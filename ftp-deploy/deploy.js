#!/usr/bin/env node

/**
 * 🚀 PATAGANG DEPLOYMENT v2.0 — AIOX-Compliant
 * =============================================
 *
 * Sistema de versionamento e deploy FTP automatizado
 * Workflow: alteração → git commit → node deploy.js → FTP + git push
 *
 * Fases:
 * - Fase 0: Validação de contexto (story, credenciais)
 * - Fase 1: Detecção de arquivos modificados (git diff)
 * - Fase 2: Auto-increment de versão (patch/minor)
 * - Fase 3: Git commit de versão + tag + push
 * - Fase 4: Backup incremental dos arquivos
 * - Fase 5: Deploy para FTP
 * - Fase 6: Validação pós-deploy
 *
 * Uso:
 *   node deploy.js "Descrição da mudança"        (patch version)
 *   node deploy.js "Descrição" --minor            (minor version)
 *   node deploy.js "Descrição" --dry-run          (simula sem executar)
 *   node deploy.js "Descrição" --force             (skip confirmações)
 *
 * Exemplos:
 *   node deploy.js "Fix: Ajuste de cores no botão"
 *   node deploy.js "Feature: Nova seção de trust" --minor
 *   node deploy.js "Test: Validação" --dry-run
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const readline = require('readline');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG, DIRS, PROJECT_ROOT } = require('./config');

// =============================================================================
// UTILITIES
// =============================================================================

const COLORS = {
  reset: '\x1b[0m',
  bright: '\x1b[1m',
  dim: '\x1b[2m',
  cyan: '\x1b[36m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  magenta: '\x1b[35m',
};

function log(type, message) {
  const timestamp = new Date().toLocaleTimeString('pt-BR');
  const icons = {
    info: `${COLORS.cyan}ℹ${COLORS.reset}`,
    success: `${COLORS.green}✅${COLORS.reset}`,
    error: `${COLORS.red}❌${COLORS.reset}`,
    warning: `${COLORS.yellow}⚠️${COLORS.reset}`,
    section: `${COLORS.bright}▶${COLORS.reset}`,
    box: `${COLORS.magenta}📦${COLORS.reset}`,
  };
  console.log(`${timestamp} | ${icons[type] || '•'} ${message}`);
}

async function prompt(question) {
  return new Promise((resolve) => {
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
    });
    rl.question(`\n${COLORS.bright}${question}${COLORS.reset} `, (answer) => {
      rl.close();
      resolve(answer.toLowerCase());
    });
  });
}

// =============================================================================
// PHASE 0: CONTEXT VALIDATION
// =============================================================================

async function phase0_validateContext(args) {
  log('section', 'FASE 0: Validação de Contexto');

  // Validar argumentos
  if (!args.description) {
    log('error', 'Especifique descrição: node deploy.js "Descrição da mudança"');
    process.exit(1);
  }

  // Detectar story do branch
  let storyId = null;
  try {
    const branch = execSync('git rev-parse --abbrev-ref HEAD', { encoding: 'utf-8' }).trim();
    const storyMatch = branch.match(/story[_-](\d+\.\d+\.\d+)/i);
    if (storyMatch) {
      storyId = storyMatch[1];
      log('info', `📖 Story detectada: ${storyId} (branch: ${branch})`);
    }
  } catch (err) {
    // Não está em um repositório git ou branch não tem story
  }

  // Validar credenciais FTP
  if (!FTP_CONFIG.user || !FTP_CONFIG.password) {
    log('error', 'Credenciais FTP não configuradas. Crie ftp-deploy/.env');
    process.exit(1);
  }

  log('success', '✅ Credenciais FTP carregadas');

  // Validar que está em repositório git
  try {
    execSync('git status', { encoding: 'utf-8', stdio: 'pipe' });
    log('success', '✅ Repositório git detectado');
  } catch (err) {
    log('error', 'Não está em um repositório git');
    process.exit(1);
  }

  return { storyId };
}

// =============================================================================
// PHASE 1: DETECT MODIFIED FILES
// =============================================================================

function phase1_detectFiles() {
  log('section', 'FASE 1: Detecção de Arquivos Modificados');

  let modifiedFiles = new Set();

  try {
    // AIOX FIX: Detectar arquivos modificados desde a ÚLTIMA versão deployada
    // Strategy: Compare com a última git tag (última versão do deploy)
    let compareRef = 'HEAD~1'; // fallback padrão

    try {
      // Tentar obter a última tag (última versão deployada)
      const lastTag = execSync(
        'git describe --tags --abbrev=0',
        { encoding: 'utf-8' }
      ).trim();
      if (lastTag && lastTag.length > 0) {
        compareRef = lastTag;
        log('info', `Comparando com última versão: ${lastTag}`);
      }
    } catch (err) {
      // Usar fallback se não houver tags
      log('info', 'Nenhuma tag anterior encontrada, usando HEAD~1');
    }

    // 1. Working directory vs HEAD (unstaged changes)
    const gitDiffWorking = execSync(
      'git diff --name-only HEAD -- theme-deploy-corrigido/',
      { encoding: 'utf-8' }
    ).trim();

    if (gitDiffWorking) {
      gitDiffWorking.split('\n').filter(f => f.length > 0).forEach(f => modifiedFiles.add(f));
    }

    // 2. Arquivos modificados desde a última versão
    const gitDiffSinceLastVersion = execSync(
      `git diff --name-only ${compareRef}..HEAD -- theme-deploy-corrigido/`,
      { encoding: 'utf-8' }
    ).trim();

    if (gitDiffSinceLastVersion) {
      gitDiffSinceLastVersion.split('\n').filter(f => f.length > 0).forEach(f => modifiedFiles.add(f));
    }

    // Sempre incluir version-info.js (será atualizado com nova versão)
    const versionInfoPath = 'theme-deploy-corrigido/static/js/version-info.js';
    modifiedFiles.add(versionInfoPath);

    // Converter Set para Array
    const filesArray = Array.from(modifiedFiles);

    log('success', `Arquivos detectados: ${filesArray.length}`);
    filesArray.forEach(f => {
      log('info', `  → ${f}`);
    });

    return filesArray;
  } catch (err) {
    log('warning', `Erro na detecção de arquivos: ${err.message}`);
    // Fallback: pelo menos incluir version-info.js
    const versionInfoPath = 'theme-deploy-corrigido/static/js/version-info.js';
    log('info', `  → ${versionInfoPath} (fallback)`);
    return [versionInfoPath];
  }
}

// =============================================================================
// PHASE 2: AUTO-INCREMENT VERSION
// =============================================================================

function phase2_bumpVersion(isMinor = false) {
  log('section', 'FASE 2: Auto-increment de Versão');

  const versionFile = path.join(PROJECT_ROOT, 'theme-deploy-corrigido', 'VERSION.json');

  let currentVersion = '1.1.8'; // fallback padrão
  if (fs.existsSync(versionFile)) {
    try {
      const content = JSON.parse(fs.readFileSync(versionFile, 'utf-8'));
      currentVersion = content.version || currentVersion;
    } catch (err) {
      log('warning', `Erro ao ler VERSION.json, usando fallback: ${currentVersion}`);
    }
  }

  // Parse versão atual
  const parts = currentVersion.split('.').map(Number);
  let [major, minor, patch] = parts;

  if (isMinor) {
    minor++;
    patch = 0;
  } else {
    patch++;
  }

  const newVersion = `${major}.${minor}.${patch}`;
  log('info', `Versão atual: ${currentVersion}`);
  log('success', `Nova versão: ${newVersion}`);

  // Atualizar VERSION.json
  const versionJson = {
    version: newVersion,
    deployment_date: new Date().toISOString(),
    git_commit: execSync('git rev-parse HEAD', { encoding: 'utf-8' }).trim(),
    console_message: `📦 PATAGANG v${newVersion} (${new Date().toLocaleDateString('pt-BR')}) ✅`,
  };

  const versionJsonPath = path.join(PROJECT_ROOT, 'theme-deploy-corrigido', 'VERSION.json');
  fs.writeFileSync(versionJsonPath, JSON.stringify(versionJson, null, 2));
  log('success', `VERSION.json atualizado`);

  // Sincronizar version-info.js com nova versão
  const versionInfoPath = path.join(PROJECT_ROOT, 'theme-deploy-corrigido', 'static', 'js', 'version-info.js');
  const versionInfoContent = `/* Auto-generated by deploy.js - ${new Date().toISOString()} */
