const ftp = require('basic-ftp');
const { FTP_CONFIG } = require('./config.js');

async function checkImages() {
    const client = new ftp.Client();
    client.ftp.verbose = true;

    try {
        console.log('Conectando ao FTP...');
        await client.access(FTP_CONFIG);
        console.log('Conectado!');

        const remotePath = 'static/images';
        console.log(`Listando arquivos em ${remotePath}...`);
        
        const list = await client.list(remotePath);
        
        const images = list.filter(f => f.name.startsWith('produto-'));
        
        console.log('\nArquivos encontrados:');
        images.forEach(f => {
            console.log(`- ${f.name} | Tamanho: ${f.size} bytes | Data: ${f.rawModifiedAt}`);
        });

    } catch (err) {
        console.error('Erro:', err);
    } finally {
        client.close();
    }
}

checkImages();
