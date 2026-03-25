# 8. Deployment Artifacts — Versioning, FTP & Release Process

**Purpose:** Document versioning strategy, deployment process, rollback procedures, and release artifacts

---

## 📦 Current Version: v1.5.93

| Metric | Value |
|--------|-------|
| **Current Production** | v1.5.93 |
| **Release Date** | 2026-03-24 |
| **Status** | ✅ Production (Post-Epic 8 baseline) |
| **Last Change** | Story 8.5 v1.5.93 APPROVED |
| **Backup Location** | `backups/deployment-1.5.74/` |

---

## 🔢 Versioning Strategy

### **Semantic Versioning (MAJOR.MINOR.PATCH)**

```
v1.5.93
│ │ │
│ │ └─ PATCH (0-99): Bug fixes, minor adjustments
│ │
│ └─── MINOR (0-99): New features, story completion
│
└───── MAJOR (0-∞): Breaking changes, major refactoring
```

### **Version Increment Rules**

| Trigger | Action | Example |
|---------|--------|---------|
| **Bug fix** | Increment PATCH | v1.5.93 → v1.5.94 |
| **New story completed** | Increment MINOR | v1.5.99 → v1.6.0 |
| **Major refactoring** | Increment MAJOR | v2.0.0 (rare) |
| **Rollback** | Decrement or special | v1.5.93 → v1.5.92 (rollback) |

### **Never Decrement**

```
✅ v1.5.93 → v1.5.94 (OK)
✅ v1.5.99 → v1.6.0 (OK)
❌ v1.5.94 → v1.5.93 (WRONG — use rollback instead)
```

---

## 🚀 Deployment Process (Story-Driven)

### **Standard Workflow**

```
PHASE 1: Development
  └─ @dev writes code in working directory
  └─ Tests locally
  └─ Ready for commit

PHASE 2: Git Commit (Mandatory)
  └─ @dev: git add + git commit
  └─ Message: "feat: description [Story X.Y.Z]"
  └─ Status: Committed to feature branch

PHASE 3: FTP Deploy (Mandatory — @devops)
  └─ @devops: node ftp-deploy/deploy.js "v1.5.XX: message" --force
  └─ Auto-increment version (PATCH)
  └─ Auto-create backup in backups/deployment-vX.X.X/
  └─ Auto-upload to FTP
  └─ Auto-validate checksums
  └─ Status: LIVE in production

PHASE 4: Gabriel Validation (Mandatory)
  └─ Gabriel tests on https://patagang.com.br/
  └─ Decision: ✅ APPROVED or ⚠️ CONCERNS or ❌ FAILED
  └─ Status: Validated in production

PHASE 5: GitHub Push (After Validation)
  └─ @devops: git push + gh pr create (only if ✅ APPROVED)
  └─ Status: Merged to main
```

---

## 📂 Backup Structure

### **Backup Directory Layout**

```
backups/
├── deployment-1.5.90/
│   ├── 2026-03-20T15-30-22/
│   │   ├── manifest.json (what was deployed)
│   │   ├── style-critical.tpl.bak
│   │   ├── store.js.tpl.bak
│   │   └── [all modified files]
│   │
│   └── 2026-03-21T18-45-10/
│       └── [backup for v1.5.90 deploy 2]
│
├── deployment-1.5.91/
├── deployment-1.5.92/
├── ...
├── deployment-1.5.93/ ← CURRENT
│   └── 2026-03-24T16-38-42/
│       ├── manifest.json
│       └── [files from v1.5.93 deploy]
│
└── incremental/ (for quick rollback)
    ├── v1.5.92-backup.tar.gz
    ├── v1.5.91-backup.tar.gz
    └── ...
```

### **Backup Contents (manifest.json)**

```json
{
  "version": "1.5.93",
  "deployed_at": "2026-03-24T16:38:42Z",
  "deployed_by": "devops",
  "story": "8.5",
  "message": "JavaScript Optimization v1.5.93 [Story 8.5]",
  "files_deployed": [
    "static/js/store.js.tpl",
    "static/js/external.js.tpl",
    "static/css/style-critical.tpl"
  ],
  "stats": {
    "files_total": 127,
    "files_modified": 3,
    "size_total_mb": 2.4,
    "size_modified_mb": 0.256
  },
  "ftp_validation": "PASSED",
  "checksums_verified": true,
  "git_tag": "v1.5.93"
}
```

---

## 🔄 Rollback Procedures

### **Scenario 1: Immediate Rollback (Same Hour)**

**Command:**
```bash
node ftp-deploy/rollback-incremental.js --version v1.5.92
```

