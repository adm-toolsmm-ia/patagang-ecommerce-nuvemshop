# File Structure Standards — AIOX L1-L4 Framework

**Type:** Contextual Auto-Load (file creation/modification)
**Authority:** @architect
**Enforcement:** GUIDANCE (advisory, non-blocking)

---

## CORE PRINCIPLE

**ONE FILE → ONE CORRECT FOLDER**

Every file must be placed based on: (1) file type, (2) purpose, (3) AIOX layer (L1-L4).

---

## QUICK DECISION TREE

```
Is it SOURCE CODE?
  YES → L4: src/, tests/, public/
  NO → Continue...

Is it FRAMEWORK TEMPLATE/TASK?
  YES → L2: .aiox-core/development/{tasks|templates|workflows|checklists}
  NO → Continue...

Is it CONFIG or RULE?
  YES → L3: .aiox-core/data/ or .claude/rules/
  NO → Continue...

Is it PROJECT DOCUMENTATION?
  YES → L4: docs/{guides|reports|architecture|reviews|stories|prd}/[domain]/
  NO → Ask @architect
```

---

## L1-L4 ORGANIZATIONAL MODEL

| Layer | Path | Mutability | Purpose |
|-------|------|-----------|---------|
| **L1** | `.aiox-core/core/` | ❌ NEVER | Framework core (Constitution, CLI, registry) |
| **L2** | `.aiox-core/development/` | 🔒 Extend-only | Reusable templates, tasks, checklists, workflows, agents |
| **L3** | `.aiox-core/data/` + `.claude/rules/` + `.claude/` | ✅ Mutable | Project configuration, contextual rules, settings |
| **L4** | `docs/`, `src/`, `tests/`, `packages/` | ✅ ALWAYS | Project runtime (source code, documentation, content) |

---

## FILE TYPE → FOLDER MAPPING

### Documentation Files (L4: `docs/`)

| File Type | Folder | Example |
|-----------|--------|---------|
| **Guide** | `docs/guides/[domain]/` | `NUVEMSHOP_FTP_STANDARDS.md` |
| **Report** | `docs/reports/[domain]/` | `PERFORMANCE_ASSESSMENT.md` |
| **Architecture** | `docs/architecture/[domain]/` | `SYSTEM_ARCHITECTURE.md` |
| **Review** | `docs/reviews/[domain]/` | `SECURITY_AUDIT.md` |
| **Story** | `docs/stories/` | `STORY_001.md` |
| **PRD** | `docs/prd/` | `FEATURE_PRD.md` |

### Code Files (L4: `src/`, `tests/`)

| File Type | Folder | Example |
|-----------|--------|---------|
| **Component** | `src/components/` | `Button.tsx` |
| **Service** | `src/services/` | `api-client.ts` |
| **Utility** | `src/utils/` | `validation.ts` |
| **Test** | `tests/` | `auth.test.ts` |
| **Script** | `ftp-deploy/` or `scripts/` | `deploy.js` |

### Configuration Files (L3: `.aiox-core/data/` or `.claude/rules/`)

| File Type | Folder | Example |
|-----------|--------|---------|
| **Pattern registry** | `.aiox-core/data/patterns/` | `nuvemshop-patterns.yaml` |
| **Contextual rule** | `.claude/rules/` | `file-structure-standards.md` |
| **Project state** | `.aiox-core/data/` | `patagang-project-state.yaml` |

### Framework Templates (L2: `.aiox-core/development/`)

| File Type | Folder | Example |
|-----------|--------|---------|
| **Task** | `.aiox-core/development/tasks/` | `create-story.md` |
| **Workflow** | `.aiox-core/development/workflows/` | `deployment.yaml` |
| **Checklist** | `.aiox-core/development/checklists/` | `qa-gate-checklist.md` |
| **Template** | `.aiox-core/development/templates/` | `story-template.md` |
| **Agent** | `.aiox-core/development/agents/` | `dev-agent.yaml` |

---

## NAMING CONVENTIONS

```
Documentation:  [FEATURE]_[TYPE]_[DESCRIPTOR].md
                NUVEMSHOP_FTP_STANDARDS.md

Code:          lowercase-with-hyphens.ts/js/tsx
                validate-constraints.js, Button.tsx

Configuration: [domain]-[type]-[descriptor].yaml
                nuvemshop-patterns.yaml

Tests:         [source-file].test.ts
                Button.test.tsx
```

---

## VALIDATION CHECKLIST

Before finalizing ANY file:

```
☐ File type identified (doc, code, config, template)
☐ Correct folder per L1-L4 model
☐ Naming convention followed
☐ L4 doc folders have README.md (navigation)
☐ No scattered files in project root
☐ Cross-references updated (if moved/created)
☐ Consistent with related files in same folder
```

---

## DOMAIN ORGANIZATION (Integrations)

When creating domain-specific files (Nuvemshop, Shopify, etc.):

```
docs/guides/[domain]/          → Domain guides
docs/reports/[domain]/         → Domain reports
docs/architecture/[domain]/    → Domain architecture
.aiox-core/data/[domain]-patterns.yaml   → Domain constraints
```

Example: `docs/guides/nuvemshop/` contains all Nuvemshop guides.

---

## SPECIAL CASES

### README.md Files

Create in every domain folder + main doc folders for navigation:

```markdown
# [Domain Name]

Brief description.

## Files

| File | Purpose |
|------|---------|
| file.md | Purpose |
```

### Moving Files

When refactoring:
1. Move to correct folder
2. Update ALL cross-references
3. Update navigation/index
4. Commit with clear message

---

## EXCEPTIONS & OVERRIDES

**When in doubt:** Ask @architect (SLA: 4 hours)

**Custom exception format:**
```
// @architect-exception-request
// File: [name]
// Current: [path]
// Requested: [path]
// Reason: [justification]
```

---

## EXTENDED GUIDE

For detailed examples, validation checklists, and troubleshooting:
→ `.aiox-core/development/docs/FILE_STRUCTURE_EXTENDED_GUIDE.md`

---

**Version:** 2.0 (Optimized 2026-03-28)
**Status:** ✅ ACTIVE (auto-load on file creation)
**Maintained by:** @architect
