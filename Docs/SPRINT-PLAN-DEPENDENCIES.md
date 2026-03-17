# Sprint Plan - Dependency Graph (DAG)

**Epic:** TDB-2026-001
**Total Stories:** 21
**Critical Path Stories:** 8

---

## DEPENDENCY MATRIX

### Story Dependencies

```
TDB-2026-001.1.1 (Focus Indicators)
  ├─ DEPENDS ON: None
  └─ BLOCKS: None

TDB-2026-001.1.2 (CSS Caching Workaround) ⭐ CRITICAL
  ├─ DEPENDS ON: None
  └─ BLOCKS: 1.5, 2.1, 3.1, 3.2 (all CSS-heavy work)

TDB-2026-001.1.3 (Jest Testing Setup) ⭐ CRITICAL
  ├─ DEPENDS ON: None
  └─ BLOCKS: 2.4, 2.5 (CI/CD and testing)

TDB-2026-001.1.4 (Alt Text for Images)
  ├─ DEPENDS ON: 1.2 (CSS Caching - if image CSS involved)
  └─ BLOCKS: 3.1 (Image optimization)

TDB-2026-001.1.5 (CSS Variables) ⭐ CRITICAL
  ├─ DEPENDS ON: 1.2 (CSS Caching)
  └─ BLOCKS: 2.1, 3.2, 4.1

TDB-2026-001.1.6 (Form Labels)
  ├─ DEPENDS ON: None
  └─ BLOCKS: None

TDB-2026-001.2.1 (Design System Foundation) ⭐ CRITICAL
  ├─ DEPENDS ON: 1.5 (CSS Variables)
  └─ BLOCKS: 2.2 (Storybook)

TDB-2026-001.2.2 (Storybook MVP)
  ├─ DEPENDS ON: 2.1 (Design System)
  └─ BLOCKS: None (reference tool)

TDB-2026-001.2.3 (Build Pipeline) ⭐ CRITICAL
  ├─ DEPENDS ON: 1.5 (CSS Variables)
  └─ BLOCKS: 2.4, 2.5 (CI/CD and testing)

TDB-2026-001.2.4 (GitHub CI/CD) ⭐ CRITICAL
  ├─ DEPENDS ON: 1.3 (Jest), 2.3 (Build)
  └─ BLOCKS: 2.5 (JS Testing in CI/CD)

TDB-2026-001.2.5 (JavaScript Testing)
  ├─ DEPENDS ON: 1.3 (Jest), 2.3 (Build), 2.4 (CI/CD)
  └─ BLOCKS: None

TDB-2026-001.2.6 (GitHub Integration & Branch Rules)
  ├─ DEPENDS ON: 2.4 (CI/CD - status checks)
  └─ BLOCKS: None

TDB-2026-001.3.1 (Image Optimization) ⭐ CRITICAL
  ├─ DEPENDS ON: 1.2 (CSS Caching), 1.4 (Alt Text)
  └─ BLOCKS: 3.2 (Lighthouse Optimization)

TDB-2026-001.3.2 (Lighthouse Optimization) ⭐ CRITICAL
  ├─ DEPENDS ON: 3.1 (Image Optimization), 2.3 (Build)
  └─ BLOCKS: None

TDB-2026-001.3.3 (Template Deduplication)
  ├─ DEPENDS ON: None
  └─ BLOCKS: None (code quality improvement)

TDB-2026-001.4.1 (Reduced Motion Support)
  ├─ DEPENDS ON: 1.5 (CSS Variables)
  └─ BLOCKS: None

TDB-2026-001.4.2 (Mobile Menu UX Polish)
  ├─ DEPENDS ON: None
  └─ BLOCKS: None

TDB-2026-001.4.3 (Documentation)
  ├─ DEPENDS ON: All previous stories
  └─ BLOCKS: None

TDB-2026-001.4.4 (Team Training)
  ├─ DEPENDS ON: All previous stories
  └─ BLOCKS: None
```

---

## CRITICAL PATH ANALYSIS

### Path 1: CSS Infrastructure (8 stories)
```
1.2 (CSS Caching) ────→ 1.5 (CSS Variables) ────→ 2.1 (Design System)
                                          ↓
                                       2.2 (Storybook)

                    └────→ 3.1 (Image Opt) ────→ 3.2 (Lighthouse)

                    └────→ 4.1 (Reduced Motion)

DURATION: 2 weeks → 1 week → 1 week → 2 weeks = 6 weeks on critical path
BLOCKERS: None (starts week 1, completes week 6)
```

