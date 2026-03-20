# 📂 FILE STRUCTURE ANALYSIS — AIOX Standard Organization
## Nuvemshop Documentation Reorganization

**Date:** 2026-03-20
**Status:** Analysis Complete - Reorganization Plan Ready
**Issue:** Files placed incorrectly in `.aiox-core/` root and project root
**Solution:** Reorganize following AIOX L1-L4 layer structure + folder organization standards

---

## AIOX FOLDER STRUCTURE STANDARD

### `.aiox-core/` (Framework & Configuration)

```
.aiox-core/
├── core/                    # L1: Framework Core (PROTECTED - never modify)
│   ├── constitution.md
│   ├── cli/
│   ├── code-intel/
│   ├── orchestration/
│   └── registry/
│
├── development/             # L2: Framework Templates (extend-only)
│   ├── tasks/              # Executable task workflows
│   ├── workflows/          # Multi-step workflow definitions
│   ├── checklists/         # Validation and review checklists
│   ├── templates/          # Document and code templates
│   ├── docs/               # Framework documentation (extends core)
│   ├── agents/             # Agent persona definitions
│   └── scripts/            # Utility scripts
│
├── data/                    # L3: Project Configuration (mutable)
│   ├── entity-registry.yaml
│   ├── patterns/           # Pattern registries (like nuvemshop-patterns.yaml)
│   ├── tech-presets/       # Technology presets
│   └── [other configs]
│
├── infrastructure/          # Infrastructure-as-Code
├── scripts/                 # CLI & utility scripts
├── docs/                    # Framework-level documentation
└── [other framework areas]
```

### `docs/` (Project-Level Documentation - L4)

```
docs/
├── architecture/           # System architecture + design decisions
├── guides/                 # User guides, developer guides, how-tos
├── reports/                # Analysis reports, assessments, evaluations
├── reviews/                # Architecture reviews, code reviews
├── prd/                    # Product requirement documents
├── stories/                # User stories (development tracking)
├── platform/               # Platform/integration documentation
├── features/               # Feature documentation
├── project/                # Project-level information
└── [other documentation]
```

### `.claude/` (Claude Code Configuration)

```
.claude/
├── CLAUDE.md               # Project instructions (this is the source)
├── rules/                  # Contextual rules (auto-loaded)
│   ├── agent-authority.md
│   ├── nuvemshop-ftp-constraints.md  # ✅ Correct location
│   └── [other rules]
├── settings.json           # Claude Code settings
└── [other config]
```

---

## CURRENT MISPLACEMENT (WRONG ❌)

| File | Current Location | Problem |
|------|------------------|---------|
| NUVEMSHOP_FTP_STANDARDS.md | Project root | Should be in `docs/guides/` |
| NUVEMSHOP_FTP_QUICK_REFERENCE.md | Project root | Should be in `docs/guides/` |
| NUVEMSHOP_FTP_GAPS_ANALYSIS.md | `.aiox-core/development/docs/` | Should be in `docs/reports/` |
| NUVEMSHOP_FTP_VIOLATION_RECOVERY.md | `.aiox-core/development/docs/` | Should be in `docs/guides/` |
| NUVEMSHOP_FTP_ARCHITECTURE.md | `.aiox-core/` | Should be in `docs/architecture/` |
| NUVEMSHOP_INTEGRATION_QUICK_START.md | `.aiox-core/` | Should be in `docs/guides/` |
| ARCHITECTURE_REVIEW_NUVEMSHOP_CONTEXT.md | `.aiox-core/` | Should be in `docs/reviews/` |
| NUVEMSHOP_CONTEXT_REFACTORING_GUIDE.md | `.aiox-core/` | Should be in `docs/guides/` |
| ARCHITECTURE_ASSESSMENT_FINAL.md | Project root | Should be in `docs/reports/` |
| AIOX_NUVEMSHOP_IMPLEMENTATION_SUMMARY.md | Project root | Should be in `docs/reports/` |
| nuvemshop-patterns.yaml | `.aiox-core/data/` | ✅ CORRECT |
| nuvemshop-ftp-constraints.md (rule) | `.claude/rules/` | ✅ CORRECT |
| nuvemshop-ftp-constraints.md (checklist) | `.aiox-core/development/checklists/` | ✅ CORRECT |
| validate-nuvemshop-constraints.js | `ftp-deploy/` | ✅ CORRECT |

