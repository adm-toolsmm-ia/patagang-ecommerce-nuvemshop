# Guia de Execução — Refatoração Técnica CSS/JS (Epic 8)

**Type:** Development Guide (L4)
**Authority:** @architect + @dev
**Framework:** AIOX Story Development Cycle
**Date Created:** 2026-03-21

---

## Visão Geral

Este guia descreve como **executar autonomamente** cada fase de refatoração seguindo o fluxo AIOX:

```
@sm Draft → @po Validate → @dev Implement → @qa Gate → @devops Deploy → Gabriel Approval
```

---

## 🎯 Workflow Macro (Epic 8)

### Timeline esperada (2 developers)

| Week | Phase | Story | Status |
|------|-------|-------|--------|
| W1 | 1 | 8.1 Tokens | Implement → QA → Deploy v1.2.0 |
| W1-W2 | 2 | 8.2 CSS Reduction | Implement → QA → Deploy v1.3.0 |
| W2-W3 | 3 | 8.3 !important | Implement → QA → Deploy v1.4.0 |
| W1 | 4 | 8.4 Cleanup | Parallel with Phase 2 → Deploy v1.5.0 |
| W1 | 5 | 8.5 JavaScript | Parallel → Deploy v1.6.0 |

**Total:** 3-4 weeks (2 devs), 6-8 weeks (1 dev)

---

## 📋 Phase 1: Design Tokens (Story 8.1)

### Pre-implementation

**Time:** 2 hours
**Owner:** @dev
**Purpose:** Understand current token usage

```bash
# 1. Analyze current colors in codebase
grep -r "#[A-F0-9]\{6\}" theme-deploy-corrigido/static/css/ | wc -l
# Expected: 150+ hardcoded colors

# 2. List current tokens in style-tokens.tpl
head -50 theme-deploy-corrigido/static/css/style-tokens.tpl
# Expected: partial tokens already defined

# 3. Check breakpoints in use
grep -r "@media\|min-width:" theme-deploy-corrigido/static/css/ | grep -o "[0-9]*px" | sort -u
# Expected: 10+ different values (need to consolidate to 3)
```

### Implementation Steps

**Time:** 8-10 hours
**Owner:** @dev
**Deliverable:** Story 8.1 complete with tokens mapped

**Step 1: Analyze and map colors (2h)**
```bash
# Generate list of all colors in project
grep -roh "#[A-F0-9]\{6\}" theme-deploy-corrigido/static/css/ | sort -u > /tmp/colors.txt

# Manually categorize in spreadsheet:
# - Primary: #007bff (blue)
# - Secondary: #EAFE67 (yellow)
# - Neutral: #E2E2E2 (gray)
# etc.

# Create token names (semantic):
# --color-primary: #007bff
# --color-highlight: #EAFE67
# --color-border-light: #E2E2E2
# etc. (100+ tokens minimum)
```

**Step 2: Update `style-tokens.tpl` (3h)**
```liquid
<style>
  :root {
    /* Primary Colors */
    --color-primary: #007bff;
    --color-primary-light: #0056b3;
    --color-secondary: #EAFE67;

    /* Neutrals */
    --color-border-light: #E2E2E2;
    --color-background: #FFFFFF;
    --color-text-primary: #333333;

    /* Breakpoints */
    --breakpoint-mobile: 768px;
    --breakpoint-tablet: 1024px;
    --breakpoint-desktop: 1200px;

    /* ... 100+ more tokens ... */
  }
</style>
```

**Step 3: Update `style-colors.scss.tpl` (2h)**
```scss
// Reference tokens instead of hardcoding
$primary-color: var(--color-primary);
$secondary-color: var(--color-secondary);
// ... etc

// Or use tokens directly in mixins
@mixin button-primary {
  background: var(--color-primary);
  color: white;
}
```

**Step 4: Update `style-critical.tpl` (2h)**
```liquid
<style>
  /* Use tokens instead of hardcoded colors */
  .header {
    background: var(--color-primary);
    border-color: var(--color-border-light);
  }

  .button {
    background: var(--color-primary);
  }
  /* ... replace all hardcoded with var(--color-*) ... */
</style>
```

**Step 5: Centralize breakpoints (1h)**
```scss
// Update all breakpoints to use 3 values only
@media (min-width: var(--breakpoint-mobile)) { /* 768px */ }
@media (min-width: var(--breakpoint-tablet)) { /* 1024px */ }
@media (min-width: var(--breakpoint-desktop)) { /* 1200px */ }
```

### Post-implementation Validation

**Time:** 2 hours
**Owner:** @qa

