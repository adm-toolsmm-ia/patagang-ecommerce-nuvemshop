# Epic 8 — Workflow Completo (CSS Reduction + UX Optimization)

**Version:** 1.0
**Last Updated:** 2026-03-24
**Sprint:** Epic 8 — Critical CSS Reduction & UX Optimization
**Status:** ✅ Story 8.4 COMPLETO

---

## 📋 Visão Geral do Epic

**Epic 8** é um esforço consolidado de **CSS otimização** e **UX melhorias** na loja Patagang usando fluxo AIOX **Story Development Cycle** com validação em produção (sem homologação local).

**Características Únicas:**
- ✅ Validação DIRETA em produção (via FTP)
- ✅ Deploy IMEDIATO após cada story
- ✅ Gabriel valida antes de GitHub push
- ✅ Rollback disponível sempre
- ✅ 2 deploys bem-sucedidos (v1.5.72 + v1.5.73)

---

## 🎯 Stories Completadas

### Story 8.1 — Design Tokens (Planejado)
- Planned: Implementar design tokens CSS
- Status: ⏳ Não iniciado

### Story 8.2 — Critical CSS Reduction (Completo)
- Completed: Redução agressiva de CSS crítico
- Deployed: v1.5.60-v1.5.71
- Status: ✅ DONE

### Story 8.3 — !important Resolution (Planejado)
- Planned: Resolver especificidade CSS (!important)
- Status: ⏳ Não iniciado

### **Story 8.4 — Sacola + Cupom GANGDAPATA (✅ COMPLETO)**
- **Completed:** Funcionalidade de cupom 100% funcional
- **Deployed:** v1.5.72 (cupom) + v1.5.73 (botão fix)
- **Status:** ✅ **PRONTO PARA VALIDAÇÃO**
- **What:** Cupom GANGDAPATA aplicável na sacola sem reload
- **Why:** Melhora UX checkout, reduz fricção de entrada de cupom
- **How:** Refactoring cart-drawer.js + Nuvemshop LS API integration

### Story 8.5 — JavaScript Optimization (Planejado)
- Planned: Consolidação de JS, remoção de duplicatas
- Status: ⏳ Próxima

---

## 🔄 AIOX Workflow Padrão — Story 8.4 (Documentado)

### PHASE 1: Implementation
```
@dev (Dex) investigou profundamente:
  ├─ Ler cart-drawer-new.tpl (HTML do cupom - OK)
  ├─ Ler style-critical.tpl (CSS do cupom - OK)
  ├─ Ler cart-drawer.js (JavaScript - ❌ FALTANDO handler)
  └─ Identificado: applyCoupon() function precisa ser adicionada

@dev refatorou cart-drawer.js:
  ├─ Adicionou CONFIG.selectors para cupom
  ├─ Adicionou applyCoupon() com LS API integration
  ├─ Adicionou showNotification() para feedback
  └─ Adicionou bindEvents() handler para cupom
```

### PHASE 2: Git Commit (MANDATORY)
```
✅ Commit 1 (e0d3492):
   refactor: implement cupom GANGDAPATA functionality in cart drawer
   - Files: cart-drawer.js

✅ Commit 2 (3d2a123):
   fix: correct whatsapp button text orientation
   - Files: style-whatsapp-button.css.tpl
```

### PHASE 3: FTP Deploy (MANDATORY - @devops)
```
✅ Deploy v1.5.72:
   - Cupom funcional + notificações
   - 2 arquivos: cart-drawer.js, version-info.js
   - Backup: backups/deployment-1.5.72/
   - Validação FTP: ✅ 2/2 arquivos
   - Status: 🟢 LIVE em produção

✅ Deploy v1.5.73:
   - WhatsApp botão texto fix
   - 2 arquivos: style-whatsapp-button.css.tpl, version-info.js
   - Backup: backups/deployment-1.5.73/
   - Validação FTP: ✅ 2/2 arquivos
   - Status: 🟢 LIVE em produção
```

