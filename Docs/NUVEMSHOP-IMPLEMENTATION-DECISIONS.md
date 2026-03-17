# Nuvemshop Implementation Decisions - Developer Guide

**Quick Reference for Safe Decisions During Implementation**
**Use this guide to answer "Can I do this?" questions**

---

## Decision Tree: Can I Modify This?

```
┌─ Is it in theme/ directory?
│  │
│  ├─ YES (layouts/, snipplets/, templates/, static/)
│  │  └─ ✅ SAFE - Proceed with caution, test in staging
│  │
│  └─ NO
│     ├─ Is it configuration or documentation?
│     │  └─ (Docs/, .github/, configs)
│     │  └─ ✅ SAFE - Git-tracked, no deploy impact
│     │
│     └─ Is it a Nuvemshop system file?
│        └─ (.aiox/, .claude/, node_modules/, etc.)
│        └─ ❌ DON'T TOUCH - Framework/infrastructure files
```

---

## Can I Do This? Lookup Table

| Change Type | Can Do? | Example | Risk | Notes |
|-------------|---------|---------|------|-------|
| **Edit Liquid template** | ✅ YES | `theme/snipplets/product-card.tpl` | LOW | Test in staging |
| **Edit SCSS file** | ✅ YES | `theme/static/scss/colors.scss` | LOW | Uses cache-buster |
| **Edit CSS file** | ✅ YES | `theme/static/css/custom.css` | NONE | Direct deploy |
| **Edit JavaScript** | ✅ YES | `theme/static/js/cart.js` | MEDIUM | Test behavior |
| **Add new file** | ✅ YES | `theme/snipplets/new-component.tpl` | NONE | Auto-included |
| **Delete file** | ⚠️ CAUTION | Removing old template | MEDIUM | Check dependencies |
| **Modify layout.tpl** | ✅ YES | Override CSS | LOW | Last layer wins |
| **Access Nuvemshop database** | ❌ NO | Product data via SQL | NONE | Not possible |
| **Create backend API** | ❌ NO | Custom /api/endpoint | NONE | Not possible |
| **Install Node package** | ✅ YES | npm install jest | NONE | Local dev only |
| **Deploy Node package** | ❌ NO | Ship node_modules to FTP | BLOCKED | Not deployed |
| **Use ES6 modules** | ❌ NO | import/export syntax | BLOCKED | Use IIFE instead |
| **Create .env file** | ❌ NO | FTP credentials | BLOCKED | Use GitHub Secrets |
| **Modify Nuvemshop core** | ❌ NO | Edit Nuvemshop files | BLOCKED | No access |

---

## Safe Patterns by Debt Type

### CSS Changes (FE-1, FE-3, FE-4, FE-6, FE-7, FE-13, FE-8, FE-9)

#### Pattern: Add CSS Rule
```scss
// ✅ SAFE - Adding new rules
.my-new-style {
  color: var(--color-primary);
  padding: var(--space-md);
}

// ⚠️ CAUTION - Overriding existing rules
.item-product {
  display: flex !important; // Force override, but use layout.tpl instead
}

// ✅ SAFE - Use layout.tpl for overrides
// In theme/layouts/layout.tpl:
<style id="pg-override-final">
  .item-product { display: flex; }
</style>
```

#### Pattern: CSS Variables
```scss
// ✅ SAFE - Define tokens
:root {
  --color-primary: #FF6B35;
  --space-md: 16px;
}

// ✅ SAFE - Use tokens
.button {
  background: var(--color-primary);
  padding: var(--space-md);
}

// ❌ DON'T - Hardcode values anymore
.button {
  background: #FF6B35; // Use variable instead
  padding: 16px;       // Use variable instead
}
```

#### Pattern: Cache Busting
```html
<!-- BEFORE: Static link (cached) -->
<link rel="stylesheet" href="/static/css/main.css">

<!-- AFTER: With version ID (cache-busted) -->
<link rel="stylesheet" href="/static/css/main.css?v=20260315">

<!-- In deployment script: increment version ID -->
sed -i 's/?v=[0-9]*/?v=20260316/' theme/layouts/layout.tpl
```

---

