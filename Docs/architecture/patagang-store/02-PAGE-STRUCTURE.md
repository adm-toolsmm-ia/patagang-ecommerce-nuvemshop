# 2. Page Structure — All 12 Pages & Layouts

**Purpose:** Complete inventory of all pages, their structure, components, CSS, and JavaScript

---

## 📄 Pages Overview

| # | Page | Route | Type | Status | Users | Notes |
|---|------|-------|------|--------|-------|-------|
| 1 | Homepage | `/` | Landing | ✅ | Public | Hero + product grids |
| 2 | Product Detail | `/products/:slug` | Product | ✅ | Public | Images, variants, reviews |
| 3 | Category | `/category/:slug` | Listing | ✅ | Public | Filters, infinite scroll |
| 4 | Search | `/search?q=` | Listing | ✅ | Public | Query results |
| 5 | Cart | `/cart` | Transaction | ✅ | Public | Items, summary, checkout |
| 6 | Checkout | `/checkout` | Transaction | ⚠️ Nuvemshop | Public | Payment (NOT customizable) |
| 7 | Blog | `/blog` | Content | ✅ | Public | Post listing |
| 8 | Blog Post | `/blog/:slug` | Content | ✅ | Public | Post detail, comments |
| 9 | Contact | `/contact` | Form | ✅ | Public | Contact form |
| 10 | Generic Page | `/pages/:slug` | Content | ✅ | Public | CMS content |
| 11 | Account | `/account/*` | Auth | ✅ | Logged-in | Login, register, orders |
| 12 | 404/Password | Various | Error | ✅ | Public | Error pages |

---

## 1️⃣ HOMEPAGE

**File:** `templates/home.tpl` | **Route:** `/` | **Type:** Landing Page

### **Sections**

| Section | Component | File | Purpose |
|---------|-----------|------|---------|
| **Hero V2** | hero-v2 | inline | Split-screen banner (blueprint + photo) with CTAs |
| **Vista Products** | product-grid | `snipplets/product_grid.tpl` | "Vista o Propósito" product showcase (5 items) |
| **Development Products** | product-grid | `snipplets/product_grid.tpl` | "Seja o Primeiro a Conhecer" development products |
| **Newsletter** | newsletter-form | `snipplets/newsletter.tpl` | Email signup modal/footer |

### **Layout**

```html
<div id="home" class="pg-home">
  <!-- Hero V2: Full width split screen -->
  <section class="pg-hero-v2">
    <picture> <!-- Responsive images -->
    <div class="pg-hero-v2__content"> <!-- CTAs -->
  </section>

  <!-- Vista Products Grid -->
  <section class="pg-section pg-section--vista-products">
    <header class="pg-section__header">
    <div class="pg-products-grid">
      <!-- Product cards via product_grid.tpl -->
  </section>

  <!-- Development Products -->
  <section class="pg-section pg-section--dev-products">
    <!-- Similar grid structure -->
  </section>
</div>
```

### **CSS & JS**

| Type | Files | Location |
|------|-------|----------|
| **CSS Critical** | style-critical.tpl, style-home-v2.css | inlined in `<head>` |
| **CSS Async** | style-async.scss.tpl | loaded non-blocking |
| **JS** | store.js.tpl, product-page-custom.js, smooth-scroll.js | footer |

### **Performance**

| Metric | Value | Target |
|--------|-------|--------|
| **LCP** | 1.2s | < 2.5s ✅ |
| **Hero Image** | eager loading | LCP trigger |
| **Product Images** | lazy loading | `loading="lazy"` |

### **Constraints**

- ✅ No checkout form
- ✅ Footer visible
- ✅ Newsletter form untouched

---

## 2️⃣ PRODUCT DETAIL PAGE (PDP)

**File:** `templates/product.tpl` | **Route:** `/products/:slug` | **Type:** Product

### **Sections**

| Section | Component | File | Purpose |
|---------|-----------|------|---------|
| **Identity Banner** | product-identity-banner | `snipplets/product/product-identity-banner.tpl` | Brand statement (minimalist) |
| **Informative Banner** | product-informative-banner | `snipplets/product/product-informative-banner.tpl` | Discount/offers info |
| **Images Column** | product-image | `snipplets/product/product-image.tpl` | Gallery with zoom, Swiper.js |
| **Info Card** | product-form | `snipplets/product/product-form.tpl` | Variants, quantity, add-to-cart |
| **Watermark** | logo-mark | inline | Dog logo background element |
| **FB Comments** | fb-comments | Nuvemshop | Comments widget (optional) |
| **Related Products** | product-related | `snipplets/product/product-related.tpl` | Cross-sell section |

