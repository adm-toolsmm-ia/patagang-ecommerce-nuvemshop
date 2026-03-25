# 4. CSS Architecture — Style Organization & Performance

**Purpose:** Understand CSS file organization, critical/async split, and performance optimization strategy

---

## 📊 CSS File Inventory

### **Critical Path CSS** (Inlined in `<head>`)

| File | Size | Status | Purpose |
|------|------|--------|---------|
| `style-critical.tpl` | **163KB** | 🔴 **OVERSIZED** | Core layout, typography, components |
| Includes: | | | |
| └─ `style-tokens.tpl` | 2KB | ✅ | Design tokens (colors, spacing) |
| └─ `style-colors.scss.tpl` | 45KB | ✅ | Nuvemshop settings colors |
| └─ `style-menu-patagang.css.tpl` | ? | ✅ | Navigation styles (inlined) |
| └─ `style-filters-patagang.css.tpl` | ? | ✅ | Category filter UI (inlined) |
| └─ `style-help-sidebar.css.tpl` | ? | ✅ | Help sidebar (inlined) |
| └─ `style-whatsapp-button.css.tpl` | ? | ✅ | WhatsApp button (inlined) |
| | | | |
| **Total Critical CSS** | **163KB** | **🔴 3.26x over limit** | **Limit: 50KB** |

### **Async CSS** (Non-blocking, loaded after)

| File | Size | Status | Purpose |
|------|------|--------|---------|
| `style-async.scss.tpl` | **164KB** | ✅ **OK** | Non-critical styles |
| | | | |
| **Total Async CSS** | **164KB** | **✅ Within limit** | **Limit: 200KB** |

### **Specialized CSS**

| File | Size | Purpose | Loading |
|------|------|---------|---------|
| `style-fonts.tpl` | ~5KB | Font loading & fallbacks | Preload |
| `style-blog.scss.tpl` | ~8KB | Blog-specific styles | Async |
| `style-home-v2.css` | ~12KB | Home page hero (v2) | Critical |
| `checkout.scss.tpl` | ~3KB | Checkout styling (Nuvemshop) | Critical |
| `product-card-v3.css` | ~4KB | Legacy product cards | **REVIEW IF USED** |
| `style-colors.scss.tpl` | 45KB | Nuvemshop color settings | Critical |

---

## 🎯 Performance Problem: CSS Oversized

### **Current Status**

```
Critical CSS Budget: 50KB
Current Size:       163KB
Ratio:              3.26x OVER

Impact:
  ├─ Page render blocked until 163KB CSS loads
  ├─ Mobile users: 2-3 seconds of white screen
  ├─ CLS impact: Layout shifts as CSS loads
  └─ LCP delay: Largest contentful paint delayed
```

### **Why So Large?**

The 163KB includes many components that could be deferred to async:
- Product card styles
- Advanced layouts
- Animations
- Hover states
- Page-specific styles
- Mobile-specific styles

### **Story 8.2 Goal: Reduce to 50KB**

**Target:** Extract ~113KB to async CSS (or delete unused)

**Strategy:**
1. Consolidate duplicate styles
2. Remove unused CSS (Chrome DevTools Coverage)
3. Move non-critical to async
4. Split by page/component if needed

---

## 🔄 Loading Strategy

### **How CSS is Loaded**

```
<head>
  <!-- Preload async CSS to start loading early -->
  <link rel="preload" as="style" href="style-async.scss.tpl">

  <!-- Inline critical CSS (BLOCKING) -->
  <style>
    {# Content of style-critical.tpl, style-colors, etc #}
  </style>

  <!-- Load async CSS (NON-BLOCKING) -->
  <link rel="stylesheet"
        href="style-async.scss.tpl"
        media="print"
        onload="this.media='all'">
</head>
```

### **What's in Critical CSS**

**Must include (blocks rendering):**
- Grid layout (`col-12`, `col-md-6`, `col-lg-4`)
- Header styles (navigation background, logo)
- Footer styles (attribution, required for Nuvemshop)
- Product card base (image, title, price)
- Form base (inputs, buttons)
- Modal base (overlay, close button)
- Typography (body font, headings)

