# Patagang FTP Production Deployment Standard

**Type:** Contextual Rule (L3 — Project Configuration)
**Auto-Load Trigger:** On edit of `theme-deploy-corrigido/**/*.{tpl,scss,js}`
**Authority:** Gabriel Cristofolini (CTO) + @devops (Gage)
**Effective Date:** 2026-03-24
**Status:** ✅ CURRENT PRODUCTION (Baseline: v1.5.93+)
**Applies To:** All FTP deployments to Nuvemshop production (Stories 8.6+, future stories)
**Consolidates:** Learnings from Epic 8 standard workflows

## 📌 Relationship to Epic 8 Rules

**This is the generalized FTP deployment standard** consolidated from Epic 8-specific workflows:

- **Epic 8 Rules (Active During Epic 8):**
  - `.claude/rules/devops-epic8-standard-workflow.md` — Epic 8 deployment standard
  - `.claude/rules/epic-8-execution-workflow.md` — Epic 8 production-only execution

- **General FTP Standard (Recommended for Stories 8.6+):**
  - `.claude/rules/patagang-ftp-production-standard.md` ← **This rule (recommended going forward)**

**Migration Path:**
- **Epic 8 (Stories 8.1-8.5):** Reference Epic 8 rules (still active)
- **Stories 8.6+:** Transition to this general FTP standard
- **Future Projects:** Use this as baseline for FTP deployment patterns

**Principle:** Follow whatever rule is referenced in your story's documentation. This file serves as the modern consolidated reference.

---

## 🎯 **PRINCIPLE: Commit → FTP Deploy → Gabriel Validation → GitHub Push**

### Sequential Phases (MANDATORY — No Exceptions)

```
PHASE 1: Implementation (@dev)
  └─ Code changes in working directory
  └─ Status: Ready to commit

PHASE 2: Git Commit (MANDATORY)
  └─ git add + git commit
  └─ Conventional commits: "type: description [Story X.Y.Z]"
  └─ Status: Committed to feature branch

PHASE 3: FTP Deploy (MANDATORY — @devops)
  └─ node ftp-deploy/deploy.js "vX.X.X: message"
  └─ Auto-increment: patch version (v1.5.93 → v1.5.94)
  └─ Backup: backups/deployment-vX.X.X/TIMESTAMP/
  └─ Validation: Verify all files on FTP
  └─ Status: LIVE in production

PHASE 4: Gabriel Validation (MANDATORY)
  └─ https://patagang.com.br/ (visual + functional test)
  └─ Console check: 📦 PATAGANG vX.X.X
  └─ Decision: ✅ APPROVED or ⚠️ CONCERNS or ❌ FAILED
  └─ Status: Validated in production

PHASE 5: GitHub Push (AFTER validation approval)
  └─ git push (if ✅ APPROVED)
  └─ gh pr create + review + merge
  └─ Status: On main branch
```

---

## 📋 **Responsibility Matrix**

| Phase | Agent | Action | Success Criteria |
|-------|-------|--------|-----------------|
| 1. Implement | @dev | Write code, test locally | Code ready for commit |
| 2. Commit | @dev | `git add` + `git commit` | Commit on feature branch |
| 3. FTP Deploy | **@devops** | `node ftp-deploy/deploy.js` | ✅ All files verified on FTP |
| 4. Validate | **Gabriel** | Test on production | ✅ Visual validation passed |
| 5. GitHub Push | **@devops** | `git push` + `gh pr create` | ✅ Only AFTER Gabriel approval |

---

## ⚙️ **PHASE 3 Details: FTP Deploy (@devops)**

### Command
```bash
node ftp-deploy/deploy.js "vX.X.X: Clear description [Story Y.Z]" --force
```

### Automation
1. ✅ Detects modified files (git diff)
2. ✅ Auto-increments version (PATCH: v1.5.93 → v1.5.94)
3. ✅ Creates git commit with version bump
4. ✅ Creates git tag (vX.X.X)
5. ✅ Creates backup in `backups/deployment-vX.X.X/`
6. ✅ Uploads all files to FTP
7. ✅ Validates checksums on FTP
8. ✅ Logs deployment metadata

### Success Output
```
✅ SUCESSO — vX.X.X
📦 Ready for Gabriel validation
📁 Backup: backups/deployment-vX.X.X/TIMESTAMP/
🔙 Rollback: node ftp-deploy/rollback-incremental.js --version vX.X.X-1
```

### Failure Handling
If ANY step fails:
1. Automatic rollback
2. Check: `ftp-deploy-vX.X.X.log`
3. Report to @dev with specific error
4. @dev fixes → new commit → retry deploy

---

## 🎯 **PHASE 4 Details: Gabriel Validation**

### Steps
1. Navigate: `https://patagang.com.br/`
2. Open Console (F12)
3. Check: "📦 PATAGANG vX.X.X" message
4. Visual Test: Desktop + Tablet + Mobile
5. Performance: No FOUC, no console errors, acceptable loading time

