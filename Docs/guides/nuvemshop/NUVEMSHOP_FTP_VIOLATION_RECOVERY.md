# Nuvemshop FTP Violation Recovery Playbook

**Document Type:** Incident Response & Recovery Guide (L4)
**Status:** ACTIVE — For use during constraint violations
**Date:** 2026-03-20
**Author:** Aria (@architect)
**Scope:** Recovery procedures for FTP constraint violations

---

## Quick Reference: Violation Types & Severity

| Violation | Severity | Impact | Recovery Time | Escalation |
|-----------|----------|--------|---------------|------------|
| Checkout structure modified | CRITICAL | ⚠️ Payment broken | 5-15 min | @architect + @devops |
| Footer attribution hidden | CRITICAL | ⚠️ Terms breach | 10-30 min | @architect + legal review |
| Form integration broken | HIGH | 🔴 Feature down | 15-30 min | @architect + @dev |
| Performance degraded (CSS > 50KB) | MEDIUM | 📈 Slow pages | 20-60 min | @dev optimization |
| JavaScript error | MEDIUM | 🚨 Console error | 15-45 min | @dev debug + fix |

---

## SCENARIO 1: Checkout Structure Modified

### Severity: CRITICAL
**Impact:** Payment processing broken, store down, customers cannot checkout
**Detection:** Gate 2 blocks save OR Customer reports checkout broken
**Recovery Time:** 5-15 minutes (rollback) + 10 min (cache clear) = 15-25 minutes total

### Diagnosis

**Step 1: Identify what was modified**
```bash
cd ftp-deploy
git diff HEAD~1 -- theme-deploy-corrigido/static/css/checkout.scss
# OR
git diff HEAD~1 -- theme-deploy-corrigido/snipplets/**/checkout*.tpl
```

**Indicators:**
- [ ] CSS properties changed on `.checkout-form` or `.checkout-*` classes
- [ ] HTML form structure removed/modified
- [ ] Form field names changed
- [ ] Form action modified
- [ ] Checkout elements hidden (display:none, visibility:hidden, opacity:0)

### Immediate Action (Prevent Further Damage)

**Step 1: Stop serving the bad code**
```bash
# If violation detected BEFORE deployment:
# ❌ DO NOT commit or push
git reset --hard HEAD
git clean -fd

# If violation deployed to production:
# Immediately rollback
cd ftp-deploy
npm run rollback -- <previous_version_timestamp>
```

**Step 2: Verify rollback**
```javascript
// In browser console:
window.__PATAGANG_VERSION__
// Should show PREVIOUS version (not the broken one)

// Check that checkout works:
// 1. Go to product page
// 2. Add item to cart
// 3. Click checkout
// 4. Verify form loads (name, email, shipping, payment fields visible)
```

**Step 3: Clear cache**
```
Nuvemshop Admin:
1. Go to: https://www.nuvemshop.com.br/admin/v2/themes
2. Click ⋯ menu on active theme
3. Select "Limpar Cache"
4. Wait 3-5 minutes for propagation
5. Test checkout in incognito window (Ctrl+Shift+N)
```

### Root Cause Analysis

**Interview questions:**
- Q: What changes were attempted?
- A: `_______________________________________`

- Q: Were they tested locally?
- A: ☐ No (skip manual testing step)  ☐ Yes (how? _____)`

- Q: Did Gate 2 trigger?
- A: ☐ No (pattern missing - needs update)  ☐ Yes (user overrode)`

### Prevention: Update Validation

**If violation was NOT caught by Gate 2:**
1. Analyze the modification pattern
2. Add pattern to `.aiox-core/data/nuvemshop-patterns.yaml`
3. Test pattern with new test case
4. Increment pattern version
5. Escalate to @architect for approval

**Example:**
```yaml
# Before:
forbidden_patterns:
  - pattern: '\.checkout-form\s*\{[^}]*(display\s*:\s*none)'

# After: Add new pattern
forbidden_patterns:
  - pattern: '\.checkout-form\s*\{[^}]*(display\s*:\s*none)'
  - pattern: '\.checkout-form[^{]*{[^}]*(float|position|transform):'
    message: "❌ Checkout form structure modifications forbidden."
```

