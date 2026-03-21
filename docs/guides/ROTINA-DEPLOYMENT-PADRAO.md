# 🚀 Rotina Padrão de Deployment — GitHub + FTP Sincronizados

**Versão:** 1.0
**Data:** 2026-03-21
**Aplicável:** Sempre que houver alterações de código + novo versionamento

---

## 📌 Princípio

**UMA ÚNICA ROTINA que sincroniza versionamento em 3 lugares:**
1. **GitHub** — Commit + Tag com versão
2. **VERSION.json** — Source of truth da versão
3. **version-info.js** — Exibe versão no console do navegador
4. **FTP Nuvemshop** — Servidor de produção

**Resultado:** Versão é idêntica em GitHub, código local e loja.

---

## 🔄 ROTINA PADRÃO (8 Passos)

### **PASSO 1: Fazer alterações no código**
```bash
# Editar arquivos theme-deploy-corrigido/
# Exemplo: product.tpl, style-critical.tpl, etc.
```
✅ **Checkpoint:** Alterações feitas e testadas localmente

---

### **PASSO 2: Decidir nova versão**
```
Versão anterior: 1.1.6
Nova versão: 1.1.7  ← DECIDIR AQUI
(Ou 1.2.0 para feature, 1.1.7 para fix, etc.)
```

---

### **PASSO 3: Atualizar VERSION.json**
**Arquivo:** `theme-deploy-corrigido/VERSION.json`

Atualizar SEMPRE:
- `version`: "1.1.6" → "1.1.7"
- `deployment_date`: Data/hora atual
- `git_commit`: "bc30860" → Será preenchido em PASSO 5 após o commit
- `console_message`: "v1.1.6 — ..." → "v1.1.7 — [descrição]"
- `recent_changes`: Adicionar novo change com ID incremental

```json
{
  "version": "1.1.7",
  "deployment_date": "2026-03-21T02:20:00.000Z",
  "git_commit": "PENDING_NEW_COMMIT",
  "console_message": "📦 PATAGANG v1.1.7 — PDP Final Adjustments ✅"
}
```

✅ **Checkpoint:** VERSION.json atualizado

---

### **PASSO 4: Atualizar version-info.js**
**Arquivo:** `theme-deploy-corrigido/static/js/version-info.js`

Atualizar SEMPRE:
- `const VERSION = "1.1.6"` → `"1.1.7"`
- `const DEPLOY_DATE = "2026-03-20"` → Data atual
- `const GIT_COMMIT = "bc30860"` → Será preenchido em PASSO 5
- `const GIT_TAG = "v1.1.6-..."` → Nova tag `"v1.1.7-..."`

```javascript
const VERSION = "1.1.7";
const DEPLOY_DATE = "2026-03-21";
const GIT_COMMIT = "PENDING_NEW_COMMIT";
const GIT_TAG = "v1.1.7-pdp-final-adjustments";
```

✅ **Checkpoint:** version-info.js atualizado

---

### **PASSO 5: Git Commit com versão e descrição**
```bash
cd patagang-ecommerce-nuvemshop

git add -A

git commit -m "fix: Ajustes finais PDP v1.1.7 - textos trust-strip, espaço vazio, Konfidence

- [Descrição detalhada das mudanças]
- [Mais um ponto]
- [Etc]

Story: PDP Final Adjustments (1-3)
Co-Authored-By: @dev (Dex) <noreply@anthropic.com>"
```

**Resultado esperado:**
```
[main 68adc66] fix: Ajustes finais PDP v1.1.7
5 files changed
```

✅ **Checkpoint:** Commit criado — copiar o **HASH** (ex: 68adc66)

---

### **PASSO 6: Criar Git Tag**
```bash
git tag -a v1.1.7-pdp-final-adjustments -m "PDP Final Adjustments: Trust-strip texts, layout gap fix, Konfidence removal"
```

✅ **Checkpoint:** Tag criada com sucesso

---

### **PASSO 7: Git Push (GitHub)**
```bash
git push origin main
git push origin v1.1.7-pdp-final-adjustments
```

**Resultado esperado:**
```
bc30860..68adc66  main -> main
 * [new tag]      v1.1.7-pdp-final-adjustments -> v1.1.7-pdp-final-adjustments
```

✅ **Checkpoint:** GitHub atualizado com commit e tag

---

### **PASSO 8A: Atualizar hash nos arquivos de versionamento**
**Agora que temos o commit hash: 68adc66**

Atualizar em:
- `VERSION.json`: `"git_commit": "PENDING_NEW_COMMIT"` → `"git_commit": "68adc66"`
- `version-info.js`: `const GIT_COMMIT = "PENDING_NEW_COMMIT"` → `const GIT_COMMIT = "68adc66"`

✅ **Checkpoint:** Hash final registrado

---

### **PASSO 8B: FTP Deploy**
```bash
cd ftp-deploy

# Usa a versão em theme-deploy-corrigido/VERSION.json automaticamente
npm run deploy

# Ou manualmente:
node deploy.js 1.1.7
```

**Resultado esperado:**
```
FASE 1: Sincronizar versão ✓
FASE 2: Backup incremental ✓
FASE 3: Deploy para FTP ✓
FASE 4: Validação pós-deploy ✓

✅ SUCESSO — v1.1.7
```

✅ **Checkpoint:** Arquivos deployados no FTP Nuvemshop

---

## ✅ CHECKLIST FINAL

```
□ Código alterado e testado localmente
□ VERSION.json atualizado com v1.1.7
□ version-info.js atualizado com v1.1.7
□ Git commit feito com nova versão
□ Git tag criada (v1.1.7-pdp-final-adjustments)
□ GitHub atualizado (push commit + tag)
□ Hash do commit registrado em VERSION.json e version-info.js
□ FTP deploy executado com sucesso
□ 4/4 arquivos validados no FTP
□ Versão visível no console: window.__PATAGANG_VERSION__
```

---

## 🔍 VALIDAÇÃO NO NAVEGADOR

Após deploy, validar:

```javascript
// Console do navegador (F12)
window.__PATAGANG_VERSION__

// Deve retornar:
{
  version: "1.1.7",
  date: "2026-03-21",
  git_commit: "68adc66",
  git_tag: "v1.1.7-pdp-final-adjustments",
  timestamp: "2026-03-21T...",
  environment: "production"
}
```

---

## 📝 NOTAS IMPORTANTES

1. **NUNCA deixar "PENDING_NEW_COMMIT"** — Sempre preencher com hash real após commit
2. **Versionamento deve ser IDÊNTICO** em:
   - GitHub tag
   - VERSION.json
   - version-info.js
3. **FTP deploy SEMPRE após GitHub push** — Ordem importa para rastreabilidade
4. **Backup incremental criado automaticamente** — Checar em `backups/deployment-1.1.7/`
5. **Cache Nuvemshop:** Pode levar 2-5 minutos para atualizar na loja

---

## 🆘 TROUBLESHOOTING

### ❌ "Versão no console diferente da tag"
**Causa:** Hash em version-info.js não foi atualizado
**Solução:** Atualizar version-info.js com hash correto + re-deploy

### ❌ "FTP deploy falha com credenciais"
**Causa:** Credenciais vencidas em ftp-deploy/config.js
**Solução:** Atualizar credenciais em ftp-deploy/config.js com valores atuais

### ❌ "version-info.js não aparece no navegador"
**Causa:** Cache do navegador
**Solução:** Ctrl+Shift+R (hard refresh) ou limpar cache manualmente

---

**Rotina Padrão v1.0 — Segue este fluxo para TODOS os deployments com versionamento**

— Orion, Orchestrator 🎯
