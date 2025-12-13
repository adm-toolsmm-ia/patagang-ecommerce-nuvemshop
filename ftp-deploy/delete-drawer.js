#!/usr/bin/env node
/**
 * Delete navigation-drawer.tpl from FTP server
 */

const ftp = require('basic-ftp');
const { FTP_CONFIG } = require('./config.js');

async function deleteDrawer() {
    const client = new ftp.Client();
    client.ftp.verbose = true;

    try {
        console.log('Conectando ao FTP...');
        await client.access({
            host: FTP_CONFIG.host,
            user: FTP_CONFIG.user,
            password: FTP_CONFIG.password,
            secure: true
        });

        console.log('Conectado! Deletando navigation-drawer.tpl...');

        const filePath = '/snipplets/navigation/navigation-drawer.tpl';

        try {
            await client.remove(filePath);
            console.log('✓ Arquivo deletado com sucesso!');
        } catch (err) {
            if (err.code === 550) {
                console.log('⚠ Arquivo não existe no servidor (já foi removido)');
            } else {
                throw err;
            }
        }

    } catch (err) {
        console.error('Erro:', err.message);
        process.exit(1);
    } finally {
        client.close();
    }
}

deleteDrawer();
