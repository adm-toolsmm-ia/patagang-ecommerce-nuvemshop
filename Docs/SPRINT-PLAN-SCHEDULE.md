# Sprint Plan - Visual Timeline & Schedule

**Epic:** TDB-2026-001
**Duration:** 8 weeks (Mar 24 - May 16, 2026)
**Team:** 2 developers
**Total Stories:** 21

---

## TIMELINE OVERVIEW

```
WEEK 1        WEEK 2        WEEK 3        WEEK 4        WEEK 5
(Mar 24)      (Mar 31)      (Apr 7)       (Apr 14)      (Apr 21)
│             │             │             │             │
├─ Sprint 1.1  ├─ Sprint 1.2  ├─ Sprint 2.1  ├─ Sprint 2.2  ├─ Sprint 2.3
│ 3 stories    │ 3 stories    │ 2 stories    │ 2 stories    │ 2 stories
│             │ GATE: P1 ✓  │             │             │ GATE: P2 ✓
│             │             │             │             │

WEEK 6        WEEK 7        WEEK 8
(Apr 28)      (May 5)       (May 12)
│             │             │
├─ Sprint 3.1  ├─ Sprint 3.2  ├─ Sprint 4.1
│ 2 stories    │ 1 story      │ 4 stories
│             │ GATE: P3 ✓  │ GATE: EPIC ✓
│             │             │
```

---

## PHASE 1: CRITICAL & FOUNDATION
**Duration:** 2 weeks (Mar 24 - Apr 4)
**Stories:** 6
**Points:** 38
**Hours:** 57-82

### Sprint 1.1 - Week 1 (Mar 24-28)

| Day | Story | Owner | Hours | Deliverable |
|-----|-------|-------|-------|------------|
| Mon-Tue | TDB-2026-001.1.1: Focus Indicators | Dev A | 2-4 | CSS with focus outlines |
| Tue-Wed | TDB-2026-001.1.2: CSS Caching | Dev B | 3-5 | Cache-buster mechanism |
| Wed-Fri | TDB-2026-001.1.3: Jest Setup | Dev A/B | 5-8 | Testing framework live |

**Daily Standup:** 9:00 AM
**Sprint Review:** Friday 4:00 PM
**Blockers:** None expected

### Sprint 1.2 - Week 2 (Mar 31 - Apr 4)

| Day | Story | Owner | Hours | Deliverable |
|-----|-------|-------|-------|------------|
| Mon-Tue | TDB-2026-001.1.4: Alt Text | Dev A | 4-6 | All images labeled |
| Tue-Wed | TDB-2026-001.1.5: CSS Variables | Dev B | 5-8 | Design tokens system |
| Wed-Thu | TDB-2026-001.1.6: Form Labels | Dev A | 3-5 | Proper ARIA labels |
| Thu-Fri | PHASE 1 GATE REVIEW | All | 2-3 | WCAG AA achieved |

**Daily Standup:** 9:00 AM
**Sprint Review:** Friday 4:00 PM
**Phase Gate:** Friday EOD

---

## PHASE 2: ARCHITECTURE & FOUNDATION
**Duration:** 3 weeks (Apr 7 - Apr 25)
**Stories:** 6
**Points:** 71
**Hours:** 102-154

### Sprint 2.1 - Week 3 (Apr 7-11)

| Day | Story | Owner | Hours | Deliverable |
|-----|-------|-------|-------|------------|
| Mon-Tue | TDB-2026-001.2.1: Design System | Dev A | 5-8 | Tokens.json + docs |
| Tue-Thu | TDB-2026-001.2.2: Storybook MVP | Dev B | 8-12 | 15+ components documented |
| Thu-Fri | Testing & refinement | Both | 2-3 | Ready for Phase 2.2 |

**Daily Standup:** 9:00 AM
**Sprint Review:** Friday 4:00 PM

### Sprint 2.2 - Week 4 (Apr 14-18)

| Day | Story | Owner | Hours | Deliverable |
|-----|-------|-------|-------|------------|
| Mon-Tue | TDB-2026-001.2.3: Build Pipeline | Dev A | 6-10 | npm run build working |
| Tue-Wed | TDB-2026-001.2.4: GitHub CI/CD | Dev B | 5-8 | Workflow in GitHub Actions |
| Wed-Fri | Integration & testing | Both | 3-4 | CI/CD green on main |

**Daily Standup:** 9:00 AM
**Sprint Review:** Friday 4:00 PM

### Sprint 2.3 - Week 5 (Apr 21-25)