### Post-Incident Review

**Timeline:**
- T+0: Violation created (local development)
- T+?: Deployed to production
- T+X: Detected (Gate 2 pre-deploy OR customer report)
- T+X+15: Rollback complete
- T+X+25: Production validated

**Record:**
```yaml
incident:
  date: 2026-03-20
  type: checkout_structure_modified
  severity: CRITICAL
  detection_method: customer_report
  time_to_detection: "90 minutes"
  time_to_recovery: "25 minutes"

  root_cause: "Gate 2 pattern missing for this modification type"
  prevention: "Added pattern XYZ to nuvemshop-patterns.yaml"

  action_items:
    - "Update pattern registry"
    - "Review all existing custom CSS (patterns v1.0 → v1.1)"
    - "Re-run validation on previous 3 deployments"
    - "Team training: Checkout structure lock"
```

---

## SCENARIO 2: Footer Attribution Hidden

### Severity: CRITICAL
**Impact:** Terms of service breach, Nuvemshop may suspend store, legal implications
**Detection:** Gate 2 blocks save OR Manual audit discovers issue
**Recovery Time:** 10-30 minutes (fix) + potential legal review (1-5 days)

### Diagnosis

**Step 1: Identify how attribution was hidden**
```bash
git diff HEAD~1 -- theme-deploy-corrigido/layouts/layout.tpl
git diff HEAD~1 -- theme-deploy-corrigido/snipplets/footer/*.tpl
git diff HEAD~1 -- theme-deploy-corrigido/static/css/*.scss
```

**Indicators:**
- [ ] CSS `.store-attribution` has `display:none`
- [ ] CSS `.store-attribution` has `visibility:hidden`
- [ ] CSS `.store-attribution` has `opacity:0`
- [ ] CSS positions attribution off-screen (left: -9999px)
- [ ] HTML footer HTML completely removed
- [ ] Store name variable `{{ store.name }}` removed

### Immediate Action (Legal Priority)

**Step 1: Restore attribution**
```bash
# If violation detected before deployment:
git checkout HEAD -- theme-deploy-corrigido/
git clean -fd
# OR manually restore footer HTML/CSS

# If deployed to production:
cd ftp-deploy
npm run rollback -- <previous_version_timestamp>
```

**Step 2: Verify restoration**
```html
<!-- In production HTML, verify: -->
<footer>
  <div class="store-attribution">
    <p>© 2026 {{ store.name }} • Powered by Nuvemshop</p>
  </div>
</footer>

<!-- Check that it's visible: -->
<!-- CSS should NOT have display:none, visibility:hidden, opacity:0 -->
```

**Step 3: Clear cache (fast propagation)**
```
Nuvemshop Admin:
1. Theme Menu → Limpar Cache
2. Wait 3-5 minutes
3. Check footer visible in incognito window
```

**Step 4: Contact Nuvemshop Support (ASAP)**
```
Subject: Footer Attribution Restoration — Urgent

Body:
"We accidentally modified our theme to hide the store attribution footer.
We have immediately restored it to visibility.

Version: [your current version]
Visibility: [screenshot showing footer visible]
Timestamp: [restore time]

Please confirm:
1. No terms of service breach recorded
2. Account status remains active
3. No further action required

Thank you."
```

### Root Cause Analysis

**Prevention Questions:**
- Q: Why was attribution hidden?
- A: `_______________________________________`
  - Was it accidental CSS rule? (class name collision?)
  - Was it intentional design request? (escalate for legal review!)
  - Was it leftover from design iterations?

### Prevention: Strengthen Gate 2