---

## REORGANIZATION PLAN (CORRECT ✅)

### Phase 1: Create Missing `docs/` Subdirectories

```bash
mkdir -p docs/guides/nuvemshop
mkdir -p docs/reports/nuvemshop
mkdir -p docs/reviews/nuvemshop
mkdir -p docs/architecture/nuvemshop
```

### Phase 2: Move Files to Correct Locations

**To `docs/guides/nuvemshop/`:**
```
docs/guides/nuvemshop/
├── NUVEMSHOP_FTP_STANDARDS.md
├── NUVEMSHOP_FTP_QUICK_REFERENCE.md
├── NUVEMSHOP_FTP_VIOLATION_RECOVERY.md
├── NUVEMSHOP_INTEGRATION_QUICK_START.md
└── NUVEMSHOP_CONTEXT_REFACTORING_GUIDE.md
```

**To `docs/reports/nuvemshop/`:**
```
docs/reports/nuvemshop/
├── ARCHITECTURE_ASSESSMENT_FINAL.md
└── AIOX_NUVEMSHOP_IMPLEMENTATION_SUMMARY.md
```

**To `docs/reviews/nuvemshop/`:**
```
docs/reviews/nuvemshop/
└── ARCHITECTURE_REVIEW_NUVEMSHOP_CONTEXT.md
```

**To `docs/architecture/nuvemshop/`:**
```
docs/architecture/nuvemshop/
└── NUVEMSHOP_FTP_ARCHITECTURE.md
```

**KEEP (Already Correct):**
- `ftp-deploy/validate-nuvemshop-constraints.js` ✅
- `.aiox-core/data/nuvemshop-patterns.yaml` ✅
- `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md` ✅
- `.claude/rules/nuvemshop-ftp-constraints.md` ✅

---

## RATIONALE: Why This Structure Matters

### 1. **Separation of Concerns (AIOX Layer Model)**

```
L1: Framework Core (protected)
    └─ constitutive rules, core infrastructure

L2: Framework Templates (extend-only)
    └─ development assets, reusable templates

L3: Project Configuration (mutable)
    ├─ data patterns, registry, settings
    └─ .aiox-core/data/ for framework-level configs

L4: Project Runtime (always modify)
    ├─ docs/ (project-specific documentation)
    ├─ src/ (source code)
    ├─ tests/ (test code)
    └─ ftp-deploy/ (project scripts)
```

### 2. **Discoverability**
- Developer wants "architecture docs" → looks in `docs/architecture/`
- Developer wants "implementation guides" → looks in `docs/guides/`
- Developer wants "reports & assessments" → looks in `docs/reports/`
- **Not scattered across `.aiox-core/` root!**

### 3. **Maintenance & Scalability**
- As you add more integrations (Shopify, WooCommerce, etc.), each gets its own subfolder
- Pattern: `docs/guides/[integration]/`, `docs/reports/[integration]/`, etc.
- Without this, root becomes cluttered

### 4. **AIOX Framework Integrity**
- `.aiox-core/` root should contain ONLY high-level framework files
- All project-specific docs belong in `docs/`
- This respects the L2/L3/L4 boundary

---

## REORGANIZATION COMMANDS

### Step 1: Create Directory Structure

```bash
cd docs

# Create subdirectories for Nuvemshop integration
mkdir -p guides/nuvemshop
mkdir -p reports/nuvemshop
mkdir -p reviews/nuvemshop
architecture/nuvemshop

# Verify
ls -R guides reports reviews architecture | grep nuvemshop
```

### Step 2: Move Files

```bash
# Move to guides
mv ../NUVEMSHOP_FTP_STANDARDS.md guides/nuvemshop/
mv ../NUVEMSHOP_FTP_QUICK_REFERENCE.md guides/nuvemshop/
mv ../.aiox-core/NUVEMSHOP_INTEGRATION_QUICK_START.md guides/nuvemshop/
mv .aiox-core/development/docs/NUVEMSHOP_FTP_VIOLATION_RECOVERY.md guides/nuvemshop/
mv ../.aiox-core/NUVEMSHOP_CONTEXT_REFACTORING_GUIDE.md guides/nuvemshop/

# Move to reports
mv ../ARCHITECTURE_ASSESSMENT_FINAL.md reports/nuvemshop/
mv ../AIOX_NUVEMSHOP_IMPLEMENTATION_SUMMARY.md reports/nuvemshop/

# Move to reviews
mv ../.aiox-core/ARCHITECTURE_REVIEW_NUVEMSHOP_CONTEXT.md reviews/nuvemshop/

# Move to architecture
mv ../.aiox-core/NUVEMSHOP_FTP_ARCHITECTURE.md architecture/nuvemshop/
```

