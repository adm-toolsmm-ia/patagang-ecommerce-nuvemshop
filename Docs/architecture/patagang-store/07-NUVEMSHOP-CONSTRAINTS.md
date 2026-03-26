# 7. Nuvemshop Constraints — Critical Restrictions

**Purpose:** Document all 8 critical Nuvemshop platform restrictions and what's forbidden

**Authority:** Nuvemshop Terms of Service + Gabriel Cristofolini (CTO)

---

## ⚠️ Constraint Summary Table

| # | Name | Severity | Pages | Current Status | Action |
|---|------|----------|-------|-----------------|--------|
| 1 | Checkout form structure | 🔴 CRITICAL | checkout, cart | ✅ PROTECTED | Do not modify |
| 2 | Footer attribution | 🔴 CRITICAL | all | ✅ VISIBLE | Keep visible |
| 3 | Contact form structure | 🟡 HIGH | contact, page | ✅ PROTECTED | Do not modify |
| 4 | CSS performance budget | 🟡 HIGH | all | 🔴 EXCEEDS (3.26x) | Reduce to 50KB |
| 5 | Registration form | 🟡 HIGH | account/register | ✅ PROTECTED | Do not modify |
| 6 | Newsletter form | 🟡 HIGH | home, page | ✅ PROTECTED | Do not modify |
| 7 | JavaScript safety | 🟠 MEDIUM | all | ✅ COMPLIANT | No override |
| 8 | Auto-generated files | 🟠 MEDIUM | root | ✅ UNTOUCHED | Do not modify |

---

## 🔴 CONSTRAINT #1: Checkout Form Structure — CRITICAL

### **The Rule**

**Do NOT modify checkout page structure, form fields, or layout.**

### **Why**

Nuvemshop manages the entire checkout flow:
- Payment processing
- Order placement
- Tax calculation
- Shipping selection
- Customer authentication

Modifying form structure can:
- Break payment processing
- Lose customer data
- Violate PCI compliance
- Cause order failures

### **What You CAN Modify**

✅ **ALLOWED:**
- CSS styling (colors, fonts, spacing)
- Button colors/styling
- Form input styling
- Layout spacing
- Typography
- Dark mode/light mode CSS

### **What You CANNOT Modify**

❌ **FORBIDDEN:**
- Remove form fields
- Add form fields
- Reorder form fields
- Change form structure (HTML hierarchy)
- Change form submission method (`POST`, `GET`)
- Change form endpoint (action)
- Modify input names or types
- Disable/enable fields programmatically

### **Examples**

#### ✅ Allowed (CSS styling only)

```html
<!-- ✅ ALLOWED: Style the form -->
<form class="checkout-form styled-checkout">
  <input type="text" name="email" class="styled-input">
  <button class="styled-button">Continue to Payment</button>
</form>

<style>
  .styled-input {
    border: 1px solid #ccc;
    padding: 12px;
    border-radius: 4px;
  }

  .styled-button {
    background-color: #EAFE67;
    padding: 12px 24px;
    border-radius: 4px;
  }
</style>
```

#### ❌ Forbidden (structure modification)

```html
<!-- ❌ FORBIDDEN: Remove fields -->
<form class="checkout-form">
  <!-- <input type="email" name="email"> --> REMOVED!
  <input type="text" name="name">
  <button>Continue</button>
</form>

<!-- ❌ FORBIDDEN: Reorder fields -->
<form class="checkout-form">
  <input type="text" name="name">
  <input type="email" name="email"> <!-- MOVED UP! -->
  <input type="text" name="address">
</form>

<!-- ❌ FORBIDDEN: Change endpoint -->
<form action="/custom-checkout"> <!-- CHANGED! -->
  ...
</form>
```

### **File Locations**

- **Checkout:** Nuvemshop managed (not in theme)
- **HTML:** Cannot be modified
- **Allowed:** Only CSS via `checkout.scss.tpl` (~3KB)

### **Violations & Consequences**

| Violation | Consequence |
|-----------|------------|
| Remove email field | Checkout breaks, no order placed |
| Remove payment field | Can't complete payment |
| Change form method | Data lost, payment fails |
| Change endpoint | Custom server receives data (privacy issue) |

---