**Update pattern sensitivity:**
```yaml
# Current pattern (v1.0):
forbidden_patterns:
  - pattern: '\.store-attribution\s*\{[^}]*display\s*:\s*none'

# Enhanced pattern (v1.1) - catch more variations:
forbidden_patterns:
  - pattern: '\.store-attribution\s*\{[^}]*(display\s*:\s*none|visibility\s*:\s*hidden|opacity\s*:\s*0)'
  - pattern: '\.store-attribution\s*\{[^}]*(left|right|top|bottom)\s*:\s*-\d+px'
  - pattern: 'store\.name'
    inverted: true
    message: "Attribution text removed from footer."
```

### Escalation to Legal

**If attribution was INTENTIONALLY hidden:**
1. Stop all work immediately
2. Escalate to @architect
3. @architect escalates to Product Owner
4. Schedule legal review with Nuvemshop compliance

**Q&A:**
- Q: What if client DEMANDS hidden attribution?
- A: Not allowed. Violates Nuvemshop terms. Document the request.

- Q: What if competitor does this?
- A: Report to Nuvemshop abuse team. They will suspend store.

### Post-Incident Review

**Record:**
```yaml
incident:
  date: 2026-03-20
  type: footer_attribution_hidden
  severity: CRITICAL
  detection_method: gate_2_pre_deployment

  root_cause: "CSS class naming collision (.store-attribution same as user rule)"
  prevention: "Add specificity rule to pattern registry"
  legal_review: "Completed - no breach recorded"

  improvements:
    - "Add footer attribution CSS override test"
    - "Educate team on terms of service"
    - "Add legal hold flag to checklist"
```

---

## SCENARIO 3: Form Integration Broken

### Severity: HIGH
**Impact:** Contact form, registration, or newsletter not functioning
**Detection:** Gate 2 pattern match OR User reports "form not working"
**Recovery Time:** 15-30 minutes (fix + deploy)

### Diagnosis

**Step 1: Identify which form broke**
```bash
git diff HEAD~1 -- theme-deploy-corrigido/snipplets/**/*form*.tpl
git diff HEAD~1 -- theme-deploy-corrigido/snipplets/**/*register*.tpl
git diff HEAD~1 -- theme-deploy-corrigido/snipplets/**/*newsletter*.tpl
git diff HEAD~1 -- theme-deploy-corrigido/snipplets/**/*contact*.tpl
```

**Indicators (per form):**
- [ ] Contact: Form action changed, fields renamed, method changed
- [ ] Registration: Email/password field removed, form action broken
- [ ] Newsletter: Subscription endpoint changed

### Immediate Action

**Step 1: Identify the problem**
```bash
# Look at the diff:
# BROKEN:
- <form action="/contact" method="POST">
+ <form action="/custom-handler" method="POST">  ❌ Action changed!

# BROKEN:
- <input name="email" required>
+ <input name="user_email" required>  ❌ Field renamed!

# BROKEN:
- <form method="POST">
+ <form method="GET">  ❌ Method changed!
```

**Step 2: Fix the issue**
```bash
# Option A: Quick fix in development
vim theme-deploy-corrigido/snipplets/contact.tpl
# Restore form action, field names, method
git diff  # verify only styling changes remain

# Option B: Rollback if too many changes
git checkout HEAD -- theme-deploy-corrigido/snipplets/contact.tpl
```

**Step 3: Re-deploy**
```bash
cd ftp-deploy
npm run deploy:critical  # Deploy only critical + fixed files
```

**Step 4: Verify in production**
```javascript
// Test contact form:
1. Navigate to /contact page
2. Fill form (name, email, message)
3. Click submit
4. Check for success message OR email confirmation

// Check console for errors (F12):
- Should be empty or only warnings
```

### Root Cause Analysis

**Questions:**
- Q: What was changed and why?
- A: `_______________________________________`

- Q: Was it intentional modification or copy-paste error?
- A: `_______________________________________`

- Q: Did the developer test the form locally?
- A: ☐ No  ☐ Yes (what tool?)

### Prevention: Update Gate 3 Checklist

