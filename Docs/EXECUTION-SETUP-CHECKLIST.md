# 🚀 EXECUTION SETUP CHECKLIST — Sprint 1.1 (Week 1)

**Project:** TDB-2026-001 (Brownfield Discovery)
**Target Start:** 2026-03-24
**Phase:** Critical Foundation (Weeks 1-2)
**Padrão:** AIOX 10/10 + Nuvemshop Safety

---

## ✅ PRÉ-REQUISITOS (Antes de 2026-03-24)

### ✓ APPROVAL & TEAM

- [ ] **User Approval:** Sprint plan aprovado
- [ ] **Developer 1:** Confirmado (full-time, 40h/week)
- [ ] **Developer 2:** Confirmado (full-time, 40h/week)
- [ ] **QA Lead:** Designado para validação de staging
- [ ] **Product Manager:** Disponível para approvals
- [ ] **Engineering Manager:** Escalation point

### ✓ ENVIRONMENT VALIDATION

#### Staging Environment
- [ ] Staging URL acessível: `https://staging-patagang.nuvemshop.com.br`
- [ ] Database sincronizado com produção (se aplicável)
- [ ] CSS cache cleared (manual)
- [ ] Monitoring/logging ativo

#### FTP Access
- [ ] FTP credentials tested: `ftp.nuvemshop.com.br`
- [ ] Upload/download funcionando
- [ ] Backup automated configured
- [ ] Rollback script tested (manual FTP restore)

#### GitHub/CI
- [ ] GitHub Actions configured
- [ ] Workflows functional (lint, typecheck, tests)
- [ ] Branch protection rules active
- [ ] Webhook integration verified

#### Local Development
- [ ] Node.js 18+ installed (`node --version`)
- [ ] npm dependencies updated (`npm install`)
- [ ] ESLint configured (`npm run lint`)
- [ ] TypeScript working (`npm run typecheck`)
- [ ] Jest ready for Story 1.3 (`npm test` works)

### ✓ BASELINE METRICS (Capture Before Story 1.1)

**WCAG Compliance:**
- [ ] Run axe audit on homepage: _____ violations
- [ ] Run axe on product page: _____ violations
- [ ] Run axe on checkout: _____ violations
- **Target Phase 1:** 0 violations (WCAG AA)

**Lighthouse (Mobile):**
- [ ] Capture lighthouse-report.json for homepage
- [ ] Performance: _____ / 100
- [ ] Accessibility: _____ / 100
- [ ] SEO: _____ / 100
- **Target Phase 3:** 85+, 90+, 90+

**Test Coverage:**
- [ ] Current coverage: _____ %
- [ ] Number of tests: _____
- **Target Phase 1:** 60% (Story 1.3 adds Jest setup)

**Performance Metrics:**
- [ ] LCP (Largest Contentful Paint): _____ s
- [ ] FCP (First Contentful Paint): _____ s
- [ ] CLS (Cumulative Layout Shift): _____
- **Target Phase 3:** <2.5s, <1.5s, <0.1

**Save as:** `docs/execution/BASELINE-METRICS-2026-03-24.md`

---

## 📅 WEEK 1 (2026-03-24 to 2026-03-28) — SPRINT 1.1

### ☀️ MONDAY 2026-03-24 — Kick-off

#### Morning (10:00 AM)
- [ ] **Kick-off Meeting** (1h, all team)
  - [ ] Review SPRINT-PLAN-README.md
  - [ ] Review SPRINT-PLAN-AIOX-10-10.md (stories 1.1-1.3)
  - [ ] Review NUVEMSHOP-IMPLEMENTATION-DECISIONS.md
  - [ ] Q&A on acceptance criteria
  - [ ] Assign Developer A to Story 1.1
  - [ ] Assign Developer B to Story 1.2 + joint 1.3

- [ ] **Environment Validation** (30m)
  - [ ] Staging site loads
  - [ ] FTP connection works
  - [ ] GitHub Actions passing
  - [ ] Local npm setup works

