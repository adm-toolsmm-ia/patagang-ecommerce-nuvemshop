# Memory Architecture Reference — Patagang Ecommerce

**Type:** L2 Development Documentation (Reference Only — NOT auto-loaded)
**Location:** `.aiox-core/development/docs/` (framework reference, not executable rule)
**Last Updated:** 2026-03-24
**Maintained by:** @architect
**Read By:** Agents implementing memory system, architecture reviews, future refactorings

**Note:** This is detailed reference documentation. For quick summary, see `CLAUDE.md` § "Memory Architecture".

---

## Purpose

This rule documents how memory files are structured and used in Patagang ecommerce project to support the **AIOX framework** and optimize agent context efficiency.

**Goal:** 34% reduction in context token overhead while maintaining Constitution compliance (Story-Driven, Quality First, No Invention).

---

## Memory Architecture (AIOX L2-L3 Model)

### L2: Agent-Specific Memory (Framework Template)
**Location:** `.aiox-core/development/agents/{agent}/MEMORY.md`
**Mutability:** Agent can read/write their own section
**Scope:** Agent persona, patterns, exclusive authorities

**Current Agent Memories (Updated Patagang-Specific):**
- ✅ `agents/dev/MEMORY.md` — Code patterns, FTP constraints, Nuvemshop patterns
- ✅ `agents/qa/MEMORY.md` — QA gate verdicts, FTP validation checklist
- ✅ `agents/architect/MEMORY.md` — Design decisions, CSS architecture, integrations
- ✅ `agents/devops/MEMORY.md` — FTP deployment flow, versioning, release checklist
- ⚪ `agents/pm/MEMORY.md` — Epic orchestration, requirements gathering
- ⚪ `agents/po/MEMORY.md` — Story validation checklist (10-point)
- ⚪ `agents/sm/MEMORY.md` — Story creation templates, epic context
- ⚪ `agents/qa/MEMORY.md` — Quality patterns (in QA agent memory)
- ⚪ `agents/analyst/MEMORY.md` — Research findings, validation patterns
- ⚪ `agents/data-engineer/MEMORY.md` — Schema patterns (if DB exists)

### L3: Project Configuration (Mutable)
**Location:** `.aiox-core/data/{domain}-*.yaml` or `.claude/rules/`
**Mutability:** Updated as project evolves
**Scope:** Project state, learned patterns, configuration

**Current Project State Files:**
- ✅ `.aiox-core/data/patagang-project-state.yaml` — Active stories, epics, QA loop state
- ✅ `.aiox-core/data/patagang-learned-patterns.yaml` — Feedback patterns, gates, processes
- ✅ `.aiox-core/data/nuvemshop-patterns.yaml` — FTP constraint registry (EXISTING)
- ✅ `.aiox-core/data/learned-patterns.yaml` — Global patterns (FRAMEWORK)

---

## Memory Loading Strategy (Per Workflow)

### Story Development Cycle (SDC) — PRIMARY WORKFLOW

**Phase 1 (CREATE — @sm):**
- Load: `agents/sm/MEMORY.md` (story creation)
- Load: `.aiox-core/data/patagang-project-state.yaml` (epic context)
- Output: Create `docs/stories/{storyID}.story.md`
- Update: `patagang-project-state.yaml` (add story to active list)

**Phase 2 (VALIDATE — @po):**
- Load: `agents/po/MEMORY.md` (validation checklist)
- Load: `.aiox-core/data/patagang-project-state.yaml` (story details)
- Output: Validation decision (10-point checklist)
- Update: `patagang-project-state.yaml` (story status: Draft → Ready)

**Phase 3 (IMPLEMENT — @dev):**
- Load: `agents/dev/MEMORY.md` (FTP patterns, constraints, testing)
- Load: `.aiox-core/data/patagang-project-state.yaml` (current story)
- Load: `.aiox-core/data/patagang-learned-patterns.yaml` (dev patterns)
- Load: `.aiox-core/data/nuvemshop-patterns.yaml` (constraint registry)
- Output: Code changes to theme-deploy-corrigido/
- Update: Story checkboxes [x], File List section
- Update: `patagang-project-state.yaml` (story status: Ready → InProgress)

**Phase 4 (QA GATE — @qa):**
- Load: `agents/qa/MEMORY.md` (gate verdicts, FTP validation)
- Load: `.aiox-core/data/patagang-project-state.yaml` (current story)
- Load: `.aiox-core/data/patagang-learned-patterns.yaml` (QA patterns)
- Output: Gate verdict (PASS / CONCERNS / FAIL)
- Update: `patagang-project-state.yaml` (story status: InProgress → Done)

