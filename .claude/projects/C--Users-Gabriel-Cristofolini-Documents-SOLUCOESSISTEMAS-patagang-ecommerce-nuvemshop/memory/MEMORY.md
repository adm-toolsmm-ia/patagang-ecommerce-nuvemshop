# Memory Index — Patagang Ecommerce EPIC 9

## Project Context

**Project:** Patagang E-commerce (Nuvemshop FTP-deployed)
**Current Phase:** EPIC 9 Phase A (CSS Cleanup & Optimization)
**Status:** ✅ COMPLETE (v1.5.145 stable)

---

## Lessons Learned & Implementations

### 1. CSS Refactoring Safety Pattern
- **File:** `.claude/rules/css-refactoring-safety-pattern.md`
- **Topic:** Conservative batching prevents CSS cascade failures
- **Key Learning:** Max 10-15 rules per deploy, validate between batches
- **From:** EPIC 9 Phase A incident (v1.5.136 HTTP 500 error)
- **Status:** ✅ MANDATORY — Apply to ALL CSS refactoring
- **Evidence:** v1.5.135-v1.5.139 (safe) vs v1.5.136 (aggressive, failed)

### 2. Cache Busting Solution (CRITICAL)
- **File:** `EPIC-9-CACHE-BUSTING-SOLUTION.md`
- **Topic:** Nuvemshop multi-layer caching requires automatic `?v=VERSION` injection
- **Key Learning:** CSS changes won't be visible without cache busting
- **From:** EPIC 9 Phase A (v1.5.141-v1.5.145 incidents)
- **Status:** ✅ ACTIVE — Runs automatically every deploy (Phase 5)
- **Implementation:** `injectVersionIntoCSSLinks()` in `ftp-deploy/deploy.js`
- **Validation:** All CSS links now include `?v=X.X.X` during deploy

### 3. CSS Structure & Cascading Rules
- **Topic:** Understanding layout.tpl + style-critical.tpl interaction
- **Key Learning:** Always investigate HTML structure and existing CSS before changes
- **From:** Story 9.1 (banner transparency fix)
- **Status:** ✅ CRITICAL — Apply to all future CSS modifications

### 4. Regex Complexity Risks
- **Topic:** Complex capture groups cause URL reconstruction errors
- **Key Learning:** Simplify regex patterns; don't reconstruct from parts
- **From:** Cache busting incident (v1.5.141-v1.5.142)
- **Status:** ✅ DOCUMENTED — Avoid in future development
- **Error Example:** `style-colors.scss.tpl` → `style-colors.scssscss.tpl` (404)

---

## Architecture Decisions

### FTP Deployment Phases
```
Phase 0: Context validation
Phase 1: Detect modified files
Phase 2: Bump version (vX.X.X)
Phase 3: Git commit + tag + push
Phase 4: Backup
Phase 5: Deploy to FTP (+ cache busting ← NEW)
Phase 6: Validate on FTP
```

**Why Phase 5?** Before upload ensures layout.tpl on FTP has correct URLs

### Cache Busting Mechanism
```
Browser:   href="style.scss.tpl?v=1.5.145" → force re-fetch
CDN:       ?v=1.5.145 = new cache entry (separate from ?v=1.5.144)
Nuvemshop: Fresh file served with new query string
```

**Result:** CSS updates visible immediately (no manual cache clearing)

---

## Critical Files

### Documentation
- `.aiox-core/data/EPIC-9-CACHE-BUSTING-IMPLEMENTATION.md` — Full implementation details
- `.aiox-core/data/EPIC-9-PHASE-A-COMPLETION.md` — Phase A results + cache busting addendum
- `.claude/rules/css-refactoring-safety-pattern.md` — Safety guidelines
- `.claude/rules/nuvemshop-ftp-constraints.md` — Platform constraints

### Code
- `ftp-deploy/deploy.js` — Contains `injectVersionIntoCSSLinks()` (lines ~380-430)
- `theme-deploy-corrigido/layouts/layout.tpl` — Layout with cache-busted CSS links
- `ftp-deploy/rollback-incremental.js` — Rollback capability (tested & working)

### Backups & Versions
- `backups/deployment-v1.5.145/` — Latest stable version
- Git tags: v1.5.133 (baseline) → v1.5.145 (current)

---

## Deployment Timeline

| Version | Purpose | Status | Notes |
|---------|---------|--------|-------|
| v1.5.133 | Baseline (pre-Phase A) | ✅ | Working |
| v1.5.134-v1.5.139 | Phase A CSS cleanup | ✅ | 68 !important rules removed |
| v1.5.140 | Pre-cache busting | ✅ | Baseline for implementation |
| v1.5.141 | Initial cache busting | ⚠️ | Regex bug (URLs duplicated) |
| v1.5.142 | Banner transparency | ⚠️ | Regex bug caused 404s |
| v1.5.143 | Test deployment | ℹ️ | Identified regex issue |
| v1.5.144 | Regex fix hotfix | ✅ | Code corrected |
| v1.5.145 | Production restoration | ✅ | Final stable version |

---

## Validation Checklist (For Gabriel)

```
Production Validation (https://www.patagang.com.br/):
☐ Console: See 📦 PATAGANG v1.5.145
☐ Network: CSS have ?v=1.5.145 in URLs (Status 200)
☐ Visual: Banner transparent, pages formatted correctly
☐ Mobile/Tablet/Desktop: Responsive layout working
☐ No 404 errors in console
☐ No CSS loading delays
```

---

## For Future Agents

### When Implementing CSS Changes
1. Read: `.claude/rules/css-refactoring-safety-pattern.md` (10-15 rule max)
2. Read: `.claude/rules/nuvemshop-ftp-constraints.md` (platform rules)
3. Modify: `theme-deploy-corrigido/layouts/layout.tpl`
4. Commit: `git add + git commit`
5. Deploy: `node ftp-deploy/deploy.js "description" --force`
6. Validate: Cache busting should auto-inject `?v=VERSION`
7. Gabriel: Test in production

### If Cache Issues Occur
1. Check: Is layout.tpl modified? (git status)
2. Verify: Deploy script ran Phase 5 (check logs)
3. Confirm: CSS URLs have `?v=` (Network tab F12)
4. Rollback: `node ftp-deploy/rollback-incremental.js --version vX`

### Never Do
- ❌ Manually add `?v=` to layout.tpl (automation does it)
- ❌ Remove cache busting from deploy.js
- ❌ Deploy more than 15 CSS rules at once
- ❌ Assume version numbers are consistent (let script handle)

---

## Status: Ready for Phase B

✅ **Phase A Complete**
- 68 !important rules removed
- Cache busting implemented & validated
- All pages formatting correctly
- Ready for Stories 9.2-9.6

---

**Document Version:** 1.0.0
**Last Updated:** 2026-03-26
**Authority:** @aiox-master
**Next Review:** After Phase B completion (Stories 9.2-9.6)
