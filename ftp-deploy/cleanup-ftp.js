#!/usr/bin/env node

const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

async function cleanup() {
  const client = new Client();

  try {
    console.log('🔗 Conectando ao FTP...');
    await client.access({
      host: FTP_CONFIG.host,
      user: FTP_CONFIG.user,
      password: FTP_CONFIG.password,
      secure: true,
    });

    console.log('✅ Conectado ao FTP');
    console.log('\n🗑️  Removendo arquivos desincronizados...\n');

    const filesToDelete = [
      'theme-deploy-corrigido/layouts/layout.tpl.backup-whatsapp-css-impl',
      'theme-deploy-corrigido/layouts/layout.tpl.backup.v1.5.133',
      'theme-deploy-corrigido/static/checkout.scss.tpl.backup-20260109-215632',
      'theme-deploy-corrigido/static/css/style-async.scss.tpl.backup',
      'theme-deploy-corrigido/static/css/style-async.scss.tpl.corrupted',
      'theme-deploy-corrigido/static/css/style-critical.tpl.backup',
      'theme-deploy-corrigido/static/css/style-critical.tpl.backup-2a',
      'theme-deploy-corrigido/static/css/style-critical.tpl.backup-8.2',
      'theme-deploy-corrigido/static/css/style-critical.tpl.pre-extraction',
      'theme-deploy-corrigido/static/css/style-critical.tpl.corrupted-5271',
      'theme-deploy-corrigido/static/js/store.js.tpl.backup.v1.5.76',
      'theme-deploy-corrigido/static/js/store.js.tpl.backup.v1.5.77.phase2',
    ];

    for (const file of filesToDelete) {
      try {
        await client.remove(file);
        console.log(`  ✅ Deletado: ${file}`);
      } catch (err) {
        if (err.message.includes('550')) {
          console.log(`  ⚠️  Arquivo não encontrado: ${file}`);
        } else {
          throw err;
        }
      }
    }

    console.log('\n📊 Limpeza FTP concluída!');

  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  } finally {
    client.close();
  }
}

cleanup();
