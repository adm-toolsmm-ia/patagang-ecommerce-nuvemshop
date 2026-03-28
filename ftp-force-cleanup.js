const ftp = require("basic-ftp");
const fs = require("fs");

async function forceCleanup() {
  const client = new ftp.Client();
  
  try {
    const ftpConfig = {
      host: process.env.FTP_HOST,
      user: process.env.FTP_USER,
      password: process.env.FTP_PASSWORD,
      port: 21,
    };

    console.log("Conectando ao FTP...");
    await client.access(ftpConfig);
    
    console.log("Deletando arquivo corrompido do FTP...");
    await client.remove("/static/css/style-async.scss.tpl");
    console.log("✅ Arquivo deletado do FTP");
    
    console.log("Uploadando versão limpa...");
    await client.uploadFrom(
      fs.createReadStream("theme-deploy-corrigido/static/css/style-async.scss.tpl"),
      "/static/css/style-async.scss.tpl"
    );
    console.log("✅ Arquivo reuploaded");
    
    console.log("Validando no FTP...");
    const list = await client.list("/static/css/");
    const file = list.find(f => f.name === "style-async.scss.tpl");
    console.log(`✅ Validado: ${file.name} (${file.size} bytes)`);
    
  } finally {
    await client.close();
  }
}

forceCleanup().catch(console.error);