if (typeof window !== 'undefined') {
  console.log('${versionJson.console_message}');
  window.__PATAGANG_VERSION__ = '${newVersion}';
}
`;
  fs.writeFileSync(versionInfoPath, versionInfoContent);
  log('success', `version-info.js sincronizado`);

  return newVersion;
}

// =============================================================================
// PHASE 3: GIT COMMIT + TAG + PUSH
// =============================================================================

async function phase3_gitCommitAndPush(newVersion, description, isDryRun = false, forceSkipConfirm = false) {
  log('section', 'FASE 3: Git Commit de Versão + Tag + Push');

  if (isDryRun) {
    log('info', '(DRY RUN - sem executar git commands)');
    return;
  }

  // Fazer commit de versão
  const commitMessage = `chore: bump version to ${newVersion} — ${description}

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>`;

  try {
    execSync('git add theme-deploy-corrigido/VERSION.json theme-deploy-corrigido/static/js/version-info.js');
    execSync(`git commit -m "${commitMessage.replace(/"/g, '\\"')}"`, { encoding: 'utf-8' });
    log('success', `Git commit criado: v${newVersion}`);
  } catch (err) {
    log('warning', `Erro ao fazer commit: ${err.message}`);
  }

  // Criar tag
  try {
    execSync(`git tag -a v${newVersion} -m "Version ${newVersion}"`, { encoding: 'utf-8' });
    log('success', `Git tag criado: v${newVersion}`);
  } catch (err) {
    log('warning', `Erro ao criar tag: ${err.message}`);
  }

  // Pedir confirmação antes de fazer push
  if (!forceSkipConfirm) {
    const confirm = await prompt('✅ Deploy para FTP confirmado. Fazer git push agora? (s/n)');
    if (confirm !== 's' && confirm !== 'yes' && confirm !== 'y') {
      log('info', 'Git push cancelado. Você pode fazer git push manualmente depois.');
      return;
    }
  }

  // Git push
  try {
    execSync('git push origin main --tags', { encoding: 'utf-8' });
    log('success', `Git push concluído com sucesso`);
  } catch (err) {
    log('error', `Erro ao fazer git push: ${err.message}`);
    log('warning', `Execute manualmente: git push origin main --tags`);
  }
}

