#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

async function upload() {
  const client = new Client();

  try {
    console.log('🔗 Conectando ao FTP...');
    await client.access({
      host: FTP_CONFIG.host,
      user: FTP_CONFIG.user,
      password: FTP_CONFIG.password,
      secure: true,
    });
    console.log('✅ Conectado ao FTP\n');

    const filesToUpload = [
      { local: 'theme-deploy-corrigido/snipplets/header/header-patagang.tpl', remote: '/snipplets/header/header-patagang.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/header/header-advertising.tpl', remote: '/snipplets/header/header-advertising.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/header/header.tpl', remote: '/snipplets/header/header.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/header/header-search.tpl', remote: '/snipplets/header/header-search.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/header/header-search-results.tpl', remote: '/snipplets/header/header-search-results.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/header/header-utilities.tpl', remote: '/snipplets/header/header-utilities.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/banner-services/banner-services.tpl', remote: '/snipplets/banner-services/banner-services.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/banner-services/banner-services-item.tpl', remote: '/snipplets/banner-services/banner-services-item.tpl' },
    ];

    console.log('📤 Uploadando 8 arquivos restaurados:\n');

    for (const file of filesToUpload) {
      const fullPath = path.join(__dirname, '..', file.local);
      if (fs.existsSync(fullPath)) {
        await client.uploadFrom(fullPath, file.remote);
        const size = (fs.statSync(fullPath).size / 1024).toFixed(2);
        console.log(`   ✅ ${file.remote} (${size} KB)`);
      }
    }

    console.log('\n✅ Upload concluído com sucesso!');

  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  } finally {
    client.close();
  }
}

upload();
