/**
 * Configurações FTP - Nuvemshop Patagang
 * Copie este arquivo para config.js e preencha com suas credenciais
 */

const path = require('path');

// Diretório raiz do projeto
const PROJECT_ROOT = path.join(__dirname, '..');

// Configurações FTP
const FTP_CONFIG = {
    host: 'ftp.nuvemshop.com.br',
    port: 21,
    user: 'SEU_USUARIO',
    password: 'SUA_SENHA',
    secure: true, // FTPS explícito (AUTH TLS)
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
];

module.exports = {
    FTP_CONFIG,
    DIRS,
    IGNORE_PATTERNS,
    PROJECT_ROOT,
};