### **Layout**

```html
<div id="single-product" class="pg-pdp-container">
  <!-- Identity & Informative Banners -->
  {% include 'snipplets/product/product-identity-banner.tpl' %}
  {% include 'snipplets/product/product-informative-banner.tpl' %}

  <!-- Two-column layout: Images (7 cols) + Info (5 cols) -->
  <div class="row section-single-product">
    <div class="col-12 col-lg-7 pg-pdp-image-col">
      {% include 'snipplets/product/product-image.tpl' %}
    </div>
    <div class="col-12 col-lg-5 pg-pdp-info-col">
      <img class="pg-pdp-watermark" src="logo-mark.svg">
      <div class="pg-pdp-info-card">
        {% include 'snipplets/product/product-form.tpl' %}
      </div>
    </div>
  </div>

  <!-- FB Comments (if enabled) -->
  {% if settings.show_product_fb_comment_box %}
    <div class="fb-comments"></div>
  {% endif %}
</div>

<!-- Related Products -->
{% include 'snipplets/product/product-related.tpl' %}
```

### **CSS & JS**

| Type | Files | Purpose |
|------|-------|---------|
| **CSS Critical** | style-critical.tpl | Layout, form, card |
| **CSS Async** | style-async.scss.tpl | Advanced layouts, animations |
| **JS** | store.js.tpl, external.js.tpl | Variants, cart, Swiper gallery |

### **Interactive Features**

- **Variant Selection:** Change color/size → price updates
- **Quantity Selector:** Increment/decrement with CONSTRAINT #1
- **Add to Cart:** AJAX → notification → cart updates
- **Image Gallery:** Swiper.js with zoom (mobile touch-friendly)
- **Share Buttons:** Social sharing (Facebook, Pinterest)
- **Installments:** Payment options display

### **Constraints**

- 🔴 CONSTRAINT #1: Form structure PROTECTED (variants, add-to-cart)
- ✅ CONSTRAINT #2: Footer visible
- 🔴 CONSTRAINT #7: No JS overrides

---

## 3️⃣ CATEGORY / DEPARTMENT PAGE

**File:** `templates/category.tpl` | **Route:** `/category/:slug` | **Type:** Listing

### **Sections**

| Section | Component | File | Purpose |
|---------|-----------|------|---------|
| **Category Banner** | category-banner | `snipplets/category-banner.tpl` | Hero banner with category title |
| **Filters Panel** | filters | inline | Left sidebar (desktop) / modal (mobile) |
| **Product Grid** | product-grid | `snipplets/product_grid.tpl` | Infinite scroll grid |
| **Breadcrumbs** | breadcrumbs | `snipplets/breadcrumbs.tpl` | Navigation trail |

### **Layout**

```html
<div id="category" class="pg-category-container">
  <!-- Category Hero Banner -->
  {% include 'snipplets/category-banner.tpl' %}

  <!-- Filters + Grid (two-column on desktop) -->
  <div class="row">
    <!-- Filters Sidebar (3 cols on desktop, hidden on mobile) -->
    <div class="col-12 col-lg-3 pg-filters-panel">
      {% include 'snipplets/filters.tpl' %}
    </div>

    <!-- Product Grid (9 cols on desktop, 12 on mobile) -->
    <div class="col-12 col-lg-9 pg-products-section">
      {% include 'snipplets/breadcrumbs.tpl' %}
      {% include 'snipplets/product_grid.tpl' %}
    </div>
  </div>
</div>
```

### **Interactive Features**

- **Filters:** Price range, color, size, etc. (AJAX)
- **Sorting:** Price, newest, best-seller
- **Infinite Scroll:** Auto-load more products on scroll
- **Mobile:** Filters collapse to modal
- **Pagination:** Optional (if infinite scroll disabled)

### **CSS & JS**

| Type | Files | Purpose |
|------|-------|---------|
| **CSS Critical** | style-critical.tpl, style-filters-patagang.css.tpl | Layout, filters |
| **CSS Async** | style-async.scss.tpl | Grid animations |
| **JS** | store.js.tpl, external.js.tpl | Filters, infinite scroll |

### **Performance**

| Feature | Status |
|---------|--------|
| **Lazy Images** | ✅ loading="lazy" |
| **Filter AJAX** | ✅ No full page reload |
| **Infinite Scroll** | ✅ Smooth loading |

---

## 4️⃣ SEARCH RESULTS PAGE