### Template Changes (FE-2, FE-5, FE-6)

#### Pattern: Add HTML Element
```liquid
<!-- ✅ SAFE - Add HTML element -->
<label for="email-input">Email Address</label>
<input type="text" id="email-input" name="email">

<!-- ✅ SAFE - Add alt text -->
<img src="..." alt="Product name - detailed description">

<!-- ❌ DON'T - Remove existing elements -->
<!-- This breaks if other templates depend on it -->
```

#### Pattern: Use Liquid Variables
```liquid
<!-- ✅ SAFE - Use Nuvemshop variables -->
<h1>{{ product.name }}</h1>
<p>{{ product.description | truncate: 100 }}</p>

<!-- ❌ DON'T - Create custom backend logic -->
{% assign custom_value = "hardcoded" %}
<!-- These are fine locally, but won't scale -->
```

#### Pattern: Create New Snippet
```liquid
<!-- ✅ SAFE - Create new snippet -->
<!-- Create: theme/snipplets/badge-status.tpl -->
<span class="badge badge--{{ status }}">
  <svg>...</svg>
  {{ label }}
</span>

<!-- Use in other templates -->
{% include 'snipplet' 'badge-status', status: 'active', label: 'Active' %}
```

---

### JavaScript Changes (FE-12, SYS-5)

#### Pattern: Add to Module
```javascript
// ✅ SAFE - Add to IIFE module
const CartModule = (function() {
  let state = [];

  return {
    add: function(item) {
      state.push(item);
    },
    get: function() {
      return state;
    }
  };
})();

// Use it
CartModule.add({ id: 1, name: 'Product' });
console.log(CartModule.get());

// ❌ DON'T - Use import/export (Nuvemshop limitation)
// export function add(item) { }  // WON'T WORK
// import { add } from './cart.js'; // WON'T WORK
```

#### Pattern: Test JavaScript
```javascript
// test/cart.test.js
const { CartModule } = require('../theme/static/js/cart.js');

describe('CartModule', () => {
  test('adds item', () => {
    CartModule.add({ id: 1 });
    expect(CartModule.get()).toHaveLength(1);
  });
});

// Run: npm test
```

#### Pattern: Lazy Load Script
```html
<!-- In template -->
<script>
  // Load script only when needed
  if (document.querySelector('[data-mobile-menu]')) {
    const script = document.createElement('script');
    script.src = '/static/js/mobile-menu.js?v=20260315';
    document.head.appendChild(script);
  }
</script>
```

---

### Testing Changes (SYS-7, FE-12)

#### Pattern: Write Unit Test
```javascript
// theme/static/js/utils.js
function formatPrice(price) {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(price);
}

// tests/utils.test.js
describe('formatPrice', () => {
  test('formats price in BRL', () => {
    expect(formatPrice(1000)).toBe('R$ 1.000,00');
  });
});
```

#### Pattern: Write E2E Test
```javascript
// tests/e2e/checkout.spec.js
describe('Checkout Flow', () => {
  it('should complete purchase', () => {
    cy.visit('https://patagang.myshopify.com/cart');
    cy.contains('button', 'Proceed to Checkout').click();
    cy.url().should('include', '/checkout');
    cy.get('[data-test=success-message]').should('be.visible');
  });
});
```

---

### Build Changes (SYS-2)

#### Pattern: Configure Webpack
```javascript
// webpack.config.js (LOCAL ONLY - not deployed)
module.exports = {
  entry: './theme/static/scss/main.scss',
  output: {
    path: './theme/static/css/',
    filename: 'main.min.css'
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: ['style-loader', 'sass-loader']
      }
    ]
  }
};

// Run: npm run build
// Deploy: theme/static/css/main.min.css (minified output)
```

#### Pattern: Deploy Minified Files
```bash
# ✅ SAFE - Deploy minified CSS/JS
ftp-deploy --local theme/static/css/main.min.css \
           --remote /static/css/main.min.css

# ❌ DON'T - Deploy webpack/node_modules
# These stay local, never deployed
```

---

### CI/CD Changes (SYS-3)

