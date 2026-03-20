# 📦 Fluxo de Versionamento - PATAGANG Nuvemshop

## Visão Geral

Sistema **simples, único e automático** de versionamento que mantém a versão sincronizada entre o projeto e o console da loja.

---

## 🎯 Objetivo

Garantir que:
- ✅ Versão no console (`📦 PATAGANG v1.1.3`) coincide com as mudanças reais
- ✅ Cada deploy atualiza automaticamente a versão visível
- ✅ Uma única fonte de verdade (VERSION.json)
- ✅ Sem conflitos de múltiplas versões

---

## 📋 Fluxo de Deploy

### **ANTES de fazer deploy:**

```bash
# 1. Na pasta ftp-deploy/, sincronize a versão
cd ftp-deploy/
node sync-version.js 1.1.4

# Saída esperada:
# 🔄 Sincronizando versão para: 1.1.4
# ✅ VERSION.json atualizado para v1.1.4
# ✅ version-info.js atualizado para v1.1.4
# ✅ VERSION arquivo atualizado
# ✨ Sincronização concluída!
```

### **DEPOIS de sincronizar:**

```bash
# 2. Faça o deploy normalmente
npm run deploy:critical

# Saída esperada:
# 🚀 Deploy CRITICAL ONLY - 2 arquivos
# ✅ Conectado ao FTP
# ✅ Enviado: /layouts/layout.tpl
# ✅ Enviado: /static/js/version-info.js
# ✨ Deploy concluído!
```

---

## ✅ Checklist Pós-Deploy

Após enviar para FTP, valide no console do navegador:

```
1. ☐ Limpe cache Nuvemshop (Admin → Temas → Menu ⋯ → Limpar Cache)
2. ☐ Aguarde 3-5 minutos de propagação
3. ☐ Abra a loja no navegador (incógnito se possível)
4. ☐ Pressione F12 (DevTools) → Console
5. ☐ Procure pela linha: 📦 PATAGANG v1.1.4
6. ☐ Confirme que a versão coincide com o que enviou
```

**Para validar programaticamente no console:**
```javascript
window.__PATAGANG_VERSION__.version  // Deve retornar "1.1.4"
```

---

## 📁 Arquivos Envolvidos

| Arquivo | Propósito | Atualizado por |
|---------|-----------|---|
| `ftp-deploy/VERSION` | Fonte única de verdade da versão | `sync-version.js` |
| `theme-deploy-corrigido/VERSION.json` | Metadados completos | `sync-version.js` |
| `theme-deploy-corrigido/static/js/version-info.js` | Exibição no console | `sync-version.js` |
| `theme-deploy-corrigido/layouts/layout.tpl` | Carrega version-info.js | Manual (raro) |

### ❌ Removidos (conflitos antigos)
- `ftp-deploy/LAST_DEPLOY_VERSION.txt` (não usado)
- Comentário de versão em layout.tpl (removido)

---

## 🔧 Trocando de Versão

Sempre que precisar de nova versão:

```bash
# 1. Edite a versão desejada
echo "1.1.5" > ftp-deploy/VERSION

# 2. Sincronize
node ftp-deploy/sync-version.js 1.1.5

# 3. Faça as mudanças no código
# ... edite arquivos ...

# 4. Deploy
npm run deploy:critical

# 5. Valide no console da loja
```

---

## 🎛️ Troubleshooting

### Versão no console ainda mostra a antiga

**Causa:** Cache Nuvemshop ou navegador

**Solução:**
```
1. Admin Nuvemshop → Temas → Menu (⋯) → Limpar Cache
2. Espere 3-5 minutos
3. Abra a loja em aba incógnita (Ctrl+Shift+N)
4. Pressione Ctrl+Shift+Delete → Limpar cache local
5. Recarregue a página
```

### Script sync-version.js falha

**Causa:** Path incorreto ou arquivo não existe

**Solução:**
```bash
# Certifique-se que está na pasta ftp-deploy/
cd ftp-deploy/
node sync-version.js 1.1.6
```

### Deploy envia arquivo antigo

**Causa:** Versão não foi sincronizada antes do deploy

**Solução:**
```bash
# Sempre execute ANTES de deploy
node sync-version.js [nova-versao]
npm run deploy:critical
```

---

## 📊 Histórico de Versões

| Versão | Data | Mudanças |
|--------|------|----------|
| 1.1.3 | 2026-03-20 | Sistema de versionamento consolidado |
| 1.1.2 | 2026-03-20 | Version Simplification Test |
| 1.1.1 | 2026-03-20 | PDP Layout Fix |

---

## 👥 Orquestração da Equipe

### **Para Desenvolvedores (@dev)**
1. Quando atualizar código → comunique a nova versão
2. Antes de fazer deploy → avise o DevOps com o número da versão

### **Para DevOps (@devops)**
1. Receba a versão do @dev
2. Execute: `node ftp-deploy/sync-version.js [versao]`
3. Execute: `npm run deploy:critical`
4. Valide no console da loja

### **Para QA (@qa)**
1. Após deploy → valide versão no console
2. Se versão estiver desatualizada → avise DevOps para limpar cache
3. Documente na história: "✅ Versão v1.1.X confirmada no console"

---

## 🚀 Próximos Deploys

Para cada novo deploy:

```bash
# 1. Determine a nova versão (1.1.X)
# 2. Sincronize
node ftp-deploy/sync-version.js 1.1.X
# 3. Deploy
npm run deploy:critical
# 4. Valide no console (F12 → Console → 📦 PATAGANG vX.X.X)
```

---

**Sistema atualizado:** 2026-03-20
**Versão atual:** 1.1.3
