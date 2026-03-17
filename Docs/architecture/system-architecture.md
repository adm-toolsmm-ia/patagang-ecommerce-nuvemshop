# System Architecture - Patagang E-commerce (Nuvemshop)

**Project:** Patagang E-commerce
**Platform:** Nuvemshop (SaaS e-commerce)
**Deploy Method:** FTP with versioning
**Last Updated:** 2026-03-15

---

## Executive Summary

Patagang é uma loja virtual customizada na plataforma Nuvemshop com theme personalizado usando:
- **Template Engine:** Liquid (Nuvemshop native)
- **Styling:** SCSS (compilado server-side) + CSS inline
- **Scripting:** JavaScript vanilla
- **Infrastructure:** FTP deployment com sistema de backup/rollback versioned

A arquitetura segue um modelo de theme-based customization típico de Nuvemshop, com múltiplas camadas de CSS cacheadas server-side e um sistema de deployment FTP otimizado com MD5 cache.

---

## 1. Stack Tecnológico

| Component | Technology | Version | Notes |
|-----------|-----------|---------|-------|
| **Platform** | Nuvemshop | SaaS | Managed e-commerce |
| **Template Engine** | Liquid | Nuvemshop | Server-side template language |
| **Styling** | SCSS + CSS | Compiled | Mixed inline e external |
| **JavaScript** | Vanilla JS | ES5/ES6 | No framework |
| **Deployment** | FTP over TLS | Node.js 14+ | Custom Node scripts |
| **Version Control** | Git | - | Local repo only |
| **Backup System** | Node.js FTP | basic-ftp 5.0.4 | Automated backups |

---

## 2. Arquitetura do Projeto

### 2.1 Estrutura de Diretórios

```
patagang-ecommerce-nuvemshop/
├── Docs/                              # Documentação e backups
│   └── platform/base-theme/           # Base theme reference (100+ .tpl files)
│       ├── layouts/                   # Main layout
│       ├── snipplets/                 # Reusable template components
│       ├── templates/                 # Page-specific templates
│       └── static/                    # CSS, JS, images
│
├── theme-deploy-corrigido/            # LIVE THEME (sincronizado com FTP)
│   ├── config/
│   │   └── data.json                  # Theme configuration
│   ├── layouts/
│   │   └── layout.tpl                 # CRÍTICO: Layout principal + override CSS
│   ├── snipplets/                     # ~80 template components
│   ├── templates/                     # Page templates (category, product, etc.)
│   └── static/
│       ├── css/                       # 6 layers of CSS
│       ├── js/                        # JavaScript custom
│       └── images/                    # Static assets
│
├── ftp-deploy/                        # Deployment automation
│   ├── deploy-optimized.js            # PRIMARY: Deploy script
│   ├── backup-full-ftp.js             # Full backup from FTP
│   ├── rollback-incremental.js        # Rollback to previous version
│   ├── sync-backup-to-local.js        # Sync FTP to local
│   ├── config.js                      # FTP credentials
│   └── package.json                   # Node dependencies
│
├── backups/                           # Backup storage
│   ├── ftp-full/[TIMESTAMP]/          # Complete FTP snapshots
│   └── incremental/[TIMESTAMP]/       # Files before each deploy
│
├── .git/                              # Git repository
└── .claude/                           # Claude Code configuration
```

### 2.2 Camadas de Templates

**Nuvemshop usa 3 níveis de componentes:**

1. **Base Theme (Docs/platform/base-theme/)**
   - Referência da estrutura padrão Nuvemshop
   - 100+ arquivos .tpl (layouts, snipplets, templates)
   - Estrutura hierárquica profunda

2. **Active Theme (theme-deploy-corrigido/)**
   - Cópia sincronizada com FTP
   - Customizações específicas da Patagang
   - ~80 snipplets + principais templates

3. **Dynamic Content**
   - Config em `data.json`
   - Variáveis Nuvemshop injetadas em tempo real
   - JavaScript dinâmico carregado

---

## 3. CSS Architecture (CRÍTICO)

### 3.1 Ordem de Carregamento (6 Camadas)

Nuvemshop injeta CSS em ordem específica. **Última camada vence tudo.**

