---
title: Workflow de Deployment FTP para Nuvemshop Patagang
category: Nuvemshop
description: Guia completo do sistema de versionamento e deploy automático v2.0
---

# 🚀 Workflow de Deployment FTP — Patagang Nuvemshop v2.0

> **AIOX-Compliant** — Sistema de versionamento e deploy automático via FTP

## Overview

Este guia documenta o workflow **completo** de desenvolvimento, versionamento e deployment para a loja Patagang no Nuvemshop.

**Simplificado:**
```
Alterar tema → git commit → npm run deploy → Validar na loja
```

---

## 1. Setup Inicial (Uma Vez)

### 1.1 Clonar Repositório

```bash
git clone https://github.com/SolucoesSistemas/patagang-ecommerce-nuvemshop.git
cd patagang-ecommerce-nuvemshop
```

### 1.2 Criar Arquivo .env com Credenciais

```bash
cd ftp-deploy
cp .env.example .env
```

Editar `ftp-deploy/.env`:
```bash
FTP_HOST=ftp.nuvemshop.com.br
FTP_PORT=21
FTP_USER=patagang
FTP_PASSWORD=Q88gP0Ud    # Usar credenciais reais
FTP_SECURE=true
```

**⚠️ Importante:** `.env` está em `.gitignore` — NUNCA será commitado

### 1.3 Instalar Dependências

```bash
npm install
cd ftp-deploy && npm install && cd ..
```

### 1.4 Validar Setup

```bash
cd ftp-deploy
npm run deploy:dry "Test: Validar setup"
```

Se aparecer `✅ SUCESSO`, está pronto!

---

## 2. Workflow Diário (Developer)

### Passo 1: Alterar Tema

```bash
# Editar arquivos do tema:
# - theme-deploy-corrigido/layouts/*
# - theme-deploy-corrigido/templates/*
# - theme-deploy-corrigido/snipplets/*
# - theme-deploy-corrigido/static/css/*
# - theme-deploy-corrigido/static/js/*
```

**Onde editar:**
- Layouts: `theme-deploy-corrigido/layouts/`
- Templates: `theme-deploy-corrigido/templates/`
- Snippets: `theme-deploy-corrigido/snipplets/`
- CSS: `theme-deploy-corrigido/static/css/`
- JavaScript: `theme-deploy-corrigido/static/js/`

**❌ NUNCA editar:**
- Arquivos de checkout (constraints Nuvemshop)
- Arquivo VERSION.json (auto-updated)
- version-info.js (auto-updated)

### Passo 2: Git Commit (Local)

```bash
git status                          # ver mudanças
git add theme-deploy-corrigido/*    # staged
git commit -m "fix: descrição"      # commit
```

**Convenção de commit:**
- `fix:` Bug fix
- `feat:` Nova feature
- `style:` Mudança CSS/visual
- `docs:` Documentação
- `chore:` Alteração de build/infra

Exemplo:
```bash
git commit -m "fix: Ajustar cores do botão help sidebar"
git commit -m "feat: Adicionar nova seção trust-strip"
```

### Passo 3: Deploy (com validação)

```bash
cd ftp-deploy

# Opção A: Simular primeiro (recomendado)
npm run deploy:dry "Descrição da mudança"

# Se OK, fazer deploy real
npm run deploy "Descrição da mudança"
```

**Flags disponíveis:**
```bash
# Patch version (1.1.8 → 1.1.9)
npm run deploy "Descrição"

# Minor version (1.1.8 → 1.2.0)
npm run deploy "Descrição" --minor

# Simular sem executar
npm run deploy:dry "Descrição"

# Skip confirmações (CI/CD)
npm run deploy "Descrição" --force
```

### Passo 4: Validar na Loja

```
1. Abrir loja: https://patagang.com.br/
2. F12 → Console
3. Procure por: 📦 PATAGANG v1.1.X
4. Se não vir, limpe cache:
   - Ctrl+Shift+Delete (Settings > Storage > Clear)
   - Ou Ctrl+F5 (Hard Refresh)
```

---

## 3. O Que Acontece no Deploy (6 Fases)

