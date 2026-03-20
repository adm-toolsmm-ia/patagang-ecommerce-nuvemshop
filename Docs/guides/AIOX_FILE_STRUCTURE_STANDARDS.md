# 📂 AIOX File Structure Standards — Complete Guide
## Professional Organization for All Projects

**Version:** 2.0
**Date Created:** 2026-03-20
**Audience:** All agents, developers, and LLMs
**Authority:** @architect
**Status:** ACTIVE

---

## INTRODUCTION

This guide teaches **how to organize files professionally** in an AIOX project. Every file you create has a **correct home** based on its type, purpose, and lifecycle.

**Core principle:** One file type → one correct folder. No scattered files.

**Who should read this:**
- ✅ Developers writing code
- ✅ Architects creating documentation
- ✅ Product managers writing PRDs
- ✅ Analysts creating reports
- ✅ Any agent/model/LLM creating files

---

## QUICK START (5 Minutes)

### If You're Creating...

**A Developer Guide (how-to, tutorial, quickstart):**
→ Save to: `docs/guides/[domain]/`

**A Technical Report (analysis, assessment, evaluation):**
→ Save to: `docs/reports/[domain]/`

**Architecture or Design Documentation:**
→ Save to: `docs/architecture/[domain]/`

**An Architecture Review or Audit:**
→ Save to: `docs/reviews/[domain]/`

**Configuration or Patterns (YAML):**
→ Save to: `.aiox-core/data/`

**A Reusable Task or Workflow:**
→ Save to: `.aiox-core/development/tasks/` or `.aiox-core/development/workflows/`

**Source Code:**
→ Save to: `src/`

**Tests:**
→ Save to: `tests/`

**If unsure:** Ask @architect (response in 4 hours)

---

## AIOX FRAMEWORK LAYERS (L1-L4)

AIOX uses a **4-layer model** to organize files:

### LAYER 1: Framework Core (L1)
**Location:** `.aiox-core/core/`
**Status:** Protected (never modify without reason)
**Contains:** Constitutional rules, core infrastructure
**Examples:** `constitution.md`, CLI core, registry core

**Your role:** Don't create files here unless updating framework core itself.

