# EPIC 9 — FASE A: CSS Cleanup Plan (5 Days)

**Status:** APPROVED & ACTIVE
**Start Date:** 2026-03-27 (Tomorrow)
**Duration:** 5 days (March 27 - March 31)
**Owner:** @dev (Dex)
**Validation:** Gabriel (daily, 4:30 PM)
**Success Criteria:** 50% reduction in `!important`, zero regressions, QA sign-off

---

## 🎯 OBJECTIVE

**Stabilize CSS architecture by:**
1. Removing 200+ orphaned CSS classes (not used in HTML)
2. Consolidating 100+ redundant `!important` rules
3. Reducing `!important` from 806 → ~400-500 (50% reduction)
4. Establishing "zero new `!important`" norm going forward

**Outcome:** Stories 9.2-9.6 will execute 3x faster (1-2 deploys vs. 5+ deploys/story)

---

## 📅 TIMELINE (5 DAYS)

### **DAY 1-2: CSS Dependency Mapping (Wed-Thu)**

#### Morning (Day 1)

**Task 1: Script & Inventory**
```bash
@dev executes:
1. Find all 806 !important rules in layout.tpl
   $ grep -n "!important" theme-deploy-corrigido/layouts/layout.tpl > inventory.txt

2. Categorize each rule:
   - CRITICAL: Blocks platform functionality (Nuvemshop integration, checkout, etc.)
   - NECESSARY: Component specificity (required for layout to work)
   - REDUNDANT: Same rule defined 2+ times elsewhere
   - ORPHANED: Rule for element that doesn't exist in HTML anymore

3. Create dependency map:
   - Rule → Affected elements
   - Elements → Which templates/snipplets use them
   - Dependency graph (visual diagram)
```

**Deliverable:** Inventory spreadsheet + dependency graph

---

#### Afternoon (Day 1)

**Task 2: Gabriel Review & Approval**
```
Gabriel time: 4:30 PM validation
- Review dependency map
- Approve removals (sign off on list)
- Flag any concerns
- Ask questions

Output: Approved removal list (200+ orphans, 100+ redundants)
```

**Checkpoint 1:** Mapping complete, removals approved

---

#### Day 2: Finalize Mapping & Plan Details

**Task 1: Detailed Removal Plan**
```bash
@dev creates removal plan:
1. Order: Remove in sequence to avoid cascading failures
   - Day 2: Orphaned classes (safest)
   - Day 3-4: Redundant !important (test after each)

2. Rollback plan: Each day has rollback option
   - Backup: backups/deployment-1.5.13X/
   - Command: node ftp-deploy/rollback-incremental.js --version vX.X.X

3. Testing matrix: What to validate each day
   - Homepage load
   - Product page load
   - Blog load
   - Mobile responsiveness
   - Checkout flow (critical)
```

**Deliverable:** Detailed 3-day execution plan with rollback procedures

---

#### Afternoon (Day 2)

**Task 2: Final Prep & Tools**

```bash
@dev prepares:
1. Create test suite baseline
   $ lighthouse https://patagang.com.br/ --output-path baseline-1.5.133.html
   $ visual-diff capture baseline-1.5.133.png

2. Prepare daily validation checklist
   - Render performance (Lighthouse score)
   - Visual consistency (diff report)
   - Mobile responsiveness (3 breakpoints)
   - Error console (no JS errors)

3. Set up deployment automation
   - Script for daily deploys (v1.5.134, v1.5.135, v1.5.136)
   - Rollback automation
   - Git tagging automation
```

**Checkpoint 2:** Tools ready, testing baseline established, ready to execute

---

### **DAY 3-4: Remove & Consolidate (Fri-Sat)**

#### Day 3 Morning: Remove Orphaned Classes

```bash
@dev executes:
1. Remove 200+ orphaned CSS classes from style-critical.tpl
   - Orphans: Classes defined but never used in HTML
   - Safest removals (zero dependents)
   - Expected reduction: ~10-15 KB CSS

2. Git commit with detailed message
   $ git commit -m "chore: remove 200+ orphaned CSS classes [EPIC 9 Phase A, Day 3]"

3. Deploy v1.5.134
   $ node ftp-deploy/deploy.js "v1.5.134: Remove orphaned CSS classes [Phase A Day 1]" --force

4. Wait for Gabriel validation (< 4h turnaround)
```

**Validation Checklist (Gabriel):**
```
☐ Homepage renders without layout shifts
☐ Product page renders correctly
☐ Blog page renders correctly
☐ Mobile (< 768px) responsive
☐ Tablet (768-1023px) responsive
☐ Desktop (1024px+) responsive
☐ No JS errors in console (F12)
☐ Lighthouse score >= baseline - 2 points
☐ APPROVED or CONCERNS or ROLLBACK
```

