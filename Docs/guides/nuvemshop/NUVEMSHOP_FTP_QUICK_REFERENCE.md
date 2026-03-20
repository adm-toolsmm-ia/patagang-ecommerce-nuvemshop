# Nuvemshop FTP Quick Reference - EXECUTIVE SUMMARY

**Status:** Quick lookup guide for FTP customization rules
**Date:** 2026-03-20
**Full Documentation:** `.aiox-core/development/docs/NUVEMSHOP_FTP_STANDARDS.md`

---

## 🟢 WHAT YOU CAN MODIFY VIA FTP

### Files & Templates
```
✅ layouts/layout.tpl              Master layout template
✅ product.tpl                     Product page template
✅ snipplets/**/*.tpl              All component templates
✅ static/css/style-critical.tpl   Critical CSS
✅ static/css/style-colors.scss    Color definitions
✅ static/js/store.js.tpl          Custom JavaScript
✅ static/images/                  All custom images
```

### Visual Elements
```
✅ Logos & watermarks
✅ Banners & backgrounds
✅ Navigation menus
✅ Product page layout
✅ Font families & sizes
✅ Button text & styling
✅ Product installment display
✅ Search bar customization
✅ Page colors (all except checkout)
```

### Advanced
```
✅ Custom CSS for pages
✅ Custom JavaScript functions
✅ Template conditional logic
✅ URL redirects (via meta refresh)
✅ Product-specific customizations
```

---

## 🔴 WHAT YOU CANNOT MODIFY VIA FTP

### Strictly Forbidden
```
❌ Checkout page structure
❌ Checkout form fields
❌ Contact forms (backend integration)
❌ Customer registration/login (backend integration)
❌ Newsletter signup forms
❌ Footer Nuvemshop attribution
❌ Sitemap generation
❌ RSS feeds
❌ IP/Email blocking rules
```

### Limited Modification
```
⚠️ Checkout colors ONLY (structure locked)
⚠️ Form styling ONLY (fields locked)
```

---

## ⚡ CRITICAL CONSTRAINT

### Automatic Updates STOP When You Access FTP

```
🚨 "Ao abrir o FTP (código-fonte), a loja não receberá
   as atualizações de melhorias automaticamente."

Translation: When you access FTP, your store NO LONGER receives
            automatic platform updates from Nuvemshop.
```

**Implications:**
- Nuvemshop bug fixes don't apply automatically
- Platform improvements must be manually merged
- Support limited to "only if platform has errors"
- You must monitor release notes yourself

**Mitigation:**
- Use version tracking (in Patagang: `VERSIONING_WORKFLOW.md`)
- Create backups before modifications
- Document all changes clearly
- Plan for manual updates

---

## 📁 FILE STRUCTURE

### Key Directories

```
theme-deploy-corrigido/
├── layouts/layout.tpl              ← Master layout
├── product.tpl                     ← Product page
├── snipplets/                      ← Components
│   ├── header/
│   ├── product/
│   ├── navigation/
│   ├── footer/
│   └── [others]/
├── static/
│   ├── css/
│   │   ├── style-critical.tpl     ← Above-fold CSS
│   │   ├── style-colors.scss.tpl  ← Colors
│   │   └── checkout.scss.tpl      ← Checkout (colors only!)
│   ├── js/
│   │   ├── store.js.tpl           ← Custom logic
│   │   └── external*.js.tpl       ← Dependencies
│   └── images/                    ← Custom images
└── VERSION.json                    ← Version metadata
```

### External Libraries (Pre-installed)
- Bootstrap v4.1.3 (CSS framework)
- Swiper 4.4.2 (carousel)
- jQuery 1.11.1 (JavaScript)

---

## ✅ PATAGANG DEPLOYMENT CHECKLIST

Before every FTP deploy:

```
1. ☐ Sync version:
   cd ftp-deploy/
   node sync-version.js X.X.X

2. ☐ All modified .tpl files use correct syntax

3. ☐ No checkout form fields removed or moved

4. ☐ No footer attribution hidden

5. ☐ CSS critical file < 50KB

6. ☐ External dependencies unchanged

7. ☐ JavaScript has no console errors (warnings OK)

8. ☐ Backup created automatically

9. ☐ Run deploy:
   npm run deploy:critical   (recommended for safety)
   OR
   npm run deploy            (full deploy)

10. ☐ Post-deploy validation:
    - Clear Nuvemshop cache: Admin → Temas → Menu (⋯) → Limpar Cache
    - Wait 3-5 minutes
    - Check version in console: window.__PATAGANG_VERSION__.version
    - Test on multiple browsers & devices
```

---

## 🎯 DEPLOYMENT COMMANDS

### Safe Deployment (Recommended)
```bash
# Deploy only critical files (layout + version)
npm run deploy:critical
```

### Full Deployment
```bash
# Deploy all modified files
npm run deploy
```

### Rollback
```bash
# Revert to previous version
npm run rollback
```

---

## 🐛 TROUBLESHOOTING QUICK FIXES

| Problem | Solution |
|---------|----------|
| Version shows old number | Clear cache: Admin → Temas → Limpar Cache (wait 3-5 min) |
| CSS not applying | Check DevTools for conflicts; use !important to test |
| Images not showing | Verify uploaded to `/static/images/`; use full URL |
| Checkout broken | **ROLLBACK IMMEDIATELY** - restore from backup |
| JavaScript errors | Check `external.js.tpl` and `store.js.tpl` for syntax |

---

## 📞 ESCALATION MATRIX

| Issue | Responsible | Action |
|-------|-------------|--------|
| FTP deployment | @devops | Execute deployment task |
| Version management | @devops | Sync version before deploy |
| Theme customization | @dev | Modify .tpl files |
| QA validation | @qa | Test post-deployment |
| Template questions | @architect | Design decisions |
| Nuvemshop limits | Support research needed | Consult official docs |

---

## 🔗 QUICK LINKS

| Resource | Path |
|----------|------|
| Full Standards | `.aiox-core/development/docs/NUVEMSHOP_FTP_STANDARDS.md` |
| Deployment Guide | `.aiox-core/development/docs/FTP_DEPLOY_GUIDE.md` |
| Deployment Task | `.aiox-core/development/tasks/deploy-ftp-standard.md` |
| Versioning System | `VERSIONING_WORKFLOW.md` |
| Checklist | `.aiox-core/development/checklists/ftp-deploy-checklist.md` |
| Workflow Definition | `.aiox-core/development/workflows/ftp-deployment.yaml` |

---

## 💡 GOLDEN RULES

1. **Never modify checkout structure** - It breaks payment/shipping
2. **Always sync version before deploy** - Keeps tracking accurate
3. **Always backup before modifications** - Recovery is fast
4. **Always clear cache after deploy** - Changes won't show otherwise
5. **Always test before production** - Catch issues early
6. **Never hide footer attribution** - Violates Nuvemshop terms
7. **Always document changes** - Future devs will thank you

---

## 📊 PATAGANG CURRENT STATE

**Last Version:** 1.1.3 (2026-03-20)
**Files Modified:** 5
**Critical Files:** 2 (layout.tpl, version-info.js)
**Deployment Method:** `npm run deploy:critical`
**Update Status:** Using FTP (manual updates required)

---

**Quick Reference v1.0 | Updated 2026-03-20 | See full docs for details**
