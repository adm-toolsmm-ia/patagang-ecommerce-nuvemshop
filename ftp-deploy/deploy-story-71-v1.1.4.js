#!/usr/bin/env node

/**
 * Deploy Story 7.1 com Versionamento v1.1.4
 * ==========================================
 * Deployar 2 arquivos específicos da Story 7.1:
 * 1. theme-deploy-corrigido/templates/product.tpl
 * 2. theme-deploy-corrigido/snipplets/product/product-form.tpl
 * 3. theme-deploy-corrigido/static/js/version-info.js (automático)
 * 
 * Versão sincronizada para: v1.1.4
 */

const fs = require('fs');
const path = require('path');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG, DIRS } = require('./config');

const COLORS = {
  reset: '\x1b[0m',
  bright: '\x1b[1m',
  cyan: '\x1b[36m',
  green: '\x1b[32m',
  red: '\x1b[31m',
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

// Story 7.1 - 2 arquivos modificados
const FILES_TO_DEPLOY = [
  'theme-deploy-corrigido/templates/product.tpl',
  'theme-deploy-corrigido/snipplets/product/product-form.tpl',
  'theme-deploy-corrigido/static/js/version-info.js' // versionamento
];

async function deployStory71() {
  console.log(`\n${COLORS.cyan}${'='.repeat(66)}${COLORS.reset}`);
  console.log(`${COLORS.cyan}    DEPLOY STORY 7.1 — v1.1.4 PATAGANG${COLORS.reset}`);
  console.log(`${COLORS.cyan}${'='.repeat(66)}${COLORS.reset}\n`);

  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const backupDir = path.join(DIRS.backup, 'incremental', timestamp);

  const client = new Client();

  try {
    // Verificar que os arquivos existem localmente
    log('info', 'Verificando arquivos da Story 7.1...');
    for (const file of FILES_TO_DEPLOY) {
      const localPath = path.join(__dirname, '..', file);
      if (!fs.existsSync(localPath)) {
        log('error', `Arquivo não encontrado: ${file}`);
        process.exit(1);
      }
    }
    log('success', `${FILES_TO_DEPLOY.length} arquivos encontrados`);

    // Conectar ao FTP
    log('info', `Conectando ao FTP ${FTP_CONFIG.host}...`);
    await client.access(FTP_CONFIG);
    log('success', `Conectado como ${FTP_CONFIG.user}`);

    // Backup incremental
    log('section', 'Fase 1: Backup Incremental');
    fs.mkdirSync(backupDir, { recursive: true });
    
    for (const file of FILES_TO_DEPLOY) {
      const remotePath = `/theme/${file.replace('theme-deploy-corrigido/', '')}`;
      const localPath = path.join(backupDir, file.replace('theme-deploy-corrigido/', ''));
      const localDir = path.dirname(localPath);

      fs.mkdirSync(localDir, { recursive: true });

      try {
        await client.downloadTo(localPath, remotePath);
        console.log(`  ✓ Backup: ${file.replace('theme-deploy-corrigido/', '')}`);
      } catch (err) {
        console.log(`  ⚠ Falha no backup: ${file} (arquivo pode não existir no FTP)`);
      }
    }

    // Gerar metadados
    const metadata = {
      timestamp,
      version: '1.1.4',
      story: '7.1',
      files: FILES_TO_DEPLOY.map(f => ({
        path: f.replace('theme-deploy-corrigido/', ''),
        size: fs.statSync(path.join(__dirname, '..', f)).size
      })),
      totalFiles: FILES_TO_DEPLOY.length,
      gitCommit: 'Story 7.1 - Corrigir página de produto',
      deployed_at: new Date().toISOString()
    };

    fs.writeFileSync(path.join(backupDir, '_METADATA.json'), JSON.stringify(metadata, null, 2));
    log('success', `Backup criado em: backups/incremental/${timestamp}/`);

    // Deploy para FTP
    log('section', 'Fase 2: Deploy para FTP');
    let successCount = 0;
    let failedCount = 0;

    for (const file of FILES_TO_DEPLOY) {
      const localPath = path.join(__dirname, '..', file);
      const remotePath = `/theme/${file.replace('theme-deploy-corrigido/', '')}`;

      try {
        await client.uploadFrom(localPath, remotePath);
        console.log(`  ✓ Deployed: ${file.replace('theme-deploy-corrigido/', '')}`);
        successCount++;
      } catch (err) {
        console.log(`  ✗ Erro: ${file} - ${err.message}`);
        failedCount++;
      }
    }

    log('success', `Deploy concluído: ${successCount}/${FILES_TO_DEPLOY.length} sucesso`);
    if (failedCount > 0) {
      log('error', `${failedCount} arquivo(s) falharam`);
    }

    // Resultado final
    console.log(`\n${COLORS.bright}${'='.repeat(66)}${COLORS.reset}`);
    log('success', `✨ DEPLOY v1.1.4 CONCLUÍDO COM SUCESSO!`);
    console.log(`${COLORS.bright}${'='.repeat(66)}${COLORS.reset}\n`);
    console.log(`📦 Versão: v1.1.4`);
    console.log(`📄 Arquivos: ${successCount}/${FILES_TO_DEPLOY.length}`);
    console.log(`💾 Backup: backups/incremental/${timestamp}/\n`);

    process.exit(failedCount > 0 ? 1 : 0);
  } catch (err) {
    log('error', `ERRO CRÍTICO: ${err.message}`);
    process.exit(1);
  } finally {
    await client.close();
  }
}

deployStory71();