#### Pattern: Add GitHub Actions
```yaml
# .github/workflows/deploy.yml
name: Deploy
on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: npm test
      - run: npm run lint
      # Manual approval before FTP deploy
```

#### Pattern: Protect Main Branch
```
GitHub Settings → Branches → Add Rule (main)
✅ Require pull request reviews (1)
✅ Require status checks passing
✅ Include administrators
✅ Require branches up to date
```

---

## Common Pitfalls & Solutions

### Pitfall 1: CSS Changes Don't Appear

```
Problem: Edited style-async.scss.tpl, but changes don't show
Reason:  Server-side cache (Nuvemshop limitation)
Solution: Use layout.tpl override instead

// ❌ WRONG - Changes cached
theme/static/scss/style-async.scss.tpl

// ✅ CORRECT - Override final
In theme/layouts/layout.tpl:
<style id="pg-override">
  /* Your CSS here - ALWAYS wins */
</style>
```

### Pitfall 2: JavaScript Error on Page

```
Problem: Deployed JS, now page shows error
Reason:  JavaScript broke during execution
Fix:
  1. Open Chrome DevTools (F12)
  2. Check Console tab for error
  3. Revert deployment: git revert <hash>
  4. Redeploy previous version
  5. Fix code locally and test before re-deploy
```

### Pitfall 3: Template Change Breaks Layout

```
Problem: Modified product card, now all products missing
Reason:  Didn't check if other templates depend on it
Fix:
  1. Search for references: grep -r "product-card" theme/
  2. Check all calling templates
  3. Test on multiple product pages
  4. Rollback if broken: git revert <hash>
```

### Pitfall 4: Deployed Node Package by Mistake

```
Problem: FTP upload includes node_modules (400MB+)
Reason:  npm install added packages to repo
Fix:
  1. Add to .gitignore: node_modules/
  2. FTP delete node_modules/ (use FTP client)
  3. Update deploy script to skip npm packages
  4. Redeploy without node_modules
```

### Pitfall 5: Cache Buster Outdated

```
Problem: Still seeing old CSS even after cache bust
Reason:  Browser cache or CDN cache
Fix:
  1. Hard refresh: Ctrl+Shift+R (or Cmd+Shift+R)
  2. Incognito window: Ctrl+Shift+N
  3. Clear browser cache: Settings → Clear browsing data
  4. Wait 1 hour for CDN cache to expire
```

---

## Pre-Deploy Checklist

### Before ANY Deploy

```
Code Quality:
  [ ] npm test passes (no failures)
  [ ] npm run lint passes (no errors)
  [ ] No console errors (F12 → Console)
  [ ] No accessibility violations (WAVE extension)

Staging Validation:
  [ ] Deployed to staging Nuvemshop store
  [ ] Tested on Chrome, Firefox, Safari
  [ ] Tested on iPhone and Android
  [ ] Keyboard navigation works (Tab through page)
  [ ] Screen reader test (NVDA or VoiceOver)

Performance:
  [ ] Lighthouse score checked (target: 85+)
  [ ] Core Web Vitals acceptable
  [ ] No performance regression

Backup:
  [ ] Full FTP backup created: npm run backup
  [ ] Backup file stored safely
  [ ] Rollback procedure documented

Final Checks:
  [ ] Git committed: git status is clean
  [ ] Branch up to date: git pull origin main
  [ ] Reviewed changes: git diff main...HEAD
  [ ] PR reviewed and approved (if required)
```

### Before CRITICAL Deploy (Major Changes)

```
Additional:
  [ ] Tested with real products/customers (staging)
  [ ] Tested payment flow (sandbox mode)
  [ ] Tested cart/checkout (staging)
  [ ] Monitored error logs after deploy (2 hours)
  [ ] Support team alerted (30 min before)
  [ ] Emergency contact on-call
  [ ] Rollback plan documented in Slack
```

---

## Quick Decision Reference

### When in Doubt...

1. **"Can I change this file?"**
   - If it's in `theme/` → ✅ YES
   - If it's in `Docs/` or `.github/` → ✅ YES
   - If it's in `.aiox/` or `node_modules/` → ❌ NO

