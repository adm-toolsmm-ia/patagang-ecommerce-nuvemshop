# CSS Refactoring Safety Pattern — AIOX Standard

**Type:** Contextual Rule (L3 — AIOX Best Practice)
**Created:** 2026-03-26 (Post-incident)
**Authority:** @aiox-master, @dev (Dex)
**Severity:** CRITICAL — Prevents CSS cascade failures
**Based on:** Epic 9 Phase A incident (v1.5.136 failure)

---

## 🎯 PRINCIPLE

**Never remove more than 15-20 CSS rules in a single deployment.**

Aggressive batching (50+ rules) breaks CSS cascade and causes 500 errors.
Safe batching (10-15 rules) ensures validation gates can catch issues early.

---

## 📊 INCIDENT CONTEXT (2026-03-26)

- **Attempt:** Remove 59 duplicate !important rules in one batch
- **Result:** HTTP 500 error, loja completely down
- **Root Cause:** CSS cascade interdependencies broken by aggressive de-duplication
- **Recovery:** Rollback in < 2 minutes
- **Lesson:** Small batches + validation between = SUCCESS

---

## ✅ SAFE PATTERN (MANDATORY)

### Batch Size Limits

```
Maximum per batch:
• Orphaned rules (not in HTML):     5-10 rules
• Obvious duplicates (same line):   10-15 rules
• Critical rules:                    1-2 rules (extra caution)

NEVER exceed 15 rules per deployment.
```

### Execution Flow

```
1. Identify 10-15 candidates for removal
2. Remove rules + create commit
3. Deploy to FTP
4. Validate (HTTP 200, CSS syntax, console, visual)
5. If OK: proceed to next batch
6. If ERROR: rollback + investigate + retry
```

### Validation Gates (MANDATORY)

After EVERY deployment:

```
☐ HTTP 200 (not 500 error)
☐ CSS Syntax valid
☐ Browser Console no errors
☐ Critical classes present
☐ Core pages load without FOUC
☐ Mobile responsive
☐ Gabriel visual check (if needed)

If ANY fails: IMMEDIATE ROLLBACK
```

---

## 🔧 IMPLEMENTATION RULES

### For @dev (Code Changes)
1. Analyze rule candidates (10-15 max per batch)
2. Create atomic commit per batch
3. Wait for validation before next batch

### For @devops (Deployment)
1. Deploy each batch independently
2. Monitor HTTP status in real-time
3. Auto-rollback on error
4. Tag each version for tracking

### For @qa (Validation)
1. Validate after EACH deployment
2. Run full checklist
3. Document results
4. Flag warnings for next batch

---

## 📈 COMPARISON: Aggressive vs Safe

**Aggressive (FAILED in v1.5.136):**
- Hour 1-6: Implementation (59 rules, 1 batch)
- Hour 6-7: Recovery from 500 error
- Total: 7 hours for ~36% reduction (FAILED)

**Safe (RECOMMENDED):**
- Hour 1-6: 6 batches × (implement + validate)
- Hour 7: Final documentation
- Total: 7 hours for 60 rules removed (SUCCESS)

**Result:** Safe takes SAME TIME but GUARANTEES SUCCESS with zero rollbacks.

---

## 🚨 ANTI-PATTERNS (NEVER DO)

- ❌ Remove 50+ rules in one operation
- ❌ De-duplicate programmatically without semantic validation
- ❌ Skip validation gates between batches
- ❌ Assume "duplicate lines" are safe without testing
- ❌ Deploy without HTTP status check

---

## ✅ BEST PRACTICES (ALWAYS DO)

- ✅ Batch in small units (10-15 max per deployment)
- ✅ Validate between every batch
- ✅ Use atomic commits with clear messages
- ✅ Tag versions for rollback capability
- ✅ Document decisions in commit messages
- ✅ Keep Gabriel in the loop for visual validation

---

## 🎓 LESSONS LEARNED

1. **Batch Size Matters** — 9 rules work ✅, 59 rules fail ❌
2. **Cascade is Complex** — Interdependencies not obvious
3. **Validation Gates Save Time** — Catch issues early
4. **Conservative Always Wins** — Safe approach is faster overall

---

**Status:** ✅ ACTIVE (enforced for all CSS refactoring)
**Applied to:** Epic 9 Phase A (continuing), Epic 9.2 (future)
**Learned from:** v1.5.136 failure → automated rollback success