**File:** `templates/search.tpl` | **Route:** `/search?q=` | **Type:** Listing

### **Sections**

| Section | Component | Purpose |
|---------|-----------|---------|
| **Search Input** | search-form | Query input with suggestions |
| **Results Grid** | product-grid | Product results for query |
| **Filters** | filters | Refine search results |
| **No Results** | empty-state | Message if no products found |

### **Layout**

Similar to Category page but with search-specific messaging.

### **SEO**

- **robots.txt:** `noindex, follow` (no duplicate indexing)
- **Canonical:** Points to category or homepage
- **Meta:** "Search results for '{query}'"

---

## 5️⃣ SHOPPING CART PAGE

**File:** `templates/cart.tpl` | **Route:** `/cart` | **Type:** Transaction

### **Sections**

| Section | Component | File | Purpose |
|---------|-----------|------|---------|
| **Cart Items** | cart-items | `snipplets/cart-item-new.tpl` | List of cart items |
| **Cart Summary** | cart-totals | `snipplets/cart-totals.tpl` | Subtotal, tax, total |
| **Related Products** | cart-related | `snipplets/cart-related-products.tpl` | Cross-sell |
| **Cart Banner** | cart-banner | `snipplets/cart-banner.tpl` | Summary info |

### **Layout**

```html
<div id="cart" class="pg-cart-container">
  <!-- Cart Items List -->
  <div class="pg-cart-items">
    {% for item in cart.items %}
      {% include 'snipplets/cart-item-new.tpl' %}
    {% endfor %}
  </div>

  <!-- Cart Summary -->
  <div class="pg-cart-summary">
    {% include 'snipplets/cart-totals.tpl' %}
  </div>

  <!-- Related Products -->
  <section class="pg-cart-related">
    {% include 'snipplets/cart-related-products.tpl' %}
  </section>
</div>
```

### **Interactive Features**

- **Update Quantity:** Change item quantity (AJAX)
- **Remove Item:** Remove from cart (AJAX)
- **Apply Coupon:** Discount code entry
- **Proceed to Checkout:** Button to Nuvemshop checkout

### **Constraints**

- 🔴 CONSTRAINT #1: Checkout button structure (protected)
- ✅ CONSTRAINT #2: Footer visible
- 🔴 CONSTRAINT #7: No JS overrides

### **Robots Meta**

