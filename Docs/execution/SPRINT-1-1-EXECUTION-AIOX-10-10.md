# 🚀 SPRINT 1.1 EXECUTION — AIOX 10/10 Detailed Plan

**Sprint:** Sprint 1.1 (Critical Foundation Phase)
**Dates:** 2026-03-24 (Mon) to 2026-03-28 (Fri)
**Duration:** 1 week (5 days)
**Stories:** 3 (TDB-2026-001.1.1, TDB-2026-001.1.2, TDB-2026-001.1.3)
**Team:** Dev A, Dev B (both full-time)
**Padrão:** AIOX 10/10 (all 10 elements for each story)
**Status:** 🟢 READY TO EXECUTE

---

## 📋 SPRINT 1.1 OVERVIEW

```
SPRINT 1.1: CRITICAL FOUNDATION
Week 1 (2026-03-24 to 2026-03-28)

Story 1.1: Focus Indicators (Dev A) .................... 2-4h
Story 1.2: CSS Caching Workaround (Dev B) ............ 12-16h
Story 1.3: Unit Tests Setup (Both Devs) .............. 24-40h

Total Effort: ~40-60h (2 devs × 40h/week = 80h available)
Capacity: 80h available - plenty for Week 1

Daily Standup: 09:00 AM (15 min)
Weekly Retro: Friday 16:00 (30 min)

Key Blockers:
- Story 1.2 must complete before Story 1.3 starts (blocks 2.1)
- Story 1.3 depends on Jest setup (Story 1.2 cache busting)
```

---

## 🎯 STORY 1.1: FOCUS INDICATORS — AIOX 10/10

### 1. Story ID + Title
```
TDB-2026-001.1.1 — Implement Focus Indicators
Epic: TDB-2026-001 (Technical Debt Resolution)
Phase: 1 (Critical Foundation)
Week: Week 1 (2026-03-24 to 2026-03-28)
```

### 2. Owner & Assignment
```
Story Owner: Developer A
Estimated Effort: 2-4 hours
Timeline: Monday 2026-03-24 to Wednesday 2026-03-26 EOD
Pairing: Available if blocked
Code Review: Requires 2+ eyes (Dev B + QA Lead)
```

### 3. User Story (Clear Intent)
```
As a keyboard-only user,
I want to see a clear focus outline on all interactive elements,
So that I can navigate the website using only Tab key.

Acceptance Context:
- Current State: No visible focus indicators
- Target State: All buttons/links/inputs have #FF6B35 outline
- WCAG 2.4.7 compliance required
- Zero visual regression on other styles
```

### 4. Acceptance Criteria (Testable Checklist)

**AC-1: Focus Outline Implementation**
```
□ `:focus-visible` CSS rule added to theme
□ Outline color: #FF6B35 (brand color)
□ Outline width: 2px
□ Outline offset: 2px (space between element + outline)
□ Applies to: buttons, links, inputs, selects, textareas
```

**AC-2: Browser Compatibility**
```
□ Chrome: Focus visible on Tab (latest 2 versions)
□ Firefox: Focus visible on Tab (latest 2 versions)
□ Safari: Focus visible on Tab (latest 2 versions)
□ Edge: Focus visible on Tab (latest 2 versions)
```

**AC-3: Keyboard Navigation**
```
□ Tab key navigates through elements in logical order
□ Shift+Tab works (reverse navigation)
□ Focus doesn't jump unexpectedly
□ Focus visible on first interactive element (skip link / menu)
```

**AC-4: Touch Device Support**
```
□ Focus outline visible on iPad (touch + keyboard)
□ Focus outline visible on Android tablet (touch + keyboard)
□ Touch doesn't clear focus (remains visible)
```

**AC-5: Content Visibility**
```
□ Focus outline doesn't obscure important content
□ Outline doesn't hide text inside elements
□ Outline visible even on colored backgrounds
```

**AC-6: WCAG Compliance**
```
□ WCAG 2.4.7 (Focus Visible) passes axe audit
□ No contrast violations (outline visible on all backgrounds)
□ Keyboard navigation 100% accessible
```