Quando você executa `npm run deploy "Descrição"`, automaticamente:

### Fase 0️⃣ — Validação de Contexto
- ✅ Detecta story do branch (se em branch como `story-1.1.1-fix`)
- ✅ Valida que credenciais FTP estão em `.env`
- ✅ Verifica que está em repositório git

### Fase 1️⃣ — Detectar Arquivos Modificados
```bash
git diff --name-only HEAD -- theme-deploy-corrigido/
```
- ✅ Lista todos arquivos que você alterou
- ✅ Sempre inclui `version-info.js` (para console message)
- ✅ Se nenhum arquivo → abola (você não alterou nada)

### Fase 2️⃣ — Auto-Increment de Versão
```
Versão atual:  1.1.8
Após deploy:   1.1.9  (patch)
Ou --minor:    1.2.0  (feature)
```
- ✅ Incrementa automaticamente
- ✅ Atualiza `VERSION.json`
- ✅ Sincroniza `version-info.js` com nova versão

### Fase 3️⃣ — Git Commit + Tag + Push
```bash
git commit "chore: bump version to 1.1.9"
git tag v1.1.9
git push origin main --tags
```
- ✅ **Pede confirmação antes de push**
- ✅ Você pode cancelar e fazer `git push` manualmente depois
- ✅ Tag é criada para cada versão

### Fase 4️⃣ — Backup Incremental
```
backups/deployment-1.1.9/2026-03-21T023422/
├── layouts/...
├── templates/...
├── static/js/version-info.js
└── _METADATA.json
```
- ✅ Baixa versão anterior do FTP
- ✅ Salva com metadados (timestamps, hashes)
- ✅ Permite rollback rápido

### Fase 5️⃣ — Deploy para FTP
- ✅ Upload de todos os arquivos detectados
- ✅ Timeout 30 segundos por arquivo
- ✅ Retry automático se falhar

### Fase 6️⃣ — Validação Pós-Deploy
- ✅ Re-download de cada arquivo do FTP
- ✅ Valida que tudo foi deployado
- ✅ Confirma integridade (tamanho, etc)

---

## 4. Rollback (Se Algo Deu Errado)

Se o deploy teve problema e você quer voltar para versão anterior:

```bash
cd ftp-deploy
npm run rollback

# Seleciona versão anterior e restaura automaticamente
```

**Ou manualmente:**
```bash
# Listar backups disponíveis
npm run list

# Restaurar backup específico
npm run rollback  # escolhe interativamente
```

---

## 5. Variações Comuns

### Deploy com Mensagem em Português

```bash
npm run deploy "Fix: Ajustar espaçamento do header"
npm run deploy "Feature: Adicionar banner de promoção"
npm run deploy "Style: Alterar cor do botão checkout"
```

### Deploy Urgente (Skip Confirmações)

```bash
npm run deploy "Fix: Urgente" --force
# Não pede confirmação, faz tudo automático
```

### Testar Deploy Antes de Executar

```bash
# Simula tudo, mas não modifica nada
npm run deploy:dry "Descrição da mudança"

# Saída mostrará:
# - Quais arquivos seriam deployados
# - Nova versão que seria criada
# - Tudo sem realmente fazer
```

### Deploy com Minor Version

```bash
# Para features maiores, incrementa versão minor
npm run deploy "Feature: Nova seção trust-strip" --minor
# 1.1.8 → 1.2.0
```

---

## 6. Scripts Disponíveis

### Principais

| Script | Descrição |
|--------|-----------|
| `npm run deploy` | Deploy normal (incrementa patch) |
| `npm run deploy:dry` | Simula sem executar |
| `npm run deploy:minor` | Deploy com minor version |
| `npm run deploy:force` | Deploy sem confirmações |

### Backup & Rollback

| Script | Descrição |
|--------|-----------|
| `npm run backup` | Fazer backup completo do FTP |
| `npm run rollback` | Restaurar versão anterior |
| `npm run list` | Listar todos os backups |
| `npm run list:all` | Listar com detalhes completos |

### Validação

| Script | Descrição |
|--------|-----------|
| `npm run validate` | Validar constraints Nuvemshop |

