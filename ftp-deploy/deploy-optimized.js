#!/usr/bin/env node
/**
 * Deploy Otimizado - Nuvemshop Patagang
 * Upload em lotes com retry automático, progress tracking e cache MD5
 * Envia apenas arquivos modificados desde o último deploy
 */

const ftp = require('basic-ftp');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const { FTP_CONFIG, DIRS } = require('./config.js');

// Configurações otimizadas
const TIMEOUT_MS = 120000;  // 2 minutos
const MAX_RETRIES = 3;
const BATCH_SIZE = 10;  // Reduzido para 10 para manter conexão estável
const RECONNECT_EVERY = 50;  // Reconectar a cada 50 arquivos
const CACHE_FILE = path.join(__dirname, '.deploy-cache.json');
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

// Calcular MD5 hash de um arquivo
function getFileHash(filePath) {
    const content = fs.readFileSync(filePath);
    return crypto.createHash('md5').update(content).digest('hex');
}

// Carregar cache
function loadCache() {
    try {
        if (fs.existsSync(CACHE_FILE)) {
            return JSON.parse(fs.readFileSync(CACHE_FILE, 'utf8'));
        }
    } catch (error) {
        log(`Erro ao ler cache: ${error.message}`, 'warning');
    }
    return { files: {}, lastDeploy: null };
}

// Salvar cache
function saveCache(cache) {
    try {
        fs.writeFileSync(CACHE_FILE, JSON.stringify(cache, null, 2));
        log('Cache atualizado com sucesso', 'success');
    } catch (error) {
        log(`Erro ao salvar cache: ${error.message}`, 'warning');
    }
}

// Filtrar apenas arquivos modificados
function filterModifiedFiles(files, forceAll = false) {
    if (forceAll) {
        log('Modo --force-all: enviando todos os arquivos', 'warning');
        return files;
    }

    const cache = loadCache();
    const modified = [];
    const unchanged = [];

    log('Verificando arquivos modificados...', 'info');

    files.forEach(file => {
        const hash = getFileHash(file.local);
        const cachedHash = cache.files[file.remote];

        if (!cachedHash || cachedHash !== hash) {
            modified.push({ ...file, hash });
        } else {
            unchanged.push(file.remote);
        }
    });

    if (modified.length === 0) {
        log('Nenhum arquivo modificado detectado', 'success');
        return [];
    }

    log(`Modificados: ${modified.length} | Inalterados: ${unchanged.length}`, 'info');

    return modified;
}

// Coletar todos os arquivos recursivamente
function getAllFiles(dirPath, arrayOfFiles = [], baseDir = dirPath) {
    const files = fs.readdirSync(dirPath);

    files.forEach(file => {
        const fullPath = path.join(dirPath, file);
        if (fs.statSync(fullPath).isDirectory()) {
            arrayOfFiles = getAllFiles(fullPath, arrayOfFiles, baseDir);
        } else {
            const relativePath = path.relative(baseDir, fullPath);
            arrayOfFiles.push({
                local: fullPath,
                remote: relativePath.replace(/\\/g, '/'),
                size: fs.statSync(fullPath).size
            });
        }
    });

    return arrayOfFiles;
}

