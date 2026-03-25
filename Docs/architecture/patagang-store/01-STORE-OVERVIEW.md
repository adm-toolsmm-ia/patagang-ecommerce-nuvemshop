# 1. Patagang Store Architecture — Overview

**Purpose:** High-level understanding of store structure, technology stack, and key architectural decisions

---

## 🏗️ Architecture at a Glance

```
┌─────────────────────────────────────────────────────────────┐
│                   NUVEMSHOP ECOMMERCE STORE                  │
│                     (Patagang Pet Brand)                     │
└────────────────┬──────────────────────────────────┬──────────┘
                 │                                   │
         ┌───────▼────────┐              ┌──────────▼─────┐
         │  TEMPLATES     │              │   STATIC ASSETS │
         │  (12 pages)    │              │  CSS / JS / IMG │
         │                │              │                 │
         │  • home.tpl    │              │ style-critical  │
         │  • product.tpl │              │ style-async     │
         │  • cart.tpl    │              │ store.js        │
         │  • category    │              │ external.js     │
         │  • checkout    │              │ cart-drawer.js  │
         │  • blog        │              │ images/*        │
         │  • etc.        │              │                 │
         └────────┬───────┘              └────────┬────────┘
                  │                               │
         ┌────────▼────────────────────────────────▼────────┐
         │         SNIPPLETS / COMPONENTS (41)              │
         │  ─────────────────────────────────────────       │
         │  Navigation (8) │ Cart (6) │ Product (6)         │
         │  Forms (2) │ UI (6) │ Footer (2) │ Special (5)   │
         └──────────────────┬───────────────────────────────┘
                            │
              ┌─────────────┴──────────────────┐
              │  LAYOUT.TPL (Master Template)   │
              │  ─────────────────────────────  │
              │  <head>: Critical CSS inlined   │
              │  <body>: Dynamic content        │
              │         (filled by templates)   │
              └────────────────────────────────┘
                            │
              ┌─────────────▼──────────────┐
              │   NUVEMSHOP PLATFORM       │
              │  (Checkout, Auth, APIs)    │
              └────────────────────────────┘
```

---

## 📦 Project Structure

```
theme-deploy-corrigido/
│
├── layouts/
│   └── layout.tpl                   # Master template (all pages)
│       ├── Inlines critical CSS
│       ├── Loads fonts
│       ├── Meta tags
│       └── Includes page-specific content
│
├── templates/                       # Main page templates (12 files)
│   ├── home.tpl                    # Homepage (hero + product sections)
│   ├── product.tpl                 # Product detail page
│   ├── category.tpl                # Category listing page
│   ├── cart.tpl                    # Shopping cart
│   ├── blog.tpl & blog-post.tpl   # Blog pages
│   ├── search.tpl                  # Search results
│   ├── account/*.tpl               # Login, register, orders, addresses
│   ├── contact.tpl                 # Contact form
│   ├── page.tpl                    # Generic CMS pages
│   ├── 404.tpl                     # Not found
│   └── password.tpl                # Password protected store
│
├── snipplets/                       # Reusable components (41 files)
│   ├── navigation/                 # Navigation & menus (8 files)
│   ├── product/                    # Product-related (6 files)
│   ├── *-cart*.tpl                # Cart operations (6 files)
│   ├── footer.tpl                  # Footer with attribution
│   ├── modal*.tpl                  # Modals
│   ├── notification*.tpl           # Notifications
│   ├── help-sidebar.tpl            # Help widget (Story 1.1.1)
│   └── [others]                    # UI, forms, special features
│
├── static/
│   │
│   ├── css/                        # CSS files (15 total)
│   │   ├── style-critical.tpl     # 163KB ⚠️ OVERSIZED
│   │   ├── style-async.scss.tpl   # 164KB (async loaded)
│   │   ├── style-colors.scss.tpl  # Color tokens
│   │   ├── style-tokens.tpl       # Design tokens
│   │   ├── style-menu-patagang.css.tpl
│   │   ├── style-filters-patagang.css.tpl
│   │   ├── style-help-sidebar.css.tpl
│   │   ├── style-whatsapp-button.css.tpl
│   │   ├── style-blog.scss.tpl
│   │   ├── style-fonts.tpl
│   │   └── [legacy files]
│   │
│   ├── js/                         # JavaScript files (6+ TPL files)
│   │   ├── store.js.tpl           # 125KB (core store logic)
│   │   ├── external.js.tpl        # 106KB (Olark, GA, Swiper)
│   │   ├── cart-drawer.js.tpl     # 25KB (cart sidebar)
│   │   ├── cart-utils.js.tpl      # 15KB (cart utilities)
│   │   ├── product-page-custom.js # Product-specific
│   │   ├── smooth-scroll.js       # Smooth scrolling
│   │   ├── payment-discount-text-override.js
│   │   ├── external-no-dependencies.js.tpl
│   │   ├── google-survey.js.tpl
│   │   ├── instatheme.js          # Instagram feed
│   │   └── version-info.js        # Version tracking
│   │
│   └── images/                     # Static images
│       ├── home-v2-hero-desktop.png
│       ├── home-v2-hero-mobile.png
│       ├── logos/
│       └── [product images, icons, etc]
│
└── [other files: config, metadata, etc]
```

