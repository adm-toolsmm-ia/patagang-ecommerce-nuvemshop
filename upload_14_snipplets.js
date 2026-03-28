const Client = require('basic-ftp').Client;
const fs = require('fs');
const path = require('path');
const { FTP_CONFIG } = require('./ftp-deploy/config');

const FILES = [
  'theme-deploy-corrigido/snipplets/blog/blog-post-item.tpl',
  'theme-deploy-corrigido/snipplets/placeholders/button-placeholder.tpl',
  'theme-deploy-corrigido/snipplets/placeholders/product-detail-image-placeholder.tpl',
  'theme-deploy-corrigido/snipplets/placeholders/shipping-placeholder.tpl',
  'theme-deploy-corrigido/snipplets/social/social-footer.tpl',
  'theme-deploy-corrigido/snipplets/social/social-links.tpl',
  'theme-deploy-corrigido/snipplets/social/social-share.tpl',
  'theme-deploy-corrigido/snipplets/svg/trash-alt.tpl',
  'theme-deploy-corrigido/snipplets/svg/truck.tpl',
  'theme-deploy-corrigido/snipplets/svg/twitter.tpl',
  'theme-deploy-corrigido/snipplets/svg/usd-circle.tpl',
  'theme-deploy-corrigido/snipplets/svg/user.tpl',
  'theme-deploy-corrigido/snipplets/svg/whatsapp.tpl',
  'theme-deploy-corrigido/snipplets/svg/youtube.tpl',
];

async function upload() {
  const client = new Client();
  try {
    console.log('🔗 Conectando ao FTP...');
    await client.access({
      host: FTP_CONFIG.host,
      user: FTP_CONFIG.user,
      password: FTP_CONFIG.password,
      secure: true,
    });
    console.log('✅ Conectado\n');
    console.log('📤 Uploading 14 snipplets...\n');
    
    for (const file of FILES) {
      const localPath = file;
      const remotePath = '/' + file.replace(/\\/g, '/').replace('theme-deploy-corrigido/', '');
      const remoteDir = remotePath.substring(0, remotePath.lastIndexOf('/'));
      
      try {
        if (!fs.existsSync(localPath)) {
          console.log(`⚠️  ARQUIVO NÃO EXISTE: ${localPath}`);
          continue;
        }
        
        await client.ensureDir(remoteDir);
        await client.uploadFrom(fs.createReadStream(localPath), remotePath);
        const size = fs.statSync(localPath).size;
        console.log(`✅ ${remotePath} (${size} bytes)`);
      } catch (err) {
        console.error(`❌ Erro ao upload ${file}: ${err.message}`);
      }
    }
    
    console.log('\n✅ Upload completo!');
  } catch (err) {
    console.error('❌ Erro:', err.message);
  } finally {
    client.close();
  }
}

upload();