| Day | Story | Owner | Hours | Deliverable |
|-----|-------|-------|-------|------------|
| Mon-Tue | TDB-2026-001.2.5: JS Testing | Dev A | 6-10 | 15+ tests, 70% coverage |
| Tue-Thu | TDB-2026-001.2.6: GitHub Rules | Dev B | 2-3 | Branch protection active |
| Thu-Fri | PHASE 2 GATE REVIEW | All | 2-3 | Storybook live |

**Daily Standup:** 9:00 AM
**Sprint Review:** Friday 4:00 PM
**Phase Gate:** Friday EOD

---

## PHASE 3: PERFORMANCE & OPTIMIZATION
**Duration:** 2 weeks (Apr 28 - May 9)
**Stories:** 3
**Points:** 21
**Hours:** 28-40

### Sprint 3.1 - Week 6 (Apr 28 - May 2)

| Day | Story | Owner | Hours | Deliverable |
|-----|-------|-------|-------|------------|
| Mon-Tue | TDB-2026-001.3.1: Image Optimization | Dev A | 5-8 | WebP + JPEG, 50% smaller |
| Tue-Thu | TDB-2026-001.3.2: Lighthouse Opt | Dev B | 6-10 | Lighthouse 85+ achieved |
| Thu-Fri | Testing & metrics | Both | 2-3 | Performance locked in |

**Daily Standup:** 9:00 AM
**Sprint Review:** Friday 4:00 PM

### Sprint 3.2 - Week 7 (May 5-9)

| Day | Story | Owner | Hours | Deliverable |
|-----|-------|-------|-------|------------|
| Mon-Wed | TDB-2026-001.3.3: Template Dedup | Dev A | 3-5 | 30% less duplication |
| Wed-Thu | Code review & refine | Dev B | 1-2 | Clean code |
| Thu-Fri | PHASE 3 GATE REVIEW | All | 2-3 | Lighthouse 85+ verified |

**Daily Standup:** 9:00 AM
**Sprint Review:** Friday 4:00 PM
**Phase Gate:** Friday EOD

---

## PHASE 4: POLISH & MAINTENANCE
**Duration:** 1 week (May 12-16)
**Stories:** 4
**Points:** 10
**Hours:** 4-7

### Sprint 4.1 - Week 8 (May 12-16)

| Day | Story | Owner | Hours | Deliverable |
|-----|-------|-------|-------|------------|
| Mon | TDB-2026-001.4.1: Reduced Motion | Dev A | 1-2 | @prefers-reduced-motion |
| Tue | TDB-2026-001.4.2: Mobile Menu | Dev B | 1-2 | UX polish complete |
| Wed | TDB-2026-001.4.3: Documentation | Dev A | 2-3 | Docs complete |
| Thu-Fri | TDB-2026-001.4.4: Team Training | Both | 1-2 | Training delivered |

**Daily Standup:** 9:00 AM
**Sprint Review:** Friday 4:00 PM
**PHASE 4 & EPIC GATE:** Friday EOD

---

## CRITICAL DATES

| Date | Event | Owner | Status |
|------|-------|-------|--------|
| Mar 17 | Sprint plan created | Product | DRAFT |
| Mar 18-22 | Stakeholder review | Product | PENDING |
| Mar 22 | Budget approval | Finance | PENDING |
| Mar 24 | Kick-off meeting | Team | PENDING |
| Mar 24 | Sprint 1.1 starts | Dev A/B | PENDING |
| Apr 4 | Phase 1 complete | QA | PENDING |
| Apr 4 | Phase 1 gate review | Product | PENDING |
| Apr 7 | Sprint 2.1 starts | Dev A/B | PENDING |
| Apr 25 | Phase 2 complete | QA | PENDING |
| Apr 25 | Phase 2 gate review | Product | PENDING |
| Apr 28 | Sprint 3.1 starts | Dev A/B | PENDING |
| May 9 | Phase 3 complete | QA | PENDING |
| May 9 | Phase 3 gate review | Product | PENDING |
| May 12 | Sprint 4.1 starts | Dev A/B | PENDING |
| May 16 | Phase 4 complete | QA | PENDING |
| May 16 | EPIC COMPLETE | Team | PENDING |
| May 17 | Production readiness | Product | PENDING |
| May 24 | Production deployment | DevOps | PENDING |

---

## RESOURCE ALLOCATION

### Developer Capacity: 2 Full-Time

**Dev A:** 40 hours/week
**Dev B:** 40 hours/week
**Total Capacity:** 80 hours/week × 8 weeks = 640 hours available
**Estimated Need:** 156-234 hours = 20-37% of capacity
**Buffer:** 60% (allows for testing, review, debugging, learning)

### Weekly Workload Distribution

