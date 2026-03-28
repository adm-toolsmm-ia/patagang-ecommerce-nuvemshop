#!/usr/bin/env node
/**
 * Deploy Completo de TODOS os Arquivos CSS
 * Sincroniza: static/css/ completo
 * Propósito: Restaurar arquivos CSS faltantes (style-async.scss.tpl, etc)
 */

const ftp = require('basic-ftp');
const fs = require('fs');
const path = require('path');

const FTP_CONFIG = {
    host: 'ftp.nuvemshop.com.br',
    port: 21,
    user: 'patagang',
    password: 'Q88gP0Ud',
    secure: true
};

const LOCAL_CSS_DIR = path.join(__dirname, '../theme-deploy-corrigido/static/css');
const REMOTE_CSS_DIR = 'static/css';

console.log('🚀 DEPLOY COMPLETO — TODOS OS ARQUIVOS CSS');
console.log('━'.repeat(70));
console.log(`📁 Local: ${LOCAL_CSS_DIR}`);
console.log(`📁 FTP: ${REMOTE_CSS_DIR}`);
console.log();

async function main() {
    const client = new ftp.Client();
    client.ftp.verbose = false;

    try {
        // Listar arquivos CSS locais
        const localFiles = fs.readdirSync(LOCAL_CSS_DIR).filter(f =>
            f.endsWith('.scss.tpl') || f.endsWith('.css') || f.endsWith('.scss')
        );

        console.log(`📊 Arquivos CSS encontrados localmente: ${localFiles.length}`);
        localFiles.forEach(f => console.log(`   ✓ ${f}`));
        console.log();

        // Conectar ao FTP
        console.log('🔐 Conectando ao FTP...');
        await client.access({
            host: FTP_CONFIG.host,
            port: FTP_CONFIG.port,
            user: FTP_CONFIG.user,
            password: FTP_CONFIG.password,
            secure: true
        });
        console.log('✅ Conectado!');
        console.log();

        // Deploy cada arquivo CSS
        console.log('⬆️  Iniciando upload de arquivos CSS...');
        console.log();

        let successCount = 0;
        let failCount = 0;

        for (const file of localFiles) {
            const localPath = path.join(LOCAL_CSS_DIR, file);
            const remotePath = `${REMOTE_CSS_DIR}/${file}`;

            try {
                process.stdout.write(`   ⬆️  ${file}... `);

                const startTime = Date.now();
                await client.uploadFrom(localPath, remotePath);
                const duration = ((Date.now() - startTime) / 1000).toFixed(2);

                const fileSize = (fs.statSync(localPath).size / 1024).toFixed(1);
                console.log(`✅ (${fileSize}KB, ${duration}s)`);
                successCount++;
            } catch (err) {
                console.log(`❌ ERRO: ${err.message}`);
                failCount++;
            }
        }

        console.log();
        console.log('━'.repeat(70));
        console.log(`✅ UPLOAD CONCLUÍDO`);
        console.log(`   Sucesso: ${successCount}/${localFiles.length}`);
        if (failCount > 0) {
            console.log(`   Falhas: ${failCount}`);
        }
        console.log();

        // Verificar arquivos críticos no FTP
        console.log('🔍 Verificando arquivos críticos no FTP...');
        const ftpList = await client.list(REMOTE_CSS_DIR);
        const critical = ['style-async.scss.tpl', 'style-critical.tpl', 'style-colors.scss.tpl'];

        for (const file of critical) {
            const found = ftpList.find(f => f.name === file);
            if (found) {
                console.log(`   ✅ ${file} (${(found.size / 1024).toFixed(1)}KB)`);
            } else {
                console.log(`   ❌ ${file} NÃO ENCONTRADO!`);
            }
        }

        console.log();
        console.log('━'.repeat(70));
        console.log('✅ DEPLOY DE CSS COMPLETO COM SUCESSO!');
        console.log();
        console.log('📋 Próximos passos:');
        console.log('   1. Aguarde 30-60 segundos para cache Nuvemshop atualizar');
        console.log('   2. Limpe cache do navegador: Ctrl+Shift+Del');
        console.log('   3. Acesse patagang.com.br e verifique se CSS carrega');
        console.log('   4. Abra console (F12) e procure por erros');
        console.log();

    } catch (error) {
        console.error(`\n❌ ERRO CRÍTICO: ${error.message}`);
        process.exit(1);
    } finally {
        client.close();
    }
}

main().catch(console.error);
