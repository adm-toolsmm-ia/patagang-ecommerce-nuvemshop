# 🚀 PATAGANG Deployment System v2.0

> **AIOX-Compliant** — Versionamento e Deploy Automático via FTP

---

## Quick Start

```bash
# 1. Fazer alterações no tema
# 2. Git commit
# 3. Deploy com um único comando

npm run deploy:dry "Descrição da mudança"    # Simular (recomendado primeiro)
npm run deploy "Descrição da mudança"         # Deploy real

# Ou diretamente:
node deploy.js "Descrição da mudança"
```

---

## Fluxo Completo (Developer)

```
1. Alteração no Tema
   └─ Editar: theme-deploy-corrigido/*.*

2. Git Commit
   └─ git add .
   └─ git commit -m "fix: descrição"

3. Deploy
   └─ npm run deploy:dry "Descrição"          (validar primeiro)
   └─ npm run deploy "Descrição"               (fazer deploy real)

4. Validação na Loja
   └─ Abrir: https://patagang.com.br/
   └─ F12 → Console
   └─ Verificar: 📦 PATAGANG v1.1.X
   └─ Limpar cache se não aparecer: Ctrl+Shift+Delete

```

---

## 6 Fases do Deploy (Automatizadas)

### Fase 0️⃣ — Validação de Contexto
- Detecta story do branch (se existir)
- Valida credenciais FTP em `.env`
- Verifica que está em repositório git

### Fase 1️⃣ — Detecção de Arquivos Modificados
```bash
git diff --name-only HEAD -- theme-deploy-corrigido/
```
- Auto-detecta todos arquivos alterados no tema
- Sempre inclui `version-info.js` (será atualizado)
- Se nenhum arquivo → abola (exit 0)

### Fase 2️⃣ — Auto-Increment de Versão
```
Versão atual:  1.1.8
Patch default: 1.1.9
--minor flag:  1.2.0
```
- Incrementa versão automaticamente
- Atualiza `VERSION.json`
- Sincroniza `version-info.js` com nova versão
- Console message: `📦 PATAGANG v1.1.9 (21/03/2026) ✅`

### Fase 3️⃣ — Git Commit + Tag + Push
```bash
git commit "chore: bump version to 1.1.9"
git tag v1.1.9
git push origin main --tags
```
- **Importante:** Pede confirmação antes de fazer push
- Você pode cancelar e fazer `git push` manualmente depois

### Fase 4️⃣ — Backup Incremental
```
backups/deployment-1.1.9/2026-03-21T023422/
├── layouts/...
├── templates/...
├── snipplets/...
├── static/js/version-info.js
└── _METADATA.json  (hashes, timestamps, etc)
```
- Baixa versão atual do FTP para cada arquivo
- Salva com metadados completos
- Permite rollback rápido se algo der errado

### Fase 5️⃣ — Deploy para FTP
- Upload de todos os arquivos detectados
- Timeout 30 segundos por arquivo
- Retry automático se falhar

### Fase 6️⃣ — Validação Pós-Deploy
- Re-download de cada arquivo do FTP
- Valida integridade (tamanho, hash)
- Confirma 100% dos arquivos foram deployados

---

## Exemplos de Uso

### ✅ Deploy Normal (Patch Version)

```bash
npm run deploy "Fix: Ajuste de cores no botão"

# Resultado:
# 1.1.8 → 1.1.9
# [tudo automático]
# Versão sincronizada na loja
```

### ✨ Deploy com Minor Version

```bash
npm run deploy "Feature: Nova seção trust-strip" --minor

# Resultado:
# 1.1.8 → 1.2.0
# [tudo automático]
```

### 🧪 Testar sem Executar (DRY-RUN)

```bash
npm run deploy:dry "Descrição"

# NÃO FAZ:
# ❌ Git commit/push
# ❌ Backup
# ❌ Deploy FTP real
# ✅ Mostra o que FARIA

# Útil para:
# - Verificar quais arquivos seriam deployados
# - Testar sem risco
# - CI/CD simulation
```

### 🎯 Skip Confirmações (Force)

```bash
npm run deploy "Descrição" --force

# NÃO pede confirmação antes de git push
# Útil para: CI/CD automático
```

---

## Setup Inicial

### 1. Criar `.env` com Credenciais

```bash
# Copiar template:
cp ftp-deploy/.env.example ftp-deploy/.env

# Editar com suas credenciais:
FTP_HOST=ftp.nuvemshop.com.br
FTP_PORT=21
FTP_USER=patagang
FTP_PASSWORD=Q88gP0Ud
FTP_SECURE=true
```

**❌ NUNCA commitar `.env`** — está em `.gitignore`

### 2. Instalar Dependências

```bash
npm install     # ou yarn/pnpm
```

### 3. Testar Conexão

```bash
npm run deploy:dry "Test: Verificar setup"

# Se aparecer "✅ SUCESSO", está pronto!
```

---

## Scripts Disponíveis

