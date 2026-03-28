#!/usr/bin/env node

const Client = require('basic-ftp').Client;
const fs = require('fs');
const path = require('path');
const { FTP_CONFIG } = require('./config');

async function checkFile() {
  const client = new Client();
  
  try {
    console.log('🔗 Conectando ao FTP...');
    await client.access({
      host: FTP_CONFIG.host,
      user: FTP_CONFIG.user,
      password: FTP_CONFIG.password,
      secure: true,
    });

    console.log('✅ Conectado\n');

    // Listar arquivo no FTP
    const ftpList = await client.list('/theme-deploy-corrigido/static/css/');
    const asyncFile = ftpList.find(f => f.name === 'style-async.scss.tpl');
    
    // Tamanho local
    const localSize = fs.statSync('theme-deploy-corrigido/static/css/style-async.scss.tpl').size;
    
    console.log('📊 COMPARAÇÃO DE TAMANHO\n');
    console.log('LOCAL:  ' + localSize + ' bytes');
    
    if (asyncFile) {
      console.log('FTP:    ' + asyncFile.size + ' bytes');
      console.log('DATA:   ' + asyncFile.modifiedAt);
      
      if (localSize === asyncFile.size) {
        console.log('\n✅ TAMANHOS IDÊNTICOS - arquivo foi deployado corretamente');
      } else {
        const diff = Math.abs(localSize - asyncFile.size);
        console.log('\n❌ TAMANHOS DIFERENTES - Diferença: ' + diff + ' bytes');
        console.log('   Arquivo no FTP NÃO foi atualizado ou corrupted no upload');
      }
    } else {
      console.log('\n❌ Arquivo NÃO encontrado no FTP!');
    }

  } catch (err) {
    console.error('❌ Erro de conexão:', err.message);
  } finally {
    client.close();
  }
}

checkFile();