**What happens:**
1. Restores files from `backups/deployment-1.5.92/`
2. Re-uploads to FTP
3. Validates checksums
4. Takes ~2 minutes
5. Site back to v1.5.92 in production

**Use when:**
- Critical bug introduced
- Data corruption detected
- Payment processing broken
- Site goes down

---

### **Scenario 2: Rollback with Investigation**

```bash
# Step 1: Check what changed
git log --oneline v1.5.93...v1.5.92

# Step 2: Understand the issue
cat ftp-deploy-v1.5.93.log

# Step 3: Rollback
node ftp-deploy/rollback-incremental.js --version v1.5.92

# Step 4: Verify production
# Open https://patagang.com.br/ and test

# Step 5: Fix in dev
@dev makes code changes

# Step 6: Re-deploy
node ftp-deploy/deploy.js "v1.5.93: Fix [issue description]" --force
```

---

### **Scenario 3: Full Rollback to Last Known Good**

```bash
node ftp-deploy/rollback-full.js
```

**What happens:**
- Restores ENTIRE codebase to previous stable version
- Takes ~5 minutes
- Deletes current changes (be careful!)

---

## 📊 Version History (Post-Epic 8)

### **Recent Versions**

| Version | Date | Story | Status | Notes |
|---------|------|-------|--------|-------|
| v1.5.93 | 2026-03-24 | 8.5 | ✅ APPROVED | Post-Epic 8 baseline, Olark lazy-loaded |
| v1.5.92 | 2026-03-24 | 8.5 | — | (development) |
| v1.5.91 | 2026-03-23 | 8.4 | ✅ | Template cleanup |
| v1.5.90 | 2026-03-23 | 8.3 | ✅ | Remove !important |
| v1.5.89 | 2026-03-22 | 8.2 | ✅ | Critical CSS reduction attempt |
| v1.5.74 | 2026-03-21 | 8.5-P1 | ✅ | Olark lazy-loaded |
| v1.5.58 | 2026-03-15 | 8.1 | ✅ | Design tokens |

### **Epic 8 Timeline**

```
v1.5.58 ───── v1.5.74 ────── v1.5.93
  Story 8.1      Story 8.5-P1    COMPLETE
  Design         Olark lazy      All 5 stories
  Tokens         loaded          + v2.0.0 release

Feb 2026        Mar 21          Mar 24
```

---

## 🎯 Planned Future Versions

### **Story 8.5 Priorities (Remaining)**

| Version | Priority | Goal | Status |
|---------|----------|------|--------|
| v1.5.75 | P2 | Modularize store.js | ⏳ Planned |
| v1.5.76 | P3 | Consolidate cart JS | ⏳ Planned |
| v1.5.77 | P4 | Audit Swiper usage | ⏳ Planned |
| v2.0.0 | Release | Epic 8 Complete | ⏳ Planned (Q2) |

### **Post-Epic 8 (Stories 8.6+)**

```
v2.0.0 ─── v2.1.0 ─── v2.2.0 ─── ...
Release   Story 8.6  Story 8.7
    ↓
New Epic begins
```

---

## 📋 Deployment Checklist (Pre-Deploy)

### **Code Quality Gates**

```
☐ 1. Branch is feature/* (not main/master)
☐ 2. All changes committed (git status clean)
☐ 3. Commit message follows convention
☐ 4. Code passes linting: npm run lint
☐ 5. Code passes type check: npm run typecheck
☐ 6. Code builds: npm run build
☐ 7. Tests pass: npm run test
```

### **Nuvemshop Constraints Gates**

```
☐ 8. Checkout form NOT modified (styling only)
☐ 9. Footer attribution still visible
☐ 10. Contact form NOT modified
☐ 11. CSS size monitored (< 50KB goal)
☐ 12. Registration form NOT modified
☐ 13. Newsletter form NOT modified
☐ 14. No JS function overrides (Nuvemshop.*)
☐ 15. Auto-generated files untouched
```

### **Deployment Gates**

```
☐ 16. VERSION.json updated (if manual bump)
☐ 17. Backup directory ready
☐ 18. Deploy script tested (--dry-run)
☐ 19. Gabriel available for validation
```

### **Post-Deploy Gates**

```
☐ 20. FTP files validated (checksums)
☐ 21. Git tag created (v1.5.XX)
☐ 22. Console has no errors (F12)
☐ 23. Production version matches deployed
☐ 24. Gabriel approved in production
☐ 25. PR created to main (if approved)
```

---

## 🛠️ Deploy Commands

### **Dry Run (Test without deploying)**

```bash
node ftp-deploy/deploy.js "v1.5.XX: message" --dry-run
# Shows: what files would be deployed, size, time estimate
# Does NOT upload to FTP
```

