# AIOX Cleanup & Organization Reference — Summary

**Created:** 2026-03-26
**Purpose:** Structured reference for safe cleanup respecting AIOX architecture
**Key Location:** `.aiox-core/development/docs/AIOX-ARCHITECTURE-REFERENCE-2026-03-26.md`

---

## Golden Rule

**Limpeza segura NUNCA violará Constitution ou hierarquia de autoridades.**

If cleanup violates any of the 6 Constitutional Articles or breaks agent authorities → **AUTOMATICALLY REJECTED**

---

## AIOX Architecture (4 Layers)

| Layer | Location | Mutability | Action |
|-------|----------|-----------|--------|
| **L1** | .aiox-core/core/ | ❌ NEVER | Never modify (protected by deny rules) |
| **L2** | .aiox-core/development/ | Extend-only | Create new, deprecate old (never delete) |
| **L3** | .aiox-core/data/, .claude/rules/ | Mutable (careful) | Update, archive, never delete active rules |
| **L4** | docs/, src/, tests/ | ✅ Always | Safe to organize, archive, update |

---

## Constitutional Articles (6) — INVIOLABLE

| Article | Principle | Cleanup Implication |
|---------|-----------|-------------------|
| **I** | CLI First | Preserve: CLI docs, command references |
| **II** | Agent Authority | Preserve: Agent MEMORY.md (all 11), exclusive authorities |
| **III** | Story-Driven Development | Preserve: Active stories; archive old (> 6 months) |
| **IV** | No Invention | Preserve: Research docs (source of truth) |
| **V** | Quality First | Preserve: Quality gate docs; never remove gates |
| **VI** | Absolute Imports | Validate: All imports use absolute paths |

---

## Protected Assets (TIER 1 — Never Delete)

### Agent MEMORY Files (11 Total)
```
✅ .aiox-core/development/agents/dev/MEMORY.md
✅ .aiox-core/development/agents/qa/MEMORY.md
✅ .aiox-core/development/agents/architect/MEMORY.md
✅ .aiox-core/development/agents/pm/MEMORY.md
✅ .aiox-core/development/agents/po/MEMORY.md
✅ .aiox-core/development/agents/sm/MEMORY.md
✅ .aiox-core/development/agents/analyst/MEMORY.md
✅ .aiox-core/development/agents/data-engineer/MEMORY.md
✅ .aiox-core/development/agents/ux-design-expert/MEMORY.md
✅ .aiox-core/development/agents/devops/MEMORY.md
```

### Rules (17 Total in .claude/rules/)
```
✅ agent-authority.md (NON-NEGOTIABLE)
✅ agent-handoff.md
✅ agent-memory-imports.md
✅ coderabbit-integration.md
✅ ids-principles.md
✅ mcp-usage.md
✅ story-lifecycle.md (NON-NEGOTIABLE)
✅ workflow-execution.md (NON-NEGOTIABLE)
✅ file-structure-standards.md (AUTO-LOAD)
✅ nuvemshop-ftp-constraints.md (CRITICAL)
✅ communication-language-portuguese.md (MANDATORY)
✅ devops-epic8-standard-workflow.md (ACTIVE)
✅ epic-8-execution-workflow.md (ACTIVE)
✅ css-refactoring-safety-pattern.md (CRITICAL)
✅ patagang-ftp-production-standard.md (ACTIVE)
✅ tool-examples.md
✅ tool-response-filtering.md
```

### Stories & Requirements
```
✅ docs/stories/*.md (active stories)
✅ docs/prd/*.md (product requirements)
✅ All task/workflow/checklist definitions in L2
```

---

## Preservation Hierarchy

