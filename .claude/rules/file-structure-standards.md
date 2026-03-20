# File Structure Standards — AIOX Organizational Framework
## Contextual Auto-Load Rule for All File Creation

**Rule Type:** Contextual Auto-Load (triggers on file creation/modification)
**Scope:** Entire project (all agents, all models, all LLMs)
**Trigger:** ANY file creation, documentation writing, or architectural decision
**Enforcement Mode:** GUIDANCE (advisor, non-blocking)
**Authority:** @architect (maintains this rule)

---

## AUTO-TRIGGER CONDITIONS

This rule **auto-loads** whenever:

✅ Creating a new file
✅ Writing documentation
✅ Adding code to the project
✅ Creating reports or analysis
✅ Making architectural decisions
✅ Adding configuration or data files

**No manual intervention needed** — Claude Code auto-loads this rule based on context.

---

## CORE PRINCIPLE

### ➡️ **ONE FILE → ONE CORRECT FOLDER**

Every file created must be placed in its **correct organizational folder** based on:
1. **File type** (source code, documentation, config, etc.)
2. **File purpose** (guide, report, architecture, etc.)
3. **File lifecycle** (L1-L4 framework layer)

**Not:** "Where should this go?"
**Yes:** "This file exists, so it MUST go in [specific folder]"

---

## QUICK DECISION TREE

**When creating ANY file, answer these questions in order:**

```
1. Is this a code file?
   YES → Go to LAYER 4: Source Code
   NO → Continue to question 2

2. Is this a framework/template file?
   YES → Go to LAYER 2: Framework Templates
   NO → Continue to question 3

3. Is this configuration or pattern data?
   YES → Go to LAYER 3: Project Configuration
   NO → Continue to question 4

4. Is this project documentation?
   YES → Go to LAYER 4: Documentation (docs/)
   NO → Continue to question 5

5. Is this process/procedure/guide?
   YES → docs/guides/[domain]/
   NO → Continue to question 6

6. Is this a report or assessment?
   YES → docs/reports/[domain]/
   NO → Continue to question 7

7. Is this an architecture/design?
   YES → docs/architecture/[domain]/
   NO → Continue to question 8

8. Is this a review or analysis?
   YES → docs/reviews/[domain]/
   NO → Ask @architect where this belongs
```

---

## FRAMEWORK LAYERS (L1-L4)

### **LAYER 1: Framework Core** (PROTECTED - L1)
**Path:** `.aiox-core/core/`
**Mutability:** NEVER modify
**Files:** Constitutional rules, core infrastructure
**Examples:** constitution.md, CLI core, registry core
**Rule:** Do NOT create files here unless CORE framework change

### **LAYER 2: Framework Templates** (Extend-only - L2)
**Path:** `.aiox-core/development/`
**Mutability:** Read-only reference, extend by creating new files
**Subfolders:**
- `.aiox-core/development/tasks/` — Reusable task workflows
- `.aiox-core/development/workflows/` — Multi-step processes
- `.aiox-core/development/checklists/` — Validation checklists
- `.aiox-core/development/templates/` — Document/code templates
- `.aiox-core/development/agents/` — Agent persona definitions
- `.aiox-core/development/docs/` — Framework documentation (extends core)

**Examples of L2 Files:**
- `create-story-task.md` → `.aiox-core/development/tasks/`
- `story-template.md` → `.aiox-core/development/templates/`
- `code-review-checklist.md` → `.aiox-core/development/checklists/`
- `nuvemshop-ftp-constraints.md` → `.aiox-core/development/checklists/`

**Rule:** When you create reusable templates/tasks, put in L2

### **LAYER 3: Project Configuration** (Mutable - L3)
**Path:** `.aiox-core/data/`, `.claude/rules/`, `core-config.yaml`
**Mutability:** Mutable, modify as needed
**Subfolders:**
- `.aiox-core/data/patterns/` — Pattern registries (YAML)
- `.aiox-core/data/tech-presets/` — Technology stacks
- `.aiox-core/data/[other configs]/` — Other configuration
- `.claude/rules/` — Contextual rules (auto-load in Claude Code)
- `.claude/settings.json` — Claude Code configuration

**Examples of L3 Files:**
- `nuvemshop-patterns.yaml` → `.aiox-core/data/`
- `file-structure-standards.md` → `.claude/rules/`
- `agent-authority.md` → `.claude/rules/`