### Step 3: Create Index Files (Optional but Recommended)

**File: `docs/guides/nuvemshop/README.md`**
```markdown
# Nuvemshop FTP Customization Guides

## Overview
Guides for customizing Nuvemshop theme via FTP, respecting platform constraints.

## Files

- **NUVEMSHOP_FTP_STANDARDS.md** — Complete reference of Nuvemshop constraints
- **NUVEMSHOP_FTP_QUICK_REFERENCE.md** — Developer quick lookup (5-minute read)
- **NUVEMSHOP_FTP_VIOLATION_RECOVERY.md** — Recovery procedures for mistakes
- **NUVEMSHOP_INTEGRATION_QUICK_START.md** — Getting started guide
- **NUVEMSHOP_CONTEXT_REFACTORING_GUIDE.md** — Architecture refactoring plan

## Related Documentation

- Architecture: `docs/architecture/nuvemshop/`
- Reports: `docs/reports/nuvemshop/`
- Reviews: `docs/reviews/nuvemshop/`
```

---

## BEFORE & AFTER FILE TREE

### BEFORE (Current - Wrong ❌)

```
project-root/
├── NUVEMSHOP_FTP_STANDARDS.md           (Wrong location)
├── NUVEMSHOP_FTP_QUICK_REFERENCE.md     (Wrong location)
├── ARCHITECTURE_ASSESSMENT_FINAL.md     (Wrong location)
├── AIOX_NUVEMSHOP_IMPLEMENTATION_SUMMARY.md (Wrong location)
├── docs/
│   ├── architecture/
│   ├── guides/
│   ├── reports/
│   ├── reviews/
│   └── [no Nuvemshop subfolder]
├── .aiox-core/
│   ├── NUVEMSHOP_FTP_ARCHITECTURE.md    (Wrong location)
│   ├── ARCHITECTURE_REVIEW_NUVEMSHOP_CONTEXT.md (Wrong location)
│   ├── NUVEMSHOP_CONTEXT_REFACTORING_GUIDE.md (Wrong location)
│   ├── development/
│   │   ├── docs/
│   │   │   ├── NUVEMSHOP_FTP_GAPS_ANALYSIS.md (Wrong location)
│   │   │   └── NUVEMSHOP_FTP_VIOLATION_RECOVERY.md (Wrong location)
│   │   └── checklists/
│   │       └── nuvemshop-ftp-constraints.md (✅ Correct)
│   └── data/
│       └── nuvemshop-patterns.yaml (✅ Correct)
└── .claude/
    └── rules/
        └── nuvemshop-ftp-constraints.md (✅ Correct)
```

### AFTER (Reorganized - Correct ✅)

```
project-root/
├── docs/
│   ├── guides/
│   │   └── nuvemshop/
│   │       ├── README.md
│   │       ├── NUVEMSHOP_FTP_STANDARDS.md          ✅
│   │       ├── NUVEMSHOP_FTP_QUICK_REFERENCE.md    ✅
│   │       ├── NUVEMSHOP_FTP_VIOLATION_RECOVERY.md ✅
│   │       ├── NUVEMSHOP_INTEGRATION_QUICK_START.md ✅
│   │       └── NUVEMSHOP_CONTEXT_REFACTORING_GUIDE.md ✅
│   ├── reports/
│   │   └── nuvemshop/
│   │       ├── README.md
│   │       ├── ARCHITECTURE_ASSESSMENT_FINAL.md                ✅
│   │       └── AIOX_NUVEMSHOP_IMPLEMENTATION_SUMMARY.md       ✅
│   ├── reviews/
│   │   └── nuvemshop/
│   │       ├── README.md
│   │       └── ARCHITECTURE_REVIEW_NUVEMSHOP_CONTEXT.md       ✅
│   └── architecture/
│       └── nuvemshop/
│           ├── README.md
│           └── NUVEMSHOP_FTP_ARCHITECTURE.md                   ✅
├── .aiox-core/
│   ├── development/
│   │   └── checklists/
│   │       └── nuvemshop-ftp-constraints.md (✅ Correct location)
│   └── data/
│       └── nuvemshop-patterns.yaml (✅ Correct location)
├── .claude/
│   └── rules/
│       └── nuvemshop-ftp-constraints.md (✅ Correct location)
├── ftp-deploy/
│   └── validate-nuvemshop-constraints.js (✅ Correct location)
└── [clean root - no scattered docs]
```