## 🔴 CONSTRAINT #2: Footer Attribution — CRITICAL

### **The Rule**

**Footer MUST contain VISIBLE Nuvemshop store attribution.**

### **Why**

Nuvemshop Terms of Service (Legal Requirement):
- Proves store is using Nuvemshop
- Provides platform attribution
- Maintains relationship with Nuvemshop
- Violation = terms breach

### **Current Status**

✅ **COMPLIANT:** Footer contains "Powered by Nuvemshop" (visible)

Location: `snipplets/footer.tpl`

### **What You CAN Modify**

✅ **ALLOWED:**
- Footer styling (colors, fonts, background)
- Footer positioning (sticky footer, etc.)
- Additional footer content (links, social, etc.)
- Footer layout changes
- Typography changes

### **What You CANNOT Modify**

❌ **FORBIDDEN:**
- Remove footer completely
- Hide attribution with `display: none`
- Hide with `opacity: 0`
- Hide with `visibility: hidden`
- Move attribution off-screen (`position: absolute; left: -9999px`)
- Make text color same as background (invisible)
- Shrink to unreadable size

### **Examples**

#### ✅ Allowed (Add content around attribution)

```html
<!-- ✅ ALLOWED: Enhance footer -->
<footer class="footer">
  <div class="footer-primary">
    <div class="footer-navigation">
      <a href="/about">About</a>
      <a href="/contact">Contact</a>
    </div>

    <!-- REQUIRED: Visible attribution -->
    <p class="footer-attribution">
      © 2026 Patagang | Powered by {{ store.powered_by }}
    </p>
  </div>

  <div class="footer-secondary">
    <a href="/privacy">Privacy Policy</a>
    <a href="/terms">Terms</a>
  </div>
</footer>

<style>
  .footer {
    background-color: #f5f5f5;
    padding: 40px;
    text-align: center;
  }

  .footer-attribution {
    color: #333;
    font-size: 14px;
    margin: 10px 0; /* Visible and readable */
  }
</style>
```

#### ❌ Forbidden (Hide attribution)

```html
<!-- ❌ FORBIDDEN: Hide with display:none -->
<footer>
  <p style="display: none;">Powered by Nuvemshop</p>
</footer>

<!-- ❌ FORBIDDEN: Hide with opacity -->
<footer>
  <p style="opacity: 0;">Powered by Nuvemshop</p>
</footer>

<!-- ❌ FORBIDDEN: Off-screen -->
<footer>
  <p style="position: absolute; left: -9999px;">Powered by Nuvemshop</p>
</footer>

<!-- ❌ FORBIDDEN: Invisible text -->
<footer>
  <p style="color: white; background-color: white;">Powered by Nuvemshop</p>
</footer>
```

### **File Location**

- **File:** `snipplets/footer.tpl`
- **CSS:** `style-critical.tpl` (footer styling)

### **Verification**

To verify compliance:
1. Open https://patagang.com.br/ in browser
2. Scroll to footer
3. Verify text "Powered by Nuvemshop" is visible
4. Check mobile footer (also visible on mobile)

---

## 🟡 CONSTRAINT #3: Contact Form Structure — HIGH

### **The Rule**

**Do NOT modify contact form structure, fields, or submission.**

### **Why**

Contact form integrates with Nuvemshop backend:
- Email delivery to store admin
- Customer inquiry tracking
- CRM integration
- Support ticket creation

Modifications break the integration.

### **What You CAN Modify**

✅ **ALLOWED:**
- Input styling (border, padding, font)
- Label styling
- Button colors
- Form container styling
- Placeholder text
- Help text styling

### **What You CANNOT Modify**

❌ **FORBIDDEN:**
- Remove name, email, message fields
- Reorder form fields
- Change form submission endpoint
- Change field names (name, email, message)
- Add new required fields
- Change validation logic

### **Current Status**

✅ **COMPLIANT:** Contact form structure untouched

Location: `snipplets/contact-links.tpl`

---

## 🟡 CONSTRAINT #4: CSS Performance Budget — HIGH

### **The Rule**

**Critical CSS must be < 50KB (currently 163KB — EXCEEDS)**

### **Current Status**

🔴 **VIOLATION:** Critical CSS is 3.26x over limit

