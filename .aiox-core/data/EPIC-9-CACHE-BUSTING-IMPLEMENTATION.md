# EPIC 9 Phase A — Cache Busting Implementation

**Status:** ✅ COMPLETED & DEPLOYED
**Date Created:** 2026-03-26
**Implemented:** v1.5.141 → v1.5.145
**Authority:** @dev (implementation) + @aiox-master (documentation)
**Related:** CSS Refactoring Safety Pattern, Nuvemshop Cache Problem Resolution

---

## 🎯 **PROBLEM STATEMENT**

### Issue
After deploying CSS changes (banner background: transparent), the loja still displayed old cached styles (banner remained yellow instead of transparent).

### Root Cause
**Nuvemshop Multi-Layer Caching:**
- Browser cache (local)
- CDN cache (Akamai/CloudFlare)
- Nuvemshop server cache

CSS files without version query strings were served from cache indefinitely, preventing style updates.

### Impact
- Visual changes not reflected in production
- Users saw outdated styling
- Required manual cache clearing (Ctrl+Shift+Delete)

---

## ✅ **SOLUTION: AUTOMATIC CACHE BUSTING**

### Design Decision
Inject automatic `?v=VERSION` query string into all CSS links during deployment Phase 5 (before FTP upload).

**Why this approach:**
- ✅ Automatic (no manual intervention)
- ✅ Foolproof (every deploy gets new version)
- ✅ Browser-native (query strings force re-fetch)
- ✅ CDN-compatible (Akamai/CloudFlare recognize new URLs)
- ✅ Nuvemshop-compatible (no backend changes needed)

---

## 🔧 **IMPLEMENTATION DETAILS**

### Function: `injectVersionIntoCSSLinks(layoutPath, version)`

**Location:** `ftp-deploy/deploy.js` (lines ~380-430)

**Functionality:**

```javascript
/**
 * Injeta ou atualiza ?v=VERSION nos links CSS para forçar cache busting
 *
 * Regex 1: Atualiza versão antiga
 *   Encontra: href="URL?v=1.5.141"
 *   Substitui: href="URL?v=1.5.145"
 *
 * Regex 2: Injeta versão em links sem versão
 *   Encontra: href="URL.scss.tpl"
 *   Substitui: href="URL.scss.tpl?v=1.5.145"
 */
```

### Integration Point: Phase 5 (Deploy to FTP)

```
PHASE 5: Deploy para FTP
  └─ injectVersionIntoCSSLinks(layoutPath, newVersion)  [NEW]
  └─ Upload modified files to FTP
  └─ Validate checksums on FTP
```

**Called from:** Line 527 in main()

---

## 📋 **DEPLOYMENT TIMELINE**

### v1.5.141 — Initial Implementation
```
✅ Implemented cache busting function
✅ Injected ?v=1.5.141 into 3 CSS links
✅ Deployed to production
⚠️  Regex issue discovered (extensions duplicated)
```

**Issue Found:** Regex captured groups incorrectly
- `style-colors.scss.tpl` became `style-colors.scssscss.tpl`
- URLs returned 404, causing CSS loading failures
- Pages lost formatting (reported by Gabriel)

---

### v1.5.142 — Banner Transparency Change
```
✅ Added background-color: transparent to .section-advertising
✅ Attempted cache busting (with broken regex)
❌ CSS URLs broken: 404 errors
❌ Formatting lost in /account/login/ and other pages
```

---

### v1.5.143 — Test Deployment
```
✅ Tested cache busting logic
✅ No changes needed (layout.tpl not modified)
ℹ️  Revealed: regex needs fixing
```

---

### v1.5.144 — Regex Correction Hotfix
```
✅ Fixed regex in cache busting function
✅ Simplified approach: don't reconstruct URLs
✅ Git pushed but no layout.tpl changes yet
```

**Changes:**
- Regex 1: `/href="([^"]*)\?v=[^"]*"/g` (update old versions)
- Regex 2: `/href="([^"]*\.(css|scss|scss\.tpl))"(?!\?v=)/g` (inject new)

---

### v1.5.145 — Production Restoration
```
✅ Manually corrected broken CSS URLs
✅ Deployed with fixed regex
✅ All 3 CSS links restored to correct format
✅ Pages regained proper formatting
```

**Restored URLs:**
- `style-colors.scss.tpl` ✅
- `style-async.scss.tpl` ✅
- `style-blog.scss.tpl` ✅

---

## 🎓 **LESSONS LEARNED**

### Critical Finding #1: Regex Complexity
**Issue:** Overly complex regex with multiple capture groups caused URL reconstruction errors

**Solution:** Simplify to preserve original URLs
```javascript
// WRONG: Reconstructs URL, duplicating extensions
const regex = /href="([^"]*\.(css|scss|scss\.tpl))\?v=[^"]*"/g;
return `href="${url}${ext}?v=${version}"`;  // ❌ Duplication

// CORRECT: Preserves original URL, only updates version
const regex = /href="([^"]*)\?v=[^"]*"/g;
return `href="${url}?v=${version}"`;  // ✅ Correct
```

