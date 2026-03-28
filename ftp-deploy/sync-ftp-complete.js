#!/usr/bin/env node

/**
 * SINCRONIZAÇÃO COMPLETA FTP ↔ LOCAL
 * Garante que o FTP tem EXATAMENTE o mesmo conteúdo do theme-deploy-corrigido/
 * Deleta arquivos/pastas que não existem mais localmente
 */

const fs = require('fs');
const path = require('path');
const Client = require('basic-ftp').Client;
const { FTP_CONFIG, DIRS } = require('./config');

const LOCAL_THEME = path.join(__dirname, '..', 'theme-deploy-corrigido');
let ftpStructure = {};
let localStructure = {};

function log(type, msg) {
  const icons = {
    info: 'ℹ️ ',
    success: '✅',
    error: '❌',
    warning: '⚠️ ',
    delete: '🗑️ ',
  };
  console.log(`${icons[type] || '•'} ${msg}`);
}

// Mapeie estrutura local
function mapLocalStructure(dir = '', basePath = LOCAL_THEME) {
  const fullPath = path.join(basePath, dir);
  const items = fs.readdirSync(fullPath, { withFileTypes: true });

  items.forEach(item => {
    const itemPath = path.join(dir, item.name);
    const key = itemPath.replace(/\\/g, '/');

    if (item.isDirectory()) {
      localStructure[key + '/'] = 'dir';
      mapLocalStructure(itemPath, basePath);
    } else {
      localStructure[key] = 'file';
    }
  });
}

// Mapeie estrutura FTP
async function mapFtpStructure(client, dir = '', depth = 0) {
  if (depth > 10) return; // Proteção contra recursão infinita

  try {
    const list = await client.list(dir);

    list.forEach(item => {
      const itemPath = dir ? `${dir}/${item.name}` : item.name;
      const key = itemPath.replace(/\\/g, '/');

      if (item.isDirectory) {
        ftpStructure[key + '/'] = 'dir';
      } else {
        ftpStructure[key] = 'file';
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
    // Ignorar erros de diretórios especiais
  }
}

async function deleteFromFtp(client, paths) {
  for (const itemPath of paths) {
    try {
      const isDir = itemPath.endsWith('/');
      const pathToDelete = itemPath.replace(/\/$/, '');

      if (isDir) {
        // Tentar remover como diretório
        try {
          await client.removeDir(pathToDelete);
          log('delete', `Diretório removido: ${pathToDelete}/`);
        } catch (err) {
          // Se falhar, ignorar (pode estar vazio ou ter permissões)
          // log('warning', `Não foi possível remover dir: ${pathToDelete}`);
        }
      } else {
        // Remover arquivo
        await client.remove(pathToDelete);
        log('delete', `Arquivo removido: ${pathToDelete}`);
      }
    } catch (err) {
      if (!err.message.includes('550')) {
        log('warning', `Erro ao remover ${itemPath}: ${err.message}`);
      }
    }
  }
}

async function main() {
  const client = new Client();

  try {
    log('info', 'Conectando ao FTP...');
    await client.access({
      host: FTP_CONFIG.host,
      user: FTP_CONFIG.user,
      password: FTP_CONFIG.password,
      secure: true,
    });
    log('success', 'Conectado ao FTP');

    log('info', 'Mapeando estrutura local...');
    mapLocalStructure();
    log('success', `Local: ${Object.keys(localStructure).length} itens`);

    log('info', 'Mapeando estrutura FTP...');
    await mapFtpStructure(client);
    log('success', `FTP: ${Object.keys(ftpStructure).length} itens`);

    // Encontrar itens que estão no FTP mas NÃO estão localmente
    const toDelete = [];
    for (const ftpItem of Object.keys(ftpStructure)) {
      if (!localStructure[ftpItem]) {
        toDelete.push(ftpItem);
      }
    }

    if (toDelete.length === 0) {
      log('success', 'FTP já está sincronizado! Nenhum item para remover.');
      client.close();
      return;
    }

    log('warning', `\n${toDelete.length} itens para remover do FTP:\n`);
    toDelete.forEach(item => {
      console.log(`   - ${item}`);
    });

    console.log('\nProsseguindo com limpeza...\n');

    // Deletar arquivos primeiro (de trás para frente, para evitar conflitos)
    const filesToDelete = toDelete.filter(f => !f.endsWith('/'));
    const dirsToDelete = toDelete.filter(d => d.endsWith('/')).sort().reverse();

    await deleteFromFtp(client, filesToDelete);
    await deleteFromFtp(client, dirsToDelete);

    log('success', `\n✅ Sincronização concluída!`);
    log('info', `Removidos: ${filesToDelete.length} arquivos + ${dirsToDelete.length} diretórios`);

  } catch (err) {
    log('error', `Erro: ${err.message}`);
    process.exit(1);
  } finally {
    client.close();
  }
}

main();
