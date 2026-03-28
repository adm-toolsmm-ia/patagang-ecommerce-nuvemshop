# Quick Reference Card — CSS Simplification (v1.5.246)

**Print this, keep at desk during implementation**

---

## 🎯 ONE-LINE SUMMARY

**Remove 164 KB corrupted CSS (style-async) + 80 KB redundant inline CSS**

---

## ❌ TO REMOVE (EXACT)

| What | Line(s) | Size | Action |
|------|---------|------|--------|
| Background reset CSS | 80-107 | -28 ln, 3 KB | DELETE |
| Gallery/banner CSS | 109-248 | -140 ln, 8 KB | DELETE |
| style-async.scss.tpl link | 252 | -1 ln, 164 KB | DELETE |
| style-async.scss.tpl file | — | 164 KB | `rm` |

---

## ⚠️ TO EVALUATE (test local first)

| What | Line(s) | Size | If OK? |
|------|---------|------|--------|
| Home V2 link | 255-258 | 4 ln, 24 KB | DELETE |
| Ad bar override | 273-357 | 85 ln, 8 KB | REVIEW style-critical first |

---

## ✅ TO KEEP (DON'T TOUCH)

| What | Line(s) | Reason |
|-------|---------|--------|
| Critical CSS (lines 69-73) | 69-73 | Essential (151 KB) |
| Colors inline (line 78) | 78 | Essential (25 KB) |
| Header styling | 360-386 | Essential |
| Mobile spacing fix | 450+ | Essential |
| ALL HTML body | rest | Essential |

---

## 🔢 METRICS

```
BEFORE:  974 lines, 450 KB CSS
AFTER:   800-850 lines, 182 KB CSS
REDUCTION: -174 lines (-17%), -268 KB (-59%)
```

---

## ⚡ QUICK STEPS

```bash
# 1. Read this card (you're doing it!) ✅
# 2. Verify style-async has "content:??"
grep -c "content:??" theme-deploy-corrigido/static/css/style-async.scss.tpl
# Expected: > 0

# 3. Edit layout.tpl (remove exact lines)
# Lines 80-107: DELETE
# Lines 109-248: DELETE
# Line 252: DELETE
# Keep everything else

# 4. Delete CSS file
rm theme-deploy-corrigido/static/css/style-async.scss.tpl

# 5. Validate
wc -l theme-deploy-corrigido/layouts/layout.tpl
# Expected: ~800-850 (before: 974)

wc -c theme-deploy-corrigido/static/css/*.tpl
# Expected: ~200 KB total (before: 450 KB)

# 6. Test local (browser)
# Check: No HTTP 500, No "content:??", Gallery renders, Colors correct

# 7. CodeRabbit check
coderabbit --prompt-only -t uncommitted

# 8. Commit
git add theme-deploy-corrigido/
git commit -m "refactor: remove corrupted style-async.scss.tpl (164KB)
- Removes invalid 'content:??' CSS
- Eliminates HTTP 500 error
- Simplifies CSS architecture (450KB → 182KB)

[Story 11.x]

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>"

# 9. Deploy (if local tests pass)
node ftp-deploy/deploy.js "v1.5.246: CSS Simplification" --force

# 10. Gabriel validates on https://patagang.com.br/
# ✅ HTTP 200
# ✅ No console errors
# ✅ Gallery works
# ✅ Colors correct
# ✅ Mobile responsive

# 11. If OK: push + PR
git push origin feat/epic-11
gh pr create --title "refactor: simplify CSS" --body "..."
```

---

## 🚨 IF SOMETHING BREAKS

```bash
# Immediate rollback
node ftp-deploy/rollback-incremental.js --version v1.5.245

# Local revert
git revert HEAD

# Investigate what went wrong
# Contact @dev or @architect
```

---

## ✓ VALIDATION CHECKLIST (LOCAL)

- [ ] `wc -l` shows ~800-850 lines (was 974)
- [ ] `wc -c` CSS total ~200 KB (was 450 KB)
- [ ] `grep "content:??"` returns 0 (was >3)
- [ ] Browser: No HTTP 500 error
- [ ] Browser: No "content:??" in console
- [ ] Browser: Gallery renders (2x2 desktop, 1x mobile)
- [ ] Browser: Colors correct (not gray/broken)
- [ ] Browser: Ad bar visible
- [ ] Browser: Help button + WhatsApp button visible
- [ ] Mobile: All pages responsive
- [ ] Lighthouse: Mobile score ≥ 90 (target)

---

## ✓ VALIDATION CHECKLIST (PRODUCTION)

**@gabriel tests on https://patagang.com.br/**

- [ ] HTTP 200 (no 500)
- [ ] Console: 0 JS errors
- [ ] Home page loads fast
- [ ] Gallery renders correctly
- [ ] Product page loads
- [ ] Category page loads
- [ ] Filters work
- [ ] Mobile: all pages responsive
- [ ] Mobile: no FOUC (Flash of Unstyled Content)
- [ ] Help button works
- [ ] WhatsApp button works

**Decision:**
- ✅ **OK** → Push to main
- ⚠️ **CONCERNS** → Revert + fix + redeploy
- ❌ **FAILED** → Rollback + investigate

---

## 📞 CONTACTS

- **@dev (Dex):** Implementation help
- **@architect (Aria):** Architecture decisions
- **@devops (Gage):** Deploy issues
- **@gabriel:** Final validation

---

## 🕐 TIME ESTIMATES

| Task | Duration |
|------|----------|
| Understand plan | 10-15 min |
| Edit layout.tpl | 10 min |
| Test local | 15 min |
| CodeRabbit | 5 min |
| Commit + push to feature branch | 5 min |
| Deploy FTP | 5 min |
| Gabriel validation | 15 min |
| Push to main + PR | 5 min |
| **TOTAL** | **75-80 min** |

---

## 📊 BEFORE / AFTER

```
BEFORE (v1.5.245):
HTTP 500 error ❌
"content:??" in CSS ❌
450 KB CSS ❌
974 lines layout.tpl ❌
CSS inline scattered ❌

AFTER (v1.5.246):
HTTP 200 ✅
No "content:??" ✅
182 KB CSS ✅
~800 lines layout.tpl ✅
CSS cleaner ✅
```

---

**Print Date:** 2026-03-28
**Expires:** When v1.5.246 is deployed
**Status:** READY
