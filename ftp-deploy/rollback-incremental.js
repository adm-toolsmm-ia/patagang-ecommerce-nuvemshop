#!/usr/bin/env node
/**
 * Rollback Incremental - Restaura arquivos do último backup incremental
 * Restaura a versão anterior dos arquivos que foram alterados no deploy
 */

const fs = require('fs');
const path = require('path');
const { DIRS, FTP_CONFIG } = require('./config.js');
const ftp = require('basic-ftp');

const BACKUP_DIR = path.join(__dirname, '..', 'backups', 'incremental');

const colors = {
    reset: '\x1b[0m',
    green: '\x1b[32m',
    yellow: '\x1b[33m',
    red: '\x1b[31m',
    cyan: '\x1b[36m',
    blue: '\x1b[34m',
};

function log(message, type = 'info') {
    const timestamp = new Date().toLocaleTimeString('pt-BR');
    const icons = { info: 'ℹ', success: '✓', warning: '⚠', error: '✗', progress: '▶' };
    const colorMap = {
        info: colors.cyan,
        success: colors.green,
        warning: colors.yellow,
        error: colors.red,
        progress: colors.blue
    };
    console.log(`${colorMap[type]}${timestamp} | ${icons[type]} ${message}${colors.reset}`);
}

// Listar todos os backups incrementais disponíveis
function listBackups() {
    if (!fs.existsSync(BACKUP_DIR)) {
        return [];
    }

    return fs.readdirSync(BACKUP_DIR)
        .filter(name => {
            const fullPath = path.join(BACKUP_DIR, name);
            return fs.statSync(fullPath).isDirectory();
        })
        .sort()
        .reverse(); // Mais recente primeiro
}

// Carregar metadados do backup
function loadBackupMetadata(backupDir) {
    const metadataPath = path.join(backupDir, '_BACKUP_METADATA.json');
    if (fs.existsSync(metadataPath)) {
        return JSON.parse(fs.readFileSync(metadataPath, 'utf8'));
    }
    return null;
}

// Coletar todos os arquivos do backup recursivamente
function getAllBackupFiles(dirPath, baseDir = dirPath, fileList = []) {
    const files = fs.readdirSync(dirPath);

    for (const file of files) {
        // Ignorar arquivos de metadados
        if (file === '_BACKUP_METADATA.json' || file === 'README.md') {
            continue;
        }

        const fullPath = path.join(dirPath, file);
        const stat = fs.statSync(fullPath);

        if (stat.isDirectory()) {
            getAllBackupFiles(fullPath, baseDir, fileList);
        } else {
            const relativePath = path.relative(baseDir, fullPath).replace(/\\/g, '/');
            fileList.push({
                local: fullPath,
                remote: relativePath,
                size: stat.size
            });
        }
    }

    return fileList;
}

// Upload com retry
async function uploadFileWithRetry(client, localPath, remotePath, retries = 3) {
    for (let attempt = 1; attempt <= retries; attempt++) {
        try {
            const remoteDir = path.dirname(remotePath).replace(/\\/g, '/');
            if (remoteDir !== '.' && remoteDir !== '/') {
                // Garantir que diretório existe
                const parts = remoteDir.split('/');
                let currentPath = '';
                for (const part of parts) {
                    if (!part) continue;
                    currentPath += '/' + part;
                    try {
                        await client.send(`MKD ${currentPath}`);
                    } catch (error) {
                        // Diretório já existe, ok
                    }
                }
            }

            await client.uploadFrom(localPath, remotePath);
            return { success: true, file: remotePath };
        } catch (error) {
            if (attempt === retries) {
                return { success: false, file: remotePath, error: error.message };
            }
            await new Promise(resolve => setTimeout(resolve, 2000));
        }
    }
}

