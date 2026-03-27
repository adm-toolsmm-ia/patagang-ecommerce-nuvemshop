# Nuvemshop FTP Constraints — Complete Reference Guide

**Type:** L2 Development Reference (NOT auto-loaded)
**Created:** 2026-03-28
**For:** Deep understanding of 8 critical constraints

**Quick Reference:** `.claude/rules/nuvemshop-ftp-constraints.md`

---

## Constraint #1: Checkout Structure (CRITICAL)

**Rule:** Do NOT modify checkout page structure, form fields, or layout.

### Why This Matters

Nuvemshop platform handles checkout backend. Structural changes break:
- Payment processing (form data flow)
- Order submission (backend integration)
- Customer authentication (session handling)
- Tax/shipping calculations (hidden fields)

### What's Protected

```
- Form element position (reordering breaks flow)
- Form field removal (backend expects all fields)
- Form field addition (unhandled by backend)
- HTML structure changes (<form>, <input>, <section> nesting)
- Form submission endpoint (action="" attribute)
```

### Safe Examples

```liquid
✅ Styling only:
<div style="color: #333;">{{ field }}</div>

✅ CSS classes:
<input type="email" class="form-input form-input--large" />

✅ Variable logic:
{% assign field_color = '#FF0000' %}
<input style="color: {{ field_color }};" />

✅ Placeholder text:
<input type="text" placeholder="Seu email" />
```

### Unsafe Examples

```liquid
❌ Field removal:
<!-- removed coupon field to simplify checkout -->

❌ Field addition:
<input type="hidden" name="custom_data" />

❌ Form reordering:
<form>
  <input name="payment" />
  <input name="email" />   <!-- moved up! -->
</form>

❌ Nesting change:
<fieldset>
  <input name="payment" />  <!-- was direct child of form -->
</fieldset>
```

### Violation Recovery

1. Identify changes: `git diff HEAD^..HEAD -- checkout.tpl`
2. Revert file: `git checkout -- theme-deploy-corrigido/layouts/checkout.tpl`
3. Reapply styling only: Re-implement color/spacing changes in CSS instead
4. Test payment flow: End-to-end checkout validation
5. Report: Document what was attempted + why it failed

---

## Constraint #2: Footer Attribution (CRITICAL)

**Rule:** Footer MUST contain visible Nuvemshop store name.

### Why This Matters

**Legal Requirement:** Nuvemshop Terms of Service require visible store attribution.
- Removing = contract violation
- Hiding = violation (same as removing)
- Obscuring = violation (same as removing)

### What's Protected

Any technique that hides/removes/obscures:

```css
/* All UNSAFE */
display: none;           ← Hides content
opacity: 0;              ← Invisible
visibility: hidden;      ← Hidden but reserves space
height: 0; overflow: hidden;  ← Collapses
position: absolute; left: -9999px;  ← Off-screen
font-size: 0;           ← Invisible text
color: transparent;     ← Invisible text
```

### Safe Examples

```liquid
✅ Visible footer:
<footer>
  <p>Loja {{ store.name }} - Powered by {{ store.powered_by }}</p>
</footer>

✅ Styled footer:
<footer style="text-align: center; padding: 20px; color: #666;">
  {{ store.name }} • Nuvemshop Store
</footer>

✅ Multiple lines:
<footer>
  <p>Powered by Nuvemshop</p>
  <p>© {{ year }} {{ store.name }}</p>
</footer>
```

### Unsafe Examples

```liquid
❌ Hidden with CSS:
<footer style="display: none;">Powered by Nuvemshop</footer>

❌ Removed entirely:
<!-- Removed Nuvemshop attribution to clean up footer -->

❌ Invisible text:
<footer style="opacity: 0;">Powered by Nuvemshop</footer>

❌ Off-screen:
<footer style="position: absolute; left: -9999px;">...</footer>
```

### Violation Recovery

