# Nuvemshop FTP Constraints — Contextual Validation Rule

**Rule Type:** Contextual Auto-Load
**Version:** 1.0
**Date Created:** 2026-03-20
**Trigger Paths:** `theme-deploy-corrigido/**/*.tpl`, `theme-deploy-corrigido/**/*.scss`, `theme-deploy-corrigido/**/*.js`
**Severity:** CRITICAL
**Authority:** @architect + @analyst consolidated research

---

## TRIGGER CONDITION

This rule **auto-loads** when files matching these patterns are edited:

```
theme-deploy-corrigido/**/*.tpl      (Template files)
theme-deploy-corrigido/**/*.scss     (Stylesheet files)
theme-deploy-corrigido/**/*.js       (JavaScript files)
theme-deploy-corrigido/layouts/**/*  (Layout templates)
theme-deploy-corrigido/snipplets/**/* (Snippet templates)
theme-deploy-corrigido/static/**/*   (Static assets and styles)
```

---

## RULE CONTENT

### About This Rule

You are editing **Nuvemshop FTP theme files**. This rule enforces critical constraints documented in `NUVEMSHOP_FTP_STANDARDS.md` to prevent violations that would:

- **Break payment processing** (checkout modifications)
- **Violate Nuvemshop Terms of Service** (footer attribution removal)
- **Disable backend integrations** (form field modifications)
- **Degrade performance** (bundle size violations)

---

## CONSTRAINT PATTERNS (8 Critical Rules)

### 🔴 CONSTRAINT #1: Checkout Structure (CRITICAL)

**Rule:** Do NOT modify checkout page structure, form fields, or layout.

**Trigger Pattern:**
```
File: **/checkout.tpl OR
Content:
  - Form field removals: <input removed from form context
  - Form reordering: form element position changed
  - HTML structure: <form>, <div>, <section> nesting changed in checkout
```

**Why:** Nuvemshop platform handles checkout backend. Structural changes break payment processing and order data flow. Only color/styling changes are safe.

**Safe Examples:**
```liquid
✅ <div style="color: #333;">{{ field }}</div>        (styling only)
✅ {% assign field_color = '#FF0000' %}               (variable logic)
```

**Unsafe Examples:**
```liquid
❌ <!-- removed checkout step -->                     (field removal)
❌ <input type="hidden" name="coupon"> (new field)    (form modification)
```

**Violation Fix:**
- Undo checkout structural changes
- Revert to `checkout.tpl` from version control
- Ask @architect if styling-only changes needed
- See: NUVEMSHOP_FTP_VIOLATION_RECOVERY.md → Scenario 1

---

### 🔴 CONSTRAINT #2: Footer Attribution (CRITICAL)

**Rule:** Footer MUST contain visible Nuvemshop store name. Cannot be hidden, removed, or obscured.

**Trigger Pattern:**
```
File: **/footer.tpl OR **/footer-*.tpl
Content:
  - Attribute removal: "Powered by Nuvemshop" removed
  - CSS hiding: display: none; opacity: 0; visibility: hidden;
  - Position hiding: position: absolute; left: -9999px;
  - Overflow hide: overflow: hidden; height: 0;
```

**Why:** Nuvemshop Terms of Service requires visible store attribution for legal compliance. Removal violates platform terms.

**Safe Examples:**
```liquid
✅ <footer>
     <p>Loja {{ store.name }} - Powered by {{ store.powered_by }}</p>
   </footer>
✅ <footer style="text-align: center; padding: 20px;">
     Nuvemshop Store
   </footer>
```

**Unsafe Examples:**
```liquid
❌ <footer style="display: none;">Powered by Nuvemshop</footer>  (hidden)
❌ <!-- Powered by Nuvemshop -->                                 (removed)
❌ <footer style="opacity: 0;">Powered by Nuvemshop</footer>     (invisible)
```

**Violation Fix:**
- Restore footer attribution
- Remove any `display: none`, `opacity: 0`, `visibility: hidden` CSS
- Ensure text is visible in footer area
- Review with @qa before deployment
- See: NUVEMSHOP_FTP_VIOLATION_RECOVERY.md → Scenario 2