### LAYER 2: Framework Templates (L2)
**Location:** `.aiox-core/development/`
**Status:** Extend-only (add new templates, don't modify existing)
**Contains:** Reusable templates, tasks, workflows, checklists
**Subfolders:**
- `tasks/` — Executable workflows
- `workflows/` — Multi-step processes
- `checklists/` — Validation lists
- `templates/` — Document/code templates
- `agents/` — Agent definitions
- `docs/` — Framework documentation

**Your role:** Create reusable templates here for team to use.

**Examples:**
```
.aiox-core/development/
├── tasks/
│   ├── create-story.md
│   ├── validate-constraints.md
│   └── validate-file-structure.md
├── checklists/
│   ├── nuvemshop-ftp-constraints.md
│   └── qa-gate-checklist.md
├── workflows/
│   ├── deployment-workflow.yaml
│   └── story-development-cycle.yaml
└── templates/
    ├── story-template.md
    └── prd-template.md
```

### LAYER 3: Project Configuration (L3)
**Location:** `.aiox-core/data/`, `.claude/rules/`, `core-config.yaml`
**Status:** Mutable (modify as needed)
**Contains:** Configuration data, patterns, contextual rules
**Subfolders:**
- `.aiox-core/data/` — Patterns, presets, configs
- `.claude/rules/` — Contextual rules (auto-load in Claude Code)
- `.claude/settings.json` — Claude Code settings

**Your role:** Create and maintain project-specific configurations.

**Examples:**
```
.aiox-core/data/
├── nuvemshop-patterns.yaml
├── entity-registry.yaml
└── tech-presets/
    ├── nextjs-react.md
    └── nodejs-express.md

.claude/rules/
├── file-structure-standards.md
├── agent-authority.md
└── nuvemshop-ftp-constraints.md
```

### LAYER 4: Project Runtime (L4)
**Location:** `docs/`, `src/`, `tests/`, project scripts
**Status:** Always mutable (primary development area)
**Contains:** Documentation, source code, tests
**Subfolders:**
- `docs/guides/` — How-to guides, tutorials
- `docs/reports/` — Analysis reports, assessments
- `docs/architecture/` — Technical design
- `docs/reviews/` — Architecture reviews
- `docs/prd/` — Product requirements
- `docs/stories/` — User stories
- `src/` — Application code
- `tests/` — Test code

**Your role:** Create and update all project files and documentation here.

---

## FILE TYPE → FOLDER MAPPING

Use this table to find the right folder for any file:

### Documentation Files

| File Type | Purpose | Location | Example |
|-----------|---------|----------|---------|
| **Getting Started Guide** | Tutorial for newcomers | `docs/guides/[domain]/` | `NUVEMSHOP_FTP_QUICK_START.md` |
| **How-To Guide** | Instructions for specific task | `docs/guides/[domain]/` | `AUTHENTICATION_SETUP_GUIDE.md` |
| **API Reference** | API documentation | `docs/guides/[domain]/` | `API_REFERENCE.md` |
| **Troubleshooting** | Problem-solving procedures | `docs/guides/[domain]/` | `DEPLOYMENT_TROUBLESHOOTING.md` |
| **Performance Report** | Performance analysis | `docs/reports/[domain]/` | `PERFORMANCE_ANALYSIS_REPORT.md` |
| **Security Assessment** | Security evaluation | `docs/reports/[domain]/` | `SECURITY_ASSESSMENT_REPORT.md` |
| **Implementation Summary** | Project summary | `docs/reports/[domain]/` | `PROJECT_SUMMARY.md` |
| **System Architecture** | Technical design | `docs/architecture/[domain]/` | `SYSTEM_ARCHITECTURE.md` |
| **Design Decisions** | Architecture decisions | `docs/architecture/[domain]/` | `DESIGN_DECISIONS.md` |
| **Architecture Review** | Review findings | `docs/reviews/[domain]/` | `ARCHITECTURE_REVIEW.md` |
| **Code Review** | Code review results | `docs/reviews/[domain]/` | `CODE_REVIEW.md` |
| **Audit Report** | Audit findings | `docs/reviews/[domain]/` | `SECURITY_AUDIT.md` |
| **Product Requirement** | PRD document | `docs/prd/` | `FEATURE_001_PRD.md` |
| **User Story** | Development story | `docs/stories/` | `STORY_001_CHECKOUT.md` |
| **Epic** | Epic-level story | `docs/stories/` | `EPIC_001_PAYMENT.md` |

### Source Code Files

| File Type | Language | Location | Example |
|-----------|----------|----------|---------|
| **Component** | React/Vue | `src/components/[domain]/` | `Button.tsx`, `Header.tsx` |
| **Page** | React | `src/pages/` | `checkout.tsx` |
| **Hook** | React | `src/hooks/` | `useAuth.ts` |
| **Service** | Node.js | `src/services/` | `api-client.ts` |
| **Utility** | JavaScript | `src/utils/` | `date-utils.ts` |
| **Style** | CSS/SCSS | `src/styles/` | `button.scss` |
| **Type Definition** | TypeScript | `src/types/` | `user.types.ts` |
| **Test** | Jest | `tests/` | `auth.test.ts` |
| **Integration Test** | E2E | `tests/e2e/` | `checkout.e2e.ts` |
| **Script** | Bash/Node | `scripts/` or domain | `deploy.js` |

### Configuration & Template Files

| File Type | Purpose | Location | Example |
|-----------|---------|----------|---------|
| **Pattern Registry** | Constraint patterns | `.aiox-core/data/` | `nuvemshop-patterns.yaml` |
| **Technology Preset** | Tech stack definition | `.aiox-core/data/tech-presets/` | `nextjs-react.md` |
| **Entity Registry** | Entity definitions | `.aiox-core/data/` | `entity-registry.yaml` |
| **Contextual Rule** | Auto-load rule | `.claude/rules/` | `file-structure-standards.md` |
| **Task Workflow** | Executable task | `.aiox-core/development/tasks/` | `create-story.md` |
| **Workflow Definition** | Process workflow | `.aiox-core/development/workflows/` | `deployment.yaml` |
| **Checklist** | Validation checklist | `.aiox-core/development/checklists/` | `qa-gate.md` |
| **Document Template** | Reusable template | `.aiox-core/development/templates/` | `story-template.md` |

---

## DOMAIN ORGANIZATION

When creating files for a **specific integration** (Nuvemshop, Shopify, etc.), organize by domain:

### Folder Structure by Domain

```
docs/
├── guides/nuvemshop/           ← Nuvemshop guides
│   ├── README.md               ← Navigation
│   ├── STANDARDS.md            ← Reference
│   ├── QUICK_REFERENCE.md      ← Quick lookup
│   └── [other guides]
├── guides/shopify/             ← Shopify guides (future)
│   ├── README.md
│   └── [guides]
├── reports/nuvemshop/          ← Nuvemshop reports
│   ├── README.md
│   ├── ASSESSMENT.md
│   └── [other reports]
├── architecture/nuvemshop/     ← Nuvemshop architecture
│   ├── README.md
│   └── [architecture docs]
└── reviews/nuvemshop/          ← Nuvemshop reviews
    ├── README.md
    └── [review docs]

.aiox-core/data/
├── nuvemshop-patterns.yaml     ← Nuvemshop patterns
└── shopify-patterns.yaml       ← Shopify patterns (future)
```

### Naming Convention by Domain

```
Guides: [DOMAIN]_[TYPE]_GUIDE.md
Examples:
  - NUVEMSHOP_FTP_STANDARDS.md
  - NUVEMSHOP_INTEGRATION_GUIDE.md
  - SHOPIFY_API_REFERENCE.md

Reports: [DOMAIN]_[ANALYSIS_TYPE]_REPORT.md
Examples:
  - NUVEMSHOP_ASSESSMENT_REPORT.md
  - SHOPIFY_PERFORMANCE_REPORT.md

Architecture: [DOMAIN]_ARCHITECTURE.md
Examples:
  - NUVEMSHOP_ARCHITECTURE.md
  - SHOPIFY_INTEGRATION_ARCHITECTURE.md

Patterns: [domain]-patterns.yaml
Examples:
  - nuvemshop-patterns.yaml
  - shopify-patterns.yaml
```

**Benefit:** As you add more integrations, structure scales naturally. Everything organized by domain.

---

## STEP-BY-STEP: WHERE DOES MY FILE GO?

Use this flowchart to find the right folder:

```
START: "I'm creating a file"
  ↓
1. Is this SOURCE CODE? (JavaScript, TypeScript, React, etc.)
  ├─ YES → Go to src/[component-type]/
  └─ NO → Continue to 2

2. Is this a TEST?
  ├─ YES → Go to tests/
  └─ NO → Continue to 3

3. Is this CONFIGURATION or PATTERN data? (YAML, patterns)
  ├─ YES → Go to .aiox-core/data/
  └─ NO → Continue to 4

4. Is this a CONTEXTUAL RULE? (auto-load rule)
  ├─ YES → Go to .claude/rules/
  └─ NO → Continue to 5

5. Is this a REUSABLE TEMPLATE or TASK?
  ├─ YES → Go to .aiox-core/development/[tasks/templates/checklists/workflows]/
  └─ NO → Continue to 6

6. Is this DOCUMENTATION?
  ├─ YES → Continue to 6a
  └─ NO → Ask @architect

6a. What TYPE of documentation?
  ├─ GUIDE (how-to, tutorial, reference) → docs/guides/[domain]/
  ├─ REPORT (analysis, assessment) → docs/reports/[domain]/
  ├─ ARCHITECTURE (system design) → docs/architecture/[domain]/
  ├─ REVIEW (audit, review) → docs/reviews/[domain]/
  ├─ PRD (product requirement) → docs/prd/
  ├─ STORY (user story) → docs/stories/
  └─ OTHER → docs/[type]/[domain]/

RESULT: File placed in CORRECT folder
```

---

## PRACTICAL EXAMPLES

### Example 1: Creating a Developer Guide

**Scenario:** You're writing a guide on "How to use the Nuvemshop API"

**Decision Process:**
1. Is this source code? NO
2. Is this a test? NO
3. Is this configuration? NO
4. Is this a rule? NO
5. Is this a template? NO
6. Is this documentation? YES
7. What type? GUIDE (how-to)

**Result:** `docs/guides/nuvemshop/NUVEMSHOP_API_GUIDE.md`

### Example 2: Creating a Report

**Scenario:** You've completed a performance analysis and want to save findings

**Decision Process:**
1. Is this source code? NO
2. Is this a test? NO
3. Is this configuration? NO
4. Is this a rule? NO
5. Is this a template? NO
6. Is this documentation? YES
7. What type? REPORT (analysis)

**Result:** `docs/reports/nuvemshop/PERFORMANCE_ANALYSIS_REPORT.md`

### Example 3: Creating a React Component

**Scenario:** You're building a new Button component for the checkout page

**Decision Process:**
1. Is this source code? YES → Go to src/

**Result:** `src/components/checkout/Button.tsx`

### Example 4: Creating a Pattern Registry

**Scenario:** You've identified validation patterns for form submissions

**Decision Process:**
1. Is this source code? NO
2. Is this a test? NO
3. Is this configuration? YES (pattern data)

**Result:** `.aiox-core/data/form-validation-patterns.yaml`

### Example 5: Creating a Reusable Checklist

**Scenario:** Team needs a standard QA checklist for all deployments

**Decision Process:**
1. Is this source code? NO
2. Is this a test? NO
3. Is this configuration? NO
4. Is this a rule? NO
5. Is this a template? YES (checklist)

**Result:** `.aiox-core/development/checklists/deployment-qa-checklist.md`

---

## BEST PRACTICES

### DO ✅

- ✅ **Create README.md** in every new documentation folder for navigation
- ✅ **Use descriptive names** (not vague like "document.md")
- ✅ **Organize by domain** (nuvemshop/, shopify/, generic/, etc.)
- ✅ **Update cross-references** when creating/moving files
- ✅ **Follow naming conventions** (lowercase with hyphens for code)
- ✅ **Keep folder structure clean** (no scatter)
- ✅ **Ask @architect** if unsure (response in 4 hours)

### DON'T ❌

- ❌ **Scatter files** in project root (except essential)
- ❌ **Mix file types** (code with docs, etc.)
- ❌ **Improvise folder names** (use standard folders)
- ❌ **Modify L1 framework** core (protected)
- ❌ **Create ad-hoc folders** without plan
- ❌ **Leave files without purpose** (remove if unused)
- ❌ **Duplicate files** in multiple locations

---

## WHEN TO REQUEST EXCEPTION

Sometimes a file needs **special placement**. Use this process:

### Request Exception (if justified)

```markdown
// @architect-exception-request

File: [filename]
Current location: [where it is now]
Requested location: [where you want it]
Domain: [nuvemshop | shopify | other]
Reason: [specific, business-driven justification]

Example reason:
"This validation script is used by 5 different domains,
so it makes sense to place in scripts/ rather than domain-specific folder"
```

**Process:**
1. Document your request
2. @architect reviews within 24 hours
3. Decision: APPROVED / NEEDS DISCUSSION / REJECTED
4. If approved: Place file as requested + document exception

**Exceptions logged:**
- `docs/reports/audit-exceptions.md`

---

## VALIDATION & AUDIT

You can validate the project structure:

### Manual Audit

```bash
# List all files not in correct folders
find . -name "*.md" -type f | grep -v docs | grep -v ".aiox-core" | grep -v ".claude"
```

### Automated Task (Execute)

```bash
# Run validation task
*task validate-file-structure

# Task will check:
# - No scattered files
# - All docs organized
# - All configs in L3
# - All templates in L2
# - File structure compliant
```

### Create Audit Report

**After validation**, create report:
```
docs/reports/audit-file-structure-[DATE].md
```

---

## RELATED RULES & DOCUMENTATION

| Document | Purpose | Location |
|----------|---------|----------|
| **File Structure Standards (Rule)** | Auto-load rule for Claude Code | `.claude/rules/file-structure-standards.md` |
| **File Structure Analysis** | Detailed technical reference | `.aiox-core/FILE_STRUCTURE_ANALYSIS.md` |
| **Validation Task** | Audit task to validate structure | `.aiox-core/development/tasks/validate-file-structure.md` |
| **Project Instructions** | CLAUDE.md with standards | `.claude/CLAUDE.md` |

---

## FAQ

**Q: Can I keep a file in the project root?**
A: Only if absolutely essential (README.md, package.json, etc.). Everything else → appropriate folder.

**Q: What if a file fits multiple categories?**
A: Choose the PRIMARY purpose. Example: a guide about architecture → `docs/guides/` (not architecture), a technical report → `docs/reports/` (not guides).

**Q: Can I create a new folder type?**
A: Check if it fits existing types first. If truly new, ask @architect before creating.

**Q: Do I need README.md in every folder?**
A: For every **documentation domain subfolder** (docs/guides/nuvemshop/, etc.), yes. Add navigation for discoverability.

**Q: How often should I audit structure?**
A: Monthly for active projects. More frequently if adding many files.

**Q: Who maintains these standards?**
A: @architect owns the standards. File feedback/exceptions with them.

---

## SUMMARY

**The Golden Rule:** Every file has ONE correct folder based on:
1. **Type** (code, doc, config, template)
2. **Purpose** (guide, report, architecture, etc.)
3. **Layer** (L1, L2, L3, L4)
4. **Domain** (nuvemshop, shopify, generic, etc.)

**Result:** Professional, organized, scalable project structure.

**Your responsibility:** When creating files, use this guide to place them correctly. Ask if unsure.

---

## IMPLEMENTATION CHECKLIST

- [ ] Read this entire guide (understanding)
- [ ] Understand the 4-layer model (L1-L4)
- [ ] Know the file type → folder mapping
- [ ] Review practical examples
- [ ] Follow best practices (DO/DON'T)
- [ ] Ask @architect if unsure
- [ ] Place files correctly
- [ ] Update cross-references
- [ ] Create README.md in new folders

---

**Guide Version:** 2.0
**Created:** 2026-03-20
**Authority:** @architect
**Status:** ACTIVE
**Review Schedule:** Quarterly

👑 **Organize professionally — one file, one correct folder.**

*Questions? Ask @architect. Need exception? Use the request format above.*
