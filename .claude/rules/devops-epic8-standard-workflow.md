# DevOps — Epic 8 Standard Workflow (MANDATORY)

**Type:** Contextual Rule (L3 — Project Configuration)
**Authority:** Gabriel Cristofolini (CTO) + @devops (Gage)
**Effective Date:** 2026-03-21
**Applies To:** All stories in Epic 8 + All FTP-deployed projects using this workflow
**Severity:** CRITICAL — Mandatory pattern, no exceptions

---

## 🎯 **RULE: Code Changes → Commit → FTP Deploy → Gabriel Validation**

### THE STANDARD WORKFLOW (ALWAYS, NO EXCEPTIONS)

```
PHASE 1: Implementation
  └─ @dev writes code locally
  └─ Changes in working directory
  └─ Status: Ready to commit

PHASE 2: Git Commit (MANDATORY)
  └─ @dev executes: git add + git commit
  └─ Message: Conventional commits format
  └─ Linked to: Story ID [Story X.Y.Z]
  └─ Status: Committed to feature branch

PHASE 3: FTP Deploy (MANDATORY - THIS AGENT)
  └─ @devops executes: node ftp-deploy/deploy.js "v1.x.x: message" --force
  └─ Version: Auto-incremented (patch version)
  └─ Backup: Created in backups/deployment-vX.X.X/
  └─ Validation: All files verified on FTP
  └─ Status: LIVE in production

PHASE 4: Gabriel Validation (MANDATORY)
  └─ Gabriel opens https://patagang.com.br/
  └─ Gabriel uses provided checklist
  └─ Gabriel confirms: ✅ APPROVED or ⚠️ CONCERNS or ❌ FAILED
  └─ Status: Validation complete

PHASE 5: GitHub Push (AFTER validation approval)
  └─ @devops executes: git push (if approved)
  └─ PR created: Linked to story
  └─ Status: On main branch (after approval)
```

---

## 🚨 **CRITICAL: Phases MUST be Sequential**

**WRONG SEQUENCE:**
```
❌ Code → Commit → GitHub Push → (forgot FTP!)
❌ Code → FTP Deploy → (skipped commit!)
❌ Code → (no versioning, no backup!)
```

**CORRECT SEQUENCE (MANDATORY):**
```
✅ Code → Commit (local) → FTP Deploy (production) → Gabriel Validation
```

---

## 📋 **RESPONSIBILITY MATRIX**

| Phase | Agent | Action | Success Criteria |
|-------|-------|--------|-----------------|
| 1. Implementation | @dev | Write code, test locally | Code ready for commit |
| 2. Git Commit | @dev | `git add` + `git commit` | Commit exists on feature branch |
| 3. FTP Deploy | **@devops** | `node ftp-deploy/deploy.js` | ✅ Deploy logs show SUCCESS, all files verified on FTP |
| 4. Validation | **Gabriel** | Test on production (`https://patagang.com.br/`) | ✅ Visual validation passed, checklist complete |
| 5. GitHub Push | **@devops** | `git push` + `gh pr create` | ✅ Only AFTER Gabriel approval |

---

## ⚙️ **PHASE 3: FTP Deploy (THIS AGENT — @devops)**

### Trigger
When @dev says: "Ready for deploy" or "Deploy v1.x.x"

### Command
```bash
node ftp-deploy/deploy.js "v1.x.x: Clear description of changes [Story X.Y.Z]" --force
```

### What Happens Automatically
1. ✅ Detects modified files (compares to last version)
2. ✅ Auto-increments version (PATCH: v1.5.15 → v1.5.16)
3. ✅ Creates git commit with version bump
4. ✅ Creates git tag (v1.5.16)
5. ✅ Pushes tag to GitHub
6. ✅ Creates backup in `backups/deployment-vX.X.X/`
7. ✅ Uploads files to FTP
8. ✅ Validates all files on FTP (checksums)
9. ✅ Logs deployment metadata

### Success Output
```
✅ SUCESSO — vX.X.X
📦 Versão para validar: vX.X.X
📁 Backup: backups/deployment-vX.X.X/TIMESTAMP/
🔄 Pronto para validação de Gabriel
```

### Failure Output
If ANY step fails:
```
❌ ERRO em FASE X: [descrição do erro]
📁 Rollback automático ativado
🔙 Última versão em produção: v1.5.15
⚙️ Verificar logs: ftp-deploy-vX.X.X.log
```

---

## 🎯 **PHASE 4: Gabriel Validation (MANDATORY)**

### Trigger
@devops reports: "✅ Deploy completo: vX.X.X — Gabriel, valida em produção"

