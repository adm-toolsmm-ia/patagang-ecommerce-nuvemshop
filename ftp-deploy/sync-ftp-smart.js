#!/usr/bin/env node

/**
 * SINCRONIZAÇÃO INTELIGENTE FTP ↔ LOCAL
 * 1. Mapeia estrutura LOCAL
 * 2. Conecta ao FTP e mapeia estrutura remota
 * 3. Compara e identifica APENAS o que falta
 * 4. Envia delta (diferença)
 * 5. Valida com comparativo final
 */

const fs = require('fs');
const path = require('path');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG, DIRS } = require('./config');

const LOCAL_THEME = path.join(__dirname, '..', 'theme-deploy-corrigido');
let localStructure = {};
let ftpStructure = {};
let uploadStats = { success: 0, failed: 0, skipped: 0 };

function log(type, msg) {
  const icons = {
    info: 'ℹ️ ',
    success: '✅',
    error: '❌',
    warning: '⚠️ ',
    compare: '🔍',
    sync: '🔄',
  };
  console.log(`${icons[type] || '•'} ${msg}`);
}

// MAP LOCAL STRUCTURE
function mapLocalStructure(dir = '', basePath = LOCAL_THEME) {
  const fullPath = path.join(basePath, dir);

  try {
    const items = fs.readdirSync(fullPath, { withFileTypes: true });

    items.forEach(item => {
      // Ignorar backup
      if (item.name === 'backup') return;
      if (item.name === '.git') return;
      if (item.name === '.env') return;

      const itemPath = path.join(dir, item.name);
      const key = itemPath.replace(/\\/g, '/');

      if (item.isDirectory()) {
        localStructure[key + '/'] = 'dir';
        mapLocalStructure(itemPath, basePath);
      } else {
        try {
          const stats = fs.statSync(path.join(basePath, itemPath));
          localStructure[key] = { type: 'file', size: stats.size };
        } catch (err) {
          // Ignorar erros de leitura
        }
      }
    });
  } catch (err) {
    // Ignorar erros de diretório
  }
}

// MAP FTP STRUCTURE
async function mapFtpStructure(client, dir = '', depth = 0) {
  if (depth > 10) return; // Proteção contra recursão

  try {
    const list = await client.list(dir);

    list.forEach(item => {
      const itemPath = dir ? `${dir}/${item.name}` : item.name;
      const key = itemPath.replace(/\\/g, '/');

      if (item.isDirectory) {
        ftpStructure[key + '/'] = 'dir';
      } else {
        ftpStructure[key] = { type: 'file', size: item.size };
      }
    });

    // Recursivamente mapear subdiretórios
    for (const item of list) {
      if (item.isDirectory) {
        const itemPath = dir ? `${dir}/${item.name}` : item.name;
        await mapFtpStructure(client, itemPath, depth + 1);
      }
    }
  } catch (err) {
    // Ignorar erros
  }
}

// ENCONTRAR GAPS (o que falta)
function findGaps() {
  const missing = {
    files: [],
    dirs: [],
  };

  for (const localItem of Object.keys(localStructure)) {
    if (!ftpStructure[localItem]) {
      if (localItem.endsWith('/')) {
        missing.dirs.push(localItem);
      } else {
        missing.files.push(localItem);
      }
    }
  }

  return missing;
}

// CRIAR DIRETÓRIOS NO FTP
async function createDirs(client, dirs) {
  for (const dir of dirs) {
    const dirPath = dir.replace(/\/$/, '');
    try {
      // Tentar criar diretório
      await client.ensureDir(dirPath);
      log('sync', `Diretório criado: ${dirPath}/`);
    } catch (err) {
      // Ignorar se já existe
    }
  }
}

// UPLOAD COM RETRY
async function uploadFile(client, localPath, remotePath, retries = 3) {
  for (let i = 0; i < retries; i++) {
    try {
      const fullLocalPath = path.join(LOCAL_THEME, localPath);
      const fileStream = fs.createReadStream(fullLocalPath);

      await client.uploadFrom(fileStream, remotePath);

      const stats = fs.statSync(fullLocalPath);
      const sizeKB = (stats.size / 1024).toFixed(2);
      log('success', `Enviado: ${remotePath} (${sizeKB} KB)`);
      uploadStats.success++;
      return true;
    } catch (err) {
      if (i === retries - 1) {
        log('error', `Falha permanente: ${remotePath} — ${err.message}`);
        uploadStats.failed++;
        return false;
      }

      // Reconectar e retry
      try {
        log('warning', `Retry ${i + 1}/${retries - 1} para ${remotePath}...`);
        await client.access(FTP_CONFIG);
      } catch (reconnectErr) {
        // Ignorar erros de reconexão
      }
    }
  }
}

// COMPARATIVO FINAL
function compareStructures() {
  const differences = {
    localOnly: [],
    ftpOnly: [],
    sizeChanged: [],
  };

  // Arquivos que estão local mas não no FTP
  for (const localItem of Object.keys(localStructure)) {
    if (typeof localStructure[localItem] === 'object' && localStructure[localItem].type === 'file') {
      if (!ftpStructure[localItem]) {
        differences.localOnly.push(localItem);
      } else if (
        typeof ftpStructure[localItem] === 'object' &&
        localStructure[localItem].size !== ftpStructure[localItem].size
      ) {
        differences.sizeChanged.push({
          file: localItem,
          local: localStructure[localItem].size,
          ftp: ftpStructure[localItem].size,
        });
      }
    }
  }

  // Arquivos que estão no FTP mas não local (não esperado, mas monitorar)
  for (const ftpItem of Object.keys(ftpStructure)) {
    if (typeof ftpStructure[ftpItem] === 'object' && ftpStructure[ftpItem].type === 'file') {
      if (!localStructure[ftpItem]) {
        differences.ftpOnly.push(ftpItem);
      }
    }
  }

  return differences;
}