| Metric | Value | Limit | Status |
|--------|-------|-------|--------|
| Current | 163KB | 50KB | 🔴 EXCEEDS |
| Async | 164KB | 200KB | ✅ OK |

### **Impact**

```
163KB critical CSS
├─ 550ms render blocking (mobile)
├─ 0.6s delay to LCP
├─ Visible white screen (2-3 seconds)
└─ Poor Core Web Vitals score
```

### **Goal: Story 8.2**

**Target:** Reduce to 50KB (~113KB savings)

**Strategy:**
1. Remove unused CSS (Chrome DevTools Coverage)
2. Split by page type (common + page-specific)
3. Move animations to async CSS
4. Extract utilities to separate file

### **How to Help**

If modifying CSS:
1. Check current size: `wc -c theme-deploy-corrigido/static/css/style-critical.tpl`
2. Minimize new CSS added
3. Prefer async CSS for non-critical styles
4. Run DevTools Coverage before committing

---

## 🟡 CONSTRAINT #5: Registration Form — HIGH

### **The Rule**

**Do NOT modify registration form structure or validation.**

### **Why**

Registration integrates with Nuvemshop customer database:
- Account creation
- Email verification
- Password hashing
- Profile storage
- CRM sync

### **Current Status**

✅ **COMPLIANT:** Registration form untouched

Location: `templates/account/register.tpl`

### **File Locations**

- **File:** `templates/account/register.tpl`
- **CSS:** `style-critical.tpl` (form styling)

---

## 🟡 CONSTRAINT #6: Newsletter Form — HIGH

### **The Rule**

**Do NOT modify newsletter form submission or structure.**

### **Why**

Newsletter form integrates with Nuvemshop email marketing:
- Email list building
- Subscriber management
- Campaign tracking
- Compliance (CAN-SPAM, GDPR)

### **Current Status**

✅ **COMPLIANT:** Newsletter form untouched

Locations:
- `snipplets/newsletter.tpl` (footer)
- `snipplets/modal-newsletter.tpl` (modal)

### **What You CAN Modify**

✅ **ALLOWED:**
- Button colors/styling
- Input styling
- Label text
- Modal appearance
- Submission button text ("Subscribe" → "Join Our List")

### **What You CANNOT Modify**

❌ **FORBIDDEN:**
- Remove email input
- Add non-email fields (without backend support)
- Change form action
- Disable submission button
- Change form method

---

## 🟠 CONSTRAINT #7: JavaScript Safety — MEDIUM

### **The Rule**

**Custom JavaScript must NOT override Nuvemshop core functions.**

### **Why**

Nuvemshop provides core functionality via global JavaScript:
- `window.Nuvemshop.*` — Platform API
- `window.$` — jQuery (required for theme)
- `window.fetch` — API calls
- Event system for cart/checkout

Overriding breaks platform functionality.

### **Forbidden Patterns**

❌ **OVERRIDE NUVEMSHOP FUNCTIONS:**

```javascript
// ❌ DON'T DO THIS
window.Nuvemshop.checkout.complete = function() {
  // Custom logic (BREAKS CHECKOUT!)
};

window.Nuvemshop.cart.addItem = function() {
  // Custom logic (BREAKS CART!)
};
```

❌ **OVERRIDE GLOBAL VARIABLES:**

```javascript
// ❌ DON'T DO THIS
$ = null;  // BREAKS JQUERY!
jQuery = {};  // BREAKS JQUERY!
fetch = null;  // BREAKS API CALLS!
```

❌ **POLLUTE GLOBAL SCOPE:**

```javascript
// ❌ DON'T DO THIS
function myHelper() { ... }  // Global function
myVar = 42;  // Global variable
Object.keys = customFunction;  // BREAKS NATIVE!
```

### **Allowed Patterns**

✅ **SCOPE IN IIFE (Immediately Invoked Function Expression):**

```javascript
// ✅ DO THIS INSTEAD
(function() {
  // All code scoped to this function
  function myHelper() { ... }
  const myVar = 42;

  // Listen to Nuvemshop events (don't override!)
  document.addEventListener('cart:updated', function() {
    console.log('Cart updated');
  });
})();
```