- `noindex, nofollow` (don't index cart)

---

## 6️⃣ CHECKOUT PAGE

**File:** N/A (Nuvemshop Managed) | **Route:** `/checkout` | **Type:** Transaction

### **Important: NOT Customizable**

**This page is entirely managed by Nuvemshop.**

✅ **What you CAN do:**
- Style with CSS (colors, fonts, spacing)
- Add background images
- Customize button colors
- Change typography

❌ **What you CANNOT do:**
- Remove form fields
- Reorder fields
- Change payment processor
- Modify form structure
- Override JavaScript

### **Constraints**

- 🔴 CONSTRAINT #1: Form structure PROTECTED (CRITICAL)
- ✅ CONSTRAINT #2: Footer visible

### **CSS**

- File: `checkout.scss.tpl` (~3KB)
- Can customize appearance only

---

## 7️⃣ BLOG LISTING PAGE

**File:** `templates/blog.tpl` | **Route:** `/blog` | **Type:** Content

### **Sections**

| Section | Component | File |
|---------|-----------|------|
| **Blog Posts** | blog-grid | `snipplets/blog-item.tpl` |
| **Pagination** | pagination | Nuvemshop default or custom |

### **CSS & JS**

| Type | Files |
|------|-------|
| **CSS** | style-critical.tpl, style-blog.scss.tpl, style-async.scss.tpl |
| **JS** | store.js.tpl |

---

## 8️⃣ BLOG POST DETAIL PAGE

**File:** `templates/blog-post.tpl` | **Route:** `/blog/:slug` | **Type:** Content

### **Sections**

| Section | Component | File |
|---------|-----------|------|
| **Post Content** | post-detail | inline |
| **Social Share** | social-buttons | `snipplets/social-share.tpl` |
| **Comments** | comments | Nuvemshop comments |
| **Related Posts** | related-posts | Nuvemshop related |

### **SEO**

- **robots.txt:** `index, follow`
- **Open Graph:** Article type, published date, author
- **Twitter Cards:** Summary with image

---

## 9️⃣ CONTACT PAGE

**File:** `templates/contact.tpl` | **Route:** `/contact` | **Type:** Form

### **Sections**

| Section | Component | File | Purpose |
|---------|-----------|------|---------|
| **Contact Form** | contact-form | `snipplets/contact-links.tpl` | Email form to store |
| **Contact Links** | contact-info | inline | Phone, email, social |

### **Form Fields**

- Name (required)
- Email (required)
- Subject (required)
- Message (required)

### **Constraints**

- 🔴 CONSTRAINT #3: Form structure PROTECTED (CRITICAL)
- ✅ CONSTRAINT #2: Footer visible

---

## 🔟 GENERIC PAGE

**File:** `templates/page.tpl` | **Route:** `/pages/:slug` | **Type:** Content

### **Sections**

| Section | Component | File |
|---------|-----------|------|
| **Page Header** | page-header | `snipplets/page-header.tpl` |
| **Page Content** | page-body | inline (Nuvemshop CMS) |

**Examples:**
- About Us (`/about`)
- Privacy Policy (`/privacy`)
- Terms of Service (`/terms`)
- FAQ (`/faq`)

---

## 1️⃣1️⃣ ACCOUNT PAGES

**Files:** `templates/account/*.tpl` | **Route:** `/account/*` | **Type:** Authenticated

### **Subpages**

| Page | File | Purpose | Constraint |
|------|------|---------|-----------|
| **Login** | `account/login.tpl` | Customer login | CONSTRAINT #3 |
| **Register** | `account/register.tpl` | New account creation | CONSTRAINT #5 |
| **Addresses** | `account/addresses.tpl` | Saved addresses | — |
| **Address Detail** | `account/address.tpl` | Edit single address | — |
| **Orders** | `account/orders.tpl` | Order history | — |
| **Order Detail** | `account/order.tpl` | Single order view | — |
| **Account Info** | `account/info.tpl` | Profile settings | — |
| **Password Reset** | `account/reset.tpl` | Forgot password | — |
| **New Password** | `account/newpass.tpl` | Set new password | — |

### **Constraints**

- 🔴 CONSTRAINT #3: Login form PROTECTED
- 🔴 CONSTRAINT #5: Register form PROTECTED
- ✅ CONSTRAINT #2: Footer visible
- All pages: `noindex, nofollow`

---

## 1️⃣2️⃣ ERROR & SPECIAL PAGES

### **404 Not Found**

**File:** `templates/404.tpl`

- Custom 404 page
- Link to homepage/categories
- Search suggestions

### **Password Protected Store**

**File:** `templates/password.tpl`

- Password entry form
- Shown when store in maintenance
- Nuvemshop managed

---

## 📊 Quick Reference: CSS & JS by Page

| Page | CSS Critical | CSS Async | JS Modules |
|------|--------------|-----------|-----------|
| Home | style-critical.tpl, style-home-v2.css | style-async.scss.tpl | store.js, smooth-scroll |
| Product | style-critical.tpl | style-async.scss.tpl | store.js, external.js |
| Category | style-critical.tpl, style-filters-patagang.css.tpl | style-async.scss.tpl | store.js, external.js |
| Cart | style-critical.tpl | style-async.scss.tpl | store.js, cart-drawer.js, cart-utils.js |
| Blog | style-critical.tpl, style-blog.scss.tpl | style-async.scss.tpl | store.js |
| Contact | style-critical.tpl | — | store.js |
| Account | style-critical.tpl | — | store.js |

---

## 🎯 Page Performance Targets

| Page | LCP Target | FID Target | CLS Target | Lighthouse |
|------|-----------|-----------|-----------|-----------|
| Home | < 2.5s | < 0.1s | < 0.1 | > 90 |
| Product | < 2.5s | < 0.1s | < 0.1 | > 90 |
| Category | < 2.5s | < 0.1s | < 0.1 | > 85 |
| Cart | < 2.5s | < 0.1s | < 0.1 | > 85 |
| Blog | < 2.5s | < 0.1s | < 0.1 | > 88 |

---

## 🔗 Related Documentation

- **[README.md](README.md)** — Navigation & use cases
- **[03. Component Inventory](03-COMPONENT-INVENTORY.md)** — Snipplets used per page
- **[04. CSS Architecture](04-CSS-ARCHITECTURE.md)** — Style files & performance
- **[05. JavaScript Modules](05-JAVASCRIPT-MODULES.md)** — JS dependencies
- **[07. Nuvemshop Constraints](07-NUVEMSHOP-CONSTRAINTS.md)** — Restrictions per page

---

**Document Version:** 1.0.0 | **AIOX L4 Documentation** | **Last Updated:** 2026-03-24
