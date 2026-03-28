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
      // Grid (10)
      { local: 'theme-deploy-corrigido/snipplets/grid/item.tpl', remote: '/snipplets/grid/item.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/grid/filters.tpl', remote: '/snipplets/grid/filters.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/grid/categories.tpl', remote: '/snipplets/grid/categories.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/grid/quick-shop.tpl', remote: '/snipplets/grid/quick-shop.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/grid/pagination.tpl', remote: '/snipplets/grid/pagination.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/grid/sort-by.tpl', remote: '/snipplets/grid/sort-by.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/grid/item-prices.tpl', remote: '/snipplets/grid/item-prices.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/grid/item-colors.tpl', remote: '/snipplets/grid/item-colors.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/grid/item-sizes.tpl', remote: '/snipplets/grid/item-sizes.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/grid/product-counter.tpl', remote: '/snipplets/grid/product-counter.tpl' },
      // Forms (4)
      { local: 'theme-deploy-corrigido/snipplets/forms/form.tpl', remote: '/snipplets/forms/form.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/forms/form-input.tpl', remote: '/snipplets/forms/form-input.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/forms/form-select.tpl', remote: '/snipplets/forms/form-select.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/forms/form-input-inline.tpl', remote: '/snipplets/forms/form-input-inline.tpl' },
      // Header (3)
      { local: 'theme-deploy-corrigido/snipplets/header/header-logo.tpl', remote: '/snipplets/header/header-logo.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/header/header-modals.tpl', remote: '/snipplets/header/header-modals.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/header/header-search-overlay.tpl', remote: '/snipplets/header/header-search-overlay.tpl' },
      // Footer (4)
      { local: 'theme-deploy-corrigido/snipplets/footer/footer-newsletter.tpl', remote: '/snipplets/footer/footer-newsletter.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/footer/footer-support.tpl', remote: '/snipplets/footer/footer-support.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/footer/footer-search-links.tpl', remote: '/snipplets/footer/footer-search-links.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/footer/footer-social.tpl', remote: '/snipplets/footer/footer-social.tpl' },
      // CSS (1)
      { local: 'theme-deploy-corrigido/assets/css/focus-indicators.css', remote: '/assets/css/focus-indicators.css' },
      // Shipping (5)
      { local: 'theme-deploy-corrigido/snipplets/shipping/shipping-calculator.tpl', remote: '/snipplets/shipping/shipping-calculator.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/shipping/shipping-calculator-item.tpl', remote: '/snipplets/shipping/shipping-calculator-item.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/shipping/branches.tpl', remote: '/snipplets/shipping/branches.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/shipping/shipping-free-rest.tpl', remote: '/snipplets/shipping/shipping-free-rest.tpl' },
      { local: 'theme-deploy-corrigido/snipplets/shipping_suboptions/select.tpl', remote: '/snipplets/shipping_suboptions/select.tpl' },
      // Home (1)
      { local: 'theme-deploy-corrigido/snipplets/home/home-banners.tpl', remote: '/snipplets/home/home-banners.tpl' },
    ];

    console.log('📤 Uploadando 28 arquivos:\n');

    for (const file of filesToUpload) {
      const fullPath = path.join(__dirname, '..', file.local);
      if (fs.existsSync(fullPath)) {
        await client.uploadFrom(fullPath, file.remote);
        const size = (fs.statSync(fullPath).size / 1024).toFixed(2);
        console.log(`   ✅ ${file.remote} (${size} KB)`);
      }
    }

    console.log('\n✅ Upload de 28 arquivos concluído!');

  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  } finally {
    client.close();
  }
}

upload();