---

### 🔴 CONSTRAINT #3: Contact Form Integration (HIGH)

**Rule:** Do NOT modify contact form structure, field order, or backend submission.

**Trigger Pattern:**
```
File: **/contact*.tpl OR **/form*.tpl
Content:
  - Field removal: <input name="email"> removed from form
  - Field reordering: form fields rearranged
  - Submission modification: form action changed or method modified
  - Field addition in form context: new <input>, <textarea>, <select> added
```

**Why:** Contact form integrates with Nuvemshop backend for customer communication. Modifications break email delivery and CRM integration.

**Safe Examples:**
```liquid
✅ <input type="email" name="email" style="border: 1px solid #ccc;" />  (styling)
✅ <input type="text" name="name" placeholder="Seu nome" />             (placeholder)
```

**Unsafe Examples:**
```liquid
❌ <!-- removed email field to reduce spam -->                          (field removal)
❌ <form action="/custom-handler">Contact Form</form>                   (endpoint change)
```

**Violation Fix:**
- Restore form to original structure
- Revert form to template defaults
- If custom behavior needed, ask @architect for API-based solution
- See: NUVEMSHOP_FTP_VIOLATION_RECOVERY.md → Scenario 3

---

### 🟡 CONSTRAINT #4: Performance Budget — CSS Size (HIGH)

**Rule:** `theme-deploy-corrigido/static/css/style-critical.tpl` must remain < 50 KB

**Trigger Pattern:**
```
File: style-critical.tpl OR style.scss
Content Changes:
  - File size approaches 45 KB (warning)
  - File size exceeds 50 KB (error)
  - New font declarations without justification
  - Large background-image URLs embedded in CSS
```

**Why:** Critical CSS is inlined in `<head>`, blocking page render. Large files delay page load and impact Core Web Vitals (Largest Contentful Paint).

**Safe Examples:**
```scss
✅ $primary-color: #007bff;
   .btn { color: $primary-color; }                (variable reuse)
✅ .header { background-image: url('/images/hero.jpg'); }
   (image < 100KB, properly optimized)
```

**Unsafe Examples:**
```scss
❌ .element { background: url('data:image/svg+xml;base64,VERY_LONG_STRING...'); }
   (embedded base64 bloats CSS)
❌ @import url('https://fonts.googleapis.com/css?family=Font1&Font2&Font3&Font4');
   (loads 4+ fonts blocking render)
```

**Violation Fix:**
1. Check current file size: `wc -c theme-deploy-corrigido/static/css/style-critical.tpl`
2. If > 50 KB:
   - Remove unused CSS rules (use Chrome DevTools Coverage tab)
   - Move non-critical styles to separate async stylesheet
   - Optimize images: compress with ImageOptim or TinyPNG
   - Minify CSS: `npm run build` should minify automatically
3. Re-test performance: Lighthouse score should stay > 90 mobile
4. Verify: Core Web Vitals acceptable before deployment

---

### 🟡 CONSTRAINT #5: Registration Form Integrity (HIGH)

**Rule:** Do NOT modify registration form fields, validation, or backend submission.

**Trigger Pattern:**
```
File: **/register*.tpl OR **/signup*.tpl
Content:
  - Field removal: <input> removed
  - Validation changes: new pattern/required attribute added
  - Submission endpoint changed
  - Password field modifications
```

**Why:** Registration integrates with Nuvemshop customer database. Modifications break account creation and CRM data flow.

**Safe Examples:**
```liquid
✅ <input type="email" name="email" style="border-radius: 4px;" />  (styling)
✅ <label style="color: #666;">Email (required)</label>              (text styling)
```

**Unsafe Examples:**
```liquid
❌ <input type="email" name="email" disabled />                      (field disabled)
❌ <input type="password" name="pwd" pattern="[A-Z]+" />             (validation added)
```

**Violation Fix:**
- Restore form fields to original Nuvemshop defaults
- Remove custom validation added
- Test registration flow end-to-end
- See: NUVEMSHOP_FTP_VIOLATION_RECOVERY.md → Scenario 3