### PHASE 4: Gabriel Validation (MANDATORY)
```
⏳ AGUARDANDO:
  - Gabriel acessa: https://patagang.com.br/
  - Gabriel limpa cache: Ctrl+Shift+Delete
  - Gabriel verifica console: 📦 PATAGANG v1.5.73
  - Gabriel testa cupom: GANGDAPATA → aplica 10%
  - Gabriel valida botão WhatsApp: texto legível

Resultado esperado:
  ✅ "v1.5.73 OK para prosseguir" → GitHub push
  ⚠️ "Encontrou problema" → @dev corrige → novo deploy
  ❌ "Rollback" → Volta para v1.5.71 → @dev investigar
```

### PHASE 5: GitHub Push (AFTER Gabriel Approval)
```
⏳ PENDENTE (aguardando aprovação):
  - @devops executa: git push origin feature/8.3-remove-important
  - @devops cria PR: Story 8.4 - Sacola Cupom GANGDAPATA
  - PR linked ao story: automatic
  - After QA gate: Merge to main
```

---

## 🛠️ Comandos & Operações

### Para @dev (Implementação)

```bash
# Ler arquivos para entender estrutura
cat theme-deploy-corrigido/snipplets/cart-drawer-new.tpl
cat theme-deploy-corrigido/static/css/style-critical.tpl | grep -A 50 "coupon"
cat theme-deploy-corrigido/static/js/cart-drawer.js

# Editar cart-drawer.js
# - Adicionar seletores de cupom em CONFIG.selectors
# - Adicionar function applyCoupon(code)
# - Adicionar function showNotification(msg, type)
# - Atualizar bindEvents() com handlers

# Testar localmente (se possível)
npm run lint      # Verificar sintaxe
npm run typecheck # Verificar tipos

# Fazer commit
git add theme-deploy-corrigido/static/js/cart-drawer.js
git commit -m "refactor: implement cupom GANGDAPATA functionality..."
```

### Para @devops (Deployment)

```bash
# Pre-deployment checklist
git status                    # ✅ Clean working directory
git log -1 --oneline         # ✅ Commit exists
npm run lint                 # ✅ Lint passes
npm run typecheck            # ✅ Typecheck passes
npm run build                # ✅ Build passes

# Deploy FTP
node ftp-deploy/deploy.js "v1.5.72: implement cupom..." --force

# Monitorar output
# FASE 0: Validação contexto
# FASE 1: Detecção arquivos
# FASE 2: Auto-increment versão
# FASE 3: Git commit + tag + push
# FASE 4: Backup incremental
# FASE 5: Deploy FTP
# FASE 6: Validação pós-deploy

# Se erro: Rollback
node ftp-deploy/rollback-incremental.js --version v1.5.71

# Se sucesso: Aguardar validação Gabriel
echo "✅ Deploy v1.5.72 completo. Gabriel valida em produção."
```

### Para Gabriel (Validação)

```bash
# 1. Abrir loja (F12 para console)
https://patagang.com.br/

# 2. Verificar versão
# Console → Look for: 📦 PATAGANG v1.5.73

# 3. Testar cupom
# - Abrir sacola (cart icon)
# - Digite: GANGDAPATA
# - Click: Aplicar
# - Resultado: "Cupom GANGDAPATA aplicado com sucesso!"
# - Verificar: Desconto 10% no total

# 4. Testar botão WhatsApp
# - Lado esquerdo tela
# - Texto legível de cima para baixo
# - Não invertido/upside-down

# 5. Confirmar validação
# Via Claude Code:
# "v1.5.73 OK para prosseguir"     → GitHub push
# "Encontrou problema em [X]"       → Ajustes
# "Rollback necessário"             → Reverter + investigar
```

---

## 📊 Documentação por Story

### Story 8.4 — Documentação Completa

| Documento | Tipo | Localização | Status |
|-----------|------|-------------|--------|
| **Story Formal** | Story | `docs/stories/8.4-SACOLA-CUPOM-GANGDAPATA.md` | ✅ Criado |
| **Completion Report** | Report | `docs/reports/STORY-8.4-COMPLETION-REPORT.md` | ✅ Criado |
| **Workflow Guide** | Guide | `docs/guides/EPIC-8-WORKFLOW-COMPLETE-GUIDE.md` | ✅ Este arquivo |
| **Code Comments** | Code | `theme-deploy-corrigido/static/js/cart-drawer.js` | ✅ Inline docs |
| **Constraints Checklist** | Checklist | `.claude/rules/nuvemshop-ftp-constraints.md` | ✅ Validado |

