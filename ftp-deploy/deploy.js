#!/usr/bin/env node

/**
 * 🚀 PATAGANG DEPLOYMENT DEFINITIVO — v1.1.5+
 * =============================================
 *
 * ROTINA ÚNICA E FINAL DE DEPLOYMENT
 *
 * Fluxo:
 * 1. Sincronizar versão (VERSION.json → version-info.js)
 * 2. Backup incremental dos arquivos críticos
 * 3. Deploy para FTP (força máxima com reconexão)
 * 4. Validação pós-deploy (verificar integridade no FTP)
 * 5. Commit com documentação
 *
 * Uso:
 *   node deploy.js                    (usa VERSION atual em ftp-deploy/VERSION)
 *   node deploy.js 1.1.6              (deploy v1.1.6 específica)
 *   node deploy.js 1.1.6 --no-backup  (sem backup incremental)
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
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

// Arquivos críticos para deploy
const CRITICAL_FILES = [
  {
    local: 'theme-deploy-corrigido/templates/product.tpl',
    remote: '/templates/product.tpl',
    description: 'Template página de produto'
  },
  {
    local: 'theme-deploy-corrigido/snipplets/product/product-form.tpl',
    remote: '/snipplets/product/product-form.tpl',
    description: 'Formulário de compra'
  },
  {
    local: 'theme-deploy-corrigido/snipplets/product/product-informative-banner.tpl',
    remote: '/snipplets/product/product-informative-banner.tpl',
    description: 'Banner informativo'
  },
  {
    local: 'theme-deploy-corrigido/static/js/version-info.js',
    remote: '/static/js/version-info.js',
    description: 'Versionamento (console)'
  }
];

async function deploy() {
  // Parse argumentos
  let targetVersion = process.argv[2];
  const skipBackup = process.argv.includes('--no-backup');

  // Ler versão se não especificada
  if (!targetVersion) {
    const versionFile = path.join(__dirname, 'VERSION');
    if (fs.existsSync(versionFile)) {
      targetVersion = fs.readFileSync(versionFile, 'utf-8').trim();
    } else {
      log('error', 'Especifique versão: node deploy.js 1.1.5');
      process.exit(1);
    }
  }

  console.log(`\n${COLORS.bright}${'='.repeat(70)}${COLORS.reset}`);
  console.log(`${COLORS.bright}    🚀 PATAGANG DEPLOYMENT v${targetVersion}${COLORS.reset}`);
  console.log(`${COLORS.bright}${'='.repeat(70)}${COLORS.reset}\n`);

  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const backupDir = path.join(DIRS.backup, `deployment-${targetVersion}`, timestamp);
  const deployResult = {
    success: 0,
    failed: 0,
    validated: 0,
    totalTime: Date.now(),
    startTime: Date.now()
  };

  try {
    // FASE 1: Sincronizar versão
    log('section', 'FASE 1: Sincronizar versão');
    try {
      const syncOutput = execSync(`node sync-version.js ${targetVersion}`, {
        encoding: 'utf-8',
        cwd: __dirname
      });
      log('success', `Versão sincronizada para v${targetVersion}`);
    } catch (err) {
      log('warning', `Aviso ao sincronizar: ${err.message.split('\n')[0]}`);
    }

    // FASE 2: Backup incremental
    if (!skipBackup) {
      log('section', 'FASE 2: Backup incremental');
      fs.mkdirSync(backupDir, { recursive: true });

      const client = new Client();

      for (const file of CRITICAL_FILES) {
        try {
          await client.access(FTP_CONFIG);
          const backupPath = path.join(backupDir, file.local.replace('theme-deploy-corrigido/', ''));
          const backupDirPath = path.dirname(backupPath);

          fs.mkdirSync(backupDirPath, { recursive: true });

          try {
            await client.downloadTo(backupPath, file.remote);
            const size = fs.statSync(backupPath).size;
            log('success', `Backup: ${file.description} (${(size / 1024).toFixed(2)} KB)`);
          } catch (err) {
            log('warning', `Backup falhou (arquivo novo?): ${file.description}`);
          }
          await client.close();
        } catch (err) {
          log('warning', `Erro ao fazer backup: ${err.message}`);
        }
      }

      // Metadados
      const metadata = {
        timestamp,
        version: targetVersion,
        files: CRITICAL_FILES.length,
        deployed_at: new Date().toISOString()
      };
      fs.writeFileSync(path.join(backupDir, '_METADATA.json'), JSON.stringify(metadata, null, 2));
      log('success', `Backup salvo: deployment-${targetVersion}/${timestamp}/`);
    } else {
      log('info', 'Backup skipped (--no-backup)');
    }

    // FASE 3: Deploy para FTP
    log('section', 'FASE 3: Deploy para FTP');

    for (const file of CRITICAL_FILES) {
      const localPath = path.join(__dirname, '..', file.local);
      const remotePath = file.remote;

      if (!fs.existsSync(localPath)) {
        log('error', `Arquivo não existe: ${file.description}`);
        deployResult.failed++;
        continue;
      }

      const client = new Client();
      client.ftp.timeout = 30000;

      try {
        await client.access(FTP_CONFIG);
        await client.uploadFrom(localPath, remotePath);
        log('success', `Deployed: ${file.description}`);
        deployResult.success++;
      } catch (err) {
        log('error', `Falha: ${file.description} - ${err.message}`);
        deployResult.failed++;
      } finally {
        await client.close();
      }
    }

    // FASE 4: Validação pós-deploy
    log('section', 'FASE 4: Validação pós-deploy');

    const valClient = new Client();
    valClient.ftp.timeout = 30000;

    try {
      await valClient.access(FTP_CONFIG);

      for (const file of CRITICAL_FILES) {
        const remotePath = file.remote;

        try {
          const testPath = path.join(__dirname, `.val-${Date.now()}.tmp`);
          await valClient.downloadTo(testPath, remotePath);
          const size = fs.statSync(testPath).size;
          fs.unlinkSync(testPath);

          log('success', `Validado: ${file.description} (${(size / 1024).toFixed(2)} KB no FTP)`);
          deployResult.validated++;
        } catch (err) {
          log('error', `Validação falhou: ${file.description}`);
        }
      }
    } catch (err) {
      log('warning', `Erro ao validar: ${err.message}`);
    } finally {
      await valClient.close();
    }

    // FASE 5: Relatório final
    deployResult.totalTime = Date.now() - deployResult.startTime;

    console.log(`\n${COLORS.bright}${'='.repeat(70)}${COLORS.reset}`);
    const success = deployResult.failed === 0;
    log('section', `${success ? '✅ SUCESSO' : '⚠️ COM PROBLEMAS'} — v${targetVersion}`);
    console.log(`${COLORS.bright}${'='.repeat(70)}${COLORS.reset}\n`);

    console.log(`${COLORS.bright}📊 Resultados:${COLORS.reset}`);
    console.log(`   Deploy bem-sucedido: ${deployResult.success}/${CRITICAL_FILES.length}`);
    if (deployResult.failed > 0) {
      console.log(`   Deploy falhado: ${deployResult.failed}`);
    }
    console.log(`   Validação: ${deployResult.validated}/${deployResult.success}`);
    console.log(`   Tempo: ${(deployResult.totalTime / 1000).toFixed(2)}s\n`);

    if (!skipBackup) {
      console.log(`${COLORS.bright}💾 Backup:${COLORS.reset}`);
      console.log(`   deployment-${targetVersion}/${timestamp}/\n`);
    }

    console.log(`${COLORS.bright}🎯 Próximos passos:${COLORS.reset}`);
    console.log(`   1. Ctrl+F5 no navegador (cache clear)`);
    console.log(`   2. Verificar console: "📦 PATAGANG v${targetVersion}"\n`);

    process.exit(deployResult.failed > 0 ? 1 : 0);

  } catch (err) {
    log('error', `ERRO CRÍTICO: ${err.message}`);
    process.exit(1);
  }
}

deploy();