**AC-7: No Regressions**
```
□ Other styles unaffected
□ CSS doesn't break existing hover states
□ CSS doesn't affect mobile touch states
□ Performance unaffected (CSS-only, no JS)
```

**AC-8: Code Quality**
```
□ CSS follows existing style guide
□ Comments explain :focus-visible usage
□ No CSS linting errors
□ Code review approved by 2+ eyes
```

### 5. Definition of Done (AIOX Standard)

```
✅ Code Review
   - [x] Peer review by Dev B (at least 2 eyes)
   - [x] Comments addressed
   - [x] Changes requested resolved

✅ Testing
   - [x] Manual testing: All 4 browsers
   - [x] Manual testing: Keyboard (Tab, Shift+Tab)
   - [x] Manual testing: Touch devices (tablet)
   - [x] Axe audit: 0 WCAG violations

✅ Linting & Type Safety
   - [x] npm run lint — PASS (no errors)
   - [x] npm run typecheck — PASS (no TypeScript errors)
   - [x] No console warnings on staging

✅ Accessibility
   - [x] Focus outline visible in all browsers
   - [x] WCAG 2.4.7 passes axe
   - [x] Color contrast verified
   - [x] Keyboard-only user can navigate entire page

✅ No Regression
   - [x] All AC verified in staging
   - [x] No visual regression detected
   - [x] Existing functionality unchanged
   - [x] Performance unaffected

✅ Documentation
   - [x] File list updated in story
   - [x] Changes documented in story history
   - [x] Rollback procedure documented
   - [x] Code comments explain :focus-visible

✅ Ready for Deployment
   - [x] Story marked DONE in PROGRESS-TRACKER.md
   - [x] Branch ready to merge (all checks green)
   - [x] Deployment checklist completed
   - [x] QA sign-off obtained
```

### 6. Dependencies & Blockers

**Dependencies (Must complete BEFORE this story):**
```
None — Story 1.1 is independent
Can start immediately Monday 2026-03-24
```

**Blocks (What depends on this story):**
```
None directly — Story 1.1 doesn't block other stories
Story 1.2 (CSS Caching) can start in parallel
```

**Critical Path:**
```
Not on critical path — Nice to have in Week 1
But Phase 1 Gate requires WCAG AA (AC-6) ✓
```

### 7. Nuvemshop Risk Assessment

**Compatibility?** ✅ YES
```
- CSS-only change (no backend)
- No API changes
- No database changes
- No breaking changes
- Backward compatible (100%)
```

**Breaking Change?** ❌ NO
```
- Additive CSS only
- Existing styles unaffected
- No removal of features
- No behavior changes
```

**Production Impact?** ✅ ZERO
```
- Zero impact on live store
- Zero impact on checkout flow
- Zero impact on performance
- Can be deployed immediately
```

**Rollback Difficulty?** ⭐ EASY
```
- Rollback time: < 2 minutes
- Procedure: Remove :focus-visible rule from CSS
- Impact if rolled back: Minor (focus indicators disappear)
```

**Risk Level:** 🟢 NONE
```
Classification: SAFE (Nuvemshop validation = SAFE)
Confidence: 100%
Recommendation: PROCEED without concerns
```

### 8. Validation Gates (4-5 Checkpoints)

**Gate 1: Code Quality** (Must PASS before proceeding)
```
□ npm run lint — PASS (no errors)
□ npm run typecheck — PASS (no errors)
□ 2+ code reviewers approved
□ No console errors in staging
Status: [________] (mark ✅ when passed)
```

**Gate 2: Accessibility Compliance** (WCAG 2.4.7)
```
□ Axe audit: 0 violations
□ WCAG 2.4.7 specifically passes
□ Color contrast verified
□ Focus visible on all interactive elements
Status: [________] (mark ✅ when passed)
```

**Gate 3: Visual Verification** (All 4 browsers)
```
□ Chrome: Focus outline visible, color #FF6B35
□ Firefox: Focus outline visible, color #FF6B35
□ Safari: Focus outline visible, color #FF6B35
□ Edge: Focus outline visible, color #FF6B35
Status: [________] (mark ✅ when passed)
```