1. Find footer file: `grep -r "Nuvemshop\|powered by" --include="*.tpl"`
2. Restore original: `git checkout -- theme-deploy-corrigido/layouts/footer*.tpl`
3. Check visibility: Ensure text is readable (not hidden)
4. Test: Navigate to site, verify footer appears
5. Report: Document attempted changes + why violation occurred

---

## Constraint #3-5: Forms (Contact, Registration, Newsletter)

**Rule:** Do NOT modify form structure, field order, backend submission.

### Why This Matters

**Backend Integration:** Forms sync with Nuvemshop:
- Contact form → Customer support emails
- Registration form → Customer database
- Newsletter form → Marketing automation + email list

Modifications break synchronization.

### Protected Elements

```
- Form field order (reordering breaks database schema)
- Form field removal (creates NULL values)
- Form field addition (unhandled by backend)
- Submission endpoint (action="" attribute)
- Submission method (method="post/get")
- Field validation (pattern, required attributes)
```

### Safe Examples

```liquid
✅ Styling:
<input type="email" style="border: 1px solid #ccc;" />

✅ Placeholder:
<input type="text" placeholder="Seu nome" />

✅ Label text:
<label>Email (obrigatório):</label>

✅ CSS classes:
<input class="form-input form-input--large" />
```

### Unsafe Examples

```liquid
❌ Field removal:
<!-- removed email field to reduce spam -->

❌ Field reordering:
<form>
  <input name="message" />
  <input name="email" />    <!-- should be first -->
</form>

❌ Custom validation:
<input type="email" pattern="[a-z@.]+" />

❌ Submission change:
<form action="/custom-handler">
```

### Violation Recovery

