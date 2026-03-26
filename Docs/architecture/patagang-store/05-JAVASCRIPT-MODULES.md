# 5. JavaScript Modules — Dependencies & Optimization

**Purpose:** Understand JS architecture, module dependencies, and optimization priorities

---

## 📦 JavaScript File Inventory

### **Core Store Module**

| File | Size | Priority | Status | Purpose |
|------|------|----------|--------|---------|
| `store.js.tpl` | **125KB** | **P2** | ⏳ Modularize | Core store functions (cart, product, forms) |

### **External Integrations**

| File | Size | Priority | Status | Purpose |
|------|------|----------|--------|---------|
| `external.js.tpl` | **106KB** | **P1** | ✅ Complete | Olark (lazy), GA, Facebook, Swiper |
| `external-no-dependencies.js.tpl` | ~94KB | — | — | Standalone external libs |
| `google-survey.js.tpl` | ~1KB | — | — | Google Survey integration |

### **Cart Operations**

| File | Size | Priority | Status | Purpose |
|------|------|----------|--------|---------|
| `cart-drawer.js.tpl` | **25KB** | **P3** | ⏳ Consolidate | Cart sidebar interactions |
| `cart-utils.js.tpl` | **15KB** | **P3** | ⏳ Consolidate | Cart helper functions |

### **Specialized**

| File | Size | Purpose |
|------|------|---------|
| `product-page-custom.js` | ~8KB | Product page-specific |
| `smooth-scroll.js` | ~3KB | Anchor link scrolling |
| `payment-discount-text-override.js` | ~2KB | Payment text customization |
| `instatheme.js` | ~12KB | Instagram feed widget |
| `version-info.js` | ~1KB | Version tracking |

---

## 🎯 Optimization Priorities

### **Priority 1: Lazy-load Olark** — ✅ COMPLETE (v1.5.74)

**Goal:** Defer Olark chat widget until on-demand

**Implemented in external.js:**
```javascript
// Olark loaded lazily (not blocking page load)
// Loads when:
// - User clicks chat button
// - 10 seconds of idle time
// - Mobile: after user interaction
```

**Result:**
- Removed 5KB from critical path
- No impact on LCP
- Chat available after 1-2s

---

### **Priority 2: Modularize store.js** — ⏳ PLANNED (v1.5.75)

**Goal:** Split 125KB monolithic file into modules

**Current Table of Contents (in store.js.tpl):**
```javascript
/* Sections in store.js */

#Lazy load
#Notifications
#Modals
#Tabs
#Header and nav
  // Search suggestions
#Sliders
  // Home slider
  // Banner services slider
#Social
  // YouTube/Vimeo video
  // Facebook login
#Product grid
  // Filters
  // Product item slider
  // Infinite scroll
#Product detail
  // Installments
  // Change variant
  // Product labels
  // Color/size variants
  // Mobile variants
  // Contact submit
  // Product slider
  // Pinterest sharing
  // Quantity selector
#Cart
  // Toggle cart
  // Add to cart
  // Cart quantity changes
  // Empty alert
  // Go to checkout
#Shipping calculator
  // Free shipping bar
  // Select shipping
  // Calculate shipping
  // Shipping by submit
  // Branch click
  // More options
  // On page load
  // Provinces
  // Country change
#Forms
#Footer
#Empty placeholders
```

**Proposed Modularization:**
```
store-core.js (30KB)      # Must-load: cart, product basics
  ├─ Cart operations
  ├─ Notifications
  ├─ Modals
  └─ Form validation

store-product.js (25KB)   # Product page specific
  ├─ Variant selection
  ├─ Installments
  ├─ Custom fields
  └─ Related products

store-cart.js (20KB)      # Cart page specific
  ├─ Cart item updates
  ├─ Quantity changes
  └─ Shipping calculator

store-nav.js (15KB)       # Navigation & search
  ├─ Search suggestions
  ├─ Mega menu
  └─ Mobile menu

store-social.js (8KB)     # Social features (lazy)
  ├─ YouTube videos
  ├─ Pinterest sharing
  └─ Facebook login

store-ui.js (12KB)        # UI interactions (lazy)
  ├─ Tabs
  ├─ Sliders
  ├─ Animations
  └─ Hover effects

store-utils.js (15KB)     # Shared utilities
  ├─ Helpers
  ├─ Validation
  └─ Common functions
```

**Estimated Savings:** 20-25KB via tree-shaking unused code per page

### **Priority 3: Consolidate Cart JS** — ⏳ PLANNED (v1.5.76)

**Goal:** Merge cart-drawer.js (25KB) + cart-utils.js (15KB)

**Current:** Two separate files