| Script | Comando | Uso |
|--------|---------|-----|
| **deploy** | `npm run deploy` | Deploy normal (patch version) |
| **deploy:dry** | `npm run deploy:dry` | Simular sem executar |
| **deploy:minor** | `npm run deploy:minor` | Incrementar versão minor |
| **deploy:force** | `npm run deploy:force` | Skip confirmações |
| **backup** | `npm run backup` | Backup completo do FTP |
| **rollback** | `npm run rollback` | Restaurar versão anterior |
| **list** | `npm run list` | Listar backups disponíveis |
| **validate** | `npm run validate` | Validar Nuvemshop constraints |

---

## Versão Atual

Verifique a versão em qualquer arquivo:

**Em arquivo:**
```bash
cat theme-deploy-corrigido/VERSION.json

# {
#   "version": "1.1.9",
#   "deployment_date": "2026-03-21T02:46:17.944Z",
#   "git_commit": "35ec426ccce...",
#   "console_message": "📦 PATAGANG v1.1.9 (21/03/2026) ✅"
# }
```

**Na loja (console do navegador):**
```javascript
// F12 → Console → procure por:
// 📦 PATAGANG v1.1.9 (21/03/2026) ✅

// Ou acesse:
window.__PATAGANG_VERSION__  // "1.1.9"
```

---

## Validação em Produção

Após executar `npm run deploy`:

### 1. Limpar Cache do Navegador
```
Windows: Ctrl + Shift + Delete (Settings > Storage > Clear)
Mac:     Cmd + Shift + Delete
Firefox: Ctrl + H > Settings
```

Ou diretamente na página:
```
Windows: Ctrl + F5 (Hard Refresh)
Mac:     Cmd + Shift + R
```

### 2. Verificar Versão no Console
```javascript
F12 → Console tab
Procure por: 📦 PATAGANG v1.1.9 (21/03/2026) ✅

Se vê a mensagem → ✅ Deploy bem-sucedido!
```

### 3. Validar Elementos (caso a caso)
Dependendo da story deployada:
- ✅ Elemento novo aparece?
- ✅ Cores/estilos corretos?
- ✅ Espaçamento OK?
- ✅ Responsivo no mobile?

---

## Troubleshooting

### ❌ "Credenciais FTP não configuradas"

```
Solução:
1. Verificar que ftp-deploy/.env existe
2. Verificar que contém FTP_USER e FTP_PASSWORD
3. Confirmar valores corretos
4. Rodar npm install (instala dotenv)
```

### ❌ "Nenhum arquivo modificado"

```
Possíveis causas:
1. Commits não foram feitos (fazer: git commit)
2. Modificações em arquivos fora de theme-deploy-corrigido/
3. Já foi deployado (versão nova de um deploy antigo)

Solução:
1. Fazer git commit das mudanças
2. Rodar npm run deploy:dry "Descrição" novamente
```

### ❌ "Erro ao conectar FTP"

```
Causas comuns:
1. FTP credentials erradas (verificar .env)
2. Servidor Nuvemshop offline (incomum)
3. Timeout de rede (tentar novamente)

Solução:
1. Verificar credentials: cat ftp-deploy/.env
2. Testar com deploy:dry primeiro
3. Tentar novamente (timeout é intermitente)
```

### ❌ "Versão não atualiza no console"

```
99% dos casos: Cache do navegador

Solução:
1. Ctrl + F5 (ou Cmd+Shift+R no Mac)
2. Limpar cache em Settings > Storage > Clear
3. Abrir em abas anônima/incognito para testar
```

### ❌ "Deploy reportou erro mas arquivo foi ao FTP"

```
Pode acontecer se:
- Validação falhou por timeout (mas file já estava lá)
- FTP desconectou mas upload foi antes

Verificar:
1. npm run list           (listar backups)
2. Abrir painel Nuvemshop (verificar arquivo manualmente)
```

---

## Estrutura de Backup

```
backups/
└── deployment-1.1.9/
    └── 2026-03-21T023422-123/
        ├── layouts/
        ├── templates/
        ├── snipplets/
        ├── static/js/version-info.js
        └── _METADATA.json    ← timestamp, hashes, versão anterior, etc
```

**Para restaurar:**
```bash
npm run rollback          # seleciona versão anterior automaticamente
```

---

## Integration com AIOX Framework

Este sistema segue os padrões **AIOX** do projeto:

| Princípio | Implementado |
|-----------|--------------|
| **CLI First** | ✅ Apenas npm/node commands |
| **Story-Driven** | ✅ Detecta story do branch |
| **Quality First** | ✅ Validação pós-deploy |
| **No Invention** | ✅ Apenas consolidação de funcionalidade |
| **Português** | ✅ Mensagens e docs em PT-BR |

---

## Commits Relacionados

```
2375b4f feat: refatorar deploy.js com 6 fases (AIOX v2.0)
d60a5e6 chore: atualizar package.json com scripts
35ec426 security: implementar credenciais FTP via .env
3574b68 chore: remover arquivos legados de deployment
```

---

## Suporte & Documentação Completa

- **Documentação AIOX:** `docs/guides/nuvemshop/deployment-workflow.md`
- **Task Framework:** `.aiox-core/development/tasks/deploy-ftp-standard.md`
- **Workflow Definition:** `.aiox-core/development/workflows/ftp-deployment.yaml`

---

**Versão:** 2.0.0
**Data:** 21 de Março de 2026
**Status:** ✅ Production Ready