async function main() {
  const client = new Client();

  try {
    log('info', '📊 SINCRONIZAÇÃO INTELIGENTE FTP ↔ LOCAL');
    log('info', '━'.repeat(50));

    log('info', '\n1️⃣  Mapeando estrutura LOCAL...');
    mapLocalStructure();
    const totalLocal = Object.keys(localStructure).length;
    const filesLocal = Object.values(localStructure).filter(v => typeof v === 'object' && v.type === 'file').length;
    log('success', `Local: ${totalLocal} itens (${filesLocal} arquivos)`);

    log('info', '\n2️⃣  Conectando ao FTP...');
    await client.access(FTP_CONFIG);
    log('success', 'Conectado ao FTP');

    log('info', '\n3️⃣  Mapeando estrutura FTP...');
    await mapFtpStructure(client);
    const totalFTP = Object.keys(ftpStructure).length;
    const filesFTP = Object.values(ftpStructure).filter(v => typeof v === 'object' && v.type === 'file').length;
    log('success', `FTP: ${totalFTP} itens (${filesFTP} arquivos)`);

    log('info', '\n4️⃣  Identificando GAPS (o que falta)...');
    const gaps = findGaps();

    if (gaps.files.length === 0 && gaps.dirs.length === 0) {
      log('success', '✨ FTP já está 100% sincronizado! Nenhum arquivo faltando.');
      log('compare', '✅ ESTRUTURAS IDÊNTICAS');
    } else {
      log('warning', `Encontrados ${gaps.files.length} arquivos + ${gaps.dirs.length} diretórios faltando:\n`);

      if (gaps.files.length > 0) {
        log('info', `📁 Arquivos faltando (${gaps.files.length}):`);
        gaps.files.slice(0, 10).forEach(f => console.log(`   - ${f}`));
        if (gaps.files.length > 10) console.log(`   ... e mais ${gaps.files.length - 10} arquivos`);
      }

      if (gaps.dirs.length > 0) {
        log('info', `\n📂 Diretórios faltando (${gaps.dirs.length}):`);
        gaps.dirs.slice(0, 5).forEach(d => console.log(`   - ${d}`));
        if (gaps.dirs.length > 5) console.log(`   ... e mais ${gaps.dirs.length - 5} diretórios`);
      }

      log('info', '\n5️⃣  Sincronizando DELTA...');

      // Criar diretórios que faltam
      if (gaps.dirs.length > 0) {
        log('info', `Criando ${gaps.dirs.length} diretórios...`);
        await createDirs(client, gaps.dirs);
      }

      // Enviar arquivos que faltam
      if (gaps.files.length > 0) {
        log('info', `Enviando ${gaps.files.length} arquivos...`);
        for (const file of gaps.files) {
          await uploadFile(client, file, file);
        }
      }

      log('success', `\n✅ Delta enviado: ${uploadStats.success} sucesso, ${uploadStats.failed} falhas`);
    }

    log('info', '\n6️⃣  VALIDAÇÃO FINAL (Re-mapeando FTP)...');
    ftpStructure = {}; // Reset FTP structure
    await mapFtpStructure(client);

    const differences = compareStructures();

    log('compare', '\n📊 COMPARATIVO LOCAL vs FTP:');
    log('compare', `  Local: ${totalLocal} itens`);
    log('compare', `  FTP:   ${Object.keys(ftpStructure).length} itens`);
    log('compare', `  Diferença: ${totalLocal - Object.keys(ftpStructure).length} itens`);

    if (differences.localOnly.length > 0) {
      log('warning', `⚠️  ${differences.localOnly.length} arquivo(s) ainda faltando no FTP:`);
      differences.localOnly.slice(0, 5).forEach(f => console.log(`    - ${f}`));
      if (differences.localOnly.length > 5) console.log(`    ... e mais ${differences.localOnly.length - 5}`);
    }

    if (differences.ftpOnly.length > 0) {
      log('warning', `⚠️  ${differences.ftpOnly.length} arquivo(s) no FTP que não estão local:`);
      differences.ftpOnly.slice(0, 5).forEach(f => console.log(`    - ${f}`));
      if (differences.ftpOnly.length > 5) console.log(`    ... e mais ${differences.ftpOnly.length - 5}`);
    }

    if (differences.sizeChanged.length > 0) {
      log('warning', `⚠️  ${differences.sizeChanged.length} arquivo(s) com tamanhos diferentes:`);
      differences.sizeChanged.slice(0, 5).forEach(item => {
        console.log(`    - ${item.file} (local: ${item.local} bytes, FTP: ${item.ftp} bytes)`);
      });
      if (differences.sizeChanged.length > 5) console.log(`    ... e mais ${differences.sizeChanged.length - 5}`);
    }

    if (differences.localOnly.length === 0 && differences.ftpOnly.length === 0 && differences.sizeChanged.length === 0) {
      log('success', '\n🎉 SINCRONIZAÇÃO COMPLETA! Local e FTP estão 100% idênticos.');
    } else {
      log('warning', '\n⚠️  Ainda há diferenças. Execute novamente para sincronizar restante.');
    }

    log('info', '\n' + '━'.repeat(50));
    log('success', 'Sincronização finalizada!');

  } catch (err) {
    log('error', `Erro: ${err.message}`);
    process.exit(1);
  } finally {
    client.close();
  }
}

main();
