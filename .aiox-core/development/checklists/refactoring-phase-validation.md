# Checklist de Validação — Refatoração CSS/JS (Epic 8)

**Type:** Quality Gate Checklist
**Authority:** @qa (Quinn)
**Usage:** Execute before marking each story as DONE
**Framework:** AIOX Story Development Cycle (SDC)

---

## Visão Geral

Este checklist valida cada fase de refatoração contra:
1. **Acceptance Criteria** (da story individual)
2. **Nuvemshop Constraints** (8 regras críticas)
3. **Visual Regression** (nenhuma mudança visual)
4. **Performance** (Lighthouse metrics)

---

## 🟢 PHASE 1: Design Tokens (Story 8.1)

### Visual Validation (MANDATORY)

Inspecionar cada página em **desktop + mobile (375px)**:

- [ ] **Home page**
  - [ ] Hero section renderiza corretamente
  - [ ] Produtos em destaque com cores corretas
  - [ ] Footer visível com attribution
  - [ ] Menu navigation estilo correto

- [ ] **Category page**
  - [ ] Grid de produtos renderiza
  - [ ] Filtros visíveis
  - [ ] Breakpoint 768px: mobile layout ativado
  - [ ] Breakpoint 1024px: tablet layout ativado
  - [ ] Breakpoint 1200px: desktop layout ativado

- [ ] **Product Detail Page (PDP)**
  - [ ] Imagens carregadas
  - [ ] Variantes de produto funcionam
  - [ ] Preço exibido com cor correta
  - [ ] Botão "Adicionar ao carrinho" estilo correto

- [ ] **Cart page**
  - [ ] Itens carregam com estilo
  - [ ] Totals calculado corretamente
  - [ ] Checkout button estilo correto

### Technical Validation

- [ ] **Tokens defined in `style-tokens.tpl`**
  - Inspecionar DevTools: abrir `<style>` tag
  - Verificar CSS Custom Properties: `--color-*`, `--breakpoint-*`
  - Contar: mínimo 100+ color tokens

- [ ] **No hardcoded colors**
  - Grep para `#[A-F0-9]{6}` em `style-critical.tpl` e `style-colors.scss.tpl`
  - Resultado esperado: zero ocorrências (ou exceções documentadas)

- [ ] **Breakpoints centralizados**
  - Grep para `@media` ou `(min-width:`
  - Verificar apenas 3 valores: 768px, 1024px, 1200px
  - Sem exceções (ex: 640px, 800px, 992px)

- [ ] **Lint passes**
  - `npm run lint` → zero errors
  - `npm run typecheck` → zero errors

### Performance Validation

- [ ] **Lighthouse audit** (Chrome DevTools)
  - [ ] Desktop score: ≥ 90
  - [ ] Mobile score: ≥ 85
  - [ ] LCP acceptable (< 4s still, not optimized yet)

- [ ] **File size check**
  - `style-critical.tpl`: 205 KB (unchanged)
  - `style-colors.scss.tpl`: 25 KB (unchanged)
  - `style-tokens.tpl`: expanded but < 40 KB total

### Nuvemshop Constraints Validation

| Constraint | Check | Result |
|-----------|-------|--------|
| Checkout | Don't touch `checkout.scss.tpl` | ✅ Not modified |
| Footer | Keep visible | ✅ Visible |
| Contact Form | Don't modify | ✅ Not modified |
| Registration Form | Don't modify | ✅ Not modified |
| Newsletter Form | Don't modify | ✅ Not modified |
| Auto-Generated | Don't modify sitemap | ✅ Not modified |
| Performance | CSS < 50KB (N/A for Phase 1) | ✅ N/A |
| JavaScript | No conflicts | ✅ No changes |

### Sign-off

- [ ] @qa validates all checks
- [ ] @qa marks story as "Ready for Deployment"
- [ ] Gabriel reviews & approves
- [ ] @devops deploys v1.2.0

---

## 🟡 PHASE 2: CSS Reduction (Story 8.2)

### Visual Validation