**Rule:** Configuration & rules go in L3

### **LAYER 4: Project Runtime** (Always modify - L4)
**Path:** `docs/`, `src/`, `tests/`, `packages/`, project-level scripts
**Mutability:** Always mutable, main development area
**Subfolders:**

#### **Documentation (`docs/`):**
- `docs/guides/[domain]/` — How-to guides, user guides, onboarding
- `docs/reports/[domain]/` — Analysis reports, assessments, evaluations
- `docs/reviews/[domain]/` — Architecture reviews, code reviews, audits
- `docs/architecture/[domain]/` — Technical design, system architecture
- `docs/prd/` — Product requirement documents
- `docs/stories/` — User stories, epics
- `docs/platform/` — Platform integration documentation
- `docs/features/` — Feature documentation
- `docs/project/` — Project-level information
- `docs/[other]/` — Other documentation

#### **Source Code:**
- `src/` — Application source code
- `tests/` — Test code
- `packages/` — NPM packages
- `public/` — Public assets
- `[domain]-specific/` — Domain folders

#### **Scripts & Tools:**
- `ftp-deploy/` — FTP deployment scripts (project-specific)
- `.aiox-core/scripts/` — Utility scripts (if framework-level)

**Examples of L4 Files:**
- `NUVEMSHOP_FTP_STANDARDS.md` → `docs/guides/nuvemshop/`
- `validate-nuvemshop-constraints.js` → `ftp-deploy/` (project script)
- `story-001-checkout.md` → `docs/stories/`
- `app.tsx` → `src/components/`

**Rule:** Development work, docs, code all go in L4

---

## FILE TYPE → FOLDER MAPPING

### Documentation Files

| File Type | Content | Correct Folder | Example |
|-----------|---------|-----------------|---------|
| **Guide** | How-to, tutorial, user guide | `docs/guides/[domain]/` | `NUVEMSHOP_FTP_STANDARDS.md` |
| **Quick Reference** | Quick lookup, cheat sheet | `docs/guides/[domain]/` | `API_QUICK_REFERENCE.md` |
| **Recovery/Playbook** | Incident recovery, procedures | `docs/guides/[domain]/` | `ERROR_RECOVERY_PROCEDURES.md` |
| **Architecture** | System design, technical decisions | `docs/architecture/[domain]/` | `SYSTEM_ARCHITECTURE.md` |
| **Report** | Analysis, assessment, evaluation | `docs/reports/[domain]/` | `PERFORMANCE_ASSESSMENT.md` |
| **Review** | Architecture review, audit | `docs/reviews/[domain]/` | `SECURITY_AUDIT_REVIEW.md` |
| **Specification** | Technical spec, requirements | `docs/[other]/` or L2 | `API_SPECIFICATION.md` |
| **Story** | User story, epic | `docs/stories/` | `STORY_001_FEATURE.md` |
| **PRD** | Product requirement | `docs/prd/` | `FEATURE_PRD.md` |

### Configuration Files

| File Type | Content | Correct Folder | Example |
|-----------|---------|-----------------|---------|
| **Pattern Registry** | Constraint/pattern data (YAML) | `.aiox-core/data/patterns/` | `nuvemshop-patterns.yaml` |
| **Tech Preset** | Technology stack definition | `.aiox-core/data/tech-presets/` | `nextjs-react.md` |
| **Context Rule** | Contextual rule (auto-load) | `.claude/rules/` | `file-structure-standards.md` |
| **Settings/Config** | Configuration data | `.aiox-core/data/` or `.claude/` | `agent-config.yaml` |

### Source Code Files

| File Type | Language | Correct Folder | Example |
|-----------|----------|-----------------|---------|
| **Component** | React/Vue/etc | `src/components/` | `Button.tsx` |
| **Utility** | JavaScript/TypeScript | `src/utils/` | `validation.ts` |
| **Hook** | React | `src/hooks/` | `useAuth.ts` |
| **Service** | Backend/API | `src/services/` | `api-client.ts` |
| **Test** | Jest/Vitest | `tests/` | `auth.test.ts` |
| **Script** | Deployment/tooling | `ftp-deploy/` or `scripts/` | `deploy.js` |

### Template & Task Files (L2)

