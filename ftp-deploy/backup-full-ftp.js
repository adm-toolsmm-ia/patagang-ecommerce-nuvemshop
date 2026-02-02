#!/usr/bin/env node
/**
 * Backup Completo do FTP - Nuvemshop Patagang
 * Faz download de TODOS os arquivos do servidor FTP
 * e salva em backups/ftp-full/[TIMESTAMP]/
 *
 * Uso: node backup-full-ftp.js
 * ou: npm run backup:full
 */

const ftp = require('basic-ftp');
const fs = require('fs');
const path = require('path');
const { FTP_CONFIG, DIRS } = require('./config.js');

const TIMEOUT_MS = 120000; // 2 minutos
const BATCH_SIZE = 10; // Processar em lotes
const BACKUP_BASE_DIR = path.join(DIRS.backup, 'ftp-full');

const colors = {
    reset: '\x1b[0m',
    green: '\x1b[32m',
    yellow: '\x1b[33m',
    red: '\x1b[31m',
    cyan: '\x1b[36m',
    blue: '\x1b[34m',
    magenta: '\x1b[35m',
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

// Listar todos os arquivos remotos recursivamente
async function listRemoteFiles(client, remotePath = '', fileList = [], level = 0) {
    try {
        const list = await client.list(remotePath || '/');

        for (const item of list) {
            const fullPath = remotePath ? `${remotePath}/${item.name}` : item.name;

            // Ignorar pastas especiais
            if (item.name === '_arquivados' || item.name === '.' || item.name === '..') {
                continue;
            }

            if (item.isDirectory) {
                // Mostrar progresso de listagem a cada 10 pastas
                if (level === 0 || fileList.length % 10 === 0) {
                    process.stdout.write(`\r${colors.cyan}Listando... ${fileList.length} arquivos encontrados${colors.reset}`);
                }
                await listRemoteFiles(client, fullPath, fileList, level + 1);
            } else {
                fileList.push({
                    remote: fullPath.startsWith('/') ? fullPath.slice(1) : fullPath, // Remover barra inicial
                    name: item.name,
                    size: item.size,
                    date: item.rawModifiedAt || item.modifiedAt || null
                });
            }
        }
    } catch (error) {
        // Ignorar erros de pastas que não podem ser acessadas
        if (error.code !== 550) {
            log(`Erro ao listar ${remotePath}: ${error.message}`, 'warning');
        }
    }
    return fileList;
}

// Criar estrutura de diretórios local
function ensureLocalDir(filePath) {
    const dir = path.dirname(filePath);
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
    }
}

// Download de arquivo com retry e reconexão
async function downloadFileWithRetry(client, remotePath, localPath, connectFn, retries = 5) {
    for (let attempt = 1; attempt <= retries; attempt++) {
        try {
            // Verificar se o cliente está fechado antes de tentar
            if (client.closed) {
                // log(`Conexão fechada, tentando reconectar (tentativa ${attempt})...`, 'warning');
                await connectFn();
            }

            ensureLocalDir(localPath);
            await client.downloadTo(localPath, remotePath);
            return { success: true, file: remotePath, attempts: attempt };
        } catch (error) {
            const isConnectionError = error.code === 'ECONNRESET' || error.message.includes('closed') || error.message.includes('socket');

            if (isConnectionError && attempt < retries) {
                // Se for erro de conexão, tenta reconectar explicitamente
                try {
                    client.close(); // Garante que está fechado
                    await connectFn();
                    continue; // Tenta novamente com nova conexão
                } catch (connError) {
                    // Se falhar na reconexão, espera um pouco mais
                    await new Promise(resolve => setTimeout(resolve, 5000));
                }
            }

            if (attempt === retries) {
                return { success: false, file: remotePath, error: error.message };
            }
            // Não logar tentativas intermediárias para não poluir o output, exceto se for erro grave
            await new Promise(resolve => setTimeout(resolve, 2000 * attempt));
        }
    }
}