**Proposed:** Single `store-cart.js` (30KB)
- Eliminates duplicate requires
- Shared cart context
- Single error handler

**Estimated Savings:** 3-5KB (deduplication)

### **Priority 4: Review Swiper Usage** — ⏳ PLANNED (v1.5.77)

**Goal:** Audit Swiper.js usage and optimize

**Current Usage:**
- Product image gallery (essential)
- Home hero slider (nice-to-have)
- Banner sliders (could use CSS alternative)

**Options:**
- Keep Swiper (already loaded)
- Replace banner sliders with CSS-only
- Lazy-load Swiper for non-essential sliders

**Estimated Savings:** 5-10KB (if replaced with CSS)

---

## 🔍 store.js.tpl — Detailed Analysis

### **Module Dependencies**

```
store.js.tpl
├─ Depends on:
│  ├─ jQuery (Nuvemshop core) — DOM manipulation
│  ├─ Nuvemshop Cart API — Add/remove/update items
│  ├─ Nuvemshop Shipping API — Calculate shipping
│  ├─ DOMContentLoaded polyfill — Browser compatibility
│  └─ Nuvemshop settings — Store config
│
└─ Used by (directly):
   ├─ page: home
   ├─ page: product
   ├─ page: cart
   ├─ page: category
   ├─ page: search
   ├─ snipplet: product/product-form.tpl
   ├─ snipplet: product/product-related.tpl
   ├─ snipplet: product/item-quantity.tpl
   ├─ snipplet: cart-item-new.tpl
   ├─ snipplet: cart-totals.tpl
   ├─ snipplet: notification.tpl
   ├─ snipplet: modal.tpl
   ├─ snipplet: newsletter.tpl
   └─ [15 more dependencies]
```

### **Code Organization**

```javascript
/* SECTION: Lazy Load (native HTML5) */
// - Native loading="lazy" attribute
// - Browser handles lazy loading
// - No custom library needed

/* SECTION: Notifications */
// Function: showNotification(message, type)
// Types: 'success', 'error', 'warning', 'info'

/* SECTION: Modals */
// Functions: openModal(), closeModal(), toggleModal()
// Handles: Add-to-cart confirmation, newsletter signup

/* SECTION: Tabs */
// Function: setupTabs()
// Used in: Product detail (reviews, details, shipping)

/* SECTION: Header and Nav */
// setupSearchSuggestions() — autocomplete
// nav event handlers

/* SECTION: Sliders */
// Home slider (Swiper.js) — hero banner
// Banner sliders (Swiper.js) — service banners

/* SECTION: Social */
// embedYouTubeVideo() — iframe
// embedVimeoVideo() — iframe
// handleFacebookLogin() — OAuth

/* SECTION: Product Grid */
// setupFilters() — category filters
// setupInfiniteScroll() — auto-load more products
// handleProductItemSlider() — Swiper on product cards

/* SECTION: Product Detail */
// handleVariantSelection() — SKU change
// displayInstallments() — payment options
// showLabelsOnVariantChange() — sale/new badges
// handleProductSlider() — image gallery (Swiper.js)
// handleSharePinterest() — social share

/* SECTION: Cart */
// toggleCart() — open/close drawer
// addToCart(productId) — API call
// updateCartQuantity(lineItemId, qty) — AJAX
// goToCheckout() — navigate to checkout

/* SECTION: Shipping */
// calculateShipping(zipCode) — real-time quote
// selectShippingOption() — choose delivery method
// toggleBranches() — show pickup locations

/* SECTION: Forms */
// validateContactForm() — required fields
// validateNewsletterEmail() — email format
// submitForm(formElement) — handle submission

/* SECTION: Footer */
// Footer-specific interactions (minimal)

/* SECTION: Empty Placeholders */
// Reserved for future functionality
```

---

## 🔗 external.js.tpl — Integrations

### **What It Includes**

```javascript
/* Olark Chat (lazy-loaded v1.5.74+) */
// - Loads only when needed
// - Controlled by user interaction
// - Previously: always loaded (5KB overhead)
// - Now: deferred until first use

/* Google Analytics */
// - Page tracking
// - Event tracking (add to cart, purchase, etc)
// - User engagement metrics

/* Facebook SDK */
// - Facebook login
// - Product sharing
// - Comments widget
// - Pixel tracking (retargeting)

/* Swiper.js */
// - Image sliders on product pages
// - Homepage hero slider
// - Banner carousels
// - Touch-friendly mobile sliders

/* Twitter Widgets */
// - Tweet embeds
// - Tweet buttons

/* Instagram Embeds */
// - Instagram post embeds
// - Timeline feeds

/* Third-Party Widgets */
// - Reviews widget
// - Chat widget
// - Support tools
```