#### Afternoon (14:00)
- [ ] **Developer A:** Start Story 1.1 implementation
  - [ ] Read full story from SPRINT-PLAN-AIOX-10-10.md
  - [ ] Create branch: `feature/TDB-2026-001.1.1-focus-indicators`
  - [ ] Begin implementation (2-4h estimated)

- [ ] **Developer B:** Start Story 1.2 implementation
  - [ ] Read full story from SPRINT-PLAN-AIOX-10-10.md
  - [ ] Create branch: `feature/TDB-2026-001.1.2-css-caching`
  - [ ] Begin implementation (12-16h estimated, spans multiple days)

- [ ] **QA:** Prepare staging validation environment
  - [ ] Setup testing infrastructure
  - [ ] Review SPRINT-PLAN-AIOX-10-10.md validation gates
  - [ ] Review NUVEMSHOP-ACCEPTANCE-CRITERIA.md

---

### 📊 DAILY STANDUP (09:00 AM, All Days)

**Format:** 15 minutes
**Questions:**
1. What did you complete yesterday? (checkbox in PROGRESS-TRACKER.md)
2. What are you working on today?
3. Any blockers?

**Update:** After each standup, update `PROGRESS-TRACKER.md` AC checklist

---

### 🔧 STORY 1.1: FOCUS INDICATORS (Dev A)

**Dates:** Mon-Wed (2026-03-24 to 2026-03-26)
**Effort:** 2-4h
**File:** `docs/SPRINT-PLAN-AIOX-10-10.md` → Find "TDB-2026-001.1.1"