// Download em lotes
async function downloadInBatches(client, files, backupDir, connectFn) {
    const totalFiles = files.length;
    let downloaded = 0;
    let downloadedSize = 0;
    let failed = [];
    const startTime = Date.now();

    log(`Total: ${totalFiles} arquivos para fazer backup`, 'info');

    // Calcular tamanho total estimado
    const totalSize = files.reduce((sum, f) => sum + (f.size || 0), 0);
    log(`Tamanho total estimado: ${(totalSize / 1024 / 1024).toFixed(2)} MB`, 'info');
    console.log();

    for (let i = 0; i < files.length; i += BATCH_SIZE) {
        const batch = files.slice(i, i + BATCH_SIZE);
        const batchNum = Math.floor(i / BATCH_SIZE) + 1;
        const totalBatches = Math.ceil(totalFiles / BATCH_SIZE);

        log(`Lote ${batchNum}/${totalBatches} (${batch.length} arquivos)`, 'progress');

        for (const file of batch) {
            const localPath = path.join(backupDir, file.remote);

            const result = await downloadFileWithRetry(client, file.remote, localPath, connectFn);

            if (result.success) {
                downloaded++;
                downloadedSize += file.size || 0;

                const percent = ((downloaded / totalFiles) * 100).toFixed(1);
                const barLength = 30;
                const filled = Math.round((downloaded / totalFiles) * barLength);
                const bar = '█'.repeat(filled) + '░'.repeat(barLength - filled);

                const speed = downloadedSize / ((Date.now() - startTime) / 1000);
                const speedText = speed > 1024 * 1024
                    ? `${(speed / 1024 / 1024).toFixed(1)} MB/s`
                    : `${(speed / 1024).toFixed(1)} KB/s`;

                process.stdout.write(
                    `\r${colors.green}[${bar}] ${percent}% (${downloaded}/${totalFiles}) | ${speedText}${colors.reset}`
                );
            } else {
                failed.push(result);
                console.log(`\n${colors.red}✗ FALHA: ${file.remote}${colors.reset}`);
                console.log(`  Erro: ${result.error}`);
            }
        }

        console.log(); // Nova linha após progress bar

        // Pausa entre lotes para não sobrecarregar
        if (i + BATCH_SIZE < files.length) {
            await new Promise(resolve => setTimeout(resolve, 500));
        }
    }

    const duration = ((Date.now() - startTime) / 1000).toFixed(1);
    return {
        downloaded,
        failed,
        total: totalFiles,
        downloadedSize,
        duration
    };
}

// Criar arquivo de metadados do backup
function createMetadataFile(backupDir, files, startTime, endTime, stats) {
    const metadata = {
        timestamp: new Date(startTime).toISOString(),
        backupPath: path.relative(DIRS.backup, backupDir),
        totalFiles: files.length,
        downloadedFiles: stats.downloaded,
        failedFiles: stats.failed.length,
        duration: `${stats.duration}s`,
        totalSize: stats.downloadedSize,
        totalSizeMB: (stats.downloadedSize / 1024 / 1024).toFixed(2),
        ftpConfig: {
            host: FTP_CONFIG.host,
            user: FTP_CONFIG.user,
            // Não salvar senha por segurança
        },
        files: files.map(f => ({
            remote: f.remote,
            name: f.name,
            size: f.size,
            date: f.date
        })),
        failedFiles: stats.failed.map(f => ({
            file: f.file,
            error: f.error
        }))
    };

    const metadataPath = path.join(backupDir, '_BACKUP_METADATA.json');
    fs.writeFileSync(metadataPath, JSON.stringify(metadata, null, 2));
    log(`Metadados salvos em: ${path.basename(metadataPath)}`, 'success');

    return metadataPath;
}

// Criar arquivo README do backup
function createReadmeFile(backupDir, timestamp, stats) {
    const readmeContent = `# Backup Completo FTP - Patagang Nuvemshop

**Data/Hora:** ${new Date().toLocaleString('pt-BR')}
**Timestamp:** ${timestamp}

## Estatísticas

- **Total de arquivos:** ${stats.total}
- **Arquivos baixados:** ${stats.downloaded}
- **Falhas:** ${stats.failed.length}
- **Tamanho total:** ${(stats.downloadedSize / 1024 / 1024).toFixed(2)} MB
- **Duração:** ${stats.duration}s

## Estrutura

Este backup contém uma cópia completa de todos os arquivos que estavam no servidor FTP no momento do backup.

## Como Restaurar

Para restaurar este backup:

1. Copiar arquivos do backup para \`theme-deploy-corrigido/\`:
   \`\`\`powershell
   Copy-Item -Recurse -Force ${timestamp}/* ../theme-deploy-corrigido/
   \`\`\`

2. Fazer deploy:
   \`\`\`bash
   cd ../ftp-deploy
   node deploy-optimized.js --force-all
   \`\`\`

3. Limpar cache da Nuvemshop:
   - Acessar: https://www.nuvemshop.com.br/admin/v2/themes
   - Menu (três pontos) do tema ativo
   - "Limpar Cache"

## Observações

- Este é um backup manual completo do FTP
- Arquivos que falharam no download estão listados em \`_BACKUP_METADATA.json\`
- Use este backup apenas se precisar restaurar o estado anterior do tema
`;

    const readmePath = path.join(backupDir, 'README.md');
    fs.writeFileSync(readmePath, readmeContent);
}

