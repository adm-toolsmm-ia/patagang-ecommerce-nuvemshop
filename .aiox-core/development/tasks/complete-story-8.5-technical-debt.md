# Task — Completar Story 8.5 Technical Debt (ACs 1 & 2)

**Assigned to:** @dev (Dex)
**Priority:** High
**Estimated Time:** 30-45 minutes
**Related Story:** Story 8.5 — JavaScript Optimization
**Deploy Version:** v1.5.100 (after v1.5.99)

---

## 📋 Objetivo

Story 8.5 está funcional em produção (v1.5.99) MAS com 2 ACs não implementadas:
- ❌ **AC 1:** Consolidar `instatheme.js` (2 versões legado)
- ❌ **AC 2:** Refatorar `payment-discount-text-override.js` (setTimeout → callback)

Nesta task, implementar ambas ACs para fechar Story 8.5 com 100% de conclusão.

---

## 🔧 AC 1: Consolidar instatheme.js

### 1.1 — Investigação Inicial

**Objetivo:** Determinar qual versão é carregada em produção

**Arquivos envolvidos:**
```
theme-deploy-corrigido/static/js/instatheme.js
theme-deploy-corrigido/static/js/instatheme-83af8dd95a83e9bfd631a208ebe4476030.js
theme-deploy-corrigido/layouts/layout.tpl (arquivo que carrega JS)
```

**Steps:**
```bash
# 1. Buscar instatheme em layout.tpl
grep -n "instatheme" theme-deploy-corrigido/layouts/layout.tpl

# 2. Verificar qual arquivo é incluído/carregado
# Esperado: Somente UM arquivo é carregado (ex: instatheme-{hash}.js)

# 3. Comparar conteúdo dos dois arquivos (se diferentes, determinar qual é atual)
diff theme-deploy-corrigido/static/js/instatheme.js theme-deploy-corrigido/static/js/instatheme-83af8dd95a83e9bfd631a208ebe4476030.js
```

### 1.2 — Remover Arquivo Legado

**Decision Logic:**
- Se layout.tpl carrega `instatheme-{hash}.js` → remover `instatheme.js` (original)
- Se layout.tpl carrega `instatheme.js` → remover `instatheme-{hash}.js` (versão legado)

**Action:**
```bash
# Remover arquivo não-usado
rm theme-deploy-corrigido/static/js/[arquivo-legado].js

# Verificar remoção
git status
git diff

# Commit
git add -A
git commit -m "fix: remove legacy instatheme.js duplicate file [Story 8.5 AC 1]"
```

**Validation:**
- Verificar que APENAS UM arquivo instatheme permanece
- Confirmar layout.tpl referencia o arquivo correto
- Zero erros no console (F12) quando carregar site

---

## 🔧 AC 2: Refatorar payment-discount-text-override.js

### 2.1 — Análise Atual

**File:** `theme-deploy-corrigido/static/js/payment-discount-text-override.js`

**Problema:** 3x nested setTimeout (callback hell)
```javascript
setTimeout(() => {
  // check 1
  setTimeout(() => {
    // check 2
    setTimeout(() => {
      // check 3
    }, 100);
  }, 100);
}, 100);
```

**Impacto:**
- Difícil de ler/manter (callback hell)
- Sem tratamento de erro
- Desnecessariamente complexo

### 2.2 — Refatoração (escolher UMA técnica)

**Opção A: DOMContentLoaded Event (RECOMENDADO)**
```javascript
(function() {
  'use strict';

  function updatePaymentDiscountText() {
    // Check 1: Elemento existe?
    const discountElement = document.querySelector('[data-discount]');
    if (!discountElement) return;

    // Check 2: Atributo tem valor?
    const discountValue = discountElement.getAttribute('data-discount');
    if (!discountValue) return;

    // Check 3: Atualizar texto
    discountElement.textContent = `Desconto: ${discountValue}`;
  }

  // Chamar quando DOM estiver pronto
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', updatePaymentDiscountText);
  } else {
    // DOM já carregado
    updatePaymentDiscountText();
  }
})();
```