**Can defer to async (won't block rendering):**
- Animations (keyframes)
- Hover states
- Advanced layouts (flexbox, grid for secondary layouts)
- Page-specific styles (blog, category filters)
- Responsive utilities (mostly mobile-specific)

---

## 📑 CSS File Organization

### **style-critical.tpl (163KB) — Includes Multiple Files**

```tpl
{% include "static/css/style-tokens.tpl" %}
{% include "static/css/style-colors.scss.tpl" %}
{% include "static/css/style-menu-patagang.css.tpl" %}
{% include "static/css/style-filters-patagang.css.tpl" %}
{% include "static/css/style-help-sidebar.css.tpl" %}
{% include "static/css/style-whatsapp-button.css.tpl" %}

{# Other critical styles inlined here #}
```

**Content areas:**
- Layout grid system
- Header & navigation base
- Footer
- Product grids
- Cart UI
- Forms
- Modals & notifications
- Typography

### **style-async.scss.tpl (164KB) — Loaded Asynchronously**

**Content areas:**
- Advanced layouts & flexbox
- Animations & transitions
- Hover states
- Page-specific styles (blog, home v2)
- Responsive breakpoints
- Utility classes

---

## 🎨 Design System Integration

### **Colors (from style-colors.scss.tpl)**

Colors are pulled from Nuvemshop admin settings and defined in CSS variables:

```scss
// Primary brand color (Patagang yellow)
$primary-color: #EAFE67;
$primary-dark: #D4D41F;

// Neutral palette
$color-gray-1: #F0F0F0;
$color-gray-2: #D0D0D0;
$color-gray-3: #808080;

// State colors
$color-success: #00CC66;
$color-warning: #FF9900;
$color-error: #CC0000;
$color-info: #0066FF;
```

### **Typography (in style-critical.tpl)**

```scss
// Font families from settings
$font-headings: 'Inter';
$font-body: 'Open Sans';

// Font sizes
$font-h1: 2.5rem;
$font-h2: 2rem;
$font-h3: 1.5rem;
$font-body: 1rem;
$font-small: 0.875rem;

// Font weights
$fw-light: 300;
$fw-normal: 400;
$fw-bold: 700;
```

### **Spacing (CSS Variables)**

```scss
$spacing-xs: 4px;
$spacing-sm: 8px;
$spacing-md: 16px;
$spacing-lg: 24px;
$spacing-xl: 32px;
$spacing-xxl: 48px;
```

---

## 📱 Responsive Breakpoints

### **Bootstrap Grid Breakpoints**

```
xs (< 576px):   Full width
sm (576px):     Single column
md (768px):     Two columns
lg (992px):     Three columns
xl (1200px):    Four columns
xxl (1400px):   Full width
```

### **Usage in Templates**

```html
<div class="row">
  <div class="col-12 col-md-6 col-lg-4">
    {# Mobile: 100% width (col-12) #}
    {# Tablet: 50% width (col-md-6) #}
    {# Desktop: 33% width (col-lg-4) #}
  </div>
</div>
```

---

## 🎬 Performance Metrics

### **CSS Impact on Core Web Vitals**

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| **FCP** (First Contentful Paint) | < 1.8s | ~1.2s | ✅ Good |
| **LCP** (Largest Contentful Paint) | < 2.5s | ~1.2s | ✅ Good |
| **CLS** (Cumulative Layout Shift) | < 0.1 | 0.08 | ✅ Excellent |

### **CSS Loading Impact**

```
163KB critical CSS
  ├─ Download time (4G): ~400ms
  ├─ Parse time: ~150ms
  ├─ Render blocking time: ~550ms
  └─ Total delay: ~0.6s (60% of LCP!)

If reduced to 50KB:
  ├─ Download time: ~120ms
  ├─ Parse time: ~45ms
  ├─ Render blocking time: ~165ms
  └─ Total delay: ~0.2s (improvement: -73%)
  └─ New LCP estimate: ~0.6s (vs 1.2s currently)
```

---

## 🔧 Optimization Opportunities

### **Priority 1: Remove Unused CSS**

Use Chrome DevTools Coverage tab to identify unused CSS:
```
1. Open DevTools → Coverage tab
2. Start recording
3. Navigate through pages
4. Identify unused selectors
5. Remove or defer to async
```

**Estimated savings:** 20-30KB

### **Priority 2: Split by Page Type**

Instead of one 163KB file:
```
critical-common.css (50KB)  # Used on all pages
  ├─ Grid, header, footer, typography

critical-product.css (20KB) # Only product pages
critical-home.css (15KB)    # Only home page
critical-blog.css (10KB)    # Only blog pages
critical-catalog.css (12KB) # Only category/search
```

**Estimated savings:** 40-50KB (lazy-load page-specific CSS)

### **Priority 3: Extract Animations**

Move all `@keyframes` to async CSS:
```scss
/* MOVE TO ASYNC */
@keyframes fadeIn { ... }
@keyframes slideIn { ... }
@keyframes pulse { ... }
```

**Estimated savings:** 5-8KB

### **Priority 4: Consolidate Reset/Normalize**

Merge Bootstrap reset with custom reset:
```scss
/* Consolidate into one reset block */
```

**Estimated savings:** 2-3KB

---

## 📋 CSS Best Practices in This Codebase

### **Do's** ✅

```scss
/* ✅ USE CSS VARIABLES */
:root {
  --primary-color: #EAFE67;
  --spacing-unit: 8px;
}

.button {
  background: var(--primary-color);
  padding: calc(var(--spacing-unit) * 2);
}

/* ✅ SCOPE STYLES WITH BEM */
.product-card {
  ...
}

.product-card__image {
  ...
}

.product-card__title {
  ...
}

/* ✅ USE UTILITY CLASSES */
<div class="mt-16 mb-8 px-12">...</div>

/* ✅ DEFER NON-CRITICAL */
.animation-fade { animation: fadeIn 0.3s; } /* async */
.hover-shadow:hover { box-shadow: ...; }     /* async */
```

### **Don'ts** ❌

```scss
/* ❌ AVOID INLINE STYLES */
<div style="margin-top: 20px">...</div>

/* ❌ AVOID !important */
.header {
  background-color: white !important; /* Anti-pattern */
}

/* ❌ AVOID DEEPLY NESTED SELECTORS */
.container .row .col .product .card .image img {...}

/* ❌ AVOID UNUSED SELECTORS */
.old-component { ... } /* Dead code */

/* ❌ AVOID LARGE BASE64 */
.icon { background: url('data:image/svg+xml;base64,VERY_LONG...'); }
```

---

## 🚀 Optimization Roadmap

### **Epic 8 (Current): CSS/JS Optimization**

- **Story 8.1:** Design tokens (✅ complete)
- **Story 8.2:** Critical CSS reduction (⏳ In Progress — Goal: 50KB)
- **Story 8.3:** Remove !important (✅ complete)
- **Story 8.4:** Template cleanup (⏳ Planned)
- **Story 8.5:** JS optimization (⏳ Planned)

### **Post-Epic 8**

- Page-specific CSS splits
- Advanced animation optimizations
- Responsive image optimization
- Font subsetting

---

## 🔗 Related Documentation

- **[01. Store Overview](01-STORE-OVERVIEW.md)** — Architecture & tech stack
- **[02. Page Structure](02-PAGE-STRUCTURE.md)** — CSS usage per page
- **[07. Nuvemshop Constraints](07-NUVEMSHOP-CONSTRAINTS.md)** — CSS constraint #4
- **Registry:** `.aiox-core/data/patagang-store-catalog.yaml` (css section)

---

**Document Version:** 1.0.0 | **AIOX L4 Documentation** | **Last Updated:** 2026-03-24
