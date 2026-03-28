const ftp = require('basic-ftp');
const fs = require('fs');

async function test() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: 'ftp.nuvemshop.com.br',
            user: 'patagang',
            password: 'cqLidGTH',
            secure: true
        });
        console.log('Conn OK');
        
        const timestamp = Date.now().toString();
        fs.writeFileSync('ftp-test.txt', timestamp);
        
        console.log('Uploading test file...');
        await client.uploadFrom('ftp-test.txt', '/ftp-test.txt');
        console.log('Upload OK');
        
        await client.downloadTo('ftp-test-down.txt', '/ftp-test.txt');
        const downContent = fs.readFileSync('ftp-test-down.txt', 'utf-8');
        console.log('Downloaded content:', downContent);
        
        if (downContent === timestamp) {
            console.log('VERIFIED: FTP write works!');
        } else {
            console.log('FAILED: FTP content mismatch!');
        }
        
    } catch (err) {
        console.error('Error:', err);
    } finally {
        client.close();
    }
}
test();
