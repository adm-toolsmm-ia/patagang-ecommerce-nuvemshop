const Client = require('basic-ftp');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

const FTP_CONFIG = {
  host: process.env.FTP_HOST,
  user: process.env.FTP_USER,
  password: process.env.FTP_PASS,
  port: parseInt(process.env.FTP_PORT || '21'),
};

async function uploadFile() {
  const client = new Client();
  try {
    await client.access(FTP_CONFIG);
    console.log('✅ Conectado ao FTP');

    const localFile = 'theme-deploy-corrigido/static/css/style-async.scss.tpl';
    const remoteFile = '/theme-deploy-corrigido/static/css/style-async.scss.tpl';

    await client.uploadFrom(fs.createReadStream(localFile), remoteFile);
    console.log(`✅ Arquivo enviado: ${remoteFile}`);

    await client.logout();
  } catch (err) {
    console.error('❌ Erro ao fazer upload:', err.message);
  }
}

uploadFile();