| Order | File | Type | Location | Caching | Purpose |
|-------|------|------|----------|---------|---------|
| **1** | `style-critical.tpl` | Inline `<style>` | `<head>` | Template (no SCSS cache) | Base styles, critical inline |
| **2** | `style-colors.scss.tpl` | Inline `<style>` | `<head>` | SCSS compiled + server cache | Color variables, theme colors |
| **3** | `style-async.scss.tpl` | `<link>` async | `<head>` | **SCSS cache** ⚠️ | Main responsive grid, layout |
| **4** | `product-card-v3.css` | `<link>` | `<head>` | No cache | Product cards styling |
| **5** | `style-blog.scss.tpl` | `<link>` | `<head>` | SCSS cache | Blog-specific styles |
| **6** | **Override Final** | Inline `<style>` | `<body>` end | Template (no cache) | **VENCE TUDO** |

### 3.2 Critical CSS Rules by File

**style-critical.tpl** (carregado primeiro, pode ser sobrescrito):
- `.img-absolute` - Posicionamento absoluto de imagens
- `.img-absolute-centered` - Centralização com transform
- Base typography, resets
- Layout base classes

**style-async.scss.tpl** (CACHEADO no servidor ⚠️):
- `.item-product` - Wrapper do card
- `.item-image` - Container de imagem
- Flex grid rules (alta especificidade)
- Responsive breakpoints
- ⚠️ **Alterações podem não refletir por cache - use override final**

**product-card-v3.css** (externo, sem cache):
- `.pg-card` classes
- `.pg-card__image`, `.pg-card__info`, etc.
- Custom v3 card styling

**layout.tpl Override Final** (último, VENCE TUDO):
```html
<style id="pg-v3-override-final">
  /* CSS aqui sobrescreve TUDO */
</style>
```

### 3.3 Nuvemshop Auto-Injected Classes

Nuvemshop adiciona automaticamente:
- `.item-product` - Wrapper (equivalente a `.pg-card`)
- `.item-image` - Container (equivalente a `.pg-card__image`)
- `.item-description` - Info (equivalente a `.pg-card__info`)
- `.img-absolute` - Image positioning
- `.img-absolute-centered` - Centered image transform
- `.js-item-product` - JavaScript selector

---

## 4. Template Architecture

### 4.1 Key Templates

| File | Purpose | Dependencies | Status |
|------|---------|--------------|--------|
| `layouts/layout.tpl` | **MAIN LAYOUT** - Head, CSS, JS loading, override | ALL | Critical |
| `snipplets/grid/item.tpl` | Product card HTML | layout, CSS | Critical |
| `templates/category.tpl` | Category page | grid/item, layout | Active |
| `templates/search.tpl` | Search results page | grid/item, layout | Active |
| `templates/product.tpl` | Product detail | layout, snipplets | Active |
| `snipplets/header/header.tpl` | Header component | layout | Critical |
| `snipplets/footer.tpl` | Footer component | layout | Active |

### 4.2 Component Organization

**Snipplets (Reusable):**
```
snipplets/
├── grid/           # Product grid components (item, pagination, filters)
├── header/         # Header variations
├── banner-services/
├── product/        # Product-specific (image, form, variants, etc.)
├── cart-*/         # Cart-related snipplets
├── navigation/     # Menu variations
├── home/           # Home-specific sections
└── svg/            # SVG icon components
```

**Templates (Page-specific):**
```
templates/
├── category.tpl    # Category listing
├── search.tpl      # Search results
├── product.tpl     # Product detail
├── home.tpl        # Homepage
├── cart.tpl        # Shopping cart
└── account/        # Account pages
```

---

## 5. JavaScript Architecture

### 5.1 Script Loading

Located in `layout.tpl`:
1. **Nuvemshop core scripts** (injected by platform)
2. **Custom scripts** in `static/js/`
3. **Third-party integrations** (analytics, tracking)

### 5.2 Custom JavaScript Files

Main scripts in `static/js/`:
- Product interactions (image zoom, variants)
- Cart updates (AJAX)
- Search autocomplete
- Navigation menus (mobile toggle)
- Analytics/tracking

---

## 6. Deployment Architecture

### 6.1 Deploy System (FTP over TLS)

**Primary Script:** `ftp-deploy/deploy-optimized.js`

**Features:**
- **MD5 Cache** - Only upload modified files
- **Automatic Backup** - Saves remote files before upload
- **Versioning** - Version ID injected in layout.tpl
- **Retry Logic** - Auto-reconnect on timeout
- **Progress Tracking** - Real-time upload status

**Workflow:**
```
1. Collect local files
2. Calculate MD5 hashes
3. Compare with .deploy-cache.json
4. Detect modified files
5. Connect to FTP
6. Download remote versions to backup/incremental/
7. Upload modified files
8. Update .deploy-cache.json
9. Generate version ID
```

### 6.2 Cache Strategy