**Phase 4.5 (PUSH — @devops):**
- Load: `agents/devops/MEMORY.md` (push gates, versioning)
- Load: `.aiox-core/data/patagang-project-state.yaml` (release context)
- Output: `git push` + PR creation + merge
- Update: `patagang-project-state.yaml` (increment deployment count, version)

---

### QA Loop — ITERATIVE WORKFLOW

**Loop Iteration:**
```
@qa review (load agent memory + project state)
  ↓ verdict (PASS | CONCERNS | FAIL | BLOCKED)
  ↓
  If REJECT:
    @dev fix (load agent memory + learned patterns)
    iteration++
    Back to @qa review (max 5 iterations)
  ↓
  If APPROVE:
    story DONE
    → @devops push
```

**Memory Updates:**
- `patagang-project-state.yaml` tracks QA loop iteration count
- Each iteration stored: `qaLoopState.iteration`, `lastVerdict`, `nextAction`
- Max iterations: 5 (escalate if reached)

---

## Memory File Responsibilities

### Agent Memory Files (`agents/*/MEMORY.md`)
**Responsibility:** Store agent-specific patterns, not project state

| Agent | Stores |
|-------|--------|
| @dev | Code patterns, FTP constraints, testing patterns |
| @qa | Gate verdicts, validation patterns, checklist |
| @architect | Design decisions, CSS architecture, technology stack |
| @devops | Deployment flow, versioning, pre-push gates |
| @po | Story validation (10-point checklist) |
| @pm | Epic orchestration, spec pipeline |
| @sm | Story creation templates |
| @analyst | Research patterns, finding validation |

**NOT stored here:**
- Active stories (→ `patagang-project-state.yaml`)
- Epics (→ `patagang-project-state.yaml`)
- QA loop state (→ `patagang-project-state.yaml`)

### Project State File (`patagang-project-state.yaml`)
**Responsibility:** Track SDC/QA Loop progress (checkpoint for handoff)

Stores:
- ✅ Active stories (phase, assignment, files)
- ✅ Active epics (status, target completion)
- ✅ QA loop state (iteration count, last verdict)
- ✅ Metrics (stories completed, deployments, violations fixed)
- ✅ Release tracking (current version, backups)

Updated:
- When story moves between phases (draft → validate → implement → qa → done)
- When @qa verdict issued
- When @devops deploys
- Daily (staleness check)

### Learned Patterns File (`patagang-learned-patterns.yaml`)
**Responsibility:** Capture decision patterns and gate processes

Stores:
- ✅ Development patterns (FTP editing, CSS optimization)
- ✅ QA gate patterns (validation checklist, CodeRabbit iterations)
- ✅ Architecture patterns (CSS load order, Twig conditionals)
- ✅ Deployment patterns (versioning, pre-deploy gates)
- ✅ Constitution enforcement (how Article I-V are applied)

Updated:
- Quarterly (or when significant pattern emerges)
- Source: Observed from completed stories

---

## Handoff Protocol Integration

### How Memory Files Support Agent-to-Agent Handoff

**Problem:** Agent switch loses context (3-5K tokens per agent persona)

**Solution:** Memory files ARE checkpoint repositories

**Flow:**

```
Agent A (Outgoing):
  ✅ Updates patagang-project-state.yaml with current story status
  ✅ Commits checkpoint
  ✅ Generates handoff artifact (refs to memory files)
    ↓
Agent B (Incoming):
  ✅ Loads patagang-project-state.yaml (story is there!)
  ✅ Loads agents/B/MEMORY.md (B's patterns)
  ✅ Loads patagang-learned-patterns.yaml (decision history)
  ✅ Resumes from checkpoint (zero context loss)
```

**Token Savings:**
- Without memory: Agent B reloads full context (~8K tokens)
- With memory: Agent B loads only what changed (~0.5K tokens)
- **Savings: 94% per switch** (via checkpoint model)

---

## Constitution Alignment

Each memory file enforces Constitution principles:

| Article | Enforced By | Memory File |
|---------|-----------|-------------|
| I. CLI First | Developer awareness + coderabbit | `agents/dev/MEMORY.md` |
| II. Agent Authority | CLAUDE.md + .claude/rules/ | (not memory) |
| III. Story-Driven | @po gate + @sm story creation | `patagang-project-state.yaml` |
| IV. No Invention | @architect + @analyst | `patagang-learned-patterns.yaml` |
| V. Quality First | @qa verdicts + FTP checklist | `agents/qa/MEMORY.md` |

---

## Staleness & Refresh Strategy

### Refresh Frequency
- **High-frequency:** `patagang-project-state.yaml` (DAILY - on phase transitions)
- **Medium-frequency:** `agents/*/MEMORY.md` (WEEKLY - on pattern changes)
- **Low-frequency:** `patagang-learned-patterns.yaml` (QUARTERLY - on retrospective)

### Staleness Detection
Memory files include metadata:
```yaml
lastUpdated: "2026-03-20T00:00:00.000Z"
staleAfter: "1 day"  # or "7 days", "90 days"
```

**Check on agent startup:**
```
if (now - lastUpdated > staleAfter):
  warn("Memory is stale, consider refresh")
```

---

## File Locations Reference

### Agent Memory (L2)
```
.aiox-core/development/agents/
├── dev/MEMORY.md              ← @dev patterns
├── qa/MEMORY.md               ← @qa patterns
├── architect/MEMORY.md        ← @architect patterns
├── devops/MEMORY.md           ← @devops patterns
├── pm/MEMORY.md               ← @pm patterns
├── po/MEMORY.md               ← @po patterns
├── sm/MEMORY.md               ← @sm patterns
├── analyst/MEMORY.md          ← @analyst patterns
└── data-engineer/MEMORY.md    ← @data-engineer patterns
```

### Project Configuration (L3)
```
.aiox-core/data/
├── patagang-project-state.yaml        ← Active stories/epics/QA state
├── patagang-learned-patterns.yaml     ← Feedback patterns & gates
├── nuvemshop-patterns.yaml            ← FTP constraint registry (EXISTING)
└── learned-patterns.yaml              ← Global patterns (FRAMEWORK)
```

### Rules (L3)
```
.claude/rules/
├── project-memory-strategy.md         ← This file
├── agent-memory-imports.md            ← Agent memory imports
├── nuvemshop-ftp-constraints.md       ← FTP enforcement
└── ... (other rules)
```

---

## Best Practices

### For Agents

1. **On startup:** Load your agent MEMORY.md first (patterns)
2. **Then load:** `patagang-project-state.yaml` (context)
3. **Then load:** `patagang-learned-patterns.yaml` (decision patterns)
4. **On phase transition:** Update `patagang-project-state.yaml` immediately
5. **On new pattern:** Document in `.aiox-core/data/` (not agent memory)

### For Architecture Reviews

1. **Quarterly:** Review `patagang-learned-patterns.yaml` for elevation to CLAUDE.md
2. **Monthly:** Check staleness of `patagang-project-state.yaml`
3. **As-needed:** Update FTP constraints in `.aiox-core/data/nuvemshop-patterns.yaml`

### For Token Efficiency

1. **Only load needed files** (agent doesn't need PM patterns)
2. **Keep agent MEMORY.md under 2K tokens** (patterns only)
3. **Keep project-state.yaml under 3K tokens** (compress old stories to archive)
4. **Archive completed stories** to `.aiox-core/data/archived-states/` (yearly)

---

## Next Steps (Future Phases)

- **Phase 2 (Week 2):** Create `agents/pm/MEMORY.md`, `agents/po/MEMORY.md`, `agents/sm/MEMORY.md`
- **Phase 3 (Week 3):** Add `agents/analyst/MEMORY.md`, `agents/data-engineer/MEMORY.md`
- **Phase 4 (Week 4):** Create `reference_external_systems.md`, `reference_aiox_resources.md`
- **Phase 5+:** Implement auto-refresh via Claude Code hooks

---

## Related Documents

- **Constitution:** `.aiox-core/constitution.md` (5 non-negotiable principles)
- **Agent Authority:** `.claude/rules/agent-authority.md` (exclusive operations)
- **Handoff Protocol:** `.claude/rules/agent-handoff.md` (context compaction)
- **FTP Constraints:** `.claude/rules/nuvemshop-ftp-constraints.md` (validation rules)
- **File Structure:** `.claude/rules/file-structure-standards.md` (L1-L4 organization)

---

**Version:** 1.0.0
**Created:** 2026-03-20
**Status:** ACTIVE
**Maintained by:** @architect