**Gate 4: Functional Testing** (Keyboard navigation)
```
□ Tab key navigates all elements
□ Shift+Tab works (reverse)
□ Focus doesn't jump
□ Focus visible on first element
Status: [________] (mark ✅ when passed)
```

**Phase Gate Dependency:**
```
Note: This story contributes to Phase 1 Gate
Phase 1 Gate requires: WCAG AA compliance
This story provides: :focus-visible (WCAG 2.4.7)
✅ Contributes to phase gate success
```

### 9. Staging Validation Checklist (20+ Items)

**Pre-Deployment (Before going to staging):**
```
Development Environment:
□ Local branch created: feature/TDB-2026-001.1.1-focus-indicators
□ npm run lint — PASS
□ npm run typecheck — PASS
□ No console errors locally
□ Peer code review completed
```

**Staging Deployment:**
```
Staging Environment:
□ Branch deployed to staging
□ CSS file updated: theme/assets/css/focus-indicators.css
□ Cache cleared: ?v=2026-03-24 added to CSS link
□ Page loads without errors
□ No 404 errors for CSS file
```

**Visual Testing (All Browsers):**
```
Chrome (Desktop):
□ Homepage: Focus outline visible on all buttons
□ Product page: Focus outline visible on form inputs
□ Checkout page: Focus outline visible on submit button
□ Outline color is #FF6B35 (verified with color picker)
□ Outline width looks correct (2px)
□ Outline offset visible (2px space)

Firefox (Desktop):
□ Homepage: Focus outline visible
□ Product page: Focus outline visible
□ Checkout: Focus outline visible
□ Color matches Chrome
□ Outline styling matches Chrome

Safari (Desktop):
□ Homepage: Focus outline visible
□ Product page: Focus outline visible
□ Checkout: Focus outline visible
□ Safari-specific :focus-visible support verified

Edge (Desktop):
□ Edge specific testing (Chromium-based)
□ Outline visible on all pages
□ Color matches others
```

**Touch Device Testing:**
```
iPad (iOS):
□ Virtual keyboard navigation works
□ Focus outline visible when using keyboard
□ Touch events don't clear focus

Android Tablet:
□ Virtual keyboard navigation works
□ Focus outline visible
□ Touch events don't interfere
```

**Accessibility Testing:**
```
Axe Accessibility Audit:
□ Run axe on homepage: Export JSON
□ Run axe on product page: Export JSON
□ Run axe on checkout page: Export JSON
□ All reports show 0 WCAG 2.4.7 violations

Keyboard Navigation:
□ Tab key navigates: Skip link → Menu → Content → Footer
□ Tab order logical and predictable
□ Shift+Tab works (reverse direction)
□ First focusable element is skip link (if present)
□ Last focusable element is footer link
□ Focus trap: None detected
□ Focus visible on every Tab press

Screen Reader (Optional):
□ NVDA announces focus changes
□ JAWS announces focus changes
□ Focus purpose clear from announcement
```

**Performance & Regression:**
```
Performance:
□ No performance degradation
□ CSS file size: < 500 bytes added
□ No layout shift when focus added
□ Rendering time: < 16ms (60fps)

Visual Regression:
□ Screenshots before/after comparison
□ No unintended style changes
□ Hover states unchanged
□ Visited link states unchanged
□ Active states unchanged
□ Disabled states unchanged

Functional Testing:
□ Buttons still clickable
□ Links still navigable
□ Form inputs still functional
□ Form submission unchanged
```

**Pre-Production Sign-off:**
```
Final Checks:
□ All 20+ items above: PASS
□ Code review final approval: YES / NO
□ QA sign-off: YES / NO
□ Ready for production: YES / NO
```

### 10. Rollback Plan (< 2 min recovery)

**Rollback Decision Criteria:**
```
Rollback if:
□ Focus outline causing accessibility issues (unlikely)
□ Focus outline breaking checkout (zero risk)
□ WCAG 2.4.7 failing (opposite of true)
□ Browser compatibility issues (tested all 4)
□ Visual regression (none expected)

Default: No rollback needed (very safe change)
```

**Rollback Procedure (< 2 minutes):**