#### Acceptance Criteria Checklist:
- [ ] `:focus-visible` CSS rule added to theme
- [ ] All interactive elements show outline
- [ ] Outline color matches brand (#FF6B35)
- [ ] Works on Chrome, Firefox, Safari, Edge
- [ ] WCAG 2.4.7 passes (axe)
- [ ] Keyboard TAB works
- [ ] Touch devices: focus visible
- [ ] Outline doesn't obscure content

#### Implementation Steps:
1. [ ] Create file: `theme/assets/css/focus-indicators.css`
   ```css
   /* Focus indicator styles */
   :focus-visible {
     outline: 2px solid #FF6B35;
     outline-offset: 2px;
   }
   /* Rest of rules... */
   ```

2. [ ] Link CSS in theme template: `theme/layouts/layout.tpl`
3. [ ] Deploy to staging (Story 1.2 prerequisite not needed yet)
4. [ ] Run axe audit: `npx axe website_url`
5. [ ] Test in all 4 browsers
6. [ ] Get code review (2+ eyes)

#### Definition of Done:
- [ ] Code reviewed (2+ eyes)
- [ ] All AC verified in staging
- [ ] `npm run lint` — PASS
- [ ] `npm run typecheck` — PASS
- [ ] Accessibility audit: 0 violations
- [ ] No regression
- [ ] File list updated in story
- [ ] Story marked READY FOR PRODUCTION

#### Validation Gates:
1. **Code Quality Gate:** Lint + type check pass ✓
2. **Accessibility Gate:** Axe + WCAG 2.4.7 pass ✓
3. **Visual Gate:** All 4 browsers show outline ✓
4. **Functional Gate:** TAB navigation works ✓

#### Staging Validation (20+ items):
- [ ] Chrome: focus visible on all buttons
- [ ] Firefox: focus visible on all buttons
- [ ] Safari: focus visible on all buttons
- [ ] Edge: focus visible on all buttons
- [ ] Tablet: focus visible on touch
- [ ] Mobile: focus visible on touch
- [ ] Screen reader announces correctly
- [ ] No performance impact
- [ ] Outline color is #FF6B35 ✓
- [ ] Tab order logical
- [ ] Shift+Tab works (reverse)
- [ ] Focus doesn't scroll incorrectly
- [ ] Works with keyboard-only users
- [ ] No regression on other styles
- [ ] Ready for production: YES/NO

#### Deployment:
- [ ] Approved for production: YES/NO
- [ ] FTP upload completed
- [ ] Cache busted (manual: add ?v=timestamp)
- [ ] Production validated (5 min check)
- [ ] Deployment log created: `docs/execution/SPRINT-1-1-EXECUTION.md`

#### Update Progress:
```
Story 1.1: [████░░░░░░░░░░░░░░░░] 20% (AC checklist: 2/8)
Status: IN_PROGRESS (Started 2026-03-24)
Target Completion: 2026-03-26
```

---

### 🎨 STORY 1.2: CSS CACHING WORKAROUND (Dev B)

**Dates:** Mon-Fri (2026-03-24 to 2026-03-28)
**Effort:** 12-16h
**Blocks:** Story 1.3, Story 2.1
**File:** `docs/SPRINT-PLAN-AIOX-10-10.md` → Find "TDB-2026-001.1.2"

#### Acceptance Criteria Checklist:
- [ ] Cache invalidation process documented
- [ ] Version ID system implemented in layout.tpl
- [ ] ?v=timestamp added to CSS links
- [ ] Deploy script updated to bust cache
- [ ] Cache busting strategy tested
- [ ] CSS changes reflected after deploy

#### Implementation Steps:
1. [ ] Create cache busting system in theme
   ```tpl
   <!-- theme/layouts/layout.tpl -->
   {% assign versionId = "2026-03-24-001" %}
   <link rel="stylesheet" href="/theme/assets/css/style.css?v={{ versionId }}">
   ```

2. [ ] Document in: `docs/NUVEMSHOP-CSS-CACHE-BUSTING.md`
3. [ ] Test cache busting (deploy, verify new CSS loads)
4. [ ] Deploy to staging
5. [ ] Test in browsers (F5, Ctrl+Shift+R, Private mode)

#### Definition of Done:
- [ ] Code reviewed (2+ eyes)
- [ ] All AC verified in staging
- [ ] Cache busting tested (3 deployment cycles)
- [ ] No regression on visual
- [ ] File list updated
- [ ] Story marked READY FOR PRODUCTION

#### Deployment:
- [ ] Approved for production
- [ ] FTP upload completed
- [ ] Manual cache bust verified (old CSS not cached)
- [ ] Production validated
- [ ] Deployment log created

#### Update Progress:
```
Story 1.2: [██░░░░░░░░░░░░░░░░░░] 10% (AC: 1/6) — BLOCKER for 1.3, 2.1
Status: IN_PROGRESS
Target Completion: 2026-03-28
```

---

### 🧪 STORY 1.3: UNIT TESTS SETUP (Both Devs)

**Dates:** Tue-Fri (2026-03-25 to 2026-03-28)
**Effort:** 24-40h
**Depends on:** Story 1.2
**File:** `docs/SPRINT-PLAN-AIOX-10-10.md` → Find "TDB-2026-001.1.3"

#### Acceptance Criteria Checklist:
- [ ] Jest installed and configured
- [ ] jsdom configured for DOM testing
- [ ] jest.config.js created
- [ ] 5+ example tests created
- [ ] `npm test` runs successfully
- [ ] 60%+ coverage target set
- [ ] GitHub Actions CI integrated
- [ ] Pre-commit hooks configured

#### Implementation Steps:
1. [ ] Install Jest:
   ```bash
   npm install --save-dev jest @testing-library/dom jsdom
   ```

2. [ ] Create `jest.config.js`:
   ```js
   module.exports = {
     testEnvironment: 'jsdom',
     coveragePathIgnorePatterns: ['/node_modules/'],
     collectCoverageFrom: ['src/**/*.js'],
     coverageThreshold: {
       global: { lines: 60 }
     }
   };
   ```

3. [ ] Create `tests/` folder with 5+ example tests
4. [ ] Configure GitHub Actions: `.github/workflows/test.yml`
5. [ ] Setup pre-commit hook (husky)
6. [ ] Run tests: `npm test`

#### Coverage Report:
```
Statements:   _____ / _____ (___%)
Branches:     _____ / _____ (___%)
Functions:    _____ / _____ (___%)
Lines:        _____ / _____ (___%)
Target: 60%+ ✅ / ❌
```

#### Definition of Done:
- [ ] Code reviewed
- [ ] All AC verified
- [ ] Tests passing: `npm test — PASS`
- [ ] Coverage 60%+
- [ ] GitHub Actions passing
- [ ] Pre-commit hooks working
- [ ] File list updated
- [ ] Story marked READY FOR PRODUCTION

#### Update Progress:
```
Story 1.3: [██░░░░░░░░░░░░░░░░░░] 10% (AC: 1/8) — Depends on 1.2
Status: BLOCKED until 1.2 completes
Target Completion: 2026-03-28
```

---

## 📈 PROGRESS TRACKING

### Daily Update (EOD)

**File to update:** `docs/PROGRESS-TRACKER.md`

```markdown
## PHASE 1: CRITICAL & FOUNDATION (Weeks 1-2)

### Sprint 1.1 (Week 1: 2026-03-24 to 2026-03-28)

#### Story TDB-2026-001.1.1: Focus Indicators
- **Status:** ✅ IN_PROGRESS / ⏳ BLOCKED / ✅ DONE
- **Owner:** [Dev A Name]
- **Progress:** [████░░░░░░░░░░░░░░░░] 20%
- **AC Checklist:** [x] Rule added [ ] Color verified [ ] WCAG passes ...

#### Story TDB-2026-001.1.2: CSS Caching Workaround
- **Status:** ⏳ BLOCKED until 1.2
- **Owner:** [Dev B Name]
- **Progress:** [░░░░░░░░░░░░░░░░░░░░] 0%

#### Story TDB-2026-001.1.3: Unit Tests Setup
- **Status:** ⏳ BLOCKED until 1.2
- **Owner:** [Both Devs]
- **Progress:** [░░░░░░░░░░░░░░░░░░░░] 0%
```

### Weekly Review (Friday 16:00)

- [ ] All 3 stories in Phase 1 status
- [ ] Deployment logs complete
- [ ] Issues tracked in GitHub/Linear
- [ ] Retro meeting: What went well? What needs improvement?

---

## 🚨 PHASE 1 GATE (2026-04-04)

**Gate Criteria (Must Pass):**
- [ ] All 6 stories completed and merged
- [ ] WCAG AA compliance achieved (0 violations)
- [ ] Test coverage: 60%+ ✅
- [ ] Lighthouse score: 75+ ✅
- [ ] Zero critical issues in production
- [ ] Team sign-off obtained

**Decision:** [ ] GO to Phase 2 / [ ] REWORK Phase 1

---

## 📞 CONTACTS & ESCALATION

| Role | Name | Contact | Purpose |
|------|------|---------|---------|
| Engineering Lead | _____ | _____ | Technical blockers |
| Product Manager | _____ | _____ | Approvals, scope |
| QA Lead | _____ | _____ | Validation gates |
| DevOps | _____ | _____ | FTP, CI/CD issues |

---

## ✅ FINAL CHECKLIST BEFORE SPRINT STARTS

**All should be checked before Monday 2026-03-24 09:00 AM:**

- [ ] All team members confirmed
- [ ] Environment fully validated (staging, FTP, GitHub)
- [ ] Baseline metrics captured
- [ ] Documentation reviewed by all
- [ ] Meeting room booked (10:00 AM kick-off)
- [ ] PROGRESS-TRACKER.md ready for daily updates
- [ ] Deployment procedures reviewed
- [ ] Rollback procedures reviewed
- [ ] Nuvemshop support contact verified

---

**🚀 Ready to Launch Sprint 1.1!**

— Orion, orquestrando o sistema 🎯