---

## 🎨 Tech Stack

| Component | Technology | Version | Notes |
|-----------|-----------|---------|-------|
| **Platform** | Nuvemshop | Current | Shopify alternative for LATAM |
| **Templating** | Liquid/Twig | Nuvemshop dialect | Limited to .tpl files |
| **CSS** | SCSS/CSS3 | 2024 features | Preprocessed by Nuvemshop |
| **JavaScript** | ES6+ | Modern JS | jQuery for compatibility |
| **Layout** | Bootstrap 4 Grid | Nuvemshop bundle | `col-12 col-lg-5` classes |
| **Package Manager** | None | Static theme | FTP-deployed |
| **CI/CD** | Node scripts | Custom | `ftp-deploy/deploy.js` |
| **Version Control** | Git | GitHub | Branch-based workflow |

---

## 📊 Store Metrics

### **Inventory**
| Category | Count | Status |
|----------|-------|--------|
| Main Pages | 12 | ✅ Documented |
| Snipplets | 41 | ✅ Documented |
| CSS Files | 15 | ⚠️ Critical oversized |
| JS Modules | 6+ | ✅ Documented |
| Design System Colors | 8 | ✅ Defined |
| Typography Scales | 4 | ✅ Defined |

### **Performance**
| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| LCP (Home) | 1.2s | < 2.5s | ✅ Good |
| FID | 0.05s | < 0.1s | ✅ Excellent |
| CLS | 0.08 | < 0.1 | ✅ Good |
| Lighthouse (Mobile) | 92/100 | > 90 | ✅ Good |
| Critical CSS Size | 163KB | < 50KB | 🔴 Over (3.26x) |

---

## 🔄 Page Flow

```
USER REQUESTS PAGE
        │
        ▼
REQUEST ROUTED BY NUVEMSHOP
        │
        ▼
LAYOUT.TPL LOADS (MASTER)
        │
        ├─ <head>
        │  ├─ Meta tags, SEO
        │  ├─ Fonts preload
        │  ├─ Critical CSS inlined
        │  │  └─ style-critical.tpl (163KB)
        │  │  └─ style-colors.scss.tpl
        │  │  └─ style-menu-patagang.css.tpl
        │  │  └─ style-filters-patagang.css.tpl
        │  │  └─ style-help-sidebar.css.tpl
        │  │  └─ style-whatsapp-button.css.tpl
        │  └─ Async CSS link
        │     └─ style-async.scss.tpl (loaded non-blocking)
        │
        ├─ <body>
        │  ├─ navigation.tpl (all pages)
        │  ├─ [PAGE-SPECIFIC-TEMPLATE.tpl]
        │  │  └─ Includes snipplets
        │  │  └─ Loads JS (store.js, external.js, etc)
        │  └─ footer.tpl (all pages)
        │
        └─ <script>
           └─ store.js.tpl (125KB)
           └─ external.js.tpl (106KB)
           └─ cart-drawer.js.tpl
           └─ other JS modules

BROWSER RENDERS PAGE
        │
        ▼
USER INTERACTS
        │
        ├─ Click add-to-cart → store.js handles
        ├─ Open cart drawer → cart-drawer.js handles
        ├─ Search products → store.js + external.js
        ├─ Share social → external.js (Facebook SDK)
        └─ Chat widget → external.js (Olark, lazy-loaded)
```

---

## 🎯 Key Architectural Decisions

### 1. **CSS Strategy: Critical + Async**

**Decision:** Split CSS into two categories
- **Critical CSS** (163KB, inlined in `<head>`) — Required for initial paint
- **Async CSS** (164KB, loaded after) — Non-critical, lazy-loaded

**Status:** ⚠️ Critical CSS EXCEEDS 50KB limit (Story 8.2 goal: reduce)

### 2. **JavaScript Loading: Blocking + Async + Lazy**

**Decision:** Three-tier JS loading strategy
- **Blocking JS:** `store.js` (125KB) — Must load before interaction
- **Async JS:** `external.js` (106KB), `cart-drawer.js` — Non-blocking
- **Lazy-loaded:** Olark chat (deferred in v1.5.74) — Load on-demand

### 3. **Component Architecture: Snipplets**

**Decision:** All reusable UI as `.tpl` snipplets
- 41 snipplets for cart, products, navigation, forms, UI
- Reusable across pages (e.g., `product_grid.tpl` used in home, category, search)
- Centered around Nuvemshop data structures

### 4. **Layout Pattern: Master Template**

**Decision:** All pages inherit from `layout.tpl`
- Single source for head, navigation, footer
- Consistent CSS/JS loading
- Each page template fills `content` area

### 5. **Constraint Awareness: Nuvemshop Restrictions**

**Decision:** Design around Nuvemshop platform requirements
- ✅ Checkout form structure PROTECTED (not modifiable)
- ✅ Footer attribution REQUIRED (visible)
- ✅ Contact form structure PROTECTED
- ✅ 8 total critical constraints documented

---

## 🎓 Core Concepts