---

## 7. Troubleshooting

### ❌ "Arquivo não aparece no FTP"

```
Causa comum: Cache do navegador
Solução:
1. F12 → Console → clear()
2. Ctrl+F5 (hard refresh)
3. Limpar cache em Settings > Storage > Clear
```

### ❌ "Deploy falhou com timeout"

```
Causa: Servidor FTP temporariamente indisponível
Solução:
1. Tentar novamente: npm run deploy "Descrição"
2. Se persistir, verificar .env (credentials)
3. Contatar suporte Nuvemshop
```

### ❌ "Não consigo fazer git push"

```
Solução rápida:
1. npm run deploy "Descrição"
2. No prompt, pressione 'n' (cancel push)
3. Faça manualmente: git push origin main --tags
```

### ❌ "Version não atualiza no console"

```
99% é cache do navegador:
1. Abrir em aba incognito/privado
2. Ctrl+Shift+Delete (limpar cache)
3. Ou esperar 24h (cache HTTP)
```

### ❌ ".env não existe"

```
Solução:
1. cd ftp-deploy
2. cp .env.example .env
3. Editar .env com credenciais reais
4. Tentar novamente
```

---

## 8. Constraints Nuvemshop

Existem modificações que **NÃO SÃO PERMITIDAS** no Nuvemshop:

❌ **NUNCA modificar:**
- Estrutura do checkout (formas de pagamento)
- Atributo de footer (attribution Nuvemshop)
- Campos de formulário (contato, registro)
- Arquivo sitemap.xml, robots.txt

✅ **SEGURO modificar:**
- CSS/cores/fonts
- Layouts e positioning
- Imagens e assets
- Templates não-críticas

**Validação automática:**
```bash
npm run validate
# Verifica se você violou algum constraint
```

Para mais detalhes, ver: `.claude/rules/nuvemshop-ftp-constraints.md`

---

## 9. Referências & Documentação

### Dentro do Projeto
- **Deploy CLI:** `ftp-deploy/README-DEPLOYMENT.md`
- **Scripts disponíveis:** `ftp-deploy/package.json`
- **Constraints:** `.claude/rules/nuvemshop-ftp-constraints.md`
- **Config FTP:** `ftp-deploy/config.js` (ver .env)

### AIOX Framework
- **Framework Architecture:** `.aiox-core/constitution.md`
- **Agent Authority:** `.claude/rules/agent-authority.md`
- **Story-Driven:** `docs/stories/`

### Nuvemshop
- **Admin:** https://patagang.com.br/admin
- **Documentation:** https://help.nuvemshop.com.br

---

## 10. FAQ

**P: Preciso fazer backup antes de cada deploy?**
R: Não, o deploy.js faz backup automático na Fase 4.

**P: Posso editar VERSION.json manualmente?**
R: Não, é auto-updated no deploy. Editar arquivo deploy.js só se você sabe o que está fazendo.

**P: Quanto tempo leva o deploy?**
R: ~30-60 segundos (depende do tamanho dos arquivos).

**P: Posso fazer deploy de múltiplos branches?**
R: Sim, cada branch tem sua history de commits. Deploy detecta automaticamente.

**P: Como reversão rápida?**
R: `npm run rollback` restaura versão anterior em segundos.

**P: Posso deployar sem git push?**
R: Sim, o deploy.js pede confirmação. Você pode cancelar o push e fazê-lo manualmente.

---

## Resumo Rápido

```bash
# 1. Fazer mudanças
vi theme-deploy-corrigido/templates/product.tpl

# 2. Git commit
git commit -am "fix: descrição"

# 3. Deploy (com teste primeiro)
cd ftp-deploy
npm run deploy:dry "Descrição"
npm run deploy "Descrição"

# 4. Validar
# → Abrir loja em https://patagang.com.br/
# → F12 → Console
# → Procure por: 📦 PATAGANG v1.1.X ✅

# Pronto! Deploy completo e validado.
```

---

**Versão:** 2.0.0
**Data:** 21 de Março de 2026
**Framework:** AIOX v2
**Status:** ✅ Production Ready
