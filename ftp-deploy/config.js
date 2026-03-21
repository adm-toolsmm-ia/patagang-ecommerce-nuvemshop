/**
 * Configurações FTP - Nuvemshop Patagang
 * Credenciais lidas de process.env (via .env)
 * Nunca commitar credenciais em texto puro
 */

const path = require('path');
const fs = require('fs');

// Carregar .env se existir
const envPath = path.join(__dirname, '.env');
if (fs.existsSync(envPath)) {
  require('dotenv').config({ path: envPath });
}

// Diretório raiz do projeto
const PROJECT_ROOT = path.join(__dirname, '..');

// Validar que credenciais estão carregadas
if (!process.env.FTP_USER || !process.env.FTP_PASSWORD) {
  throw new Error(
    '❌ Credenciais FTP não configuradas. Crie ftp-deploy/.env baseado em .env.example'
  );
}

// Configurações FTP (credenciais de process.env)
const FTP_CONFIG = {
    host: process.env.FTP_HOST || 'ftp.nuvemshop.com.br',
    port: parseInt(process.env.FTP_PORT || '21', 10),
    user: process.env.FTP_USER,
    password: process.env.FTP_PASSWORD,
    secure: process.env.FTP_SECURE === 'true' || true, // FTPS explícito (AUTH TLS)
    secureOptions: {
        rejectUnauthorized: false // Aceitar certificados auto-assinados
    },
};

// Diretórios
const DIRS = {
    theme: path.join(PROJECT_ROOT, 'theme-deploy-corrigido'),
    backup: path.join(PROJECT_ROOT, 'backups'),
    logs: path.join(PROJECT_ROOT, 'logs'),
};

// Arquivos a serem ignorados no deploy
const IGNORE_PATTERNS = [
    '.git',
    '.DS_Store',
    'Thumbs.db',
    '*.log',
    '.env',
    'node_modules',
    '*.bak',
];

module.exports = {
    FTP_CONFIG,
    DIRS,
    IGNORE_PATTERNS,
    PROJECT_ROOT,
};