### Path 2: Testing & CI/CD (5 stories)
```
1.3 (Jest Setup) ────→ 2.3 (Build Pipeline) ────→ 2.4 (GitHub CI/CD) ────→ 2.5 (JS Testing)
                                                           ↓
                                                      2.6 (Branch Rules)

DURATION: 1 week → 1 week → 1 week → 1 week = 4 weeks on critical path
BLOCKERS: None (starts week 1, completes week 5)
```

### Path 3: Infrastructure Integration (3 stories)
```
2.1 (Design System) ────→ 2.2 (Storybook)

DURATION: 1 week → 1 week = 2 weeks on critical path
DEPENDENT ON: Path 1 (CSS Variables)
```

### OVERALL CRITICAL PATH
```
1.2 (CSS Caching) ────→ 1.5 (CSS Variables) ────→ 2.1 (Design System) ────→ 2.2 (Storybook)
                                         ↓
                                    3.1 (Image Opt) ────→ 3.2 (Lighthouse)

Total duration on critical path: 6 weeks
If delayed: Entire epic delayed by same amount
```

---

## GANTT CHART VIEW

```
Week  Mon     Tue     Wed     Thu     Fri     Sat     Sun
1     |1.1    |1.1    |1.2    |1.3    |1.3    |       |
      |1.2    |1.2    |1.3    |1.3    |       |       |
      |       |       |       |       |       |       |

2     |1.4    |1.4    |1.5    |1.5    |1.6    |GATE 1 |REVIEW
      |1.5    |1.5    |1.6    |1.6    |       |PASS   |

3     |2.1    |2.1    |2.2    |2.2    |2.2    |       |REVIEW
      |2.2    |2.2    |       |       |       |       |

4     |2.3    |2.3    |2.3    |2.4    |2.4    |       |REVIEW
      |2.4    |2.4    |       |       |       |       |

5     |2.5    |2.5    |2.5    |2.6    |2.6    |GATE 2 |REVIEW
      |       |       |       |       |       |PASS   |

6     |3.1    |3.1    |3.2    |3.2    |3.2    |       |REVIEW
      |3.2    |3.2    |       |       |       |       |

7     |3.3    |3.3    |       |       |       |GATE 3 |REVIEW
      |       |       |       |       |       |PASS   |

8     |4.1    |4.2    |4.3    |4.3    |4.4    |GATE 4 |EPIC
      |4.2    |       |4.4    |       |       |PASS   |DONE
```

---

## DEPENDENCY GRAPH (Text Format)

```
┌─────────────────────────────────────────────────────────────┐
│ PHASE 1: CRITICAL FOUNDATION                                │
└─────────────────────────────────────────────────────────────┘

    TDB-1.1 (Focus Indicators) ─────────┐
                                        │
    TDB-1.2 (CSS Caching) ─────────────→├─→ TDB-1.5 (CSS Vars)
                                        │         ↓
    TDB-1.3 (Jest) ────────────────────┤    TDB-2.1 (Design Sys)
                                        │         ↓
    TDB-1.4 (Alt Text) ────────────────┤    TDB-2.2 (Storybook)
                                        │
    TDB-1.6 (Form Labels) ─────────────┴─→ TDB-3.1 (Image Opt)
                                             ↓
                                        TDB-3.2 (Lighthouse)

┌─────────────────────────────────────────────────────────────┐
│ PHASE 2: ARCHITECTURE                                       │
└─────────────────────────────────────────────────────────────┘

    TDB-2.3 (Build Pipeline) ────→ TDB-2.4 (GitHub CI/CD) ──→ TDB-2.5 (JS Tests)
                                         ↓
                                    TDB-2.6 (Branch Rules)

┌─────────────────────────────────────────────────────────────┐
│ PHASE 3: PERFORMANCE                                        │
└─────────────────────────────────────────────────────────────┘

    TDB-3.1 (Image Opt) ──→ TDB-3.2 (Lighthouse)
    TDB-3.3 (Template Dedup) ────────────┘ (independent)

┌─────────────────────────────────────────────────────────────┐
│ PHASE 4: POLISH                                             │
└─────────────────────────────────────────────────────────────┘

    TDB-4.1 (Reduced Motion) ────┐
                                  ├─→ TDB-4.3 (Docs) ──→ TDB-4.4 (Training)
    TDB-4.2 (Mobile Menu) ───────┘
```

---

## SEQUENTIAL CONSTRAINTS

### Stories that MUST be done in order:

**Chain 1: CSS Infrastructure**
```
1. TDB-2026-001.1.2 (CSS Caching Workaround) ← MUST start first
2. TDB-2026-001.1.5 (CSS Variables) ← starts when 1.2 in code review
3. TDB-2026-001.2.1 (Design System) ← starts when 1.5 in code review
4. TDB-2026-001.2.2 (Storybook) ← starts when 2.1 complete
5. TDB-2026-001.3.1 (Image Optimization) ← parallel with 2.1/2.2
6. TDB-2026-001.3.2 (Lighthouse) ← starts when 3.1 complete
```

