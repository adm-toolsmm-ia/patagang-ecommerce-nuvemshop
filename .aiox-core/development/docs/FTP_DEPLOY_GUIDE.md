# 🚀 Guia Completo: Deploy FTP Standard AIOX - Patagang Nuvemshop

**Versão:** 1.0.0
**Atualizado:** 2026-03-20
**Framework:** AIOX Standard Deployment
**Executor Exclusivo:** @devops (Gage)

---

## 📖 Índice

1. [Visão Geral](#visão-geral)
2. [Arquitetura & Fluxo](#arquitetura--fluxo)
3. [Antes de Começar (Setup)](#antes-de-começar-setup)
4. [Deploy Passo a Passo](#deploy-passo-a-passo)
5. [Comandos Rápidos](#comandos-rápidos)
6. [Monitoramento & Validação](#monitoramento--validação)
7. [Rollback & Recuperação](#rollback--recuperação)
8. [Troubleshooting](#troubleshooting)
9. [FAQ](#faq)

---

## Visão Geral

O **Deploy FTP Standard AIOX** é a rotina padronizada para enviar alterações da Patagang para o servidor FTP da Nuvemshop com:

### ✅ Características Principais

| Feature | Descrição | Benefício |
|---------|-----------|----------|
| **Diff Inteligente** | Envia apenas arquivos modificados (MD5) | Reduz tempo (10-30 min vs 1-2h) |
| **Versionamento Automático** | Injeta versão em `layout.tpl` | Console mostra versão exata |
| **Backup Incremental** | Faz download dos arquivos antes | Rollback em < 5 minutos |
| **Retry Automático** | 3 tentativas por arquivo | Recupera de erros de rede |
| **Reconexão FTP** | A cada 50 arquivos | Mantém conexão estável |
| **Metadados Completos** | Hash MD5 + timestamps | Auditoria e rastreabilidade |
| **Logs Estruturados** | Histórico de todos os deploys | Debugging facilitado |

### 📊 Performance Esperada

```
Arquivos modificados: 5-50
Tempo total: 20-55 minutos
├── Validação: 2-3 min
├── Backup: 5-15 min
├── Upload: 10-30 min
└── Validação pós: 3-5 min

Taxa de sucesso: 98%+
Rollback possível: < 5 minutos
```

---

## Arquitetura & Fluxo

### 🏗️ Estrutura de Componentes

```
ftp-deploy/
├── deploy-optimized.js           # 🟢 Deploy principal
├── backup-full-ftp.js            # Backup completo
├── deploy-critical-only.js       # Deploy de 2 arquivos críticos
├── rollback-incremental.js       # 🟢 Restauração
├── list-backups.js               # Listar backups
├── sync-backup-to-local.js       # Sincronizar backup
├── verify-sync.js                # Verificar sincronização
├── config.js                     # 🔐 Credenciais FTP (git-ignored)
├── config.example.js             # Template de config
├── package.json                  # Dependências
├── .deploy-cache.json            # Cache MD5 (gerado)
├── LAST_DEPLOY_VERSION.txt       # 🟢 Versão atual
├── DEPLOY_HISTORY.json           # 🟢 Histórico
└── deploy-log.txt                # 🟢 Log atual
```

### 🔄 Fluxo de Deploy (5 Fases)

```
┌─────────────────────────────────────────────────────────┐
│ FASE 1: VALIDAÇÃO PRÉ-DEPLOY (2-3 min)                │
│ Checar FTP, estrutura local, credenciais               │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│ FASE 2: BACKUP INCREMENTAL (5-15 min)                 │
│ Download dos arquivos que serão alterados              │
│ Criar metadados: _BACKUP_METADATA.json                 │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│ FASE 3: DEPLOY OTIMIZADO (10-30 min)                  │
│ Upload em lotes, retry automático, version injection   │
│ Atualizar cache MD5                                    │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│ FASE 4: VALIDAÇÃO PÓS-DEPLOY (3-5 min)               │
│ Verificar integridade, atualizar logs                  │
│ Registrar LAST_DEPLOY_VERSION.txt                      │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│ FASE 5: VALIDAÇÃO EM PRODUÇÃO (5-10 min)             │
│ Verificar versão no console, limpar cache Nuvemshop   │
│ Testar funcionalidades críticas                        │
└─────────────────────────────────────────────────────────┘
                          ↓
                    ✅ COMPLETO
```

---

## Antes de Começar (Setup)

### 📋 Pré-Requisitos

1. **Node.js >= 18**
   ```bash
   node -v  # Deve mostrar v18+
   ```

2. **Pacote basic-ftp instalado**
   ```bash
   cd ftp-deploy
   npm install
   ```

3. **Credenciais FTP válidas**
   - Arquivo: `ftp-deploy/config.js`
   - Contem: `FTP_CONFIG` com host, port, user, password
   - Status: **git-ignored** (seguro)

4. **theme-deploy-corrigido/ sincronizado**
   ```bash
   ls -la theme-deploy-corrigido/
   # Deve listar: templates/, snipplets/, static/, config/
   ```

5. **Conexão de rede estável**
   ```bash
   ping -c 3 ftp.nuvemshop.com.br
   # Deve retornar 3 respostas com < 100ms
   ```

### 🔧 Configuração Inicial

#### Passo 1: Copiar Template de Config
```bash
cd ftp-deploy
cp config.example.js config.js
```

#### Passo 2: Editar config.js com Credenciais Reais
```javascript
const FTP_CONFIG = {
    host: 'ftp.nuvemshop.com.br',
    port: 21,
    user: 'patagang',              // ← Seu usuário FTP
    password: 'Q88gP0Ud',           // ← Sua senha FTP
    secure: true,
    // ...
};
```

#### Passo 3: Testar Conexão FTP
```bash
node -e "
const ftp = require('basic-ftp');
const c = new ftp.Client();
c.access({
  host: 'ftp.nuvemshop.com.br',
  port: 21,
  user: 'patagang',
  password: 'SENHA',
  secure: true,
  secureOptions: { rejectUnauthorized: false }
}).then(() => {
  console.log('✅ Conexão FTP OK');
  c.close();
}).catch(e => {
  console.log('❌ Erro:', e.message);
});
"
```

**Saída esperada:** `✅ Conexão FTP OK`

#### Passo 4: Instalar Dependências
```bash
npm install
# Instala: basic-ftp@^5.0.4
```

#### Passo 5: Verificar Estrutura
```bash
npm run list  # Lista backups existentes
npm run verify-sync  # Verifica sincronização
```

---

## Deploy Passo a Passo

### 🚀 Execução Básica (Deploy Incremental)

**Comando:**
```bash
cd ftp-deploy
npm run deploy
```

### Entrada Esperada (Step-by-Step)

#### Fase 1: Validação Pré-Deploy
```
🚀 Deploy Otimizado - Patagang Nuvemshop
========================================

ℹ️ 10:30:15 | ℹ Conectando ao FTP ftp.nuvemshop.com.br...
✓ 10:30:18 | ✓ Conectado como patagang
ℹ️ 10:30:20 | ℹ Verificando arquivos modificados...
✓ 10:30:25 | ✓ Modificados: 28 | Inalterados: 122
```

**Status:** ✅ Pronto para próxima fase

#### Fase 2: Backup Incremental
```
ℹ️ 10:30:26 | ℹ Iniciando backup incremental...
▶ 10:30:27 | ▶ Backup será salvo em: backups/incremental/2026-03-20T10-30-45/

Listando... 150 arquivos encontrados
▶ 10:30:45 | ▶ Lote 1/3 (10 arquivos)
[████████████░░░░░░░░░░░░░░░░] 37% (11/30) | 0.8 MB/s

✓ 10:31:15 | ✓ Backup concluído em 45s
✓ 10:31:16 | ✓ Metadados salvos em: _BACKUP_METADATA.json
```

**Status:** ✅ Backup criado e seguro

#### Fase 3: Upload para FTP
```
ℹ️ 10:31:17 | ℹ Iniciando upload...
▶ 10:31:18 | ▶ Lote 1/3 (10 arquivos)
[████████████████████░░░░░░░░░░] 62% (18/28) | 1.2 MB/s

✓ 10:31:55 | ✓ templates/product.tpl
✓ 10:32:01 | ✓ static/css/style-critical.tpl
✓ 10:32:08 | ✓ snipplets/header/header-patagang.tpl

✓ 10:32:45 | ✓ Deploy concluído em 240s
✓ 10:32:46 | ✓ Sucesso: 28/28 arquivos
✓ 10:32:47 | ✓ Cache atualizado
```

**Status:** ✅ Upload 100% bem-sucedido

#### Fase 4: Validação Pós-Deploy
```
ℹ️ 10:32:48 | ℹ Validando integridade...
✓ 10:32:52 | ✓ Integridade verificada
✓ 10:32:53 | ✓ LAST_DEPLOY_VERSION.txt atualizado: v1.1.1
✓ 10:32:54 | ✓ Histórico registrado: DEPLOY_HISTORY.json

========================================
✨ DEPLOY CONCLUÍDO COM SUCESSO
========================================

📦 Versão: v1.1.1
🕐 Data: 2026-03-20T10:32:45Z
📝 Commit: 9502c44
💾 Backup: backups/incremental/2026-03-20T10-30-45/
⏱️ Duração: 4 minutos 30 segundos

💡 Próximos passos:
  1. Limpar cache Nuvemshop: Admin → Temas → Limpar Cache
  2. Aguardar 3-5 minutos de propagação
  3. Validar em produção: https://patagang.lojavirtualnuvem.com.br/
```

**Status:** ✅ Deploy finalizado com sucesso

#### Fase 5: Validação em Produção
```
✅ CHECKLIST PÓS-DEPLOY
├─ [ ] Versão em console: window.__PATAGANG_VERSION__
├─ [ ] Cache Nuvemshop limpo (Admin → Temas)
├─ [ ] Página inicial carrega
├─ [ ] Busca funciona
├─ [ ] Carrinho funciona
└─ [ ] Nenhum erro em F12 (Console)

Tempo esperado: 5-10 minutos
```

---

## Comandos Rápidos

### Deploy Incremental (Padrão)
```bash
npm run deploy
```
- Envia apenas arquivos modificados
- Faz backup automático
- Mais rápido (10-30 min)

### Deploy Completo (Force All)
```bash
npm run deploy -- --force-all
```
- Envia todos os arquivos
- Ignora cache MD5
- Mais seguro para situações críticas
- Mais lento (30-60 min)

### Deploy Sem Backup
```bash
npm run deploy -- --no-backup
```
- Pula fase de backup
- Rápido, porém **RISCO de dados**
- Use apenas em emergências

### Backup Completo
```bash
npm run backup
```
- Faz download de TODOS os arquivos do FTP
- Cria cópia completa de produção
- Armazenado em: `backups/ftp-full/{TIMESTAMP}/`

### Listar Backups
```bash
npm run list              # Últimos 5 incrementais
npm run list -- --all    # Todos os backups
npm run list -- --full   # Apenas backups completos
```

**Output:**
```
📁 Backups Disponíveis:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Incremental (Recentes):
  2026-03-20T10-30-45  → 28 arquivos | 3.2 MB
  2026-03-19T15-22-10  → 12 arquivos | 1.8 MB
  2026-03-18T09-14-33  → 5 arquivos  | 0.4 MB

Full (Completos):
  2026-02-14T00-10-23  → 150 arquivos | 35.2 MB
```

### Rollback (Restaurar Backup)
```bash
npm run rollback -- 2026-03-20T10-30-45
```
- Restaura versão anterior
- Sincroniza local com backup
- Prepara para re-deploy

**Tempo:** 2-5 minutos

### Sincronizar Backup com Local
```bash
node sync-backup-to-local.js 2026-03-20T10-30-45
```
- Copia backup para `theme-deploy-corrigido/`
- Overwrite arquivos locais
- Útil depois de rollback

### Verificar Sincronização
```bash
node verify-sync.js
```
- Compara MD5 local vs remoto
- Mostra diferenças
- Valida integridade

---

## Monitoramento & Validação

### 📊 Verificar Versão em Produção

#### Método 1: Console do Navegador
```javascript
// No browser: https://patagang.lojavirtualnuvem.com.br/
// Abrir: F12 ou Cmd+Option+J (Mac)
// Executar:

window.__PATAGANG_VERSION__

// Resposta:
{
  "app_name": "PATAGANG Nuvemshop",
  "version": "1.1.1",
  "environment": "production",
  "deployment_date": "2026-03-20T03:46:27Z",
  "git_commit": "9502c44",
  "git_branch": "main",
  "console_message": "🚀 PATAGANG v1.1.1 (2026-03-20) - PDP Layout Fix - Commit: 9502c44"
}
```

#### Método 2: Arquivo de Versão
```bash
cat ftp-deploy/LAST_DEPLOY_VERSION.txt

# Output:
# PATAGANG v1.1.1 - 2026-03-20T03:46:27Z - Commit: 9502c44
```

#### Método 3: Histórico de Deploys
```bash
cat ftp-deploy/DEPLOY_HISTORY.json | jq '.deployments | last'

# Output:
{
  "version": "1.1.1",
  "timestamp": "2026-03-20T10:30:45Z",
  "git_commit": "9502c44",
  "git_branch": "main",
  "files_deployed": 28,
  "duration_seconds": 240,
  "backup_timestamp": "2026-03-20T10-30-45"
}
```

### ✅ Checklist Pós-Deploy

```
[ ] Versão em console: v1.1.1 (correta?)
[ ] Deployment date: recente? (não > 1h)
[ ] Cache Nuvemshop: limpo (Admin → Temas)
[ ] Propagação: aguardou 3-5 min
[ ] Página inicial: carrega sem erros
[ ] Busca: funciona (digitar termo, ver resultados)
[ ] Carrinho: adiciona/remove produtos
[ ] Checkout: acessível
[ ] Mobile: responsivo (testar em 375px)
[ ] Console: sem erros JavaScript (F12)
[ ] Network: sem 404 ou 5xx (F12 → Network)
```

### 📈 Monitoramento Contínuo

```bash
# Verificar sincronização a cada 1 hora
watch -n 3600 'node verify-sync.js'

# Monitorar tamanho de backups
du -sh ../backups/incremental/*/

# Verificar espaço em disco
df -h | grep /
```

---

## Rollback & Recuperação

### 🔄 Rollback Simples (Caso de Uso Comum)

**Cenário:** Deploy novo foi para produção, mas algo deu errado.

**Passo 1: Listar Backups**
```bash
npm run list
```

**Passo 2: Identificar Versão Anterior**
```
Incremental (Recentes):
  2026-03-20T10-30-45  ← Versão problemática
  2026-03-19T15-22-10  ← Versão anterior (boa)
```

**Passo 3: Restaurar Backup**
```bash
npm run rollback -- 2026-03-19T15-22-10
```

**Passo 4: Re-Deploy**
```bash
npm run deploy
```

**Passo 5: Validar em Produção**
```javascript
window.__PATAGANG_VERSION__
// Deve mostrar versão anterior
```

**Tempo total:** 5-10 minutos

---

### 🚨 Rollback de Emergência (Dados Críticos Perdidos)

**Cenário:** Arquivo crítico foi sobrescrito, precisa restaurar do FTP.

**Passo 1: Backup Completo do FTP (Estado Atual)**
```bash
npm run backup
# Cria: backups/ftp-full/2026-03-20T10-35-20/
```

**Passo 2: Usar Backup Anterior**
```bash
npm run rollback -- 2026-03-19T15-22-10
```

**Passo 3: Sincronizar com Local**
```bash
node sync-backup-to-local.js 2026-03-19T15-22-10
```

**Passo 4: Deploy Restaurado**
```bash
npm run deploy
```

**Passo 5: Verificar Integridade**
```bash
node verify-sync.js
```

---

### 📋 Política de Retenção de Backups

```javascript
// Automático (ftp-deploy/deploy-optimized.js):
Max backups incrementais: 20
Max backups completos: 5

// Manual:
Para manter histórico: fazer backup manual
Para limpar disco: deletar backups antigos
  rm -rf ../backups/incremental/2026-02-*/
```

---

## Troubleshooting

### ❌ "Connection lost" ou "ECONNRESET"

**Causa:** Conexão FTP interrompida (rede instável ou timeout do servidor)

**Solução Rápida:**
```bash
npm run deploy
# Script tenta reconectar automaticamente 3x
# Se falhar, aguarde 2 min e retry
```

**Solução Detalhada:**
1. Verificar conexão de rede:
   ```bash
   ping -c 5 ftp.nuvemshop.com.br
   ```
2. Se lento, aumentar timeout em `deploy-optimized.js`:
   ```javascript
   const TIMEOUT_MS = 600000;  // 10 minutos (era 300000)
   ```
3. Reduzir batch size:
   ```javascript
   const BATCH_SIZE = 5;  // Antes era 10
   ```
4. Retry deploy:
   ```bash
   npm run deploy
   ```

---

### ❌ "File not found" ou "Cannot read file"

**Causa:** Arquivo local não existe ou caminho errado

**Solução:**
1. Verificar estrutura local:
   ```bash
   ls -la ../theme-deploy-corrigido/
   # Deve ter: templates/, snipplets/, static/, config/
   ```

2. Se falta arquivos, sincronizar do backup:
   ```bash
   npm run list
   npm run rollback -- {TIMESTAMP}
   node sync-backup-to-local.js {TIMESTAMP}
   ```

3. Retry deploy:
   ```bash
   npm run deploy
   ```

---

### ❌ "Authentication failed" ou "530 User cannot log in"

**Causa:** Credenciais FTP inválidas ou expiradas

**Solução:**
1. Verificar credenciais em `config.js`:
   ```javascript
   // Usar credenciais reais da Nuvemshop
   user: 'patagang',
   password: 'SENHA_CORRETA',
   ```

2. Testar conexão:
   ```bash
   node -e "
   const ftp = require('basic-ftp');
   const c = new ftp.Client();
   c.access({...}).then(() => {
     console.log('✅ OK'); c.close();
   }).catch(e => console.log('❌', e.message));
   "
   ```

3. Se continuar falhando, contatar Nuvemshop para resetar credenciais

---

### ⚠️ Deploy muito lento (> 1 hora)

**Causa:** Conexão lenta ou muitos arquivos

**Solução:**
1. Verificar velocidade de internet:
   ```bash
   speedtest-cli  # ou usar speedtest.net
   ```

2. Reduzir BATCH_SIZE em `deploy-optimized.js`:
   ```javascript
   const BATCH_SIZE = 5;  // Antes era 10
   const RECONNECT_EVERY = 100;  // Aumentar
   ```

3. Usar `--force-all` se tiver poucos arquivos:
   ```bash
   npm run deploy -- --force-all
   ```

4. Se muito lento, fazer deploy por partes:
   ```bash
   npm run deploy -- --no-backup  # Pula backup, mais rápido
   ```

---

### ⚠️ Cache desatualizado (mostra versão errada)

**Causa:** Cache MD5 ficou desincronizado

**Solução:**
1. Deletar cache:
   ```bash
   rm .deploy-cache.json
   ```

2. Verificar sincronização:
   ```bash
   node verify-sync.js
   ```

3. Re-deploy forçado:
   ```bash
   npm run deploy -- --force-all
   ```

---

## FAQ

### P: Como saber qual versão está em produção?
**R:**
```javascript
// No console do navegador:
window.__PATAGANG_VERSION__

// Ou no terminal:
cat ftp-deploy/LAST_DEPLOY_VERSION.txt
```

### P: Quanto tempo leva um deploy?
**R:**
```
Arquivos modificados: 5-20   → 20-30 min (rápido)
Arquivos modificados: 20-50  → 30-60 min (normal)
Arquivos modificados: 50+    → 60+ min (lento)

Total inclui: validação + backup + upload + logs
```

### P: Posso fazer deploy de um único arquivo?
**R:** Sim, existem 2 opções:
```bash
# 1. Deploy normal (automático detecta o arquivo)
npm run deploy

# 2. Deploy crítico (2 arquivos pré-configurados)
node deploy-critical-only.js
# Editar a lista em deploy-critical-only.js para suas necessidades
```

### P: E se o deploy falhar no meio do caminho?
**R:**
- Scripts de retry automático tentam 3x cada arquivo
- Se continuar falhando, fazer rollback:
  ```bash
  npm run rollback -- {TIMESTAMP_ANTERIOR}
  npm run deploy
  ```
- Rollback é seguro (< 5 min)

### P: Qual é o tamanho máximo de arquivo?
**R:**
```
Limite FTP Nuvemshop: Praticamente ilimitado
Limite prático: < 100 MB (lento)
Recomendação: Comprimir arquivos grandes antes de deploy
```

### P: Como limpar cache da Nuvemshop?
**R:**
```
1. Acessar: https://www.nuvemshop.com.br/admin/v2/themes
2. Clicar ⋯ (menu) do tema ativo
3. Selecionar "Limpar Cache"
4. Aguardar 3-5 minutos de propagação

Ou via API/CLI (se disponível)
```

### P: Posso fazer deploy enquanto o site está recebendo tráfego?
**R:**
```
SIM, é seguro! Patagang usa:
- Deploy incremental (não afeta arquivos não alterados)
- Arquivo versionado (layout.tpl) muda atomicamente
- Cache Nuvemshop propaga lentamente (3-5 min)

Melhor fazer deploy:
- Fora de horário de pico (noite/madrugada)
- Ou com aviso prévio ao time
```

### P: Como faço backup manual completo?
**R:**
```bash
npm run backup
# Cria: backups/ftp-full/{TIMESTAMP}/
# Inclui: metadados, README, todos os arquivos
```

### P: Quantos backups devo manter?
**R:**
```
Recomendação:
- Últimos 20 incrementais (automático)
- Últimos 5 completos (manual)
- Deletar backups > 3 meses (arquivo morto)

Comando para limpar:
rm -rf ../backups/incremental/2026-{01,02}-*/
```

### P: Como integrar deploy com CI/CD (GitHub Actions)?
**R:**
Exemplo de GitHub Actions:
```yaml
name: Deploy to FTP
on: [push]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
      - run: cd ftp-deploy && npm install
      - run: npm run deploy
        env:
          FTP_USER: ${{ secrets.FTP_USER }}
          FTP_PASS: ${{ secrets.FTP_PASS }}
```

---

## 📞 Suporte & Escalação

| Problema | Responsável | Ação |
|----------|------------|------|
| Deploy falha persistentemente | @devops | Investigar logs, testar FTP |
| Versão errada em produção | @devops | Rollback ou re-deploy |
| Arquivo crítico perdido | @devops + @data-engineer | Restaurar do backup |
| Credenciais expiradas | @devops + Nuvemshop | Renovar credenciais |
| Performance lenta | @devops + Network | Otimizar batch size |

---

## 🎯 Sumário Rápido

### Seu Primeiro Deploy
```bash
cd ftp-deploy
npm run deploy
# Pronto! Aguarde 20-50 min
```

### Validar Versão
```javascript
window.__PATAGANG_VERSION__  // No console do navegador
```

### Se Algo Deu Errado
```bash
npm run list              # Listar backups
npm run rollback -- {TS}  # Restaurar
npm run deploy            # Re-deploy
```

### Monitorar Próximos Deploys
```bash
watch 'tail -f deploy-log.txt'
```

---

**Última atualização:** 2026-03-20
**Framework:** AIOX Standard Deployment v1.0
**Autor:** Synkra AIOX
**Executor:** @devops (Exclusive)