✅ **NAMESPACE UNDER CUSTOM OBJECT:**

```javascript
// ✅ DO THIS INSTEAD
window.MyStore = {
  helpers: {
    formatPrice: function(price) { ... }
  },
  product: {
    selectVariant: function(id) { ... }
  }
};
```

✅ **USE EVENT LISTENERS (SAFE):**

```javascript
// ✅ DO THIS INSTEAD
document.addEventListener('cart:added', function(e) {
  console.log('Product added to cart:', e.detail);
});

document.addEventListener('checkout:started', function() {
  console.log('Checkout started');
});
```

### **Current Status**

✅ **COMPLIANT:** store.js and external.js follow proper scoping

---

## 🟠 CONSTRAINT #8: Auto-Generated Files — MEDIUM

### **The Rule**

**Do NOT modify Nuvemshop auto-generated files.**

### **Files Affected**

```
/sitemap.xml          ← Regenerated daily by Nuvemshop
/feed.xml             ← Regenerated daily
/robots.txt           ← Can be configured in Admin
/rss.xml              ← Regenerated daily
/.well-known/*        ← Nuvemshop managed
```

### **Why**

These files are automatically regenerated by Nuvemshop:
- Product catalog changes → sitemap updates
- Posts added → feed updates
- Store settings → robots.txt updates

Manual changes are overwritten within 24 hours.

### **What To Do Instead**

✅ **Configure via Nuvemshop Admin:**
1. **robots.txt:** Admin → Settings → SEO → Robots.txt
2. **Sitemap:** Auto-generated (no config needed)
3. **Feed:** Admin → Settings → Feeds

### **Current Status**

✅ **COMPLIANT:** These files not modified

---

## ✅ Constraint Compliance Checklist

Use this checklist before EVERY deployment:

### **Pre-Deployment Verification**

- [ ] **Constraint #1:** Checkout form NOT modified (styling only)
- [ ] **Constraint #2:** Footer attribution visible (check mobile too)
- [ ] **Constraint #3:** Contact form NOT modified (styling only)
- [ ] **Constraint #4:** CSS size monitored (track towards 50KB goal)
- [ ] **Constraint #5:** Registration form NOT modified
- [ ] **Constraint #6:** Newsletter form NOT modified
- [ ] **Constraint #7:** No `window.Nuvemshop.*` overrides
- [ ] **Constraint #8:** No auto-generated files modified
- [ ] **Tests:** All pages render correctly
- [ ] **Console:** No JavaScript errors or warnings
- [ ] **Mobile:** Forms work on mobile (not broken by CSS)

### **Automated Checks**

```bash
# Check for constraint violations (if available)
npm run validate:constraints

# Output example:
# ✅ Constraint #1: Checkout form untouched
# ✅ Constraint #2: Footer attribution present
# ⚠️  Constraint #4: CSS size 163KB (exceeds 50KB)
# ✅ Constraint #6: Newsletter form untouched
# ... etc
```

---

## 🔗 Incident Recovery

### **If You Violate a Constraint**

**Step 1: Identify the violation**
```
❌ Accidentally removed email field from contact form
```

**Step 2: Rollback immediately**
```bash
# Option A: Revert last commit
git revert HEAD

# Option B: Rollback production
node ftp-deploy/rollback-incremental.js --version v1.5.92
```

**Step 3: Fix the code**
- Restore original form structure
- Test thoroughly
- Check console for errors

**Step 4: Re-deploy**
```bash
node ftp-deploy/deploy.js "v1.5.XX: Fix contact form [Story X.Y.Z]" --force
```

---

## 📚 Related Documentation

- **[01. Store Overview](01-STORE-OVERVIEW.md)** — Constraint context
- **[02. Page Structure](02-PAGE-STRUCTURE.md)** — Pages affected by constraints
- **Registry:** `.aiox-core/data/patagang-store-catalog.yaml` (constraints section)
- **Rules:** `.claude/rules/nuvemshop-ftp-constraints.md` (enforcement details)

---

**Document Version:** 1.0.0 | **AIOX L4 Documentation** | **Authority:** Gabriel Cristofolini (CTO)
**Last Updated:** 2026-03-24 | **Severity:** CRITICAL — Violations cause production issues
