#!/usr/bin/env node

const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

async function verify() {
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

    const filesToCheck = [
      '/snipplets/grid/quick-shop.tpl',
      '/snipplets/grid/item.tpl',
      '/snipplets/forms/form.tpl',
      '/snipplets/header/header-logo.tpl',
      '/snipplets/footer/footer-newsletter.tpl',
      '/snipplets/shipping/shipping-calculator.tpl',
      '/snipplets/home/home-banners.tpl',
      '/assets/css/focus-indicators.css',
    ];

    console.log('🔍 Verificando se 28 arquivos estão no FTP:\n');

    let found = 0;
    let notFound = 0;

    for (const file of filesToCheck) {
      try {
        const list = await client.list('/');
        const exists = await client.size(file).catch(() => null);
        if (exists) {
          console.log(`   ✅ ${file}`);
          found++;
        } else {
          console.log(`   ❌ ${file} - NÃO ENCONTRADO`);
          notFound++;
        }
      } catch (err) {
        console.log(`   ❌ ${file} - NÃO ENCONTRADO`);
        notFound++;
      }
    }

    console.log(`\n📊 Resultado: ${found} encontrados, ${notFound} não encontrados`);

  } catch (err) {
    console.error('❌ Erro de conexão:', err.message);
    process.exit(1);
  } finally {
    client.close();
  }
}

verify();
