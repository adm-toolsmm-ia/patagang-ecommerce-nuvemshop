#!/usr/bin/env node
const Client = require('basic-ftp').Client;
const fs = require('fs');
const path = require('path');
const { FTP_CONFIG } = require('./config');

const PROJECT_ROOT = path.dirname(path.dirname(path.resolve(__filename)));

(async () => {
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
    
    const layoutPath = path.join(PROJECT_ROOT, 'theme-deploy-corrigido', 'layouts', 'layout.tpl');
    
    // DELETAR o arquivo
    console.log('🗑️  Deletando layout.tpl do FTP...');
    try {
      await client.remove('theme-deploy-corrigido/layouts/layout.tpl');
      console.log('✅ Arquivo deletado do FTP\n');
    } catch (e) {
      console.log('⚠️  Arquivo pode não existir no FTP\n');
    }

    // RE-ENVIAR arquivo correto
    console.log('📤 Re-enviando layout.tpl...');
    await client.uploadFrom(layoutPath, 'theme-deploy-corrigido/layouts/layout.tpl');
    console.log('✅ layout.tpl enviado com sucesso!\n');

    client.close();
    process.exit(0);
  } catch (err) {
    console.error('❌ Erro:', err.message);
    client.close();
    process.exit(1);
  }
})();
