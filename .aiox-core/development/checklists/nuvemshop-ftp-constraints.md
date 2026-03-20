# Nuvemshop FTP Constraints — Quality Assurance Gate Checklist

**Document Type:** AIOX Task Checklist (Gate 3 Validation)
**Version:** 1.0
**Date Created:** 2026-03-20
**Authority:** @architect + @analyst consolidated research
**Status:** ACTIVE

---

## ✅ PRE-DEPLOYMENT VALIDATION CHECKLIST

**Context:** This checklist validates theme modifications BEFORE deployment to FTP. Run during @qa gate in Story Development Cycle (Phase 4).

**Time Estimate:** 10-15 minutes
**Severity on Failure:** CRITICAL — Blocks deployment until all critical items pass

---

## GATE 3: MANUAL REVIEW VALIDATION

### Section 1: Forbidden Modifications (CRITICAL)
> **Note:** These items cannot be altered in Nuvemshop FTP under any circumstances.

**Checkout Structure & Forms:**
- [ ] **VERIFY:** No modifications to checkout page layout
  - Check: `theme-deploy-corrigido/layouts/checkout.tpl` — file should be UNTOUCHED
  - Red flags: form field removals, reordering, structural changes
  - Severity: CRITICAL — Will break payment processing

- [ ] **VERIFY:** No contact/registration/newsletter form field additions/removals
  - Check: Search for `<form` tags in modified files
  - Red flags: new `<input>`, `<select>`, `<textarea>` in form contexts
  - Severity: CRITICAL — Backend integration will fail

- [ ] **VERIFY:** Footer attribution contains Nuvemshop store name
  - Check: `theme-deploy-corrigido/snipplets/footer/footer.tpl`
  - Red flags: hidden footer, missing store name, CSS display:none on attribution
  - Severity: CRITICAL — Terms of service violation

- [ ] **VERIFY:** Sitemap and RSS feeds NOT modified
  - Check: No edits to `sitemap.xml`, `rss.xml` (if present)
  - Severity: CRITICAL — Auto-generated, modifications will be overwritten

---

### Section 2: Permitted Modifications (SAFE TO MODIFY)

**Visual & Styling (GREEN):**
- [ ] **REVIEW:** All logo/banner changes use official brand assets or approved originals
  - Quality check: Images are optimized (< 100KB each)
  - Accessibility: Logo has proper alt text in templates

- [ ] **REVIEW:** Background images are properly referenced and optimized
  - Check file sizes: individual images < 50KB recommended
  - Verify paths: Use relative paths `../static/images/...`

- [ ] **REVIEW:** Font changes maintain readability and load time
  - Verify: No new font files added unless justified
  - Check: Font-display strategy used (swap/fallback)

- [ ] **REVIEW:** Navigation positioning changes don't break responsive layout
  - Test: Mobile view still works (< 375px width)
  - Verify: Touch targets still adequate (> 44x44px)

**Template Files (GREEN):**
- [ ] **REVIEW:** All `.tpl` file changes use valid Liquid template syntax
  - Check: No breaking Liquid syntax errors
  - Verify: All variables referenced exist in Nuvemshop context

- [ ] **REVIEW:** Custom HTML additions are semantic and accessible
  - Validate: No broken HTML structure
  - Check: ARIA labels on interactive elements

- [ ] **REVIEW:** Added snipplets don't introduce major performance impact
  - Estimate: Each new HTTP request adds ~50-200ms
  - Flag if: More than 3 new external requests

**Stylesheets (GREEN with conditions):**
- [ ] **REVIEW:** CSS file size remains under 50KB (critical budget)
  - Measure: Run `wc -c theme-deploy-corrigido/static/css/style-critical.tpl`
  - Action if exceeded: Minify, remove unused rules, or split into separate file

- [ ] **REVIEW:** No !important overrides (should use CSS specificity instead)
  - Count: Search for `!important` — should be 0-2 max (pre-existing)
  - Action: Refactor selectors to improve specificity

- [ ] **REVIEW:** Color values use consistent format (hex or RGB, not both)
  - Pattern check: All colors in format `#RRGGBB` or `rgb(r,g,b)`
  - Consistency: Match existing color definitions in `style-colors.scss.tpl`

**JavaScript (GREEN with safety checks):**
- [ ] **REVIEW:** Custom JavaScript doesn't conflict with Nuvemshop libraries
  - Check: No jQuery conflicts, no global variable overrides
  - Verify: No overrides of Nuvemshop's JS functions

