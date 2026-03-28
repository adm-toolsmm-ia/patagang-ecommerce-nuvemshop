#!/usr/bin/env node

const Client = require('basic-ftp').Client;
const fs = require('fs');
const path = require('path');
const { FTP_CONFIG } = require('./config');

async function syncAllFiles() {
  const client = new Client();

  try {
    console.log('🔗 Conectando ao FTP...');
    await client.access({
      host: FTP_CONFIG.host,
      user: FTP_CONFIG.user,
      password: FTP_CONFIG.password,
      secure: true,
    });

    console.log('✅ Conectado ao FTP');
    console.log('
📦 SINCRONIZANDO TODOS OS ARQUIVOS DO TEMA
');

    const getAllFiles = (dir) => {
      let files = [];
      const items = fs.readdirSync(dir);
      items.forEach(item => {
        const fullPath = path.join(dir, item);
        const stat = fs.statSync(fullPath);
        if (stat.isDirectory()) {
          files = files.concat(getAllFiles(fullPath));
        } else {
          files.push(fullPath);
        }
      });
      return files;
    };

    const localFiles = getAllFiles('theme-deploy-corrigido');
    console.log(`📊 Total: ${localFiles.length}
`);

    let uploaded = 0, skipped = 0;

    for (const localFile of localFiles) {
      const ftpPath = '/' + localFile.split(path.sep).join('/');
      const dir = ftpPath.substring(0, ftpPath.lastIndexOf('/'));
      try {
        await client.ensureDir(dir);
        await client.uploadFrom(localFile, ftpPath);
        console.log(`✅ ${ftpPath}`);
        uploaded++;
      } catch (err) {
        console.log(`⚠️  ${ftpPath}: ${err.message.substring(0, 60)}`);
        skipped++;
      }
    }

    console.log('
' + '='.repeat(80));
    console.log('✅ SYNC COMPLETO');
    console.log('='.repeat(80));
    console.log(`📤 Enviados: ${uploaded} | ⚠️  Erros: ${skipped}`);

  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  } finally {
    client.close();
  }
}

syncAllFiles();