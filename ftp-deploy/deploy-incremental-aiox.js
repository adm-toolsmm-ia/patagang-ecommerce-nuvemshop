#!/usr/bin/env node

/**
 * Deploy Incremental AIOX - Nuvemshop Patagang
 *
 * Detecta arquivos alterados via GIT DIFF e faz deploy APENAS desses arquivos
 * ✅ Deploy incremental preciso
 * ✅ Backup apenas de arquivos alterados
 * ✅ Rastreabilidade por commit git
 * ✅ Rollback rápido
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG, DIRS } = require('./config');

const COLORS = {
  reset: '\x1b[0m',
  dim: '\x1b[2m',
  bright: '\x1b[1m',
  cyan: '\x1b[36m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
};

function log(type, message) {
  const timestamp = new Date().toLocaleTimeString('pt-BR');
  const icons = {
    info: `${COLORS.cyan}ℹ${COLORS.reset}`,
    success: `${COLORS.green}✓${COLORS.reset}`,
    error: `${COLORS.red}✗${COLORS.reset}`,
    section: `${COLORS.bright}▶${COLORS.reset}`,
  };
  console.log(`${timestamp} | ${icons[type]} ${message}`);
}

async function getModifiedFiles() {
  log('info', 'Detectando arquivos modificados via GIT...');

  try {
    // Detectar últimos commits da story (assumindo 3-4 commits)
    const cmd = `git diff HEAD~4 HEAD --name-only -- theme-deploy-corrigido/ 2>/dev/null || git diff HEAD~3 HEAD --name-only -- theme-deploy-corrigido/`;
    const output = execSync(cmd, { encoding: 'utf-8', cwd: path.join(__dirname, '..') });
    const files = output.trim().split('\n').filter(f => f);

    if (files.length === 0) {
      log('info', 'Nenhum arquivo modificado detectado');
      return [];
    }

    log('success', `Detectados ${files.length} arquivo(s) modificado(s):`);
    files.forEach(f => {
      const localPath = path.join(DIRS.theme, f.replace('theme-deploy-corrigido/', ''));
      const exists = fs.existsSync(localPath);
      console.log(`  ${exists ? '✓' : '⚠'} ${f}`);
    });

    return files.map(f => f.replace('theme-deploy-corrigido/', ''));
  } catch (err) {
    log('error', `Erro ao detectar arquivos: ${err.message}`);
    return [];
  }
}

async function createIncrementalBackup(client, modifiedFiles) {
  log('section', 'Fase 2: Backup Incremental');

  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const backupDir = path.join(DIRS.backup, 'incremental', timestamp);

  try {
    fs.mkdirSync(backupDir, { recursive: true });
    log('info', `Criando backup para ${modifiedFiles.length} arquivo(s)...`);

    const metadata = {
      timestamp,
      files: [],
      totalSize: 0,
      gitCommit: execSync('git rev-parse --short HEAD', { encoding: 'utf-8', cwd: path.join(__dirname, '..') }).trim(),
    };

    for (const file of modifiedFiles) {
      try {
        const remotePath = `/theme/${file}`;
        const localPath = path.join(backupDir, file);
        const localDir = path.dirname(localPath);

        fs.mkdirSync(localDir, { recursive: true });

        await client.downloadTo(localPath, remotePath);

        const size = fs.statSync(localPath).size;
        metadata.files.push({ path: file, size });
        metadata.totalSize += size;

        console.log(`  ✓ Backup: ${file}`);
      } catch (err) {
        console.log(`  ⚠ Falha no backup de ${file}: ${err.message}`);
      }
    }

    // Salvar metadados
    fs.writeFileSync(path.join(backupDir, '_METADATA.json'), JSON.stringify(metadata, null, 2));
    fs.writeFileSync(path.join(backupDir, 'README.md'), `
# Backup Incremental ${timestamp}

- **Arquivos:** ${modifiedFiles.length}
- **Tamanho:** ${(metadata.totalSize / 1024).toFixed(2)} KB
- **Commit:** ${metadata.gitCommit}
- **Data:** ${new Date().toLocaleString('pt-BR')}

## Restaurar

\`\`\`bash
node rollback-incremental.js ${timestamp}
\`\`\`
    `.trim());

    log('success', `Backup criado em: backups/incremental/${timestamp}/`);
    return backupDir;
  } catch (err) {
    log('error', `Erro ao criar backup: ${err.message}`);
    throw err;
  }
}

async function deployFiles(client, modifiedFiles) {
  log('section', 'Fase 3: Deploy Incremental');

  let successCount = 0;
  let failedCount = 0;
  const BATCH_SIZE = 10;

  for (let i = 0; i < modifiedFiles.length; i += BATCH_SIZE) {
    const batch = modifiedFiles.slice(i, i + BATCH_SIZE);

    for (const file of batch) {
      try {
        const localPath = path.join(DIRS.theme, file);
        const remotePath = `/theme/${file}`;

        if (!fs.existsSync(localPath)) {
          console.log(`  ⚠ ${file} - NÃO ENCONTRADO localmente, pulando`);
          failedCount++;
          continue;
        }

        await client.uploadFrom(localPath, remotePath);
        console.log(`  ✓ ${file}`);
        successCount++;
      } catch (err) {
        console.log(`  ✗ ${file} - ${err.message}`);
        failedCount++;
      }
    }

    // Reconectar a cada BATCH_SIZE
    if (i + BATCH_SIZE < modifiedFiles.length) {
      try {
        await client.ensureDir('/theme');
      } catch (err) {
        log('info', 'Reconectando ao FTP...');
        await client.logout();
        await client.access(FTP_CONFIG);
        await client.ensureDir('/theme');
      }
    }
  }

  log('success', `Deploy concluído: ${successCount}/${modifiedFiles.length} sucesso`);
  if (failedCount > 0) {
    log('error', `${failedCount} arquivo(s) falharam`);
  }

  return { successCount, failedCount };
}

async function main() {
  console.log(`\n${COLORS.cyan}${'='.repeat(66)}${COLORS.reset}`);
  console.log(`${COLORS.cyan}         DEPLOY INCREMENTAL AIOX - NUVEMSHOP${COLORS.reset}`);
  console.log(`${COLORS.cyan}${'='.repeat(66)}${COLORS.reset}\n`);

  const client = new Client();

  try {
    // Fase 1: Detectar arquivos modificados
    const modifiedFiles = await getModifiedFiles();

    if (modifiedFiles.length === 0) {
      log('info', 'Nenhum arquivo para deploy');
      process.exit(0);
    }

    // Conectar FTP
    log('info', `Conectando ao FTP ${FTP_CONFIG.host}...`);
    await client.access(FTP_CONFIG);
    log('success', `Conectado como ${FTP_CONFIG.user}`);

    // Fase 2: Backup incremental
    await createIncrementalBackup(client, modifiedFiles);

    // Fase 3: Deploy
    const result = await deployFiles(client, modifiedFiles);

    // Resultado final
    console.log(`\n${COLORS.bright}${'='.repeat(66)}${COLORS.reset}`);
    log('success', `Deploy Incremental Concluído!`);
    console.log(`${COLORS.bright}${'='.repeat(66)}${COLORS.reset}\n`);

    process.exit(result.failedCount > 0 ? 1 : 0);
  } catch (err) {
    log('error', `ERRO CRÍTICO: ${err.message}`);
    process.exit(1);
  } finally {
    await client.logout();
  }
}

main();
