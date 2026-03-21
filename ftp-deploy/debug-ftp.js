#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

async function checkFTP() {
  const client = new Client();
  
  console.log('🔍 VERIFICANDO ARQUIVO NO FTP\n');

  try {
    await client.access(FTP_CONFIG);
    console.log('✓ Conectado ao FTP\n');

    // Download do arquivo do FTP
    const remoteFile = '/theme/static/js/version-info.js';
    const tempFile = '/tmp/version-info-ftp.js';

    console.log(`Baixando: ${remoteFile}`);
    await client.downloadTo(tempFile, remoteFile);
    
    const ftpContent = fs.readFileSync(tempFile, 'utf-8');
    const localContent = fs.readFileSync(path.join(__dirname, '../theme-deploy-corrigido/static/js/version-info.js'), 'utf-8');

    // Extrair versão
    const ftpVersion = ftpContent.match(/const VERSION = "([^"]+)"/)?.[1] || 'NÃO ENCONTRADA';
    const localVersion = localContent.match(/const VERSION = "([^"]+)"/)?.[1] || 'NÃO ENCONTRADA';

    console.log(`\nVersão NO FTP: ${ftpVersion}`);
    console.log(`Versão LOCAL: ${localVersion}`);

    if (ftpVersion !== localVersion) {
      console.log(`\n⚠️  VERSÕES DIFERENTES! Upload falhou ou não sincronizou`);
      console.log(`\nArquivo FTP (primeiras 500 chars):`);
      console.log(ftpContent.substring(0, 500));
    } else {
      console.log(`\n✓ Versões iguais! Upload funcionou corretamente`);
    }

    await client.close();

  } catch (err) {
    console.error('❌ ERRO:', err.message);
    process.exit(1);
  }
}

checkFTP();