// Main
async function main() {
    console.log(colors.cyan + '='.repeat(70) + colors.reset);
    console.log(colors.cyan + '      BACKUP COMPLETO DO FTP - NUVEMSHOP PATAGANG' + colors.reset);
    console.log(colors.cyan + '='.repeat(70) + colors.reset);
    console.log();

    // Criar diretório base de backups se não existir
    if (!fs.existsSync(BACKUP_BASE_DIR)) {
        fs.mkdirSync(BACKUP_BASE_DIR, { recursive: true });
        log(`Diretório de backup criado: backups/ftp-full/`, 'success');
    }

    // Criar diretório de backup com timestamp
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, 19);
    const backupDir = path.join(BACKUP_BASE_DIR, timestamp);

    if (!fs.existsSync(backupDir)) {
        fs.mkdirSync(backupDir, { recursive: true });
    }

    log(`Backup será salvo em: backups/ftp-full/${timestamp}/`, 'info');
    log(`Caminho completo: ${backupDir}`, 'info');
    console.log();

    const client = new ftp.Client(TIMEOUT_MS);
    client.ftp.verbose = false;

    try {
        // Função de conexão reutilizável
        const connectFn = async () => {
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
                timeout: TIMEOUT_MS
            });
            log(`Conectado como ${FTP_CONFIG.user}`, 'success');
        };

        await connectFn();
        console.log();

        // Listar todos os arquivos
        log('Listando arquivos no servidor FTP (isso pode levar alguns minutos)...', 'info');
        const listStartTime = Date.now();
        const files = await listRemoteFiles(client);
        const listDuration = ((Date.now() - listStartTime) / 1000).toFixed(1);

        console.log(); // Nova linha após progresso de listagem
        log(`Encontrados ${files.length} arquivos no FTP (${listDuration}s)`, 'success');

        if (files.length === 0) {
            log('Nenhum arquivo encontrado para backup', 'warning');
            client.close();
            process.exit(0);
        }

        console.log();

        // Fazer download de todos os arquivos
        const downloadStartTime = Date.now();
        log('Iniciando download dos arquivos...', 'info');
        const result = await downloadInBatches(client, files, backupDir, connectFn);

        // Criar metadados
        log('Gerando metadados do backup...', 'info');
        createMetadataFile(backupDir, files, downloadStartTime, Date.now(), result);
        createReadmeFile(backupDir, timestamp, result);

        // Resultado final
        console.log();
        console.log(colors.cyan + '='.repeat(70) + colors.reset);
        log(`Backup concluído em ${result.duration}s`, 'success');
        log(`Sucesso: ${result.downloaded}/${result.total} arquivos`, 'success');
        log(`Tamanho: ${(result.downloadedSize / 1024 / 1024).toFixed(2)} MB`, 'info');

        if (result.failed.length > 0) {
            log(`Falhas: ${result.failed.length} arquivos`, 'warning');
            console.log('\n' + colors.yellow + 'Arquivos que falharam:' + colors.reset);
            result.failed.slice(0, 10).forEach(f => {
                console.log(`  ${colors.yellow}⚠${colors.reset} ${f.file}`);
                console.log(`    Erro: ${f.error}`);
            });
            if (result.failed.length > 10) {
                console.log(`  ... e mais ${result.failed.length - 10} arquivos`);
            }
            console.log();
            log('Todos os arquivos com falha estão listados em _BACKUP_METADATA.json', 'info');
        } else {
            log('Todos os arquivos foram baixados com sucesso!', 'success');
        }

        console.log();
        console.log(colors.green + '📦 Backup completo salvo em:' + colors.reset);
        console.log(`  ${colors.cyan}${backupDir}${colors.reset}`);
        console.log();
        console.log(colors.magenta + '💡 Para restaurar este backup:' + colors.reset);
        console.log(`  1. Copiar arquivos: Copy-Item -Recurse -Force "${backupDir.replace(/\\/g, '/')}/*" "../theme-deploy-corrigido/"`);
        console.log(`  2. Fazer deploy: cd ftp-deploy && node deploy-optimized.js --force-all`);
        console.log();
        console.log(colors.cyan + '='.repeat(70) + colors.reset);

    } catch (error) {
        log(`Erro: ${error.message}`, 'error');
        console.error(error);
        process.exit(1);
    } finally {
        client.close();
    }
}

if (require.main === module) {
    main().catch(console.error);
}

