#!/usr/bin/env node

/**
 * FIX CRITICAL ISSUES
 * 1. Atualizar /static/js/version-info.js para v1.1.4
 * 2. Remover arquivo antigo para evitar conflitos
 */

const fs = require('fs');
const path = require('path');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

async function fixCriticalIssues() {
  const client = new Client();

  console.log('\n╔════════════════════════════════════════════════════════╗');
  console.log('║           CORRIGINDO PROBLEMAS CRÍTICOS                ║');
  console.log('╚════════════════════════════════════════════════════════╝\n');

  try {
    await client.access(FTP_CONFIG);
    console.log('✓ Conectado ao FTP\n');

    // 1. Atualizar /static/js/version-info.js
    console.log('📤 ETAPA 1: Atualizando arquivo antigo...\n');
    
    const localPath = path.join(__dirname, '../theme-deploy-corrigido/static/js/version-info.js');
    const remotePath = '/static/js/version-info.js';
    
    await client.uploadFrom(localPath, remotePath);
    console.log(`  ✓ Enviado: ${remotePath} com v1.1.4\n`);

    // 2. Verificar ambos os arquivos
    console.log('🔍 ETAPA 2: Verificando ambos os arquivos...\n');
    
    const paths = [
      '/theme/static/js/version-info.js',
      '/static/js/version-info.js'
    ];

    for (const rPath of paths) {
      try {
        const tempFile = `/tmp/verify-${Date.now()}-${rPath.replace(/\//g, '-')}.js`;
        await client.downloadTo(tempFile, rPath);
        const content = fs.readFileSync(tempFile, 'utf-8');
        const version = content.match(/const VERSION = "([^"]+)"/)?.[1] || 'NÃO ENCONTRADA';
        console.log(`  ✓ ${rPath}`);
        console.log(`    Versão: ${version}\n`);
        fs.unlinkSync(tempFile);
      } catch (err) {
        console.log(`  ✗ ${rPath} — ${err.message}\n`);
      }
    }

    // 3. Relatório CSS
    console.log('📊 ETAPA 3: Análise de Performance CSS\n');
    
    const styleFile = path.join(__dirname, '../theme-deploy-corrigido/static/css/style-critical.tpl');
    const stats = fs.statSync(styleFile);
    const sizeKb = (stats.size / 1024).toFixed(2);
    
    console.log(`  CSS Crítico: ${sizeKb} KB (limite: 50 KB)`);
    
    if (stats.size > 50000) {
      console.log(`  ⚠️  ACIMA DO LIMITE! Excesso: ${(stats.size - 50000) / 1024} KB\n`);
      console.log(`  Recomendações para reduzir tamanho:\n`);
      
      // Ler arquivo e analisar
      const content = fs.readFileSync(styleFile, 'utf-8');
      
      // Verificar duplicações
      const rules = content.match(/\{[^}]+\}/g) || [];
      console.log(`  1. Total de regras CSS: ${rules.length}`);
      console.log(`  2. Procurar por: media queries duplicadas`);
      console.log(`  3. Procurar por: classes não utilizadas`);
      console.log(`  4. Minificar CSS (remove espaços/comentários)`);
      console.log(`  5. Remover cores/fonts não usadas\n`);
    }

    console.log('\n✅ CORREÇÃO CONCLUÍDA!\n');
    console.log('Próximos passos:');
    console.log('1. Aguarde 2-5 min para Nuvemshop regenerar cache');
    console.log('2. Limpe cache do navegador (Ctrl+Shift+Del)');
    console.log('3. Recarregue: deve mostrar v1.1.4 no console');
    console.log('4. Otimizar CSS para < 50 KB (urgente!)\n');

    await client.close();
    process.exit(0);

  } catch (err) {
    console.error('❌ ERRO:', err.message);
    process.exit(1);
  }
}

fixCriticalIssues();
