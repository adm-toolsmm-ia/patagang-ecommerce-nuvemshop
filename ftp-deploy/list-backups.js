#!/usr/bin/env node
/**
 * Lista Backups Incrementais - Organiza e exibe backups mais recentes
 * Mostra informações detalhadas para facilitar identificação do último backup
 */

const fs = require('fs');
const path = require('path');

const BACKUP_DIR = path.join(__dirname, '..', 'backups', 'incremental');
const BACKUP_FULL_DIR = path.join(__dirname, '..', 'backups', 'ftp-full');

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
    const colorMap = {
        info: colors.cyan,
        success: colors.green,
        warning: colors.yellow,
        error: colors.red,
        highlight: colors.magenta,
    };
    console.log(`${colorMap[type] || colors.cyan}${message}${colors.reset}`);
}

// Listar backups incrementais
function listIncrementalBackups() {
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

// Listar backups completos
function listFullBackups() {
    if (!fs.existsSync(BACKUP_FULL_DIR)) {
        return [];
    }

    return fs.readdirSync(BACKUP_FULL_DIR)
        .filter(name => {
            const fullPath = path.join(BACKUP_FULL_DIR, name);
            return fs.statSync(fullPath).isDirectory();
        })
        .sort()
        .reverse();
}

// Carregar metadados do backup incremental
function loadIncrementalMetadata(backupDir) {
    const metadataPath = path.join(backupDir, '_BACKUP_METADATA.json');
    if (fs.existsSync(metadataPath)) {
        try {
            return JSON.parse(fs.readFileSync(metadataPath, 'utf8'));
        } catch (error) {
            return null;
        }
    }
    return null;
}

// Contar arquivos em um diretório recursivamente
function countFiles(dirPath, excludePatterns = ['_BACKUP_METADATA.json', 'README.md']) {
    let count = 0;

    function walkDir(currentPath) {
        try {
            const items = fs.readdirSync(currentPath);
            for (const item of items) {
                if (excludePatterns.includes(item)) continue;

                const fullPath = path.join(currentPath, item);
                const stat = fs.statSync(fullPath);

                if (stat.isDirectory()) {
                    walkDir(fullPath);
                } else {
                    count++;
                }
            }
        } catch (error) {
            // Ignorar erros de leitura
        }
    }

    walkDir(dirPath);
    return count;
}

// Calcular tamanho do diretório
function getDirSize(dirPath) {
    let size = 0;

    function walkDir(currentPath) {
        try {
            const items = fs.readdirSync(currentPath);
            for (const item of items) {
                const fullPath = path.join(currentPath, item);
                const stat = fs.statSync(fullPath);

                if (stat.isDirectory()) {
                    walkDir(fullPath);
                } else {
                    size += stat.size;
                }
            }
        } catch (error) {
            // Ignorar erros
        }
    }

    walkDir(dirPath);
    return size;
}

// Formatar tamanho em bytes
function formatSize(bytes) {
    if (bytes === 0) return '0 B';
    const k = 1024;
    const sizes = ['B', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return Math.round(bytes / Math.pow(k, i) * 100) / 100 + ' ' + sizes[i];
}

// Converter timestamp para data legível
function formatTimestamp(timestamp) {
    try {
        // Converter de 2025-12-12T21-57-28 para formato ISO
        // Formato entrada: 2025-12-12T21-57-28
        // Formato ISO: 2025-12-12T21:57:28
        const isoString = timestamp.replace(/(\d{4}-\d{2}-\d{2}T\d{2})-(\d{2})-(\d{2})/, '$1:$2:$3');
        const date = new Date(isoString);

        if (isNaN(date.getTime())) {
            return timestamp;
        }

        return date.toLocaleString('pt-BR', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });
    } catch (error) {
        return timestamp;
    }
}

// Calcular tempo relativo
function getRelativeTime(timestamp) {
    try {
        // Converter de 2025-12-12T21-57-28 para formato ISO
        const isoString = timestamp.replace(/(\d{4}-\d{2}-\d{2}T\d{2})-(\d{2})-(\d{2})/, '$1:$2:$3');
        const date = new Date(isoString);

        if (isNaN(date.getTime())) {
            return '';
        }

        const now = new Date();
        const diffMs = now - date;
        const diffSec = Math.floor(diffMs / 1000);
        const diffMin = Math.floor(diffSec / 60);
        const diffHour = Math.floor(diffMin / 60);
        const diffDay = Math.floor(diffHour / 24);

        if (diffSec < 60) {
            return `há ${diffSec} segundo${diffSec !== 1 ? 's' : ''}`;
        } else if (diffMin < 60) {
            return `há ${diffMin} minuto${diffMin !== 1 ? 's' : ''}`;
        } else if (diffHour < 24) {
            return `há ${diffHour} hora${diffHour !== 1 ? 's' : ''}`;
        } else if (diffDay < 7) {
            return `há ${diffDay} dia${diffDay !== 1 ? 's' : ''}`;
        } else {
            return formatTimestamp(timestamp);
        }
    } catch (error) {
        return '';
    }
}

function main() {
    const args = process.argv.slice(2);
    const showFull = args.includes('--full');
    const showAll = args.includes('--all');
    const limit = args.includes('--limit') ? parseInt(args[args.indexOf('--limit') + 1]) : 10;

    console.log(colors.cyan + '='.repeat(70) + colors.reset);
    console.log(colors.cyan + '         LISTA DE BACKUPS - NUVEMSHOP PATAGANG' + colors.reset);
    console.log(colors.cyan + '='.repeat(70) + colors.reset);
    console.log();

    // Backups Incrementais
    const incrementalBackups = listIncrementalBackups();

    if (incrementalBackups.length === 0) {
        log('Nenhum backup incremental encontrado', 'warning');
        log(`Diretório: ${BACKUP_DIR}`, 'info');
    } else {
        log(`📦 BACKUPS INCREMENTAIS (${incrementalBackups.length} total)`, 'highlight');
        log('   Backups dos arquivos alterados antes de cada deploy', 'info');
        console.log();

        const backupsToShow = showAll ? incrementalBackups : incrementalBackups.slice(0, limit);

        backupsToShow.forEach((timestamp, index) => {
            const backupDir = path.join(BACKUP_DIR, timestamp);
            const metadata = loadIncrementalMetadata(backupDir);
            const fileCount = countFiles(backupDir);
            const dirSize = getDirSize(backupDir);
            const relativeTime = getRelativeTime(timestamp);
            const formattedDate = formatTimestamp(timestamp);

            // Indicador de mais recente
            const isLatest = index === 0;
            const indicator = isLatest ? colors.green + '🟢 MAIS RECENTE' + colors.reset : '';

            console.log(colors.yellow + `${'─'.repeat(68)}` + colors.reset);

            if (isLatest) {
                console.log(`${colors.magenta}▶ ${timestamp}${colors.reset} ${indicator}`);
            } else {
                console.log(`${colors.cyan}  ${timestamp}${colors.reset}`);
            }

            console.log(`  📅 Data: ${formattedDate} ${relativeTime ? `(${relativeTime})` : ''}`);

            if (metadata) {
                console.log(`  📊 Total de arquivos: ${metadata.total}`);
                console.log(`  ✅ Backup bem-sucedido: ${metadata.backedUp}`);
                if (metadata.failed > 0) {
                    console.log(`  ${colors.yellow}⚠️  Falhas: ${metadata.failed}${colors.reset}`);
                }

                // Listar alguns arquivos alterados
                if (metadata.files && metadata.files.length > 0) {
                    const sampleFiles = metadata.files.slice(0, 5);
                    console.log(`  📁 Arquivos alterados (primeiros ${sampleFiles.length}):`);
                    sampleFiles.forEach(file => {
                        const status = file.status === 'backed_up' ? '✅' :
                                      file.status === 'new_file' ? '🆕' :
                                      file.status === 'failed' ? '❌' : '❓';
                        console.log(`     ${status} ${file.remote}`);
                    });
                    if (metadata.files.length > 5) {
                        console.log(`     ... e mais ${metadata.files.length - 5} arquivo(s)`);
                    }
                }
            } else {
                console.log(`  📊 Arquivos no backup: ${fileCount}`);
            }

            console.log(`  💾 Tamanho: ${formatSize(dirSize)}`);
            console.log(`  📍 Local: ${backupDir}`);

            // Instrução de rollback
            if (isLatest) {
                console.log();
                console.log(colors.green + `  💡 Para fazer rollback deste backup (mais recente):` + colors.reset);
                console.log(colors.cyan + `     node rollback-incremental.js` + colors.reset);
                console.log(colors.cyan + `     ou` + colors.reset);
                console.log(colors.cyan + `     node rollback-incremental.js ${timestamp}` + colors.reset);
            }

            console.log();
        });

        if (!showAll && incrementalBackups.length > limit) {
            console.log(colors.yellow + `  ... e mais ${incrementalBackups.length - limit} backup(s) incremental(is)` + colors.reset);
            console.log(colors.cyan + `  Use --all para ver todos os backups` + colors.reset);
            console.log();
        }
    }

    // Backups Completos
    if (showFull) {
        const fullBackups = listFullBackups();

        if (fullBackups.length === 0) {
            log('Nenhum backup completo encontrado', 'warning');
            log(`Diretório: ${BACKUP_FULL_DIR}`, 'info');
        } else {
            console.log();
            log(`📦 BACKUPS COMPLETOS FTP (${fullBackups.length} total)`, 'highlight');
            log('   Backups completos de todos os arquivos do servidor FTP', 'info');
            console.log();

            const fullBackupsToShow = showAll ? fullBackups : fullBackups.slice(0, limit);

            fullBackupsToShow.forEach((timestamp, index) => {
                const backupDir = path.join(BACKUP_FULL_DIR, timestamp);
                const fileCount = countFiles(backupDir);
                const dirSize = getDirSize(backupDir);
                const relativeTime = getRelativeTime(timestamp);
                const formattedDate = formatTimestamp(timestamp);

                const isLatest = index === 0;

                console.log(colors.yellow + `${'─'.repeat(68)}` + colors.reset);

                if (isLatest) {
                    console.log(`${colors.magenta}▶ ${timestamp}${colors.reset} ${colors.green}🟢 MAIS RECENTE${colors.reset}`);
                } else {
                    console.log(`${colors.cyan}  ${timestamp}${colors.reset}`);
                }

                console.log(`  📅 Data: ${formattedDate} ${relativeTime ? `(${relativeTime})` : ''}`);
                console.log(`  📊 Total de arquivos: ${fileCount}`);
                console.log(`  💾 Tamanho: ${formatSize(dirSize)}`);
                console.log(`  📍 Local: ${backupDir}`);
                console.log();
            });

            if (!showAll && fullBackups.length > limit) {
                console.log(colors.yellow + `  ... e mais ${fullBackups.length - limit} backup(s) completo(s)` + colors.reset);
                console.log();
            }
        }
    }

    console.log(colors.cyan + '='.repeat(70) + colors.reset);
    console.log();

    // Instruções rápidas
    if (incrementalBackups.length > 0) {
        const latest = incrementalBackups[0];
        log('📌 RESUMO RÁPIDO:', 'highlight');
        console.log();
        log(`   Último backup incremental: ${latest}`, 'info');
        log(`   Para rollback do último backup:`, 'info');
        console.log(colors.cyan + `     node rollback-incremental.js` + colors.reset);
        console.log();
        log(`   Para rollback de backup específico:`, 'info');
        console.log(colors.cyan + `     node rollback-incremental.js ${latest}` + colors.reset);
        console.log();
    }

    log('💡 DICAS:', 'highlight');
    console.log(colors.cyan + '   --full      Mostrar também backups completos' + colors.reset);
    console.log(colors.cyan + '   --all       Mostrar todos os backups (sem limite)' + colors.reset);
    console.log(colors.cyan + '   --limit N   Limitar a N backups (padrão: 10)' + colors.reset);
    console.log();
}

if (require.main === module) {
    main();
}

