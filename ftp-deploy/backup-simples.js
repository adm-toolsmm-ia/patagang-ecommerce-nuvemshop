#!/usr/bin/env node
/**
 * Backup Simples do FTP - Sem Dependências
 * Conecta ao FTP, lista e faz backup de TODOS os arquivos
 */

const ftp = require('basic-ftp');
const fs = require('fs');
const path = require('path');

// Configurações (hardcoded para garantir que funcionam)
const FTP_CONFIG = {
    host: 'ftp.nuvemshop.com.br',
    port: 21,
    user: 'patagang',
    password: 'Q88gP0Ud',
    secure: true
};

const BACKUP_DIR = path.join(__dirname, '../backups/ftp-backup-' + new Date().toISOString().split('T')[0]);

console.log('🔧 BACKUP SIMPLES DO FTP - NUVEMSHOP PATAGANG');
console.log('━'.repeat(60));
console.log(`📁 Backup será salvo em: ${BACKUP_DIR}`);
console.log(`🔐 Conectando a ${FTP_CONFIG.host}...`);
console.log();

async function main() {
    const client = new ftp.Client();
    client.ftp.verbose = false;

    try {
        // Conectar
        await client.access({
            host: FTP_CONFIG.host,
            port: FTP_CONFIG.port,
            user: FTP_CONFIG.user,
            password: FTP_CONFIG.password,
            secure: true
        });
        console.log('✅ Conectado com sucesso!');

        // Criar diretório de backup
        if (!fs.existsSync(BACKUP_DIR)) {
            fs.mkdirSync(BACKUP_DIR, { recursive: true });
        }

        // Função para listar e fazer backup recursivamente
        async function backupDir(remotePath = '', localPath = BACKUP_DIR) {
            try {
                const list = await client.list(remotePath || '/');

                for (const item of list) {
                    if (item.name === '.' || item.name === '..') continue;

                    const fullRemote = remotePath ? `${remotePath}/${item.name}` : item.name;
                    const fullLocal = path.join(localPath, item.name);

                    if (item.isDirectory) {
                        console.log(`📂 ${fullRemote}`);
                        if (!fs.existsSync(fullLocal)) {
                            fs.mkdirSync(fullLocal, { recursive: true });
                        }
                        await backupDir(fullRemote, fullLocal);
                    } else {
                        try {
                            process.stdout.write(`  ⬇️  ${item.name}`);
                            await client.downloadTo(fullLocal, fullRemote);
                            console.log(` [${item.size} bytes] ✓`);
                        } catch (err) {
                            console.log(` ❌ ERRO: ${err.message}`);
                        }
                    }
                }
            } catch (err) {
                console.error(`Erro ao acessar ${remotePath}: ${err.message}`);
            }
        }

        console.log('📥 Iniciando backup de todos os arquivos...');
        console.log();

        const startTime = Date.now();
        await backupDir();
        const duration = ((Date.now() - startTime) / 1000).toFixed(1);

        console.log();
        console.log('━'.repeat(60));
        console.log(`✅ BACKUP CONCLUÍDO em ${duration}s`);
        console.log(`📁 Caminho: ${BACKUP_DIR}`);
        console.log();

        // Gerar relatório
        const stats = {
            timestamp: new Date().toISOString(),
            ftpHost: FTP_CONFIG.host,
            ftpUser: FTP_CONFIG.user,
            backupPath: BACKUP_DIR,
            duration: `${duration}s`,
            completed: new Date()
        };

        fs.writeFileSync(path.join(BACKUP_DIR, '_BACKUP_REPORT.json'), JSON.stringify(stats, null, 2));
        console.log('📊 Relatório salvo em: _BACKUP_REPORT.json');
        console.log();

    } catch (error) {
        console.error(`\n❌ ERRO CRÍTICO: ${error.message}`);
        console.error(error);
        process.exit(1);
    } finally {
        client.close();
    }
}

main().catch(console.error);