### Critical Finding #2: Query String Versioning
**Validated:** Browser and CDN cache-busting via query strings
- Browser: Force re-fetch when URL changes
- CDN: Treats `?v=X` as unique resource
- Nuvemshop: Serves fresh files with new query string

### Critical Finding #3: Idempotent Deployment
**Discovery:** Cache busting is idempotent
- Can run multiple times without side effects
- Correctly handles:
  - URLs with old version → updates to new
  - URLs without version → injects new
  - URLs with new version → no change

---

## 🚀 **DEPLOYMENT PROCESS (Going Forward)**

### For All Future Deployments
```
1. Code changes completed
2. git add + git commit
3. node deploy.js "description" --force
   │
   ├─ Phase 0: Context validation
   ├─ Phase 1: Detect modified files
   ├─ Phase 2: Bump version (v1.5.145 → v1.5.146)
   ├─ Phase 3: Git commit + tag + push
   ├─ Phase 4: Backup
   ├─ Phase 5: Deploy to FTP
   │   └─ injectVersionIntoCSSLinks(layoutPath, "1.5.146")
   │       ├─ Updates: href="...?v=1.5.145" → href="...?v=1.5.146"
   │       └─ Injects: href="..." → href="...?v=1.5.146"
   ├─ Phase 6: Validate on FTP
   └─ Done!

4. Gabriel validates in production
   - Console: 📦 PATAGANG v1.5.146
   - Network: style-colors.scss.tpl?v=1.5.146 (Status 200)
   - Visual: Changes appear immediately (no cache issues)
```

---

## ✅ **VALIDATION CHECKLIST**

### For Gabriel (Production Validation)

```
☐ Open loja: https://www.patagang.com.br/
☐ Console (F12): See 📦 PATAGANG vX.X.X
☐ Network (F12 → Network, refresh):
  ☐ style-colors.scss.tpl?v=X.X.X → Status 200
  ☐ style-async.scss.tpl?v=X.X.X → Status 200
  ☐ style-blog.scss.tpl?v=X.X.X → Status 200
  ☐ No 404 errors
☐ Visual: All pages render correctly
☐ Mobile (responsive): Correct on <768px
☐ Tablet (responsive): Correct on 768-1023px
☐ Desktop (responsive): Correct on 1024px+
```

### For Developers (Code Review)

```
☐ layout.tpl URLs correct (no duplication)
☐ CSS extensions: .css, .scss, .scss.tpl
☐ No hardcoded versions in layout.tpl
☐ Regex doesn't modify other attributes
☐ Rollback available in backups/deployment-vX.X.X/
```

---

## 🔍 **TROUBLESHOOTING**

### Symptom: CSS files still not loading (404 errors)

**Check 1: Verify FTP Upload**
```
- CSS file on FTP with correct URL?
- Backup available for rollback?
```

**Check 2: Verify URL Format**
```
Correct:  style-colors.scss.tpl?v=1.5.145
Wrong:    style-colors.scssscss.tpl?v=1.5.145
Wrong:    style-colors.scss.tpl?v=?v=1.5.145
```

**Check 3: Browser Cache**
```
Hard refresh: Ctrl+Shift+Delete (Windows)
              Cmd+Shift+Delete (Mac)
```

### Symptom: Version not updating in new deploys

**Solution:** Ensure layout.tpl is modified and included in deploy
```
git status → should show theme-deploy-corrigido/layouts/layout.tpl as modified
git commit → include layout.tpl in version commit
```

---

## 📚 **RELATED DOCUMENTATION**

- **CSS Refactoring Safety Pattern:** `.claude/rules/css-refactoring-safety-pattern.md`
- **Nuvemshop FTP Constraints:** `.claude/rules/nuvemshop-ftp-constraints.md`
- **Deploy Script:** `ftp-deploy/deploy.js`
- **Phase A Completion:** `.aiox-core/data/EPIC-9-PHASE-A-COMPLETION.md`

---

## 🎯 **ANTI-PATTERNS (NEVER DO)**

```
❌ Remove cache busting from deploy.js (fixes would regress)
❌ Hardcode versions in layout.tpl (manually editable is error-prone)
❌ Use timestamps instead of version numbers (inconsistent with git tags)
❌ Deploy without running Phase 5 (cache busting needs to run every time)
❌ Assume ?v= is only for testing (it's production-critical)
```

---

## ✅ **SUCCESS CRITERIA MET**

- ✅ Banner background changes visible immediately (no cache delay)
- ✅ All CSS links served with version query strings
- ✅ Nuvemshop multi-layer caching bypassed
- ✅ Browser local cache bypassed
- ✅ CDN cache bypassed
- ✅ Pages restore correct formatting
- ✅ Automated (no manual intervention)
- ✅ Deployable (works with existing workflow)

---

**Status:** ✅ COMPLETE & PRODUCTION-READY
**Next Step:** Continue with EPIC 9 Phase B story implementations
**Maintenance:** Cache busting runs automatically every deploy

---

*Document version: 1.0.0*
*Created: 2026-03-26*
*Authority: @aiox-master*
*Experience: Incident → Solution → Documentation*