async function main() {
    const args = process.argv.slice(2);
    const timestamp = args[0];

    console.log(colors.cyan + '='.repeat(70) + colors.reset);
    console.log(colors.cyan + '         ROLLBACK INCREMENTAL - NUVEMSHOP PATAGANG' + colors.reset);
    console.log(colors.cyan + '='.repeat(70) + colors.reset);
    console.log();

    // Listar backups disponíveis
    const backups = listBackups();

    if (backups.length === 0) {
        log('Nenhum backup incremental encontrado', 'error');
        log('Diretório de backups: ' + BACKUP_DIR, 'info');
        process.exit(1);
    }

    // Determinar qual backup usar
    let backupTimestamp;
    if (timestamp) {
        // Backup específico solicitado
        if (!backups.includes(timestamp)) {
            log(`Backup ${timestamp} não encontrado`, 'error');
            console.log();
            log('Backups disponíveis:', 'info');
            backups.slice(0, 10).forEach(b => {
                console.log(`  ${colors.cyan}▶${colors.reset} ${b}`);
            });
            if (backups.length > 10) {
                console.log(`  ... e mais ${backups.length - 10} backups`);
            }
            process.exit(1);
        }
        backupTimestamp = timestamp;
    } else {
        // Usar o backup mais recente
        backupTimestamp = backups[0];
        log(`Nenhum timestamp especificado. Usando backup mais recente: ${backupTimestamp}`, 'info');
    }

    const backupDir = path.join(BACKUP_DIR, backupTimestamp);

    // Carregar metadados
    const metadata = loadBackupMetadata(backupDir);
    if (metadata) {
        log(`Backup encontrado: ${metadata.timestamp}`, 'success');
        log(`Total de arquivos: ${metadata.total}`, 'info');
        log(`Backup bem-sucedido: ${metadata.backedUp}`, 'info');
        if (metadata.failed > 0) {
            log(`Falhas no backup original: ${metadata.failed}`, 'warning');
        }
    } else {
        log(`Backup encontrado: ${backupTimestamp}`, 'success');
        log('Metadados não encontrados. Continuando mesmo assim...', 'warning');
    }

    console.log();

    // Coletar arquivos do backup
    log('Coletando arquivos do backup...', 'info');
    const backupFiles = getAllBackupFiles(backupDir);

    if (backupFiles.length === 0) {
        log('Nenhum arquivo encontrado no backup', 'error');
        process.exit(1);
    }

    log(`Encontrados ${backupFiles.length} arquivos no backup`, 'success');
    console.log();

    // Confirmar rollback
    console.log(colors.yellow + '⚠️  ATENÇÃO: Este rollback irá RESTAURAR os arquivos para a versão anterior!' + colors.reset);
    console.log(colors.yellow + '   Os arquivos atuais no FTP serão substituídos pelos arquivos do backup.' + colors.reset);
    console.log();

    // Conectar ao FTP
    const client = new ftp.Client(120000);
    client.ftp.verbose = false;

    try {
        log(`Conectando ao FTP ${FTP_CONFIG.host}...`, 'info');
        await client.access({
            host: FTP_CONFIG.host,
            port: FTP_CONFIG.port,
            user: FTP_CONFIG.user,
            password: FTP_CONFIG.password,
            secure: true,
            secureOptions: {
                rejectUnauthorized: false
            },
            timeout: 120000
        });
        log('Conectado com sucesso', 'success');
        console.log();

        // Fazer upload dos arquivos do backup
        log('Restaurando arquivos do backup...', 'info');
        let restored = 0;
        let failed = [];

        for (let i = 0; i < backupFiles.length; i++) {
            const file = backupFiles[i];
            const result = await uploadFileWithRetry(client, file.local, file.remote);

            if (result.success) {
                restored++;
                const percent = ((restored / backupFiles.length) * 100).toFixed(1);
                process.stdout.write(`\r${colors.green}[Restaurando] ${percent}% (${restored}/${backupFiles.length}) - ${file.remote}${colors.reset}`);
            } else {
                failed.push(result);
                console.log(`\n${colors.red}✗ FALHA: ${file.remote}${colors.reset}`);
                console.log(`  Erro: ${result.error}`);
            }
        }

        console.log(); // Nova linha

        // Resultado
        console.log();
        console.log(colors.cyan + '='.repeat(70) + colors.reset);

        if (failed.length === 0) {
            log(`Rollback concluído: ${restored}/${backupFiles.length} arquivos restaurados`, 'success');
            console.log();
            console.log(colors.green + 'Próximos passos:' + colors.reset);
            console.log('  1. Limpe o cache da Nuvemshop: https://www.nuvemshop.com.br/admin/v2/themes');
            console.log('  2. Acesse: https://patagang.lojavirtualnuvem.com.br/');
            console.log('  3. Valide se a loja está funcionando corretamente');
            console.log();
        } else {
            log(`Rollback parcial: ${restored}/${backupFiles.length} arquivos restaurados`, 'warning');
            log(`Falhas: ${failed.length} arquivos`, 'error');
            console.log();
            console.log(colors.red + 'Arquivos que falharam:' + colors.reset);
            failed.forEach(f => console.log(`  ${colors.red}✗${colors.reset} ${f.file}`));
            console.log();
            process.exit(1);
        }

        console.log(colors.cyan + '='.repeat(70) + colors.reset);

    } catch (error) {
        log(`Erro na conexão: ${error.message}`, 'error');
        console.error(error);
        process.exit(1);
    } finally {
        client.close();
    }
}

if (require.main === module) {
    main().catch(console.error);
}

