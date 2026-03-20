# PATAGANG Nuvemshop - Deploy Changelog

## Version 1.1.1 - PDP Layout Fix
**Deploy Date:** 2026-03-20T03:46:27Z
**Git Commit:** 9502c44
**Status:** ✅ Deployed to Production

### Changes
- **Fix:** Remove empty space on product page right side
- **Area:** Product Detail Page (PDP) - Desktop Layout (≥992px)
- **Impact:** Eliminates 2% whitespace on right side of product information card

### Technical Details
| Component | Before | After | Change |
|-----------|--------|-------|--------|
| Image Column (col-lg-7) | 58% | 57% | -1% |
| Info Column (col-lg-5) | 40% | 43% | +3% |
| Total Coverage | 98% | 100% | ✅ Fills entire width |
| Responsive | Maintained | Maintained | ✓ No regression |
| Sticky Scroll | Maintained | Maintained | ✓ Functional |

### Root Cause
Layout regression introduced when reviews plugin (kreviews/Konfidency widget) was reactivated on product page. The PDP container's flexbox layout left 2% uncovered space.

### Files Modified
- `theme-deploy-corrigido/static/css/style-critical.tpl` - Column flex proportions adjusted
- `theme-deploy-corrigido/layouts/layout.tpl` - Deploy version metadata updated
- `theme-deploy-corrigido/VERSION.json` - Created (deployment manifest)
- `theme-deploy-corrigido/static/js/version-info.js` - Created (console version logger)

### Backup Location
```
backups/incremental/style-critical.tpl.backup-2026-03-20T03-46-27
```

### Testing
- ✅ CSS syntax validated
- ✅ Responsive breakpoints verified (768px, 992px, 1200px)
- ✅ Layout proportions calculated (57% + 43% = 100%)
- ✅ Sticky scroll functionality confirmed
- ✅ No breaking changes introduced

### Deployment
```bash
# Push executed
git push origin main
# Commit: bcb978d → 9502c44

# Version visible in:
1. Browser console: window.__PATAGANG_VERSION__
2. Page meta tag: <meta name="deploy-version" ... />
3. VERSION.json file
```

### Rollback (if needed)
```bash
git revert 9502c44
# Or restore backup:
cp backups/incremental/style-critical.tpl.backup-2026-03-20T03-46-27 theme-deploy-corrigido/static/css/style-critical.tpl
```

---

**Deployed by:** Gage (DevOps Agent)
**Environment:** Production (Nuvemshop)
**Next Review:** Monitor PDP on all breakpoints for rendering issues