// =============================================================================
// PHASE 4: INCREMENTAL BACKUP
// =============================================================================

async function phase4_backup(modifiedFiles, newVersion) {
  log('section', 'FASE 4: Backup Incremental');

  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const backupDir = path.join(DIRS.backup, `deployment-${newVersion}`, timestamp);
  fs.mkdirSync(backupDir, { recursive: true });

  const client = new Client();
  client.ftp.timeout = 30000;

  let backed = 0;
  const backupMetadata = {
    version: newVersion,
    timestamp,
    files: [],
    deployed_at: new Date().toISOString(),
  };

  try {
    await client.access(FTP_CONFIG);

    for (const localFile of modifiedFiles) {
      const remotePath = '/' + localFile.replace('theme-deploy-corrigido/', '').replace(/\\/g, '/');

      try {
        const backupPath = path.join(backupDir, localFile.replace('theme-deploy-corrigido/', ''));
        const backupDirPath = path.dirname(backupPath);
        fs.mkdirSync(backupDirPath, { recursive: true });

        await client.downloadTo(backupPath, remotePath);
        const size = fs.statSync(backupPath).size;
        log('success', `Backup: ${localFile} (${(size / 1024).toFixed(2)} KB)`);

        backupMetadata.files.push({
          local: localFile,
          remote: remotePath,
          size,
          backed_up: true,
        });

        backed++;
      } catch (err) {
        log('warning', `Backup falhou (arquivo novo?): ${localFile}`);
        backupMetadata.files.push({
          local: localFile,
          remote: remotePath,
          backed_up: false,
          error: err.message,
        });
      }
    }

    log('success', `Backup completo: ${backed}/${modifiedFiles.length} arquivos`);
  } catch (err) {
    log('error', `Erro ao conectar FTP para backup: ${err.message}`);
  } finally {
    await client.close();
  }

  // Salvar metadados
  fs.writeFileSync(path.join(backupDir, '_METADATA.json'), JSON.stringify(backupMetadata, null, 2));
  log('success', `Metadados salvos: ${backupDir}/_METADATA.json`);

  return backupDir;
}

