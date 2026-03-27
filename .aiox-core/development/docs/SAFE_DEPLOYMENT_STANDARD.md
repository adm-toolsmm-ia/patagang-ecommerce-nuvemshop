# Safe Deployment Standard — CSS Refactoring & FTP Deploy Playbook

**Type:** L2 Development Reference (NOT auto-loaded)
**Created:** 2026-03-28
**For:** Step-by-step deployment procedures

**Quick Reference:** `.claude/rules/patagang-ftp-production-standard.md` + `.claude/rules/css-refactoring-safety-pattern.md`

---

## CSS Refactoring Safety Pattern

### Principle: Conservative Batching

**NEVER remove more than 10-15 CSS rules in a single deployment.**

Aggressive batching (50+ rules) breaks CSS cascade interdependencies.
Safe batching (10-15 rules) ensures validation gates catch issues early.

### Why It Matters

**Incident:** v1.5.136 attempted to remove 59 CSS rules → HTTP 500 error

Root cause: Cascade dependencies between rules. When you remove many rules at once:
1. Unknown interdependencies break
2. Higher-specificity rules lose overrides
3. Cascade order collapses
4. Entire stylesheet fails to parse

**Solution:** Remove 10-15 rules per deployment, validate between each batch.

### Safe Execution Flow

```
1. Identify 10-15 candidates for removal
2. Create atomic commit
3. Deploy to FTP
4. Validate (HTTP 200, syntax, console, visual)
5. If OK: proceed to next batch
6. If ERROR: immediate rollback + investigate
```

### Validation Gates (MANDATORY)

After EVERY CSS deployment:

```
☐ HTTP Status: 200 (not 500, not 404)
☐ CSS Syntax: Valid (no parse errors)
☐ Browser Console: Zero errors
☐ Critical Classes: Still present (in HTML)
☐ Core Pages Load: No FOUC (Flash of Unstyled Content)
☐ Mobile Responsive: Works on all breakpoints
☐ Performance: Lighthouse 90+
☐ Visual Check: No unexpected layout changes
```

**If ANY fails:** IMMEDIATE ROLLBACK

### Batch Size Recommendations

```
Orphaned rules (not in HTML):     5-10 rules per batch
Obvious duplicates (same line):   10-15 rules per batch
Critical rules (high specificity): 1-2 rules per batch (extra caution)
```

### Example: Safe Refactoring Timeline

**Aggressive (FAILED in v1.5.136):**
```
Hour 0-6: Implement 59 rule removal + test
Hour 6-7: HTTP 500 error → urgent investigation
Hour 7+: Recovery from critical failure
Result: FAILED, 7+ hours lost
```

**Safe (RECOMMENDED):**
```
Hour 0-1: Batch 1 (10 rules) — implement + deploy + validate
Hour 1-2: Batch 2 (10 rules) — implement + deploy + validate
Hour 2-3: Batch 3 (10 rules) — implement + deploy + validate
Hour 3+: Continue batching until complete
Result: ALL PASS, systematic success, same total time (7 hours)
```

---

## FTP Deployment Workflow

### Phase 1: Implementation (@dev)

**What:** Write code, test locally, create commit

**Steps:**
1. Code changes in working directory
2. Run tests locally: `npm test`
3. Lint: `npm run lint`
4. Type checking: `npm run typecheck`
5. Visual test in browser (local + mobile)

**Success:** Code ready for commit, all tests passing

---

### Phase 2: Git Commit (@dev)

**What:** Commit changes with conventional message

**Format:**
```
{type}: {description} [Story X.Y.Z]

Detailed explanation:
- What changed
- Why it changed
- Impact/constraints

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

**Example:**
```
fix: CSS batching for safe removal [Story 8.2]

Removed 12 orphaned CSS rules from style-critical.tpl:
- Old .header-legacy styling (5 rules)
- Duplicate .button-old selectors (7 rules)

Batching: Conservative 12-rule limit respected
Constraints: ✅ Nuvemshop 8/8, CSS 45KB < 50KB

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

**Success:** Feature branch has commit, clean working tree

---

### Phase 3: FTP Deploy (@devops)

**What:** Deploy to FTP production, auto-increment version

**Command:**
```bash
node ftp-deploy/deploy.js "vX.X.X: Clear description [Story Y.Z]" --force
```

**Automation:**
1. Detect modified files (git diff)
2. Auto-increment version (PATCH: v1.5.170 → v1.5.171)
3. Create git commit + tag
4. Create backup in `backups/deployment-vX.X.X/TIMESTAMP/`
5. Upload all files to FTP
6. Validate checksums on FTP
7. Verify: All files present on FTP