**Checkpoint 3:** Orphans removed, Gabriel validates Day 3 changes

---

#### Day 3 Afternoon: Consolidate Redundant Rules (Batch 1)

```bash
@dev executes:
1. Identify redundant !important rules
   - Same rule defined in multiple places
   - Keep best version, remove duplicates
   - Expected: 30-40 redundancies per day

2. Remove first batch (Day 3: rules 1-40)
   - Commits per 10 rules (easier to track regressions)

3. Deploy v1.5.135
   $ node ftp-deploy/deploy.js "v1.5.135: Consolidate redundant !important (batch 1) [Phase A Day 1b]" --force

4. Gabriel validates (same checklist)
```

**Expected outcome:** v1.5.135 deployed, validated

---

#### Day 4 Morning: Consolidate Redundant Rules (Batch 2)

```bash
@dev executes:
1. Remove redundants batch 2 (rules 41-80)

2. Deploy v1.5.136
   $ node ftp-deploy/deploy.js "v1.5.136: Consolidate redundant !important (batch 2) [Phase A Day 2a]" --force

3. Gabriel validates
```

---

#### Day 4 Afternoon: Final Consolidation (Batch 3)

```bash
@dev executes:
1. Remove redundants batch 3 (rules 81-100)
   - Final push to reach target of 100+ removed

2. Deploy v1.5.137
   $ node ftp-deploy/deploy.js "v1.5.137: Final consolidation (batch 3) [Phase A Day 2b]" --force

3. Gabriel validates
```

**Checkpoint 4:** All 300 removals (200 orphans + 100 redundants) deployed, validated

---

### **DAY 5: Validation & Documentation (Sun)**

#### Morning: Comprehensive Testing

```bash
@qa executes:
1. Lighthouse full test
   $ lighthouse https://patagang.com.br/ --output-path final-1.5.137.html
   - Target: >= 90 mobile, >= 95 desktop
   - Compare to baseline-1.5.133.html

2. Visual regression test
   $ visual-diff compare baseline-1.5.133.png screenshot-1.5.137.png
   - Target: < 2% pixel differences (acceptable)
   - Flag any major changes

3. Performance metrics
   - CSS file size: before vs. after
   - Render time: before vs. after
   - Core Web Vitals: LCP, CLS, FID

4. Mobile responsiveness (3 browsers)
   - Chrome Mobile
   - Safari iOS
   - Firefox Mobile
```

**Success Criteria:**
```
✅ Lighthouse >= 90 mobile (or >= baseline - 1 point)
✅ Visual regression < 2% (acceptable)
✅ CSS size reduced 50% (!important rules)
✅ Zero regressions on critical pages
✅ Mobile responsiveness confirmed
✅ All Gabriel validations passed
```

---

#### Afternoon: Documentation & Sign-Off

```bash
@dev creates final documentation:
1. What Changed (detailed list)
   - 200 orphaned classes removed
   - 100 redundant !important consolidated
   - 806 → ~400-500 !important (final count)
   - ~15-20 KB CSS removed

2. Why Changed (rationale)
   - Orphans: unused code, maintenance burden
   - Redundants: cascade confusion, performance
   - Result: more predictable CSS, faster feature development

3. Impact Analysis
   - Stories 9.2-9.6 will execute 3x faster (1-2 deploys vs. 5+)
   - Velocity improvement: 0.5 → 2 stories/week
   - No functionality changes (same visual output)

4. Next Steps
   - Stories 9.2-9.6 begin Monday (no delay)
   - New norm: zero new !important rules
   - Future: Epic 9.2 full CSS refactor (Q2 2026)

5. Lessons Learned
   - Document what went well
   - Document what was harder
   - Recommendations for next cleanup
```

**Gabriel Sign-Off:**
```
Gabriel reviews:
☐ Testing results (Lighthouse, visual diff, mobile)
☐ Documentation quality
☐ Confidence in stability

Decision:
✅ APPROVED → Proceed to Stories 9.2-9.6 (Monday)
⚠️ CONCERNS → Fix specific issues, retest
❌ FAILED → Rollback, reassess, retry tomorrow
```

**Checkpoint 5:** Phase A complete, Gabriel sign-off, ready for Phase B

---

## 📊 DAILY DEPLOYMENT SCHEDULE

| Day | Version | Change | Expected Size |
|-----|---------|--------|---|
| Wed Day 1 | v1.5.134 | Remove 200 orphaned classes | -10 KB |
| Fri Day 2 | v1.5.135 | Consolidate redundant batch 1 | -5 KB |
| Fri Day 2b | v1.5.136 | Consolidate redundant batch 2 | -5 KB |
| Sat Day 3 | v1.5.137 | Consolidate redundant batch 3 | -3 KB |
| Sun Day 4 | FINAL | Full validation & sign-off | Baseline stable |