---

## FILE ORGANIZATION PRINCIPLES (AIOX Standard)

### 1. **`.aiox-core/` is for FRAMEWORK**
- Core infrastructure
- Development templates (L2)
- Configuration data (L3)
- **NOT** for project-specific documentation

### 2. **`docs/` is for PROJECT**
- All project-level documentation
- Organized by purpose (guides, reports, reviews, architecture)
- Further organized by domain/feature (nuvemshop, shopify, etc.)

### 3. **`.claude/rules/` is for CONTEXTUAL RULES**
- Auto-loading rules for agent guidance
- Proper location for constraint rules
- ✅ Already correct

### 4. **`.aiox-core/data/` is for PATTERNS & CONFIGS**
- Data patterns (YAML registries)
- Configuration data
- ✅ Correct for nuvemshop-patterns.yaml

### 5. **`ftp-deploy/` is for PROJECT SCRIPTS**
- Deployment scripts
- Project-specific tooling
- ✅ Correct for validation script

---

## REFERENCE: AIOX FOLDER STANDARDS

```markdown
# AIOX Folder Organization Standard

## Root-Level Folders (Project)
- `docs/` — All project documentation
- `src/` — Source code
- `tests/` — Test code
- `packages/` — NPM packages
- `public/` — Public assets

## `.aiox-core/` Folders (Framework)
- `.aiox-core/core/` — Framework core (L1)
- `.aiox-core/development/` — Development assets (L2)
- `.aiox-core/data/` — Configuration data (L3)
- `.aiox-core/infrastructure/` — Infrastructure code
- `.aiox-core/scripts/` — Utility scripts
- `.aiox-core/docs/` — Framework documentation

## `docs/` Subfolders (Project Documentation)
- `docs/architecture/` — System architecture & design
- `docs/guides/` — How-to guides, user guides
- `docs/reports/` — Analysis reports, assessments
- `docs/reviews/` — Architecture reviews, audits
- `docs/prd/` — Product requirements
- `docs/stories/` — User stories
- `docs/platform/` — Platform integration docs
- `docs/features/` — Feature documentation

## `.claude/` Folders (Claude Code Config)
- `.claude/rules/` — Contextual rules (auto-loaded)
- `.claude/CLAUDE.md` — Project instructions (source of truth)
- `.claude/settings.json` — Settings

## Domain/Feature Folders
When adding domain-specific docs (Nuvemshop, Shopify, etc.):
- Create subfolders: `guides/[domain]/`, `reports/[domain]/`, etc.
- Add README.md in each subfolder for navigation
- Example: `docs/guides/nuvemshop/README.md`
```

---

## SUMMARY: Why This Matters

✅ **Discoverability** — Developers know where to look
✅ **Scalability** — Easy to add more integrations
✅ **AIOX Compliance** — Respects L1-L4 framework layers
✅ **Maintainability** — No root clutter, organized by purpose
✅ **Professional** — Follows industry standards
✅ **Future-proof** — Extensible architecture

---

## NEXT ACTION

Should I proceed with reorganizing all files to the correct locations? This would involve:

1. ✅ Creating `docs/guides/nuvemshop/`, `docs/reports/nuvemshop/`, etc.
2. ✅ Moving files from `.aiox-core/` root to `docs/`
3. ✅ Creating README.md index files in each folder
4. ✅ Updating internal cross-references
5. ✅ Committing and pushing to GitHub

**Recommendation:** Proceed with reorganization (takes ~30 minutes)

---

**Standard Version:** AIOX File Structure v2.0
**Date:** 2026-03-20
**Reviewed:** YES - Files incorrectly placed, reorganization needed