### **Loading Strategy**

```javascript
// Most 3rd-party scripts loaded:
// - After DOMContentLoaded
// - Async (non-blocking)
// - With error handling (fails gracefully)

// Some (like GA, FB Pixel) can use async attribute
<script async src="ga.js"></script>

// Others need setup before
<script>
  // Setup code here
  fbq('init', 'PIXEL_ID');
</script>
<script async src="facebook-pixel.js"></script>
```

---

## 📈 JavaScript Performance Metrics

### **Page Load Impact**

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| JS Total | ~266KB | < 400KB | ✅ OK |
| Core JS | ~140KB | < 150KB | ✅ OK |
| External Libs | ~126KB | < 200KB | ✅ OK |
| Load Time (4G) | ~800ms | < 1500ms | ✅ Good |
| Parse Time | ~300ms | < 500ms | ✅ Good |

### **Execution Timeline**

```
HTML loads (0ms)
  │
  ├─ Parse HTML + CSS (100ms)
  ├─ Render layout (150ms)
  ├─ Paint (200ms) ← Page visible
  │
  ├─ store.js loads (125KB, 400ms)
  │  └─ Parse & execute (300ms)
  │
  ├─ external.js loads (106KB, 350ms)
  │  └─ GA ready (100ms)
  │  └─ Swiper ready (200ms)
  │
  ├─ Page interactive (1200ms total)
  │
  └─ Olark loads (lazy, 2000ms+)
     └─ Only on demand
```

---

## 🚀 Loading Strategy: Critical vs Non-Critical

### **Blocking JS (Must Load Before Interaction)**

```html
<body>
  ...
  <!-- Footer JS (loads late, blocking is OK) -->
  <script src="store.js.tpl" defer></script>
</body>
```

- **File:** `store.js.tpl` (125KB)
- **Why:** Needed for add-to-cart, form validation, cart drawer
- **Strategy:** `defer` attribute (loads in background, executes after parsing)

### **Async JS (Can Load Independently)**

```html
<body>
  ...
  <!-- Loads independently, doesn't block parsing -->
  <script async src="external.js.tpl"></script>
  <script async src="google-analytics.js"></script>
</body>
```

- **Files:** `external.js`, `instatheme.js`, etc.
- **Why:** Not needed for core functionality
- **Strategy:** `async` attribute (loads in parallel, executes immediately when ready)

### **Lazy JS (Load on Demand)**

```javascript
// In external.js

// Olark chat loads when:
if (userClicksChatButton || idleTime > 10000) {
  loadOlarkChat(); // Load asynchronously
}

// Instagram feed loads when:
if (windowInView('#instafeed')) {
  loadInstatheme(); // Load when needed
}
```

---

## ⚠️ Critical Constraints

### **CONSTRAINT #7: JavaScript Safety**

**Rule:** Custom JS must NOT override Nuvemshop functions

**Forbidden:**
```javascript
// ❌ DON'T DO THIS
window.Nuvemshop.checkout.submit = myCustomFunction;
window.$ = null;  // Breaks jQuery
Object.keys = myFunction;  // Override native
```

**Allowed:**
```javascript
// ✅ DO THIS INSTEAD
(function() {
  // Scope in IIFE
  function myCustomFunction() { ... }

  // Use event listeners
  document.addEventListener('cart:updated', myFunction);
})();

// Namespace under store
window.MyStore = {
  helpers: { ... },
  product: { ... }
};
```

---

## 📋 Testing JavaScript Changes

### **Before Modifying store.js:**

1. **Test on all pages that use it:**
   - Homepage (hero, products, newsletter)
   - Product detail (variants, add-to-cart)
   - Cart page (item updates, checkout)
   - Category (filters, infinite scroll)
   - Search (filters, grid)

2. **Test all interactions:**
   - Add to cart → notification → cart drawer
   - Change quantity → cart updates
   - Select variant → price updates
   - Apply filter → grid reloads
   - Submit form → validation works

3. **Check console for errors:**
   - No JS errors
   - No warnings
   - No 404s for resources

4. **Performance test:**
   - Measure FCP, LCP
   - Check Core Web Vitals
   - Monitor JS execution time

---

## 🔗 Related Documentation

- **[01. Store Overview](01-STORE-OVERVIEW.md)** — JS in architecture
- **[02. Page Structure](02-PAGE-STRUCTURE.md)** — JS per page
- **[06. File Dependency Tree](06-FILE-DEPENDENCY-TREE.md)** — Dependencies
- **Registry:** `.aiox-core/data/patagang-component-dependency-map.yaml` (JS section)

---

**Document Version:** 1.0.0 | **AIOX L4 Documentation** | **Last Updated:** 2026-03-24