**Success Output:**
```
✅ SUCESSO — vX.X.X
📦 Ready for Gabriel validation
📁 Backup: backups/deployment-vX.X.X/TIMESTAMP/
🔙 Rollback: node ftp-deploy/rollback-incremental.js --version vX.X.X-1
```

**Failure Handling:**
1. Automatic rollback triggered
2. Check: `ftp-deploy-vX.X.X.log`
3. Report to @dev with specific error
4. @dev fixes → new commit → retry deploy

---

### Phase 4: Gabriel Validation

**What:** Validate on production, decide approval

**Steps:**
1. Navigate: `https://patagang.com.br/`
2. Open Console (F12)
3. Check message: "📦 PATAGANG vX.X.X"
4. Visual test: Desktop + tablet + mobile
5. Functional test: Key features work (no errors)
6. Performance: No FOUC, console clean, fast loading

**Decision:**
- ✅ **APPROVED** → Proceed to Phase 5
- ⚠️ **CONCERNS** → Document issue, @dev fixes, redeploy vX.X.X+1
- ❌ **FAILED** → Rollback immediately

---

### Phase 5: GitHub Push (@devops — ONLY after ✅)

**What:** Push to main branch, create PR

**Steps:**
1. Verify Gabriel said ✅ APPROVED
2. `git push` (feature branch → main)
3. `gh pr create` (create PR for audit trail)
4. PR review + merge to main

**Success:** Feature branch merged to main, release tagged

---

## Quality Gates (BEFORE Phase 3 Deploy)

@devops MUST verify all gates before deploying:

### Gate 1: Git Status

```
☐ Branch is feature/* (not main/master)
☐ Commit exists on branch (git log shows it)
☐ All changes staged and committed
☐ Working tree is clean
```

### Gate 2: Nuvemshop Constraints (8/8 Check)

See `.aiox-core/development/docs/NUVEMSHOP_FTP_REFERENCE.md`

```
☐ 1. Checkout structure NOT modified (styling OK)
☐ 2. Footer attribution VISIBLE
☐ 3. Contact form structure INTACT
☐ 4. Registration form structure INTACT
☐ 5. Newsletter form structure INTACT
☐ 6. No JavaScript function overrides
☐ 7. CSS < 50 KB (wc -c style-critical.tpl)
☐ 8. No auto-generated files modified
```

### Gate 3: Version & Backup

```
☐ VERSION.json/package.json current
☐ Backup directory ready
☐ Rollback script tested (can execute)
```

**If ANY gate fails:** STOP, report to @dev, do NOT deploy

---

## Rollback Commands

### Incremental Rollback (to previous version)

```bash
node ftp-deploy/rollback-incremental.js --version vX.X.X-1
```

Restores to immediately previous version (e.g., v1.5.169 if currently v1.5.170)

### Complete Rollback (to last known good)

```bash
node ftp-deploy/rollback-full.js
```

Restores to very last successful deployment (if incremental fails)

---

## Versioning Strategy

**Pattern:** Semantic Versioning `vX.Y.Z`
**Current:** v1.5.170

**Increment Rules:**
- **Patch (Z):** Bug fix, CSS adjustment, constraint fix
- **Minor (Y):** New story/feature, template consolidation
- **Major (X):** Breaking change (rare, needs discussion)

**Timeline Example:**
```
v1.5.170 → v1.5.171 (CSS batch 1 fix)
v1.5.171 → v1.5.172 (CSS batch 2 fix)
v1.6.0   → Story 9.2 (new feature, minor bump)
v2.0.0   → Major refactoring (rare)
```

---

## Troubleshooting

| Problem | Steps |
|---------|-------|
| Deploy fails | Check `ftp-deploy-vX.X.X.log`, report error to @dev |
| Gabriel found issue | @dev fixes + new commit → retry vX.X.X+1 |
| Need rollback | `rollback-incremental.js`, Gabriel validates previous version |
| Constraint violation | Check gate failure, revert change, @architect approval needed |
| HTTP 500 after deploy | Immediate rollback, investigate root cause (likely CSS cascade) |

---

## See Also

- **CSS Refactoring:** Detailed guide in this doc (section above)
- **Nuvemshop Constraints:** `.aiox-core/development/docs/NUVEMSHOP_FTP_REFERENCE.md`
- **Lessons Learned:** `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md`
- **Quickstart:** `.aiox-core/development/docs/AIOX_QUICKSTART.md`

---

**Version:** 2.0
**Type:** L2 Development Reference (on-demand loaded)
**Authority:** @devops (Gage)
