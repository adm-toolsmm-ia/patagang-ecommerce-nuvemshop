#!/usr/bin/env node

/**
 * ANÁLISE CORRETA (Versão 2)
 * Para cada arquivo, encontrar a ÚLTIMA versão que o ALTEROU
 * ENTRE v1.5.166 (bbcf569) e v1.5.200 (52482ea)
 *
 * Estratégia:
 * 1. git log bbcf569..52482ea -- arquivo (commits que tocaram nesse arquivo)
 * 2. Extrair versão do primeiro commit (mais recente = ÚLTIMA alteração)
 */

const { execSync } = require('child_process');

function log(type, msg) {
  const icons = {
    info: 'ℹ️ ',
    success: '✅',
    error: '❌',
    warning: '⚠️ ',
    version: '📌',
  };
  console.log(`${icons[type] || '•'} ${msg}`);
}

// Encontrar ÚLTIMA versão que alterou um arquivo entre dois commits
function findLastVersionBetweenCommits(filePath, fromCommit, toCommit) {
  try {
    const output = execSync(
      `git log ${fromCommit}..${toCommit} --oneline -- "${filePath}" | head -1`,
      { encoding: 'utf8', cwd: process.cwd() }
    );

    if (!output.trim()) return null;

    const [hash, ...msgParts] = output.trim().split(' ');
    const msg = msgParts.join(' ');

    // Extrair versão
    const versionMatch = msg.match(/1\.5\.(\d+)/);
    const version = versionMatch ? parseInt(versionMatch[1]) : null;

    return {
      hash,
      msg,
      version,
      versionString: version ? `v1.5.${version}` : 'unknown',
    };
  } catch (err) {
    return null;
  }
}

// Encontrar TODAS as versões que tocaram um arquivo entre dois commits
function findAllVersionsBetweenCommits(filePath, fromCommit, toCommit) {
  try {
    const output = execSync(
      `git log ${fromCommit}..${toCommit} --oneline -- "${filePath}"`,
      { encoding: 'utf8', cwd: process.cwd() }
    );

    if (!output.trim()) return [];

    return output
      .trim()
      .split('\n')
      .map(line => {
        const [hash, ...msgParts] = line.split(' ');
        const msg = msgParts.join(' ');
        const versionMatch = msg.match(/1\.5\.(\d+)/);
        const version = versionMatch ? parseInt(versionMatch[1]) : null;
        return { hash, msg, version, versionString: version ? `v1.5.${version}` : 'unknown' };
      });
  } catch (err) {
    return [];
  }
}

// MAIN
const fromCommit = 'bbcf569'; // v1.5.166
const toCommit = '52482ea';   // v1.5.200

log('info', '🔍 ANÁLISE CORRETA: Última Versão Entre v1.5.166 e v1.5.200');
log('info', `📍 Procurando commits ENTRE ${fromCommit} (v1.5.166) e ${toCommit} (v1.5.200)\n`);

const arquivos = [
  'theme-deploy-corrigido/VERSION.json',
  'theme-deploy-corrigido/layouts/layout.tpl',
  'theme-deploy-corrigido/snipplets/header/header-advertising.tpl',
  'theme-deploy-corrigido/snipplets/header/header-patagang.tpl',
  'theme-deploy-corrigido/snipplets/whatsapp-left.tpl',
  'theme-deploy-corrigido/static/css/style-critical.tpl',
  'theme-deploy-corrigido/static/css/style-async.scss.tpl',
  'theme-deploy-corrigido/static/css/style-help-sidebar.css.tpl',
  'theme-deploy-corrigido/static/css/style-menu-patagang.css.tpl',
  'theme-deploy-corrigido/static/css/style-whatsapp-button.css.tpl',
  'theme-deploy-corrigido/static/js/product-page-custom.js',
  'theme-deploy-corrigido/static/js/version-info.js',
];

const resultados = [];

log('info', 'Analisando cada arquivo...\n');

arquivos.forEach(arquivo => {
  const lastVersion = findLastVersionBetweenCommits(arquivo, fromCommit, toCommit);
  const allVersions = findAllVersionsBetweenCommits(arquivo, fromCommit, toCommit);

  const nomeArquivo = arquivo.split('/').pop();

  if (!lastVersion) {
    log('warning', `${nomeArquivo.padEnd(50)} — Sem alterações entre 166 e 200`);
    return;
  }

  resultados.push({
    arquivo,
    nomeArquivo,
    ultimaVersao: lastVersion.version,
    ultimoCommit: lastVersion.hash,
    ultimaMensagem: lastVersion.msg,
    todasAsVersoes: allVersions.map(v => v.version),
    todasAsVersoesFull: allVersions,
  });

  log('version', `${nomeArquivo.padEnd(50)} | ${lastVersion.versionString}`);
  if (allVersions.length > 1) {
    const versoesList = allVersions.map(v => `v1.5.${v.version}`).join(' ← ');
    log('info', `  └─ Histórico: ${versoesList}`);
  }
});

// RESUMO
log('info', '\n' + '━'.repeat(100));
log('success', '\n📋 RESUMO: Última Versão CORRETA de Cada Arquivo Alterado\n');

log('info', 'Arquivo | Última Versão | Histórico de Alterações');
log('info', '─'.repeat(120));

resultados.sort((a, b) => b.ultimaVersao - a.ultimaVersao).forEach(r => {
  const versoes = r.todasAsVersoesFull
    .map(v => `v1.5.${v.version}`)
    .reverse()
    .join(' → ');
  console.log(`${r.nomeArquivo.padEnd(45)} | v1.5.${r.ultimaVersao.toString().padStart(3)} | ${versoes}`);
});

// MAPEAMENTO FINAL
log('info', '\n' + '━'.repeat(100));
log('success', '\n📌 MAPEAMENTO FINAL: Use Esta Versão Como Referência\n');

console.log('┌─ ARQUIVO ─────────────────────────────────────────┬─ VERSÃO ─┬─ USAR COMO REFERÊNCIA ─┐');
resultados
  .sort((a, b) => b.ultimaVersao - a.ultimaVersao)
  .forEach(r => {
    const marker = r.ultimaVersao >= 190 ? '⚠️ ' : '✅';
    console.log(`├─ ${r.nomeArquivo.padEnd(48)} │ v1.5.${r.ultimaVersao.toString().padStart(3)} │ ${marker} v1.5.${r.ultimaVersao.toString().padStart(3)} ${' '.repeat(10)} │`);
  });
console.log('└────────────────────────────────────────────────────┴──────────┴────────────────────────┘');

// ARQUIVOS SEM ALTERAÇÃO
log('info', '\n━'.repeat(100));
log('warning', '\n⚠️  ARQUIVOS SEM ALTERAÇÃO ENTRE v1.5.166 E v1.5.200:\n');

const semAlteracao = arquivos.filter(
  arquivo => !resultados.some(r => r.arquivo === arquivo)
);

if (semAlteracao.length === 0) {
  log('success', 'Nenhum — todos os arquivos foram alterados!');
} else {
  semAlteracao.forEach(arquivo => {
    log('info', `  • ${arquivo.split('/').pop()}`);
  });
}

log('info', '\n' + '━'.repeat(100));
log('success', '\n✅ Análise Correta Completa!');
log('info', '\nPróximo passo: Usar EXATAMENTE as versões identificadas acima como referência.');
