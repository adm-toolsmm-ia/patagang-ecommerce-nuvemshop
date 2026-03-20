# Validate File Structure — AIOX Organization Compliance
## Task: Validate project follows folder standards

**Task ID:** file-structure-validation-001
**Task Type:** Quality Assurance / Audit
**Authority:** @architect (owns standards), any agent can execute
**Execution Time:** 15-30 minutes
**Status:** ACTIVE

---

## TASK DESCRIPTION

Validate that all files in the project follow the AIOX folder structure standards defined in:
- `.claude/rules/file-structure-standards.md`
- `docs/guides/AIOX_FILE_STRUCTURE_STANDARDS.md`

This task ensures:
- ✅ No scattered files in project root (except essential)
- ✅ All documentation in `docs/` organized by type
- ✅ All configuration in `.aiox-core/data/` or `.claude/`
- ✅ All templates/tasks in `.aiox-core/development/`
- ✅ All source code in `src/`, `tests/`, `scripts/`
- ✅ Each domain has proper subfolder structure

---

## PREREQUISITES

- Access to project root directory
- Understanding of AIOX L1-L4 framework
- Knowledge of `.claude/rules/file-structure-standards.md`

---

## EXECUTION STEPS

### Step 1: Understand the Standards (5 minutes)

Read the file structure standards:
```bash
# Open and review standards
less .claude/rules/file-structure-standards.md
```

Key mappings to remember:
- **L1:** `.aiox-core/core/` (protected)
- **L2:** `.aiox-core/development/` (extend-only)
- **L3:** `.aiox-core/data/`, `.claude/rules/` (mutable configs)
- **L4:** `docs/`, `src/`, `tests/` (always modify)

---

### Step 2: Scan Project Root (5 minutes)

Check project root for scattered files:

```bash
# List files in project root
ls -la | grep -E '\.md$|\.yaml$|\.json$'
```

**Expected in root:**
- ✅ `.env`, `.gitignore`, `package.json`, etc. (standard project files)
- ✅ `README.md` (project overview)
- ✅ `.git`, `node_modules/` (development tools)

**Should NOT be in root:**
- ❌ Domain-specific docs (NUVEMSHOP_*.md, etc.)
- ❌ Architecture files (ARCHITECTURE_*.md)
- ❌ Report files (REPORT_*.md, *_ASSESSMENT.md)
- ❌ Ad-hoc documentation files

**If found:** Move to appropriate `docs/` subfolder

---

### Step 3: Check .aiox-core/ Organization (5 minutes)

Verify framework files are not scattered:

```bash
# Check .aiox-core root
ls -la .aiox-core/ | grep -E '\.md$|\.yaml$'
```

**Expected in `.aiox-core/` root:**
- ✅ `constitution.md` (framework)
- ✅ `core-config.yaml` (configuration)
- ✅ Analysis documents that explain framework (FILE_STRUCTURE_ANALYSIS.md OK)

**Should NOT be in root:**
- ❌ Domain-specific docs (move to `docs/`)
- ❌ Project documentation (move to `docs/`)
- ❌ Guides, reports, architecture (move to `docs/`)

**If found:** Move to `docs/[type]/[domain]/`

---

### Step 4: Audit docs/ Folder Structure (10 minutes)

Verify documentation is organized properly:

```bash
# Check docs subfolders exist
ls -R docs/ | head -50

# Verify proper structure
# Should see: guides/, reports/, reviews/, architecture/, [other]/
# Each should have [domain]/ subfolders
```

**Expected structure:**
```
docs/
├── guides/
│   ├── nuvemshop/
│   │   ├── README.md
│   │   └── *.md
│   └── [other domains]/
├── reports/
│   ├── nuvemshop/
│   │   ├── README.md
│   │   └── *.md
│   └── [other domains]/
├── reviews/
│   ├── nuvemshop/
│   │   ├── README.md
│   │   └── *.md
│   └── [other domains]/
├── architecture/
│   ├── nuvemshop/
│   │   ├── README.md
│   │   └── *.md
│   └── [other domains]/
└── [other standard folders]/
```

**Check each domain:**
- [ ] README.md exists in each subfolder
- [ ] Files match subfolder purpose
- [ ] No misplaced files (guide in reports folder, etc.)
- [ ] Consistent naming conventions

---

### Step 5: Verify Configuration Files (5 minutes)

Check that config and pattern files are in correct layers:

```bash
# Check L2: Framework templates
ls .aiox-core/development/tasks/ | grep -E '\.md$'
ls .aiox-core/development/checklists/ | grep -E '\.md$'
ls .aiox-core/development/workflows/ | grep -E '\.yaml$'

# Check L3: Configuration
ls .aiox-core/data/ | grep -E '\.yaml$'
ls .claude/rules/ | grep -E '\.md$'
```

**Verification:**
- [ ] All patterns in `.aiox-core/data/` (e.g., nuvemshop-patterns.yaml)
- [ ] All rules in `.claude/rules/` (e.g., file-structure-standards.md)
- [ ] All tasks in `.aiox-core/development/tasks/`
- [ ] All checklists in `.aiox-core/development/checklists/`
- [ ] All workflows in `.aiox-core/development/workflows/`

---

### Step 6: Check for Orphaned Files (5 minutes)

Search for files that don't belong in their current location:

```bash
# Find all markdown files and their locations
find . -name "*.md" -type f | grep -v node_modules | grep -v ".git" | sort

# Manually review each location, check:
# - Is this file in the correct folder per standards?
# - Does the folder name match the file's purpose?
# - Is there a better folder for this file?
```