| File Type | Content | Correct Folder | Example |
|-----------|---------|-----------------|---------|
| **Task** | Executable workflow | `.aiox-core/development/tasks/` | `create-story.md` |
| **Workflow** | Multi-step process | `.aiox-core/development/workflows/` | `deployment.yaml` |
| **Checklist** | Validation checklist | `.aiox-core/development/checklists/` | `qa-gate-checklist.md` |
| **Template** | Document/code template | `.aiox-core/development/templates/` | `story-template.md` |
| **Agent Definition** | Agent persona | `.aiox-core/development/agents/` | `dev-agent.yaml` |

---

## DOMAIN ORGANIZATION (FOR INTEGRATIONS)

When creating files for a **specific integration/domain** (Nuvemshop, Shopify, etc.):

**Standard Pattern:**
```
docs/
├── guides/[domain]/
│   ├── README.md (navigation)
│   ├── [guide1].md
│   └── [guide2].md
├── reports/[domain]/
│   ├── README.md (navigation)
│   ├── [report1].md
│   └── [report2].md
├── reviews/[domain]/
│   ├── README.md (navigation)
│   └── [review1].md
└── architecture/[domain]/
    ├── README.md (navigation)
    └── [architecture1].md

.aiox-core/data/
└── [domain]-patterns.yaml
```

**Examples:**
- `docs/guides/nuvemshop/` — All Nuvemshop guides
- `.aiox-core/data/shopify-patterns.yaml` — Shopify constraints
- `docs/architecture/stripe-integration/` — Stripe architecture

**Benefit:** As you add more integrations, structure scales naturally

---

## RULES FOR FILE CREATION

### ✅ DO: Create in Correct Folder

```
✅ Creating a guide? → docs/guides/[domain]/
✅ Creating a report? → docs/reports/[domain]/
✅ Creating a pattern registry? → .aiox-core/data/
✅ Creating a reusable task? → .aiox-core/development/tasks/
✅ Creating a contextual rule? → .claude/rules/
✅ Creating source code? → src/[component-type]/
✅ Creating a test? → tests/
```

### ❌ DON'T: Scatter Files

```
❌ Create files in project root (unless absolutely necessary)
❌ Create files in .aiox-core/ root
❌ Mix documentation with source code
❌ Put guides in architecture folder
❌ Put reports in guides folder
❌ Create ad-hoc folders without justification
```

### 🔍 WHEN IN DOUBT

Ask yourself:
1. **What is the purpose of this file?** (guide, report, code, config, etc.)
2. **What layer does it belong to?** (L1, L2, L3, L4)
3. **What domain/area is it for?** (nuvemshop, general, shopify, etc.)
4. **Where are similar files stored?**

Then place it in that folder.

**If still unsure:** Ask @architect for guidance (response SLA: 4 hours)

---

## VALIDATION CHECKLIST (For File Creation)

Before finalizing ANY file, verify:

```
□ File type identified correctly
□ Folder structure exists (create if needed)
□ File follows naming conventions (lowercase, hyphens, descriptive)
□ File is in CORRECT folder per mapping above
□ README.md exists in folder for navigation (if L4 doc)
□ Cross-references updated (if file moved/created)
□ No duplicate files elsewhere
□ Consistent with related files in same folder
```

---

## NAMING CONVENTIONS

**Files must follow these patterns:**

### Documentation
- **Guides:** `[FEATURE]_[TYPE]_GUIDE.md` or `[FEATURE].md`
  - Example: `NUVEMSHOP_FTP_VIOLATION_RECOVERY.md`
- **Reports:** `[DOMAIN]_[ANALYSIS_TYPE]_REPORT.md`
  - Example: `ARCHITECTURE_ASSESSMENT_FINAL.md`
- **Architecture:** `[DOMAIN]_ARCHITECTURE.md`
  - Example: `NUVEMSHOP_FTP_ARCHITECTURE.md`

### Code & Scripts
- **All lowercase with hyphens:** `validate-constraints.js`, `api-client.ts`
- **Components:** PascalCase: `Button.tsx`, `Header.tsx`
- **Tests:** Same name as source + `.test` or `.spec`: `Button.test.tsx`

### Configuration
- **Patterns:** `[domain]-patterns.yaml`
  - Example: `nuvemshop-patterns.yaml`
- **Rules:** `[domain]-[type]-rule.md` or descriptive
  - Example: `file-structure-standards.md`, `nuvemshop-ftp-constraints.md`

### Tasks & Workflows
- **Tasks:** `[action]-[domain/object].md`
  - Example: `create-story.md`, `validate-constraints.md`