// Garantir que diretório existe no servidor
async function ensureRemoteDir(client, remotePath) {
    const parts = remotePath.split('/');
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

// Substituir placeholder de versão no arquivo antes do upload
// Retorna o conteúdo original para restaurar depois
function injectVersionInFile(filePath, versionId) {
    try {
        if (!fs.existsSync(filePath)) {
            return null;
        }

        let content = fs.readFileSync(filePath, 'utf8');
        const originalContent = content;
        const hasPlaceholder = content.includes('PLACEHOLDER_VERSION_ID');

        if (hasPlaceholder) {
            content = content.replace(/PLACEHOLDER_VERSION_ID/g, versionId);
            fs.writeFileSync(filePath, content, 'utf8');
            return originalContent; // Retorna conteúdo original para restaurar
        }

        return null; // Não tinha placeholder, nada a fazer
    } catch (error) {
        log(`Erro ao injetar versão em ${filePath}: ${error.message}`, 'warning');
        return null;
    }
}

// Upload com retry
async function uploadFileWithRetry(client, localPath, remotePath, retries = MAX_RETRIES, versionId = null) {
    let originalContent = null;

    for (let attempt = 1; attempt <= retries; attempt++) {
        try {
            // Injetar versão se for layout.tpl e versionId fornecido (apenas na primeira tentativa)
            if (versionId && remotePath === 'layouts/layout.tpl' && attempt === 1) {
                originalContent = injectVersionInFile(localPath, versionId);
            }

            // Garantir que o diretório remoto existe
            const remoteDir = path.dirname(remotePath).replace(/\\/g, '/');
            if (remoteDir !== '.' && remoteDir !== '/') {
                await ensureRemoteDir(client, remoteDir);
            }

            // Upload do arquivo
            await client.uploadFrom(localPath, remotePath);

            // Restaurar arquivo original após upload bem-sucedido
            if (originalContent) {
                fs.writeFileSync(localPath, originalContent, 'utf8');
            }

            return { success: true, file: remotePath, attempts: attempt };

        } catch (error) {
            // Restaurar arquivo original em caso de erro (exceto na última tentativa)
            if (originalContent && attempt < retries) {
                try {
                    fs.writeFileSync(localPath, originalContent, 'utf8');
                } catch (restoreError) {
                    // Ignora erro de restauração
                }
            }

            if (attempt === retries) {
                // Última tentativa falhou, restaurar antes de retornar
                if (originalContent) {
                    try {
                        fs.writeFileSync(localPath, originalContent, 'utf8');
                    } catch (restoreError) {
                        // Ignora erro de restauração
                    }
                }
                return { success: false, file: remotePath, error: error.message };
            }
            log(`Tentativa ${attempt}/${retries} falhou para ${remotePath}: ${error.message}`, 'warning');
            await new Promise(resolve => setTimeout(resolve, 2000)); // Aguardar 2s antes de retry
        }
    }
}

// Reconectar ao FTP
async function reconnectFTP(client) {
    try {
        log('Reconectando ao FTP...', 'info');
        client.close();
        await new Promise(resolve => setTimeout(resolve, 2000)); // Aguardar 2s

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

        log('Reconectado com sucesso', 'success');
        return true;
    } catch (error) {
        log(`Erro na reconexão: ${error.message}`, 'error');
        return false;
    }
}

// Upload em lotes
async function uploadInBatches(client, files, updateCache = true, versionId = null) {
    const totalFiles = files.length;
    const totalSize = files.reduce((sum, f) => sum + f.size, 0);
    let uploaded = 0;
    let uploadedSize = 0;
    let failed = [];
    const uploadedHashes = {};

    log(`Total: ${totalFiles} arquivos (${(totalSize / 1024 / 1024).toFixed(2)} MB)`, 'info');

    for (let i = 0; i < files.length; i += BATCH_SIZE) {
        // Reconectar periodicamente para evitar timeouts
        if (i > 0 && i % RECONNECT_EVERY === 0) {
            const reconnected = await reconnectFTP(client);
            if (!reconnected) {
                log('Falha na reconexão, continuando com conexão atual', 'warning');
            }
        }

        const batch = files.slice(i, i + BATCH_SIZE);
        const batchNum = Math.floor(i / BATCH_SIZE) + 1;
        const totalBatches = Math.ceil(totalFiles / BATCH_SIZE);

        log(`Lote ${batchNum}/${totalBatches} (${batch.length} arquivos)`, 'progress');

        for (const file of batch) {
            const result = await uploadFileWithRetry(client, file.local, file.remote, MAX_RETRIES, versionId);

            if (result.success) {
                uploaded++;
                uploadedSize += file.size;

                // Armazenar hash do arquivo enviado com sucesso
                if (file.hash) {
                    uploadedHashes[file.remote] = file.hash;
                }

                const percent = ((uploaded / totalFiles) * 100).toFixed(1);

                // Progress bar
                const barLength = 30;
                const filled = Math.round((uploaded / totalFiles) * barLength);
                const bar = '█'.repeat(filled) + '░'.repeat(barLength - filled);

                process.stdout.write(`\r${colors.green}[${bar}] ${percent}% (${uploaded}/${totalFiles})${colors.reset}`);

                if (result.attempts > 1) {
                    console.log(`  ${colors.yellow}(${result.attempts} tentativas)${colors.reset}`);
                }
            } else {
                failed.push(result);
                console.log(`\n${colors.red}✗ FALHA: ${file.remote}${colors.reset}`);
                console.log(`  Erro: ${result.error}`);
            }
        }

        console.log(); // Nova linha após progress bar

        // Pequena pausa entre lotes
        if (i + BATCH_SIZE < files.length) {
            await new Promise(resolve => setTimeout(resolve, 1000));
        }
    }

    // Atualizar cache apenas se TODOS os uploads foram bem-sucedidos
    if (updateCache && uploaded > 0 && failed.length === 0) {
        const cache = loadCache();
        cache.files = { ...cache.files, ...uploadedHashes };
        cache.lastDeploy = new Date().toISOString();
        saveCache(cache);
        log('Cache atualizado com sucesso', 'success');
    } else if (updateCache && failed.length > 0) {
        log(`Cache NÃO atualizado: ${failed.length} arquivo(s) falharam`, 'warning');
        log('Arquivos que falharam serão reenviados no próximo deploy', 'info');
    }

    return { uploaded, failed, total: totalFiles };
}

// Backup incremental dos arquivos REMOTOS (versão anterior) antes do deploy
async function createIncrementalBackup(client, filesToUpload) {
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, 19);
    const backupDir = path.join(BACKUP_DIR, timestamp);

    if (!fs.existsSync(backupDir)) {
        fs.mkdirSync(backupDir, { recursive: true });
    }

    log(`Criando backup incremental dos arquivos REMOTOS: ${timestamp}`, 'info');
    log(`Backup será feito ANTES do upload para permitir rollback`, 'info');

    let backedUp = 0;
    let failed = [];
    const metadata = {
        timestamp,
        files: [],
        total: filesToUpload.length,
        backedUp: 0,
        failed: 0
    };

    for (const file of filesToUpload) {
        try {
            const destPath = path.join(backupDir, file.remote);
            const destDir = path.dirname(destPath);

            if (!fs.existsSync(destDir)) {
                fs.mkdirSync(destDir, { recursive: true });
            }

            // Tentar fazer download do arquivo remoto
            try {
                // Verificar se arquivo existe no servidor antes de baixar
                await client.downloadTo(destPath, file.remote);
                backedUp++;
                metadata.files.push({
                    remote: file.remote,
                    status: 'backed_up',
                    timestamp: new Date().toISOString()
                });
            } catch (downloadError) {
                // Arquivo não existe no servidor (novo arquivo)
                // Não é erro, apenas marca como novo
                metadata.files.push({
                    remote: file.remote,
                    status: 'new_file',
                    note: 'Arquivo não existe no servidor (será criado)'
                });
                backedUp++; // Conta como sucesso pois é um arquivo novo
            }
        } catch (error) {
            log(`Erro no backup de ${file.remote}: ${error.message}`, 'warning');
            failed.push({ file: file.remote, error: error.message });
            metadata.files.push({
                remote: file.remote,
                status: 'failed',
                error: error.message
            });
        }
    }

    metadata.backedUp = backedUp;
    metadata.failed = failed.length;

    // Salvar metadados do backup
    const metadataPath = path.join(backupDir, '_BACKUP_METADATA.json');
    fs.writeFileSync(metadataPath, JSON.stringify(metadata, null, 2));

    // Criar README de rollback
    const readmeContent = `# Backup Incremental - ${timestamp}

Este backup contém os arquivos REMOTOS (versão anterior) que foram alterados no deploy.

## Informações

- **Timestamp:** ${timestamp}
- **Total de arquivos:** ${filesToUpload.length}
- **Backup bem-sucedido:** ${backedUp}
- **Falhas:** ${failed.length}

## Arquivos incluídos neste backup

${metadata.files.map(f => `- ${f.remote} (${f.status})`).join('\n')}

## Como fazer rollback

### Opção 1: Script automatizado (recomendado)

\`\`\`bash
cd ftp-deploy
node rollback-incremental.js ${timestamp}
\`\`\`

### Opção 2: Manual

1. Copiar arquivos do backup para o tema local:
   \`\`\`powershell
   Copy-Item -Recurse -Force backups/incremental/${timestamp}/* theme-deploy-corrigido/
   \`\`\`

2. Fazer deploy do rollback (SEM criar novo backup):
   \`\`\`bash
   cd ftp-deploy
   node deploy-optimized.js --force-all --no-backup
   \`\`\`

## ⚠️ Importante

- Este backup contém a VERSÃO ANTERIOR dos arquivos (do servidor FTP)
- Use para restaurar o estado antes das alterações
- Sempre valide após rollback
`;

    const readmePath = path.join(backupDir, 'README.md');
    fs.writeFileSync(readmePath, readmeContent);

    if (failed.length > 0) {
        log(`Backup concluído: ${backedUp}/${filesToUpload.length} arquivos (${failed.length} falhas)`, 'warning');
        log(`Alguns arquivos falharam no backup. Revise antes de continuar.`, 'warning');
        return { success: false, backupDir, metadata, failed };
    }

    log(`Backup de ${backedUp} arquivos REMOTOS em: backups/incremental/${timestamp}/`, 'success');
    return { success: true, backupDir, metadata, failed: [] };
}

