#!/usr/bin/env node

/**
 * Deploy Story 7.1 - Arquivos específicos
 * Baseado em padrão AIOX incremental
 */

const fs = require('fs');
const path = require('path');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG, DIRS } = require('./config');

const COLORS = {
  cyan: '\x1b[36m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  bright: '\x1b[1m',
  reset: '\x1b[0m',
};

// Arquivos específicos da story 7.1
const STORY_71_FILES = [
  'templates/product.tpl',
  'snipplets/product/product-form.tpl',
];

async function main() {
  console.log(`\n${COLORS.cyan}${'='.repeat(66)}${COLORS.reset}`);
  console.log(`${COLORS.cyan}  DEPLOY STORY 7.1 - ARQUIVOS ESPECÍFICOS${COLORS.reset}`);
  console.log(`${COLORS.cyan}${'='.repeat(66)}${COLORS.reset}\n`);

  const client = new Client();

  try {
    // Conectar
    console.log(`${new Date().toLocaleTimeString('pt-BR')} | Conectando ao FTP...`);
    await client.access(FTP_CONFIG);
    console.log(`${COLORS.green}✓${COLORS.reset} Conectado como ${FTP_CONFIG.user}\n`);

    // Backup
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
    const backupDir = path.join(DIRS.backup, 'incremental', timestamp);
    fs.mkdirSync(backupDir, { recursive: true });

    console.log(`${COLORS.bright}▶${COLORS.reset} Backup dos ${STORY_71_FILES.length} arquivo(s)...\n`);
    for (const file of STORY_71_FILES) {
      try {
        const localPath = path.join(backupDir, file);
        fs.mkdirSync(path.dirname(localPath), { recursive: true });
        await client.downloadTo(localPath, `/theme/${file}`);
        console.log(`  ${COLORS.green}✓${COLORS.reset} Backup: ${file}`);
      } catch (err) {
        console.log(`  ⚠ ${file}: ${err.message}`);
      }
    }

    // Deploy
    console.log(`\n${COLORS.bright}▶${COLORS.reset} Deploy dos ${STORY_71_FILES.length} arquivo(s)...\n`);
    let successCount = 0;
    for (const file of STORY_71_FILES) {
      const localPath = path.join(DIRS.theme, file);
      if (fs.existsSync(localPath)) {
        await client.uploadFrom(localPath, `/theme/${file}`);
        console.log(`  ${COLORS.green}✓${COLORS.reset} ${file}`);
        successCount++;
      }
    }

    console.log(`\n${COLORS.bright}${'='.repeat(66)}${COLORS.reset}`);
    console.log(`${COLORS.green}✓${COLORS.reset} Deploy Story 7.1 Concluído!`);
    console.log(`  Arquivos: ${successCount}/${STORY_71_FILES.length}`);
    console.log(`  Backup: backups/incremental/${timestamp}/`);
    console.log(`${COLORS.bright}${'='.repeat(66)}${COLORS.reset}\n`);

  } catch (err) {
    console.log(`${COLORS.red}✗${COLORS.reset} ERRO: ${err.message}\n`);
    process.exit(1);
  } finally {
    await client.logout();
  }
}

main();