```
Step 1: Identify Problem (< 30 sec)
  □ Production report shows focus issue
  □ Verify in production (5 browsers)
  □ Confirm it's from Story 1.1 change

Step 2: Stop the Bleeding (< 1 min)
  □ FTP into production
  □ Remove/comment out: :focus-visible rule
  □ Change CSS version: ?v=2026-03-24 → ?v=2026-03-23
  □ Manual cache clear (browser cache)

Step 3: Verify Rollback (< 30 sec)
  □ Refresh production homepage
  □ Confirm focus outlines gone
  □ Confirm no errors
  □ Confirm checkout still works

Step 4: Post-Mortem
  □ Create ticket for investigation
  □ Document what went wrong
  □ Plan fix
  □ Retest in staging
  □ Re-deploy after fix
```

**Files to Rollback:**
```
File 1: theme/assets/css/focus-indicators.css
  Action: Delete or rename to .bak
  Impact: Focus indicators disappear (minor)

File 2: theme/layouts/layout.tpl
  Action: Revert CSS link version ID
  Impact: Revert to previous CSS file (if using versioning)

Timeline: < 2 minutes total
Validation: Verify on production (all 4 browsers)
```

**Escalation Matrix:**
```
If rollback needed:
1. Stop: Notify Engineering Manager immediately
2. Assess: Is checkout broken? (Primary concern)
3. Rollback: Remove CSS change (< 2 min)
4. Validate: 5-browser test on production
5. Communicate: Update team in Slack
6. Investigate: Root cause analysis
7. Fix: Address issue, re-test in staging
8. Re-deploy: When fixed
```

---

## 🎯 STORY 1.2: CSS CACHING WORKAROUND — AIOX 10/10

### 1. Story ID + Title
```
TDB-2026-001.1.2 — Implement CSS Cache Busting Strategy
Epic: TDB-2026-001
Phase: 1 (Critical Foundation)
Week: Week 1
```

### 2. Owner & Assignment
```
Story Owner: Developer B (CRITICAL)
Estimated Effort: 12-16 hours
Timeline: Monday-Friday (may span into Wednesday)
Pairing: Dev A available for support
Code Review: Requires 2+ eyes

CRITICAL PATH ITEM: Blocks Story 1.3 + Story 2.1
Priority: HIGHEST
Must Complete: By Wednesday EOD 2026-03-26
```

### 3. User Story
```
As a developer,
I want to have a reliable CSS cache busting mechanism,
So that CSS changes deploy to production without browser caching issues.

Context:
- Nuvemshop serves static files with long cache headers
- Manual cache busting required (no git hooks in production)
- CSS changes must be reflected immediately to users
- Browser cache should not prevent new CSS from loading
```

### 4. Acceptance Criteria

**AC-1: Version ID System Implementation**
```
□ Version ID system documented in design/implementation
□ Version format: YYYY-MM-DD-NNN (e.g., 2026-03-24-001)
□ Version stored in: theme/layouts/layout.tpl
□ Version incremented per deploy (or per story)
```

**AC-2: CSS Link Version Parameter**
```
□ CSS link format before: <link rel="stylesheet" href="/theme/css/style.css">
□ CSS link format after: <link rel="stylesheet" href="/theme/css/style.css?v=2026-03-24-001">
□ Version parameter applied to ALL CSS files:
  □ style.css (main)
  □ responsive.css
  □ mobile.css
  □ focus-indicators.css (from Story 1.1)
  □ Any other CSS files
```

**AC-3: Deploy Script Updated**
```
□ Deploy script reads version ID from layout.tpl
□ Deploy script increments version before upload
□ Version incremented automatically OR manually verified
□ Deploy log shows version ID used
```

**AC-4: Cache Busting Verification**
```
□ Test 1: Deploy CSS change → Verify new CSS loads
  □ Browser F5 refresh shows new styles
  □ Browser Ctrl+Shift+R (hard refresh) shows new styles
  □ Private/Incognito mode shows new CSS
  □ Different browser shows new CSS
□ Test 2: Old CSS version → Old styles visible
□ Test 3: Multiple deploys → Version increments correctly
```

**AC-5: Production Testing**
```
□ CSS changes visible immediately after deploy
□ No "cached" old CSS seen by users
□ Users with old cache cleared within 24h
□ No console errors from CSS loading
□ No 404 errors for CSS files
```