### Actions (Gabriel)
1. Open: `https://patagang.com.br/`
2. Console (F12): Check for "📦 PATAGANG vX.X.X"
3. Use: `Docs/stories/.archive/8.2/guides/8.2-MARQUEE-VALIDATION-CHECKLIST.md` (or story-specific checklist)
4. Test: Desktop, Tablet, Mobile
5. Report: ✅ APPROVED or ⚠️ CONCERNS or ❌ FAILED

### If ✅ APPROVED
```
Gabriel says: "v1.x.x OK para prosseguir"
↓
@devops: Executa git push + cria PR
↓
Story avança para: QA Gate → GitHub Merge
```

### If ⚠️ CONCERNS or ❌ FAILED
```
Gabriel says: "v1.x.x encontrou problema em [X]"
↓
@dev: Corrige código
↓
@dev: Novo commit (hotfix)
↓
@devops: Novo deploy (vX.X.X+1)
↓
Gabriel: Valida novamente
↓
Loop até ✅ APPROVED
```

---

## 🔄 **Rollback Strategy**

If Gabriel finds critical issue AFTER deploy:

```bash
# Rollback 1: To previous working version
node ftp-deploy/rollback-incremental.js --version v1.5.15

# Rollback 2: Full revert
node ftp-deploy/rollback-full.js
```

---

## 📊 **Commit Message Format (MANDATORY)**

All commits in Epic 8 workflows MUST follow:

```
{type}: {description} [Story X.Y.Z ETAPA N]

Detailed explanation:
- What changed
- Why it changed
- Impact on performance/constraints

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

**Examples:**
```
fix: implement marquee animation and styling for ad bar [Story 8.2 ETAPA 2 - Banner Marquee Fix]

Added complete CSS for marquee component with deslizante animation.
- Background color #EAFE67 (Patagang yellow)
- @keyframes marquee for infinite scrolling
- 3 breakpoints: mobile (25s), tablet (28s), desktop (30s)
- Removed redundant CSS from header-patagang.tpl

Constraints: ✅ Nuvemshop validated (8/8)
Performance: CSS animation (60 FPS, no JS)

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

---

## 🛡️ **Quality Gates (BEFORE Deploy)**

@devops MUST verify BEFORE executing deploy:

```
Gate 1: Git Status
  ☐ Branch is feature/* (not main/master)
  ☐ Commit exists (git log shows it)
  ☐ All changes staged and committed

Gate 2: Code Quality
  ☐ npm run lint — PASS
  ☐ npm run typecheck — PASS
  ☐ npm run build — PASS

Gate 3: Nuvemshop Constraints
  ☐ Checkout form NOT modified
  ☐ Footer attribution MAINTAINED
  ☐ Contact form NOT modified
  ☐ CSS file size < 50KB (or validated)

Gate 4: Version Tracking
  ☐ VERSION.json current
  ☐ version-info.js synced
  ☐ Backup directory ready

If ANY gate fails: STOP, report to @dev, do NOT deploy
```

---

## 📝 **Workflow Checklist (FOR @devops)**

When @dev says "Ready for deploy":

```
BEFORE Deploy:
  [ ] 1. Verify git commit exists (git log -1)
  [ ] 2. Check Nuvemshop constraints (see Gate 4 above)
  [ ] 3. Confirm version bump needed (analyze diff)
  [ ] 4. Backup path ready

DURING Deploy:
  [ ] 5. Execute: node ftp-deploy/deploy.js "v1.x.x: message" --force
  [ ] 6. Monitor: All 6 phases complete
  [ ] 7. Verify: Deploy logs show ✅ SUCESSO
  [ ] 8. Confirm: All files on FTP match local

AFTER Deploy:
  [ ] 9. Report to Gabriel: version + checklist path
  [ ] 10. Wait: Gabriel validation (do NOT push yet)
  [ ] 11. Listen: ✅ APPROVED / ⚠️ CONCERNS / ❌ FAILED

IF APPROVED:
  [ ] 12. git push + gh pr create
  [ ] 13. Mark story: Ready for QA Gate

IF CONCERNS/FAILED:
  [ ] 12. Report issue back to @dev
  [ ] 13. @dev fixes → new commit → new deploy (loop)
```

---

## 🚨 **WHAT NOT TO DO**

### ❌ VIOLATIONS (Will be enforced)

```
❌ Don't push to GitHub without FTP deploy first
   Reason: Gabriel can't validate in production
   Fix: Always FTP deploy → Gabriel validation → GitHub push

❌ Don't skip version bump
   Reason: No tracking of what changed in each release
   Fix: Use auto-increment in deploy script

❌ Don't skip backup
   Reason: Can't rollback if something breaks
   Fix: Deploy script auto-creates backup

❌ Don't deploy without git commit
   Reason: Code changes not tracked
   Fix: Always commit first with proper message

❌ Don't push without Gabriel approval
   Reason: Untested code reaches main branch
   Fix: Wait for "✅ APPROVED" from Gabriel

❌ Don't ignore Nuvemshop constraints
   Reason: Violates terms of service
   Fix: Validate 8 constraints before deploy
```

