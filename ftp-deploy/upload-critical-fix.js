#!/usr/bin/env node
/**
 * Upload de Arquivo Crítico — style-critical.tpl
 * Solução rápida para erro CSS na loja
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

const FILE_TO_UPLOAD = path.join(__dirname, '../theme-deploy-corrigido/static/css/style-critical.tpl');
const REMOTE_PATH = 'static/css/style-critical.tpl';

console.log('🚀 UPLOAD CRÍTICO — style-critical.tpl');
console.log('━'.repeat(60));

async function main() {
    const client = new ftp.Client();
    client.ftp.verbose = false;

    try {
        // Validar arquivo local
        if (!fs.existsSync(FILE_TO_UPLOAD)) {
            throw new Error(`Arquivo não encontrado: ${FILE_TO_UPLOAD}`);
        }

        const fileStats = fs.statSync(FILE_TO_UPLOAD);
        console.log(`📁 Arquivo local: ${path.basename(FILE_TO_UPLOAD)}`);
        console.log(`📊 Tamanho: ${(fileStats.size / 1024).toFixed(1)} KB`);
        console.log(`🔄 Linhas: ${fs.readFileSync(FILE_TO_UPLOAD, 'utf8').split('\n').length}`);
        console.log();

        // Conectar ao FTP
        console.log(`🔐 Conectando a ${FTP_CONFIG.host}...`);
        await client.access({
            host: FTP_CONFIG.host,
            port: FTP_CONFIG.port,
            user: FTP_CONFIG.user,
            password: FTP_CONFIG.password,
            secure: true
        });
        console.log('✅ Conectado!');
        console.log();

        // Fazer backup do arquivo existente no FTP (se houver)
        try {
            console.log(`📦 Fazendo backup do arquivo existente no FTP...`);
            const backupRemote = `${REMOTE_PATH}.backup-${new Date().toISOString().split('T')[0]}`;
            await client.rename(REMOTE_PATH, backupRemote);
            console.log(`✅ Backup criado: ${backupRemote}`);
        } catch (err) {
            if (err.code === 550) {
                console.log(`ℹ️  Arquivo não existe no FTP (primeira vez) — prosseguindo`);
            } else {
                throw err;
            }
        }

        console.log();

        // Upload do arquivo
        console.log(`⬆️  Fazendo upload de ${path.basename(FILE_TO_UPLOAD)}...`);
        const startTime = Date.now();
        await client.uploadFrom(FILE_TO_UPLOAD, REMOTE_PATH);
        const duration = ((Date.now() - startTime) / 1000).toFixed(2);

        console.log(`✅ Upload concluído em ${duration}s`);
        console.log();

        // Verificar arquivo no FTP
        console.log(`🔍 Verificando arquivo no FTP...`);
        const list = await client.list('static/css');
        const uploadedFile = list.find(f => f.name === 'style-critical.tpl');

        if (uploadedFile) {
            console.log(`✅ Arquivo encontrado no FTP!`);
            console.log(`   Nome: ${uploadedFile.name}`);
            console.log(`   Tamanho: ${(uploadedFile.size / 1024).toFixed(1)} KB`);
            console.log(`   Modificado: ${uploadedFile.modifiedAt}`);
        } else {
            throw new Error('Arquivo não encontrado no FTP após upload!');
        }

        console.log();
        console.log('━'.repeat(60));
        console.log('✅ UPLOAD CONCLUÍDO COM SUCESSO!');
        console.log();
        console.log('📋 Próximos passos:');
        console.log('   1. Acessar patagang.com.br');
        console.log('   2. Limpar cache do navegador (Ctrl+Shift+Del)');
        console.log('   3. Verificar se CSS carrega corretamente');
        console.log('   4. Testar em desktop, tablet e mobile');
        console.log();

    } catch (error) {
        console.error(`\n❌ ERRO: ${error.message}`);
        process.exit(1);
    } finally {
        client.close();
    }
}

main().catch(console.error);