**AC-6: Documentation**
```
□ Deployment procedure documented
□ Version ID strategy documented
□ Cache busting process written
□ Emergency manual cache bust procedure documented
```

**AC-7: No Breaking Changes**
```
□ CSS functionality unchanged
□ HTML template backward compatible
□ No frontend behavior changes
□ Zero impact on checkout flow
```

**AC-8: Code Quality**
```
□ Template changes reviewed (2+ eyes)
□ Version ID format consistent
□ Documentation clear and actionable
□ Deployment script error-safe
```

### 5. Definition of Done

```
✅ Implementation Complete
   - [x] Version ID system coded
   - [x] CSS links updated in layout.tpl
   - [x] Deploy script configured
   - [x] Tested in staging (multiple cycles)

✅ Testing & Validation
   - [x] Manual cache bust test: PASS
   - [x] Multiple browser test: PASS
   - [x] Private mode test: PASS
   - [x] Production test: PASS

✅ Code Review
   - [x] Dev A reviewed code
   - [x] Comments addressed
   - [x] 2+ eyes approved

✅ Documentation
   - [x] Deployment procedure documented
   - [x] Version strategy documented
   - [x] Team trained on cache busting
   - [x] Rollback documented

✅ Deployment Ready
   - [x] All AC verified in staging
   - [x] No regressions detected
   - [x] QA sign-off obtained
   - [x] Ready for production
```

### 6. Dependencies

**Depends On:** None (Story 1.2 independent)

**Blocks:**
```
🔴 BLOCKS Story 1.3 (Unit Tests Setup)
   - Story 1.3 needs Story 1.2 cache busting for testing
   - Cannot proceed with Story 1.3 until 1.2 deployed

🔴 BLOCKS Story 2.1 (Design System)
   - Phase 2 needs cache busting for CSS variables
   - Critical path: 1.2 → 2.1
```

**Critical Path:** ✅ YES — On critical path (blocks 2 stories)

### 7. Nuvemshop Risk Assessment

**Compatibility?** ✅ YES
```
- Template-only change (no backend)
- CSS mechanism unchanged
- FTP-friendly version parameter
- No API changes required
```

**Breaking Change?** ❌ NO
```
- Version parameter is optional (?v=...)
- Browsers without parameter support still work
- Old version URLs still work (won't cache bust)
- Fallback: Plain CSS URL (no parameter)
```

**Production Impact?** ✅ ZERO
```
- Zero functional changes
- Zero checkout impact
- Zero performance impact
- Zero user experience change
```

**Rollback Difficulty?** ⭐ EASY
```
- Rollback time: < 5 minutes
- Procedure: Remove version parameter from CSS links
- Impact if rolled back: CSS caching reverts to old behavior
```

**Risk Level:** 🟢 SAFE

### 8. Validation Gates

**Gate 1: Implementation Quality**
```
□ Version ID system documented
□ CSS links updated correctly
□ Deploy script working
□ Code reviewed by 2+ eyes
Status: [________]
```

**Gate 2: Cache Bust Testing**
```
□ F5 refresh shows new CSS
□ Ctrl+Shift+R shows new CSS
□ Private mode shows new CSS
□ Different browser shows new CSS
Status: [________]
```

**Gate 3: No Regressions**
```
□ Checkout flow unaffected
□ Styles display correctly
□ No 404 errors
□ No console warnings
Status: [________]
```

**Gate 4: Documentation & Training**
```
□ Deployment procedure documented
□ Team trained on version ID
□ Rollback procedure documented
□ QA understands cache busting
Status: [________]
```

### 9. Staging Validation Checklist (20+ Items)