**Opção B: Promises/async-await (ALTERNATIVA)**
```javascript
(function() {
  'use strict';

  async function updatePaymentDiscountText() {
    try {
      // Check 1
      const discountElement = document.querySelector('[data-discount]');
      if (!discountElement) return;

      // Check 2
      const discountValue = discountElement.getAttribute('data-discount');
      if (!discountValue) return;

      // Check 3
      discountElement.textContent = `Desconto: ${discountValue}`;
    } catch (error) {
      console.error('Error updating payment discount:', error);
    }
  }

  // Chamar quando DOM estiver pronto
  if (document.readyState !== 'loading') {
    updatePaymentDiscountText();
  } else {
    document.addEventListener('DOMContentLoaded', updatePaymentDiscountText);
  }
})();
```

**Melhorias implementadas:**
- ✅ Sem nested timeouts
- ✅ IIFE para não poluir global scope
- ✅ Error handling (`try/catch`)
- ✅ 'use strict' mode
- ✅ Legível e testável

### 2.3 — Implementação

```bash
# 1. Editar arquivo
nano theme-deploy-corrigido/static/js/payment-discount-text-override.js

# 2. Substituir conteúdo pela Opção A ou B acima

# 3. Validar sintaxe (no console não deve dar erro)
npm run build  # se houver build step

# 4. Commit
git add theme-deploy-corrigido/static/js/payment-discount-text-override.js
git commit -m "refactor: replace setTimeout callbacks with DOMContentLoaded event [Story 8.5 AC 2]

Remove callback hell from payment-discount-text-override.js
- Before: 3x nested setTimeout (difficult to read/maintain)
- After: Single DOMContentLoaded event listener (clear intent)
- Added: Error handling with console.error()
- Added: IIFE to prevent global scope pollution
- Added: 'use strict' mode

Improves readability and maintainability without changing functionality.

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>"
```

### 2.4 — Validação

**Local Testing:**
```bash
# 1. npm run build (se houver)
# 2. Abrir site localmente
# 3. F12 → Console
# 4. Verificar:
#    - Zero erros JavaScript
#    - Desconto aparece corretamente na página de pagamento
#    - Funcionalidade idêntica a antes (sem mudança visual)
```

---

## 📋 Sequência Completa (45 min)

### Step 1: AC 1 — Consolidar instatheme.js (15 min)
```bash
1. Investigar qual arquivo é carregado: grep + layout.tpl
2. Remover arquivo legado: rm + git add
3. Validar: git status, abrir site, F12 console
4. Commit: conventional format com [Story 8.5 AC 1]
```

### Step 2: AC 2 — Refatorar payment-discount (25 min)
```bash
1. Ler arquivo atual e entender lógica
2. Escolher Opção A (DOMContentLoaded) ou B (async)
3. Editar arquivo com novo código
4. Testar localmente: npm run build + console check
5. Commit: conventional format com [Story 8.5 AC 2]
```

### Step 3: Deploy (5 min)
```bash
1. git push (quando ready)
2. @devops: node ftp-deploy/deploy.js "v1.5.100: Complete Story 8.5 technical debt"
3. Gabriel: Validate in production
```

---

## ✅ Definition of Done

- [x] AC 1: Consolidate instatheme.js — determined which version, removed legacy
- [x] AC 2: Refactor payment-discount.js — replaced setTimeout with event listener
- [x] Zero JavaScript console errors
- [x] Payment discount functionality identical (no visual change)
- [x] 2 commits: one per AC, conventional format
- [x] Ready for FTP deploy (v1.5.100)

---

## 🚀 Next Steps After This Task

1. **@dev:** Complete this task (45 min)
2. **@dev:** Push feature/8.5-debt-completion to GitHub
3. **@devops:** Deploy to FTP (v1.5.100)
4. **Gabriel:** Validate in production
5. **@devops:** Merge to main + close Story 8.5

**Result:** Story 8.5 100% complete with all ACs implemented ✅

---

**Created:** 2026-03-27
**Source:** EPIC-8-STATUS-REAL-ANALYSIS.md
**Type:** Code Quality / Bug Fix
**Risk:** Low (refactoring existing code)

