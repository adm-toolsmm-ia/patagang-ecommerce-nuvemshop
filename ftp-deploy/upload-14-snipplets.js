#!/usr/bin/env node

const Client = require('basic-ftp').Client;
const fs = require('fs');
const path = require('path');
const { FTP_CONFIG } = require('./config');

const FILES = [
  'snipplets/blog/blog-post-item.tpl',
  'snipplets/placeholders/button-placeholder.tpl',
  'snipplets/placeholders/product-detail-image-placeholder.tpl',
  'snipplets/placeholders/shipping-placeholder.tpl',
  'snipplets/social/social-footer.tpl',
  'snipplets/social/social-links.tpl',
  'snipplets/social/social-share.tpl',
  'snipplets/svg/trash-alt.tpl',
  'snipplets/svg/truck.tpl',
  'snipplets/svg/twitter.tpl',
  'snipplets/svg/usd-circle.tpl',
  'snipplets/svg/user.tpl',
  'snipplets/svg/whatsapp.tpl',
  'snipplets/svg/youtube.tpl',
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
    
    let count = 0;
    for (const file of FILES) {
      const localPath = path.join(__dirname, '..', 'theme-deploy-corrigido', file);
      const remotePath = '/' + file.replace(/\/g, '/');
      const remoteDir = remotePath.substring(0, remotePath.lastIndexOf('/'));
      
      try {
        if (!fs.existsSync(localPath)) {
          console.log(`⚠️  ARQUIVO NÃO EXISTE: ${localPath}`);
          continue;
        }
        
        await client.ensureDir(remoteDir);
        await client.uploadFrom(fs.createReadStream(localPath), remotePath);
        const size = fs.statSync(localPath).size;
        console.log(`✅ ${remotePath} (${(size/1024).toFixed(2)} KB)`);
        count++;
      } catch (err) {
        console.error(`❌ Erro ao upload ${file}: ${err.message}`);
      }
    }
    
    console.log(`\n✅ Upload completo! ${count}/${FILES.length} arquivos`);
  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  } finally {
    client.close();
  }
}

upload();
