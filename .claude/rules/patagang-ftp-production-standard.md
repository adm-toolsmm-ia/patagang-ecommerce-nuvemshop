# Patagang FTP Production Deployment Standard

**Type:** Contextual Rule (L3 — Project Configuration)
**Trigger:** Edit `theme-deploy-corrigido/**/*.{tpl,scss,js}`
**Authority:** Gabriel Cristofolini (CTO)
**Status:** ✅ PRODUCTION (v1.5.170)

---

## PRINCIPLE: Sequential Phases (MANDATORY)

```
1. @dev: Implement + git commit
2. @devops: Deploy to FTP (auto-increment version)
3. Gabriel: Validate on patagang.com.br
4. @devops: Push to GitHub (ONLY if ✅ APPROVED)
```

---

## WORKFLOW

| Phase | Agent | Action | Success |
|-------|-------|--------|---------|
| 1 | @dev | Write + test locally + commit | Feature branch ready |
| 2 | @devops | `node ftp-deploy/deploy.js` | ✅ Files verified on FTP |
| 3 | Gabriel | Test production (visual + mobile + console) | ✅ APPROVED |
| 4 | @devops | `git push` + `gh pr create` | Main branch merged |

---

## FTP DEPLOY (@devops)

**Command:**
```bash
node ftp-deploy/deploy.js "vX.X.X: message [Story Y.Z]" --force
```

**Automation:** Auto-increment version, create backup, upload, validate checksums

**Rollback (if needed):**
```bash
node ftp-deploy/rollback-incremental.js --version vX.X.X-1
```

---

## GABRIEL VALIDATION

Navigate `https://patagang.com.br/`:
1. Check console: "📦 PATAGANG vX.X.X"
2. Test: Desktop + Tablet + Mobile
3. Verify: No errors, no FOUC, acceptable performance
4. Decide: ✅ APPROVED or ⚠️ CONCERNS or ❌ FAILED

If issues: @dev fixes → new deploy → re-validate

---

## QUALITY GATES (BEFORE Deploy)

@devops verifies:

**Gate 1: Git**
- ☐ Feature branch (not main)
- ☐ All changes committed

**Gate 2: Nuvemshop Constraints** (8/8 check)
- ☐ Checkout NOT modified (styling OK)
- ☐ Footer attribution VISIBLE
- ☐ Forms intact (contact, register, newsletter)
- ☐ No JS overrides
- ☐ CSS < 50 KB

**Gate 3: Backup**
- ☐ VERSION.json current
- ☐ Backup ready
- ☐ Rollback tested

**If ANY fails:** STOP, report to @dev

---

## COMMIT MESSAGE

```
{type}: {description} [Story X.Y.Z]

Brief explanation + impact

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

---

## VERSIONING

Pattern: `vX.Y.Z` (Current: v1.5.170)
- **Patch:** Bug fix, CSS adjustment
- **Minor:** New story/feature
- **Major:** Breaking change (rare)

---

## BLOCKING VIOLATIONS

- ❌ Deploy without git commit
- ❌ Push before Gabriel validates
- ❌ Skip Nuvemshop 8/8 checks
- ❌ Deploy without backup

Override: Requires @architect approval

---

## EXTENDED GUIDE

For detailed procedures, templates, and troubleshooting:
→ `.aiox-core/development/docs/SAFE_DEPLOYMENT_STANDARD.md`

---

**Version:** 2.0 (Optimized 2026-03-28)
**Status:** ✅ ACTIVE
**Enforced by:** @devops (Gage)

🚀 **This workflow is the current production deployment standard. Follow it ALWAYS.**