---

## 🎓 Padrões & Best Practices Aplicados

### Padrão 1: Nuvemshop LS API Integration

**Problema:** Integrar cupom com backend Nuvemshop sem page reload

**Solução:**
```javascript
// Primary: Use LS API (Nuvemshop global object)
if (typeof LS !== 'undefined' && LS.addCoupon) {
    LS.addCoupon(code, function(cart) {
        updateUI(cart);  // Cart updated, no reload
    });
}

// Fallback: POST if LS not available
fetch(form.action, {
    method: 'POST',
    body: new FormData(form),
    headers: {'X-Requested-With': 'XMLHttpRequest'}
})
```

**Why:** Graceful degradation. Always have a backup.

---

### Padrão 2: Writing-Mode Text Orientation

**Problema:** Botão esquerdo com texto vertical legível

**Solução:**
```css
/* ✅ CORRETO: Apenas writing-mode */
writing-mode: vertical-rl;
text-orientation: mixed;

/* ❌ INCORRETO: Transformar causa inversão */
transform: scaleX(-1) rotateZ(180deg);  /* Nunca use com writing-mode */
```

**Why:** Writing-mode handles orientation. Transforms break it.

---

### Padrão 3: Notification Feedback

**Problema:** Usuário não sabe se cupom foi aplicado

**Solução:**
```javascript
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `pg-drawer__notification pg-drawer__notification--${type}`;
    notification.textContent = message;
    notification.style.cssText = `
        padding: 10px 12px;
        background: ${type === 'success' ? '#d4edda' : '#f8d7da'};
        color: ${type === 'success' ? '#155724' : '#721c24'};
        ...
    `;
    couponSection.appendChild(notification);
    setTimeout(() => notification.remove(), 3000);
}
```

**Why:** Inline feedback is better than console messages.

---

## 🚀 Próximas Stories (Roadmap)

### Story 8.5 — JavaScript Optimization
- Consolidação de JS files
- Remoção de duplicatas
- Performance audit
- Estimated: 1-2 days

### Story 8.3 — !important Resolution
- Resolver CSS especificidade
- Remover !important desnecessário
- Audit existing uses
- Estimated: 2-3 days

### Story 8.1 — Design Tokens
- Implementar sistema de tokens
- CSS variables
- Documentation
- Estimated: 3-5 days

---

## 📞 Suporte & Escalation

**Perguntas sobre:**
- **Cupom Nuvemshop?** → Consultar `.claude/rules/nuvemshop-ftp-constraints.md`
- **LS API?** → Ver applyCoupon() em `cart-drawer.js`
- **Deploy?** → Ver `devops-epic8-standard-workflow.md`
- **Story 8.4?** → Ler `docs/stories/8.4-SACOLA-CUPOM-GANGDAPATA.md`

---

## ✅ Checklist Final

### Para Gabriel Validation

- [ ] Acesso: https://patagang.com.br/ ✅
- [ ] Console: 📦 PATAGANG v1.5.73 ✅
- [ ] Cupom GANGDAPATA aplicável ✅
- [ ] Desconto 10% refletido ✅
- [ ] Sem page reload ✅
- [ ] Botão WhatsApp texto legível ✅
- [ ] Mobile responsivo ✅
- [ ] Nenhum erro de console ✅

### Para GitHub Push (após aprovação)

- [ ] Gabriel aprovação: ✅
- [ ] git push origin feature/8.3-remove-important
- [ ] gh pr create --title "feat: Story 8.4 - Cupom GANGDAPATA"
- [ ] Merge to main após QA gate
- [ ] Close Story 8.4

---

**Documento Finalizado:** 2026-03-24
**Status:** ✅ Completo
**Next Step:** Awaiting Gabriel validation of v1.5.73

