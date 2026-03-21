#!/usr/bin/env node

/**
 * DEPLOY PDP FIX — v1.1.5 FORÇA MÁXIMA + VALIDAÇÃO
 * ================================================
 * Deployment crítico para corrigir página de produtos.
 *
 * Arquivos corrigidos:
 * 1. theme-deploy-corrigido/templates/product.tpl (restaurar banner)
 * 2. theme-deploy-corrigido/snipplets/product/product-form.tpl (desconto visível)
 * 3. theme-deploy-corrigido/snipplets/product/product-informative-banner.tpl (banner info)
 * 4. theme-deploy-corrigido/static/js/version-info.js (versionamento)
 *
 * Modo: FORCE-REDEPLOYMENT (reconectar a cada arquivo)
 * Validação: POST-DEPLOY (verificar que os arquivos foram realmente enviados)
 */

const fs = require('fs');
const path = require('path');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG, DIRS } = require('./config');

const COLORS = {
  reset: '\x1b[0m',
  bright: '\x1b[1m',
  dim: '\x1b[2m',
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
    warning: `${COLORS.yellow}⚠${COLORS.reset}`,
    section: `${COLORS.bright}▶${COLORS.reset}`,
  };
  console.log(`${timestamp} | ${icons[type] || '•'} ${message}`);
}

// PDP Fix v1.1.5 - 4 arquivos críticos
const FILES_TO_DEPLOY = [
  {
    local: 'theme-deploy-corrigido/templates/product.tpl',
    remote: '/templates/product.tpl',
    description: 'Template principal (restaurar banner)'
  },
  {
    local: 'theme-deploy-corrigido/snipplets/product/product-form.tpl',
    remote: '/snipplets/product/product-form.tpl',
    description: 'Formulário de compra (desconto visível)'
  },
  {
    local: 'theme-deploy-corrigido/snipplets/product/product-informative-banner.tpl',
    remote: '/snipplets/product/product-informative-banner.tpl',
    description: 'Banner informativo (4 seções info)'
  },
  {
    local: 'theme-deploy-corrigido/static/js/version-info.js',
    remote: '/static/js/version-info.js',
    description: 'Versionamento'
  }
];