**Chain 2: Testing & CI/CD**
```
1. TDB-2026-001.1.3 (Jest Setup) ← MUST start first
2. TDB-2026-001.2.3 (Build Pipeline) ← parallel (independent)
3. TDB-2026-001.2.4 (GitHub CI/CD) ← starts when 1.3 + 2.3 complete
4. TDB-2026-001.2.5 (JS Testing) ← starts when 2.4 complete
5. TDB-2026-001.2.6 (Branch Rules) ← starts when 2.4 complete
```

### Stories that CAN be done in parallel:

- TDB-2026-001.1.1 (Focus) ← independent from everything
- TDB-2026-001.1.4 (Alt Text) ← independent, only soft-depends on 1.2
- TDB-2026-001.1.6 (Form Labels) ← independent from everything
- TDB-2026-001.3.3 (Template Dedup) ← independent from everything
- TDB-2026-001.4.1 (Reduced Motion) ← only depends on CSS being complete
- TDB-2026-001.4.2 (Mobile Menu) ← independent from everything
- TDB-2026-001.4.3 (Docs) ← can start after Phase 1
- TDB-2026-001.4.4 (Training) ← can start after Phase 2

---

## DEVELOPER ALLOCATION STRATEGY

### Sprint 1.1 (Week 1)
```
Dev A: TDB-1.1 (Focus) → TDB-1.3 (Jest, help with)
Dev B: TDB-1.2 (CSS Caching) → TDB-1.3 (Jest, help with)
```

### Sprint 1.2 (Week 2)
```
Dev A: TDB-1.4 (Alt Text) → TDB-1.6 (Form Labels)
Dev B: TDB-1.5 (CSS Variables) ← CRITICAL PATH
```

### Sprint 2.1 (Week 3)
```
Dev A: TDB-2.1 (Design System) ← CRITICAL PATH
Dev B: TDB-2.2 (Storybook)
```

### Sprint 2.2 (Week 4)
```
Dev A: TDB-2.3 (Build Pipeline) ← CRITICAL PATH
Dev B: TDB-2.4 (GitHub CI/CD) ← CRITICAL PATH
```

### Sprint 2.3 (Week 5)
```
Dev A: TDB-3.1 (Image Optimization - can start early) ← CRITICAL PATH
Dev B: TDB-2.5 (JS Testing) → TDB-2.6 (Branch Rules)
```

### Sprint 3.1 (Week 6)
```
Dev A: TDB-3.1 (Image Opt, finish if needed)
Dev B: TDB-3.2 (Lighthouse Optimization) ← CRITICAL PATH
```

### Sprint 3.2 (Week 7)
```
Dev A: TDB-3.3 (Template Dedup)
Dev B: TDB-3.2 (Lighthouse, finish/verify)
```

### Sprint 4.1 (Week 8)
```
Dev A: TDB-4.1 (Reduced Motion) → TDB-4.3 (Docs)
Dev B: TDB-4.2 (Mobile Menu) → TDB-4.4 (Training)
```

---

## BLOCKERS & RISK MITIGATION

### High Risk Blockers

| Story | Blocker | Severity | Mitigation | Timeline |
|-------|---------|----------|-----------|----------|
| TDB-1.5 | TDB-1.2 not working | HIGH | Have fallback CSS approach | Week 2 end |
| TDB-2.1 | TDB-1.5 incomplete | HIGH | Delay 2.1 start by 1 day max | Week 3 start |
| TDB-2.4 | TDB-1.3 + TDB-2.3 incomplete | HIGH | Dev B works on 2.3 help | Week 4 start |
| TDB-3.2 | TDB-3.1 not delivering size reduction | HIGH | Alt approach: optimize other resources | Week 7 |

### Medium Risk Blockers

| Story | Blocker | Severity | Mitigation | Timeline |
|-------|---------|----------|-----------|----------|
| TDB-3.1 | Image conversion tools missing | MEDIUM | Install before week 6 | Week 5 end |
| TDB-2.2 | Component design not finalized | MEDIUM | Use placeholder components | Week 3 |
| TDB-4.4 | Training materials not ready | MEDIUM | Create during week 7 | Week 7 |

### Low Risk Blockers

| Story | Blocker | Severity | Mitigation | Timeline |
|-------|---------|----------|-----------|----------|
| TDB-1.4 | Image content review | LOW | Can proceed with placeholder alt text | Week 2 |
| TDB-3.3 | Template structure unclear | LOW | Can skip if time constrained | Week 7 |
| TDB-4.1 | Browser reduced motion support | LOW | Fallback: CSS media query for modern browsers | Week 8 |

