# File Structure Extended Guide — Detailed Examples & Troubleshooting

**Type:** L2 Development Reference (NOT auto-loaded)
**Created:** 2026-03-28
**For:** Understanding file organization in detail

---

## Complete Decision Tree with Examples

### Is it Source Code?

**YES → Layer 4: `src/`, `tests/`, `public/`**

```
React Component          → src/components/Button.tsx
Service/API Client       → src/services/api-client.ts
Utility Function         → src/utils/validation.ts
Custom Hook             → src/hooks/useAuth.ts
Test File               → tests/auth.test.ts
FTP Deploy Script       → ftp-deploy/deploy.js
Environment Config      → .env
```

---

### Is it Framework Template/Task/Workflow?

**YES → Layer 2: `.aiox-core/development/{type}/`**

```
Reusable Task            → .aiox-core/development/tasks/create-story.md
Workflow Definition      → .aiox-core/development/workflows/deployment.yaml
Checklist                → .aiox-core/development/checklists/qa-gate.md
Document Template        → .aiox-core/development/templates/story-template.md
Agent Definition         → .aiox-core/development/agents/dev-agent.yaml
Framework Documentation  → .aiox-core/development/docs/FILE_STRUCTURE_EXTENDED_GUIDE.md
```

---

### Is it Configuration or Rule?

**YES → Layer 3: `.aiox-core/data/` or `.claude/rules/` or `.claude/`**

```
Pattern Registry (YAML)   → .aiox-core/data/nuvemshop-patterns.yaml
Tech Stack Definition     → .aiox-core/data/tech-presets/nextjs-react.md
Project State (YAML)      → .aiox-core/data/patagang-project-state.yaml
Contextual Rule           → .claude/rules/file-structure-standards.md
Settings Configuration    → .claude/settings.json
```

---

### Is it Project Documentation?

**YES → Layer 4: `docs/{type}/[domain]/`**

**Guides (How-to, tutorials):**
```
Nuvemshop FTP Standards  → docs/guides/nuvemshop/NUVEMSHOP_FTP_STANDARDS.md
API Quick Reference      → docs/guides/api/API_QUICK_REFERENCE.md
Error Recovery           → docs/guides/nuvemshop/ERROR_RECOVERY_PROCEDURES.md
```

**Reports (Analysis, assessments):**
```
Performance Assessment   → docs/reports/performance/PERFORMANCE_ASSESSMENT.md
Architecture Evaluation  → docs/reports/architecture/EVALUATION_FINAL.md
Technical Audit          → docs/reports/security/SECURITY_AUDIT.md
```

**Architecture (Technical design):**
```
System Architecture      → docs/architecture/system/ARCHITECTURE.md
Nuvemshop Integration    → docs/architecture/nuvemshop/FTP_ARCHITECTURE.md
Database Design          → docs/architecture/database/SCHEMA_DESIGN.md
```

**Reviews (Code reviews, audits):**
```
Security Review          → docs/reviews/security/REVIEW_FINAL.md
Architecture Audit       → docs/reviews/architecture/AUDIT.md
Code Quality Review      → docs/reviews/code/QUALITY_REVIEW.md
```

**Stories & Epics:**
```
User Stories             → docs/stories/STORY_001_FEATURE_NAME.md
Epic Planning            → docs/stories/EPIC_09_PHASE_A.md
```

**PRDs:**
```
Product Requirements     → docs/prd/FEATURE_PRD.md
Business Requirements    → docs/prd/BUSINESS_REQUIREMENTS.md
```

---

## Domain Organization (Integration-Specific)

When creating domain-specific documentation (Nuvemshop, Shopify, etc.):

```
docs/
├── guides/nuvemshop/
│   ├── README.md (navigation)
│   ├── NUVEMSHOP_FTP_STANDARDS.md
│   ├── CONSTRAINT_GUIDE.md
│   └── DEPLOYMENT_CHECKLIST.md
│
├── reports/nuvemshop/
│   ├── README.md (navigation)
│   ├── TECHNICAL_ASSESSMENT.md
│   └── CONSTRAINT_AUDIT.md
│
└── architecture/nuvemshop/
    ├── README.md (navigation)
    └── FTP_ARCHITECTURE.md

.aiox-core/data/
└── nuvemshop-patterns.yaml   → Constraints registry
```

**Benefit:** As you add integrations (Shopify, Stripe), structure scales naturally.

---

## Naming Conventions (Detailed)

### Documentation Files

```
[FEATURE]_[TYPE]_[DESCRIPTOR].md
NUVEMSHOP_FTP_STANDARDS.md
SYSTEM_ARCHITECTURE.md
ERROR_RECOVERY_PROCEDURES.md
PERFORMANCE_ASSESSMENT_FINAL.md
```

### Code Files

```
lowercase-with-hyphens.js/ts/tsx
validate-constraints.js
api-client.ts
Button.tsx (components use PascalCase)
```

### Configuration Files

