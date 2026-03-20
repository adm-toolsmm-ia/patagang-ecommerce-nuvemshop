# 📌 Rastreamento de Versões - Patagang Nuvemshop

**Última atualização:** 2026-03-20T18:30:00Z

---

## 🔄 Histórico de Deploys

### Deploy #2: Version Simplification Test ✅

| Item | Valor |
|------|-------|
| **Versão Anterior** | `1.1.2` |
| **Versão Nova** | `1.1.3` |
| **Data Deploy** | 2026-03-20T18:35:00Z |
| **Arquivo(s)** | `static/js/version-info.js` |
| **Tempo** | < 2 segundos |
| **Backup** | Nenhum (arquivo pequeno) |
| **Status** | ✅ Enviado para FTP com sucesso |

**Como validar no console:**
```javascript
window.__PATAGANG_VERSION__
// Deve mostrar: "1.1.3"
```

**No console verá:**
```
📦 PATAGANG v1.1.3
```

---

### Deploy #1: AIOX Standard Deploy Test ✅

| Item | Valor |
|------|-------|
| **Versão Anterior** | `1.1.1` (PDP Layout Fix) |
| **Versão Nova** | `1.1.2-AIOX-STANDARD-DEPLOY-TEST` |
| **Data Deploy** | 2026-03-20T18:30:00Z |
| **Arquivo(s)** | `layouts/layout.tpl` |
| **Commit** | `9502c44-DEPLOY-TEST` |
| **Status** | ✅ Enviado para FTP com sucesso |
| **Backup** | `backups/incremental/2026-03-20T21-20-48/` |

**Como validar no console:**
```javascript
window.__PATAGANG_VERSION__
// Esperar: { version: "1.1.2-AIOX-STANDARD-DEPLOY-TEST", ... }
```

**Checklist de validação:**
- [ ] Versão atualizada no console
- [ ] Cache Nuvemshop limpo
- [ ] Aguardou 3-5 minutos de propagação
- [ ] Nenhum erro em F12 (Console)
- [ ] Responsividade validada

---

## 🎯 Como será o padrão daqui em diante

**Toda vez que fizermos um deploy, você receberá:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📌 DEPLOY REALIZADO

Versão Anterior:  1.1.1 (PDP Layout Fix)
Versão Nova:      1.1.2-AIOX-STANDARD-DEPLOY-TEST ✅
Data/Hora:        2026-03-20T18:30:00Z
Arquivo(s):       layouts/layout.tpl
Backup:           2026-03-20T21-20-48/ ✅
Status:           ✅ SUCESSO

🔍 Para validar no console do navegador:
   window.__PATAGANG_VERSION__

📋 Checklist rápido:
   [ ] Limpar cache Nuvemshop (Admin → Temas → Limpar Cache)
   [ ] Aguardar 3-5 minutos
   [ ] Validar versão no console
   [ ] Testar em desktop e mobile

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## 🚀 Próximas Ações

1. **Agora:**
   - Limpe o cache Nuvemshop: Admin → Temas → Menu (⋯) → Limpar Cache
   - Aguarde 3-5 minutos

2. **Depois:**
   - Abra a loja no navegador
   - Pressione F12 (DevTools)
   - Na aba Console, execute: `window.__PATAGANG_VERSION__`
   - Confirme que versão é: `1.1.2-AIOX-STANDARD-DEPLOY-TEST`

3. **Teste:**
   - Valide responsividade (desktop + mobile)
   - Procure por erros em F12
   - Teste funcionalidades críticas (busca, carrinho, checkout)

---

## 📊 Referência Rápida

| Versão | Descrição | Status |
|--------|-----------|--------|
| 1.1.1 | PDP Layout Fix | ✅ Anterior |
| 1.1.2-AIOX-STANDARD-DEPLOY-TEST | Teste de Deploy AIOX | ✅ Atual |

---

**Quando fizer o próximo deploy, você terá um resumo como este!** 🎯