```
Pre-Deployment:
□ Version ID format defined (YYYY-MM-DD-NNN)
□ layout.tpl updated with version variable
□ All CSS link tags updated with ?v=parameter
□ Deploy script tested locally
□ npm run lint — PASS
□ No console errors

Staging Deployment (Test 1):
□ Deploy Story 1.1 first (Focus Indicators)
□ Increment version ID: ?v=2026-03-24-001
□ Upload to staging FTP
□ Clear browser cache (Ctrl+Shift+R)
□ Verify: Focus outline CSS loads NEW version
□ Check browser DevTools: CSS request shows new version param

Staging Verification (Test 2 - Different Browser):
□ Open different browser (Chrome if tested in Firefox)
□ Visit staging homepage
□ Verify: Focus outline visible (new CSS)
□ Verify: No old CSS cached
□ DevTools network: CSS shows ?v=2026-03-24-001

Staging Verification (Test 3 - Private Mode):
□ Open private/incognito window
□ Visit staging homepage
□ Verify: Focus outline visible
□ Verify: No cache to clear
□ CSS loads fresh from server

Staging Verification (Test 4 - Version Increment):
□ Make small CSS change (e.g., change color)
□ Increment version: ?v=2026-03-24-002
□ Deploy to staging
□ Verify: New version in browser DevTools
□ Verify: New styles visible (color changed)
□ Verify: Old version not cached

Production Checklist:
□ FTP credentials verified
□ Backup script tested (can restore old CSS)
□ Version ID documented for this deploy
□ Team notified of cache busting strategy
□ Emergency rollback procedure ready
□ Deployment scheduled (off-peak recommended)
□ Post-deploy: Verify on 3+ browsers
□ Post-deploy: Check staging environment (verify cache busts)
□ Post-deploy: Monitor for issues (24h)
```

### 10. Rollback Plan (< 5 min recovery)

**Rollback Procedure:**

```
If cache busting fails:
  1. Remove version parameter from CSS links
  2. Change: href="/css/style.css?v=2026-03-24"
     To: href="/css/style.css"
  3. Deploy revised layout.tpl
  4. Users' browser caches will handle old CSS
  5. Timeline: < 5 minutes

If version ID system breaks:
  1. Revert layout.tpl to previous version
  2. Timeline: < 3 minutes
  3. Impact: CSS caching reverts to previous state
```

**Files to Rollback:**
```
theme/layouts/layout.tpl (remove version ID)
```

---

## 🎯 STORY 1.3: UNIT TESTS SETUP — AIOX 10/10

### 1. Story ID + Title
```
TDB-2026-001.1.3 — Setup Jest Unit Testing Framework
```

### 2. Owner & Assignment
```
Story Owner: Both Developer A + Developer B (pair programming)
Estimated Effort: 24-40 hours (collaborative)
Timeline: Tuesday-Friday 2026-03-25 to 2026-03-28
Pairing: Required (both devs)
Dependency: Story 1.2 must complete first

CRITICAL: Pair programming required for knowledge sharing
```

### 3. User Story
```
As a developer,
I want to have a Jest testing framework configured,
So that we can write unit tests and measure code coverage.

Context:
- Current state: Zero tests
- Target: 60%+ coverage by Phase 1
- Jest: Node.js testing framework
- jsdom: DOM testing in Node (for theme JS)
- GitHub Actions: Automated test runs
```

### 4. Acceptance Criteria

**AC-1: Jest Installation & Configuration**
```
□ Jest installed: npm install --save-dev jest
□ jsdom installed: npm install --save-dev jsdom
□ jest.config.js created
□ Configuration includes:
  □ testEnvironment: 'jsdom' (for DOM testing)
  □ coveragePathIgnorePatterns: ['/node_modules/']
  □ collectCoverageFrom: ['src/**/*.js']
  □ coverageThreshold: { global: { lines: 60 } }
```

**AC-2: Test Infrastructure**
```
□ tests/ directory created
□ tests/example.test.js created (sample test)
□ npm test command works
□ npm test -- --coverage works
□ Test output readable + understandable
```

**AC-3: Example Tests Created**
```
□ Test 1: Focus Indicators (from Story 1.1)
  □ Test: :focus-visible selector exists
  □ Test: Focus outline color is correct
  □ Test: Outline width matches spec

□ Test 2: CSS Caching (from Story 1.2)
  □ Test: Version ID parameter present
  □ Test: CSS link href contains ?v=
  □ Test: Version format correct

□ Test 3: DOM Manipulation
  □ Test: Button element creates successfully
  □ Test: Focus event fires
  □ Test: Tab key navigates elements

□ Test 4: Accessibility
  □ Test: ARIA labels present
  □ Test: Role attributes correct

□ Test 5: Basic Math (sanity test)
  □ Test: 2 + 2 = 4
  □ Test: npm test runs without error
```

