const ftp = require('basic-ftp');
const fs = require('fs');
const path = require('path');

const FTP_CONFIG = {
    host: 'ftp.nuvemshop.com.br',
    user: 'patagang',
    password: 'cqLidGTH',
    secure: true
};

const FILES_TO_SYNC = [
    { local: '../theme-deploy-corrigido/static/css/style-async.scss.tpl', remote: '/static/css/style-async.scss.tpl' },
    { local: '../theme-deploy-corrigido/static/css/style-critical.tpl', remote: '/static/css/style-critical.tpl' },
    { local: '../theme-deploy-corrigido/layouts/layout.tpl', remote: '/layouts/layout.tpl' },
    { local: '../theme-deploy-corrigido/VERSION.json', remote: '/VERSION.json' },
    { local: '../theme-deploy-corrigido/static/js/version-info.js', remote: '/static/js/version-info.js' }
];

async function recover() {
    console.log('🚀 INICIANDO RECUPERAÇÃO DE FORÇA BRUTA - PATAGANG');
    const client = new ftp.Client();
    client.ftp.verbose = true;

    try {
        await client.access(FTP_CONFIG);
        console.log('✅ Conectado ao FTP');

        for (const file of FILES_TO_SYNC) {
            const localPath = path.join(__dirname, file.local);
            const remotePath = file.remote;

            if (!fs.existsSync(localPath)) {
                console.error(`❌ Arquivo local não encontrado: ${localPath}`);
                continue;
            }

            console.log(`\n📦 Processando: ${remotePath}`);
            
            // 1. Tentar deletar o arquivo no servidor para limpar cache de arquivo do FTP
            try {
                await client.remove(remotePath);
                console.log(`   - Arquivo antigo removido do servidor.`);
            } catch (err) {
                console.log(`   - Aviso: Não foi possível remover (arquivo pode não existir).`);
            }

            // 2. Upload limpo
            await client.uploadFrom(localPath, remotePath);
            console.log(`   - Upload concluído com sucesso.`);
        }

        console.log('\n✨ OPERAÇÃO DE RECUPERAÇÃO CONCLUÍDA!');
        console.log('⚠️  Acesse a loja e limpe o cache do navegador (Ctrl+F5).');

    } catch (err) {
        console.error('\n❌ ERRO CRÍTICO NA RECUPERAÇÃO:', err);
    } finally {
        client.close();
    }
}

recover();
