# FOUC Investigation — Fase 1 Findings (Story 10.5)

**Date:** 2026-03-27
**Investigator:** @analyst (Atlas)
**Status:** ✅ ROOT CAUSE IDENTIFIED

---

## 🎯 ROOT CAUSE: Hipótese A ✅ CONFIRMADA

**Classes CSS above-the-fold carregadas de `style-async.scss.tpl` em vez de `style-critical.tpl`**

---

## 📊 Análise Detalhada

### 1️⃣ HOME (`/`)

**Template:** `home.tpl`
**Classes above-the-fold:**
- `.pg-hero-v2` — Hero section (split-screen blueprint + foto)
- `.pg-section` — Vista o Propósito section
- `.pg-products-grid` — Produtos grid

**Carregamento CSS:**
- `style-home-v2.css` carrega BLOQUEANDO (linha 284 em layout.tpl)
  ```html
  {% if template == 'home' %}
      <link rel="stylesheet" href="{{ 'css/style-home-v2.css' | static_url }}?v=2026-02-03T04-40">
  {% endif %}
  ```
- Resultado: ✅ **SEM FOUC** (CSS presente antes do render)

---

### 2️⃣ CATEGORY (`/lancamentos`, `/comunidade`)

**Template:** `category.tpl`
**Classes above-the-fold:**
- `.pg-search-page` — Container da página
- `.pg-product-grid` — Grid de produtos ⚠️ **PROBLEMA AQUI**
- `.category-controls` — Filtros e ordenação

**Carregamento CSS:**
- `.pg-search-page` está em `style-critical.tpl` (linha 4599) ✅
- **.pg-product-grid está APENAS em `style-async.scss.tpl` (linha 3499+)** ❌
- `style-async.scss.tpl` carrega com `media="print" onload="this.media='all'"` (não-bloqueante)

**Fluxo do FOUC:**
```
1. Browser renderiza HTML (<div class="pg-product-grid">)
2. style-critical.tpl carrega → produtos aparecem SEM layout grid
3. Browser mostra: Produtos em coluna única (fallback)
4. style-async.scss.tpl carrega (após onload)
5. CSS aplica grid → layout muda para 4 colunas
6. RESULTADO: Layout shift visível = **FOUC** ⚠️
```

**Evidência no código:**
```
File: style-async.scss.tpl
Line 3499: .pg-product-grid {
           grid-template-columns: repeat(4, 1fr); /* 4 colunas desktop */
           gap: 16px;
           ...
         }
```

---

### 3️⃣ PDP (Product Page) — FOUC Secundário

**Template:** `product.tpl`
**Classes above-the-fold (potencial):**
- Precisa verificação adicional conforme nota de Gabriel

**Status:** 🔶 Investigação pendente (priorizar se tempo permitir)

---

## 🔍 Hipóteses Status

| Hipótese | Status | Evidence |
|----------|--------|----------|
| **A — Classes em async** | ✅ CONFIRMADA | `.pg-product-grid` em style-async, não em critical |
| **B — Fontes FOIT** | 🟡 PENDENTE | Verificar `font-display: swap` em layout.tpl |
| **C — Hero sem fallback** | ✅ N/A | HOME usa style-home-v2.css bloqueando |
| **D — Regras críticas em async** | ✅ CONFIRMADA (parcial) | Múltiplas regras de grid em style-async |

---

## 📋 Solução Proposta (para @dev)

### Fase 2 Implementation

**Mover classes críticas de `style-async.scss.tpl` para `style-critical.tpl`:**

**Classes a mover:**
```
.pg-product-grid (e subelementos) — linhas 3499-3853 em style-async
. item-product, .item-image, .item-description, .item-price, .item-actions
(total estimado: 40-50 regras)
```

**Batching Strategy:**
- Batch 1: `.pg-product-grid` + `.item-product` base (10 rules) — CSS Safety Pattern
- Batch 2: `.item-image` + `.item-description` (10 rules)
- Batch 3: `.item-price` + `.item-actions` (10 rules)
- Batch 4: Media queries para tablet/mobile (15 rules)

**CSS Size Impact:**
- style-critical.tpl atual: ~47 KB
- Adição estimada: ~3-4 KB (classes acima)
- Final: ~50-51 KB ⚠️ **AT LIMIT (50 KB max)**

**Mitigation:** Remover duplicatas ou regras obsoletas em style-critical antes de adicionar

---

## ✅ Validação Plan (Gabriel)

Após @dev implementar:
1. Abrir `/lancamentos` com cache limpo (Ctrl+Shift+R)
2. Network tab: Verificar que `pg-product-grid` renderiza com grid desde o início
3. Performance: Lighthouse score não piora > 5 pts
4. Mobile: Verificar que grid é responsivo

---

## 📎 Referências

- **Template Pages:**
  - `/`: home.tpl
  - `/lancamentos`, `/comunidade`: category.tpl

- **CSS Files:**
  - style-critical.tpl: ~47 KB (linha 4599 para .pg-search-page)
  - style-async.scss.tpl: linha 3499 para .pg-product-grid
  - style-home-v2.css: carrega bloqueando (só em home)

- **Layout Sequencing:**
  - layout.tpl linhas 282-285: Conditional load style-home-v2.css se template == 'home'
  - layout.tpl linha 279: style-async.scss.tpl carrega não-bloqueante

---

**Next:** @dev implementa Fase 2 com batches de 10-15 rules per deployment (CSS Safety Pattern)