### Decision Template
```
## Validação vX.X.X

**Alterações esperadas:** [description]

**Visual Check:**
- [ ] Changes appear on site?
- [ ] Correct layout on desktop/tablet/mobile?
- [ ] No flashing or reflow?
- [ ] No console errors (F12)?
- [ ] Performance acceptable?

**Decision:**
- [ ] ✅ OK to proceed (PASS)
- [ ] ⚠️ Needs adjustments (CONCERNS + details)
- [ ] ❌ Rollback required (FAIL + reason)
```

### If Issues Found
```
Gabriel: "vX.X.X encontrou problema em [location]"
  ↓
@dev: Fixes code, creates new commit
  ↓
@devops: Deploys vX.X.X+1 (new validation)
  ↓
Gabriel: Re-validates new version
  ↓
Loop until ✅ APPROVED
```

---

## 🔄 **Rollback Commands**

### Incremental Rollback (to previous working version)
```bash
node ftp-deploy/rollback-incremental.js --version vX.X.X-1
```

### Complete Rollback (to last known good)
```bash
node ftp-deploy/rollback-full.js
```

---

## ✅ **Quality Gates (BEFORE Deploy)**

@devops MUST verify:

```
Gate 1: Git Status
  ☐ Branch is feature/* (not main/master)
  ☐ Commit exists (git log shows it)
  ☐ All changes staged and committed

Gate 2: Nuvemshop Constraints
  ☐ Checkout form NOT modified (except styling)
  ☐ Footer attribution MAINTAINED (visible)
  ☐ Contact form NOT modified (structure)
  ☐ Registration/Newsletter forms intact
  ☐ No JS function overrides (Nuvemshop.*, $, etc.)
  ☐ CSS size < 50KB (critical path)
  ☐ No auto-generated files modified (sitemap, RSS)

Gate 3: Version & Backup
  ☐ VERSION.json/package.json current
  ☐ Backup directory ready
  ☐ Rollback script tested

If ANY gate fails: STOP, report to @dev, do NOT deploy
```

---

## 📝 **Commit Message Format**

```
{type}: {description} [Story X.Y.Z]

Detailed explanation:
- What changed
- Why it changed
- Impact on performance/constraints

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

**Example:**
```
fix: marquee animation and CSS for ad bar [Story 8.2]

Added marquee component with deslizante animation:
- Background color #EAFE67 (Patagang yellow)
- @keyframes marquee for infinite scrolling
- 3 breakpoints: mobile (25s), tablet (28s), desktop (30s)
- Removed redundant CSS from header-patagang.tpl

Constraints: ✅ Nuvemshop (8/8 checked)
CSS size: 45KB (< 50KB limit)

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

---

## 📊 **Versioning**

**Pattern:** `vX.Y.Z` (Semantic Versioning)

**Current:** v1.5.93 (post-Epic 8 recovery)

**Increment Rules:**
- **Patch (Z):** Bug fix, constraint violation fix, CSS adjustment
- **Minor (Y):** New story/feature, template consolidation, significant refactoring
- **Major (X):** Breaking changes (rare)

**Example Timeline:**
```
v1.5.93 — Post-Epic 8 baseline
v1.5.94 — Story 9.1 (new feature)
v1.5.95 — Story 9.1 revision (Gabriel found issues)
v1.6.0  — Story 9.2 (new story, increment Y)
v2.0.0  — Major refactoring (rare, needs discussion)
```

---

## 🚨 **VIOLATIONS & ENFORCEMENT**

### ❌ Blocking Violations
```
❌ Deploy without git commit (no code tracking)
❌ Push to GitHub before FTP deploy (Gabriel can't validate)
❌ Skip Nuvemshop constraint checks (terms of service)
❌ Modify auto-generated files (sitemap, RSS)
❌ Deploy without backup (no rollback possible)
```

**Override:** Requires @architect approval + commit message notation

### ⚠️ Warning Violations
```
⚠️ CSS approaching 50KB limit (flag at 45KB)
⚠️ New external dependencies (security review)
⚠️ Performance regression detected (Lighthouse)
```

**Action:** @qa review + decision to proceed or halt

---

## 🔗 **Related Documentation**

- **Nuvemshop Constraints:** `.claude/rules/nuvemshop-ftp-constraints.md`
- **FTP Deploy Script:** `ftp-deploy/deploy.js`
- **Rollback Scripts:** `ftp-deploy/rollback-*.js`
- **Validation Checklist:** `Docs/guides/` (story-specific)

---

## 📞 **Troubleshooting**

| Issue | Step 1 | Step 2 | Step 3 |
|-------|--------|--------|--------|
| Deploy fails | Check `ftp-deploy-vX.X.X.log` | @dev fixes code | @devops retries |
| Gabriel found issue | Document problem | @dev fixes | Re-deploy vX.X.X+1 |
| Need rollback | Run rollback command | Gabriel validates previous version | Investigate root cause |
| Constraint violated | Check gate failure | Revert change | @architect review required |

---

**Version:** 1.0.0
**Created:** 2026-03-24 (Consolidation of Epic 8 learnings)
**Status:** ✅ ACTIVE — Current production standard
**Authority:** Gabriel Cristofolini (CTO)
**Enforced by:** @devops (Gage)

🚀 **This workflow is the current production deployment standard. Follow it ALWAYS.**