```
WEEK 1: 24-32 hours total (12-16 per dev)
WEEK 2: 33-50 hours total (16-25 per dev)
WEEK 3: 25-40 hours total (12-20 per dev)
WEEK 4: 27-41 hours total (13-21 per dev)
WEEK 5: 17-27 hours total (8-14 per dev)
WEEK 6: 25-40 hours total (12-20 per dev)
WEEK 7: 18-27 hours total (9-14 per dev)
WEEK 8: 4-7 hours total (2-4 per dev)

TOTAL: 156-234 hours
AVG per week: 19-29 hours
AVG per dev per week: 10-15 hours (25-37% utilization)
```

---

## DEPENDENCIES & CRITICAL PATH

```
TDB-2026-001.1.2 (CSS Caching) → blocks:
  ├─ TDB-2026-001.1.5 (CSS Variables)
  ├─ TDB-2026-001.2.1 (Design System)
  ├─ TDB-2026-001.3.1 (Image Optimization)
  └─ TDB-2026-001.3.2 (Lighthouse Optimization)

TDB-2026-001.1.3 (Jest Testing) → blocks:
  ├─ TDB-2026-001.2.5 (JS Testing)
  ├─ TDB-2026-001.2.4 (GitHub CI/CD)
  └─ All future testing work

TDB-2026-001.2.3 (Build Pipeline) → blocks:
  ├─ TDB-2026-001.2.4 (GitHub CI/CD)
  ├─ TDB-2026-001.2.5 (JS Testing)
  └─ TDB-2026-001.3.2 (Lighthouse)

TDB-2026-001.2.1 (Design System) → blocks:
  └─ TDB-2026-001.2.2 (Storybook)

TDB-2026-001.3.1 (Image Opt) → blocks:
  └─ TDB-2026-001.3.2 (Lighthouse Opt)

CRITICAL PATH:
TDB-2026-001.1.2 → 1.5 → 2.1 → 2.2 (Design system chain)
TDB-2026-001.1.3 → 2.3 → 2.4 → 2.5 (Testing/CI/CD chain)
TDB-2026-001.3.1 → 3.2 (Image optimization chain)
```

---

## QUALITY GATES

### Phase 1 Gate (End of Week 2: Apr 4)

**Must Pass Before Phase 2:**

- [ ] WCAG AA compliance achieved (0 critical violations)
- [ ] Focus indicators working (WCAG 2.4.7)
- [ ] Alt text complete (WCAG 1.1.1)
- [ ] Form labels fixed (WCAG 1.3.1, 3.3.2)
- [ ] CSS caching workaround documented and tested
- [ ] CSS variables system implemented
- [ ] Jest framework operational (baseline coverage 60%)
- [ ] All 6 stories merged to main
- [ ] All tests passing
- [ ] Zero linting errors
- [ ] QA sign-off obtained
- [ ] Stakeholder approval to proceed

**If Gate Fails:** Return to Phase 1, fix issues, re-test (1-2 weeks)

---

### Phase 2 Gate (End of Week 5: Apr 25)

**Must Pass Before Phase 3:**

- [ ] 15+ components in Storybook
- [ ] Design system documented and complete
- [ ] Build pipeline working (`npm run build < 5s`)
- [ ] GitHub CI/CD passing all PRs
- [ ] 70%+ test coverage on Phase 2 work
- [ ] Branch protection rules enforced
- [ ] All 6 stories merged to main
- [ ] All tests passing
- [ ] Zero linting errors
- [ ] Team trained on new tools
- [ ] Lighthouse score >= 75
- [ ] QA sign-off obtained
- [ ] Stakeholder approval to proceed

**If Gate Fails:** Return to Phase 2, fix issues, re-test (1-2 weeks)

---

### Phase 3 Gate (End of Week 7: May 9)

**Must Pass Before Phase 4:**

- [ ] Lighthouse Performance score >= 85 (mobile)
- [ ] Lighthouse Accessibility >= 90
- [ ] Lighthouse SEO >= 90
- [ ] LCP < 2.5s
- [ ] FCP < 1.5s
- [ ] CLS < 0.1
- [ ] Image size reduction >= 50%
- [ ] All templates deduplicated
- [ ] All 3 stories merged to main
- [ ] No regressions from Phase 1-2
- [ ] All tests still passing
- [ ] QA sign-off obtained
- [ ] Stakeholder approval to proceed

**If Gate Fails:** Return to Phase 3, optimize further, re-test (1-2 weeks)

---

### Phase 4 Gate (End of Week 8: May 16) - EPIC COMPLETE

**Final Verification:**

- [ ] All 21 stories merged to main
- [ ] All phases complete and gates passed
- [ ] WCAG AA compliance: 100%
- [ ] Lighthouse 85+ (mobile)
- [ ] Test coverage: 80%+
- [ ] Documentation complete and reviewed
- [ ] Team training completed and documented
- [ ] All QA checks passed
- [ ] Zero critical or major issues remaining
- [ ] Stakeholder sign-off for production
- [ ] Ready for production deployment

