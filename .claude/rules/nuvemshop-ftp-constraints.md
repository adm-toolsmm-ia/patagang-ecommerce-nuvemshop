# Nuvemshop FTP Constraints — CRITICAL Validation Rule

**Type:** Contextual Auto-Load
**Trigger:** Edit `theme-deploy-corrigido/**/*.{tpl,scss,js}`
**Severity:** CRITICAL
**Authority:** @architect

---

## CONSTRAINT MATRIX — 8/8 CHECKS (MANDATORY)

| # | Constraint | Level | Trigger | Safe to Modify? |
|---|-----------|-------|---------|-----------------|
| 1 | **Checkout Structure** | 🔴 CRITICAL | **/checkout.tpl modified | ❌ NO — forms managed by platform |
| 2 | **Footer Attribution** | 🔴 CRITICAL | footer hidden/removed | ❌ NO — Terms of Service requirement |
| 3 | **Contact Form** | 🔴 CRITICAL | contact*.tpl structure changed | ❌ NO — backend integration |
| 4 | **Registration Form** | 🟡 HIGH | register*.tpl fields removed | ❌ NO — customer database sync |
| 5 | **Newsletter Form** | 🟡 HIGH | newsletter*.tpl submission changed | ❌ NO — marketing automation |
| 6 | **JavaScript Safety** | 🟡 HIGH | window.Nuvemshop.* overridden | ❌ NO — breaks platform functions |
| 7 | **CSS Performance** | 🟡 HIGH | style-critical.tpl > 50 KB | ⚠️ YES (< 50 KB limit) |
| 8 | **Auto-Generated Files** | 🟠 MEDIUM | sitemap.xml, robots.txt edited | ❌ NO — regenerated daily |

---

## QUICK FIX REFERENCE

### Constraint #1: Checkout
- ❌ Do NOT modify form fields, structure, submission
- ✅ DO modify: colors, spacing, fonts (CSS only)
- If violated: Revert `checkout.tpl` to version control

### Constraint #2: Footer
- ❌ Do NOT hide/remove Nuvemshop attribution
- ❌ Do NOT use: `display: none`, `opacity: 0`, `visibility: hidden`
- ✅ DO ensure: Text visible in footer area

### Constraint #3-5: Forms (Contact, Registration, Newsletter)
- ❌ Do NOT remove/reorder fields
- ❌ Do NOT change submission endpoint
- ✅ DO modify: styling, placeholder text, validation messages

### Constraint #6: JavaScript
- ❌ Do NOT override: `window.Nuvemshop.*`, `$`, global functions
- ✅ DO use: IIFEs, namespacing, event listeners
- Example safe: `(function() { /* scoped code */ })();`

### Constraint #7: CSS Size
- ⚠️ WARN at: 45 KB (review before proceed)
- ❌ FAIL at: > 50 KB (must reduce)
- Check: `wc -c theme-deploy-corrigido/static/css/style-critical.tpl`

### Constraint #8: Auto-Generated
- ❌ Do NOT edit: `sitemap.xml`, `rss.xml`, `robots.txt`
- ✅ DO configure: Via Nuvemshop Admin panel instead

---

## GATE VIOLATIONS

### 🛑 BLOCKING (Auto-Fail)
- Checkout structure modifications
- Footer attribution removal/hiding
- Critical form field removals
- Nuvemshop function overrides

**Override:** Requires @architect approval + code comment: `// @architect: override-requested: {reason}`

### ⚠️ WARNING (Auto-Flag)
- CSS approaching 50 KB (flag at 45 KB)
- New external JS dependencies
- Performance concerns detected

**Action:** Review + @qa approval before proceed

---

## ESCALATION

1. Flag violation → contact @architect
2. If override needed → add comment + commit message notation
3. If pattern recurring → report to @pm for team training

---

## DETAILED REFERENCE

For complete constraint descriptions, safe/unsafe examples, and violation recovery steps:
→ `.aiox-core/development/docs/NUVEMSHOP_FTP_REFERENCE.md`

---

**Version:** 2.0 (Optimized 2026-03-28)
**Status:** ✅ ACTIVE (auto-load on theme edit)
**Maintained by:** @architect