---

## ROLLBACK SEQUENCE

If a critical story fails after starting, rollback in this order:

```
1. TDB-3.2 (Lighthouse) ← revert optimizations
   └─ Fallback: disable image optimization, use original images

2. TDB-3.1 (Image Optimization) ← revert WebP conversion
   └─ Fallback: use original JPEG/PNG images

3. TDB-2.4 (GitHub CI/CD) ← disable workflow
   └─ Fallback: manual code review instead

4. TDB-2.3 (Build Pipeline) ← revert build config
   └─ Fallback: use original build method

5. TDB-1.5 (CSS Variables) ← revert variable usage
   └─ Fallback: use hardcoded colors again

6. TDB-1.2 (CSS Caching) ← revert cache-buster
   └─ Fallback: accept CSS caching issues (original problem)

CRITICAL: Do NOT roll back 1.2 if any other story depends on it.
Instead, use fallback approach and skip dependent stories.
```

---

## PARALLEL EXECUTION OPPORTUNITIES

### Week 1: Maximum Parallelization
```
Dev A: Focus Indicators (1.1)
Dev B: CSS Caching (1.2)
SHARED: Jest Setup (1.3)
```

### Week 3: Design System Parallelization
```
Dev A: Design System (2.1) ← blocks Storybook
Dev B: Storybook (2.2) ← can stub components
```

### Week 4: Build & CI/CD Parallelization
```
Dev A: Build Pipeline (2.3) ← critical
Dev B: GitHub CI/CD (2.4) ← depends on 2.3 status
```

### Week 6-7: Image & Template Parallelization
```
Dev A: Image Optimization (3.1) ← critical path
Dev B: Template Dedup (3.3) ← independent
```

---

## DEPENDENCY RESOLUTION CHECKLIST

Before starting each sprint, verify:

```
BEFORE SPRINT 1.1:
[ ] Developers ready
[ ] GitHub repo configured
[ ] Staging environment ready
[ ] Team communicated

BEFORE SPRINT 1.2:
[ ] TDB-1.1 complete
[ ] TDB-1.2 complete (CSS Caching working)
[ ] TDB-1.3 complete (Jest installed)
[ ] No blockers found

BEFORE SPRINT 2.1:
[ ] TDB-1.5 complete (CSS Variables live)
[ ] All Phase 1 stories merged to main
[ ] Phase 1 gate passed
[ ] No regressions found

BEFORE SPRINT 2.2:
[ ] TDB-2.1 complete (Design System doc)
[ ] TDB-2.3 progress confirmed
[ ] No blockers on 2.2 start

BEFORE SPRINT 2.3:
[ ] TDB-2.3 complete (Build Pipeline)
[ ] TDB-2.4 complete (CI/CD)
[ ] All Phase 2 early stories done
[ ] CI/CD workflow verified working

BEFORE SPRINT 3.1:
[ ] All Phase 2 stories merged to main
[ ] Phase 2 gate passed
[ ] Build pipeline optimized
[ ] Image tools installed

BEFORE SPRINT 3.2:
[ ] TDB-3.1 complete (Images optimized)
[ ] Lighthouse baseline measured
[ ] Optimization targets confirmed

BEFORE SPRINT 4.1:
[ ] All Phase 3 stories merged to main
[ ] Phase 3 gate passed
[ ] Lighthouse 85+ achieved
[ ] Team ready for training
```

---

## CRITICAL PATH MONITORING

### Daily Checklist (for critical path stories)

```
TDB-1.2 (CSS Caching):
[ ] Working as expected
[ ] No blockers for dependent stories
[ ] CSS changes apply immediately

TDB-2.3 (Build Pipeline):
[ ] npm run build working
[ ] Output optimized
[ ] No blockers for CI/CD

TDB-3.1 (Image Optimization):
[ ] WebP conversion complete
[ ] File size reduction achieved (50%+)
[ ] No broken images in staging

TDB-3.2 (Lighthouse Optimization):
[ ] Performance score increasing
[ ] LCP < 2.5s target approaching
[ ] No regressions from Phase 1-2
```

---

## DOCUMENT METADATA

**Status:** DRAFT
**Created:** 2026-03-17
**Version:** 1.0

**Related Documents:**
- `SPRINT-PLAN-AIOX-10-10.md` - Full story details
- `SPRINT-PLAN-SCHEDULE.md` - Timeline and calendar
- `SPRINT-PLAN-ROLLBACK-PROCEDURES.md` - Rollback plans

---
