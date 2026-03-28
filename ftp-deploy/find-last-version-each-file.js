#!/usr/bin/env node

/**
 * ANÁLISE CORRETA: Última versão EXATA de cada arquivo
 * Para CADA arquivo entre v1.5.166 e v1.5.200:
 * 1. Listar todas as versões que o tocaram
 * 2. Identificar qual foi a ÚLTIMA (mais recente)
 * 3. Mapear versão → commit hash
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

// Obter histórico COMPLETO de um arquivo
function getFileHistory(filePath) {
  try {
    const output = execSync(
      `git log --all --oneline --follow -- "${filePath}" | head -50`,
      { encoding: 'utf8', cwd: process.cwd() }
    );

    return output
      .split('\n')
      .filter(line => line.trim())
      .map(line => {
        const [hash, ...msgParts] = line.split(' ');
        const msg = msgParts.join(' ');

        // Extrair versão da mensagem
        const versionMatch = msg.match(/1\.5\.(\d+)/);
        const version = versionMatch ? parseInt(versionMatch[1]) : null;

        return { hash, msg, version };
      });
  } catch (err) {
    return [];
  }
}

// MAIN
log('info', '📊 ANÁLISE: ÚLTIMA VERSÃO EXATA DE CADA ARQUIVO');
log('info', '━'.repeat(80));
log('info', 'Procurando TODAS as versões entre v1.5.166 e v1.5.200\n');

// Arquivos do tema que potencialmente foram alterados
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

arquivos.forEach(arquivo => {
  const history = getFileHistory(arquivo);

  if (history.length === 0) {
    log('warning', `${arquivo} — Sem histórico encontrado`);
    return;
  }

  // Filtrar versões entre 166 e 200
  const versoesFiltradas = history.filter(h => h.version && h.version >= 166 && h.version <= 200);

  if (versoesFiltradas.length === 0) {
    log('info', `${arquivo} — Sem alterações entre v1.5.166-200`);
    return;
  }

  // ÚLTIMA versão (primeira no array, mais recente)
  const ultimaVersao = versoesFiltradas[0];

  resultados.push({
    arquivo,
    ultimaVersao: ultimaVersao.version,
    ultimoCommit: ultimaVersao.hash,
    ultimaMensagem: ultimaVersao.msg,
    todasAsVersoes: versoesFiltradas.map(v => v.version).sort((a, b) => b - a),
  });

  log('version', `${arquivo.padEnd(60)} | v1.5.${ultimaVersao.version.toString().padStart(3)}`);
  log('info', `  └─ Versões que tocaram: v1.5.${versoesFiltradas.map(v => v.version).sort((a, b) => b - a).join(', v1.5.')}`);
  log('info', `  └─ Commit: ${ultimaVersao.hash} — ${ultimaVersao.msg.substring(0, 60)}`);
  log('info', '');
});

// RESUMO CONSOLIDADO
log('info', '━'.repeat(80));
log('success', '\n📋 RESUMO CONSOLIDADO: Última Versão de Cada Arquivo\n');

log('info', 'Arquivo | Última Versão | Todas as Versões que Alteraram');
log('info', '─'.repeat(120));

resultados.sort((a, b) => b.ultimaVersao - a.ultimaVersao).forEach(r => {
  const arquivo = r.arquivo.split('/').pop();
  const todasVersoes = r.todasAsVersoes.map(v => `v1.5.${v}`).join(' → ');
  console.log(`${arquivo.padEnd(40)} | v1.5.${r.ultimaVersao.toString().padStart(3)} | ${todasVersoes}`);
});

// AGRUPAMENTO POR VERSÃO
log('info', '\n━'.repeat(80));
log('success', '\n📊 AGRUPAMENTO: Qual versão é responsável por cada arquivo?\n');

const porVersao = {};
resultados.forEach(r => {
  if (!porVersao[r.ultimaVersao]) {
    porVersao[r.ultimaVersao] = [];
  }
  porVersao[r.ultimaVersao].push(r.arquivo.split('/').pop());
});

Object.keys(porVersao)
  .map(Number)
  .sort((a, b) => b - a)
  .forEach(versao => {
    log('version', `v1.5.${versao}:`);
    porVersao[versao].forEach(arquivo => {
      console.log(`  • ${arquivo}`);
    });
    console.log('');
  });

// MAPEAMENTO JSON para referência
log('info', '━'.repeat(80));
log('success', '\n✅ Mapeamento Completo (JSON)\n');

const mapeamento = {};
resultados.forEach(r => {
  mapeamento[r.arquivo] = {
    ultimaVersao: `v1.5.${r.ultimaVersao}`,
    ultimoCommit: r.ultimoCommit,
    todasAsVersoes: r.todasAsVersoes.map(v => `v1.5.${v}`),
  };
});

console.log(JSON.stringify(mapeamento, null, 2));

log('info', '\n━'.repeat(80));
log('success', 'Análise Completa!');
log('info', '\nPróximo passo: Usar a ÚLTIMA VERSÃO de cada arquivo como referência');