---

### 🟡 CONSTRAINT #6: Newsletter Form Integration (HIGH)

**Rule:** Do NOT modify newsletter subscription form structure or submission.

**Trigger Pattern:**
```
File: **/newsletter*.tpl OR **/subscribe*.tpl
Content:
  - Field removal: email/name fields removed
  - Submission endpoint changed
  - Backend integration disrupted
  - Checkbox/consent fields added without backend
```

**Why:** Newsletter form syncs with Nuvemshop marketing automation. Modifications break subscriber list and email campaign delivery.

**Safe Examples:**
```liquid
✅ <input type="email" name="email" placeholder="seu@email.com" />  (UX text)
✅ <button style="background: #FF6600;">Subscribe</button>           (styling)
```

**Unsafe Examples:**
```liquid
❌ <!-- removed newsletter to reduce complexity -->                  (removed)
❌ <form action="/custom-subscriber-handler">                        (endpoint change)
```

**Violation Fix:**
- Restore newsletter form to original template
- Verify Nuvemshop newsletter settings still active in Admin
- Test: Subscribe with test email and confirm receipt
- See: NUVEMSHOP_FTP_VIOLATION_RECOVERY.md → Scenario 3

---

### 🟡 CONSTRAINT #7: JavaScript Safety Checks (MEDIUM)

**Rule:** Custom JavaScript must not override Nuvemshop core functions or conflict with platform libraries.

**Trigger Pattern:**
```
File: **/*.js OR **/store.js.tpl
Content:
  - Global variable overrides: window.fetchProduct = custom_func;
  - jQuery conflicts: $ redefined
  - Nuvemshop function overrides: Nuvemshop.checkout.submit redefined
  - Silent failures: try/catch without error logging
```

**Why:** Nuvemshop platform provides core functionality through global JS. Overriding breaks checkout, analytics, and admin integrations.

**Safe Examples:**
```javascript
✅ (function() {
     // Scope custom code in IIFE to avoid global conflicts
     const customizeHeaderColor = () => { ... };
   })();

✅ document.addEventListener('DOMContentLoaded', () => {
     // Modern event binding, no conflicts
     document.querySelector('.header').style.color = '#333';
   });
```

**Unsafe Examples:**
```javascript
❌ window.Nuvemshop.checkout.complete = function() {
     // Overrides platform checkout
   };

❌ $ = null;  // Breaks jQuery if Nuvemshop expects it
```

**Violation Fix:**
- Scope custom code in IIFEs or modules
- Never override Nuvemshop global functions
- Check browser console for conflicts: `console.error()`
- Use namespacing: `window.PatagangTheme = { ... }`
- Add error handlers: `try { ... } catch(e) { console.error(e); }`

---

### 🟠 CONSTRAINT #8: Auto-Generated Content Lock (MEDIUM)

**Rule:** Do NOT modify auto-generated files (sitemap, RSS feeds, robots.txt).

**Trigger Pattern:**
```
File: sitemap.xml OR rss.xml OR robots.txt
Content:
  - Any modifications to auto-generated files
  - Note: These files are regenerated by Nuvemshop daily
```

**Why:** Nuvemshop automatically regenerates these files daily. Manual modifications are overwritten and provide no benefit.

**Safe Examples:**
```
✅ Only modify these through Nuvemshop Admin settings
✅ robots.txt: Configure via Admin → SEO → Robots Meta Tag
```

**Unsafe Examples:**
```xml
❌ Manually editing sitemap.xml (overwritten next update)
❌ Removing pages from RSS feed manually (regenerated daily)
```

**Violation Fix:**
- Do not modify these files via FTP
- Configure settings through Nuvemshop Admin panel instead
- Revert any manual changes immediately

---

## ENFORCEMENT RULES

### 🛑 BLOCKING (AUTO-FAIL)

These violations **block commit** and require @architect approval to override:
- ✗ Checkout structure modifications
- ✗ Footer attribution removal/hiding
- ✗ Critical form field removals (contact, registration, newsletter)
- ✗ Nuvemshop function overrides in JavaScript

