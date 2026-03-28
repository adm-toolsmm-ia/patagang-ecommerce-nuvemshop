#!/usr/bin/env node

/**
 * ANÁLISE DE VERSÕES
 * Mapeia arquivos alterados entre v1.5.166 (checkpoint) e v1.5.200
 * Gera relatório detalhado de quais arquivos foram modificados em cada versão
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

function log(msg) {
  console.log(msg);
}

// Obter todas as versões entre 166 e 200
function getVersionsInRange() {
  try {
    // Buscar todos os tags/commits com versão
    const output = execSync(
      'git log --oneline --all --decorate | grep "1\\.5\\." || true',
      { encoding: 'utf8', cwd: process.cwd() }
    );

    const versions = [];
    const lines = output.split('\n').filter(l => l.trim());

    lines.forEach(line => {
      const match = line.match(/1\.5\.(\d+)/);
      if (match) {
        const version = parseInt(match[1]);
        if (version >= 166 && version <= 200) {
          versions.push(version);
        }
      }
    });

    return [...new Set(versions)].sort((a, b) => b - a); // Remover duplicatas e ordenar
  } catch (err) {
    return [];
  }
}

// Obter arquivos alterados em um commit/versão específica
function getFilesChangedInVersion(version) {
  try {
    // Procurar commits que mencionam a versão
    const commitOutput = execSync(
      `git log --all --oneline --grep="1\\.5\\.${version}" | head -3`,
      { encoding: 'utf8', cwd: process.cwd() }
    );

    if (!commitOutput.trim()) return [];

    const commitHash = commitOutput.split('\n')[0].split(' ')[0];
    if (!commitHash) return [];

    // Obter arquivos alterados neste commit
    const filesOutput = execSync(
      `git diff-tree --no-commit-id --name-only -r ${commitHash}`,
      { encoding: 'utf8', cwd: process.cwd() }
    );

    return filesOutput
      .split('\n')
      .filter(f => f.trim())
      .filter(f => !f.includes('node_modules') && !f.includes('.git'));
  } catch (err) {
    return [];
  }
}

// Obter diff completo de um arquivo entre duas versões
function getFileDiffBetweenVersions(filePath, fromVersion, toVersion) {
  try {
    const output = execSync(
      `git log --all --oneline --grep="1\\.5\\.${toVersion}" | head -1`,
      { encoding: 'utf8', cwd: process.cwd() }
    );

    const toCommitHash = output.split(' ')[0];
    if (!toCommitHash) return null;

    const output2 = execSync(
      `git log --all --oneline --grep="1\\.5\\.${fromVersion}" | head -1`,
      { encoding: 'utf8', cwd: process.cwd() }
    );

    const fromCommitHash = output2.split(' ')[0];
    if (!fromCommitHash) return null;

    const diff = execSync(
      `git diff ${fromCommitHash}..${toCommitHash} -- "${filePath}" || true`,
      { encoding: 'utf8', cwd: process.cwd() }
    );

    return diff.length > 0 ? diff : null;
  } catch (err) {
    return null;
  }
}

// MAIN
log('\n' + '='.repeat(80));
log('📊 RELATÓRIO DE VERSÕES: v1.5.166 → v1.5.200');
log('='.repeat(80) + '\n');

const versions = getVersionsInRange();
log(`✅ Encontradas ${versions.length} versões entre 166 e 200\n`);

if (versions.length === 0) {
  log('⚠️  Nenhuma versão encontrada entre 166 e 200. Usando análise alternativa...\n');

  // Estratégia alternativa: buscar commits mencionando Stories ou épicas
  try {
    const allCommits = execSync(
      'git log --oneline --all | head -100',
      { encoding: 'utf8', cwd: process.cwd() }
    );

    log('Últimos commits com potencial para alterações:');
    log(allCommits);
  } catch (err) {
    log('Erro ao buscar commits: ' + err.message);
  }

  process.exit(0);
}

// Mapear arquivos por versão
const filesByVersion = {};
const allFilesModified = new Set();

log('🔍 Mapeando arquivos alterados por versão...\n');

versions.forEach(v => {
  const files = getFilesChangedInVersion(v);
  if (files.length > 0) {
    filesByVersion[v] = files;
    files.forEach(f => allFilesModified.add(f));
    log(`  v1.5.${v}: ${files.length} arquivo(s)`);
  }
});

log('\n' + '='.repeat(80));
log('📁 LISTA CONSOLIDADA DE ARQUIVOS ALTERADOS');
log('='.repeat(80) + '\n');

// Agrupar por tipo de arquivo
const filesByType = {
  css: [],
  js: [],
  tpl: [],
  other: [],
};

allFilesModified.forEach(file => {
  if (file.endsWith('.css') || file.endsWith('.scss')) {
    filesByType.css.push(file);
  } else if (file.endsWith('.js')) {
    filesByType.js.push(file);
  } else if (file.endsWith('.tpl')) {
    filesByType.tpl.push(file);
  } else {
    filesByType.other.push(file);
  }
});

log(`🎨 CSS/SCSS (${filesByType.css.length}):`);
filesByType.css.forEach(f => log(`   • ${f}`));

log(`\n📜 Templates TPL (${filesByType.tpl.length}):`);
filesByType.tpl.forEach(f => log(`   • ${f}`));

log(`\n⚙️  JavaScript (${filesByType.js.length}):`);
filesByType.js.forEach(f => log(`   • ${f}`));

log(`\n📄 Outros (${filesByType.other.length}):`);
filesByType.other.forEach(f => log(`   • ${f}`));

log('\n' + '='.repeat(80));
log('📋 DETALHES POR ARQUIVO');
log('='.repeat(80) + '\n');

const fileVersionMap = {};

allFilesModified.forEach(file => {
  const versionsModified = [];
  versions.forEach(v => {
    if (filesByVersion[v] && filesByVersion[v].includes(file)) {
      versionsModified.push(v);
    }
  });

  if (versionsModified.length > 0) {
    const lastVersion = Math.max(...versionsModified);
    fileVersionMap[file] = {
      versions: versionsModified.sort((a, b) => b - a),
      lastVersion: lastVersion,
    };
  }
});

// Ordenar por última versão (decrescente)
const sortedFiles = Object.entries(fileVersionMap)
  .sort((a, b) => b[1].lastVersion - a[1].lastVersion);

sortedFiles.forEach(([file, info]) => {
  log(`\n📄 ${file}`);
  log(`   Última alteração: v1.5.${info.lastVersion}`);
  log(`   Alterado em ${info.versions.length} versões: v1.5.${info.versions.join(', v1.5.')}`);
});

log('\n' + '='.repeat(80));
log('🎯 MAPEAMENTO FINAL: Última Versão de Cada Arquivo');
log('='.repeat(80) + '\n');

log('Arquivo | Última Versão | Alterações');
log('─'.repeat(80));

const sortedByLastVersion = sortedFiles.sort((a, b) => {
  const aFile = path.basename(a[0]);
  const bFile = path.basename(b[0]);
  return aFile.localeCompare(bFile);
});

sortedByLastVersion.forEach(([file, info]) => {
  const fileName = path.basename(file);
  const lastV = info.lastVersion;
  const count = info.versions.length;
  log(`${fileName.padEnd(40)} | v1.5.${lastV.toString().padStart(3)} | ${count}x`);
});

log('\n' + '='.repeat(80));
log('✅ Análise Completa!');
log('='.repeat(80) + '\n');

log('PRÓXIMOS PASSOS:');
log('1. Revisar quais arquivos tiveram alterações mais importantes');
log('2. Comparar local (v1.5.166) com últimas versões (v1.5.200)');
log('3. Aplicar apenas as correções necessárias\n');