**Add to manual review section:**
```yaml
Form Integration Checks:

For contact.tpl:
- [ ] Form action is "/contact" (unchanged)
- [ ] Form method is "POST" (unchanged)
- [ ] All fields exist: name, email, message
- [ ] Submit button text can be customized

For register.tpl:
- [ ] Form action is "/register" (unchanged)
- [ ] Email field is present
- [ ] Password field is present
- [ ] Agree to terms checkbox exists

For newsletter.tpl:
- [ ] Form submits to "/newsletter" endpoint
- [ ] Email field is required
- [ ] CAPTCHA (if present) not removed
```

### Post-Incident Review

**Record:**
```yaml
incident:
  date: 2026-03-20
  type: form_integration_broken
  form_affected: contact
  severity: HIGH

  root_cause: "Developer renamed 'email' field to 'user_email'"
  detection_method: post_deploy_manual_testing
  time_to_detection: "10 minutes"
  time_to_recovery: "12 minutes"

  prevention: "Add form field validator to Gate 1"
```

---

## SCENARIO 4: Performance Degradation (CSS File Size)

### Severity: MEDIUM
**Impact:** 📈 Pages load slowly, affects Core Web Vitals
**Detection:** Gate 1 file size check OR Performance monitoring
**Recovery Time:** 20-60 minutes (optimize)

### Diagnosis

**Step 1: Check file size**
```bash
wc -c theme-deploy-corrigido/static/css/style-critical.tpl
# Output: 52341 bytes = 52.3 KB (exceeds 50 KB limit)

# Or via npm:
npm run check:css-size
```

**Step 2: Identify what was added**
```bash
git diff HEAD~1 -- theme-deploy-corrigido/static/css/style-critical.tpl | head -100
# Look for:
# - Large new CSS rules
# - Duplicated selectors
# - Verbose vendor prefixes
```

### Immediate Action

**Step 1: Run CSS audit**
```bash
npm run audit:css
# Output:
# Unused selectors: 42
# Duplicated properties: 15
# Verbose rules: 8
# Opportunity: 12KB reduction possible
```

**Step 2: Optimize (choose approach)**

**Option A: Remove unused CSS**
```bash
npm run minify:css -- theme-deploy-corrigido/static/css/style-critical.tpl
# This removes unused selectors, duplicates, minifies

# New size: 45.2 KB ✅ Under budget
```

**Option B: Move to async CSS**
```bash
# Move non-critical styles to style-async.scss:
# FROM: style-critical.tpl (must be < 50 KB)
# TO: style-async.scss (can be any size, loads after DOM)

git mv {critical,async} rules  # Move 8 KB of rules
# New size: style-critical = 44.3 KB ✅
```

**Option C: Refactor CSS structure**
```scss
// BEFORE (verbose):
.header { color: #333; }
.header .logo { color: #333; }
.header .nav { color: #333; }

// AFTER (optimized):
.header,
.header .logo,
.header .nav {
  color: #333;
}

// Saves ~2 KB per rule group
```

**Step 3: Verify new size**
```bash
wc -c theme-deploy-corrigido/static/css/style-critical.tpl
# Output: 48734 bytes = 47.6 KB ✅ Under limit
```

**Step 4: Re-deploy and measure**
```bash
cd ftp-deploy
npm run deploy

# Measure Core Web Vitals:
# 1. Open production in Chrome
# 2. Open DevTools → Lighthouse
# 3. Run performance audit
# 4. Check: Largest Contentful Paint (LCP)
```

### Root Cause Analysis

**Questions:**
- Q: Why did CSS file grow?
- A: ☐ New design added  ☐ Copy-pasted rules  ☐ Debugging (forgot to remove)

- Q: Was file size checked before deployment?
- A: ☐ No (Gate 1 should have caught this)  ☐ Yes (error ignored)

### Prevention: Strengthen Gate 1

**Add size check to npm script:**
```javascript
// scripts/validate-css-size.js
const fs = require('fs');
const path = require('path');

const FILE = 'theme-deploy-corrigido/static/css/style-critical.tpl';
const MAX_SIZE = 50 * 1024;  // 50 KB

const size = fs.statSync(FILE).size;

if (size > MAX_SIZE) {
  console.error(`❌ CSS file (${(size/1024).toFixed(1)} KB) exceeds 50 KB limit`);
  console.error(`   Over budget by ${((size - MAX_SIZE)/1024).toFixed(1)} KB`);
  process.exit(1);
}

console.log(`✅ CSS file within budget: ${(size/1024).toFixed(1)} KB`);
```