// Listar arquivos remotos recursivamente
async function listRemoteFiles(client, remotePath = '', fileList = []) {
    try {
        const list = await client.list(remotePath || '/');
        for (const item of list) {
            const fullPath = remotePath ? `${remotePath}/${item.name}` : item.name;

            // Ignorar pasta _arquivados
            if (item.name === '_arquivados') continue;

            if (item.isDirectory) {
                await listRemoteFiles(client, fullPath, fileList);
            } else {
                fileList.push(fullPath);
            }
        }
    } catch (error) {
        // Pasta não existe ou erro de acesso
    }
    return fileList;
}

// Deletar arquivos obsoletos do FTP
async function cleanupObsoleteFiles(client, localFiles) {
    log('Listando arquivos no servidor FTP...', 'info');
    const remoteFiles = await listRemoteFiles(client);
    log(`Encontrados ${remoteFiles.length} arquivos no FTP`, 'info');

    // Criar set de arquivos locais para busca rápida
    const localFilesSet = new Set(localFiles.map(f => f.remote));

    // Encontrar arquivos que existem no FTP mas não localmente
    const obsoleteFiles = remoteFiles.filter(rf => !localFilesSet.has(rf));

    if (obsoleteFiles.length === 0) {
        log('Nenhum arquivo obsoleto encontrado no FTP', 'success');
        return { deleted: 0, files: [] };
    }

    log(`Encontrados ${obsoleteFiles.length} arquivos obsoletos para DELETAR`, 'warning');
    console.log(colors.red + '\n⚠ ATENÇÃO: Os arquivos serão permanentemente removidos do FTP!' + colors.reset);

    let deleted = 0;
    const deletedFiles = [];
    const failedFiles = [];

    for (const file of obsoleteFiles) {
        try {
            // Deletar arquivo
            await client.remove(file);
            deleted++;
            deletedFiles.push(file);

            const percent = ((deleted / obsoleteFiles.length) * 100).toFixed(1);
            process.stdout.write(`\r${colors.red}[Deletando] ${percent}% (${deleted}/${obsoleteFiles.length}) - ${file}${colors.reset.padEnd(50)}`);

        } catch (error) {
            failedFiles.push({ file, error: error.message });
        }
    }

    console.log(); // Nova linha
    return { deleted, files: deletedFiles, failed: failedFiles };
}

