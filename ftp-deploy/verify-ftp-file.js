#!/usr/bin/env node

const Client = require('basic-ftp').Client;
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const { FTP_CONFIG } = require('./config');

async function verifyFile() {
  const client = new Client();
  const localFile = 'theme-deploy-corrigido/static/css/style-async.scss.tpl';
  const ftpPath = '/theme-deploy-corrigido/static/css/style-async.scss.tpl';

  try {
    console.log('🔗 Conectando ao FTP...');
    await client.access({
      host: FTP_CONFIG.host,
      user: FTP_CONFIG.user,
      password: FTP_CONFIG.password,
      secure: true,
    });

    console.log('✅ Conectado ao FTP\n');

    // 1. Verificar tamanho no FTP
    console.log('📊 COMPARAÇÃO DE ARQUIVO\n');
    const ftpList = await client.list(path.dirname(ftpPath));
    const ftpFile = ftpList.find(f => f.name === 'style-async.scss.tpl');
    
    if (!ftpFile) {
      console.log('❌ Arquivo NÃO encontrado no FTP!');
      process.exit(1);
    }

    // 2. Ler arquivo local
    const localContent = fs.readFileSync(localFile, 'utf8');
    const localSize = Buffer.byteLength(localContent, 'utf8');
    const localMD5 = crypto.createHash('md5').update(localContent).digest('hex');

    console.log('📄 ARQUIVO LOCAL:');
    console.log(`   Tamanho: ${localSize} bytes`);
    console.log(`   MD5: ${localMD5}`);
    console.log(`   Última linha: ${localContent.split('\n').pop()?.substring(0, 60)}`);

    console.log('\n📄 ARQUIVO FTP:');
    console.log(`   Tamanho: ${ftpFile.size} bytes`);
    console.log(`   Modificado: ${ftpFile.modifiedAt}`);

    // 3. Comparar tamanhos
    if (localSize === ftpFile.size) {
      console.log('\n✅ Tamanhos IGUAIS');
    } else {
      console.log(`\n❌ Tamanhos DIFERENTES! Local: ${localSize}, FTP: ${ftpFile.size}`);
      console.log(`   Diferença: ${Math.abs(localSize - ftpFile.size)} bytes`);
    }

    // 4. Download e comparar conteúdo
    console.log('\n📥 Baixando arquivo do FTP para verificação...');
    const ftpContent = await client.readFile(ftpPath);
    const ftpMD5 = crypto.createHash('md5').update(ftpContent).digest('hex');

    console.log(`\n🔍 MD5 LOCAL: ${localMD5}`);
    console.log(`🔍 MD5 FTP:   ${ftpMD5}`);

    if (localMD5 === ftpMD5) {
      console.log('\n✅ ARQUIVO NO FTP ESTÁ IDÊNTICO AO LOCAL!');
      console.log('   → Problema NÃO é no arquivo.');
      console.log('   → Problema é COMPILAÇÃO/CACHE do Nuvemshop.');
    } else {
      console.log('\n❌ ARQUIVO NO FTP É DIFERENTE DO LOCAL!');
      console.log('   → FTP não foi atualizado corretamente');
      console.log('   → Precisa re-deploy');
    }

    // 5. Procurar pelo erro específico
    console.log('\n🔎 PROCURANDO PELO ERRO (content: ?|?)...');
    const contentErrors = (ftpContent.toString().match(/content:\s*\?[|?]/g) || []).length;
    
    if (contentErrors > 0) {
      console.log(`❌ ENCONTRADO: ${contentErrors} ocorrência(s) de "content:?" no FTP!`);
    } else {
      console.log('✅ NÃO ENCONTRADO "content:?" no FTP');
    }

    // 6. Verificar linha 646 especificamente
    console.log('\n📍 Verificando linha 646 (onde corrigimos)...');
    const lines = ftpContent.toString().split('\n');
    if (lines[645]) {
      const line646 = lines[645];
      console.log(`   Linha 646: "${line646.trim()}"`);
      if (line646.includes('content:')) {
        if (line646.includes("''") || line646.includes('""')) {
          console.log('   ✅ Está CORRIGIDA (content: "")');
        } else {
          console.log('   ❌ ESTÁ ERRADA (content: tem caracteres inválidos)');
        }
      }
    }

  } catch (err) {
    console.error('❌ Erro:', err.message);
    process.exit(1);
  } finally {
    client.close();
  }
}

verifyFile();