**FTP Deploy Cache (.deploy-cache.json):**
```json
{
  "layouts/layout.tpl": "a1b2c3d4e5f6...",
  "static/css/style-async.scss.tpl": "f6e5d4c3b2a1..."
}
```

**Results:**
- First deploy: ~290 files (all)
- Subsequent: Only changed files
- Speed improvement: ~50x faster

### 6.3 Backup Strategy

**Two Backup Types:**

1. **Full Backups** (`backups/ftp-full/[TIMESTAMP]/`)
   - Complete snapshot of FTP
   - Created manually: `npm run backup:full`
   - Used for: Major changes, snapshots, sync reference

2. **Incremental Backups** (`backups/incremental/[TIMESTAMP]/`)
   - Only files modified in each deploy
   - Created automatically before each upload
   - Used for: Rollback, version history

### 6.4 Rollback Process

**Script:** `ftp-deploy/rollback-incremental.js`

```bash
# List available backups
node list-backups.js

# Rollback to most recent
node rollback-incremental.js

# Rollback to specific timestamp
node rollback-incremental.js 2026-02-14T00-10-23
```

---

## 7. Nuvemshop Integration

### 7.1 Platform Features

**Variables Available in Templates:**
- `{{ store }}` - Store configuration
- `{{ product }}` - Product details
- `{{ product.variants }}` - Variations
- `{{ cart }}` - Shopping cart data
- `{{ customer }}` - Customer info
- `{{ collections }}` - Product collections
- `{{ search.query }}` - Search term
- `{{ menu }}` - Navigation menu

### 7.2 Theme Configuration

**config/data.json:**
- Theme settings (colors, fonts, layout options)
- Feature toggles
- Component configurations
- Nuvemshop native settings

### 7.3 Admin Integration

**Cache Management:**
- Admin > Meus Temas > (3 pontos menu)
- "Limpar Cache" - Clear theme cache
- ⚠️ **MUST execute after every deploy**

**Theme Editor:**
- Nuvemshop admin allows live CSS editing
- Changes reflect immediately (no cache)
- Direct theme customization available

---

## 8. Dependencies

### 8.1 Node.js Dependencies (ftp-deploy/)

```json
{
  "basic-ftp": "^5.0.4"
}
```

- **basic-ftp** - FTP client library
- Node 14+ required

### 8.2 External Dependencies (in theme)

**Third-party services integrated:**
- Analytics (Google Analytics, Facebook Pixel)
- Payment processors (Nuvemshop integrated)
- Shipping calculators (Nuvemshop API)
- Chat support (if configured)

---

## 9. Technical Debts Identified

### 9.1 System-Level

1. **CSS Complexity & Caching Issues**
   - Multiple SCSS files with server-side caching
   - style-async.scss.tpl cached - changes may not reflect
   - Workaround: use layout.tpl override final section
   - **Impact:** HIGH - Debugging CSS is unpredictable
   - **Effort:** MEDIUM - Need to refactor CSS layers

2. **No Build Pipeline**
   - SCSS compiled server-side (Nuvemshop)
   - No local build process
   - No CSS minification control
   - **Impact:** MEDIUM - Limits optimization
   - **Effort:** MEDIUM - Could implement local build

3. **FTP Deployment Only**
   - No CI/CD pipeline
   - Manual deploy scripts in Node.js
   - No automated testing before deploy
   - **Impact:** MEDIUM - Deployment risk high
   - **Effort:** MEDIUM-HIGH - Implement pre-deploy checks

4. **No Componentization System**
   - Snipplets are .tpl files (template language)
   - No reusable component library
   - Duplicate code across templates
   - **Impact:** MEDIUM - Maintenance burden
   - **Effort:** HIGH - Needs design system

5. **JavaScript Not Modularized**
   - Vanilla JS loaded globally
   - No module system or bundler
   - Potential conflicts and scope pollution
   - **Impact:** LOW - Works but fragile
   - **Effort:** MEDIUM - Add module system

6. **Limited Version Control**
   - Only local Git repo
   - No central repository
   - Backup structure not integrated with Git
   - **Impact:** LOW - Backups work independently
   - **Effort:** MEDIUM - Add remote repo, CI/CD

7. **No Automated Testing**
   - No unit tests
   - No integration tests
   - No visual regression tests
   - Manual QA only
   - **Impact:** MEDIUM - Quality risk
   - **Effort:** HIGH - Implement test suite

8. **Template Duplication**
   - Some templates have similar structures
   - No template inheritance mechanism used
   - Copy-paste patterns observed
   - **Impact:** LOW - Maintenance issue
   - **Effort:** MEDIUM - Refactor shared patterns

### 9.2 Performance Issues