**Add to pre-commit hook:**
```bash
# .git/hooks/pre-commit
npm run check:css-size || exit 1
```

### Post-Incident Review

**Record & Improvements:**
```yaml
incident:
  date: 2026-03-20
  type: performance_degradation_css
  severity: MEDIUM

  metrics:
    file_size_before: "52.3 KB"
    file_size_after: "47.6 KB"
    reduction: "4.7 KB (9%)"

  detection: "Gate 1 size check (pre-commit)"
  time_to_fix: "22 minutes"

  impact:
    lcp_before: "3.2 seconds"
    lcp_after: "2.1 seconds"
    improvement: "1.1 seconds (34%)"
```

---

## SCENARIO 5: JavaScript Error (Console Error)

### Severity: MEDIUM
**Impact:** 🚨 User sees red in console, possible feature breakage
**Detection:** Gate 1 syntax check OR User report/console inspection
**Recovery Time:** 15-45 minutes (debug + fix)

### Diagnosis

**Step 1: Locate the error**
```bash
# Method A: Check console
# Production:
# 1. Open https://patagang.lojavirtualnuvem.com.br
# 2. F12 → Console tab
# 3. Look for red text with error message

# Method B: Check git history
git diff HEAD~1 -- theme-deploy-corrigido/static/js/store.js.tpl

# Look for:
# - Missing semicolons
# - Unclosed brackets/parentheses
# - Undefined variables
# - Infinite loops
```

**Indicators:**
```
❌ Uncaught ReferenceError: $ is not defined
❌ Uncaught TypeError: Cannot read property 'length' of undefined
❌ Uncaught SyntaxError: Unexpected token
❌ Infinite loop (page freezes)
```

### Immediate Action

**Step 1: Understand the error**
```javascript
// Example error from console:
// Uncaught TypeError: Cannot read property 'addEventListener' of null
//   at store.js.tpl:42

// This means: Something you're trying to attach a listener to doesn't exist.
// Common causes:
// - Selector too specific: document.querySelector('.header .new-element')
// - Element loaded after script runs: Check load order
// - Typo in selector: '.hedaer' instead of '.header'
```

**Step 2: Fix locally**
```bash
# Open the file and line number from error:
vim theme-deploy-corrigido/static/js/store.js.tpl +42

# Common fixes:
# Add null check:
const element = document.querySelector('.selector');
if (element) {
  element.addEventListener('click', callback);
}

# Use optional chaining (modern):
document.querySelector('.selector')?.addEventListener('click', callback);
```

**Step 3: Test locally**
```bash
# Build/preview locally
npm run dev

# Open in browser, check console (F12):
# - Should be empty (or only warnings)
# - No red errors
```

**Step 4: Re-deploy**
```bash
cd ftp-deploy
npm run deploy:critical
```

**Step 5: Verify in production**
```javascript
// In console:
console.error('Checking...')
// Should see "Checking..." in console, no red errors
```

### Root Cause Analysis

**Code Review:**
```javascript
// ❌ BROKEN:
document.querySelector('.cart-button').addEventListener('click', () => {
  // If .cart-button doesn't exist, this throws error
  console.log('Cart clicked');
});

// ✅ FIXED:
const cartButton = document.querySelector('.cart-button');
if (cartButton) {
  cartButton.addEventListener('click', () => {
    console.log('Cart clicked');
  });
}

// ✅ MODERN (optional chaining):
document.querySelector('.cart-button')?.addEventListener('click', () => {
  console.log('Cart clicked');
});
```

### Prevention: Strengthen Gate 1