- [ ] **REVIEW:** Added JS code uses error handling and graceful fallbacks
  - Pattern: All fetches/AJAX calls have try-catch or `.catch()`
  - No silent failures: Console errors logged for debugging

- [ ] **REVIEW:** JavaScript bundle size reasonable (< 100KB for custom code)
  - Estimate: Minified custom JS should stay under 100KB
  - Action if exceeded: Consider lazy loading or code splitting

---

### Section 3: Performance & Quality Standards

**CSS & Bundle Optimization:**
- [ ] **VERIFY:** `style-critical.tpl` is inlined in `<head>` (not loaded async)
  - Reason: Critical CSS must block rendering for above-fold content

- [ ] **VERIFY:** All images in templates have explicit dimensions (width/height)
  - Prevents layout shift (CLS score stays good)

- [ ] **VERIFY:** No large blocking JavaScript in `<head>`
  - Policy: Defer all non-critical JS to end of `<body>`

- [ ] **VERIFY:** Cache-busting version applied
  - Check: `window.__PATAGANG_VERSION__` referenced in assets
  - Format: Should match VERSION file in ftp-deploy/

**Code Quality:**
- [ ] **REVIEW:** All modified templates follow project naming conventions
  - Pattern: Filenames are lowercase, hyphens (not underscores)
  - Example: `header-advertising.tpl` ✓, `HeaderAdvertising.tpl` ✗

- [ ] **REVIEW:** Comments added for non-obvious code changes
  - Policy: Complex logic (>5 lines) has explanatory comments
  - Example: Custom discount calculations, API integrations

- [ ] **REVIEW:** No hardcoded values that should be configurable
  - Flag: Prices, email addresses, URLs should use Nuvemshop variables
  - Check: All use `{{ settings.* }}` or `{{ store.* }}` Nuvemshop context

---

### Section 4: Backward Compatibility & Rollback Safety

**Version Tracking:**
- [ ] **VERIFY:** VERSION file updated
  - Location: `ftp-deploy/VERSION`
  - Format: Semantic versioning (e.g., `v1.1.3`)
  - Timestamp: DEPLOY_REPORT_yyyyMMddHHmmss.txt created

- [ ] **VERIFY:** Previous version can be recovered < 5 minutes
  - Confirm: Backup exists with prior version files
  - Test plan documented for rollback scenario

- [ ] **VERIFY:** CHANGELOG.md entry created
  - Format: Date, version, summary of changes
  - Detail level: Enough for support team to understand rollback impact

**Testing Documentation:**
- [ ] **VERIFY:** Browser compatibility tested (minimum: latest Chrome, Firefox, Safari, Edge)
  - Mobile: iOS Safari (14+), Chrome Android
  - Desktop: Chrome 90+, Firefox 88+, Safari 14+, Edge 90+

- [ ] **VERIFY:** Mobile responsiveness validated
  - Devices tested: iPhone 12, Samsung Galaxy S21, Tablet (iPad/Tab S)
  - No horizontal scroll at 375px-1920px viewport range

- [ ] **VERIFY:** Form submissions tested (if checkout/forms touched)
  - Test: Submit sample order, verify success notification
  - Verify: No console errors during interaction

- [ ] **VERIFY:** Page load performance acceptable
  - Metric: First Contentful Paint < 3s
  - Metric: Largest Contentful Paint < 5s
  - Tool: Lighthouse or PageSpeed Insights (mobile score ≥ 90)

---

### Section 5: Accessibility & Legal Compliance

**Accessibility (WCAG 2.1 Level AA):**
- [ ] **VERIFY:** All images have descriptive alt text
  - Example: `alt="Product carousel showing seasonal collection"` ✓
  - Not: `alt="image"` or `alt=""` (unless purely decorative)

- [ ] **VERIFY:** Color contrast meets WCAG AA standards
  - Ratio: Text > 4.5:1, Large text > 3:1
  - Tool: WebAIM Contrast Checker or Chrome DevTools

- [ ] **VERIFY:** Keyboard navigation works (Tab, Enter, Escape)
  - Test: Navigate entire page using Tab key only
  - Verify: Focus indicator visible on all interactive elements

- [ ] **VERIFY:** Form labels properly associated with inputs
  - Pattern: `<label for="input-id">` with matching `<input id="input-id">`

**Legal & Terms:**
- [ ] **VERIFY:** Footer attribution visible and unmodified
  - Requirement: Nuvemshop terms mandate visible store attribution
  - Check: No `display: none`, `opacity: 0`, or hidden sections

- [ ] **VERIFY:** No prohibited modifications per Nuvemshop TOS
  - Reference: See NUVEMSHOP_FTP_STANDARDS.md section "Absolutely Forbidden"

