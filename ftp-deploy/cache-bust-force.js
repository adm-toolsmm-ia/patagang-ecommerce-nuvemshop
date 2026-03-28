#!/usr/bin/env node
const Client = require('basic-ftp').Client;
const fs = require('fs');
const path = require('path');
const { FTP_CONFIG } = require('./config');

const PROJECT_ROOT = path.dirname(path.dirname(path.resolve(__filename)));

(async () => {
  const client = new Client();
  try {
    console.log('🔗 Conectando ao FTP para limpeza de cache...');
    await client.access({
      host: FTP_CONFIG.host,
      user: FTP_CONFIG.user,
      password: FTP_CONFIG.password,
      secure: true,
    });
    console.log('✅ Conectado\n');
    
    console.log('📤 Re-enviando arquivos críticos para forçar recompilação...');
    
    // Re-enviar VERSION.json com timestamp novo
    const versionPath = path.join(PROJECT_ROOT, 'theme-deploy-corrigido', 'VERSION.json');
    const layoutPath = path.join(PROJECT_ROOT, 'theme-deploy-corrigido', 'layouts', 'layout.tpl');
    
    await client.uploadFrom(versionPath, 'theme-deploy-corrigido/VERSION.json');
    console.log('  ✅ VERSION.json re-enviado');
    
    await client.uploadFrom(layoutPath, 'theme-deploy-corrigido/layouts/layout.tpl');
    console.log('  ✅ layout.tpl re-enviado');
    
    console.log('\n✅ Cache busting concluído!');
    console.log('   O Nuvemshop vai recompilar o tema na próxima requisição');
    console.log('   Aguarde 30-60 segundos antes de testar a loja');
    
    client.close();
    process.exit(0);
  } catch (err) {
    console.error('❌ Erro:', err.message);
    client.close();
    process.exit(1);
  }
})();
