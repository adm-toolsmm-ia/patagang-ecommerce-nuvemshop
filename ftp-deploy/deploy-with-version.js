#!/usr/bin/env node

/**
 * DEPLOY-WITH-VERSION.JS
 * =====================
 * Script completo de deploy que:
 * 1. Sincroniza versão
 * 2. Faz upload para FTP
 * 3. Gera relatório com cache busting
 *
 * Uso: npm run deploy:full [versao]
 * Ex:  npm run deploy:full 1.1.4
 */

const ftp = require('basic-ftp');
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const { FTP_CONFIG, DIRS } = require('./config.js');

const FILES_TO_DEPLOY = [
    { local: '../theme-deploy-corrigido/layouts/layout.tpl', remote: '/layouts/layout.tpl' },
    { local: '../theme-deploy-corrigido/static/js/version-info.js', remote: '/static/js/version-info.js' }
];

async function deployWithVersion() {
    const targetVersion = process.argv[2] || getVersionFromFile();
    const deployTime = new Date().toISOString();
    const deployTimestamp = new Date().toLocaleString('pt-BR');

    console.log('\n╔════════════════════════════════════════════════════════════╗');
    console.log('║         🚀 PATAGANG - DEPLOY COM VERSIONAMENTO              ║');
    console.log('╚════════════════════════════════════════════════════════════╝\n');

    // ETAPA 1: Sincronizar versão
    console.log('📌 ETAPA 1: Sincronizando versão...');
    try {
        const syncResult = execSync(`node sync-version.js ${targetVersion}`, { encoding: 'utf-8' });
        console.log(syncResult);
    } catch (err) {
        console.error('❌ Erro ao sincronizar versão:', err.message);
        process.exit(1);
    }

    // ETAPA 2: Fazer deploy
    console.log('\n📌 ETAPA 2: Enviando arquivos para FTP...');
    const client = new ftp.Client();
    client.ftp.timeout = 300000;

    try {
        await client.access({
            host: FTP_CONFIG.host,
            port: FTP_CONFIG.port,
            user: FTP_CONFIG.user,
            password: FTP_CONFIG.password,
            secure: true,
            secureOptions: { rejectUnauthorized: false }
        });
        console.log('✅ Conectado ao FTP\n');

        for (const file of FILES_TO_DEPLOY) {
            const localPath = path.join(__dirname, file.local);
            const remotePath = file.remote;

            if (!fs.existsSync(localPath)) {
                console.log(`❌ Arquivo não existe: ${localPath}`);
                continue;
            }

            try {
                await client.uploadFrom(fs.createReadStream(localPath), remotePath);
                console.log(`✅ Enviado: ${remotePath}`);
            } catch (err) {
                console.log(`❌ Erro ao enviar ${remotePath}: ${err.message}`);
                process.exit(1);
            }
        }

        console.log('\n✨ Deploy FTP concluído!');
    } catch (err) {
        console.error('Erro geral:', err.message);
        process.exit(1);
    } finally {
        client.close();
    }

    // ETAPA 3: Relatório com cache busting
    generateDeployReport(targetVersion, deployTime, deployTimestamp);
}

function getVersionFromFile() {
    const versionFile = path.join(__dirname, 'VERSION');
    if (fs.existsSync(versionFile)) {
        return fs.readFileSync(versionFile, 'utf-8').trim();
    }
    return '1.1.3';
}

function generateDeployReport(version, deployTime, deployTimestamp) {
    const cacheTimestamp = deployTime.replace(/[^0-9]/g, '').substring(0, 14);
    const report = `
╔════════════════════════════════════════════════════════════╗
║              ✅ DEPLOY REALIZADO COM SUCESSO               ║
╚════════════════════════════════════════════════════════════╝

📦 INFORMAÇÕES DO DEPLOY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Versão Enviada:     v${version}
Data/Hora:          ${deployTimestamp}
Timestamp:          ${cacheTimestamp}
Arquivos:           2 (layout.tpl + version-info.js)
Status:             ✅ ENVIADO PARA FTP

🔄 CACHE BUSTING (Força Atualização)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
O arquivo version-info.js foi configurado com cache busting:

    src="{{ 'js/version-info.js' | static_url }}?v=${cacheTimestamp}"

Isso força o navegador a carregar a NOVA versão, mesmo com
cache antigo. O parâmetro "v=${cacheTimestamp}" muda a cada deploy.

🧹 ETAPAS DE LIMPEZA (Importante!)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1️⃣  CACHE NUVEMSHOP (Obrigatório)
    ├─ Acesse Admin Nuvemshop
    ├─ Vá em: Temas → Menu (⋯) → Limpar Cache
    └─ Aguarde 3-5 minutos

2️⃣  CACHE NAVEGADOR (Seu Navegador)
    ├─ Pressione: Ctrl+Shift+Delete (ou Cmd+Shift+Delete)
    ├─ Selecione: "Cookies e dados armazenados"
    ├─ Marque: Site da loja (patagang-ecommerce...)
    └─ Clique em "Limpar"

3️⃣  RECARREGAR PÁGINA
    ├─ Abra a loja em ABA INCÓGNITA (Ctrl+Shift+N)
    ├─ Pressione: Ctrl+Shift+R (force reload sem cache)
    └─ Pressione: F12 → Console

📱 VALIDAÇÃO NO CONSOLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Após limpar cache e recarregar:

    ✅ Esperado ver no Console:
       📦 PATAGANG v${version} (2026-03-20)
       ℹ️ Version Info: {version: "${version}", ...}

    ❌ Se continuar mostrando v1.1.1:
       → Cache Nuvemshop ainda não foi limpo
       → Aguarde mais 5-10 minutos
       → Tente novamente em outro navegador/aba incógnita

🔗 VERIFICAÇÃO RÁPIDA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

No Console do Navegador (F12), execute:
    window.__PATAGANG_VERSION__.version
    // Deve retornar: "${version}"

╔════════════════════════════════════════════════════════════╗
║  ⚠️  IMPORTANTE: Você NÃO consegue limpar cache manualmente║
║      na Nuvemshop (customização via FTP). Use as etapas    ║
║      acima para limpar seu navegador local.                ║
║      Cache Nuvemshop será limpo automaticamente em 3-5min. ║
╚════════════════════════════════════════════════════════════╝

📊 PRÓXIMAS AÇÕES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ Aguardar 3-5 minutos de propagação
□ Limpar cache Nuvemshop (Admin → Temas → ⋯ → Limpar Cache)
□ Limpar cache navegador (Ctrl+Shift+Delete)
□ Abrir loja em ABA INCÓGNITA
□ Pressionar Ctrl+Shift+R (force reload)
□ F12 → Console → Procurar por "📦 PATAGANG v${version}"
□ Executar: window.__PATAGANG_VERSION__.version

Deploy completo: ${deployTime}
`;

    console.log(report);

    // Salva relatório em arquivo
    const reportFile = path.join(__dirname, `DEPLOY_REPORT_${cacheTimestamp}.txt`);
    fs.writeFileSync(reportFile, report);
    console.log(`\n💾 Relatório salvo em: ${reportFile}\n`);
}

deployWithVersion();
