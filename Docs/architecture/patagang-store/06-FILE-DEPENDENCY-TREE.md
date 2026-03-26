# 6. File Dependency Tree — Visual Maps & Relationships

**Purpose:** Visual representation of how files depend on each other and what breaks when changes are made

---

## 📊 Master Dependency Graph

```
┌─────────────────────────────────────────────────────────────────────────┐
│                       LAYOUT.TPL (Master Template)                       │
│  ├─ <head> (inline critical CSS, meta, fonts)                           │
│  │  ├─ style-critical.tpl (163KB) ⚠️ OVERSIZED                         │
│  │  │  ├─ style-tokens.tpl                                             │
│  │  │  ├─ style-colors.scss.tpl                                        │
│  │  │  ├─ style-menu-patagang.css.tpl                                  │
│  │  │  ├─ style-filters-patagang.css.tpl                               │
│  │  │  ├─ style-help-sidebar.css.tpl                                   │
│  │  │  └─ style-whatsapp-button.css.tpl                                │
│  │  └─ style-fonts.tpl (async preload)                                 │
│  │                                                                      │
│  ├─ <body>                                                              │
│  │  ├─ navigation.tpl (ALL PAGES)                                      │
│  │  │  ├─ navigation/navigation-mega-menu.tpl                          │
│  │  │  │  └─ navigation/navigation-category.tpl                        │
│  │  │  ├─ navigation/navigation-top.tpl                                │
│  │  │  │  ├─ icon-cart.tpl → cart-drawer.js ┐                        │
│  │  │  │  └─ Search input → external.js      │                        │
│  │  │  └─ navigation/navigation-panel.tpl (mobile)                     │
│  │  │                                        │                         │
│  │  ├─ [PAGE-SPECIFIC CONTENT]               │                         │
│  │  │  ├─ home.tpl                           │                         │
│  │  │  │  ├─ product_grid.tpl                │                         │
│  │  │  │  │  ├─ card.tpl                     │                         │
│  │  │  │  │  │  └─ labels.tpl                │                         │
│  │  │  │  │  └─ store.js.tpl ◄─────────────┐ │                         │
│  │  │  │  └─ modal-newsletter.tpl           │ │                         │
│  │  │  │     └─ newsletter.tpl              │ │                         │
│  │  │  │                                    │ │                         │
│  │  │  ├─ product.tpl                       │ │                         │
│  │  │  │  ├─ product/product-image.tpl      │ │                         │
│  │  │  │  │  └─ external.js (Swiper)       │ │                         │
│  │  │  │  ├─ product/product-form.tpl       │ │                         │
│  │  │  │  │  ├─ item-quantity.tpl          │ │                         │
│  │  │  │  │  └─ store.js.tpl ◄────────────┤ │                         │
│  │  │  │  └─ product/product-related.tpl    │ │                         │
│  │  │  │     └─ product_grid.tpl            │ │                         │
│  │  │  │                                    │ │                         │
│  │  │  ├─ cart.tpl                          │ │                         │
│  │  │  │  ├─ cart-item-new.tpl             │ │                         │
│  │  │  │  │  ├─ item-quantity.tpl          │ │                         │
│  │  │  │  │  └─ store.js.tpl ◄────────────┤ │                         │
│  │  │  │  ├─ cart-totals.tpl               │ │                         │
│  │  │  │  └─ cart-related-products.tpl     │ │                         │
│  │  │  │                                    │ │                         │
│  │  │  └─ [other pages similarly]           │ │                         │
│  │  │                                        │ │                         │
│  │  └─ footer.tpl (ALL PAGES)               │ │                         │
│  │     ├─ navigation-foot.tpl               │ │                         │
│  │     ├─ newsletter.tpl                    │ │                         │
│  │     └─ social-share.tpl ────────────────┴┴─ external.js            │
│  │                                                                      │
│  └─ <script>                                                            │
│     ├─ store.js.tpl (125KB) ◄──── CORE MODULE                         │
│     ├─ external.js.tpl (106KB) ─── INTEGRATIONS                       │
│     ├─ cart-drawer.js.tpl (25KB) ─ CART DRAWER                        │
│     └─ cart-utils.js.tpl (15KB) ── CART UTILITIES                     │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 🔗 Critical Dependencies

### **store.js.tpl (125KB) — Who Depends?**

```
store.js.tpl
├─ USED BY SNIPPLETS:
│  ├─ product/product-form.tpl (add-to-cart)
│  ├─ product/item-quantity.tpl (quantity)
│  ├─ product/product-related.tpl (grid)
│  ├─ cart-item-new.tpl (quantity updates)
│  ├─ cart-totals.tpl (total calc)
│  ├─ cart-related-products.tpl
│  ├─ notification.tpl (messages)
│  ├─ notification-cart.tpl
│  ├─ modal.tpl (open/close)
│  ├─ breadcrumbs.tpl
│  ├─ product_grid.tpl (filters, infinite scroll)
│  ├─ newsletter.tpl (submission)
│  ├─ help-sidebar.tpl (toggle)
│  ├─ icon-cart.tpl (toggle drawer)
│  └─ [5+ more]
│
├─ USED BY PAGES:
│  ├─ home.tpl (all features)
│  ├─ product.tpl (variants, cart)
│  ├─ cart.tpl (all operations)
│  ├─ category.tpl (filters, grid)
│  ├─ search.tpl (filters, grid)
│  ├─ blog.tpl (social)
│  ├─ contact.tpl (form)
│  └─ account/*.tpl (forms)
│
└─ WHAT BREAKS IF REMOVED:
   ├─ ❌ Product variants don't work
   ├─ ❌ Add-to-cart fails
   ├─ ❌ Cart operations fail
   ├─ ❌ Forms don't validate
   ├─ ❌ Modals don't work
   ├─ ❌ Notifications don't show
   └─ ❌ Page broken (15+ components affected)

Impact Level: 🔴 CRITICAL (DO NOT REMOVE)
```

### **style-critical.tpl (163KB) — Who Depends?**

```
style-critical.tpl (inlined in <head>)
├─ USED BY ALL:
│  ├─ ALL 12 PAGES (layout rendering)
│  ├─ ALL 41 SNIPPLETS (component styling)
│  └─ EVERY PAGE ELEMENT
│
└─ WHAT BREAKS IF REMOVED:
   ├─ ❌ Page renders unstyled (white screen)
   ├─ ❌ Layout broken (no grid)
   ├─ ❌ Header/footer missing styles
   ├─ ❌ Forms unstyled
   ├─ ❌ Modals broken
   ├─ ❌ 150ms+ delay to first paint
   └─ ❌ Core Web Vitals fail

Impact Level: 🔴 CRITICAL (MUST KEEP, BUT REDUCE SIZE)
Problem: 163KB exceeds 50KB limit (Story 8.2 goal)
```

### **external.js.tpl (106KB) — Who Depends?**

```
external.js.tpl
├─ USED BY:
│  ├─ product/product-image.tpl (Swiper.js gallery)
│  ├─ social-share.tpl (Facebook SDK)
│  ├─ whatsapp-chat.tpl (WhatsApp API)
│  ├─ Olark integration (lazy-loaded as of v1.5.74)
│  ├─ Google Analytics (tracking)
│  └─ Home/blog sliders
│
└─ WHAT BREAKS:
   ├─ ❌ Product image gallery doesn't work
   ├─ ❌ Social sharing buttons non-functional
   ├─ ❌ Chat widget unavailable
   ├─ ❌ Analytics tracking lost
   ├─ ❌ Image sliders broken
   └─ ⚠️ Graceful degradation (not critical to purchase)

Impact Level: 🟡 HIGH (important for UX, not critical to core functionality)
Status: ✅ Optimized (Olark lazy-loaded in v1.5.74)
```

---

## 🎯 Component Dependency Graph

### **product-form.tpl — Impact of Changes**

```
product-form.tpl
│
├─ DEPENDS ON:
│  ├─ item-quantity.tpl
│  ├─ product-payment-details.tpl
│  ├─ product-custom-fields.tpl
│  ├─ store.js.tpl (variant selection, cart)
│  ├─ external.js.tpl (payment processing)
│  └─ style-critical.tpl (form styling)
│
├─ USED BY:
│  ├─ product.tpl (main form)
│  └─ product-related.tpl (quick add)
│
└─ IMPACT IF CHANGED:
   ├─ Remove variant selector: ❌ Can't change product options
   ├─ Remove quantity input: ❌ Can't add multiple items
   ├─ Remove add-to-cart button: ❌ Can't purchase
   ├─ Change form method: ❌ Checkout breaks (CONSTRAINT #1)
   └─ Modify form fields: ❌ Order data lost

Risk Level: 🔴 CRITICAL (Payment processing)
Constraint: CONSTRAINT #1 (structure protected)
```

### **product_grid.tpl — Reusability**

```
product_grid.tpl (REUSABLE COMPONENT)
│
├─ USED BY:
│  ├─ home.tpl (Vista section)
│  ├─ home.tpl (Development section)
│  ├─ category.tpl (product listing)
│  ├─ search.tpl (search results)
│  ├─ product-related.tpl (related products)
│  ├─ cart-related-products.tpl (cross-sell)
│  └─ blog.tpl (featured)
│
├─ DEPENDS ON:
│  ├─ card.tpl (product card)
│  ├─ labels.tpl (badges)
│  ├─ store.js.tpl (filters, infinite scroll)
│  ├─ external.js.tpl (lazy loading)
│  └─ style-async.scss.tpl (grid styling)
│
└─ IMPACT IF CHANGED:
   ├─ Change card layout: Affects 7 pages
   ├─ Remove filters: Category page broken
   ├─ Remove infinite scroll: Search/category broken
   └─ Single change = Multiple pages updated

Risk Level: 🟡 HIGH (Used in 7+ locations)
Test Coverage: MUST test on ALL pages using this
```

---

## 📊 Dependency Matrix (What Breaks When)

| If You Change... | Home | Product | Category | Cart | Blog | Impact |
|------------------|------|---------|----------|------|------|--------|
| store.js.tpl | ❌ | ❌ | ❌ | ❌ | ❌ | 🔴 CRITICAL |
| style-critical.tpl | ❌ | ❌ | ❌ | ❌ | ❌ | 🔴 CRITICAL |
| external.js.tpl | ⚠️ | ❌ | ✅ | ✅ | ⚠️ | 🟡 HIGH |
| product_grid.tpl | ❌ | ⚠️ | ❌ | ⚠️ | ✅ | 🟡 HIGH |
| product-form.tpl | ✅ | ❌ | ✅ | ✅ | ✅ | 🟡 HIGH |
| navigation.tpl | ❌ | ❌ | ❌ | ❌ | ❌ | 🔴 CRITICAL |
| footer.tpl | ❌ | ❌ | ❌ | ❌ | ❌ | 🔴 CRITICAL |
| card.tpl | ❌ | ✅ | ❌ | ✅ | ✅ | 🟡 HIGH |

---

## 🔐 Constraint Dependencies

### **CONSTRAINT #1: Checkout Form Structure**

```
product-form.tpl → cart-totals.tpl → CHECKOUT (Nuvemshop)
                                          │
                              Payment Processing
                                    ↓
                         Order Data Validation
                                    ↓
                           Payment Gateway
                                    ↓
                            Customer Order

If form structure changes: ❌ Payment fails at Nuvemshop side
```

### **CONSTRAINT #2: Footer Attribution**

```
footer.tpl (MUST contain visible "Powered by Nuvemshop")
   │
   └─ Used by: ALL 12 PAGES (via layout.tpl)
      │
      └─ If removed: Legal violation (ToS breach)
```

### **CONSTRAINT #4: CSS Performance Budget**

```
style-critical.tpl (163KB) → INLINE IN <HEAD>
                                    │
                           Blocks rendering
                                    │
                        LCP: +550ms on mobile
                                    │
         Goal (Story 8.2): Reduce to 50KB → -330ms gain
```

---

## 🚀 Refactoring Impact Analysis

### **Example: Modularize store.js (Priority 2)**

**Current:**
```
store.js.tpl (125KB)
  ├─ Product logic (30KB)
  ├─ Cart logic (20KB)
  ├─ Navigation logic (15KB)
  ├─ Social logic (10KB)
  ├─ Form logic (20KB)
  ├─ Utilities (15KB)
  └─ Other (15KB)
```

**Proposed:**
```
store-core.js (30KB) ← ALWAYS LOAD (critical path)
store-product.js (25KB) ← Load on product page
store-cart.js (20KB) ← Load on cart page
store-nav.js (15KB) ← Load on all pages
store-social.js (8KB) ← Lazy load on demand
store-ui.js (12KB) ← Lazy load on demand
store-utils.js (15KB) ← Load with core
```

**Impact Analysis:**
- **Home page savings:** -95KB (load only store-core.js)
- **Product page savings:** -80KB (don't load cart/nav full)
- **Cart page savings:** -85KB (don't load product/nav full)
- **Risk:** Must ensure dependencies work correctly

---

## 🎓 Reading This Document

### **To understand impact of a change:**
1. Find component in this tree
2. Look at "USED BY" section
3. Count affected pages
4. Check "WHAT BREAKS" section
5. Assess Impact Level (🔴/🟡/🟠)

### **To trace a dependency:**
1. Start with component
2. Follow "DEPENDS ON" arrow
3. Check each dependency's status
4. Determine if safe to change

### **To plan refactoring:**
1. Look at Dependency Matrix
2. Identify which pages affected
3. List all breaking changes
4. Plan test coverage
5. Estimate risk level

---

## 🔗 Related Documentation

- **[03. Component Inventory](03-COMPONENT-INVENTORY.md)** — Detailed component descriptions
- **[05. JavaScript Modules](05-JAVASCRIPT-MODULES.md)** — JS dependency details
- **[04. CSS Architecture](04-CSS-ARCHITECTURE.md)** — CSS dependency details
- **Registry:** `.aiox-core/data/patagang-component-dependency-map.yaml` (machine-readable)

---

**Document Version:** 1.0.0 | **AIOX L4 Documentation** | **Last Updated:** 2026-03-24
