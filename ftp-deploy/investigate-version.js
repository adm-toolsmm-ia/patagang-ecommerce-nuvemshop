#!/usr/bin/env node

/**
 * INVESTIGAÇÃO PROFUNDA - VERSIONAMENTO
 * 
 * Verifica:
 * 1. Arquivo local vs FTP
 * 2. Todos os arquivos de versão
 * 3. URLs de carregamento
 * 4. Tamanhos de arquivo
 */

const fs = require('fs');
const path = require('path');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

async function investigate() {
  console.log('\n╔════════════════════════════════════════════════════════╗');
  console.log('║      INVESTIGAÇÃO PROFUNDA - VERSIONAMENTO AIOX        ║');
  console.log('╚════════════════════════════════════════════════════════╝\n');

  // 1. Arquivos locais
  console.log('📂 ARQUIVOS LOCAIS:\n');
  
  const localFiles = [
    'theme-deploy-corrigido/VERSION.json',
    'theme-deploy-corrigido/static/js/version-info.js',
    'ftp-deploy/VERSION'
  ];

  for (const file of localFiles) {
    const fullPath = path.join(__dirname, '..', file);
    if (fs.existsSync(fullPath)) {
      const size = fs.statSync(fullPath).size;
      const content = fs.readFileSync(fullPath, 'utf-8');
      const version = content.match(/1\.\d+\.\d+/)?.[0] || 'N/A';
      console.log(`  ✓ ${file}`);
      console.log(`    Versão: ${version} | Tamanho: ${size} bytes`);
      console.log(`    Conteúdo: ${content.substring(0, 100)}...`);
    }
  }

  // 2. Conectar ao FTP
  console.log('\n\n🌐 ARQUIVOS NO FTP:\n');
  const client = new Client();
  
  try {
    await client.access(FTP_CONFIG);
    console.log('  ✓ Conectado ao FTP\n');

    // Verificar múltiplos caminhos possíveis
    const remotePaths = [
      '/theme/static/js/version-info.js',
      '/static/js/version-info.js',
      '/js/version-info.js'
    ];

    for (const remotePath of remotePaths) {
      try {
        const tempFile = `/tmp/version-check-${Date.now()}.js`;
        await client.downloadTo(tempFile, remotePath);
        
        const size = fs.statSync(tempFile).size;
        const content = fs.readFileSync(tempFile, 'utf-8');
        const version = content.match(/1\.\d+\.\d+/)?.[0] || 'N/A';
        
        console.log(`  ✓ ${remotePath} ENCONTRADO`);
        console.log(`    Versão: ${version} | Tamanho: ${size} bytes`);
        console.log(`    Conteúdo: ${content.substring(0, 100)}...`);
        
        fs.unlinkSync(tempFile);
      } catch (err) {
        console.log(`  ✗ ${remotePath} — NÃO ENCONTRADO`);
      }
    }

    // 3. Análise de CSS crítico
    console.log('\n\n📊 ANÁLISE DE PERFORMANCE:\n');
    
    const styleFile = path.join(__dirname, '../theme-deploy-corrigido/static/css/style-critical.tpl');
    if (fs.existsSync(styleFile)) {
      const stats = fs.statSync(styleFile);
      console.log(`  CSS Crítico (style-critical.tpl):`);
      console.log(`    Tamanho: ${stats.size} bytes (${(stats.size / 1024).toFixed(2)} KB)`);
      
      if (stats.size > 50000) {
        console.log(`    ⚠️  ALERTA: Acima do limite de 50KB!`);
      }
    }

    // 4. Recomendações
    console.log('\n\n💡 DIAGNÓSTICO:\n');
    console.log('  1. Query string mudando (v=20260321005146)');
    console.log('     → Nuvemshop ESTÁ regenerando cache');
    console.log('');
    console.log('  2. Versão ainda 1.1.3 no console');
    console.log('     → Arquivo NO FTP ainda pode ser 1.1.3');
    console.log('');
    console.log('  3. Possíveis causas:');
    console.log('     a) Upload não sincronizou (permissões FTP)');
    console.log('     b) Nuvemshop serv e arquivo de backup automático');
    console.log('     c) CDN Nuvemshop tem cache de 10-15 min');
    console.log('     d) Arquivo em caminho diferente no FTP');

    await client.close();

  } catch (err) {
    console.error('❌ Erro ao conectar FTP:', err.message);
  }
}

investigate();
