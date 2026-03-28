const Client = require('basic-ftp').Client;
const { FTP_CONFIG } = require('./config');

async function checkLayouts() {
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
    
    console.log('📂 Verificando layouts/:');
    try {
      const files = await client.list('/theme-deploy-corrigido/layouts/');
      console.log(`Total de arquivos: ${files.length}\n`);
      files.slice(0, 20).forEach(f => {
        console.log(`  ${f.isFile ? '📄' : '📁'} ${f.name}`);
      });
      if (files.length > 20) console.log(`  ... e mais ${files.length - 20}`);
    } catch (e) {
      console.log(`  ❌ Erro: ${e.code} - ${e.message.substring(0, 60)}`);
    }

  } catch (err) {
    console.error('❌ Conexão FTP falhou:', err.message);
  } finally {
    client.close();
  }
}

checkLayouts();
