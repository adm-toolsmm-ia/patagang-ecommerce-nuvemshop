# AIOX Architecture Reference — Safe Cleanup Guidelines

**Document Type:** Framework Reference (L2)
**Created:** 2026-03-26
**Maintained By:** @architect
**Status:** ACTIVE

---

## Executive Summary

This document provides a structured reference for AIOX architecture to ensure all cleanup and organization activities respect:
- **6 Constitutional Articles** (non-negotiable principles)
- **4-Layer Architecture** (framework vs project separation)
- **10 Specialized Agents** (exclusive authorities)
- **4 Primary Workflows** (development patterns)
- **17 Auto-Load Rules** (contextual governance)

**Golden Rule:** Limpeza segura NUNCA violará Constitution ou hierarquia de autoridades.

---

## 1. Constitutional Articles (6)

### I. CLI First (NON-NEGOTIABLE)
- CLI é fonte da verdade
- Preserve: CLI docs, command references
- Never: Remove CLI interfaces

### II. Agent Authority (NON-NEGOTIABLE)
- Cada agente tem autoridades exclusivas
- @devops: git push, gh pr (ONLY)
- Preserve: Agent MEMORY.md (all 11), authorities
- Never: Remove or consolidate authorities

### III. Story-Driven Development (MUST)
- Todo dev começa com uma story
- Preserve: Active stories (docs/stories/)
- Archive: Stories > 6 months Done status
- Never: Delete active story requirements

### IV. No Invention (MUST)
- Specs derivam de requisitos, não inventam
- Preserve: Research docs (source of truth)
- Never: Delete research

### V. Quality First (MUST)
- Qualidade inegociável (lint, test, build, CodeRabbit, @qa-gate)
- Preserve: Quality gate documentation
- Never: Remove gates

### VI. Absolute Imports (SHOULD)
- Imports sempre absolutos
- Validate: All imports use absolute paths

---

## 2. Layered Architecture (L1-L4)

| Layer | Location | Mutability | Contents | Action |
|-------|----------|-----------|----------|--------|
| **L1** | .aiox-core/core/ | ❌ NEVER | Constitution, CLI core | ❌ Never modify |
| **L2** | .aiox-core/development/ | Extend-only | Agents, tasks, workflows, templates | ✅ Create new, deprecate old |
| **L3** | .aiox-core/data/, .claude/rules/ | Mutable (careful) | Rules (17), patterns, state | ✅ Update, archive, never delete active |
| **L4** | docs/, src/, tests/ | ✅ Always | Stories, code, docs, reports | ✅ Safe to organize, archive |

---

## 3. Agent System (11 Total)

All have MEMORY.md in L2 (inviolable):

| Agent | Exclusive Authority | Preserve |
|-------|-------------------|----------|
| @dev | Code implementation | dev/MEMORY.md |
| @qa | Quality verdicts | qa/MEMORY.md |
| @architect | Architecture decisions | architect/MEMORY.md |
| @pm | Epic creation, spec writing | pm/MEMORY.md |
| @po | Story validation (10-pt) | po/MEMORY.md |
| @sm | Story creation | sm/MEMORY.md |
| @analyst | Research & analysis | analyst/MEMORY.md |
| @data-engineer | Database design | data-engineer/MEMORY.md |
| @ux-design-expert | UX/UI design | ux-design-expert/MEMORY.md |
| @devops | git push, CI/CD (EXCLUSIVE) | devops/MEMORY.md |
| @aiox-master | Framework governance | — |

**Never: Delete any MEMORY.md file**

---

## 4. Primary Workflows (4)

### SDC (Story Development Cycle)
@sm → @po (10-pt) → @dev → @qa (7-check) → @devops

### QA Loop (Iterative)
@qa review → verdict → @dev fixes (max 5) or escalate

### Spec Pipeline (Pre-Implementation)
Gather → Assess → Research → Spec → Critique → Plan (6 phases)
Constitutional Gate: Every spec statement traces to FR-*/NFR-*/CON-*/research

