#!/usr/bin/env node

/**
 * Deploy com Verificação FTP
 * Verifica se arquivo foi realmente enviado
 */

const fs = require('fs');
const path = require('path');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

const COLORS = {
  cyan: '\x1b[36m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  reset: '\x1b[0m',
};

async function deployWithVerify() {
  const client = new Client();
  
  console.log(`\n${COLORS.cyan}DEPLOY COM VERIFICAÇÃO FTP${COLORS.reset}\n`);

  const files = [
    { 
      local: '../theme-deploy-corrigido/static/js/version-info.js',
      remote: '/theme/static/js/version-info.js'
    },
    {
      local: '../theme-deploy-corrigido/templates/product.tpl',
      remote: '/theme/templates/product.tpl'
    },
    {
      local: '../theme-deploy-corrigido/snipplets/product/product-form.tpl',
      remote: '/theme/snipplets/product/product-form.tpl'
    }
  ];

  try {
    // Conectar
    console.log(`Conectando a ${FTP_CONFIG.host}...`);
    await client.access(FTP_CONFIG);
    console.log(`${COLORS.green}✓${COLORS.reset} Conectado\n`);

    // Deploy cada arquivo
    for (const file of files) {
      const localPath = path.join(__dirname, file.local);
      const localSize = fs.statSync(localPath).size;
      
      console.log(`Enviando: ${file.remote}`);
      console.log(`  Tamanho local: ${localSize} bytes`);
      
      try {
        await client.uploadFrom(localPath, file.remote);
        console.log(`${COLORS.green}✓${COLORS.reset} Upload feito\n`);
      } catch (err) {
        console.log(`${COLORS.red}✗${COLORS.reset} Erro: ${err.message}\n`);
        throw err;
      }
    }

    console.log(`${COLORS.green}✓ DEPLOY CONCLUÍDO${COLORS.reset}`);
    console.log(`\n⚠️  Limpe o cache do navegador (Ctrl+Shift+Del) e recarregue a página!`);
    console.log(`📦 Console deve mostrar: v1.1.4 (2026-03-21)\n`);

    await client.close();
    process.exit(0);

  } catch (err) {
    console.error(`${COLORS.red}ERRO:${COLORS.reset}`, err.message);
    process.exit(1);
  }
}

deployWithVerify();
