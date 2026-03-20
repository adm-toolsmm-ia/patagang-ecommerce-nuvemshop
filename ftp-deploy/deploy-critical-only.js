#!/usr/bin/env node
const ftp = require('basic-ftp');
const fs = require('fs');
const path = require('path');
const { FTP_CONFIG, DIRS } = require('./config.js');

const FILES_TO_DEPLOY = [
    { local: '../theme-deploy-corrigido/layouts/layout.tpl', remote: '/layouts/layout.tpl' },
    { local: '../theme-deploy-corrigido/static/js/version-info.js', remote: '/static/js/version-info.js' }
];

async function deployCriticalFiles() {
    const client = new ftp.Client();
    client.ftp.timeout = 300000;

    try {
        console.log('🚀 Deploy CRITICAL ONLY - 2 arquivos');
        await client.access({
            host: FTP_CONFIG.host,
            port: FTP_CONFIG.port,
            user: FTP_CONFIG.user,
            password: FTP_CONFIG.password,
            secure: true,
            secureOptions: { rejectUnauthorized: false }
        });
        console.log('✅ Conectado ao FTP');

        for (const file of FILES_TO_DEPLOY) {
            const localPath = path.join(__dirname, file.local);
            const remotePath = file.remote;

            if (!fs.existsSync(localPath)) {
                console.log(`❌ Arquivo não existe: ${localPath}`);
                continue;
            }

            try {
                await client.uploadFrom(fs.createReadStream(localPath), remotePath);
                console.log(`✅ Enviado: ${remotePath}`);
            } catch (err) {
                console.log(`❌ Erro ao enviar ${remotePath}: ${err.message}`);
            }
        }

        console.log('✨ Deploy concluído!');
    } catch (err) {
        console.error('Erro geral:', err.message);
    } finally {
        client.close();
    }
}

deployCriticalFiles();