- [ ] **VERIFY:** No customer data collection modifications
  - Flag: No new tracking scripts added to checkout
  - Verify: Any analytics additions comply with privacy policy

---

### Section 6: Security Checks

**Code Injection Prevention:**
- [ ] **VERIFY:** No SQL injection vectors (if any backend integration)
  - Check: All user input is escaped using Nuvemshop sanitization

- [ ] **VERIFY:** No XSS vectors in custom JavaScript
  - Pattern: Use `.textContent` not `.innerHTML` for user content
  - Verify: Template variables are auto-escaped by Liquid

- [ ] **VERIFY:** No sensitive data in frontend code
  - Flag: API keys, passwords, admin URLs should never appear in CSS/JS
  - Check: Run grep for common patterns (API_KEY, password, token)

**Dependency Safety:**
- [ ] **VERIFY:** No new external dependencies added without approval
  - Policy: New CDN resources require @architect review
  - Document: Justify third-party inclusion (performance impact vs benefit)

---

## GATE 4: POST-DEPLOYMENT VALIDATION (Run by @devops)

**⚠️ Note:** These steps execute AFTER FTP deployment. Team should verify before closing story.

### Immediate Post-Deploy (within 5 minutes)
- [ ] Cache cleared in Nuvemshop Admin → Temas → Limpar Cache
- [ ] Homepage loads without errors (check browser console)
- [ ] All images display correctly
- [ ] Navigation links work
- [ ] No 404 errors for CSS/JS files

### Browser Testing (15-30 minutes)
- [ ] Desktop: Chrome, Firefox, Safari, Edge (latest versions)
- [ ] Mobile: iOS Safari, Chrome Android
- [ ] No JavaScript console errors
- [ ] No CSS layout issues (layout shifts, overlapping elements)
- [ ] All forms are functional (if modified)

### Version Verification
- [ ] `window.__PATAGANG_VERSION__` matches deployed VERSION file
- [ ] Network tab shows correct cache-busting version in asset URLs
- [ ] Lighthouse Accessibility score ≥ 85

### Rollback Readiness
- [ ] Previous version backup confirmed to exist
- [ ] Rollback procedure documented and tested (< 5 min recovery time)
- [ ] Team on standby for 1 hour post-deployment

---

## FAILURE HANDLING & ESCALATION

**Critical Items Failed (CHECKOUT/FOOTER/FORMS):**
1. **Immediate Action:** Do NOT deploy — escalate to @architect
2. **Communication:** Notify @pm and @sm of blocker
3. **Resolution:** @architect + @dev review violations, correct, re-test
4. **Documentation:** Log in INCIDENT_LOG.md for future training

**Major Items Failed (PERFORMANCE/SECURITY):**
1. **Action:** Return to @dev with specific feedback
2. **Timeline:** Re-test within 24 hours
3. **Documentation:** Update checklist if pattern recurs

**Minor Items Failed (FORMATTING/COMMENTS):**
1. **Action:** Document as "known acceptable" with justification
2. **Timeline:** Can proceed to deployment with approval
3. **Documentation:** Note in DEPLOY_REPORT_*.txt

---

## APPROVAL & SIGN-OFF

**QA Gate 3 Complete When:**
- ✅ All CRITICAL items pass
- ✅ All MAJOR items pass or documented exception
- ✅ Testing documented with evidence (screenshots/logs)
- ✅ Approval signature below

**QA Reviewer Signature:**
```
Reviewed by: _________________ (Name)
Date: _________________ (YYYY-MM-DD)
Status: ✅ APPROVED | ⚠️ APPROVED WITH EXCEPTIONS | ❌ REJECTED
```

**Exceptions Documented (if applicable):**
```
1. Item: _________________ Reason: _________________ Approved by: _________________
2. Item: _________________ Reason: _________________ Approved by: _________________
```

---

## REFERENCE DOCUMENTS

- **Primary Reference:** `.aiox-core/development/docs/NUVEMSHOP_FTP_STANDARDS.md`
- **Quick Reference:** `NUVEMSHOP_FTP_QUICK_REFERENCE.md`
- **Recovery Procedures:** `.aiox-core/development/docs/NUVEMSHOP_FTP_VIOLATION_RECOVERY.md`
- **Architecture:** `.aiox-core/NUVEMSHOP_FTP_ARCHITECTURE.md`

---

**AIOX Framework Level:** L2 (Framework Templates — Read-Only Core)
**Last Updated:** 2026-03-20
**Next Review:** 2026-06-20 (Q2 Architecture Review)
