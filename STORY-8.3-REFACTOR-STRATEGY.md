# Story 8.3: CSS Refactor Strategy

**Status:** FASE 3 — Estratégia de Refactoring
**!important encontrados:** 859 total
  - 265 em CSS custom (FOCO)
  - 302 em style-async (bibliotecas, não alterar)
  - 3 em outros (remoção fácil)

---

## 🎯 ABORDAGEM SEGURA

### Tier 1: Remover !important Fáceis (3 arquivos)
**Locais:** style-fonts.tpl, style-help-sidebar, style-blog
**Mudanças:** Simples, low-risk
**Tempo:** 30 min

### Tier 2: CSS Custom No-Risk (50-80 casos)
**Locais:** style-tokens.tpl, style-colors.scss.tpl (simples)
**Mudanças:** Podem remover direto
**Tempo:** 1 hora

### Tier 3: CSS Custom Medium-Risk (185 casos)
**Locais:** style-critical.tpl (maioria aqui)
**Mudanças:** Melhorar especificidade
**Estratégia:**
  - Aumentar seletores (mais específico)
  - Usar cascata CSS corretamente
  - NUNCA quebrar layout existente
**Tempo:** 2-3 horas

### Tier 4: DEIXAR COMO ESTÁ (302 casos)
**Locais:** style-async.scss.tpl
**Razão:** Fancybox + Carousel minificadas (bibliotecas)
**Risco:** Alto - quebraria modals/carousels
**Ação:** Zero mudanças aqui

---

## 📋 EXECUÇÃO

### Step 1: Remover Tier 1 (fáceis)
```bash
# style-fonts.tpl, style-help-sidebar, style-blog
# Remover !important direto (sem cascata)
```

### Step 2: Refactor Tier 2 (simple)
```bash
# style-tokens.tpl: cores/fontes
# style-colors.scss.tpl: paletas
# Remover !important (especificidade já OK)
```

### Step 3: Refactor Tier 3 (complex)
```bash
# style-critical.tpl: PRINCIPAL
# Para cada !important:
#   1. Entender por que foi adicionado
#   2. Aumentar especificidade sem !important
#   3. Testar que não quebrou nada
```

### Step 4: Validar
```bash
# Desktop: sem layout shift
# Mobile: sem layout shift
# Modal: funciona
# Galeria: funciona
# Console: sem erros
```

---

## ⚠️ CONSTRAINTS

**Nuvemshop:**
- ✅ Checkout: Não tocado
- ✅ Footer: Não tocado
- ✅ Forms: Não tocado
- ✅ Newsletter: Não tocado
- ✅ CSS Size: Removendo !important, vai DIMINUIR tamanho

**Safety:**
- Backup antes de começar
- Commit após cada tier
- Test após cada commit

---

## 🎬 PRÓXIMO PASSO

Começar PHASE 4: Implementation
- Tier 1: Remover !important fáceis
- Commit
- Test
- → Tier 2, 3, etc.