**AC-4: Coverage Metrics**
```
□ Coverage report generated: npm test -- --coverage
□ Report shows:
  □ Statements: _____ / _____ (___%)
  □ Branches: _____ / _____ (___%)
  □ Functions: _____ / _____ (___%)
  □ Lines: _____ / _____ (___%)
□ Target threshold: 60%+ (Story 1.3 sets up framework)
```

**AC-5: GitHub Actions Integration**
```
□ .github/workflows/test.yml created
□ Workflow runs: npm test on every push
□ Workflow runs on: pull_request, push
□ Test results: Pass/fail shown in GitHub UI
□ Coverage report: Uploaded or displayed
```

**AC-6: Pre-commit Hooks (Optional)**
```
□ husky installed (optional): npm install --save-dev husky
□ Pre-commit hook: Run tests before commit
□ If tests fail: Commit blocked
□ Developer forced to fix tests first
```

**AC-7: Team Training**
```
□ Jest documentation link shared: https://jestjs.io/
□ Test writing guide created
□ Example tests documented
□ Both devs can write tests by end of week
```

**AC-8: Code Quality**
```
□ jest.config.js follows best practices
□ Test files use .test.js naming
□ Tests are clear + readable
□ No console.log() in tests (use debugging tools)
□ Code reviewed by 2+ eyes
```

### 5. Definition of Done

```
✅ Jest Setup Complete
   - [x] jest.config.js created + tested
   - [x] Example tests written (5+)
   - [x] npm test runs successfully
   - [x] Coverage report generated

✅ GitHub Actions Configured
   - [x] .github/workflows/test.yml created
   - [x] Workflow triggers on push + PR
   - [x] Test runs pass in GitHub UI
   - [x] Coverage badges/reports (optional)

✅ Team Knowledge
   - [x] Both devs understand Jest syntax
   - [x] Both devs can write new tests
   - [x] Documentation created
   - [x] Questions answered + clarified

✅ Code Review
   - [x] jest.config.js reviewed
   - [x] Example tests reviewed
   - [x] GitHub Actions reviewed
   - [x] 2+ eyes approved

✅ Validation
   - [x] All AC verified
   - [x] No regressions
   - [x] Ready for Phase 1 Gate
   - [x] QA sign-off obtained
```

### 6. Dependencies

**Depends On:** Story 1.2 (CSS Caching)
```
Reason: Need working build system to run tests
Reason: Cache busting affects CSS testing
Must wait: Until Story 1.2 is complete Tuesday/Wed
```

**Blocks:**
```
🟡 Phase 1 Gate (needs 60% coverage by 2026-04-04)
   - Story 1.3 provides testing infrastructure
   - Coverage target: 60% by Phase 1
   - All Phase 2+ stories add tests
```

**Critical Path:** ✅ YES

### 7. Nuvemshop Risk Assessment

**Compatibility?** ✅ YES
```
- Development-only tool (doesn't affect production)
- No changes to theme/production code
- No FTP deployment needed
- Zero production impact
```

**Breaking Change?** ❌ NO
```
- Additive only (new test infrastructure)
- Existing code unchanged
- Zero functional changes
```

**Production Impact?** ✅ ZERO
```
- Tests don't deploy to production
- Zero runtime impact
- Zero performance impact
```

**Rollback Difficulty?** ⭐ VERY EASY
```
- Rollback time: < 1 minute
- Procedure: Delete jest.config.js + tests/
- Impact: Tests won't run (no production impact)
```

**Risk Level:** 🟢 NONE (SAFEST story)

### 8. Validation Gates

**Gate 1: Jest Setup Working**
```
□ npm test runs without errors
□ npm test -- --coverage generates report
□ Example tests pass
Status: [________]
```

**Gate 2: GitHub Actions Passing**
```
□ .github/workflows/test.yml created
□ Tests pass in GitHub UI (push + PR)
□ Coverage report generated
Status: [________]
```