```bash
# 1. Lint check
npm run lint  # Should pass

# 2. Lighthouse audit
# Open Chrome DevTools → Lighthouse → Run audit
# Expected: Mobile ≥ 85, Desktop ≥ 90

# 3. Visual test
# Open each page in browser, verify visually identical to v1.1.18

# 4. Git commit
git add .
git commit -m "feat: establish unified design tokens system [Story 8.1]"
```

### Checklist

- [ ] 150+ color tokens mapped in `style-tokens.tpl`
- [ ] Breakpoints: 768px, 1024px, 1200px only
- [ ] All CSS files reference tokens (no hardcoded colors)
- [ ] Lint passes
- [ ] Lighthouse ≥ 85 mobile
- [ ] Visual test: identical to v1.1.18
- [ ] @qa validation complete
- [ ] Gabriel approval received

---

## 📋 Phase 2: CSS Reduction (Story 8.2)

### Pre-implementation

**Time:** 3 hours
**Owner:** @architect + @dev
**Purpose:** Determine above-the-fold CSS

```bash
# Analyze style-critical.tpl
wc -c theme-deploy-corrigido/static/css/style-critical.tpl
# Expected: 205 KB

# List what CSS is loaded
grep -E "\.header|\.nav|\.hero|\.button" theme-deploy-corrigido/static/css/style-critical.tpl | head -20
```

**Decision:** What stays inline vs moves async
- **Inline (keep in critical):** Header, nav, hero, above-fold buttons (≈30-40KB)
- **Async (move to async):** Cards, filters, sidebar, blog, secondary pages (≈150KB+)

### Implementation Steps

**Time:** 15-18 hours
**Owner:** @dev

**Step 1: Identify critical CSS (3h)**
```bash
# Review hero.scss
grep -A 50 "^\.hero" theme-deploy-corrigido/static/css/style-critical.tpl

# Review header.scss
grep -A 50 "^\.header" theme-deploy-corrigido/static/css/style-critical.tpl

# Review nav.scss
grep -A 50 "^\.nav" theme-deploy-corrigido/static/css/style-critical.tpl

# Everything else → async
```

**Step 2: Create async stylesheet (5h)**
```bash
# Move non-critical CSS from style-critical.tpl to style-async.scss.tpl
# Leave only header, nav, hero, buttons in critical
```

**Step 3: Reduce `style-critical.tpl` (4h)**
```liquid
<style>
  /* Only above-the-fold CSS */
  .header { /* ... */ }
  .nav { /* ... */ }
  .hero { /* ... */ }
  .button-primary { /* ... */ }
  /* Everything else removed to async */
</style>

<!-- Load async CSS with preload -->
<link rel="preload" href="/static/css/style-async.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="/static/css/style-async.css"></noscript>
```

**Step 4: Update layout.tpl (2h)**
```liquid
<!-- In <head> -->
<style>
  /* Critical CSS inline */
</style>

<!-- Async CSS loading -->
<link rel="preload" href="/static/css/style-async.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
```

**Step 5: Validate no FOUC (1h)**
```bash
# Test in browser with DevTools Network throttling
# Slow 3G: should still render without unstyled content
```

### Post-implementation Validation

**Time:** 2 hours
**Owner:** @qa

```bash
# 1. File size check
wc -c theme-deploy-corrigido/static/css/style-critical.tpl
# Expected: < 50 KB

# 2. Lighthouse
# Expected: Mobile ≥ 85, LCP < 2s

# 3. No FOUC
# Visual test on Slow 3G in DevTools

# 4. Commit
git add .
git commit -m "perf: reduce critical CSS from 205KB to <50KB [Story 8.2]"
```

### Checklist

- [ ] `style-critical.tpl` < 50 KB
- [ ] `style-async.scss.tpl` contains moved CSS
- [ ] No FOUC on any page
- [ ] Lighthouse Mobile ≥ 85
- [ ] LCP < 2 seconds
- [ ] Gabriel approval

---

## 📋 Phase 3: !important Resolution (Story 8.3)

### Pre-implementation

**Time:** 2 hours
**Owner:** @dev

```bash
# Count !important usage
grep -r "!important" theme-deploy-corrigido/static/css/ | wc -l
# Expected: 1.316

# Per-file breakdown
grep -l "!important" theme-deploy-corrigido/static/css/*.* | while read f; do
  echo "$f: $(grep -c '!important' "$f")"
done
```

### Implementation Strategy

**File-by-file approach (smallest to largest):**

1. `style-blog.scss.tpl` (3)
2. `style-filters-patagang.css.tpl` (28)
3. `style-menu-patagang.css.tpl` (85)
4. `style-async.scss.tpl` (426)
5. `style-critical.tpl` (525)

### Implementation Steps

**Time:** 25-30 hours
**Owner:** @dev

**For each file:**