- [ ] **All pages tested (desktop + mobile)**
  - [ ] Home: hero, products, no FOUC
  - [ ] Category: grid, filters, no FOUC
  - [ ] PDP: images, variantes, no FOUC
  - [ ] Cart: items, totals, no FOUC
  - [ ] Checkout: visual only, no FOUC
  - [ ] Contact: form visible, no FOUC
  - [ ] Search: results render, no FOUC

- [ ] **Connection speed test**
  - Chrome DevTools → Network → Throttle to "Slow 3G"
  - [ ] Pages still render without excessive delay
  - [ ] No FOUC even on slow connection

### Performance Validation

- [ ] **Lighthouse audit**
  - [ ] Mobile: ≥ 85 (improved from ~65)
  - [ ] Desktop: ≥ 90 (improved from ~75)
  - [ ] LCP < 2s (improved from ~4s)
  - [ ] FCP < 1.5s (improved from ~2.5s)

- [ ] **File size validation**
  - `style-critical.tpl`: < 50 KB ✅
  - `style-async.scss.tpl`: 151KB (async, non-blocking)
  - Total critical CSS reduced by 50%+

- [ ] **Async CSS loading verification**
  - Open DevTools → Network tab
  - Verify `style-async.css` loaded with `rel="preload"`
  - No blocking behavior

### Technical Validation

- [ ] **No FOUC**
  - [ ] Page renders with CSS applied from first paint
  - [ ] No unstyled content visible at any point

- [ ] **CSS split correct**
  - [ ] Critical: header, nav, hero, above-fold buttons
  - [ ] Async: cards, filtros, sidebar, blog, secondary pages
  - Verify in DevTools: only critical CSS inlined in `<head>`

- [ ] **Lint passes**
  - `npm run lint` → zero errors
  - `npm run typecheck` → zero errors

### Nuvemshop Constraints

- [ ] All 8 constraints still valid
- [ ] Checkout not touched
- [ ] Footer visible
- [ ] Forms unchanged

### Sign-off

- [ ] @qa validates all checks
- [ ] Gabriel reviews performance improvements
- [ ] @devops deploys v1.3.0

---

## 🟠 PHASE 3: !important Resolution (Story 8.3)

### Visual Regression Testing

Validar que NENHUMA mudança visual ocorre após refatoração.

- [ ] **Every page tested (desktop + mobile)**
  - [ ] Home identical to v1.3.0
  - [ ] Category identical to v1.3.0
  - [ ] PDP identical to v1.3.0
  - [ ] Cart identical to v1.3.0
  - [ ] Search identical to v1.3.0
  - [ ] Checkout visual only identical

- [ ] **Breakpoint testing**
  - [ ] Mobile (375px) renders identically
  - [ ] Tablet (768px) renders identically
  - [ ] Desktop (1024px) renders identically
  - [ ] Desktop (1200px) renders identically

### Technical Validation

- [ ] **!important count reduced**
  - Grep: `grep -r "!important" theme-deploy-corrigido/static/css/`
  - Before: 1.316
  - After: < 50
  - Verify count in: `style-critical.tpl`, `style-async.scss.tpl`, others

- [ ] **Specificity hierarchy correct**
  - DevTools Inspect: verify colors applied without `!important`
  - Example: `.pg-card .btn` applies correctly without override

- [ ] **Lint passes**
  - `npm run lint` → zero errors
  - `npm run typecheck` → zero errors

### Performance (Should not degrade)

- [ ] **Lighthouse audit**
  - Mobile: ≥ 85 (maintained)
  - Desktop: ≥ 90 (maintained)
  - LCP < 2s (maintained)

### Nuvemshop Constraints

- [ ] All 8 constraints still valid
- [ ] Checkout not touched
- [ ] Performance budget still met

### Sign-off

- [ ] @qa validates visual regression
- [ ] Gabriel approves zero visual changes
- [ ] @devops deploys v1.4.0

---

## 🔴 PHASE 4: Template Cleanup (Story 8.4)

### Structure Validation

- [ ] **Duplications removed**
  - `footer.tpl` (root) → removed ✅
  - `instatheme.js` (hash version) → removed ✅
  - `*.tpl.bak` files → removed ✅
  - `nul` file → removed ✅
  - Other unused snipplets → identified & removed