**Add JavaScript linting:**
```bash
npm install --save-dev jshint

# .jshintrc config:
{
  "boss": true,      // Allow assignment in if statements
  "curly": false,    // Allow omitting {} for single statements
  "eqeqeq": true,    // Require === instead of ==
  "eqnull": true,    // Allow x == null
  "esversion": 6,    // ES6 support
  "strict": false,   // Allow non-strict mode
  "undef": true,     // Check undefined variables
  "unused": true     // Check unused variables
}

# Run in pre-commit:
jshint theme-deploy-corrigido/static/js/store.js.tpl || exit 1
```

**Add to Gate 1 npm script:**
```bash
npm run validate:js
# Output:
# ❌ store.js.tpl line 42: Unknown variable '$'
# ❌ store.js.tpl line 88: Unreachable code
```

### Post-Incident Review

**Record:**
```yaml
incident:
  date: 2026-03-20
  type: javascript_error
  severity: MEDIUM

  error: "TypeError: Cannot read property 'addEventListener' of null"
  location: "store.js.tpl:42"
  root_cause: "Selector '.cart-button' doesn't exist in DOM"

  fix: "Added null check before addEventListener"
  detection: "User report → console inspection"
  time_to_fix: "18 minutes"

  prevention: "Enable JSHint in pre-commit hook"
```

---

## General Escalation Rules

### When to Escalate (Contact @architect)

**Escalate if:**
1. Violation type not in this playbook
2. Multiple violations in same deployment
3. Violation affected production for > 30 minutes
4. Customer impact occurred (payments, orders affected)
5. Unclear if violation is intentional or accidental
6. Gate 2 pattern seems wrong (false positive)

**How to escalate:**
```
1. Document incident (use template above)
2. Gather evidence (git diff, screenshots, metrics)
3. Send to @architect with:
   - What happened
   - When (timestamp)
   - Impact (customers affected?)
   - Recovery action taken
   - Root cause (if known)
   - Proposed prevention
```

### When to Escalate (Contact @devops)

**Escalate if:**
1. Rollback needed (failed deployment)
2. Cache clear not working (propagation issue)
3. FTP connection failing
4. Need to deploy emergency hotfix
5. Production validation cannot be completed

**How to escalate:**
```
@devops, need deployment support:
- Issue: [brief description]
- Severity: CRITICAL | HIGH | MEDIUM
- Affected: [file/system]
- Action needed: [rollback | hotfix | cache clear | other]
```

---

## Post-Incident Checklist

**After ANY violation (caught or deployed):**

```
☐ Root cause identified
☐ Fix implemented and tested
☐ Deployed (if violation reached production)
☐ Production validated
☐ Gate patterns updated (if false negative)
☐ Checklist updated (if missed)
☐ Team notified of incident
☐ Incident log entry created
☐ Lessons learned documented
☐ Calendar entry for pattern review (30 days)
☐ No customer communication needed (if yes, who to contact?)
```

---

## Quick Reference Card (Clipboard Copy)

```
VIOLATION QUICK FIXES
═════════════════════════════════════════════════════════════

Checkout broken:
1. git reset --hard HEAD
2. cd ftp-deploy && npm run rollback -- [timestamp]
3. Check version: window.__PATAGANG_VERSION__
4. Clear cache (Admin → Temas → Limpar Cache)

Footer hidden:
1. Fix footer HTML/CSS
2. Deploy with: npm run deploy:critical
3. Verify in incognito window
4. Contact Nuvemshop support if hidden before fix

Form broken:
1. Restore form action/fields: git checkout HEAD -- snipplets/
2. Deploy: npm run deploy:critical
3. Test form submission
4. Check console (F12) for errors

CSS too large (> 50 KB):
1. Run audit: npm run audit:css
2. Minify: npm run minify:css
3. Check size: wc -c static/css/style-critical.tpl
4. Deploy: npm run deploy

JavaScript error:
1. Find error in console (F12)
2. Add null check or fix syntax
3. Test locally: npm run dev
4. Deploy: npm run deploy:critical
5. Verify console clean (F12)

═════════════════════════════════════════════════════════════
```

---

**Document Version:** 1.0.0
**Last Updated:** 2026-03-20
**Next Review:** 2026-06-20
**Maintainer:** @architect (Aria)