### TIER 1: INVIOLABLE (Never Delete)
- ✅ L1: .aiox-core/core/*
- ✅ L2: Agent MEMORY.md (all 11) + templates
- ✅ L3: .claude/rules/* (all 17) + active patterns
- ✅ L4: docs/stories/* (active), docs/prd/*

### TIER 2: Archive if Conditions Met
- ⚠️ Stories > 6 months + Done → docs/stories/.archive/
- ⚠️ Reports > 30 days → docs/reports/.archive/
- ⚠️ Reviews > 30 days → docs/reviews/.archive/
- ⚠️ Guides > 1 year old (if newer exists)

### TIER 3: OK to Delete
- ✅ Temp files (.tmp, .bak)
- ✅ Build artifacts (dist/, node_modules/)
- ✅ Cache files (.cache/, .next/)
- ✅ Test data, mock data
- ✅ CI/CD logs > 30 days (after archived)

---

## Safe Cleanup Process (5 Phases)

### Phase 1: Audit & Categorize (Read-Only)
- Enumerate all files
- Classify by layer (L1-L4) and type
- Identify active vs dormant
- **Output:** CLEANUP-AUDIT-YYYY-MM-DD.xlsx

### Phase 2: Validate Against AIOX
- ☐ Correct layer?
- ☐ Violates Constitution?
- ☐ Violates agent authority?
- ☐ Referenced elsewhere?
- ☐ Active or dormant?
- **Output:** CLEANUP-VALIDATION-YYYY-MM-DD.md

### Phase 3: Propose Changes (Get Approval)
- DELETE candidates (TIER 4 only) + justification
- ARCHIVE candidates + destination
- CONSOLIDATE candidates + plan
- UPDATE candidates + changes
- **Approvals:** @architect (L2-L3), @pm/@po (stories), @dev (code)
- **Output:** CLEANUP-PROPOSAL-YYYY-MM-DD.md

### Phase 4: Execute Carefully
- Commit EVERY change atomically
- Test: `npm run lint`, `npm run build` PASS
- Update ALL cross-references
- Document why in commit message
- Preserve git history (no force-push)

### Phase 5: Verify & Document
- ✅ Tests pass, build succeeds
- ✅ Document in cleanup-history.yaml
- ✅ Update CHANGELOG

---

## Key Workflows to Preserve

### Story Development Cycle (SDC)
```
@sm *draft → @po *validate (10-pt) → @dev *develop → @qa *qa-gate (7-check) → @devops *push
```

### QA Loop (Iterative)
```
@qa review → verdict → @dev fixes (max 5) or escalate to @architect
```

### Spec Pipeline (Pre-Implementation)
```
Gather → Assess → Research → Spec → Critique → Plan (6 phases)
Constitutional Gate: Every spec statement traces to FR-*/NFR-*/CON-*/research
```

### Brownfield Discovery (Legacy)
```
10-phase technical debt assessment with specialists
```

**All workflow documentation is TIER 1 INVIOLABLE**

---

## Commit Message Template

```
chore: cleanup and organize [Layer X, Category Y]

Changes:
- ARCHIVED: [items] to [destination] (reason)
- CONSOLIDATED: [items] → [result] (rationale)
- DELETED: [items] (justification)
- UPDATED: [items] (cross-references)

Validation:
- ☐ No AIOX violations
- ☐ All references updated
- ☐ npm run lint passes
- ☐ npm run build passes
- ☐ Archive copies exist

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

---

## When in Doubt

1. **Preserve > Delete** — Prefer archiving to deletion
2. **Ask @architect** — Before any L2-L3 changes
3. **Test First** — `npm run lint`, `npm run build`
4. **Document Always** — Every deletion/archive in commits
5. **Golden Rule** — Never violate Constitution or agent authorities

---

## Key References

- **Full Reference:** `.aiox-core/development/docs/AIOX-ARCHITECTURE-REFERENCE-2026-03-26.md`
- **Constitution:** `.claude/CLAUDE.md` (entire framework rules)
- **File Structure:** `.claude/rules/file-structure-standards.md`
- **Agent Authority:** `.claude/rules/agent-authority.md`
- **Story Lifecycle:** `.claude/rules/story-lifecycle.md`
- **Workflows:** `.claude/rules/workflow-execution.md`

---

## Success Criteria

- ✅ Zero AIOX principle violations
- ✅ Zero agent authority violations
- ✅ npm run lint passes
- ✅ npm run build passes
- ✅ npm run test passes
- ✅ All cross-references updated
- ✅ Archive copies exist for archived items
- ✅ Git history preserved
- ✅ Changes documented in commits

---

**Version:** 1.0
**Created:** 2026-03-26
**Maintained By:** @architect
**Status:** ACTIVE — Reference for all cleanup & organization decisions