```bash
# 1. Extract all !important rules
grep -n "!important" theme-deploy-corrigido/static/css/FILENAME.tpl > /tmp/rules.txt

# 2. For each rule, increase specificity
# Before: .button { color: red !important; }
# After: .pg-card .button { color: red; }
# (Remove !important, rely on CSS hierarchy)

# 3. Test visual after each file
# Open browser, verify no regression

# 4. Commit each file
git add theme-deploy-corrigido/static/css/FILENAME.tpl
git commit -m "refactor: remove !important from FILENAME [Story 8.3]"
```

### Post-implementation Validation

**Time:** 2 hours
**Owner:** @qa

```bash
# 1. Count remaining !important
grep -r "!important" theme-deploy-corrigido/static/css/ | wc -l
# Expected: < 50

# 2. Visual regression test
# Test every page: identical to v1.3.0

# 3. Lighthouse
# Expected: maintained ≥ 85

# 4. Commit
git add .
git commit -m "refactor: resolve 1.316 !important violations [Story 8.3]"
```

### Checklist

- [ ] `!important` count < 50
- [ ] Visual identical to v1.3.0 on all pages
- [ ] All breakpoints tested
- [ ] Lighthouse maintained ≥ 85
- [ ] Gabriel approval

---

## 📋 Phase 4: Template Cleanup (Story 8.4)

### Pre-implementation

**Time:** 2 hours
**Owner:** @dev + @analyst

```bash
# Find duplicate footer.tpl
find theme-deploy-corrigido -name "footer.tpl" -type f
# Expected: multiple results

# Find .tpl.bak files
find theme-deploy-corrigido -name "*.tpl.bak" -type f

# Find nul file
find theme-deploy-corrigido -name "nul" -type f

# Find unused snipplets
grep -r "include" theme-deploy-corrigido/layouts/ | grep -o "'[^']*'" | sort -u > /tmp/used.txt
ls -la theme-deploy-corrigido/snipplets/ | grep -v "$(cat /tmp/used.txt | tr '\n' '|')" > /tmp/unused.txt
```

### Implementation Steps

**Time:** 6-8 hours
**Owner:** @dev

**Step 1: Document current structure (1h)**
```bash
# Create README in snipplets/
cat > theme-deploy-corrigido/snipplets/README.md << 'EOF'
# Snipplets

Available components:
- footer/ — Footer component (main source of truth)
- header/ — Header component
- product-card/ — Product card template
- ... etc
EOF
```

**Step 2: Remove duplicates (2h)**
```bash
# Remove footer.tpl from root (keep snipplets/footer/footer.tpl)
rm theme-deploy-corrigido/footer.tpl

# Update layout.tpl includes
# Before: {% include 'footer.tpl' %}
# After: {% include 'snipplets/footer/footer.tpl' %}
```

**Step 3: Remove residuals (1h)**
```bash
# Remove .tpl.bak files
find theme-deploy-corrigido -name "*.tpl.bak" -delete

# Remove nul file
rm -f theme-deploy-corrigido/nul
```

**Step 4: Remove unused snipplets (2h)**
```bash
# For each unused snipplet, verify it's not included anywhere
grep -r "product-old.tpl" theme-deploy-corrigido/ 2>/dev/null || rm theme-deploy-corrigido/snipplets/product-old.tpl
```

### Post-implementation Validation

**Time:** 2 hours
**Owner:** @qa

```bash
# 1. Test all pages
# Home, category, PDP, cart, contact — all should load

# 2. Check for template errors
# Browser console: zero JavaScript errors
# Server logs: zero Nuvemshop template errors

# 3. Commit
git add .
git commit -m "chore: cleanup duplicate snipplets and residuals [Story 8.4]"
```

### Checklist

- [ ] Duplicate footer.tpl removed
- [ ] .tpl.bak files removed
- [ ] nul file removed
- [ ] Unused snipplets identified & removed
- [ ] layout.tpl includes updated
- [ ] All pages render correctly
- [ ] Gabriel approval

---

## 📋 Phase 5: JavaScript Optimization (Story 8.5)

### Pre-implementation

**Time:** 2 hours
**Owner:** @dev

```bash
# Find all instatheme files
find theme-deploy-corrigido -name "instatheme*.js"

# Check layout.tpl for which version loaded
grep -n "instatheme" theme-deploy-corrigido/layouts/layout.tpl

# Find payment-discount-text-override.js
grep -n "setTimeout" theme-deploy-corrigido/static/js/payment-discount-text-override.js | wc -l
# Expected: 3
```

### Implementation Steps

**Time:** 10-12 hours
**Owner:** @dev