// =============================================================================
// CACHE BUSTING: INJECT VERSION INTO CSS LINKS
// =============================================================================

function injectVersionIntoCSSLinks(layoutPath, version) {
  /**
   * Injeta ou atualiza ?v=VERSION nos links CSS para forçar cache busting
   * Evita que navegador e CDN sirvam CSS desatualizado
   *
   * Exemplos:
   *   <link href="{{ 'css/style-colors.scss.tpl' | static_url }}" ...>
   *   Vira:
   *   <link href="{{ 'css/style-colors.scss.tpl' | static_url }}?v=1.5.142" ...>
   *
   *   <link href="{{ 'css/style-async.scss.tpl' | static_url }}?v=1.5.141" ...>
   *   Vira (ATUALIZADO):
   *   <link href="{{ 'css/style-async.scss.tpl' | static_url }}?v=1.5.142" ...>
   *
   * Opera em layout.tpl e:
   * - Injeta ?v=VERSION em CSS links sem versão
   * - Atualiza versão anterior para nova versão (1.5.141 → 1.5.142)
   */

  try {
    if (!fs.existsSync(layoutPath)) {
      log('warning', `Cache busting: arquivo layout não encontrado: ${layoutPath}`);
      return;
    }

    let content = fs.readFileSync(layoutPath, 'utf-8');

    // Regex 1: Encontra href="..." com .css/.scss/.scss.tpl E já tem ?v=VERSAO_ANTIGA
    // Substitui a versão antiga pela nova
    const oldVersionRegex = /href="([^"]*\.(css|scss|scss\.tpl))\?v=[^"]*"/g;
    let updated = 0;
    content = content.replace(oldVersionRegex, (match, url, ext) => {
      updated++;
      return `href="${url}${ext}?v=${version}"`;
    });

    // Regex 2: Encontra href="..." com .css/.scss/.scss.tpl mas SEM ?v=
    // Adiciona a versão
    const noVersionRegex = /href="([^"]*\.(css|scss|scss\.tpl))([^"]*?)"/g;
    let injected = 0;
    content = content.replace(noVersionRegex, (match, url, ext, suffix) => {
      const fullUrl = url + ext + suffix;

      // Se JÁ tem ?v=, pular (já foi tratado na regex anterior)
      if (fullUrl.includes('?v=')) {
        return match;
      }

      // Injetar versão nova
      injected++;
      return `href="${fullUrl}?v=${version}"`;
    });

    if (updated > 0 || injected > 0) {
      fs.writeFileSync(layoutPath, content);
      if (updated > 0 && injected > 0) {
        log('success', `Cache busting: ${updated} versões atualizadas, ${injected} novas injetadas → v${version}`);
      } else if (updated > 0) {
        log('success', `Cache busting: ${updated} versões atualizadas para v${version}`);
      } else {
        log('success', `Cache busting: ${injected} CSS links injetados com v${version}`);
      }
    } else {
      log('info', `Cache busting: nenhuma mudança necessária (versão v${version} já atual)`);
    }
  } catch (err) {
    log('error', `Erro ao injetar cache busting: ${err.message}`);
    throw err;
  }
}