### **Design System**
- **Colors:** 8 primary colors defined in `style-colors.scss.tpl`
- **Typography:** Font families from Nuvemshop settings
- **Spacing:** Bootstrap grid + custom margin/padding system
- **Tokens:** Design values in `style-tokens.tpl`

### **Responsive Breakpoints**
```
Mobile:     < 768px (xs, sm)
Tablet:     768px - 1199px (md, lg)
Desktop:    1200px+ (xl, xxl)
```
Using Bootstrap classes: `col-12 col-md-6 col-lg-4`

### **Performance Optimization**
- Lazy loading images: `loading="lazy"` attribute
- Async CSS loading: `<link rel="stylesheet" media="print" onload="this.media='all'">`
- Lazy-loading JS: Olark deferred (v1.5.74)
- Minification: Nuvemshop handles
- CDN: Nuvemshop CDN for assets

### **SEO Structure**
- Meta tags in `layout.tpl`
- Canonical URLs to prevent duplicates
- Structured data (JSON-LD) for products
- Robots meta (noindex for admin, cart, search)
- Open Graph tags for social sharing

---

## 🔗 Dependencies & Integrations

### **External Libraries**
- **jQuery** — Nuvemshop core (required)
- **Bootstrap 4** — Nuvemshop grid system
- **Swiper.js** — Image sliders (product, category)
- **Olark** — Chat widget (now lazy-loaded)
- **Google Analytics** — Tracking
- **Facebook SDK** — Social features, comments
- **Drift** — Support/messaging

### **Nuvemshop APIs Used**
- **Cart API** — Add/remove/update items
- **Shipping Calculator** — Real-time shipping quotes
- **Product Variants** — SKU selection
- **Customer Authentication** — Login/register
- **Payment Integration** — Checkout (not customizable)

---

## 📈 Version History & Optimization Timeline

| Version | Date | Focus | Key Changes |
|---------|------|-------|-------------|
| v1.5.74 | 2026-03-21 | JS Optimization | Olark lazy-loaded (Priority 1) |
| v1.5.93 | 2026-03-24 | Recovery | Post-Epic 8 baseline |
| **v1.5.75** | **Planned** | **Modularize JS** | Split store.js (Priority 2) |
| **v1.5.76** | **Planned** | **Consolidate Cart** | Merge cart modules (Priority 3) |
| **v1.5.77** | **Planned** | **Audit Swiper** | Review slider usage (Priority 4) |
| **v2.0.0** | **Q2 2026** | **Major Release** | Post-Epic 8 (all priorities complete) |

---

## ⚠️ Known Issues & Alerts

### 🔴 **Critical: CSS Oversized**
- **File:** `style-critical.tpl`
- **Size:** 163KB (limit: 50KB)
- **Impact:** Delays page rendering
- **Action:** Story 8.2 goal — reduce to 50KB
- **Plan:** Consolidate, extract unused, split critical/async

### 🟡 **JavaScript Optimization Ongoing**
- Priority 1 ✅ Olark lazy-loaded
- Priority 2 ⏳ Modularize store.js (25%+ potential savings)
- Priority 3 ⏳ Consolidate cart modules
- Priority 4 ⏳ Audit Swiper usage

### 🟠 **Performance Budget Constraints**
- Critical CSS: EXCEEDED (163KB vs 50KB limit)
- Async CSS: OK (164KB vs 200KB limit)
- JS Total: OK (~266KB vs 400KB limit)

---

## 🔐 Nuvemshop Constraints (Overview)

| # | Constraint | Severity | Pages | Action |
|---|-----------|----------|-------|--------|
| 1 | Checkout form structure protected | CRITICAL | checkout, cart | DO NOT MODIFY structure |
| 2 | Footer attribution required | CRITICAL | all | MUST be visible |
| 3 | Contact form structure protected | HIGH | contact, page | DO NOT MODIFY structure |
| 4 | CSS performance budget | HIGH | all | Keep < 50KB critical |
| 5 | Registration form protected | HIGH | account/register | DO NOT MODIFY structure |
| 6 | Newsletter form protected | HIGH | home, page | DO NOT MODIFY structure |
| 7 | JavaScript safety | MEDIUM | all | NO Nuvemshop override |
| 8 | Auto-generated files | MEDIUM | root | DO NOT MODIFY (regenerated) |

**[See full constraint details in 07-NUVEMSHOP-CONSTRAINTS.md](07-NUVEMSHOP-CONSTRAINTS.md)**

---

## 📚 Related Documentation

- **[02. Page Structure](02-PAGE-STRUCTURE.md)** — All 12 pages in detail
- **[03. Component Inventory](03-COMPONENT-INVENTORY.md)** — 41 snipplets catalog
- **[04. CSS Architecture](04-CSS-ARCHITECTURE.md)** — Style organization & performance
- **[05. JavaScript Modules](05-JAVASCRIPT-MODULES.md)** — JS dependencies & optimization
- **Machine Registries:** `.aiox-core/data/patagang-store-catalog.yaml`

---

**Document Version:** 1.0.0 | **AIOX L4 Documentation** | **Last Updated:** 2026-03-24
