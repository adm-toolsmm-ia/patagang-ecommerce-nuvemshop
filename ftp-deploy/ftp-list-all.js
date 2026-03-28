const ftp = require('basic-ftp');

async function listFiles() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: 'ftp.nuvemshop.com.br',
            user: 'patagang',
            password: 'cqLidGTH',
            secure: true
        });
        
        console.log('--- ROOT ---');
        console.log(await client.list('/'));
        
        console.log('\n--- static/css ---');
        console.log(await client.list('/static/css'));
        
    } catch (err) {
        console.error('Error:', err);
    } finally {
        client.close();
    }
}
listFiles();