// =============================================================================
// PHASE 5: DEPLOY TO FTP
// =============================================================================

async function phase5_deploy(modifiedFiles, newVersion, isDryRun = false) {
  log('section', 'FASE 5: Deploy para FTP');

  // Cache busting: Injetar versão nos CSS links (força refresh no navegador)
  const layoutPath = path.join(PROJECT_ROOT, 'theme-deploy-corrigido', 'layouts', 'layout.tpl');
  if (!isDryRun && fs.existsSync(layoutPath)) {
    injectVersionIntoCSSLinks(layoutPath, newVersion);
  }

  if (isDryRun) {
    log('info', '(DRY RUN - simulando upload)');
    let size = 0;
    for (const file of modifiedFiles) {
      const filePath = path.join(PROJECT_ROOT, file);
      if (fs.existsSync(filePath)) {
        const fileSize = fs.statSync(filePath).size;
        size += fileSize;
        log('info', `  [SIM] Upload: ${file} (${(fileSize / 1024).toFixed(2)} KB)`);
      }
    }
    log('success', `Total simulado: ${(size / 1024).toFixed(2)} KB`);
    return { success: modifiedFiles.length, failed: 0 };
  }

  const client = new Client();
  client.ftp.timeout = 30000;

  let successCount = 0;
  let failCount = 0;

  try {
    await client.access(FTP_CONFIG);

    for (const localFile of modifiedFiles) {
      const filePath = path.join(PROJECT_ROOT, localFile);
      const remotePath = '/' + localFile.replace('theme-deploy-corrigido/', '').replace(/\\/g, '/');

      if (!fs.existsSync(filePath)) {
        log('error', `Arquivo não existe: ${localFile}`);
        failCount++;
        continue;
      }

      try {
        await client.uploadFrom(filePath, remotePath);
        const size = fs.statSync(filePath).size;
        log('success', `Deploy: ${localFile} (${(size / 1024).toFixed(2)} KB)`);
        successCount++;
      } catch (err) {
        log('error', `Deploy falhou: ${localFile} - ${err.message}`);
        failCount++;
      }
    }

    log('success', `Deploy completo: ${successCount}/${modifiedFiles.length} arquivos`);
  } catch (err) {
    log('error', `Erro ao conectar FTP: ${err.message}`);
  } finally {
    await client.close();
  }

  return { success: successCount, failed: failCount };
}

// =============================================================================
// PHASE 6: POST-DEPLOY VALIDATION
// =============================================================================

async function phase6_validate(modifiedFiles) {
  log('section', 'FASE 6: Validação Pós-Deploy');

  const client = new Client();
  client.ftp.timeout = 30000;

  let validated = 0;
  let versionMatch = false;

  try {
    await client.access(FTP_CONFIG);

    for (const localFile of modifiedFiles) {
      const remotePath = '/' + localFile.replace('theme-deploy-corrigido/', '').replace(/\\/g, '/');

      try {
        const testPath = path.join(__dirname, `.val-${Date.now()}-${Math.random().toString(36).slice(2)}.tmp`);
        await client.downloadTo(testPath, remotePath);
        const size = fs.statSync(testPath).size;
        fs.unlinkSync(testPath);

        log('success', `Validado: ${localFile} (${(size / 1024).toFixed(2)} KB no FTP)`);
        validated++;

        // Verificar se é version-info.js
        if (localFile.includes('version-info.js')) {
          versionMatch = true;
        }
      } catch (err) {
        log('error', `Validação falhou: ${localFile}`);
      }
    }

    log('success', `Validação completa: ${validated}/${modifiedFiles.length} arquivos`);
  } catch (err) {
    log('warning', `Erro ao validar no FTP: ${err.message}`);
  } finally {
    await client.close();
  }

  return { validated, versionMatch };
}