**Override Process:**
1. Document justification in commit message
2. Request @architect approval via code comment: `// @architect: override-requested: {reason}`
3. @architect reviews and approves (or rejects)
4. If approved, proceed with deployment

### ⚠️ WARNING (AUTO-FLAG)

These violations **flag for review** but don't block:
- ⚠ CSS file approaching 50 KB (warning at 45 KB, error at 50 KB)
- ⚠ New external JavaScript dependencies
- ⚠ Form styling that might hide critical fields
- ⚠ Performance concerns detected

**Review Process:**
1. Review warning message
2. If acceptable: proceed with deployment after @qa approval
3. If not acceptable: fix and commit again

---

## APPLYING THIS RULE

### For @dev (During Implementation)

When editing theme files, Claude Code will:
1. **Auto-load this rule** (if file matches trigger patterns)
2. **Display relevant constraints** as you edit
3. **Flag violations** in real-time with severity
4. **Suggest fixes** with links to documentation

**Example Feedback:**
```
⚠️ NUVEMSHOP CONSTRAINT VIOLATION
File: theme-deploy-corrigido/layouts/checkout.tpl

🔴 CRITICAL: Checkout form structure modified
   - Detected: <input> removal from form context
   - Location: Line 45, checkout payment section
   - Action: Revert form structure OR request @architect override

📖 Learn more: NUVEMSHOP_FTP_STANDARDS.md § Checkout Rules
🔧 Recovery steps: NUVEMSHOP_FTP_VIOLATION_RECOVERY.md § Scenario 1
```

### For @qa (During QA Gate)

Use checklist: `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md`
- Section 1: Verify no forbidden modifications
- Section 2: Verify only permitted modifications made
- Gate violation = Reject and return to @dev

### For @devops (During Deployment)

Pre-deployment validation:
1. Verify all Gates 1-3 passed
2. Run post-deploy tests (Gate 4)
3. Confirm version tracking and rollback readiness

---

## QUICK REFERENCE

| Constraint | Level | Files | Safe to Modify? |
|-----------|-------|-------|-----------------|
| Checkout structure | 🔴 CRITICAL | `checkout.tpl` | ❌ NO |
| Footer attribution | 🔴 CRITICAL | `footer*.tpl` | ❌ NO (visibility required) |
| Contact form | 🔴 CRITICAL | `contact*.tpl` | ❌ NO (structure) |
| Registration form | 🟡 HIGH | `register*.tpl` | ❌ NO (fields) |
| Newsletter form | 🟡 HIGH | `newsletter*.tpl` | ❌ NO (structure) |
| Logo/banners | ✅ GREEN | `*.tpl` | ✅ YES |
| Colors/fonts | ✅ GREEN | `*.scss`, `*.tpl` | ✅ YES |
| Layout spacing | ✅ GREEN | `*.scss`, `*.tpl` | ✅ YES (except checkout) |
| CSS file size | 🟡 HIGH | `style-critical.tpl` | ⚠️ YES (< 50 KB) |
| Custom JS | 🟡 HIGH | `*.js` | ⚠️ YES (no conflicts) |

---

## RELATED DOCUMENTATION

- **Standards Reference:** `NUVEMSHOP_FTP_STANDARDS.md`
- **Quick Reference:** `NUVEMSHOP_FTP_QUICK_REFERENCE.md`
- **Recovery Guide:** `.aiox-core/development/docs/NUVEMSHOP_FTP_VIOLATION_RECOVERY.md`
- **QA Checklist:** `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md`
- **Architecture:** `.aiox-core/NUVEMSHOP_FTP_ARCHITECTURE.md`

---

## ESCALATION

**Constraint violations?**
1. **@dev:** Flag violation, request guidance from @architect
2. **@architect:** Review violation, approve override or require fix
3. **@pm/@sm:** Track recurring violations for team training
4. **@aiox-master:** Document pattern for future reference

---

**AIOX Framework Level:** L3 (Project Configuration — Contextual Rules)
**Last Updated:** 2026-03-20
**Next Review:** 2026-06-20 (Q2 Architecture Review)
**Maintainer:** @architect