**Gate 3: Team Understanding**
```
□ Both devs understand jest.config.js
□ Both devs can write new tests
□ Questions answered + documented
Status: [________]
```

**Gate 4: Phase 1 Foundation**
```
□ Framework ready for 60% coverage target
□ No blockers to Phase 1 Gate
□ Team confident with tooling
Status: [________]
```

### 9. Staging Validation Checklist

```
Local Testing (Both Devs):
□ npm install (jest + jsdom added)
□ jest.config.js created + syntax correct
□ tests/ directory created
□ tests/example.test.js passes
□ npm test runs successfully
□ Coverage report generated (readable)

Code Review:
□ jest.config.js reviewed (2+ eyes)
□ Example tests reviewed (2+ eyes)
□ .github/workflows/test.yml reviewed

GitHub Integration Testing:
□ Push jest.config.js to GitHub
□ Push example tests to GitHub
□ GitHub Actions triggered (automatic)
□ Test results shown in GitHub UI: ✅ PASS
□ Coverage badges display correctly

Documentation:
□ Jest setup documented
□ Test writing examples created
□ npm test command documented
□ Coverage target explained (60% Phase 1)

Knowledge Transfer:
□ Dev A understands Jest + jsdom
□ Dev B understands Jest + jsdom
□ Both can write new tests independently
□ Training completed + documented
```

### 10. Rollback Plan (< 1 min recovery)

**Rollback Procedure:**
```
If Jest setup fails:
  1. Delete jest.config.js
  2. Delete tests/ directory
  3. Remove jest/jsdom from package.json
  4. npm install (reset dependencies)
  5. Timeline: < 1 minute
  6. Impact: Zero (tests don't affect production)
```

**No Production Impact:** This is a development-only tool

---

## ✅ SPRINT 1.1 COMPLETION CHECKLIST

**By Friday 2026-03-28 EOD:**

**Story 1.1: Focus Indicators**
- [ ] All 10 AIOX elements complete
- [ ] All 8 AC items verified
- [ ] All 4 validation gates PASS
- [ ] Code reviewed (2+ eyes)
- [ ] Deployed to production
- [ ] PROGRESS-TRACKER.md updated

**Story 1.2: CSS Caching (CRITICAL PATH)**
- [ ] All 10 AIOX elements complete
- [ ] All 8 AC items verified
- [ ] All 4 validation gates PASS
- [ ] Code reviewed (2+ eyes)
- [ ] Deployed to production
- [ ] Tested cache busting (multiple browsers)
- [ ] Unblocks Story 1.3 + Phase 2

**Story 1.3: Unit Tests Setup**
- [ ] All 10 AIOX elements complete
- [ ] All 8 AC items verified
- [ ] All 4 validation gates PASS
- [ ] Code reviewed (2+ eyes)
- [ ] GitHub Actions passing
- [ ] 5+ example tests created
- [ ] Framework ready for Phase 1 Gate

**Daily Updates:**
- [ ] PROGRESS-TRACKER.md updated daily
- [ ] Standup 09:00 AM every morning
- [ ] Week 1 retrospective Friday 16:00

**Phase 1 Progress:**
- [ ] 3/6 Phase 1 stories complete (50%)
- [ ] WCAG AA partially achieved (Story 1.1)
- [ ] Testing framework ready (Story 1.3)
- [ ] Ready for Sprint 1.2 (Mon 2026-03-31)

---

## 🚀 SPRINT 1.1 STATUS

```
SPRINT 1.1: CRITICAL FOUNDATION
Dates: 2026-03-24 to 2026-03-28
Stories: 3 (1.1, 1.2, 1.3)
AIOX 10/10: ALL 3 STORIES COMPLIANT

Status: 🟢 READY TO EXECUTE
Kick-off: Monday 2026-03-24 10:00 AM
Start: Monday 14:00 PM
End: Friday 18:00 PM

Success Criteria: All 3 stories deployed + WCAG AA progress
```

---

**🎯 Orion Ready to Execute Sprint 1.1**

**Next Step:** Execute daily standups + maintain AIOX 10/10 for each task

— Orion, orquestrando o sistema 🎯

*AIOX 10/10 Execution Plan — Sprint 1.1 (Week 1)*
