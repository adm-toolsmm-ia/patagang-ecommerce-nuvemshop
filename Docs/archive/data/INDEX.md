# Archive Index — Historical Data (AIOX L4)
**Type:** Archive Navigation (L4)
**Date Created:** 2026-03-27
**Scope:** Historical project data from EPIC-8, EPIC-9, incidents
**Status:** Reference only — not loaded in default context
**Authority:** @architect, @aiox-master

---

## 🗂️ Structure

```
docs/archive/data/
├── epic-8-completion/         — EPIC-8 closure (completed)
├── epic-9-completion/         — EPIC-9 Fase A (v1.5.139 stable)
├── incidents/
│   └── v1.5.164-utf8-incident/ — UTF-8 encoding incident (CRITICAL LESSON)
└── INDEX.md                   — This file
```

---

## 📌 What's Here

### EPIC-8 Completion
**Status:** ✅ COMPLETED
**Version:** v1.5.133 → v1.5.139
**Duration:** 5 days (CSS cleanup + banner styling)
**Outcome:** 29% CSS reduction + banner color fix

**Files Archived:**
- Original execution plans
- Phase-by-phase progress reports
- Final summaries and sign-offs
- Status updates and checkpoints

**Lessons Extracted:**
→ See `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md`

---

### EPIC-9 Completion (Phase A)
**Status:** ✅ FASE A COMPLETE
**Version:** v1.5.139 (stable production)
**Duration:** 5 days (Opção 3 Hybrid approved)
**Outcome:** CSS dependency mapping + orphan cleanup + banner styling

**Files Archived:**
- Decision logs (Opção 1 vs 2 vs 3 analysis)
- Phase A execution plans
- Daily progress reports
- Final validation and sign-off

**Lessons Extracted:**
→ See `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md`

**Next Phase (Fase B):**
Stories 9.2-9.6 (3 weeks at 2x velocity after cleanup)
Target: 2 stories/week (vs. 0.5/week with patches)

---

### Incidents
**Directory:** `docs/archive/data/incidents/`

#### v1.5.164 UTF-8 Encoding Incident
**Status:** ✅ RESOLVED (v1.5.166 deployed)
**Severity:** CRITICAL
**Root Cause:** Aggressive sed pattern deleted 1,940 CSS lines instead of normalizing characters

**What Happened:**
```
v1.5.164: sed '/[ã-ÿçÇ—–]/d'  → deleted entire lines
Result: HTTP 500, header icons broken
Recovery: Rollback to v1.5.163 (3 min recovery)
Solution: Perl script with character mapping (v1.5.166)
```

**Files Archived:**
- Root cause analysis (technical details)
- Impact assessment (what broke, why)
- Solution documentation (safe normalization)
- Lessons learned (script safety, encoding strategy)

**Lessons Extracted:**
→ **CRITICAL LESSON:** "Character Encoding Must Use Safe Normalization, NOT Line Deletion"
→ See `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md` § LESSON 3

---

## 🔍 How to Find Information

### "I need to understand v1.5.164 incident"
1. Start here: `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md` § LESSON 3
2. Deep dive: `docs/archive/data/incidents/v1.5.164-utf8-incident/`

### "I need EPIC-9 decision rationale"
1. Start here: `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md` § LESSON 4
2. Reference: `.aiox-core/data/EPIC-9-DECISION-LOG.yaml` (still in active data!)

### "I need CSS refactoring guidance"
1. Start here: `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md` § LESSON 1-2
2. Implementation: `.claude/rules/css-refactoring-safety-pattern.md`

### "I need historical timeline"
1. Browse: `docs/archive/data/epic-8-completion/` or `epic-9-completion/`
2. Or: Check `.aiox-core/data/patagang-legacy-archive-index.yaml` for full file list

---

## 📊 Archive Inventory

**Total Files Archived:** 31 files
**Reference Location:** `.aiox-core/data/patagang-legacy-archive-index.yaml`

### Categories
| Category | Count | Status |
|----------|-------|--------|
| EPIC-8 markdown reports | 8 | Archived (reference only) |
| EPIC-9 phase reports | 8 | Archived (reference only) |
| Incident analysis | 3 | Archived (CRITICAL lessons extracted) |
| Config/state checkpoints | 5 | Archived (superseded by v1.5.170 state) |
| Investigation reports | 7 | Archived (lessons documented) |

---

## ✅ Active vs Archived Decision

### Still in `.aiox-core/data/` (ACTIVE)
```
✅ patagang-project-state.yaml (v1.5.170 current state)
✅ patagang-learned-patterns.yaml (active patterns)
✅ EPIC-9-DECISION-LOG.yaml (decision reference, not stale)
✅ Other framework files (nuvemshop-patterns, learned-patterns, etc.)
```

### Moved to `docs/archive/data/` (REFERENCE ONLY)
```
📦 31 historical files (execution plans, phase reports, old state snapshots)
📦 Reference via this INDEX.md
📦 Lessons extracted → LESSONS-LEARNED-SYNTHESIS.md
```

---

## 📖 How Archive Supports AIOX

**Problem Solved:**
- ✅ Historical files no longer load in default agent context
- ✅ Lessons captured in reusable format (LESSONS-LEARNED-SYNTHESIS.md)
- ✅ Rastreabilidade preserved (INDEX.md + ARCHIVE-INVENTORY)
- ✅ ~12-15k tokens freed up for active work

**Agent Impact:**
- @dev: Access CSS lessons without historical clutter
- @qa: Reference incident patterns without old logs
- @architect: Review decisions without legacy context
- All agents: Faster context loading, cleaner memory

**Project Impact:**
- Knowledge preserved (rastreabilidade 100%)
- Architecture decisions documented (L2 format)
- Incident lessons operationalized (patterns, not reports)
- Future similar incidents prevented (lessons embedded)

---

## 🔄 Future Maintenance

### When to Archive More
- After each completed EPIC or major milestone
- Incident resolution → extract lessons → archive files
- Quarter-end retrospective → consolidate learning → archive old state

### When to Update This INDEX
- New archive section added
- Major lesson updated
- Links/paths change
- Status updates (e.g., "Fase A → Fase B starting")

### Who Maintains
- **This INDEX:** @architect
- **LESSONS-LEARNED:** @architect + relevant agents (dev, qa, etc.)
- **Archive decisions:** @aiox-master, @architect

---

## 📞 Getting Help

### "How do I access archived files?"
```
Open: docs/archive/data/
Browse: epic-8-completion/, epic-9-completion/, incidents/
Or: Reference this INDEX.md
```

### "I need the decision for Opção 3"
```
Read: .aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md § LESSON 4
Or (detailed): .aiox-core/data/EPIC-9-DECISION-LOG.yaml
```

### "Did we learn from v1.5.164?"
```
Yes! See: .aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md § LESSON 3
Implementation: .claude/rules/css-refactoring-safety-pattern.md
```

---

**Version:** 1.0.0
**Status:** ACTIVE (reference index)
**Last Updated:** 2026-03-27
**Maintained by:** @architect