### Brownfield Discovery (Legacy)
10-phase technical debt assessment

**Preserve:** All workflow documentation, procedures, checklists

---

## 5. Rules System (17 Auto-Load)

**All in .claude/rules/, auto-load on file pattern triggers:**

1. agent-authority.md (NON-NEGOTIABLE)
2. agent-handoff.md
3. agent-memory-imports.md
4. coderabbit-integration.md
5. ids-principles.md
6. mcp-usage.md
7. story-lifecycle.md (NON-NEGOTIABLE)
8. workflow-execution.md (NON-NEGOTIABLE)
9. file-structure-standards.md (AUTO-LOAD)
10. nuvemshop-ftp-constraints.md (CRITICAL)
11. communication-language-portuguese.md (MANDATORY)
12. devops-epic8-standard-workflow.md (ACTIVE)
13. epic-8-execution-workflow.md (ACTIVE)
14. css-refactoring-safety-pattern.md (CRITICAL)
15. patagang-ftp-production-standard.md (ACTIVE)
16. tool-examples.md
17. tool-response-filtering.md

**Never:** Delete active rules (move to .deprecated/ instead)

---

## 6. Preservation Hierarchy

### TIER 1: INVIOLABLE (Never Delete)
```
✅ L1: .aiox-core/core/*
✅ L2: .aiox-core/development/agents/*/MEMORY.md (all 11)
✅ L2: Tasks, workflows, checklists, templates
✅ L3: .claude/rules/*.md (all 17)
✅ L3: Pattern registries, active configurations
✅ L4: docs/stories/* (active)
✅ L4: docs/prd/* (requirements)
```

### TIER 2: Archive if Conditions Met
```
⚠️ Stories > 6 months + Done → docs/stories/.archive/
⚠️ Reports > 30 days → docs/reports/.archive/
⚠️ Reviews > 30 days → docs/reviews/.archive/
⚠️ Guides > 1 year old (if newer exists)
```

### TIER 3: OK to Delete
```
✅ Temp files (.tmp, .bak)
✅ Build artifacts (dist/, node_modules/)
✅ Cache files (.cache/, .next/)
✅ Test data, mock data
✅ CI/CD logs > 30 days (after archived)
```

---

## 7. Safe Cleanup Process

### Phase 1: Audit (Read-Only)
- Enumerate all files
- Classify by layer (L1-L4) and type
- Identify active vs dormant

### Phase 2: Validate Against AIOX
- Check: Correct layer?
- Check: Violates Constitution?
- Check: Violates agent authority?
- Check: Active or dormant?

### Phase 3: Propose Changes (Get Approval)
- DELETE: With justification (TIER 4 only)
- ARCHIVE: Destination path (TIER 2-3)
- CONSOLIDATE: Merge plan
- UPDATE: Changes needed
- Get approvals: @architect (L2-L3), @pm/@po (stories)

### Phase 4: Execute Carefully
- Commit EVERY change atomically
- Test: `npm run lint`, `npm run build` pass
- Update ALL cross-references
- Document why in commit message

### Phase 5: Verify & Document
- Verify tests pass, build succeeds
- Document in cleanup-history.yaml
- Update CHANGELOG

---

## 8. Golden Rule

**Limpeza segura NUNCA violará Constitution ou hierarquia de autoridades.**

If cleanup:
- ❌ Violates Article I-VI → REJECTED
- ❌ Breaks agent authority → REJECTED
- ❌ Removes active workflow docs → REJECTED
- ❌ Deletes agent MEMORY.md → REJECTED
- ❌ Removes active rules → REJECTED

Then: **AUTOMATICALLY REJECTED**

---

## 9. When in Doubt

- Preserve > Delete (prefer archiving)
- Ask @architect before L2-L3 changes
- Test: `npm run lint`, `npm run build`
- Document decisions in commits

---

**Version:** 1.0 | **Created:** 2026-03-26 | **Maintained By:** @architect | **Status:** ACTIVE