**Step 1: Consolidate instatheme (2h)**
```bash
# Determine which instatheme is loaded in layout.tpl
grep "instatheme" theme-deploy-corrigido/layouts/layout.tpl

# Remove hash-versioned duplicate
rm theme-deploy-corrigido/static/js/instatheme-83af8dd95a83e9bfd631a208ebe4476030.js

# Verify only one version remains
find theme-deploy-corrigido -name "instatheme*.js" | wc -l
# Expected: 1
```

**Step 2: Optimize payment-discount-text-override.js (4h)**
```javascript
// BEFORE:
setTimeout(() => { /* logic */ }, 100);
setTimeout(() => { /* logic */ }, 200);
setTimeout(() => { /* logic */ }, 300);

// AFTER:
function initializeDiscountOverlay() {
  // All logic here, called when DOM ready
}

document.addEventListener('DOMContentLoaded', initializeDiscountOverlay);
// Or use callback from Nuvemshop if available
```

**Step 3: Add error handling (2h)**
```javascript
// Wrap custom JS in try-catch with console.error
try {
  // custom code
} catch(error) {
  console.error('Custom script error:', error);
}
```

**Step 4: Verify no Nuvemshop conflicts (2h)**
```bash
# Check for overwrites of window.Nuvemshop
grep -r "window.Nuvemshop" theme-deploy-corrigido/static/js/ | grep "="

# Check for jQuery/$ overwrites
grep -r "window.\$ =" theme-deploy-corrigido/static/js/

# Expected: zero results (no overwrites)
```

### Post-implementation Validation

**Time:** 2 hours
**Owner:** @qa

```bash
# 1. Functional tests
# Open browser DevTools Console
# - Add to cart → works, no errors
# - View discount overlay → works, no errors
# - Click WhatsApp → works, no errors
# - Search → works, no errors

# 2. Console clean
# Expected: zero errors, zero warnings

# 3. Lint
npm run lint

# 4. Commit
git add .
git commit -m "refactor: consolidate instatheme and optimize payment script [Story 8.5]"
```

### Checklist

- [ ] Only one instatheme.js loaded
- [ ] Duplicate instatheme removed
- [ ] payment-discount-text-override.js optimized (no 3x setTimeout)
- [ ] Error handling added
- [ ] Browser console: zero errors
- [ ] All functionality works (cart, discount, WhatsApp, search)
- [ ] Gabriel approval

---

## 🚀 Deployment Guide

### Per-Phase Deployment

**After each story complete:**

```bash
# 1. Ensure all changes committed
git status  # Should be clean

# 2. Create version tag
git tag -a v1.2.0 -m "Phase 1: Design Tokens"
# (increment: v1.2.0 → v1.3.0 → v1.4.0 → v1.5.0 → v1.6.0)

# 3. Deploy via FTP
cd ftp-deploy
node deploy.js --version v1.2.0

# 4. Verify deployment
# Visit patagang-ecommerce.nuvemshop.com.br
# Test each page visually
```

### Rollback Strategy

If issues found after deployment:

```bash
cd ftp-deploy
node rollback-incremental.js --version 1.1.18  # Roll back to previous version
```

---

## 📞 Common Issues & Troubleshooting

### Issue: FOUC (Flash of Unstyled Content)

**Symptom:** Page briefly shows unstyled content on load

**Solution:**
- Verify `<style>` critical CSS is inline in `<head>`
- Ensure async CSS uses `rel="preload"` with proper `onload` attribute
- Check Network tab: critical CSS loaded synchronously

### Issue: Color not rendering correctly

**Symptom:** Button color wrong after tokenization

**Solution:**
- Verify token defined in `style-tokens.tpl`
- Check CSS uses `var(--color-name)` syntax
- Inspect in DevTools: verify CSS variable resolved

### Issue: Breakpoint not working

**Symptom:** Mobile layout showing desktop styles

**Solution:**
- Verify breakpoint value is exactly 768px, 1024px, or 1200px
- Check `@media (min-width: ...)` syntax correct
- Test in DevTools with device toolbar

### Issue: !important still present

**Symptom:** Refactored CSS still has `!important`

**Solution:**
- Verify specificity chain increased (e.g., `.pg-card .button` vs `.button`)
- Check CSS load order (later rules override earlier)
- Use DevTools Inspector to verify which rule applied

---

## 📚 Related Resources

- **Epic 8:** `Docs/stories/8-epic-technical-refactoring.md`
- **Stories:** `Docs/stories/8.1-*.md` through `8.5-*.md`
- **Checklists:** `.aiox-core/development/checklists/refactoring-phase-validation.md`
- **Constraints:** `.claude/rules/nuvemshop-ftp-constraints.md`

---

**Guide Created:** 2026-03-21
**Authority:** @architect + @dev
**Framework:** AIOX Story Development Cycle