---

## 🔗 **Related Documentation**

- **Epic 8 Rule:** `.claude/rules/epic-8-execution-workflow.md`
- **Nuvemshop Constraints:** `.claude/rules/nuvemshop-ftp-constraints.md`
- **Deployment Script:** `ftp-deploy/deploy.js`
- **Rollback Script:** `ftp-deploy/rollback-incremental.js`
- **Validation Checklist:** `Docs/stories/.archive/8.2/guides/8.2-MARQUEE-VALIDATION-CHECKLIST.md`

---

## 📞 **If Workflow Breaks**

**Problem:** Deploy fails
```
1. Check ftp-deploy-vX.X.X.log
2. Identify FASE X error
3. @dev fixes code
4. New commit
5. @devops retry deploy (may increment version again)
6. Gabriel validates again
```

**Problem:** Gabriel found issue in production
```
1. Gabriel: "v1.5.16 encontrou problema em [X]"
2. @dev: Fixes code
3. New commit (hotfix)
4. @devops: Deploy vX.X.X+1
5. Gabriel: Validates again
6. Repeat until ✅ APPROVED
```

**Problem:** Rollback needed
```
1. Gabriel: "Rollback necessário — quebrou layout"
2. @devops: node ftp-deploy/rollback-incremental.js --version v1.5.15
3. Gabriel: Validates previous version works
4. @dev: Investigates root cause
5. New fix → new deploy
```

---

## ✅ **ENFORCEMENT**

This workflow is **MANDATORY** for all Epic 8 stories and all FTP-deployed changes.

**Enforcement mechanism:**
- ✅ Git hooks validate commit message format
- ✅ Deployment script requires all phases to complete
- ✅ @devops agent trained to enforce this workflow
- ✅ No exceptions (this rule overrides conflicting guidance)

**Violations escalate:**
- First violation: Warning + correction
- Second violation: Requires @architect review
- Third violation: Escalate to Gabriel for process review

---

## 🎓 **TRAINING EXAMPLES**

### Example 1: Normal Flow (✅ CORRECT)
```
@dev: "Story 8.2 complete, commit and deploy ready"
  ↓
@dev: git commit -m "fix: marquee animation [Story 8.2]"
  ↓
@devops: node ftp-deploy/deploy.js "v1.5.16: Fix marquee..." --force
  ↓ (successful deploy)
  ↓
@devops: "✅ Deploy v1.5.16 completo. Gabriel, valida em produção"
  ↓
Gabriel: Tests on https://patagang.com.br/ using checklist
  ↓
Gabriel: "v1.5.16 OK para prosseguir"
  ↓
@devops: git push + gh pr create
  ↓ (PR merged after QA gate)
Story Done ✅
```

### Example 2: With Issues (⚠️ CONCERNS)
```
@dev: Story complete, ready for deploy
  ↓
@dev: git commit -m "fix: marquee [Story 8.2]"
  ↓
@devops: node ftp-deploy/deploy.js "v1.5.16: Fix marquee..." --force
  ↓ (successful deploy)
  ↓
Gabriel: Tests on production
  ↓
Gabriel: "v1.5.16 encontrou problema: animação muito rápida no mobile"
  ↓
@dev: Ajusta CSS animation timing (25s → 22s)
  ↓
@dev: git commit -m "fix: adjust marquee animation speed [Story 8.2]"
  ↓
@devops: node ftp-deploy/deploy.js "v1.5.17: Adjust marquee animation..." --force
  ↓ (new deploy, auto-incremented)
  ↓
Gabriel: Tests again
  ↓
Gabriel: "v1.5.17 OK para prosseguir"
  ↓
@devops: git push + gh pr create
Story Done ✅
```

---

## 🎯 **SUCCESS METRICS**

When this workflow is followed correctly:

```
Metric | Target | How to Measure
─────────────────────────────────────────
Deployment Success Rate | 100% | No failed deploys
Validation Turnaround | < 15 min | Gabriel validates quickly
Rollback Frequency | < 5% | Few issues in production
GitHub PR Quality | High | Clean history, one PR per story
Documentation Completeness | 100% | Every release documented
Nuvemshop Constraint Violations | 0 | Never violate constraints
```

---

**Version:** 1.0.0
**Created:** 2026-03-21
**Authority:** Gabriel Cristofolini (CTO)
**Enforced by:** @devops (Gage)
**Status:** ACTIVE — Mandatory for all Epic 8 + FTP deployments

🚀 **This workflow is NON-NEGOTIABLE. Follow it ALWAYS.**
