---
name: EPIC 9 Phase A — Cache Busting Solution Implemented
description: Automatic CSS cache busting via ?v=VERSION query strings. Solves Nuvemshop multi-layer caching issue. Prevents CSS update delays.
type: feedback
---

# EPIC 9 Phase A — Cache Busting Solution

**Incident:** CSS changes (banner transparency) not visible in production due to cache
**Root Cause:** Nuvemshop multi-layer caching (browser + CDN + server)
**Solution:** Automatic `?v=VERSION` injection during deploy
**Status:** ✅ IMPLEMENTED & WORKING (v1.5.145)

---

## THE PROBLEM

After Phase A CSS cleanup and banner styling change:
- Changed: `.section-advertising { background-color: transparent; }`
- Expected: Banner appears transparent in production
- Actual: Banner still appeared yellow (old cached CSS)
- Issue: Browser, CDN, and Nuvemshop server all serving old CSS

---

## THE SOLUTION

### Implementation: Automatic Cache Busting

**Function:** `injectVersionIntoCSSLinks(layoutPath, version)` in `ftp-deploy/deploy.js`

**How it works:**
```
Before: <link href="{{ 'css/style-colors.scss.tpl' | static_url }}" ...>
After:  <link href="{{ 'css/style-colors.scss.tpl' | static_url }}?v=1.5.145" ...>
```

**Result:**
- ✅ Browser: Treats `?v=` as new URL → force re-fetch
- ✅ CDN: Caches new URL separately from old
- ✅ Nuvemshop: Serves fresh file with new query string

### Integration

**Phase:** Part of `ftp-deploy/deploy.js` Phase 5 (before FTP upload)
**Trigger:** Every deploy automatically
**Scope:** All CSS files (`.css`, `.scss`, `.scss.tpl`)
**Idempotent:** Safe to run multiple times

---

## LESSONS LEARNED

### Lesson 1: Regex Complexity is Dangerous
**Problem:** Overly complex regex with capture groups caused URL reconstruction errors
- Duplicated extensions: `style-colors.scss.tpl` → `style-colors.scssscss.tpl`
- Resulted in 404 errors, broken pages

**Solution:** Simplify regex to preserve original URLs
- Don't reconstruct URLs from parts
- Just update/inject version string
- Use simpler patterns

### Lesson 2: Multi-Layer Caching is Real
**Validated:** Nuvemshop uses 3+ cache layers:
- Browser cache (localStorage, HTTP cache)
- CDN cache (Akamai/CloudFlare)
- Nuvemshop server cache (origin)

**All three** require different strategies:
- Browser: Query string forces re-fetch
- CDN: New URL = new cache entry
- Server: New URL = fresh file

### Lesson 3: Query Strings Work Everywhere
**Validated:** `?v=` approach is:
- ✅ Browser-native (no special handling)
- ✅ CDN-compatible (standard practice)
- ✅ Nuvemshop-compatible (no API calls needed)
- ✅ Git-compatible (no version hardcoding)
- ✅ Automated (no manual intervention)

### Lesson 4: Automation Prevents Human Error
**Benefit:** Cache busting runs every deploy
- No need to remember to add `?v=`
- No need to increment versions manually
- No risk of inconsistent versioning
- Prevents pages from using stale CSS indefinitely

---

## DEPLOYMENT FLOW

```
1. Code changes committed
   └─ git add + git commit

2. Deploy script executes
   └─ Phase 5: injectVersionIntoCSSLinks()
      ├─ Detect: layout.tpl modified
      ├─ Read: Current CSS links
      ├─ Inject: ?v=NEW_VERSION
      └─ Write: Updated layout.tpl to FTP

3. Result in production
   └─ Browser sees new URL → fetches fresh CSS
   └─ CDN sees new URL → creates new cache entry
   └─ Nuvemshop serves fresh CSS → no cache

4. User experience
   └─ CSS changes visible immediately
   └─ No "clear cache" instructions needed
   └─ No "hard refresh" workarounds required
```

---

## HOW TO APPLY

### For Future CSS Changes
1. Make CSS modifications in layout.tpl
2. Run: `node ftp-deploy/deploy.js "description" --force`
3. Script automatically injects cache busting
4. Gabriel validates in production
5. Done! No cache issues.

### For Gabriel (Validation)
- Console (F12): See `📦 PATAGANG vX.X.X`
- Network (F12): CSS have `?v=X.X.X` in URLs
- Visual: Changes appear immediately

### For Other Agents
- See: `.aiox-core/data/EPIC-9-CACHE-BUSTING-IMPLEMENTATION.md`
- Don't: Manually add version strings to layout.tpl
- Don't: Hardcode version numbers
- Do: Let deploy script handle it automatically

---

## TROUBLESHOOTING

### Symptom: CSS still not loading (404)
**Check:** `ftp-deploy/deploy.log` for errors during cache busting
**Verify:** CSS file exists on FTP (check via FTP browser)
**Restore:** Use rollback: `node ftp-deploy/rollback-incremental.js --version vX`

### Symptom: Version not updating in headers
**Check:** Is layout.tpl actually modified? (git diff)
**Verify:** Deploy script ran successfully (check logs)
**Confirm:** New files on FTP have correct timestamps

### Symptom: Old CSS still serving after deploy
**Try 1:** Hard refresh in browser: `Ctrl+Shift+Delete`
**Try 2:** Check DevTools Network tab for URL with `?v=`
**Try 3:** If URL doesn't have `?v=`, deploy didn't run

---

## ANTI-PATTERNS

### ❌ DON'T: Manually add versions to layout.tpl
```
❌ <link href="{{ 'css/style-colors.scss.tpl' | static_url }}?v=1.5.145">
```
**Why:** If you update to v1.5.146, you must remember to change the version
**Result:** Inconsistency, human error, version mismatch

### ❌ DON'T: Remove cache busting from deploy script
**Why:** Then we're back to cache problems
**Result:** CSS changes won't be visible in production

### ❌ DON'T: Use timestamps instead of version numbers
**Why:** Timestamps don't sync with git tags
**Result:** Hard to track which deploy introduced a change

### ❌ DON'T: Deploy without Phase 5 running
**Why:** Cache busting needs to execute
**Result:** CSS may not update even though files changed

---

## VALIDATION PROOF

### v1.5.142 Issue (Before Cache Busting Working)
```
Deployed: banner transparency CSS change
Result: Banner still yellow in production
Reason: Old CSS served from cache
Proof: Had to tell Gabriel to Ctrl+Shift+Delete
```

### v1.5.145 Fix (After Cache Busting Fixed)
```
Deployed: Corrected cache busting regex
Result: Formatting restored immediately
Reason: CSS re-fetched with new query string
Proof: Gabriel didn't need hard refresh, saw changes immediately
```

---

## SUCCESS METRICS

- ✅ CSS changes visible immediately (no delay)
- ✅ No manual cache clearing needed
- ✅ Automated (runs every deploy)
- ✅ Browser cache bypassed
- ✅ CDN cache bypassed
- ✅ Nuvemshop cache bypassed
- ✅ Zero configuration needed
- ✅ Works with existing deploy workflow

---

**Status:** ✅ ACTIVE — Apply to all future CSS changes
**Applies To:** EPIC 9 Phase B+ and all FTP deployments
**Learned From:** v1.5.141-v1.5.145 incidents
**Authority:** @aiox-master (based on Nuvemshop behavior)

