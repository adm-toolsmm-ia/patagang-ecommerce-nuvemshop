# 🛡️ Nuvemshop JavaScript — Safe Practices & API Reference

**Data:** 2026-03-24
**Status:** ⚠️ CRÍTICO — Leitura obrigatória ANTES de modificar JS
**Autoridade:** Gabriel Cristofolini (CTO)
**Metodologia:** AIOX Constitutional + Nuvemshop Safety

---

## 🚨 **REGRA FUNDAMENTAL**

**NUNCA assuma que variáveis/APIs existem.**
**SEMPRE verifique e USE APIs padrão Nuvemshop.**

```javascript
// ✅ CORRETO
if (typeof LS !== 'undefined' && LS.getCart) {
  LS.getCart(callback);
}

// ❌ ERRADO
LS.getCart(callback);  // Pode quebrar se LS não existe
```

---

## 📚 **APIs Padrão Nuvemshop Comprovadas**

### Cart API (`LS` object)
```javascript
// Obter carrinho atual
LS.getCart(function(cart) {
  console.log('Cart:', cart);
  // cart contém: items, total, subtotal, etc
});

// Mudar quantidade de item
LS.changeQuantity(itemId, newQty, true, function(cart) {
  // Callback com cart atualizado
});

// Remover item
LS.removeItem(itemId, true, function(cart) {
  // Callback com cart atualizado
});

// Aplicar cupom
LS.addCoupon(couponCode, function(cart) {
  // Callback com cart atualizado (ou erro)
});
```

**Padrão de verificação:**
```javascript
if (typeof LS !== 'undefined' && typeof LS.getCart === 'function') {
  LS.getCart(callback);
} else {
  console.warn('LS API not available');
}
```

---

## 🌍 **Global Objects Disponíveis**

### Nuvemshop Nativo
- `window.tiendaNubeInstaTheme` — Objeto global de tema Nuvemshop
- `jQueryNuvem` — jQuery wrapper customizado por Nuvemshop
- `LS` — Cart/Commerce API (LS = LuckyShop ou similar)

### Patagang Custom
- `window.PGCartDrawer` — Custom cart drawer controller
- `window.__PATAGANG_VERSION__` — Versão atual
- Outros (definidos em custom JS files)

---

## ⚠️ **O Que NÃO Fazer**

### 1. Não Criar Variáveis Globais Aleatoriamente
```javascript
// ❌ ERRADO
window.store = {};  // Nuvemshop não popula isso
window.storeData = {};  // Aleatório, pode conflitar

// ✅ CORRETO
window.PGCustomData = {};  // Prefixo 'PG' deixa claro é nosso
```

### 2. Não Usar Template Variables em JavaScript
```tpl
{# ❌ ERRADO - Isso não funciona em JavaScript #}
<script>
  if ({{ store.live_chat }}) {  // Twig não interpola aqui!
    console.log('Has chat');
  }
</script>

{# ✅ CORRETO - Use condicional Twig no nivel template #}
{% if store.live_chat %}
<script>
  // Aqui já foi executado só se store.live_chat é true
  console.log('Chat is enabled');
  // Script inline com Olark
</script>
{% endif %}
```

### 3. Não Assumir Ordem de Carregamento
```javascript
// ❌ ERRADO
// Pode ser que LS não esteja carregado ainda!
LS.getCart(callback);

// ✅ CORRETO
document.addEventListener('DOMContentLoaded', function() {
  if (typeof LS !== 'undefined') {
    LS.getCart(callback);
  }
});
```

### 4. Não Modificar Estrutura de Checkout
```javascript
// ❌ ERRADO
// Checkout é gerido por Nuvemshop backend
document.querySelector('form.checkout').appendChild(newElement);

// ✅ CORRETO
// Use APIs padrão: LS.addCoupon(), etc
// Customize apenas via CSS/DOM manipulation segura
```

---

## 🔐 **Safe Implementation Pattern**

### Padrão 1: IIFE com Verificação
```javascript
// ✅ RECOMENDADO - Mesmo padrão de cart-drawer.js
(function() {
  'use strict';

  // 1. Verificar dependências
  if (typeof LS === 'undefined') {
    console.warn('LS API not available');
    return;
  }

  // 2. Configuração interna (não global)
  const config = {
    debounceDelay: 150,
    selectors: {
      // ...
    }
  };

  // 3. Funções internas
  function initModule() {
    LS.getCart(function(cart) {
      // ...
    });
  }

  // 4. Expor apenas necessário
  window.PGMyModule = {
    init: initModule,
    // somente public API
  };

  // 5. Inicializar quando pronto
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initModule);
  } else {
    initModule();
  }
})();
```

### Padrão 2: Template-Safe Lazy Loading
```tpl
{# ✅ CORRETO - Script lazy-loaded após DOMContentLoaded #}
{% if feature_enabled %}
<script>
document.addEventListener('DOMContentLoaded', function() {
  // Aqui LS já está carregado
  if (typeof LS !== 'undefined') {
    LS.getCart(function(cart) {
      // Fazer algo com cart
    });
  }
});
</script>
{% endif %}
```

---

## 📋 **Pre-Implementation Checklist**

Antes de modificar ANY JavaScript, responder:

```
☐ 1. Esta API já existe em LS ou outro objeto Nuvemshop?
☐ 2. Estou verificando se a API existe antes de usar?
☐ 3. Estou usando IIFE para evitar poluir window global?
☐ 4. Estou esperando DOMContentLoaded antes de acessar DOM?
☐ 5. Estou testando sem cache (Ctrl+Shift+Delete)?
☐ 6. Funcionou em desktop/tablet/mobile?
☐ 7. Console mostra 0 erros?
```

---

## 🚀 **Workflow Seguro para Story 8.5**

### Para CADA Priority:

```
1. PESQUISAR
   - Existe API Nuvemshop para isso?
   - Como cart-drawer.js resolve problema similar?

2. DOCUMENTAR
   - Qual API vou usar?
   - Como vou verificar se existe?
   - Qual é o callback pattern?

3. IMPLEMENTAR
   - Seguir padrão IIFE
   - Verificar existência de API
   - Usar try/catch

4. TESTAR
   - Local: console limpo?
   - Produção: funciona em todas as breakpoints?
   - Rollback plan pronto?

5. VALIDAR
   - Gabriel aprova em produção
   - Zero erros/warnings
```

---

## 📚 **Referências**

- **LS API Pattern:** `theme-deploy-corrigido/static/js/cart-drawer.js` (exemplar)
- **Nuvemshop Constraints:** `.claude/rules/nuvemshop-ftp-constraints.md`
- **AIOX Constitution:** `.aiox-core/constitution.md`
- **Cart Drawer Reference:** Ver linhas 135-217 de `cart-drawer.js`

---

## ⚠️ **Erros Conhecidos & Soluções**

### Erro: `window.store is undefined`
```
Causa: Tentou acessar variável template em JS global
Solução: Usar {% if store.variable %} no template, ou
         acessar via LS API padrão Nuvemshop
```

### Erro: `LS is not defined`
```
Causa: LS carregado depois que seu script rodou
Solução: Esperar DOMContentLoaded, verificar typeof LS
```

### Erro: `Checkout not responding`
```
Causa: Tentou modificar form.checkout via JS
Solução: Use LS APIs (addCoupon, etc), não manipule HTML
```

---

**Versão:** 1.0
**Criado:** 2026-03-24
**Status:** ✅ Production Reference
**Mantido por:** Gabriel Cristofolini + Claude AI

🛡️ **Segurança em primeiro lugar — Sempre verificar APIs antes de usar!**
