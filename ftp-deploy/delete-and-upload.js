#!/usr/bin/env node
const Client = require('basic-ftp').Client;
const fs = require('fs');
const { FTP_CONFIG } = require('./config');

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
    
    // DELETAR o arquivo problemático
    console.log('🗑️  Deletando style-async.scss.tpl do FTP...');
    try {
      await client.remove('theme-deploy-corrigido/static/css/style-async.scss.tpl');
      console.log('✅ Arquivo deletado do FTP\n');
    } catch (e) {
      console.log('⚠️  Erro ao deletar (arquivo pode não existir):\n');
    }

    // RE-ENVIAR arquivo correto
    console.log('📤 Re-enviando arquivo correto...');
    await client.uploadFrom('theme-deploy-corrigido/static/css/style-async.scss.tpl', 'theme-deploy-corrigido/static/css/style-async.scss.tpl');
    console.log('✅ Arquivo re-enviado com sucesso\n');

    console.log('🎉 OPERAÇÃO COMPLETA');
    console.log('O Nuvemshop vai recompilar o arquivo do zero na próxima vez');

  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  } finally {
    client.close();
  }
})();
