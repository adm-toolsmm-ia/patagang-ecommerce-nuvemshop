#!/usr/bin/env node

const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

async function listFiles() {
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

    // Listar arquivos na pasta layouts
    console.log('📂 Listando arquivos em /theme-deploy-corrigido/layouts/:\n');
    const layoutFiles = await client.list('/theme-deploy-corrigido/layouts/');
    layoutFiles.forEach(file => {
      if (file.isFile && (file.name.includes('backup') || file.name.includes('corrupted'))) {
        console.log(`  ${file.name} (${file.size} bytes)`);
      }
    });

    // Listar arquivos na pasta static/css
    console.log('\n📂 Listando backups em /theme-deploy-corrigido/static/css/:\n');
    const cssFiles = await client.list('/theme-deploy-corrigido/static/css/');
    cssFiles.forEach(file => {
      if (file.isFile && (file.name.includes('backup') || file.name.includes('corrupted'))) {
        console.log(`  ${file.name} (${file.size} bytes)`);
      }
    });

    // Listar arquivos na pasta static/js
    console.log('\n📂 Listando backups em /theme-deploy-corrigido/static/js/:\n');
    const jsFiles = await client.list('/theme-deploy-corrigido/static/js/');
    jsFiles.forEach(file => {
      if (file.isFile && (file.name.includes('backup') || file.name.includes('corrupted'))) {
        console.log(`  ${file.name} (${file.size} bytes)`);
      }
    });

  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  } finally {
    client.close();
  }
}

listFiles();
