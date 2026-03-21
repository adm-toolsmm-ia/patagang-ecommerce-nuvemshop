#!/usr/bin/env node

/**
 * Force Cache Bust
 * Incrementa a versão para forçar Nuvemshop a regenerar a página
 * Isso vai gerar um novo query string v=TIMESTAMP
 */

const fs = require('fs');
const path = require('path');

// Incrementar versão para forçar regeneração
const versionJsonPath = path.join(__dirname, '../theme-deploy-corrigido/VERSION.json');
const versionJson = JSON.parse(fs.readFileSync(versionJsonPath, 'utf-8'));

// Adicionar timestamp ao deployment_date para forçar cache bust
versionJson.deployment_date = new Date().toISOString();
versionJson.cache_bust_timestamp = Math.floor(Date.now() / 1000).toString();

fs.writeFileSync(versionJsonPath, JSON.stringify(versionJson, null, 2));

console.log('✓ Cache bust timestamp adicionado');
console.log('  Próximo passo: Fazer upload de novo\n');

// Agora fazer upload da versão-info.js novamente
const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

async function uploadVersionInfo() {
  const client = new Client();
  
  try {
    await client.access(FTP_CONFIG);
    
    const localPath = path.join(__dirname, '../theme-deploy-corrigido/static/js/version-info.js');
    const remotePath = '/theme/static/js/version-info.js';
    
    console.log('Uploadando version-info.js com timestamp de cache bust...');
    await client.uploadFrom(localPath, remotePath);
    
    console.log('✓ Upload concluído\n');
    console.log('⚠️  Aguarde 2-5 minutos para Nuvemshop regenerar a página');
    console.log('   Ou acesse: https://patagang.com.br/?_cache_bust=' + Date.now() + '\n');
    
    await client.close();
    process.exit(0);
    
  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  }
}

uploadVersionInfo();
