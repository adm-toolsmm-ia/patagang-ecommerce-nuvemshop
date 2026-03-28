#!/usr/bin/env node

const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

async function cleanup() {
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
    console.log('\n🗑️  Removendo arquivos desincronizados...\n');

    const filesToDelete = [
      '_METADATA.json',
      '_BACKUP_METADATA.json',
    ];

    for (const file of filesToDelete) {
      try {
        await client.remove(file);
        console.log(`  ✅ Deletado: ${file}`);
      } catch (err) {
        if (err.message.includes('550')) {
          console.log(`  ⚠️  Arquivo não encontrado: ${file}`);
        } else {
          throw err;
        }
      }
    }

    console.log('\n📊 Limpeza FTP concluída!');

  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  } finally {
    client.close();
  }
}

cleanup();