- **Workflows:** `[name]-workflow.yaml`
  - Example: `deployment-workflow.yaml`

---

## AGENT-SPECIFIC GUIDANCE

### For @dev (Implementation)
- Create source code → `src/[component-type]/`
- Create tests → `tests/`
- Create project scripts → `ftp-deploy/` or `scripts/`
- Ask if unsure about file location

### For @qa (Quality)
- Create checklists → `.aiox-core/development/checklists/`
- Create review documents → `docs/reviews/[domain]/`
- Reference this rule when creating validation docs

### For @architect (Architecture)
- Create architecture docs → `docs/architecture/[domain]/`
- Create pattern registries → `.aiox-core/data/`
- Create design decisions → `docs/architecture/[domain]/`
- Maintain this rule (update when needed)

### For @analyst (Research)
- Create analysis reports → `docs/reports/[domain]/`
- Create research guides → `docs/guides/[domain]/`
- Create context documents → `docs/guides/[domain]/` or `docs/reports/[domain]/`

### For @pm (Product)
- Create PRDs → `docs/prd/`
- Create product guides → `docs/guides/[domain]/`
- Create reports → `docs/reports/[domain]/`

### For @sm (Scrum Master)
- Create stories → `docs/stories/`
- Create workflows → `.aiox-core/development/workflows/`
- Create checklists → `.aiox-core/development/checklists/`

---

## SPECIAL CASES

### README.md Files

**When to create:**
- In every domain subfolder for navigation
- At top level of doc folders
- In component folders for large components

**Template:**
```markdown
# [Domain/Feature Name]

Brief description of contents.

## Files

| File | Purpose |
|------|---------|
| file1.md | Purpose 1 |
| file2.md | Purpose 2 |

## Related Documentation

- Link 1
- Link 2
```

### INDEX/Navigation Files

**Create when:**
- Folder has 3+ documents
- Documents have complex relationships
- Want to guide users to correct file

**Location:** Root of folder as `README.md` or `INDEX.md`

### Moving/Refactoring Files

**When moving a file:**
1. Move to correct folder
2. Update ALL cross-references
3. Create redirect comment in old location (if needed)
4. Update navigation/index files
5. Commit with message explaining move

---

## AUTOMATION & VALIDATION

### Pre-Commit Checks (Optional Future)

```bash
# Validate file structure (future automation)
npm run validate:file-structure

# Output:
# ✅ All files in correct folders
# ❌ [ERROR] docs/guides/nuvemshop/REPORT.md in wrong folder
# ⚠️  [WARN] Missing README.md in docs/guides/nuvemshop/
```

### Claude Code Integration

This rule **auto-loads** when:
- Creating new files
- Writing documentation
- Any architectural decision

**Claude Code will:**
- Display guidance in context
- Suggest correct folder
- Warn if placed incorrectly
- Provide navigation templates

---

## ENFORCEMENT & EXCEPTIONS

### Enforcement Level
- **Automated suggestions:** YES (Claude Code shows guidance)
- **Blocking:** NO (developers can override if justified)
- **Validation:** YES (pre-commit checks encourage compliance)

### When to Request Exception
```
// @architect-exception-request
// File: [filename]
// Current location: [current path]
// Requested location: [requested path]
// Reason: [specific justification]
```

@architect reviews within 24 hours.

---

## RELATED DOCUMENTS

- **Analysis:** `.aiox-core/FILE_STRUCTURE_ANALYSIS.md` (detailed reference)
- **CLAUDE.md:** `.claude/CLAUDE.md` (project instructions)
- **Rules:** `.claude/rules/` (other contextual rules)
- **Standards:** `docs/guides/AIOX_FILE_STRUCTURE_STANDARDS.md` (extended guide)

---

## SUMMARY

**One Principle:** Every file has ONE correct folder based on type, purpose, and layer.

**Three Questions:**
1. What is this file's purpose?
2. What AIOX layer does it belong to?
3. What domain/area is it for?

**Result:** Clean, organized, professional project structure.

---

**Rule Version:** 1.0.0
**Created:** 2026-03-20
**Maintains by:** @architect
**Last Updated:** 2026-03-20
**Auto-Load Trigger:** File creation events
**Enforcement Mode:** ADVISORY (non-blocking, guidance)

👑 **Keep the project organized — one file, one correct folder.**
