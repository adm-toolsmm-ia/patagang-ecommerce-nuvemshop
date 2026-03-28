#!/usr/bin/env node

const Client = require('basic-ftp').Client;
const fs = require('fs');
const crypto = require('crypto');
const { FTP_CONFIG } = require('./config');

async function verify() {
  const client = new Client();
  
  try {
    console.log('🔗 Conectando ao FTP...');
    await client.access({
      host: FTP_CONFIG.host,
      user: FTP_CONFIG.user,
      password: FTP_CONFIG.password,
      secure: false, // Tentar sem SSL primeiro
    });

    console.log('✅ Conectado\n');

    // Ler arquivo local
    const localContent = fs.readFileSync('theme-deploy-corrigido/static/css/style-async.scss.tpl', 'utf8');
    const localSize = Buffer.byteLength(localContent, 'utf8');
    
    console.log('📄 LOCAL: ' + localSize + ' bytes');
    
    // Verificar linha 646
    const lines = localContent.split('\n');
    console.log('📍 Linha 646: ' + (lines[645] ? lines[645].trim().substring(0, 80) : 'N/A'));

    // Listar arquivo no FTP
    const ftpList = await client.list('/theme-deploy-corrigido/static/css/');
    const asyncFile = ftpList.find(f => f.name === 'style-async.scss.tpl');
    
    if (asyncFile) {
      console.log('📄 FTP:   ' + asyncFile.size + ' bytes');
      console.log('📅 Data:  ' + asyncFile.modifiedAt);
      
      if (localSize === asyncFile.size) {
        console.log('✅ Tamanhos IGUAIS');
      } else {
        console.log('❌ Tamanhos DIFERENTES: ' + Math.abs(localSize - asyncFile.size) + ' bytes de diferença');
      }
    } else {
      console.log('❌ Arquivo não encontrado no FTP');
    }

  } catch (err) {
    console.error('❌ Erro:', err.message);
  } finally {
    client.close();
  }
}

verify();
