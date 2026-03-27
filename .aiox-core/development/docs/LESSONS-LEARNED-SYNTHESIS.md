# Lessons Learned Synthesis — Patagang Ecommerce
**Type:** L2 Development Documentation (Reference for agents)
**Created:** 2026-03-27
**Scope:** Consolidated learnings from EPIC-8, EPIC-9, and production incidents
**Authority:** @architect, @dev, @qa
**Status:** ACTIVE (operational guidance)

---

## 🎯 Purpose

Preserve critical lessons from completed work without loading stale decision logs into agent context. These are **operational patterns** agents should know.

---

## 📚 LESSON 1: CSS Cascade Requires Dependency Analysis

**Source:** Story 9.1 (banner color fix, 5 deploy attempts)
**Root Cause:** CSS !important rules (806 total) with unclear dependencies
**Resolution:** EPIC-9 Opção 3 (Hybrid) — 5-day cleanup + 3-week story acceleration

### Pattern
```
Problem: Visual change doesn't apply
↓
Root Cause: Inline CSS or higher-specificity rule overriding your change
↓
Solution: Map cascade order (style-critical → style-colors → style-async → inline)
↓
Prevention: Always investigate layout.tpl + existing CSS before implementing
```

### Files Involved
- `theme-deploy-corrigido/layouts/layout.tpl` (inline styles)
- `theme-deploy-corrigido/static/css/style-critical.tpl` (critical path)
- `theme-deploy-corrigido/static/css/style-async.scss.tpl` (async loading)

### Apply When
- ✅ Visual adjustment doesn't apply as expected
- ✅ Same selector appears in multiple files
- ✅ !important declarations conflict
- ✅ Local testing shows change, FTP deployment doesn't

### Key Insight
**Cascade is decisive.** Before removing or adding CSS, understand load order and specificity hierarchy.

---

## 📚 LESSON 2: Safe CSS Refactoring Requires Conservative Batching

**Source:** v1.5.136 failure (59 rule removal batch = HTTP 500)
**Root Cause:** Aggressive batching (50+ rules) broke cascade interdependencies
**Resolution:** `.claude/rules/css-refactoring-safety-pattern.md` (max 10-15 rules/batch)

### Pattern
```
Safe Batch Size: 10-15 rules per deployment
↓
✅ Local testing + CodeRabbit validation
↓
✅ FTP deploy + HTTP 200 check
↓
✅ Lighthouse validation + visual inspection
↓
Decision: PASS → next batch | FAIL → rollback + investigate
```

### Validation Gates (MANDATORY)
- [ ] HTTP 200 (not 500)
- [ ] CSS syntax valid
- [ ] Console errors: 0
- [ ] Critical classes present
- [ ] Mobile responsive: YES
- [ ] Gabriel visual check: APPROVED

### Apply When
- ✅ Removing orphaned CSS classes (not in HTML)
- ✅ Deduplicating redundant !important rules
- ✅ Consolidating similar selectors
- ✅ Removing unused media queries

### Key Insight
**Small batches win.** 15 rules per deployment = high confidence. 59 rules = cascade failure.

---

## 📚 LESSON 3: Character Encoding Must Use Safe Normalization, NOT Line Deletion

**Source:** v1.5.164 incident (sed pattern deleted 1,940 lines!)
**Root Cause:** Aggressive sed pattern `/[ã-ÿçÇ—–]/d` deleted entire lines, not just characters
**Resolution:** Perl script with explicit character mapping (normalize-accents-safe.pl)

### Pattern
```
Problem: UTF-8 characters cause encoding errors in FTP
↓
❌ WRONG: sed '/[accents]/d'  → Deletes entire lines!
↓
✅ RIGHT: Perl + explicit mapping (á→a, é→e, ç→c, etc.)
↓
Validate: Line count identical, CSS structure preserved, pure ASCII
```

### Character Mapping (Safe)
```perl
á→a, à→a, â→a, ä→a
é→e, è→e, ê→e, ë→e
ó→o, ò→o, ô→o, ö→o
í→i, ì→i, î→i, ï→i
ú→u, ù→u, û→u, ü→u
ã→a, õ→o, ç→c (plus capitals)
—→-, –→-
```

### Validation Before Deploy
- [ ] Line count identical
- [ ] CSS selectors > 95% preserved
- [ ] No accented characters remain
- [ ] File = pure US-ASCII
- [ ] diff size < 500 lines

### Apply When
- ✅ Converting UTF-8 files to US-ASCII
- ✅ Normalizing special characters
- ✅ Any character-level transformation

### Key Insight
**Structure before content.** Never delete lines to fix encoding. Normalize characters only.

---

## 📚 LESSON 4: EPIC-9 Opção 3 (Hybrid) Accelerates Story Velocity 3x

**Source:** EPIC-9-DECISION-LOG.yaml (Gabriel + all agents approved)
**Decision:** 5-day CSS cleanup (Fase A) → enables 3-week story execution (Fase B) at 2x velocity

### Pattern
```
Current: 0.5 stories/week (5+ deploys per story, patch-based)
↓
Invest: 5 days CSS cleanup (Fase A) → remove orphans, deduplicate !important
↓
Result: 2 stories/week (1-2 deploys per story, clean cascade)
↓
ROI: -5 days today, +10 days saved tomorrow = +10 net days gained
```