async function deployPDPFix115() {
  console.log(`\n${COLORS.bright}${'='.repeat(70)}${COLORS.reset}`);
  console.log(`${COLORS.bright}    🚀 DEPLOY PDP FIX v1.1.5 — FORCE REDEPLOYMENT + VALIDAÇÃO${COLORS.reset}`);
  console.log(`${COLORS.bright}${'='.repeat(70)}${COLORS.reset}\n`);

  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const backupDir = path.join(DIRS.backup, 'pdp-fix-1.1.5', timestamp);
  const deployResult = {
    success: 0,
    failed: 0,
    validated: 0,
    invalidated: 0,
    totalTime: 0,
    startTime: Date.now()
  };

  // FASE 0: Verificação local
  log('section', 'FASE 0: Verificação de arquivos locais');
  for (const file of FILES_TO_DEPLOY) {
    const fullPath = path.join(__dirname, '..', file.local);
    if (!fs.existsSync(fullPath)) {
      log('error', `CRÍTICO: Arquivo não encontrado: ${file.local}`);
      process.exit(1);
    }
    const size = fs.statSync(fullPath).size;
    log('success', `✓ ${file.description} (${(size / 1024).toFixed(2)} KB)`);
  }

  // FASE 1: Backup Incremental
  log('section', 'FASE 1: Backup Incremental (incremental/pdp-fix-1.1.5/)');
  fs.mkdirSync(backupDir, { recursive: true });

  const client = new Client();

  try {
    for (const file of FILES_TO_DEPLOY) {
      try {
        await client.access(FTP_CONFIG);
        const remotePath = file.remote;
        const backupPath = path.join(backupDir, file.local.replace('theme-deploy-corrigido/', ''));
        const backupDirPath = path.dirname(backupPath);

        fs.mkdirSync(backupDirPath, { recursive: true });

        try {
          await client.downloadTo(backupPath, remotePath);
          const size = fs.statSync(backupPath).size;
          log('success', `Backup: ${file.description} (${(size / 1024).toFixed(2)} KB)`);
        } catch (err) {
          log('warning', `Backup falhou (arquivo pode não existir no FTP): ${file.description}`);
        }
        await client.close();
      } catch (err) {
        log('error', `Erro ao conectar FTP para backup: ${err.message}`);
      }
    }

    // Gerar metadados
    const metadata = {
      timestamp,
      version: '1.1.5',
      story: '7.1',
      type: 'PDP-CRITICAL-FIX',
      description: 'Force redeployment com validação pós-deploy',
      files: FILES_TO_DEPLOY.map(f => ({
        local: f.local,
        remote: f.remote,
        description: f.description,
        size: fs.statSync(path.join(__dirname, '..', f.local)).size
      })),
      totalFiles: FILES_TO_DEPLOY.length,
      deployMode: 'force-redeployment',
      postDeployValidation: 'enabled',
      gitCommit: 'ca3cd37 (restaurar banner) + dcbcabb (desconto visível)',
      deployed_at: new Date().toISOString()
    };

    fs.writeFileSync(path.join(backupDir, '_METADATA.json'), JSON.stringify(metadata, null, 2));
    log('success', `Backup criado em: backups/pdp-fix-1.1.5/${timestamp}/`);

    // FASE 2: Deploy para FTP (FORCE MODE - reconectar a cada arquivo)
    log('section', 'FASE 2: Deploy para FTP (Force Redeployment)');

    for (const file of FILES_TO_DEPLOY) {
      const localPath = path.join(__dirname, '..', file.local);
      const remotePath = file.remote;

      const client = new Client();
      client.ftp.timeout = 30000;

      try {
        await client.access(FTP_CONFIG);
        log('info', `Conectado ao FTP para: ${file.description}`);

        await client.uploadFrom(localPath, remotePath);
        log('success', `Deployed: ${file.description}`);
        deployResult.success++;
      } catch (err) {
        log('error', `FALHA no deploy de ${file.description}: ${err.message}`);
        deployResult.failed++;
      } finally {
        await client.close();
      }
    }

    // FASE 3: Validação Pós-Deploy (verificar que os arquivos estão lá)
    log('section', 'FASE 3: Validação Pós-Deploy (verificar integridade no FTP)');

    const validationClient = new Client();
    validationClient.ftp.timeout = 30000;

    try {
      await validationClient.access(FTP_CONFIG);
      log('success', 'Conectado ao FTP para validação');

      for (const file of FILES_TO_DEPLOY) {
        const remotePath = file.remote;

        try {
          // Tentar fazer download de um pequeno trecho do arquivo para verificar que existe
          const localPath = path.join(__dirname, `../.validation-test-${Date.now()}.tmp`);
          await validationClient.downloadTo(localPath, remotePath);

          const size = fs.statSync(localPath).size;
          fs.unlinkSync(localPath); // Remover arquivo de teste

          log('success', `Validado: ${file.description} (${(size / 1024).toFixed(2)} KB no FTP)`);
          deployResult.validated++;
        } catch (err) {
          log('error', `VALIDAÇÃO FALHOU: ${file.description} não encontrado no FTP!`);
          deployResult.invalidated++;
        }
      }
    } catch (err) {
      log('error', `Erro ao conectar para validação: ${err.message}`);
    } finally {
      await validationClient.close();
    }

    // FASE 4: Relatório Final
    deployResult.totalTime = Date.now() - deployResult.startTime;

    console.log(`\n${COLORS.bright}${'='.repeat(70)}${COLORS.reset}`);

    const allSuccess = deployResult.failed === 0 && deployResult.invalidated === 0;
    const statusIcon = allSuccess ? `${COLORS.green}✓${COLORS.reset}` : `${COLORS.red}✗${COLORS.reset}`;
    const statusText = allSuccess ? 'SUCESSO TOTAL' : 'COM PROBLEMAS';

    log('section', `${statusIcon} RELATÓRIO FINAL — v1.1.5 ${statusText}`);
    console.log(`${COLORS.bright}${'='.repeat(70)}${COLORS.reset}\n`);

    console.log(`${COLORS.bright}📦 Versionamento:${COLORS.reset}`);
    console.log(`   Versão: v1.1.5`);
    console.log(`   Modo: Force Redeployment`);
    console.log(`   Timestamp: ${timestamp}\n`);

    console.log(`${COLORS.bright}📊 Estatísticas:${COLORS.reset}`);
    console.log(`   Deploy bem-sucedido: ${deployResult.success}/${FILES_TO_DEPLOY.length} ✓`);
    if (deployResult.failed > 0) {
      console.log(`   Deploy falhado: ${deployResult.failed}/${FILES_TO_DEPLOY.length} ${COLORS.red}✗${COLORS.reset}`);
    }
    console.log(`   Validação no FTP: ${deployResult.validated}/${deployResult.success} ✓`);
    if (deployResult.invalidated > 0) {
      console.log(`   Validação falhada: ${deployResult.invalidated}/${deployResult.success} ${COLORS.red}✗${COLORS.reset}`);
    }
    console.log(`   Tempo total: ${(deployResult.totalTime / 1000).toFixed(2)}s\n`);

    console.log(`${COLORS.bright}📁 Backup:${COLORS.reset}`);
    console.log(`   Local: backups/pdp-fix-1.1.5/${timestamp}/\n`);

    console.log(`${COLORS.bright}🎯 Próximos passos:${COLORS.reset}`);
    console.log(`   1. Limpar cache do navegador (Ctrl+F5 ou limpar cache)`);
    console.log(`   2. Acessar página de produto em produção`);
    console.log(`   3. Verificar: Banner informativo no topo?`);
    console.log(`   4. Verificar: Desconto visível no card?`);
    console.log(`   5. Se sucesso: Confirmar em @aiox-master\n`);

    console.log(`${COLORS.bright}${'='.repeat(70)}${COLORS.reset}\n`);

    // Exit code
    if (allSuccess) {
      log('success', '✨ DEPLOY v1.1.5 CONCLUÍDO COM SUCESSO TOTAL!');
      process.exit(0);
    } else {
      log('error', '⚠️ DEPLOY v1.1.5 CONCLUÍDO COM PROBLEMAS - REVISAR ACIMA');
      process.exit(1);
    }

  } catch (err) {
    log('error', `ERRO CRÍTICO NO DEPLOYMENT: ${err.message}`);
    console.error(err);
    process.exit(1);
  }
}

// Executar
deployPDPFix115();