Same as Checkout (#1):
1. `git diff` to identify changes
2. Revert entire file
3. Apply styling changes in CSS only
4. Test form submission
5. Verify backend receives correct data

---

## Constraint #6: JavaScript Safety

**Rule:** Do NOT override Nuvemshop core functions or conflict with platform libraries.

### Why This Matters

Nuvemshop provides global JS functions:
- `window.Nuvemshop.*` — Platform API
- `jQuery` (if loaded) — DOM manipulation
- Analytics, payment, checkout functions

Overriding breaks platform features.

### Protected Elements

```javascript
/* All UNSAFE to override */
window.Nuvemshop.*
window.$
window.checkout
window.analytics
/* or any global modifications */
```

### Safe Examples

```javascript
✅ Scoped code (IIFE):
(function() {
  const customizeHeaderColor = () => {
    // isolated code
  };
  // not global
})();

✅ Modern event binding:
document.addEventListener('DOMContentLoaded', () => {
  document.querySelector('.header').style.color = '#333';
});

✅ Namespacing:
window.PatagangTheme = {
  customizeColor: function() { ... }
};
```

### Unsafe Examples

```javascript
❌ Override platform functions:
window.Nuvemshop.checkout.complete = function() {
  // replaces platform checkout
};

❌ Global variable pollution:
$ = null;      // breaks jQuery
window.fetch = customFetch;

❌ Silent failures:
try {
  risky_operation();
} catch(e) {
  // swallowed, no error handling
}
```

### Violation Recovery

1. Identify overrides: `grep -r "window\.\|override\|replace" --include="*.js"`
2. Remove conflicting code
3. Rewrite using scoped IIFEs or namespacing
4. Test: Browser console (zero errors), checkout flow, analytics
5. Report: Document attempted approach + corrected solution

---

## Constraint #7: CSS Performance (< 50 KB)

**Rule:** Critical CSS file must remain < 50 KB.

### Why This Matters

Critical CSS is inlined in `<head>`, blocking page render.
- > 50 KB = slower First Contentful Paint (FCP)
- Violates Core Web Vitals targets
- Mobile users especially affected

### Measurement

```bash
# Check current size
wc -c theme-deploy-corrigido/static/css/style-critical.tpl

# If > 50000 bytes, need to reduce
```

### Safe Examples

```scss
✅ Variable reuse (efficient):
$primary-color: #007bff;
.btn { color: $primary-color; }
.link { color: $primary-color; }

✅ External image URLs:
.hero {
  background: url('/images/hero.jpg');  /* optimized image < 100KB */
}

✅ Minimal fonts:
@import url('https://fonts.googleapis.com/css?family=Font1');  /* 1 font */
```

### Unsafe Examples

```scss
❌ Embedded base64 images (bloats file):
.icon { background: url('data:image/svg+xml;base64,VERY_LONG_STRING...'); }

❌ Multiple fonts (blocking):
@import url('https://fonts.googleapis.com/css?family=Font1&Font2&Font3&Font4');

❌ Unused CSS (dead code):
.old-header { ... }  /* 200+ lines unused */
.legacy-layout { ... }
```

### Violation Recovery

1. **Check size:** `wc -c style-critical.tpl` (if > 50KB, continue)
2. **Find unused rules:**
   - Chrome DevTools → Coverage tab
   - Run Lighthouse audit
   - Identify < 10% used rules
3. **Optimize:**
   - Remove unused selectors
   - Move non-critical styles to separate async stylesheet
   - Compress images (ImageOptim, TinyPNG)
   - Minify: `npm run build` should do this automatically
4. **Re-test:**
   - Lighthouse score stays > 90 mobile
   - No visual regression
5. **Verify:** `wc -c style-critical.tpl` confirms < 50KB

---

## Constraint #8: Auto-Generated Files

**Rule:** Do NOT modify sitemap.xml, rss.xml, robots.txt (regenerated daily).

### Why This Matters

Nuvemshop automatically regenerates these files daily.
Manual changes are overwritten → effort wasted.

### Protected Files

```
- sitemap.xml      (regenerated daily by Nuvemshop)
- rss.xml          (regenerated daily)
- robots.txt       (can regenerate overnight)
```

### Safe Approach

Configure via Nuvemshop Admin instead:

```
Nuvemshop Admin → Settings → SEO
├── Sitemap: Enable/disable
├── RSS Feeds: Configuration
└── Robots Meta Tag: Set rules
```

### Violation Recovery

1. Do NOT edit these files via FTP
2. Revert any manual edits: `git checkout -- theme-deploy-corrigido/robots.txt`
3. Configure in Admin panel (persistent solution)

---

## Validation Checklist (Before Deploy)

```
8/8 Nuvemshop Constraints Check:

☐ 1. Checkout structure NOT modified (CSS-only changes OK)
☐ 2. Footer attribution VISIBLE (not hidden/removed)
☐ 3. Contact form structure INTACT (styling OK)
☐ 4. Registration form structure INTACT (styling OK)
☐ 5. Newsletter form structure INTACT (styling OK)
☐ 6. No JavaScript function overrides detected
☐ 7. CSS file < 50 KB (check: wc -c style-critical.tpl)
☐ 8. No auto-generated files modified (sitemap, RSS, robots)

Result: ✅ ALL 8 PASS or ❌ VIOLATIONS FOUND
```

---

## Enforcement & Escalation

### Blocking Violations (Auto-Fail)

These violations **block deployment** and require @architect approval:
- Checkout structural modifications
- Footer attribution removal/hiding
- Critical form field removals
- Nuvemshop function overrides

### Warning Violations (Auto-Flag)

These violations **flag for review** but don't block:
- CSS approaching 50 KB
- New external dependencies
- Performance concerns

### Escalation Process

1. **@dev:** Detect violation → report to @architect
2. **@architect:** Review + approve override OR require fix
3. **@devops:** Validate gates before deployment
4. **@qa:** Final validation post-deploy

---

## Reference Documents

- **Quick Reference:** `.claude/rules/nuvemshop-ftp-constraints.md`
- **Safe Deployment:** `.aiox-core/development/docs/SAFE_DEPLOYMENT_STANDARD.md`
- **Lessons Learned:** `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md`

---

**Version:** 2.0
**Type:** L2 Development Reference (on-demand loaded)
**Authority:** @architect