### Fase A (Days 1-5)
1. **Days 1-2:** CSS dependency mapping (which rules are critical?)
2. **Days 3-4:** Remove orphans + consolidate redundant rules (daily deploy + Gabriel validation)
3. **Day 5:** Final validation (Lighthouse 90+, visual regression test)

### Fase B (Days 6-21, 3 weeks)
- Story 9.2 (Gallery): 5-7 days → **2-3 days** ✅
- Story 9.3 (Info Card): 5-7 days → **2-3 days** ✅
- Story 9.4 (WhatsApp): 3-5 days → **1-2 days** ✅
- Story 9.5 (Cart): 5-7 days → **2-3 days** ✅
- Story 9.6 (Consolidation): 2-3 days → **1 day** ✅

### Success Criteria
- [ ] CSS classes: 1,246+ → 700-800
- [ ] !important rules: 806 → 400-500 (50% reduction)
- [ ] Zero regressions (Lighthouse + visual test)
- [ ] All Gabriel daily validations PASSED
- [ ] Documentation complete

### Apply When
- ✅ CSS architecture has 50%+ legacy/redundant rules
- ✅ Story velocity suffering from cascade issues
- ✅ Team morale affected by multiple deploy cycles
- ✅ Technical payoff > 10 days net gain

### Key Insight
**Invest today, accelerate tomorrow.** Strategic cleanup unblocks story pipeline.

---

## 📚 LESSON 5: Nuvemshop Constraints Are Non-Negotiable (8/8 Checks)

**Source:** `nuvemshop-ftp-constraints.md` (validated in every QA gate)
**Pattern:** Before ANY deployment, verify:

### Critical Constraints
1. **Checkout Structure** — NO modifications (forms managed by platform)
2. **Footer Attribution** — MUST be visible (Terms of Service)
3. **Contact Form** — NO structural changes (backend integration)
4. **Registration Form** — NO field modifications (CRM sync)
5. **Newsletter Form** — NO submission changes (email marketing)
6. **JavaScript Safety** — NO Nuvemshop function overrides
7. **CSS Size** — < 50 KB critical path (performance)
8. **Auto-generated Files** — NO manual edits (sitemap, RSS, robots.txt)

### Validation Checklist
```
Before deploy:
☐ Checkout form structure unchanged (except styling)
☐ Footer attribution visible
☐ All contact/signup/newsletter forms intact
☐ No JS global overrides (Nuvemshop.*, $, etc.)
☐ CSS < 50 KB
☐ No auto-generated files modified
☐ CodeRabbit PASS
☐ All 8/8 constraints verified
```

### Apply When
- ✅ Any modifications to theme-deploy-corrigido/
- ✅ Before every FTP deployment
- ✅ During QA gate validation

### Key Insight
**Constraints are boundaries.** Respect them = production stability. Violate them = platform issues.

---

## 🔄 Summary: Operational Decision Tree

```
CSS Change Needed?
↓
[1] Understand cascade (styles-critical → inline)
[2] Batch size ≤ 15 rules
[3] Local test + CodeRabbit
[4] FTP deploy + HTTP 200 check
[5] Gabriel validation (visual + mobile + console)
[6] PASS → commit to main | FAIL → rollback + investigate
↓
Always: Check 8/8 Nuvemshop constraints
```

---

## 📞 When to Reference This Document

### For @dev
- Planning CSS refactoring? → Read LESSON 1-2, apply Opção 3
- Normalizing characters? → Read LESSON 3 (Perl, not sed!)
- Deploying theme changes? → Check LESSON 5 (8/8 constraints)

### For @qa
- Validating CSS changes? → Use LESSON 2 checklist
- Checking constraints? → Use LESSON 5 validation
- Reviewing incident patterns? → Reference LESSON 1-4

### For @architect
- Designing CSS architecture? → Study LESSON 1 (cascade dependencies)
- Planning epic work? → Reference LESSON 4 (hybrid approach ROI)
- Setting standards? → Use LESSON 2-3-5 (batching, encoding, constraints)

---

## 🏛️ Ownership & Maintenance

| Lesson | Learned From | Authority | Review Frequency |
|--------|-------------|-----------|-----------------|
| 1 | Story 9.1 cascade issues | @architect | Quarterly |
| 2 | v1.5.136 cascade failure | @dev + @qa | On each CSS refactor |
| 3 | v1.5.164 encoding incident | @dev | Quarterly |
| 4 | EPIC-9 decision log | @pm + @architect | Project retrospective |
| 5 | Nuvemshop platform requirements | @qa + @architect | On policy changes |

---

## 📋 Related Files

**Framework Reference:**
- `.claude/rules/css-refactoring-safety-pattern.md`
- `.claude/rules/nuvemshop-ftp-constraints.md`
- `.claude/rules/patagang-ftp-production-standard.md`

**Historical Context (Archived):**
- `docs/archive/data/epic-8-completion/`
- `docs/archive/data/epic-9-completion/`
- `docs/archive/data/incidents/v1.5.164-utf8-incident/`

**Project State (Active):**
- `.aiox-core/data/patagang-project-state.yaml`
- `.aiox-core/data/patagang-learned-patterns.yaml`

---

**Version:** 1.0.0
**Status:** ACTIVE
**Last Updated:** 2026-03-27
**Maintained by:** @architect
