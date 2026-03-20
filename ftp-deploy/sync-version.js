#!/usr/bin/env node

/**
 * SYNC-VERSION.JS
 * ================
 * Sincroniza a versão de ftp-deploy/VERSION para os arquivos do projeto
 * Deve ser executado ANTES de fazer deploy (pré-deploy)
 *
 * Uso: node sync-version.js [nova-versao]
 * Ex:  node sync-version.js 1.1.4
 */

const fs = require('fs');
const path = require('path');

// Lê versão do arquivo VERSION ou do argumento
const versionFile = path.join(__dirname, 'VERSION');
let targetVersion = process.argv[2];

if (!targetVersion && fs.existsSync(versionFile)) {
    targetVersion = fs.readFileSync(versionFile, 'utf-8').trim();
}

if (!targetVersion) {
    console.error('❌ Erro: Especifique uma versão');
    console.log('Uso: node sync-version.js [versao]');
    console.log('Ex:  node sync-version.js 1.1.4');
    process.exit(1);
}

console.log(`🔄 Sincronizando versão para: ${targetVersion}`);

// 1. Atualizar VERSION.json
const versionJsonPath = path.join(__dirname, '../theme-deploy-corrigido/VERSION.json');
try {
    const versionJson = JSON.parse(fs.readFileSync(versionJsonPath, 'utf-8'));
    versionJson.version = targetVersion;
    versionJson.deployment_date = new Date().toISOString();
    versionJson.deployment_timestamp = new Date().toISOString().replace('T', ' ').substring(0, 19);
    fs.writeFileSync(versionJsonPath, JSON.stringify(versionJson, null, 2));
    console.log(`✅ VERSION.json atualizado para v${targetVersion}`);
} catch (err) {
    console.error(`❌ Erro ao atualizar VERSION.json: ${err.message}`);
    process.exit(1);
}

// 2. Atualizar version-info.js (substitui apenas a constante VERSION)
const versionInfoPath = path.join(__dirname, '../theme-deploy-corrigido/static/js/version-info.js');
try {
    let content = fs.readFileSync(versionInfoPath, 'utf-8');
    const today = new Date().toISOString().split('T')[0];
    content = content.replace(/const VERSION = ".*?";/, `const VERSION = "${targetVersion}";`);
    content = content.replace(/const DEPLOY_DATE = ".*?";/, `const DEPLOY_DATE = "${today}";`);
    fs.writeFileSync(versionInfoPath, content);
    console.log(`✅ version-info.js atualizado para v${targetVersion}`);
} catch (err) {
    console.error(`❌ Erro ao atualizar version-info.js: ${err.message}`);
    process.exit(1);
}

// 3. Atualizar VERSION arquivo simples para próximos deploys
try {
    fs.writeFileSync(versionFile, `${targetVersion}\n`);
    console.log(`✅ VERSION arquivo atualizado`);
} catch (err) {
    console.error(`❌ Erro ao atualizar VERSION: ${err.message}`);
    process.exit(1);
}

console.log(`\n✨ Sincronização concluída!`);
console.log(`📦 Próximo passo: npm run deploy:critical\n`);