### **Live Deploy**

```bash
node ftp-deploy/deploy.js "v1.5.XX: message" --force
# Executes full deployment:
# 1. Auto-increments version (PATCH)
# 2. Creates backup
# 3. Uploads to FTP
# 4. Validates checksums
# 5. Creates git tag
# 6. Logs deployment
```

### **Rollback**

```bash
# Incremental (recommended)
node ftp-deploy/rollback-incremental.js --version v1.5.92

# Full (use with caution)
node ftp-deploy/rollback-full.js
```

### **Status Check**

```bash
node ftp-deploy/status.js
# Shows:
# - Current FTP version
# - Last deployed date/time
# - Pending changes
# - Backup status
```

---

## 📝 Deployment Logs

### **Log Locations**

```
ftp-deploy-v1.5.93.log     ← Deploy execution log
ftp-deploy-v1.5.93-error.log ← Errors only
.aiox/logs/deployment.log   ← Central log
```

### **Log Contents**

```
[2026-03-24T16:38:42Z] Deployment started: v1.5.93
[2026-03-24T16:38:45Z] Phase 1: Git validation ... OK
[2026-03-24T16:38:46Z] Phase 2: Version bump ... v1.5.93
[2026-03-24T16:38:47Z] Phase 3: Backup creation ... 256KB
[2026-03-24T16:39:10Z] Phase 4: FTP upload (127 files)
[2026-03-24T16:39:12Z]   ✅ static/js/store.js.tpl
[2026-03-24T16:39:13Z]   ✅ static/js/external.js.tpl
[2026-03-24T16:39:15Z]   ✅ [125 more files]
[2026-03-24T16:39:15Z] Phase 5: FTP validation ... PASSED
[2026-03-24T16:39:16Z] Phase 6: Git tag creation ... v1.5.93
[2026-03-24T16:39:17Z] Deployment SUCCESS ✅

Deploy Time: 35 seconds
Files: 127 total, 3 modified (256KB)
Status: LIVE in production
```

---

## 🔐 Production Safety

### **Safeguards**

```
✅ Automatic backups (created before deploy)
✅ Git tagging (every deploy tagged)
✅ FTP validation (checksum verification)
✅ Rollback available (1-click restoration)
✅ Gabriel approval (manual validation step)
✅ Constraint checking (deploy gates)
✅ Log retention (30-day history)
✅ Status monitoring (live alerts)
```

### **Never Deployable**

```
❌ Don't deploy without git commit
❌ Don't deploy without backup
❌ Don't deploy without constraint check
❌ Don't deploy without Gabriel validation
❌ Don't force-push to main
❌ Don't manually edit FTP files
```

---

## 📊 Release Notes Template

**When creating v2.0.0 release (post-Epic 8):**

```markdown
# Patagang v2.0.0 — Epic 8 Complete

## What's New

### 🚀 Performance
- ✅ Lazy-loaded Olark chat (v1.5.74)
- ✅ Modularized store.js (v1.5.75)
- ✅ Consolidated cart JS (v1.5.76)
- ✅ Audited Swiper usage (v1.5.77)
- ⏳ Reduced critical CSS to 50KB (Story 8.2 goal)

### 🎨 Code Quality
- ✅ Removed !important from CSS (Story 8.3)
- ✅ Cleaned up templates (Story 8.4)
- ✅ Optimized JS modules (Story 8.5)

### 📊 Metrics
- LCP: 1.2s → 0.8s (estimated)
- Core Web Vitals: 92/100 (maintained)
- JS Bundle: 266KB → 235KB (estimated)
- CSS Critical: 163KB → 50KB (goal)

## Testing Checklist
- [ ] Homepage loads < 2.5s (mobile)
- [ ] Product page functional
- [ ] Cart operations work
- [ ] Checkout completes
- [ ] All constraints passed
- [ ] Mobile responsive
- [ ] Console no errors

## Upgrade Notes
- v1.x theme still supported
- No breaking changes
- Backwards compatible

---
Deployed: 2026-03-27
Stories: 8.1-8.5 complete
```

---

## 🔗 Related Documentation

- **[01. Store Overview](01-STORE-OVERVIEW.md)** — Version history timeline
- **[07. Nuvemshop Constraints](07-NUVEMSHOP-CONSTRAINTS.md)** — Deployment gates
- **Script:** `ftp-deploy/deploy.js` — Actual deployment script
- **Logs:** `ftp-deploy-*.log` — Deployment logs

---

**Document Version:** 1.0.0 | **AIOX L4 Documentation** | **Last Updated:** 2026-03-24
