#!/usr/bin/env node
/**
 * Verifica se o projeto local está igual ao backup full do FTP.
 * Usa backups/ftp-full/[TIMESTAMP] (último ou o informado).
 *
 * Uso: node verify-sync.js [TIMESTAMP]
 *      Sem argumento: usa o backup full mais recente.
 */

const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const { DIRS } = require('./config.js');

const FTP_FULL_BASE = path.join(DIRS.backup, 'ftp-full');
const LOCAL_DIR = DIRS.theme;

function getLatestBackupDir() {
    if (!fs.existsSync(FTP_FULL_BASE)) {
        return null;
    }
    const entries = fs.readdirSync(FTP_FULL_BASE)
        .filter(name => {
            const full = path.join(FTP_FULL_BASE, name);
            return fs.statSync(full).isDirectory();
        })
        .sort()
        .reverse();
    return entries.length > 0 ? path.join(FTP_FULL_BASE, entries[0]) : null;
}

function getBackupDir() {
    const timestamp = process.argv[2];
    if (timestamp) {
        const dir = path.join(FTP_FULL_BASE, timestamp);
        if (fs.existsSync(dir) && fs.statSync(dir).isDirectory()) {
            return dir;
        }
        console.error(`Backup não encontrado: ${dir}`);
        process.exit(1);
    }
    const latest = getLatestBackupDir();
    if (!latest) {
        console.error('Nenhum backup full encontrado em backups/ftp-full/. Execute: node backup-full-ftp.js');
        process.exit(1);
    }
    return latest;
}

const BACKUP_DIR = getBackupDir();

const colors = {
    reset: '\x1b[0m',
    green: '\x1b[32m',
    yellow: '\x1b[33m',
    red: '\x1b[31m',
    cyan: '\x1b[36m',
};

function log(message, type = 'info') {
    const colorMap = { info: colors.cyan, success: colors.green, warning: colors.yellow, error: colors.red };
    console.log(`${colorMap[type]}${message}${colors.reset}`);
}

const IGNORE_FILES = ['_BACKUP_METADATA.json', 'README.md'];

function getFileHash(filePath) {
    try {
        return crypto.createHash('md5').update(fs.readFileSync(filePath)).digest('hex');
    } catch {
        return null;
    }
}

function getAllFiles(dirPath) {
    const files = {};
    function walkDir(currentPath, relPath = '') {
        try {
            for (const item of fs.readdirSync(currentPath)) {
                if (IGNORE_FILES.includes(item)) continue;
                const fullPath = path.join(currentPath, item);
                const rel = relPath ? `${relPath}/${item}` : item;
                if (fs.statSync(fullPath).isDirectory()) {
                    walkDir(fullPath, rel);
                } else {
                    files[rel.replace(/\\/g, '/')] = { path: fullPath, hash: getFileHash(fullPath) };
                }
            }
        } catch { }
    }
    walkDir(dirPath);
    return files;
}

console.log(colors.cyan + '='.repeat(70) + colors.reset);
console.log(colors.cyan + '      VERIFICAÇÃO: BACKUP FTP vs PROJETO LOCAL' + colors.reset);
console.log(colors.cyan + '='.repeat(70) + colors.reset);
console.log();

log('Coletando arquivos do backup...', 'info');
const backupFiles = getAllFiles(BACKUP_DIR);
log(`Backup: ${Object.keys(backupFiles).length} arquivos`, 'info');

log('Coletando arquivos do projeto local...', 'info');
const localFiles = getAllFiles(LOCAL_DIR);
log(`Local: ${Object.keys(localFiles).length} arquivos`, 'info');
console.log();

const onlyInBackup = [];
const onlyInLocal = [];
const different = [];
const same = [];

for (const file of Object.keys(backupFiles)) {
    if (!localFiles[file]) {
        onlyInBackup.push(file);
    } else if (backupFiles[file].hash !== localFiles[file].hash) {
        different.push(file);
    } else {
        same.push(file);
    }
}

for (const file of Object.keys(localFiles)) {
    if (!backupFiles[file]) {
        onlyInLocal.push(file);
    }
}

console.log(colors.cyan + '='.repeat(70) + colors.reset);
log(`Arquivos idênticos: ${same.length}`, 'success');
log(`Arquivos diferentes: ${different.length}`, different.length > 0 ? 'warning' : 'success');
log(`Apenas no backup: ${onlyInBackup.length}`, onlyInBackup.length > 0 ? 'warning' : 'success');
log(`Apenas no local: ${onlyInLocal.length}`, onlyInLocal.length > 0 ? 'warning' : 'success');
console.log();

if (onlyInBackup.length > 0) {
    log('Arquivos que faltam no local:', 'warning');
    onlyInBackup.slice(0, 10).forEach(f => console.log(`  - ${f}`));
    if (onlyInBackup.length > 10) console.log(`  ... e mais ${onlyInBackup.length - 10}`);
    console.log();
}

if (onlyInLocal.length > 0) {
    log('Arquivos extras no local:', 'warning');
    onlyInLocal.slice(0, 10).forEach(f => console.log(`  + ${f}`));
    if (onlyInLocal.length > 10) console.log(`  ... e mais ${onlyInLocal.length - 10}`);
    console.log();
}

if (different.length > 0) {
    log('Arquivos com conteúdo diferente:', 'warning');
    different.slice(0, 10).forEach(f => console.log(`  ≠ ${f}`));
    if (different.length > 10) console.log(`  ... e mais ${different.length - 10}`);
    console.log();
}

console.log(colors.cyan + '='.repeat(70) + colors.reset);
const totalDiff = onlyInBackup.length + onlyInLocal.length + different.length;
if (totalDiff === 0) {
    log('✅ PERFEITO! Projeto local está idêntico ao backup do FTP!', 'success');
} else {
    log(`⚠️  ATENÇÃO: ${totalDiff} diferenças encontradas`, 'warning');
}
console.log(colors.cyan + '='.repeat(70) + colors.reset);

