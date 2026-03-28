#!/usr/bin/env node

const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

async function moveBackups() {
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
    console.log('\n📦 Movendo arquivos de backup para archive...\n');

    // Criar pasta archive se não existir
    try {
      await client.ensureDir('/theme-deploy-corrigido/layouts/archive');
      console.log('📁 Pasta /archive criada/verificada');
    } catch (err) {
      console.log('ℹ️  Pasta /archive pode já existir');
    }

    const filesToMove = [
      {
        from: '/theme-deploy-corrigido/layouts/layout.tpl.backup-whatsapp-css-impl',
        to: '/theme-deploy-corrigido/layouts/archive/layout.tpl.backup-whatsapp-css-impl',
      },
      {
        from: '/theme-deploy-corrigido/layouts/layout.tpl.backup.v1.5.133',
        to: '/theme-deploy-corrigido/layouts/archive/layout.tpl.backup.v1.5.133',
      },
    ];

    for (const file of filesToMove) {
      try {
        // Tentar mover (rename)
        await client.rename(file.from, file.to);
        console.log(`✅ Movido: ${file.from} → archive/`);
      } catch (err) {
        if (err.message.includes('550')) {
          console.log(`⚠️  Arquivo não encontrado: ${file.from}`);
        } else {
          console.log(`⚠️  Erro ao mover ${file.from}: ${err.message.substring(0, 80)}`);
        }
      }
    }

    console.log('\n✅ Operação concluída!');

  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  } finally {
    client.close();
  }
}

moveBackups();
