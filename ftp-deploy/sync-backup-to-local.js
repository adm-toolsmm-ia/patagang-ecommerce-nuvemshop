#!/usr/bin/env node
/**
 * Sincroniza o projeto local com o backup do FTP
 * Deixa theme-deploy-corrigido exatamente igual ao backup
 */

const fs = require('fs');
const path = require('path');
const { DIRS } = require('./config.js');

const BACKUP_DIR = path.join(DIRS.backup, 'version-01-official');
const LOCAL_DIR = DIRS.theme;

const colors = {
    reset: '\x1b[0m',
    green: '\x1b[32m',
    yellow: '\x1b[33m',
    red: '\x1b[31m',
    cyan: '\x1b[36m',
    blue: '\x1b[34m',
};

function log(message, type = 'info') {
    const colorMap = {
        info: colors.cyan,
        success: colors.green,
        warning: colors.yellow,
        error: colors.red,
    };
    console.log(`${colorMap[type]}${message}${colors.reset}`);
}

// Ignorar arquivos de metadados do backup
const IGNORE_FILES = [
    '_BACKUP_METADATA.json',
    'README.md',
];

// Copiar arquivo
function copyFile(src, dest) {
    const destDir = path.dirname(dest);
    if (!fs.existsSync(destDir)) {
        fs.mkdirSync(destDir, { recursive: true });
    }
    fs.copyFileSync(src, dest);
}

// Remover arquivo
function removeFile(filePath) {
    try {
        if (fs.existsSync(filePath)) {
            fs.unlinkSync(filePath);
            return true;
        }
    } catch (error) {
        return false;
    }
    return false;
}

// Remover diretório vazio
function removeDir(dirPath) {
    try {
        if (fs.existsSync(dirPath)) {
            const files = fs.readdirSync(dirPath);
            if (files.length === 0) {
                fs.rmdirSync(dirPath);
                return true;
            }
        }
    } catch (error) {
        return false;
    }
    return false;
}

// Coletar todos os arquivos recursivamente
function getAllFiles(dirPath, baseDir = dirPath) {
    const files = [];

    function walkDir(currentPath, relativePath = '') {
        try {
            const items = fs.readdirSync(currentPath);

            for (const item of items) {
                if (IGNORE_FILES.includes(item)) continue;

                const fullPath = path.join(currentPath, item);
                const relPath = relativePath ? `${relativePath}/${item}` : item;
                const stat = fs.statSync(fullPath);

                if (stat.isDirectory()) {
                    walkDir(fullPath, relPath);
                } else {
                    files.push({
                        relative: relPath.replace(/\\/g, '/'),
                        fullPath: fullPath,
                        size: stat.size
                    });
                }
            }
        } catch (error) {
            // Ignorar erros de leitura
        }
    }

    walkDir(dirPath);
    return files;
}

// Coletar arquivos do local para comparação
function getAllLocalFiles(dirPath, baseDir = dirPath) {
    const files = new Set();

    function walkDir(currentPath, relativePath = '') {
        try {
            const items = fs.readdirSync(currentPath);

            for (const item of items) {
                const fullPath = path.join(currentPath, item);
                const relPath = relativePath ? `${relativePath}/${item}` : item;
                const stat = fs.statSync(fullPath);

                if (stat.isDirectory()) {
                    walkDir(fullPath, relPath);
                } else {
                    files.add(relPath.replace(/\\/g, '/'));
                }
            }
        } catch (error) {
            // Ignorar erros
        }
    }

    walkDir(dirPath);
    return files;
}

// Sincronizar
function sync() {
    console.log(colors.cyan + '='.repeat(70) + colors.reset);
    console.log(colors.cyan + '      SINCRONIZAÇÃO: BACKUP FTP → PROJETO LOCAL' + colors.reset);
    console.log(colors.cyan + '='.repeat(70) + colors.reset);
    console.log();

    if (!fs.existsSync(BACKUP_DIR)) {
        log(`Erro: Backup não encontrado em ${BACKUP_DIR}`, 'error');
        process.exit(1);
    }

    if (!fs.existsSync(LOCAL_DIR)) {
        log(`Erro: Projeto local não encontrado em ${LOCAL_DIR}`, 'error');
        process.exit(1);
    }

    log(`Backup FTP: ${BACKUP_DIR}`, 'info');
    log(`Projeto Local: ${LOCAL_DIR}`, 'info');
    console.log();

    log('⚠️  ATENÇÃO: Todos os arquivos do projeto local serão sobrescritos pelo backup!', 'warning');
    console.log();

    // Coletar arquivos
    log('Coletando arquivos do backup...', 'info');
    const backupFiles = getAllFiles(BACKUP_DIR);
    log(`Encontrados ${backupFiles.length} arquivos no backup`, 'success');

    log('Coletando arquivos do projeto local...', 'info');
    const localFilesSet = getAllLocalFiles(LOCAL_DIR);
    log(`Encontrados ${localFilesSet.size} arquivos no projeto local`, 'success');
    console.log();

    // Copiar todos os arquivos do backup
    log('Copiando arquivos do backup para o projeto local...', 'info');
    let copied = 0;
    let errors = 0;

    for (const file of backupFiles) {
        try {
            const destPath = path.join(LOCAL_DIR, file.relative);
            copyFile(file.fullPath, destPath);
            copied++;

            if (copied % 50 === 0) {
                process.stdout.write(`\r${colors.cyan}Copiados: ${copied}/${backupFiles.length} arquivos${colors.reset}`);
            }
        } catch (error) {
            errors++;
            log(`Erro ao copiar ${file.relative}: ${error.message}`, 'error');
        }
    }

    console.log();
    log(`Arquivos copiados: ${copied}/${backupFiles.length}`, copied === backupFiles.length ? 'success' : 'warning');
    if (errors > 0) {
        log(`Erros: ${errors}`, 'error');
    }
    console.log();

    // Remover arquivos que existem apenas no local
    log('Removendo arquivos que não existem no backup...', 'info');
    let removed = 0;

    for (const localFile of localFilesSet) {
        const existsInBackup = backupFiles.some(bf => bf.relative === localFile);
        if (!existsInBackup) {
            try {
                const filePath = path.join(LOCAL_DIR, localFile);
                if (removeFile(filePath)) {
                    removed++;

                    // Tentar remover diretório pai se estiver vazio
                    const parentDir = path.dirname(filePath);
                    removeDir(parentDir);
                }
            } catch (error) {
                log(`Erro ao remover ${localFile}: ${error.message}`, 'warning');
            }
        }
    }

    if (removed > 0) {
        log(`Arquivos removidos: ${removed}`, 'warning');
    } else {
        log('Nenhum arquivo para remover', 'success');
    }
    console.log();

    // Resultado final
    console.log(colors.cyan + '='.repeat(70) + colors.reset);
    log('✅ Sincronização concluída!', 'success');
    log(`Projeto local agora está igual ao backup do FTP`, 'success');
    console.log();
    log('📦 Arquivos copiados do backup:', 'info');
    log(`   ${copied} arquivos`, 'info');
    if (removed > 0) {
        log(`📁 Arquivos removidos (não existiam no backup):`, 'info');
        log(`   ${removed} arquivos`, 'info');
    }
    console.log();
    console.log(colors.cyan + '='.repeat(70) + colors.reset);
}

if (require.main === module) {
    sync();
}