```
[domain]-[type]-[descriptor].yaml
nuvemshop-patterns.yaml
shopify-constraints.yaml
[domain]-[descriptor].json
patagang-project-state.yaml
```

### Tests

```
[source-file].test.ts / .spec.ts
Button.test.tsx
api-client.test.ts
validate-constraints.spec.js
```

### Task & Workflow Files

```
[action]-[object/domain].md
create-story.md
validate-constraints.md
deploy-to-ftp.md

[name]-workflow.yaml
deployment-workflow.yaml
story-development-cycle.yaml
```

---

## Special Cases & Exceptions

### README.md Navigation Files

Create in every domain folder for navigation:

```markdown
# [Domain Name]

Brief description of this domain's documentation.

## Files in This Domain

| File | Purpose |
|------|---------|
| NUVEMSHOP_FTP_STANDARDS.md | FTP deployment standards |
| CONSTRAINT_GUIDE.md | Detailed constraint guide |
| ERROR_RECOVERY_PROCEDURES.md | Recovery playbooks |

## Related Documentation

- See also: `docs/guides/nuvemshop/` for quick references
- Architecture: `docs/architecture/nuvemshop/`
- Reports: `docs/reports/nuvemshop/`

---

Last Updated: 2026-03-28
Maintained by: @architect
```

### INDEX/Navigation Files

Create when folder has 3+ documents:

```
docs/
├── guides/
│   ├── README.md (main index)
│   └── [domain]/
│       └── README.md (domain-specific index)
```

### Moving/Refactoring Files

When moving a file:

1. **Move to correct folder**
2. **Update ALL cross-references** (grep for old path)
3. **Update navigation/index files** (README.md)
4. **Create commit with clear message**

```bash
git mv old/path/file.md new/path/file.md
git add -A
git commit -m "docs: reorganize [file] to [new location] per L1-L4 standards"
```

---

## Validation Checklist

Before finalizing ANY file:

```
☐ File type identified (doc, code, config, template)
☐ Correct folder per L1-L4 decision tree
☐ Naming convention followed (lowercase/hyphens for code, UPPERCASE for docs)
☐ L4 doc folders have README.md (for navigation)
☐ No scattered files in project root
☐ Cross-references updated (if file moved/created)
☐ Consistent with related files in same folder
☐ .gitignore excludes unnecessary files (.env, node_modules, etc.)
```

---

## Common Pitfalls & Solutions

| Pitfall | Problem | Solution |
|---------|---------|----------|
| Files scattered in root | Poor organization | Use L1-L4 tree |
| README missing in domain | Hard to navigate | Create README.md in every domain folder |
| Old paths referenced | Broken links | Use tools/grep to find + update references |
| Inconsistent naming | Confusion | Follow [DOMAIN]_[TYPE] pattern strictly |
| Code in docs/ | Maintenance nightmare | Keep code in src/, link from docs |
| L1 files edited | Framework broken | L1 is read-only, use L2/L3/L4 instead |

---

## Troubleshooting

### "Where should this file go?"

1. What is its **purpose**? (guide, code, config, template)
2. What **layer** does it belong to? (L1, L2, L3, L4)
3. What **domain** is it for? (nuvemshop, general, shopify)
4. Where are **similar files** stored?

→ Check mapping table above, place file there

### "I moved a file but links broke"

```bash
# Find all references to old path
grep -r "old/path/file" .

# Update references
sed -i 's|old/path/file|new/path/file|g' *.md *.ts *.js

# Create commit
git commit -am "docs: update references after file reorganization"
```

### "Should this be in L2 or L3?"

- **L2** (`.aiox-core/development/`) = Reusable templates, tasks, workflows, checklists
- **L3** (`.aiox-core/data/` + `.claude/rules/`) = Project configuration, patterns, state

Ask: "Will this be reused by multiple agents/projects?"
- YES → L2
- NO → L3

---

## Reference: Complete L1-L4 Tree

```
.aiox-core/
├── core/                     (L1 — NEVER modify)
│   ├── constitution.md
│   ├── cli/
│   └── registry/
│
├── development/              (L2 — Extend-only)
│   ├── tasks/
│   ├── templates/
│   ├── workflows/
│   ├── checklists/
│   ├── agents/
│   └── docs/
│
└── data/                     (L3 — Mutable)
    ├── patterns/
    ├── patagang-project-state.yaml
    └── nuvemshop-patterns.yaml

.claude/
├── rules/                    (L3 — Contextual auto-load)
│   ├── file-structure-standards.md
│   └── [other rules]
└── settings.json            (L3 — Configuration)

docs/                        (L4 — Project runtime)
├── guides/[domain]/
├── reports/[domain]/
├── architecture/[domain]/
├── reviews/[domain]/
├── stories/
├── prd/
└── archive/

src/, tests/                 (L4 — Source code)
```

---

**Version:** 2.0
**Type:** L2 Development Reference (on-demand loaded)
**Maintained by:** @architect