- [ ] **Includes updated**
  - All `includes` in `layout.tpl` point to correct paths ✅
  - All snipplet references valid ✅
  - No broken references ✅

### Visual Validation

- [ ] **All pages render (desktop + mobile)**
  - [ ] Home loads correctly
  - [ ] Category loads correctly
  - [ ] PDP loads correctly
  - [ ] Cart loads correctly
  - [ ] Checkout loads correctly
  - [ ] Contact loads correctly
  - [ ] Search loads correctly

- [ ] **No template errors**
  - Browser console: zero JavaScript errors ✅
  - Server logs: zero Nuvemshop template errors ✅

### Technical Validation

- [ ] **Documentation complete**
  - Snipplet folder structure documented ✅
  - README in `snipplets/` folder ✅
  - List of available snipplets provided ✅

- [ ] **Git state clean**
  - No untracked files (except backups) ✅
  - All removals committed ✅
  - Lint passes ✅

### Nuvemshop Constraints

- [ ] All 8 constraints still valid
- [ ] Checkout not touched
- [ ] All forms still functional

### Sign-off

- [ ] @qa validates structure
- [ ] Gabriel approves cleanup
- [ ] @devops deploys v1.5.0

---

## 🟦 PHASE 5: JavaScript Optimization (Story 8.5)

### Functional Validation

Critical features must work after JS optimization:

- [ ] **Cart functionality**
  - [ ] Add to cart works
  - [ ] Cart count updates
  - [ ] Cart drawer opens/closes

- [ ] **Discount display**
  - [ ] Discount overlay appears
  - [ ] Discount value correct
  - [ ] No console errors

- [ ] **WhatsApp button**
  - [ ] Button visible
  - [ ] Clicking opens WhatsApp
  - [ ] No console errors

- [ ] **Search functionality**
  - [ ] Search input works
  - [ ] Results render
  - [ ] No console errors

- [ ] **Other custom JS**
  - [ ] All custom features work
  - [ ] No console errors or warnings

### Technical Validation

- [ ] **JavaScript consolidation**
  - Only one `instatheme.js` file ✅
  - Hash-versioned file removed ✅
  - `layout.tpl` loads correct version ✅

- [ ] **Payment discount optimization**
  - `payment-discount-text-override.js` refactored ✅
  - No 3x setTimeout (replaced with callback) ✅
  - Discount timing correct ✅

- [ ] **No conflicts with Nuvemshop**
  - Window object: `window.Nuvemshop.*` untouched ✅
  - Global $, jQuery: not overwritten ✅
  - All custom code scoped in IIFE ✅

- [ ] **Console clean**
  - Browser DevTools Console: zero errors ✅
  - Browser DevTools Console: zero warnings ✅
  - No stack traces or exceptions ✅

- [ ] **Lint passes**
  - `npm run lint` → zero errors
  - `npm run typecheck` → zero errors

### Performance (Should not degrade)

- [ ] **Lighthouse audit**
  - Mobile: ≥ 85 (maintained)
  - Desktop: ≥ 90 (maintained)
  - LCP < 2s (maintained)

### Nuvemshop Constraints

- [ ] All 8 constraints still valid
- [ ] Checkout not touched
- [ ] Performance budget still met

### Sign-off

- [ ] @qa validates functionality
- [ ] Browser console clean
- [ ] Gabriel approves
- [ ] @devops deploys v1.6.0

---

## ✅ Epic-Level Sign-off

After all 5 phases complete:

- [ ] All 5 stories marked DONE
- [ ] All phases validated by @qa
- [ ] Gabriel approves entire refactoring
- [ ] v1.6.0 deployed to production
- [ ] Team trained on new structure
- [ ] Documentation complete

---

**Checklist Version:** 1.0.0
**Created:** 2026-03-21
**Authority:** @qa (Quinn)
**Framework:** AIOX Story Development Cycle

---

*Use this checklist for each phase. Ensure all boxes checked before marking story DONE.*