// Main
async function main() {
    const args = process.argv.slice(2);
    const forceAll = args.includes('--force-all');
    const showCache = args.includes('--show-cache');
    const dryRun = args.includes('--dry-run');
    const noBackup = args.includes('--no-backup');
    const cleanup = args.includes('--cleanup');

    console.log(colors.cyan + '='.repeat(70) + colors.reset);
    console.log(colors.cyan + '         DEPLOY OTIMIZADO - NUVEMSHOP PATAGANG' + colors.reset);
    console.log(colors.cyan + '='.repeat(70) + colors.reset);

    // Mostrar cache e versão atual
    if (showCache) {
        const cache = loadCache();
        console.log('\n' + colors.cyan + '═'.repeat(70) + colors.reset);
        console.log(colors.cyan + '         INFORMAÇÕES DE DEPLOY' + colors.reset);
        console.log(colors.cyan + '═'.repeat(70) + colors.reset);
        console.log();

        if (cache.lastDeployVersion) {
            console.log(colors.green + '📦 Versão Atual do Deploy:' + colors.reset);
            console.log(`   🏷️  Versão ID: ${colors.green}${cache.lastDeployVersion}${colors.reset}`);
            if (cache.lastDeployTimestamp) {
                const deployDate = new Date(cache.lastDeployTimestamp).toLocaleString('pt-BR', {
                    timeZone: 'America/Sao_Paulo',
                    dateStyle: 'short',
                    timeStyle: 'medium'
                });
                console.log(`   📅 Data/Hora: ${deployDate} (Brasília)`);
            }
            if (cache.lastDeployFiles && cache.lastDeployFiles.length > 0) {
                console.log(`   📝 Últimos arquivos atualizados: ${cache.lastDeployFiles.length}`);
                console.log(`   ${colors.cyan}Arquivos:${colors.reset}`);
                cache.lastDeployFiles.slice(0, 5).forEach(file => {
                    console.log(`     ${colors.green}✓${colors.reset} ${file}`);
                });
                if (cache.lastDeployFiles.length > 5) {
                    console.log(`     ${colors.yellow}... e mais ${cache.lastDeployFiles.length - 5} arquivos${colors.reset}`);
                }
            }
            console.log();
            console.log(colors.yellow + '⚠ Esta é a versão que deve estar VISÍVEL na loja agora!' + colors.reset);
            console.log(colors.yellow + `⚠ Valide apenas quando confirmar que a versão ${cache.lastDeployVersion} está ativa${colors.reset}`);
        } else {
            console.log(colors.yellow + '⚠ Nenhuma versão de deploy registrada ainda' + colors.reset);
        }

        console.log();
        console.log(colors.cyan + 'Cache de Deploy:' + colors.reset);
        console.log(`Último deploy (legado): ${cache.lastDeploy || 'Nunca'}`);
        console.log(`Arquivos no cache: ${Object.keys(cache.files).length}`);
        if (Object.keys(cache.files).length > 0) {
            console.log('\nPrimeiros 10 arquivos:');
            Object.keys(cache.files).slice(0, 10).forEach(file => {
                console.log(`  ${colors.green}✓${colors.reset} ${file}`);
            });
        }
        console.log();
        console.log(colors.cyan + '═'.repeat(70) + colors.reset);
        process.exit(0);
    }

    if (!fs.existsSync(DIRS.theme)) {
        log(`Diretório theme não encontrado: ${DIRS.theme}`, 'error');
        process.exit(1);
    }

    // Coletar arquivos
    log('Coletando arquivos...', 'info');
    const allFiles = getAllFiles(DIRS.theme);
    log(`Encontrados ${allFiles.length} arquivos no total`, 'success');

    // Filtrar arquivos modificados
    const files = filterModifiedFiles(allFiles, forceAll);

    // Se for cleanup, não precisa de arquivos modificados
    if (files.length === 0 && !cleanup) {
        console.log(colors.green + '\n✓ Nada para fazer! Todos os arquivos já estão atualizados.' + colors.reset);
        console.log(colors.cyan + '\nDica: Use --force-all para enviar todos os arquivos' + colors.reset);
        console.log(colors.cyan + 'Dica: Use --cleanup para arquivar arquivos obsoletos no FTP' + colors.reset);
        process.exit(0);
    }

    if (files.length > 0) {
        log(`Serao enviados ${files.length} arquivos`, forceAll ? 'warning' : 'info');
    }

    // Modo dry-run (nao envia, so mostra)
    if (dryRun && !cleanup) {
        console.log('\n' + colors.yellow + 'MODO DRY-RUN - Arquivos que seriam enviados:' + colors.reset);
        files.slice(0, 20).forEach(f => console.log(`  ${colors.cyan}▶${colors.reset} ${f.remote}`));
        if (files.length > 20) {
            console.log(`  ... e mais ${files.length - 20} arquivos`);
        }
        console.log();
        process.exit(0);
    }

    // Conectar com timeout aumentado
    const client = new ftp.Client(TIMEOUT_MS);
    client.ftp.verbose = false; // Desabilitar logs verbose do FTP

    let backupResult = null;

    try {
        log(`Conectando ao FTP ${FTP_CONFIG.host} (timeout: ${TIMEOUT_MS / 1000}s)...`, 'info');

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
        console.log();

        // Backup incremental dos arquivos REMOTOS antes do deploy
        if (!noBackup && files.length > 0 && !cleanup) {
            log('Fazendo backup dos arquivos REMOTOS (versão anterior)...', 'info');
            backupResult = await createIncrementalBackup(client, files);

            if (!backupResult.success) {
                log('Backup teve falhas. Continuando mesmo assim...', 'warning');
                log('Recomendado: Revise os erros antes de fazer deploy', 'warning');
            } else {
                log('Backup incremental concluído com sucesso', 'success');
                log(`Arquivos salvos em: ${backupResult.backupDir}`, 'info');
            }
            console.log();
        } else if (noBackup) {
            log('Backup pulado (--no-backup)', 'warning');
        }

        // Modo cleanup - deletar arquivos obsoletos
        if (cleanup) {
            log('Iniciando limpeza de arquivos obsoletos...', 'info');
            const cleanupResult = await cleanupObsoleteFiles(client, allFiles);

            console.log();
            console.log(colors.cyan + '='.repeat(70) + colors.reset);

            if (cleanupResult.deleted > 0) {
                log(`Deletados ${cleanupResult.deleted} arquivos obsoletos do FTP`, 'success');
                console.log('\n' + colors.red + 'Arquivos removidos:' + colors.reset);
                cleanupResult.files.slice(0, 30).forEach(f =>
                    console.log(`  ${colors.red}✗${colors.reset} ${f}`)
                );
                if (cleanupResult.files.length > 30) {
                    console.log(`  ... e mais ${cleanupResult.files.length - 30} arquivos`);
                }
            } else {
                log('Nenhum arquivo obsoleto para deletar', 'success');
            }

            if (cleanupResult.failed && cleanupResult.failed.length > 0) {
                console.log('\n' + colors.yellow + 'Arquivos que falharam:' + colors.reset);
                cleanupResult.failed.slice(0, 10).forEach(f =>
                    console.log(`  ${colors.yellow}⚠${colors.reset} ${f.file}`)
                );
            }

            console.log(colors.cyan + '='.repeat(70) + colors.reset);
            client.close();
            process.exit(0);
        }

        // Gerar versão ANTES do upload para injetar no layout.tpl
        const deployTimestamp = new Date().toISOString();
        const deployId = deployTimestamp.replace(/[:.]/g, '-').slice(0, 19);
        const filesHash = crypto.createHash('md5')
            .update(files.map(f => `${f.remote}:${f.hash || ''}`).join('|'))
            .digest('hex')
            .substring(0, 8)
            .toUpperCase();
        const versionId = `${deployId}-${filesHash}`;

        // CRÍTICO: Garantir que layout.tpl sempre seja enviado e contém o placeholder de versão
        // Isso garante cache-bust e validação correta a cada deploy
        const layoutTplPath = 'layouts/layout.tpl';
        const layoutTplLocal = path.join(DIRS.theme, layoutTplPath);
        if (fs.existsSync(layoutTplLocal)) {
            const layoutContent = fs.readFileSync(layoutTplLocal, 'utf8');
            if (!layoutContent.includes('PLACEHOLDER_VERSION_ID')) {
                log('ERRO CRÍTICO: layout.tpl sem PLACEHOLDER_VERSION_ID.', 'error');
                log('Isso impede a atualização automática de versão e cache-bust.', 'error');
                log(`Arquivo: ${layoutTplLocal}`, 'error');
                log('Restaure o placeholder e rode o deploy novamente.', 'error');
                client.close();
                process.exit(1);
            }
        } else {
            log(`Aviso: layout.tpl não encontrado em ${layoutTplLocal}`, 'warning');
        }

        // Mesmo que não tenha sido modificado, precisa ser enviado para atualizar a versão
        const layoutTplInList = files.find(f => f.remote === layoutTplPath);

        if (!layoutTplInList && files.length > 0) {
            // layout.tpl não está na lista, mas há outros arquivos para enviar
            // Adicionar layout.tpl à lista para garantir atualização da versão
            if (fs.existsSync(layoutTplLocal)) {
                const layoutTplFile = {
                    local: layoutTplLocal,
                    remote: layoutTplPath,
                    size: fs.statSync(layoutTplLocal).size,
                    hash: getFileHash(layoutTplLocal) // Calcular hash para atualizar cache depois
                };
                files.push(layoutTplFile);
                log(`Adicionando layout.tpl à lista para atualizar versão no console`, 'info');
            } else {
                log(`Aviso: layout.tpl não encontrado em ${layoutTplLocal}`, 'warning');
            }
        }

        // Upload em lotes (com versão para injetar no layout.tpl)
        const startTime = Date.now();
        const result = await uploadInBatches(client, files, true, versionId);
        const duration = ((Date.now() - startTime) / 1000).toFixed(1);

        // Resultado
        console.log();
        console.log(colors.cyan + '='.repeat(70) + colors.reset);
        log(`Deploy concluído em ${duration}s (${(duration / 60).toFixed(1)} min)`, 'info');
        log(`Sucesso: ${result.uploaded}/${result.total} arquivos`, 'success');

        if (result.failed.length > 0) {
            log(`Falhas: ${result.failed.length}`, 'error');
            console.log('\n' + colors.red + 'Arquivos com falha:' + colors.reset);
            result.failed.forEach(f => console.log(`  ${colors.red}✗${colors.reset} ${f.file}`));
            console.log();

            // Não atualizar cache se houver falhas parciais
            log('Alguns arquivos falharam. Cache NÃO foi atualizado.', 'warning');
            log('Os arquivos que falharam serão reenviados no próximo deploy.', 'info');

            if (backupResult && backupResult.success) {
                console.log();
                log('Backup disponível para rollback:', 'info');
                log(`  ${backupResult.backupDir}`, 'info');
                console.log(colors.yellow + '  Para fazer rollback: node rollback-incremental.js [TIMESTAMP]' + colors.reset);
            }

            process.exit(1);
        } else {
            log('Todos os arquivos enviados com sucesso!', 'success');
            console.log();

            // Usar versão já gerada antes do upload
            const deployDate = new Date().toLocaleString('pt-BR', {
                timeZone: 'America/Sao_Paulo',
                dateStyle: 'short',
                timeStyle: 'medium'
            });

            // Salvar informação da versão no cache (versão já gerada antes do upload)
            const cache = loadCache();
            cache.lastDeployVersion = versionId;
            cache.lastDeployFiles = files.map(f => f.remote);
            cache.lastDeployTimestamp = deployTimestamp;
            saveCache(cache);

            // Mostrar resumo das alterações de forma destacada
            console.log(colors.yellow + '═'.repeat(70) + colors.reset);
            console.log(colors.yellow + '  📝 VERSÃO ATUAL DO DEPLOY - VALIDE ANTES DE TESTAR' + colors.reset);
            console.log(colors.yellow + '═'.repeat(70) + colors.reset);

            console.log(colors.cyan + `  🏷️  Versão ID: ${colors.reset}${colors.green}${versionId}${colors.reset}`);
            console.log(colors.cyan + `  📅 Data/Hora: ${colors.reset}${deployDate} (Brasília)`);
            console.log(colors.cyan + `  📦 Arquivos atualizados: ${colors.reset}${colors.green}${files.length}${colors.reset}`);
            console.log();

            console.log(colors.green + '  ✓ Arquivos modificados neste deploy:' + colors.reset);
            files.forEach((file, index) => {
                const fileNum = String(index + 1).padStart(2, '0');
                console.log(`     ${colors.cyan}${fileNum}.${colors.reset} ${file.remote}`);
            });

            console.log();
            console.log(colors.yellow + '  ⚠ IMPORTANTE:' + colors.reset);
            console.log(colors.yellow + '     • Esta é a versão que deve estar VISÍVEL na loja agora' + colors.reset);
            console.log(colors.yellow + `     • Use o Versão ID "${versionId}" para confirmar que está validando a versão correta` + colors.reset);
            console.log(colors.yellow + '     • Se o cache não atualizou, aguarde alguns minutos e limpe o cache da Nuvemshop' + colors.reset);
            console.log(colors.yellow + '═'.repeat(70) + colors.reset);
            console.log();

            if (backupResult && backupResult.success) {
                log('Backup incremental disponível para rollback:', 'info');
                const timestamp = path.basename(backupResult.backupDir);
                console.log(colors.cyan + `  Timestamp: ${timestamp}` + colors.reset);
                console.log(colors.cyan + `  Local: ${backupResult.backupDir}` + colors.reset);
                console.log();
                console.log(colors.yellow + '  Para fazer rollback, execute:' + colors.reset);
                console.log(colors.yellow + `    node rollback-incremental.js ${timestamp}` + colors.reset);
                console.log();
            }

            console.log(colors.green + 'Próximos passos:' + colors.reset);
            console.log('  1. Limpe o cache da Nuvemshop: https://www.nuvemshop.com.br/admin/v2/themes');
            console.log('  2. Acesse: https://patagang.lojavirtualnuvem.com.br/');
            console.log(`  3. ${colors.green}Valide apenas quando a versão ${versionId} estiver visível${colors.reset}`);
            console.log('  4. Se necessário, aguarde alguns minutos para o cache atualizar');
            console.log();
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
