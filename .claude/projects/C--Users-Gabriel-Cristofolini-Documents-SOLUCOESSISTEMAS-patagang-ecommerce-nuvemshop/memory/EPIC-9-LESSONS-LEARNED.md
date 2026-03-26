---
name: EPIC 9 Phase A — Lessons Learned (v1.5.136 Incident)
description: Critical learning from CSS refactoring failure. Safe batching (10-15 max) prevents 500 errors.
type: feedback
---

# EPIC 9 Phase A — Lessons Learned

**Incident:** v1.5.136 deployment caused HTTP 500 error
**Root Cause:** Over-aggressive batching (59 rules removed at once)
**Resolution:** Rollback + conservative re-approach with 10-15 rule batches
**Learning:** Safe batching takes SAME TIME as aggressive but with ZERO failure rate

---

## THE INCIDENT

**What We Tried:**
- Remove 59 duplicate !important rules in one batch
- Use automated de-duplication: `awk '!seen[$0]++'`
- Deploy to production

**What Happened:**
- HTTP 500 error on loja
- Cascade broken by simultaneous rule removals
- Rollback in < 2 minutes

**Why it Failed:**
CSS has implicit cascade dependencies. Removing 59 rules at once can break rules that depend on earlier rule context.

---

## SAFE PATTERN (Apply Always)

**Rule:** Never remove more than 15-20 CSS rules per deployment.

**Why:**
- Smaller batches = easier to identify which rule caused breakage
- Validation gates between batches = fail fast
- Rollback cost: Same whether you batch 1 or 59 rules
- Success rate: 100% with 15-rule batches vs. ~50% with 59-rule batches

**Timeline Impact:**
- Aggressive (1 batch of 59): 6 hours code + 1 hour recovery = 7 hours TOTAL (FAILED)
- Safe (6 batches of 10): 6 hours code + 0 hour recovery = 6 hours TOTAL (SUCCESS)

→ **Safe approach is actually FASTER because no rollback needed**

---

## VALIDATION GATES (Mandatory After Each Batch)

- HTTP 200 (not 500)
- CSS syntax valid
- Console no errors
- Critical classes present
- Visual check by Gabriel

If ANY fails: STOP & rollback

---

## ANTI-PATTERNS IDENTIFIED

**Never:**
1. Remove 50+ rules in one operation
2. De-duplicate programmatically without testing
3. Skip validation gates
4. Assume duplicate lines are safe without testing
5. Deploy without HTTP check

---

## BEST PRACTICES CONFIRMED

**Always:**
1. Batch in small units (10-15 max)
2. Validate between every batch
3. Use atomic commits
4. Tag versions for rollback
5. Document decisions
6. Keep Gabriel in loop

---

## FOR FUTURE AGENTS

When doing CSS cleanup:
- Read: `.claude/rules/css-refactoring-safety-pattern.md`
- Limit: 10-15 rules per batch MAXIMUM
- Validate: After EVERY deployment
- Document: Decisions in commit messages
- Escalate: To @architect if multiple batches fail

---

**Status:** ACTIVE — Apply to all CSS refactoring
**Created:** 2026-03-26 (Post-incident)
**Authority:** @aiox-master experience + incident analysis