**If Gate Fails:** Extend Phase 4 by 1-2 weeks for fixes

---

## STAGING & PRODUCTION TIMELINE

### Staging Validation (Ongoing)

**Each Sprint:**
- Staging deployment every Friday EOD
- Team validation over weekend (optional)
- Monday standup review of issues found

**Phase Gates:**
- Extended staging validation (2-3 days)
- QA final sign-off
- Product approval before proceeding

### Production Deployment

**Planned:** Week of May 24, 2026

**Pre-Deployment (May 23):**
- [ ] Final Lighthouse audit
- [ ] Final accessibility audit
- [ ] Final test run (Jest + Cypress)
- [ ] Team dry-run of deployment procedure
- [ ] Backup created
- [ ] Rollback plan reviewed
- [ ] Support team briefed

**Deployment Window:**
- **Day:** Monday (low traffic)
- **Time:** 14:00-16:00 (2-4 PM, lowest traffic window)
- **Method:** FTP + cache-buster + version bump
- **Monitoring:** 2 hours post-deploy (on-site)

**Post-Deployment (May 24-25):**
- [ ] Verify all features working
- [ ] Check Lighthouse score in production
- [ ] Verify accessibility in production
- [ ] Monitor error logs
- [ ] Team available for rollback if needed
- [ ] Final customer-facing announcement

---

## COMMUNICATION SCHEDULE

### Daily
- **9:00 AM:** Standup (15 min) - blockers, progress, next steps
- **Slack:** Async updates on #development channel

### Weekly
- **Friday 4:00 PM:** Sprint review + retrospective
- **Friday 5:00 PM:** Stakeholder update (email)

### Gate Reviews
- **Monday 10:00 AM:** Phase gate review meeting (all stakeholders)
- **Decision:** Proceed to next phase or return for fixes

### Monthly
- **Last Friday:** Executive summary to leadership
- **Report:** Progress, metrics, budget tracking

---

## RISK MITIGATION TIMELINE

| Week | Risk | Probability | Mitigation | Owner |
|------|------|-------------|-----------|-------|
| 1-2 | CSS caching not working | Medium | Workaround documented | Dev B |
| 1-2 | Phase 1 scope creep | Medium | Strict scope limits | PM |
| 3-5 | Learning curve on new tools | Medium | Pair programming | Dev A/B |
| 3-5 | Build pipeline issues | Low | Fallback approach ready | Dev A |
| 6-7 | Lighthouse score < 85 | Low | Extended optimization | Dev A |
| 6-7 | Image optimization breaks | Low | Fallback to JPEG | Dev A |
| 8 | Team training ineffective | Low | Follow-up sessions | Dev A/B |
| 8 | Documentation incomplete | Low | Extended Phase 4 | Dev A |

---

## SUCCESS CRITERIA BY WEEK

### Week 1 (Mar 24-28)
- [ ] Focus indicators working
- [ ] CSS caching documented
- [ ] Jest framework installed
- [ ] 3/3 stories done

### Week 2 (Mar 31-Apr 4)
- [ ] All images have alt text
- [ ] CSS variables system live
- [ ] Form labels fixed
- [ ] WCAG AA achieved
- [ ] Phase 1 GATE PASSED

### Week 3 (Apr 7-11)
- [ ] Design system documented
- [ ] Storybook with 15+ components
- [ ] 2/6 Phase 2 stories done

### Week 4 (Apr 14-18)
- [ ] Build pipeline working
- [ ] GitHub CI/CD live
- [ ] 4/6 Phase 2 stories done

### Week 5 (Apr 21-25)
- [ ] 15+ JavaScript tests
- [ ] 70%+ test coverage
- [ ] GitHub branch rules enforced
- [ ] Phase 2 GATE PASSED

### Week 6 (Apr 28-May 2)
- [ ] All images in WebP
- [ ] Lighthouse 85+ achieved
- [ ] 2/3 Phase 3 stories done

### Week 7 (May 5-9)
- [ ] Templates deduplicated
- [ ] Performance locked in
- [ ] Phase 3 GATE PASSED

### Week 8 (May 12-16)
- [ ] Reduced motion support working
- [ ] Mobile menu polished
- [ ] Documentation complete
- [ ] Team training delivered
- [ ] PHASE 4 & EPIC GATE PASSED
- [ ] Ready for production

---

## DOCUMENT METADATA

**Status:** DRAFT
**Created:** 2026-03-17
**Version:** 1.0

**Next Steps:**
1. [ ] Stakeholder review
2. [ ] Approval meeting
3. [ ] Kick-off scheduled
4. [ ] Begin execution

---