2. **"Will this break the site?"**
   - If you tested in staging → ⚠️ MAYBE (deploy with caution)
   - If you didn't test in staging → ❌ PROBABLY (test first!)

3. **"Is this Nuvemshop compatible?"**
   - Liquid templates → ✅ YES
   - SCSS/CSS → ✅ YES
   - Vanilla JavaScript → ✅ YES
   - ES6 modules → ❌ NO
   - Backend API → ❌ NO
   - Database query → ❌ NO

4. **"How long to rollback?"**
   - Single file → 5 minutes (FTP + cache clear)
   - Multiple files → 10 minutes (backup restore)
   - Database change → ❌ NOT POSSIBLE (don't do this)

---

## Communication Templates

### When You Need Approval

```
"I want to modify [FILE] to [CHANGE].

Why: [REASON]
Risk: [MEDIUM/LOW/NONE]
Test Plan: [How I'll test]
Rollback: [How to revert]

OK to proceed?"
```

### When You Find an Issue

```
"Issue: [WHAT BROKE]
Severity: [CRITICAL/HIGH/MEDIUM/LOW]
Discovered: [WHERE/WHEN]
Reproducing: [STEPS]
Fix: [SOLUTION]
Need help? [WHO]"
```

### When Deploy is Complete

```
"✅ Deployed to production: [COMMIT]
Tested: [WHAT WAS TESTED]
Monitoring: [WHAT TO WATCH]
Timeline: [WHEN TO EXPECT RESULTS]
Issue? Rollback: npm run rollback [VERSION]"
```

---

## Nuvemshop Troubleshooting

### Problem: "Site shows old CSS"

| Cause | Fix | Time |
|-------|-----|------|
| Browser cache | Hard refresh (Ctrl+Shift+R) | 1 sec |
| Server cache | Clear cache: Dashboard → Settings | 5 min |
| CDN cache | Wait 1 hour OR purge manually | 1-60 min |

### Problem: "JavaScript error on page"

| Cause | Fix | Time |
|-------|-----|------|
| Syntax error | npm test locally first | 2 min |
| Global scope conflict | Check console for variable name | 5 min |
| Module not loaded | Check script tags in layout.tpl | 2 min |

### Problem: "Template won't render"

| Cause | Fix | Time |
|-------|-----|------|
| Liquid syntax error | Validate with {% raw %} tags | 5 min |
| Missing snippet | Check if file exists in theme/ | 2 min |
| Variable not available | Nuvemshop scope limitation | 10 min |

### Problem: "Performance degraded"

| Cause | Fix | Time |
|-------|-----|------|
| Large file added | Minify with webpack | 10 min |
| Too many requests | Concatenate files | 10 min |
| Image not optimized | Convert to WebP | 20 min |

---

## Key Files by Debt Type

| Debt | Primary Files | Secondary Files |
|------|---------------|-----------------|
| **SYS-1** CSS Cache | `theme/layouts/layout.tpl` | `ftp-deploy/deploy-optimized.js` |
| **FE-4** Focus | `theme/static/css/accessibility.css` | — |
| **FE-5** Alt Text | `theme/snipplets/product-card-*.tpl` | — |
| **FE-1** CSS Vars | `theme/static/scss/_tokens.scss` | All SCSS files |
| **FE-2** Storybook | `stories/` | `storybook-config.js` |
| **SYS-7** Tests | `tests/` | `jest.config.js`, `package.json` |
| **FE-12** E2E | `tests/e2e/` | `cypress.config.js` |
| **SYS-2** Build | `webpack.config.js` | `package.json` |
| **SYS-3** CI/CD | `.github/workflows/` | `.github/settings.json` |
| **SYS-4** Design | `docs/design-system/` | `theme/static/scss/` |

---

## Document Control

| Item | Value |
|------|-------|
| **Purpose** | Quick reference during implementation |
| **Audience** | Frontend developers |
| **Updated** | 2026-03-15 |
| **Status** | ACTIVE - Use during all development |
| **Questions** | Ask in #tech-decisions Slack channel |

---

**Remember:** When in doubt, TEST IN STAGING FIRST.

**Not sure?** Ask tech lead before proceeding.

**Broke something?** Git revert + redeploy (takes 10 min).

