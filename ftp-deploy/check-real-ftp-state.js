const ftp = require('basic-ftp');
const fs = require('fs');

async function checkVersion() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: 'ftp.nuvemshop.com.br',
            user: 'patagang',
            password: 'cqLidGTH',
            secure: true
        });
        
        console.log('Fetching /VERSION.json...');
        await client.downloadTo('ftp-version-down.json', '/VERSION.json');
        const ftpVersion = JSON.parse(fs.readFileSync('ftp-version-down.json', 'utf-8'));
        console.log('VERSION on FTP:', ftpVersion.version);
        
        console.log('Fetching /static/js/version-info.js...');
        await client.downloadTo('ftp-version-info-down.js', '/static/js/version-info.js');
        const ftpVersionInfo = fs.readFileSync('ftp-version-info-down.js', 'utf-8');
        console.log('VERSION-INFO on FTP matches? (1.5.261):', ftpVersionInfo.includes('1.5.261'));
        
    } catch (err) {
        console.error('Error:', err);
    } finally {
        client.close();
    }
}
checkVersion();