**Total reduction:** ~23 KB CSS (149 KB → ~126 KB), 806 → 400-500 !important

---

## 👥 ROLES & RESPONSIBILITIES

### @dev (Dex) — Implementation
```
☐ Day 1-2: Create dependency map + removal plan
☐ Day 3-4: Execute removals + deploy daily
☐ Day 5: Document changes + prepare stories
Availability: Full-time (no interruptions)
Daily standby: Ready for hotfixes if Gabriel reports issues
```

### Gabriel — Validation & Sign-Off
```
☐ Day 1-2 (4:30 PM): Review mapping + approve removals
☐ Day 3-4 (4:30 PM daily): Validate deploys < 4h
☐ Day 5: Review testing results + sign-off
Commitment: 30 min/day (4:30 PM slot) + availability for issues
Escalation: If anything breaks, call immediately (no waiting)
```

### @qa (Quinn) — Quality Gates
```
☐ Day 1: Prepare validation checklist
☐ Day 2-4: Daily QA review (with Gabriel validation)
☐ Day 5: Full regression testing + Lighthouse + visual diff
Success criteria: Zero regressions, QA sign-off required
```

### @sm (River) — Planning & Coordination
```
☐ Day 1: Finalize Stories 9.2-9.6 backlog refinement
☐ Day 2-4: Daily standups (checkpoint)
☐ Day 5: Retrospective + lessons learned
Coordination: Ensure no blockers, team alignment
Next phase: Monday start for Stories 9.2-9.6
```

---

## 🚨 RISK MITIGATION

### If Day 3 breaks something:
```
1. Gabriel reports issue immediately (no delay)
2. @dev analyzes root cause (5 min)
3. Two options:
   a) Quick fix + redeploy (if simple)
   b) Rollback to v1.5.133 + retry tomorrow (if complex)
4. Resume next day (no loss of progress)
```

### If we can't finish in 5 days:
```
Decision point: Day 3 end-of-day
- If on track: Continue as planned
- If behind: Either extend (Day 6) or halt Phase A, revert to patches
- Gabriel decides based on progress + risk assessment
```

### If regression detected:
```
- Rollback immediately (< 5 min)
- Investigate root cause
- Resume day's work with more caution
- Daily debrief to prevent repeat
```

---

## ✅ FINAL SUCCESS CRITERIA

```
TECHNICAL:
✅ 200+ orphaned classes removed
✅ 100+ redundant !important consolidated
✅ 806 → ~400-500 !important (50% reduction)
✅ CSS size reduced ~15-20 KB
✅ Zero regressions detected
✅ Lighthouse >= 90 mobile
✅ Visual regression < 2%

ORGANIZATIONAL:
✅ Gabriel validates daily (no blockers)
✅ Team aligned (standups daily)
✅ QA sign-off complete
✅ Documentation clear

BUSINESS:
✅ Zero delay to Stories 9.2-9.6
✅ Stories now 3x faster (1-2 deploys vs. 5+)
✅ Velocity improvement visible
✅ Team morale improved (success = momentum)
```

---

## 📞 ESCALATION & CONTACT

**If problems during Phase A:**

1. **Gabriel:** Immediate ping (no waiting)
2. **@dev:** Primary (implements fixes)
3. **@qa:** Quality gate (validates)
4. **@sm:** Coordination (keeps team aligned)
5. **@architect:** Architecture decisions (if needed)

**Daily sync:** 4:30 PM (Gabriel validation + team debrief)

---

## 🎯 CHECKPOINT SUMMARY

| Checkpoint | Date | Owner | Success Criteria |
|-----------|------|-------|------------------|
| **1** | Wed Day 1 PM | Gabriel | Mapping approved, removals listed |
| **2** | Thu Day 2 PM | @dev | Tools ready, testing baseline established |
| **3** | Fri Day 3 PM | Gabriel | 200 orphans removed + validated |
| **4** | Sat Day 4 PM | Gabriel | 100 redundants consolidated + validated |
| **5** | Sun Day 5 PM | Gabriel | Full QA + sign-off |

---

## 📚 RELATED DOCUMENTS

- **Decision Record:** `.aiox-core/data/EPIC-9-DECISION-LOG.yaml`
- **Architecture Context:** `Docs/architecture/EPIC-9-EXECUTION-CONTEXT.md`
- **CSS Patterns:** `.aiox-core/data/patagang-css-patterns.yaml`
- **CSS Cascade Guide:** `Docs/architecture/patagang-css-cascade.md`

---

**Document Version:** 1.0.0
**Status:** ACTIVE (Ready for 2026-03-27 execution)
**Created:** 2026-03-26
**Owner:** @dev (Dex)
**Approver:** Gabriel Cristofolini (CTO)
