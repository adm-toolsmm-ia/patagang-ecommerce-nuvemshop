#!/usr/bin/env node
const Client = require('basic-ftp').Client;
const fs = require('fs');
const path = require('path');
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
    
    // Baixar o arquivo para verificar
    console.log('📥 Baixando layout.tpl do FTP para verificação...');
    const remoteFile = 'theme-deploy-corrigido/layouts/layout.tpl';
    const tempFile = '/tmp/layout-ftp.tpl';
    
    await client.downloadTo(tempFile, remoteFile);
    console.log('✅ Arquivo baixado\n');
    
    // Verificar conteúdo
    const content = fs.readFileSync(tempFile, 'utf-8');
    const lines = content.split('\n');
    
    // Procurar por linhas problemáticas
    console.log('🔍 Verificando sintaxe Jinja2...\n');
    
    let hasErrors = false;
    
    // Linha com style-colors
    const line30 = lines.find((l, i) => i === 29 && l.includes('style-colors'));
    console.log(`Linha 30 (style-colors):`);
    console.log(`  ${line30 || 'NÃO ENCONTRADA'}`);
    if (line30 && !line30.includes('| static_url')) {
      console.log(`  ❌ ERRO: Falta | static_url`);
      hasErrors = true;
    } else if (line30) {
      console.log(`  ✅ OK`);
    }
    
    // Linha com style-async
    const asyncLines = lines.filter(l => l.includes('style-async') && l.includes('href'));
    console.log(`\nLinhas com style-async:`);
    asyncLines.forEach(l => {
      console.log(`  ${l}`);
      if (!l.includes('| static_url')) {
        console.log(`  ❌ ERRO: Falta | static_url`);
        hasErrors = true;
      } else {
        console.log(`  ✅ OK`);
      }
    });
    
    // Linha com style-blog
    const blogLines = lines.filter(l => l.includes('style-blog') && l.includes('href'));
    console.log(`\nLinhas com style-blog:`);
    blogLines.forEach(l => {
      console.log(`  ${l}`);
      if (!l.includes('| static_url')) {
        console.log(`  ❌ ERRO: Falta | static_url`);
        hasErrors = true;
      } else {
        console.log(`  ✅ OK`);
      }
    });
    
    // Verificar if há }} não fechado
    console.log(`\n🔍 Verificando fechamento de tags Jinja2...`);
    const brokenJinja = lines.filter(l => l.includes('{{') && !l.includes('}}'));
    if (brokenJinja.length > 0) {
      console.log(`❌ ENCONTRADOS ${brokenJinja.length} tags {{ sem fechamento:}`);
      brokenJinja.slice(0, 5).forEach(l => console.log(`  ${l}`));
      hasErrors = true;
    } else {
      console.log(`✅ Todas as tags {{ estão fechadas`);
    }
    
    console.log(`\n${hasErrors ? '❌ ARQUIVO COM ERROS' : '✅ ARQUIVO CORRETO'}`);
    
    fs.unlinkSync(tempFile);
    client.close();
    process.exit(hasErrors ? 1 : 0);
  } catch (err) {
    console.error('❌ Erro:', err.message);
    client.close();
    process.exit(1);
  }
})();