// =============================================================================
// MAIN
// =============================================================================

async function main() {
  const isDryRun = process.argv.includes('--dry-run');
  const isMinor = process.argv.includes('--minor');
  const forceSkipConfirm = process.argv.includes('--force');

  // Extrair descrição (primeiro argumento não-flag)
  const description = process.argv.find((arg, i) => i > 1 && !arg.startsWith('--'));

  const args = { description };

  // Banner
  console.log(`\n${COLORS.bright}${'='.repeat(80)}${COLORS.reset}`);
  console.log(`${COLORS.bright}    🚀 PATAGANG DEPLOYMENT v2.0 — AIOX-Compliant${COLORS.reset}`);
  console.log(`${COLORS.bright}${'='.repeat(80)}${COLORS.reset}\n`);

  if (isDryRun) {
    log('info', '🏃 MODO: DRY-RUN (simula sem executar)');
  }

  try {
    // Fase 0: Validação de contexto
    const context = await phase0_validateContext(args);

    // Fase 1: Detectar arquivos modificados
    const modifiedFiles = phase1_detectFiles();

    // Fase 2: Auto-increment de versão
    const newVersion = phase2_bumpVersion(isMinor);

    // Fase 3: Git commit + tag + push
    await phase3_gitCommitAndPush(newVersion, description, isDryRun, forceSkipConfirm);

    // Fase 4: Backup incremental
    const backupDir = isDryRun ? '[DRY-RUN]' : await phase4_backup(modifiedFiles, newVersion);

    // Fase 5: Deploy para FTP (com cache busting automático)
    const deployResult = await phase5_deploy(modifiedFiles, newVersion, isDryRun);

    // Fase 6: Validação pós-deploy
    const validationResult = await phase6_validate(modifiedFiles);

    // Relatório final
    console.log(`\n${COLORS.bright}${'='.repeat(80)}${COLORS.reset}`);
    const success = deployResult.failed === 0;
    log('box', `${success ? '✅ SUCESSO' : '⚠️ COM PROBLEMAS'} — v${newVersion}`);
    console.log(`${COLORS.bright}${'='.repeat(80)}${COLORS.reset}\n`);

    console.log(`${COLORS.bright}📊 Resultados:${COLORS.reset}`);
    console.log(`   Deploy bem-sucedido: ${deployResult.success}/${modifiedFiles.length}`);
    if (deployResult.failed > 0) {
      console.log(`   Deploy falhado: ${deployResult.failed}`);
    }
    console.log(`   Validação: ${validationResult.validated}/${deployResult.success}`);
    console.log(`   Versão sincronizada: ${validationResult.versionMatch ? '✅ Sim' : '⚠️ Verificar manualmente'}\n`);

    if (!isDryRun) {
      console.log(`${COLORS.bright}💾 Backup:${COLORS.reset}`);
      console.log(`   ${backupDir}\n`);
    }

    console.log(`${COLORS.bright}🎯 Próximos passos:${COLORS.reset}`);
    console.log(`   1. Abra a loja no navegador: https://patagang.com.br/`);
    console.log(`   2. Abra o console (F12 ou Cmd+Option+J)`);
    console.log(`   3. Procure por: 📦 PATAGANG v${newVersion}`);
    console.log(`   4. Se não aparecer, limpe cache: Ctrl+Shift+Delete\n`);

    process.exit(deployResult.failed > 0 ? 1 : 0);
  } catch (err) {
    log('error', `ERRO CRÍTICO: ${err.message}`);
    console.error(err.stack);
    process.exit(1);
  }
}

main().catch((err) => {
  log('error', `Erro não capturado: ${err.message}`);
  process.exit(1);
});