1. **CSS Cascade Complexity**
   - 6 layers of CSS loading
   - High specificity rules overriding each other
   - Async SCSS file may cause layout shifts
   - **Impact:** HIGH - Performance, UX
   - **Effort:** HIGH - Reorganize CSS

2. **No Image Optimization**
   - Static images may not be optimized
   - No lazy loading strategy visible
   - Asset delivery via FTP (not CDN)
   - **Impact:** MEDIUM - Page speed
   - **Effort:** MEDIUM - Add image optimization

3. **Synchronous Script Loading**
   - Scripts in head may block rendering
   - No async/defer attributes visible
   - **Impact:** LOW-MEDIUM - LCP issue
   - **Effort:** LOW - Add async attributes

### 9.3 Maintainability Issues

1. **Documentation Gaps**
   - CSS loading order documented in CODEBASE.md (good)
   - But theme logic not documented
   - No component inventory
   - **Impact:** MEDIUM - Onboarding difficult
   - **Effort:** MEDIUM - Create docs

2. **Hardcoded Configuration**
   - Colors, fonts may be hardcoded in CSS
   - Limited use of CSS variables
   - **Impact:** LOW - Works but limits flexibility
   - **Effort:** LOW - Add CSS variables

3. **Server Cache Strategy Unclear**
   - When does SCSS recompile?
   - What triggers cache invalidation?
   - **Impact:** MEDIUM - Debugging hard
   - **Effort:** MEDIUM - Document cache

---

## 10. Critical Decision Points

### 10.1 What Nuvemshop Controls

**Cannot change:**
- Core platform version
- Payment processing
- Shipping integration
- Analytics structure
- Admin interface

**Must work within:**
- Liquid template syntax
- Nuvemshop variable naming
- Theme upload structure
- Cache invalidation process

### 10.2 Customization Boundaries

**We can customize:**
- All CSS (inline or external)
- All JavaScript (custom)
- All template structure (within Liquid syntax)
- Theme configuration (data.json)

**We cannot customize:**
- Server-side template compilation
- FTP file upload (limited to theme structure)
- Admin UI
- Core platform features

---

## 11. Current Technology Gaps

| Gap | Impact | Resolution |
|-----|--------|-----------|
| No local CSS build | Can't optimize CSS locally | Add Sass compiler locally |
| No pre-deploy validation | Deploy failures possible | Add linting + tests |
| No component library | Code duplication | Create Liquid component system |
| No version tracking in code | Hard to rollback to version | Better Git integration |
| No automated testing | Quality risk | Add test suite |
| FTP only deployment | Limited automation | Add GitHub integration |
| No A/B testing setup | Can't validate changes | Implement split testing |

---

## 12. Recommendations for Modernization

### Quick Wins (Low effort, high impact):
1. Add CSS variable definitions
2. Improve layout.tpl override documentation
3. Create component inventory
4. Add Git hooks to validate before deploy

### Medium-term (Medium effort, medium impact):
1. Create local Sass build process
2. Implement pre-deploy validation
3. Add automated visual tests
4. Create template documentation

### Long-term (High effort, high impact):
1. Migrate to Shopify/other platform with better tooling
2. Implement proper CI/CD pipeline
3. Create reusable component library
4. Add comprehensive test coverage

---

## 13. Success Metrics

| Metric | Current | Target |
|--------|---------|--------|
| Deploy time | ~30-60s | < 10s |
| Failed deploys/month | 1-2 | 0 |
| CSS debugging time | High | Low |
| New feature time | 2-3 days | 1 day |
| Bug fix time | 1-2 days | 4 hours |
| Test coverage | 0% | 80%+ |
| PageSpeed score | Unknown | 80+ |
| Mobile UX | Requires optimization | Excellent |

---

## Appendix: File Statistics

```
Total Templates (.tpl):     ~100+
Active Theme Files:         ~150-200
CSS Files:                  6 main files + inlines
JavaScript Files:           ~5 custom files
Image Assets:               ~50+ static images
Backup Directory Size:      ~1-2 GB (accumulated)
Theme Directory Size:       ~50-100 MB
```

---

## Next Steps

1. ✅ Phase 1 Complete: System architecture documented
2. ⏭️ Phase 2: Database audit (SKIPPED - Nuvemshop managed)
3. ⏭️ Phase 3: Frontend/UX specification
4. ⏭️ Phase 4: Consolidate findings into technical debt DRAFT

---

**Document Status:** PHASE 1 COMPLETE
**Created:** 2026-03-15
**By:** Claude Code - @architect delegation
**Next Review:** @ux-design-expert (FASE 3)