**Common misplacements to look for:**
- ❌ Guides in architecture folder
- ❌ Reports in guides folder
- ❌ Domain-specific docs in generic folders
- ❌ Configuration in root folders
- ❌ Tasks/templates in data folder

---

### Step 7: Verify Cross-References (5 minutes)

Check that file references are still valid after any reorganization:

```bash
# Sample grep for broken references
grep -r "docs/guides" .aiox-core/ | head -5
grep -r ".aiox-core/NUVEMSHOP" docs/ 2>/dev/null || echo "No broken refs found"
```

**Fixes:**
- Update internal links if paths changed
- Update references in README.md files
- Update references in rule files

---

## VALIDATION CHECKLIST

Mark each as you verify:

### Project Root Files
- [ ] No domain-specific documentation in root
- [ ] No architecture files in root
- [ ] No report files in root
- [ ] Standard project files (README.md, package.json, etc.) only
- [ ] Root is clean and professional

### .aiox-core/ Organization
- [ ] No documentation in .aiox-core/root
- [ ] All L2 files in .aiox-core/development/
- [ ] All L3 files in .aiox-core/data/ or .claude/rules/
- [ ] core/ folder protected (no user modifications)

### docs/ Organization
- [ ] docs/guides/ folder exists with domain subfolders
- [ ] docs/reports/ folder exists with domain subfolders
- [ ] docs/reviews/ folder exists with domain subfolders
- [ ] docs/architecture/ folder exists with domain subfolders
- [ ] Each domain subfolder has README.md
- [ ] Files match subfolder purposes (no misplaced files)
- [ ] All documentation accessible and organized

### File Naming
- [ ] All files follow naming conventions
- [ ] No spaces in filenames (use hyphens)
- [ ] Consistent capitalization
- [ ] Descriptive names (not vague like "document.md")

### Cross-References
- [ ] All internal links still valid
- [ ] Navigation READMEs updated
- [ ] Rule files reference correct locations
- [ ] No broken cross-domain links

### Overall Standards
- [ ] Every file in its correct folder per standards
- [ ] No scattered files
- [ ] Professional organization
- [ ] AIOX L1-L4 clearly separated
- [ ] Easy to find any file type

---

## FINDINGS & REPORTING

If violations found, document:

```markdown
## File Structure Violations Found

### Category: [Misplaced Files | Missing Structure | Naming]

**Issue:** [Describe problem]
- File: [path]
- Current location: [location]
- Correct location: [per standards]
- Action needed: Move / Rename / Create folder

**Severity:** [CRITICAL | HIGH | MEDIUM | LOW]
- CRITICAL: Root clutter, L1 modifications
- HIGH: Documentation scattered
- MEDIUM: Minor misplacement
- LOW: Naming/minor issues
```

### Report Format

Create summary report:

**File:** `docs/reports/audit-file-structure-[DATE].md`

```markdown
# File Structure Audit Report

**Date:** [date]
**Auditor:** [your name]
**Status:** [PASS | NEEDS FIXES | CRITICAL ISSUES]

## Executive Summary

- Total files checked: [count]
- Files in correct location: [count]
- Violations found: [count]
- Critical issues: [count]

## Violations by Category

### [Category 1]: [count] violations
- [violation 1]
- [violation 2]

## Recommendations

1. [Action 1]
2. [Action 2]
3. [Action 3]

## Follow-Up

Next audit: [date]
Owner: @architect
```

---

## POST-VALIDATION ACTIONS

If violations found:

### Priority 1: Critical Violations (Do immediately)
- Move files scattered in project root
- Fix L1 framework modifications (revert)
- Clean .aiox-core/ root

### Priority 2: High Violations (Do within 24 hours)
- Reorganize documentation
- Create missing README.md files
- Fix cross-references

### Priority 3: Medium Violations (Do within 1 week)
- Fix minor misplacements
- Update naming conventions
- Refactor organization

### Priority 4: Low Violations (Do in next sprint)
- Minor improvements
- Documentation updates
- Best practice refinements

---

## AUTOMATION (Future)

This task can be automated:

```bash
# Future: npm script to validate structure
npm run validate:file-structure

# Output:
# ✅ All files in correct folders
# ❌ [CRITICAL] Files in project root
# ⚠️  [HIGH] Missing README.md files
# ℹ️  [INFO] Audit report: docs/reports/audit-[date].md
```

---

## SUCCESS CRITERIA

✅ **Task Complete When:**
1. All files audited and categorized
2. No files scattered in project root
3. All documentation in proper `docs/` subfolders
4. All configuration in `.aiox-core/data/` or `.claude/rules/`
5. All L1-L4 layers clearly separated
6. Cross-references updated/verified
7. Audit report created
8. Recommendations documented

---

## RELATED DOCUMENTS

- **Rule:** `.claude/rules/file-structure-standards.md` (auto-load rule)
- **Analysis:** `.aiox-core/FILE_STRUCTURE_ANALYSIS.md` (detailed reference)
- **Guide:** `docs/guides/AIOX_FILE_STRUCTURE_STANDARDS.md` (extended guide)
- **CLAUDE.md:** `.claude/CLAUDE.md` (project instructions)

---

## TASK COMMANDS

**For agents to execute this task:**

```bash
# @dev, @qa, @architect, any agent
*task validate-file-structure

# Or manually execute steps above
```

---

**Task Version:** 1.0.0
**Created:** 2026-03-20
**Owner:** @architect
**Authority:** AIOX Framework Standards
**Review Frequency:** Monthly (or after major changes)

👑 **Keep the project organized — validate structure regularly.**
