#!/usr/bin/env node
/**
 * Forçar Recompilação SCSS — Invalidar Cache do Nuvemshop
 * Adiciona timestamp ao arquivo para mudar hash
 */

const fs = require('fs');
const path = require('path');

const files = [
    'C:\\Users\\Gabriel Cristofolini\\Documents\\SOLUCOESSISTEMAS\\patagang-ecommerce-nuvemshop\\theme-deploy-corrigido\\static\\css\\style-async.scss.tpl',
    'C:\\Users\\Gabriel Cristofolini\\Documents\\SOLUCOESSISTEMAS\\patagang-ecommerce-nuvemshop\\theme-deploy-corrigido\\static\\css\\style-critical.tpl'
];

console.log('🔄 FORÇANDO RECOMPILAÇÃO SCSS — Invalidando Cache Nuvemshop');
console.log('━'.repeat(70));

const timestamp = new Date().toISOString();

for (const file of files) {
    console.log(`\n📝 ${path.basename(file)}`);

    try {
        let content = fs.readFileSync(file, 'utf8');

        // Se já tem timestamp, remover (para não duplicar)
        content = content.replace(/\/\* CACHE BUSTING:.*?\*\//s, '');

        // Adicionar novo timestamp/cache busting no início
        const bustingComment = `/* CACHE BUSTING: ${timestamp} */\n`;
        content = bustingComment + content;

        fs.writeFileSync(file, content, 'utf8');
        console.log(`   ✅ Timestamp adicionado`);
        console.log(`   ℹ️  Timestamp: ${timestamp}`);

    } catch (err) {
        console.error(`   ❌ ERRO: ${err.message}`);
    }
}

console.log('\n' + '━'.repeat(70));
console.log('✅ CACHE BUSTING ADICIONADO!');
console.log('\n📋 Próximos passos:');
console.log('   1. Fazer deploy dos arquivos modificados');
console.log('   2. Nuvemshop vai detectar mudança e recompilar SCSS');
console.log('   3. CSS compilado vai ter novo hash');
console.log('   4. Cache será invalidado automaticamente');
console.log();
