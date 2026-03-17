# Sprint Plan - TDB-2026-001 Technical Debt Resolution (AIOX 10/10)

**Status:** DRAFT (Awaiting Approval)
**Created:** 2026-03-17
**Target Start:** 2026-03-24
**Target End:** 2026-05-19 (8 weeks)
**Team:** 2 developers
**Duration:** 8 weeks (4 phases, 4 sprints)
**Total Stories:** 21
**Total Story Points:** 140

---

## Executive Summary

This Sprint Plan implements the 21 technical debts identified in Epic TDB-2026-001 across 4 phases over 8 weeks with 2 full-time developers. The plan follows AIOX 10/10 standards with comprehensive acceptance criteria, Definition of Done, risk assessment, validation gates, staging checklists, and rollback procedures for each story.

**Key Constraints (Nuvemshop):**
- Theme-only platform (no backend changes)
- FTP deployment model
- Zero-impact requirement (backward compatible)
- Manual CSS cache busting required
- 5-15 minute rollback window acceptable

**Success Metrics:**
- WCAG AA compliance: 100%
- Lighthouse score: 85+ (mobile)
- Test coverage: 80%+
- Regression rate: <5%

---

## PHASE 1: CRITICAL & FOUNDATION (Weeks 1-2)

**Goals:** Accessibility compliance + Testing infrastructure
**Stories:** 6 (3 per sprint)
**Effort:** 57-82 hours
**Phase Gate:** WCAG AA achieved + 60% coverage

### Sprint 1.1 (Week 1: Mar 24-28)

---

#### Story TDB-2026-001.1.1: Implement Focus Indicators

**Epic:** TDB-2026-001
**Severity:** CRITICAL
**Priority:** P0 (Legal requirement - WCAG 2.4.7)
**Effort:** 2-4 hours
**Owner:** [dev name TBD]
**Component:** Accessibility + CSS

**User Story:**
```
As a keyboard-only user,
I want to see a clear focus outline when tabbing through interactive elements,
So that I can navigate the website and know which element has focus.
```

**Acceptance Criteria:**
- [ ] `:focus-visible` CSS rule added to `theme/static/css/accessibility.css`
- [ ] All interactive elements (buttons, links, inputs, selects, a[href]) show visible outline
- [ ] Outline is 3px width, 2px offset, primary color (#FF6B35)
- [ ] Outline visible on Chrome, Firefox, Safari, Edge (last 2 versions)
- [ ] No content obscured by outline (outline-offset: 2px)
- [ ] Keyboard TAB navigation works on all focusable elements
- [ ] Touch devices: focus visible on interactive element tap
- [ ] WCAG 2.4.7 (Focus Visible): PASS in automated audit

**Definition of Done (AIOX):**
- [ ] Code reviewed by peer (2+ eyes)
- [ ] All AC verified in staging environment
- [ ] No linting errors (`npm run lint` passes)
- [ ] No type errors (`npm run typecheck` passes, if applicable)
- [ ] Accessibility audit passes (axe DevTools: 0 violations)
- [ ] No regression: existing :hover/:active behavior unchanged
- [ ] File list updated: `theme/static/css/accessibility.css`
- [ ] Story file updated with completion status
- [ ] Ready for production validation

**Dependencies:**
- None (independent story)

**Blockers:**
- None identified

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (CSS only, theme-native)
- **Breaking Change:** ❌ NO (addition only, backward compatible)
- **Live Store Impact:** ✅ ZERO (visual enhancement, no behavior change)
- **Data Impact:** ✅ ZERO (read-only, no data touched)
- **Rollback Difficulty:** ⭐ TRIVIAL (delete CSS lines, <1 minute)
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Code Quality
[ ] npm run lint - PASS
[ ] 0 console errors in staging DevTools
[ ] CSS file size unchanged (<2% variance)

Gate 2: Accessibility (WCAG 2.4.7)
[ ] axe DevTools audit - PASS (0 violations for focus)
[ ] Screen reader (NVDA/JAWS) - Announces element on focus
[ ] Color contrast verified (3:1 minimum on white)
[ ] :focus-visible applies to all interactive elements

Gate 3: Visual Verification
[ ] Outline visible on:
    [ ] Chrome (latest 2)
    [ ] Firefox (latest 2)
    [ ] Safari (latest 2)
    [ ] Edge (latest)
    [ ] Mobile Chrome
    [ ] Mobile Safari
[ ] Outline not obscuring critical content
[ ] Outline color (#FF6B35) consistent
[ ] Outline width (3px) readable on all screen sizes

Gate 4: Keyboard Navigation
[ ] TAB through all elements - outline appears on EVERY interactive element
[ ] SHIFT+TAB (reverse) - outline visible and correct
[ ] Enter/Space - activates focused element
[ ] No elements skipped in tab order
[ ] Focus visible immediately after key press

Gate 5: Functional
[ ] No regression: existing focus/hover/active unchanged
[ ] Touch devices: tap element → outline visible
[ ] No performance impact (CSS-only, <1ms parsing)
[ ] Works on 2G connection (CSS cached)
```

**Staging Validation Checklist (Before Production):**

```
**Date:** ____________
**Validated By:** ____________
**Store:** staging.patagang.nuvemshop.com
**Build Version:** ____________

BROWSER COMPATIBILITY:
[ ] Chrome 121+ (Windows, macOS, Android)
[ ] Firefox 122+
[ ] Safari 17+ (iOS, macOS)
[ ] Edge 121+
[ ] Mobile Chrome (Android 12+)
[ ] Mobile Safari (iOS 17+)

KEYBOARD TESTING:
[ ] Home page: TAB through all buttons → outline visible
[ ] Product page: TAB through product links → outline visible
[ ] Cart: TAB through quantity input, buttons → outline visible
[ ] Checkout: TAB through form fields → outline visible on ALL inputs
[ ] Header: TAB through navigation → outline visible
[ ] Footer: TAB through footer links → outline visible
[ ] SHIFT+TAB: Reverse navigation works correctly
[ ] Outline appears immediately (no delay)

TOUCH DEVICE TESTING:
[ ] Tap menu button → focus outline visible
[ ] Tap product link → focus outline visible
[ ] Tap form input → focus outline visible
[ ] Outline stays visible while scrolling
[ ] Outline disappears when tapping elsewhere

COLOR & CONTRAST:
[ ] Outline color is exactly #FF6B35
[ ] Contrast ratio >= 3:1 with background
[ ] Visible on light backgrounds (product cards, white)
[ ] Visible on dark backgrounds (footer)
[ ] Outline width (3px) readable

ACCESSIBILITY SCREEN READERS:
[ ] NVDA (Windows): Element announced on focus
[ ] JAWS (Windows): Element announced on focus
[ ] VoiceOver (macOS): Element announced on focus
[ ] Voiceover (iOS): Element announced on tap
[ ] No new a11y announcements needed

PERFORMANCE:
[ ] Page load time: < 50ms variance from baseline
[ ] Cumulative Layout Shift (CLS): < 0.1
[ ] No memory leaks (DevTools: Memory tab)
[ ] CSS file size: < 2% increase

VISUAL INSPECTION:
[ ] Outline matches design spec exactly
[ ] No content hidden by outline
[ ] Spacing around outline (offset: 2px) looks correct
[ ] Outline consistent on all element types
[ ] Different button states (hover, active, disabled)

FINAL CHECKS:
[ ] Staging: All tests PASSED
[ ] No critical findings
[ ] No WCAG violations
[ ] Safe to deploy: ✅ YES / ❌ NO
[ ] Approver signature: ________________
[ ] Approval timestamp: ________________
```

**Rollback Plan:**

```
IF ISSUES DETECTED IN STAGING:

1. Developer Rollback (Before Approval):
   [ ] Revert commit: git revert <commit-hash>
   [ ] Re-test in staging
   [ ] Document issue for re-attempt
   [ ] (Do NOT approve until fixed)

IF DEPLOYED TO PRODUCTION AND ISSUES FOUND:

2. Immediate Rollback (< 5 minutes):
   [ ] Access FTP: ftp.nuvemshop.com.br
   [ ] Navigate: /theme/static/css/
   [ ] Restore: accessibility.css from backup/previous version
   [ ] FTP upload complete
   [ ] Clear browser cache (version bump in theme)
   [ ] Verify in production: http://patagang.nuvemshop.com.br
   [ ] Check: Focus outline gone, site renders normally

3. Root Cause Analysis (Post-Rollback):
   [ ] What CSS broke rendering?
   [ ] Why not caught in staging?
   [ ] Update staging validation checklist
   [ ] Document for team wiki

4. Timeline:
   Revert code: < 1 min
   FTP upload: < 2 min
   Cache clear: < 2 min
   Verification: < 5 min
   TOTAL: < 15 minutes (acceptable)

5. Notification (if production rollback occurs):
   [ ] Message support team: "Rolled back focus indicator CSS"
   [ ] Update status page
   [ ] Post mortem within 24h
```

**Implementation Notes:**
- **File:** `theme/static/css/accessibility.css` (create if doesn't exist)
- **Lines Added:** ~15 CSS lines
- **No JavaScript changes**
- **No HTML structure changes**
- **Deploy method:** FTP + cache-buster version bump
- **Testing:** Manual keyboard navigation (TAB/SHIFT+TAB)

---

#### Story TDB-2026-001.1.2: CSS Caching Workaround Documentation

**Epic:** TDB-2026-001
**Severity:** CRITICAL
**Priority:** P0 (Blocks other CSS changes)
**Effort:** 3-5 hours
**Owner:** [dev name TBD]
**Component:** Build infrastructure

**User Story:**
```
As a developer,
I want a documented and tested CSS caching workaround,
So that CSS changes are immediately visible to users after deployment.
```

**Acceptance Criteria:**
- [ ] CSS cache-buster mechanism implemented (e.g., version query param)
- [ ] `theme/static/index.html` links CSS with `?v=` query parameter
- [ ] Version number auto-increments in build script on CSS change
- [ ] Tested: CSS change visible in <2 seconds after FTP deploy
- [ ] Rollback procedure documented (revert version number)
- [ ] Team wiki page created: "CSS Cache Busting Procedure"
- [ ] QA can verify: Modify CSS → Deploy → See change immediately

**Definition of Done (AIOX):**
- [ ] Workaround implemented and tested
- [ ] Documentation complete (wiki + inline comments)
- [ ] Version bump mechanism working
- [ ] Next 5 CSS changes tested with workaround
- [ ] Team trained on procedure
- [ ] Ready for production

**Dependencies:**
- Blocks: TDB-2026-001.1.5 (CSS Variables)
- Blocks: TDB-2026-001.2.1+ (All CSS-heavy stories)

**Blockers:**
- None (but critical path item)

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (static file workaround)
- **Breaking Change:** ❌ NO (infrastructure only)
- **Live Store Impact:** ✅ LOW (improves CSS deployment reliability)
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** ⭐ TRIVIAL (revert query param)
- **Risk Level:** LOW

**Validation Gates (Pre-Deploy):**

```
Gate 1: Cache Mechanism Verification
[ ] Version query param appears in HTML: <link href="...css?v=20260317001">
[ ] Version parameter changes when CSS updated
[ ] Old version still cached in browser (can test with ?v=old)

Gate 2: CSS Update Testing
[ ] Modify: Change primary color in CSS (e.g., #FF6B35 → #FF0000)
[ ] Deploy: Upload to FTP staging
[ ] Verify: Refresh page → New color appears (not cached)
[ ] Verify: Check DevTools Network tab → New version loaded

Gate 3: Rollback Testing
[ ] Revert version number
[ ] Refresh page → Old CSS appears
[ ] Version in URL changed
[ ] No manual cache clear needed

Gate 4: Documentation
[ ] Wiki page created with screenshots
[ ] Procedure tested by QA
[ ] Team signed off on procedure
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

CSS CACHE BUSTER TESTING:
[ ] FTP update CSS file
[ ] Open staging site in private window
[ ] CSS change appears immediately (no manual refresh needed)
[ ] Browser DevTools Network: New CSS version loaded
[ ] Query param incremented: ?v=20260317001

MULTIPLE BROWSER TEST:
[ ] Chrome: Cache buster works
[ ] Firefox: Cache buster works
[ ] Safari: Cache buster works

ROLLBACK TEST:
[ ] Revert version param to previous
[ ] Page refreshes → Old CSS appears
[ ] No issues reverting

TEAM PROCEDURE TEST:
[ ] QA follows wiki procedure
[ ] Dev A follows wiki procedure
[ ] Both succeed without questions
[ ] Wiki clarity: A+ rating

PERFORMANCE VERIFICATION:
[ ] No impact on page load time
[ ] CSS file size unchanged
```

**Rollback Plan:**

```
IF CACHE BUSTER BREAKS CSS LOADING:

1. Immediate Fix:
   [ ] Check HTML syntax: <link ... ?v=XXX">
   [ ] Verify version number is numeric
   [ ] Test with hardcoded version first
   [ ] Verify no special characters in param

2. Production Rollback:
   [ ] Restore previous HTML file from backup
   [ ] Revert to working version parameter
   [ ] Test in staging first
   [ ] Then deploy to production

3. If Mechanism Fails:
   [ ] Fallback: Use filename-based cache bust
      Example: theme-20260317.css instead of ?v=
   [ ] Re-test and document
```

**Implementation Notes:**
- **File:** `theme/static/index.html`, build script
- **No new dependencies**
- **Tested against real Nuvemshop cache behavior**
- **Deploy method:** FTP (static files)

---

#### Story TDB-2026-001.1.3: Setup Jest Testing Framework

**Epic:** TDB-2026-001
**Severity:** CRITICAL
**Priority:** P0 (Enables all future testing)
**Effort:** 5-8 hours
**Owner:** [dev name TBD]
**Component:** Development infrastructure

**User Story:**
```
As a developer,
I want a Jest testing framework configured for the project,
So that I can write unit tests for JavaScript and validate code changes.
```

**Acceptance Criteria:**
- [ ] Jest installed and configured: `npm install --save-dev jest @testing-library/dom`
- [ ] `jest.config.js` created with proper settings
- [ ] `package.json` scripts added: `npm test` and `npm test -- --coverage`
- [ ] Sample test file created and passing
- [ ] Code coverage threshold configured: 60% (Phase 1 goal)
- [ ] GitHub Actions workflow added: Runs tests on PR
- [ ] Team can run tests locally: `npm test`
- [ ] Coverage reports generated in CI/CD

**Definition of Done (AIOX):**
- [ ] Jest working locally (all devs tested)
- [ ] CI/CD pipeline running tests
- [ ] Coverage reporting configured
- [ ] Baseline tests (at least 3 utilities/components)
- [ ] Documentation: `docs/TESTING.md` created
- [ ] Team trained on Jest usage
- [ ] Ready for Phase 1 testing work

**Dependencies:**
- None (independent infrastructure story)

**Blockers:**
- None

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (development infrastructure only)
- **Breaking Change:** ❌ NO (no production changes)
- [ ] **Live Store Impact:** ✅ ZERO (development only)
- [ ] **Data Impact:** ✅ ZERO
- [ ] **Rollback Difficulty:** N/A (not deployed to production)
- [ ] **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Jest Installation & Config
[ ] npm test runs without errors
[ ] jest.config.js exists and is valid
[ ] package.json has test scripts
[ ] Node modules installed correctly

Gate 2: Sample Tests
[ ] At least 3 sample tests created and passing
[ ] Coverage report generated
[ ] Coverage > 60% on sample code

Gate 3: Developer Testing
[ ] Dev A runs tests locally: PASS
[ ] Dev B runs tests locally: PASS
[ ] All tests complete in < 5 seconds

Gate 4: CI/CD Integration
[ ] GitHub Actions workflow created
[ ] Tests run on every PR
[ ] Coverage reports visible in PR
[ ] Workflow passes on main branch
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

LOCAL TESTING:
[ ] npm install - completes successfully
[ ] npm test - runs all tests without errors
[ ] npm run test -- --coverage - generates report
[ ] All sample tests PASS

COVERAGE REPORT:
[ ] Statements: >= 60%
[ ] Branches: >= 50%
[ ] Functions: >= 60%
[ ] Lines: >= 60%

CI/CD VERIFICATION:
[ ] GitHub Actions triggered on PR
[ ] Tests run automatically
[ ] Report published in PR
[ ] Pass/fail status visible

DOCUMENTATION:
[ ] docs/TESTING.md created
[ ] Test structure documented
[ ] Example test included
[ ] Coverage targets documented

TEAM TESTING:
[ ] Dev A runs tests: PASS
[ ] Dev B runs tests: PASS
[ ] Both understand framework
[ ] Both can write tests
```

**Rollback Plan:**

```
IF JEST BREAKS THE BUILD:

1. Revert Installation:
   [ ] npm remove jest @testing-library/dom
   [ ] Delete jest.config.js
   [ ] Revert package.json changes
   [ ] npm install

2. If CI/CD Breaks:
   [ ] Disable GitHub Actions workflow temporarily
   [ ] Fix Jest configuration
   [ ] Test locally first
   [ ] Re-enable workflow

3. Alternative: Use npm test in isolation:
   [ ] Don't run tests in build pipeline yet
   [ ] Manual test runs only
   [ ] Enable CI/CD in Phase 2
```

**Implementation Notes:**
- **No production deployment**
- **Development tool only**
- **Uses Jest (industry standard, React ecosystem)**
- **@testing-library/dom for DOM testing**
- **GitHub Actions integration**

---

### Sprint 1.2 (Week 2: Mar 31-Apr 4)

---

#### Story TDB-2026-001.1.4: Add Alt Text to Product Images

**Epic:** TDB-2026-001
**Severity:** HIGH
**Priority:** P1 (WCAG 1.1.1 - Text alternatives for images)
**Effort:** 4-6 hours
**Owner:** [dev name TBD]
**Component:** Accessibility + Content

**User Story:**
```
As a visually impaired user using a screen reader,
I want all product images to have descriptive alt text,
So that I understand what the product looks like and make informed purchases.
```

**Acceptance Criteria:**
- [ ] All product images in product listing page have `alt` attributes
- [ ] All product images in product detail page have `alt` attributes
- [ ] All decorative images have `alt=""` (empty, proper semantics)
- [ ] Alt text is descriptive: "Blue ceramic mug with white handle" (not "image1" or "product")
- [ ] Alt text < 125 characters (readability for screen readers)
- [ ] Brand name included in alt text when relevant
- [ ] Color, size, or unique features mentioned if visible
- [ ] WCAG 1.1.1 (Non-text Content): PASS in automated audit

**Definition of Done (AIOX):**
- [ ] All product images have alt attributes
- [ ] Alt text reviewed by non-dev (QA or content person)
- [ ] Accessibility audit passes (axe: 0 violations for images)
- [ ] No linting errors
- [ ] HTML validation passes
- [ ] Screenshot comparison: Visual unchanged, alt text added
- [ ] File list updated: template files modified
- [ ] Ready for production

**Dependencies:**
- Depends on: TDB-2026-001.1.2 (CSS Caching - if CSS images involved)
- None critical

**Blockers:**
- None

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (HTML template changes)
- **Breaking Change:** ❌ NO (addition only)
- **Live Store Impact:** ✅ ZERO (improves SEO + accessibility)
- **Data Impact:** ✅ ZERO (read-only content)
- **Rollback Difficulty:** ⭐ TRIVIAL (remove alt attributes)
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Alt Text Coverage
[ ] Product listing page: All images have alt text (0 missing)
[ ] Product detail page: All images have alt text (0 missing)
[ ] Category pages: All images have alt text (0 missing)
[ ] Homepage: All product images have alt text
[ ] Decorative images: alt="" (empty attribute)

Gate 2: Alt Text Quality
[ ] Alt text descriptive (not "image", "photo", "product")
[ ] Alt text < 125 characters (max)
[ ] Alt text includes: color, size, or unique feature if relevant
[ ] Brand name included (e.g., "Patagang ceramic mug")
[ ] No duplicate alt text on different images

Gate 3: Accessibility Audit
[ ] axe DevTools: 0 violations for images
[ ] WCAG 1.1.1: PASS
[ ] Screen reader test: Alt text announced correctly

Gate 4: Visual Verification
[ ] Page renders correctly with alt text
[ ] No visual changes (alt attributes are invisible)
[ ] Product images appear as expected
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

COVERAGE VERIFICATION:
[ ] Product listing page: Every image has alt attribute
[ ] Product detail page: Every image has alt attribute
[ ] Category pages: All images have alt
[ ] Homepage: All product images have alt
[ ] No alt="" on content images (only decorative)

ALT TEXT QUALITY CHECK:
Sample reviews (10 images):
1. [ ] "Blue ceramic mug with white handle, 12oz capacity"
2. [ ] "Stainless steel spoon, mirror finish, 7 inches"
3. [ ] "Red ceramic bowl, handmade, 3-inch diameter"
4. [ ] "Glass water bottle with bamboo cap"
5. [ ] "Wooden cutting board, acacia wood, 18x12 inches"
6. [ ] "White ceramic plate, dishwasher safe"
7. [ ] "Black coffee mug, thermal insulated"
8. [ ] "Ceramic tile coasters, set of 4, cork backing"
9. [ ] "Stainless steel fork, polished finish"
10. [ ] "Decorative ceramic vase" (or alt="" if decorative)

ACCESSIBILITY TEST:
[ ] NVDA screen reader: Alt text announced correctly
[ ] JAWS: Alt text announces product details
[ ] Mobile screen reader: Alt text audible
[ ] axe DevTools: 0 image violations

SEOBENEFITS:
[ ] Image search keywords optimized
[ ] Product descriptions improved
[ ] No keyword stuffing detected

VISUAL CHECK:
[ ] Page renders correctly
[ ] No broken image icons
[ ] All product images visible
[ ] Layout unchanged
```

**Rollback Plan:**

```
IF ALT TEXT CAUSES ISSUES:

1. Immediate Rollback:
   [ ] Revert HTML template changes
   [ ] Restore previous product templates
   [ ] Re-deploy via FTP
   [ ] Verify pages display correctly

2. If Some Alt Text is Wrong:
   [ ] Identify incorrect entries
   [ ] Fix alt text in template
   [ ] Re-deploy just that template file
   [ ] (Don't need full rollback)

3. Root Cause:
   [ ] Was alt text breaking HTML?
   [ ] Were special characters causing issues?
   [ ] Document for improvement
```

**Implementation Notes:**
- **Files:** Product listing templates, product detail template
- **No JavaScript changes**
- **Content review recommended**
- **Improves both accessibility AND SEO**

---

#### Story TDB-2026-001.1.5: Implement CSS Variables System

**Epic:** TDB-2026-001
**Severity:** HIGH
**Priority:** P1 (Design system foundation)
**Effort:** 5-8 hours
**Owner:** [dev name TBD]
**Component:** Design system + CSS

**User Story:**
```
As a developer,
I want CSS custom properties (variables) defined for colors, spacing, and typography,
So that I can maintain a consistent design language and reduce style duplication.
```

**Acceptance Criteria:**
- [ ] CSS custom properties file created: `theme/static/css/variables.css`
- [ ] Color variables defined: primary (#FF6B35), secondary, neutral grays
- [ ] Spacing variables defined: 4px scale (4, 8, 12, 16, 20, 24, 32, 48px)
- [ ] Typography variables defined: font sizes, weights, line heights
- [ ] Breakpoint variables defined: mobile, tablet, desktop
- [ ] Variables documented in `docs/design-system/css-variables.md`
- [ ] All existing color values refactored to use variables
- [ ] No visual regressions (pixel-perfect match with previous)
- [ ] CSS file size <= 2KB (variables only)

**Definition of Done (AIOX):**
- [ ] Variables file created and integrated
- [ ] All colors refactored to use variables
- [ ] No linting errors
- [ ] No visual regressions detected
- [ ] Documentation complete with examples
- [ ] Team can use variables in new CSS
- [ ] Ready for Phase 2 design system work

**Dependencies:**
- Depends on: TDB-2026-001.1.2 (CSS Caching)

**Blockers:**
- CSS Caching must be working

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (CSS refactoring, no HTML/JS)
- **Breaking Change:** ❌ NO (visual-identical, internal refactor)
- **Live Store Impact:** ✅ ZERO (CSS-only change)
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** ⭐ TRIVIAL (revert CSS file)
- **Risk Level:** LOW

**Validation Gates (Pre-Deploy):**

```
Gate 1: Variables Definition
[ ] variables.css file created with proper syntax
[ ] All color vars defined (primary, secondary, neutrals)
[ ] All spacing vars defined (4px scale)
[ ] All typography vars defined (sizes, weights, line-heights)
[ ] All breakpoints as variables
[ ] Valid CSS (no syntax errors)

Gate 2: Refactoring
[ ] All hardcoded colors replaced with var()
[ ] All hardcoded spacing replaced with var()
[ ] No color values (hex/rgb) in component CSS
[ ] Fallback values present (for older browsers)
[ ] CSS file size: <= 2KB for variables

Gate 3: Visual Regression Testing
[ ] Homepage: Pixel-perfect match with baseline
[ ] Product page: Pixel-perfect match
[ ] Category page: Colors match exactly
[ ] All text sizes and spacing unchanged
[ ] No layout shifts (CLS < 0.01)

Gate 4: Browser Compatibility
[ ] Chrome/Firefox/Safari: Variables working
[ ] IE 11 fallback: Colors display correctly (using fallback)
[ ] Mobile: Variables working
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

VARIABLES FILE INSPECTION:
[ ] theme/static/css/variables.css exists
[ ] Syntax valid (no missing semicolons)
[ ] 20+ variables defined
[ ] Organized by category (colors, spacing, typography)

VARIABLE VALUES:
Colors:
[ ] Primary: #FF6B35 (Patagang brand)
[ ] Secondary: (defined)
[ ] Neutral gray range: (8 shades)

Spacing:
[ ] 4px, 8px, 12px, 16px, 20px, 24px, 32px, 48px defined

Typography:
[ ] Font sizes: 12px, 14px, 16px, 18px, 20px, 24px, 32px, 48px
[ ] Font weights: 400, 500, 600, 700
[ ] Line heights: 1.4, 1.5, 1.6

Breakpoints:
[ ] Mobile: < 640px
[ ] Tablet: 640px - 1024px
[ ] Desktop: > 1024px

REFACTORING VERIFICATION:
[ ] Colors using var() throughout CSS
[ ] No hex colors in component files
[ ] No RGB colors remaining
[ ] Fallback colors present
[ ] var() syntax correct (no typos)

VISUAL REGRESSION:
[ ] Homepage colors match baseline screenshot
[ ] Product page layout unchanged
[ ] Text sizes match baseline
[ ] Spacing matches baseline
[ ] No visual glitches

CROSS-BROWSER TESTING:
[ ] Chrome: Variables working
[ ] Firefox: Variables working
[ ] Safari: Variables working
[ ] Edge: Variables working
[ ] Mobile Chrome: Variables working

PERFORMANCE:
[ ] Page load time unchanged
[ ] CSS parsing time unchanged
[ ] No memory impact
```

**Rollback Plan:**

```
IF VARIABLES BREAK STYLING:

1. Immediate Rollback:
   [ ] Revert variables.css
   [ ] Restore original CSS files
   [ ] Re-deploy via FTP
   [ ] Verify site renders correctly

2. If Partial Issue:
   [ ] Identify which variable is causing issue
   [ ] Fix the variable value
   [ ] Test in staging
   [ ] Re-deploy just variables.css

3. Browser Fallback Issue:
   [ ] Add better fallback values
   [ ] Test in IE 11 specifically
   [ ] Verify all fallback colors set
```

**Implementation Notes:**
- **File:** `theme/static/css/variables.css` (new)
- **Refactors:** All existing CSS files to use var()
- **Uses:** CSS custom properties (CSS3, wide browser support)
- **Fallback:** Each var() call includes fallback color

---

#### Story TDB-2026-001.1.6: Fix Form Input Labels (a11y)

**Epic:** TDB-2026-001
**Severity:** HIGH
**Priority:** P1 (WCAG 1.3.1 - Form labels)
**Effort:** 3-5 hours
**Owner:** [dev name TBD]
**Component:** Accessibility + HTML

**User Story:**
```
As a user with screen reader or voice command,
I want form labels to be properly associated with inputs,
So that I can understand what each form field is for and complete forms independently.
```

**Acceptance Criteria:**
- [ ] All form inputs have associated `<label>` elements
- [ ] Labels use `for` attribute matching input `id`
- [ ] Placeholder attributes NOT used as label replacement
- [ ] All form fields properly labeled (text, email, password, select, textarea, checkbox, radio)
- [ ] Required fields marked with `required` attribute and aria-required="true"
- [ ] Error messages associated via aria-describedby
- [ ] WCAG 1.3.1 (Info and Relationships): PASS
- [ ] WCAG 3.3.2 (Labels or Instructions): PASS

**Definition of Done (AIOX):**
- [ ] All form labels fixed
- [ ] Accessibility audit passes (0 violations)
- [ ] Screen reader test: Labels announced correctly
- [ ] No visual changes
- [ ] File list updated: form templates modified
- [ ] Ready for production

**Dependencies:**
- None (independent story)

**Blockers:**
- None

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (HTML template changes)
- **Breaking Change:** ❌ NO (semantic improvement)
- **Live Store Impact:** ✅ ZERO (no behavior change)
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** ⭐ TRIVIAL (revert template)
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Label Association
[ ] All inputs have <label> elements
[ ] All labels have for="inputId"
[ ] All inputs have id matching label
[ ] No orphaned inputs
[ ] No orphaned labels

Gate 2: Required Field Markup
[ ] Required inputs: required attribute present
[ ] Required inputs: aria-required="true"
[ ] Required visual indicator present (asterisk, text)
[ ] Error messages linked via aria-describedby

Gate 3: Field Types Covered
[ ] Text inputs: labeled
[ ] Email inputs: labeled
[ ] Password inputs: labeled
[ ] Textareas: labeled
[ ] Selects: labeled
[ ] Checkboxes: labeled
[ ] Radio buttons: labeled
[ ] File uploads: labeled

Gate 4: Accessibility Audit
[ ] axe DevTools: 0 violations for labels
[ ] WCAG 1.3.1: PASS
[ ] WCAG 3.3.2: PASS
[ ] Screen reader test: Labels announced
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

FORMS TO TEST:
[ ] Contact form
[ ] Newsletter signup
[ ] Product search filter
[ ] Checkout form (if applicable)
[ ] Login form (if applicable)
[ ] Account form (if applicable)

LABEL ASSOCIATION:
[ ] Every input has matching label
[ ] Label for="inputId" matches input id="inputId"
[ ] No inputs without labels
[ ] No orphaned labels

SCREEN READER TEST:
[ ] NVDA reads: "Form field name, required, text input" (example)
[ ] JAWS announces: Label and field type
[ ] Mobile screen reader: Label pronounced
[ ] Field purpose clear without HTML inspection

ACCESSIBILITY AUDIT:
[ ] axe DevTools: 0 form/label violations
[ ] Lighthouse: 0 form label issues
[ ] WCAG 1.3.1 passed
[ ] WCAG 3.3.2 passed

FORM FUNCTIONALITY:
[ ] Form submits correctly
[ ] Error messages display
[ ] Error messages linked to fields
[ ] Form validation works
[ ] No JavaScript errors

VISUAL:
[ ] Forms appear unchanged
[ ] Labels position correct
[ ] No layout shifts
[ ] No broken form display
```

**Rollback Plan:**

```
IF LABEL CHANGES BREAK FORMS:

1. Immediate Rollback:
   [ ] Revert form template files
   [ ] Restore original HTML
   [ ] Re-deploy
   [ ] Verify forms work

2. Partial Rollback:
   [ ] Revert one form at a time if needed
   [ ] Fix issues in staging
   [ ] Re-deploy fixed version
```

**Implementation Notes:**
- **Files:** All form templates (search, checkout, contact, etc.)
- **No JavaScript changes**
- **Visual impact:** Minimal (labels already visible usually)
- **Improves form accessibility significantly**

---

## PHASE 1 COMPLETION GATE

**Criteria to Proceed to Phase 2:**

- [ ] All 6 stories DONE (merged to main)
- [ ] WCAG AA compliance verified: 0 critical/major violations
- [ ] Test coverage >= 60%
- [ ] Lighthouse score >= 75
- [ ] All staging validations passed
- [ ] Team sign-off obtained
- [ ] Stakeholder approval to proceed

**Timeline: Weeks 1-2 Complete (April 4)**

---

## PHASE 2: ARCHITECTURE & FOUNDATION (Weeks 3-5)

**Goals:** Design system + Build pipeline + CI/CD
**Stories:** 6
**Effort:** 102-154 hours
**Phase Gate:** Storybook live + CI/CD passing + 80% JS coverage

### Sprint 2.1 (Week 3: Apr 7-11)

---

#### Story TDB-2026-001.2.1: Design System Foundation

**Epic:** TDB-2026-001
**Severity:** HIGH
**Priority:** P1 (Enables design consistency)
**Effort:** 5-8 hours
**Owner:** [dev name TBD]
**Component:** Design system + Documentation

**User Story:**
```
As a designer and developer,
I want a documented design system with color palette, typography, spacing, and component patterns,
So that the team can build consistent interfaces and maintain the brand identity.
```

**Acceptance Criteria:**
- [ ] Design system documentation created: `docs/design-system/index.md`
- [ ] Color palette documented: primary, secondary, neutral, status colors
- [ ] Typography system documented: 8+ sizes, weights, line heights
- [ ] Spacing scale documented: 4px baseline with scale
- [ ] Component patterns defined: buttons, cards, forms, navigation
- [ ] Design tokens exported as JSON: `docs/design-system/tokens.json`
- [ ] Brand guidelines documented: logo, typography, color usage rules
- [ ] Figma design file linked (or design specs provided)
- [ ] 5-10 design system examples with code

**Definition of Done (AIOX):**
- [ ] Design system documentation complete
- [ ] Design tokens file created
- [ ] Brand guidelines documented
- [ ] Team can reference and implement from design system
- [ ] Ready for Storybook integration

**Dependencies:**
- Depends on: TDB-2026-001.1.5 (CSS Variables)

**Blockers:**
- CSS Variables must be complete

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (documentation only, infrastructure)
- **Breaking Change:** ❌ NO (new documentation)
- **Live Store Impact:** ✅ ZERO (development-only)
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** N/A (not deployed)
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Documentation Completeness
[ ] Design system index.md created
[ ] Color palette documented with hex values
[ ] Typography system documented
[ ] Spacing scale documented
[ ] Component patterns defined

Gate 2: Design Tokens
[ ] tokens.json created with valid JSON
[ ] All colors in tokens.json
[ ] All spacing values in tokens
[ ] All typography settings in tokens
[ ] File can be imported into build process

Gate 3: Brand Guidelines
[ ] Logo usage documented
[ ] Typography rules documented
[ ] Color combination rules documented
[ ] Examples provided with screenshots
[ ] Do's and don'ts included

Gate 4: Team Review
[ ] Design/Brand owner reviewed
[ ] Approved for implementation
[ ] Ready for Storybook integration
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

DOCUMENTATION STRUCTURE:
[ ] docs/design-system/index.md created
[ ] docs/design-system/colors.md created
[ ] docs/design-system/typography.md created
[ ] docs/design-system/spacing.md created
[ ] docs/design-system/components.md created
[ ] docs/design-system/brand-guidelines.md created

DESIGN TOKENS FILE:
[ ] docs/design-system/tokens.json exists
[ ] Valid JSON syntax
[ ] All colors included
[ ] All spacing values included
[ ] All typography settings included
[ ] Can be imported by build tools

COLOR PALETTE:
[ ] Primary color: #FF6B35 (and variations: -light, -dark)
[ ] Secondary colors: (defined)
[ ] Neutral grays: (8+ shades)
[ ] Status colors: success, error, warning, info
[ ] Accessibility: Contrast ratios verified

TYPOGRAPHY:
[ ] Font family specified
[ ] 8+ font sizes documented
[ ] Font weights documented: 400, 500, 600, 700
[ ] Line heights documented
[ ] Letter spacing documented
[ ] Usage examples provided

SPACING SCALE:
[ ] 4px, 8px, 12px, 16px, 20px, 24px, 32px, 48px, 64px
[ ] Base unit: 4px
[ ] Usage examples in components

COMPONENTS DOCUMENTED:
[ ] Button component: spec, states, usage
[ ] Card component: spec, usage
[ ] Form field component: spec, usage
[ ] Navigation: spec, usage
[ ] Others: (list)

BRAND GUIDELINES:
[ ] Logo: usage rules, spacing, sizes
[ ] Typography: hierarchy, pairing, usage
[ ] Color: palette rules, contrast, combinations
[ ] Imagery: style guidelines
[ ] Voice & tone: (if applicable)

TEAM REVIEW:
[ ] Design lead reviewed: YES / NO
[ ] Brand owner approved: YES / NO
[ ] Design consistency verified: YES / NO
[ ] Ready for Storybook: YES / NO
```

**Rollback Plan:**

```
IF DESIGN SYSTEM DOCUMENTATION HAS ISSUES:

1. Update Documentation:
   [ ] Identify issues
   [ ] Update docs/design-system/ files
   [ ] Re-review with stakeholders
   [ ] Get approval

2. No Rollback Needed:
   [ ] This is documentation-only
   [ ] Can iterate without impact
   [ ] No production changes
```

**Implementation Notes:**
- **Output:** Documentation + design tokens JSON
- **No code deployment**
- **Foundational for future design system work**

---

#### Story TDB-2026-001.2.2: Component Library - Storybook MVP

**Epic:** TDB-2026-001
**Severity:** HIGH
**Priority:** P1 (Design system reference)
**Effort:** 8-12 hours
**Owner:** [dev name TBD]
**Component:** Design system + Storybook

**User Story:**
```
As a developer and designer,
I want a Storybook instance showing 15+ components with interactive examples,
So that I can see component variants, test accessibility, and validate implementation.
```

**Acceptance Criteria:**
- [ ] Storybook installed and configured: `npm install --save-dev @storybook/html`
- [ ] 15+ components documented in Storybook
- [ ] Components include: Button, Card, Input, Select, Form, Navigation, etc.
- [ ] Each component shows: states (default, hover, active, disabled, error)
- [ ] Accessibility panel shows a11y status for each component
- [ ] Design tokens integrated into Storybook
- [ ] Storybook deployed to live URL (staging or netlify)
- [ ] Team can access and use Storybook for reference

**Definition of Done (AIOX):**
- [ ] Storybook running locally and in CI/CD
- [ ] 15+ components documented
- [ ] Accessibility panel shows component issues
- [ ] Live Storybook URL accessible to team
- [ ] Ready for Phase 2 reference

**Dependencies:**
- Depends on: TDB-2026-001.2.1 (Design System Foundation)

**Blockers:**
- Design system must be documented first

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (development tool, not deployed to store)
- **Breaking Change:** ❌ NO (development infrastructure)
- **Live Store Impact:** ✅ ZERO
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** N/A (not deployed)
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Storybook Setup
[ ] Storybook installed via npm
[ ] Storybook config created (.storybook/main.js)
[ ] npm run storybook starts local instance
[ ] Storybook accessible at localhost:6006

Gate 2: Component Documentation
[ ] 15+ components have stories
[ ] Each story shows default state
[ ] Each story shows variants (disabled, error, etc.)
[ ] Stories have clear descriptions
[ ] Stories show code examples

Gate 3: Accessibility
[ ] Accessibility addon installed
[ ] Accessibility panel shows for each component
[ ] No critical a11y issues in components
[ ] Components pass initial audit

Gate 4: Design Tokens Integration
[ ] Design tokens available in Storybook
[ ] Colors from tokens displayed
[ ] Spacing from tokens used
[ ] Components use token values

Gate 5: Deployment
[ ] Storybook builds successfully
[ ] Deployed to live URL
[ ] Team can access (no auth required or documented)
[ ] Mobile responsive
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

STORYBOOK SETUP:
[ ] npm run storybook starts successfully
[ ] Storybook loads without errors
[ ] Sidebar navigation working
[ ] Component list populated

COMPONENTS DOCUMENTED (15+):
[ ] Button component story created
[ ] Card component story created
[ ] Input component story created
[ ] Select component story created
[ ] Form component story created
[ ] Navigation component story created
[ ] Badge component story created
[ ] Alert component story created
[ ] Modal component story created
[ ] Dropdown component story created
[ ] Pagination component story created
[ ] Avatar component story created
[ ] Spinner/Loader component story created
[ ] Tooltip component story created
[ ] Breadcrumb component story created

COMPONENT VARIANTS:
[ ] Button story: default, primary, secondary, small, large, disabled
[ ] Input story: default, disabled, error, success, focus
[ ] Card story: default, hover, with image, minimal
[ ] Form story: all field types, validation states

ACCESSIBILITY PANEL:
[ ] Accessibility addon showing
[ ] Components pass initial audit
[ ] Color contrast verified
[ ] Focus states visible
[ ] ARIA labels checked

DESIGN TOKENS:
[ ] Colors from tokens.json displayed
[ ] Spacing values from tokens used
[ ] Typography from tokens applied
[ ] Tokens easily searchable in Storybook

LIVE DEPLOYMENT:
[ ] Storybook deployed to live URL
[ ] URL accessible to team
[ ] Mobile responsive
[ ] All components visible on mobile
[ ] Search working

DOCUMENTATION:
[ ] Each component has description
[ ] Code examples visible
[ ] Props documented (if React components)
[ ] Usage guidelines provided
[ ] Accessibility notes included

TEAM TESTING:
[ ] Dev A can navigate Storybook
[ ] Dev B can find components
[ ] QA can use Storybook for testing
[ ] Designer can use for reference
```

**Rollback Plan:**

```
IF STORYBOOK BREAKS:

1. Rollback to Previous Version:
   [ ] Revert Storybook config changes
   [ ] npm remove @storybook/* packages
   [ ] Restore node_modules
   [ ] Remove Storybook scripts from package.json

2. If Deployment Fails:
   [ ] Check build logs
   [ ] Fix configuration
   [ ] Rebuild locally first
   [ ] Test before re-deploying

3. Alternative: Use different Storybook version
   [ ] Downgrade @storybook packages
   [ ] Test compatibility
```

**Implementation Notes:**
- **Storybook:** Industry standard component library tool
- **No production deployment**
- **Development/design reference tool**
- **Live Storybook URL for team access**

---

#### Story TDB-2026-001.2.3: Local Build Pipeline (Webpack/Vite)

**Epic:** TDB-2026-001
**Severity:** HIGH
**Priority:** P1 (Development workflow)
**Effort:** 6-10 hours
**Owner:** [dev name TBD]
**Component:** Build infrastructure

**User Story:**
```
As a developer,
I want a local build pipeline that bundles CSS and JavaScript,
So that I can develop efficiently and test builds before deploying to production.
```

**Acceptance Criteria:**
- [ ] Build tool configured (Webpack or Vite)
- [ ] `npm run build` creates optimized bundle
- [ ] CSS processed with PostCSS/autoprefixer
- [ ] JavaScript minified and tree-shaken
- [ ] Source maps generated for debugging
- [ ] Build completes in < 5 seconds
- [ ] Output size: CSS < 50KB, JS < 100KB (gzipped)
- [ ] No build warnings (0 warnings)

**Definition of Done (AIOX):**
- [ ] Build pipeline working locally
- [ ] Team can run `npm run build`
- [ ] Build artifacts optimized
- [ ] Documentation: `docs/BUILD.md` created
- [ ] Ready for CI/CD integration

**Dependencies:**
- Depends on: TDB-2026-001.1.5 (CSS Variables)

**Blockers:**
- CSS Variables must be complete

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (local development only)
- **Breaking Change:** ❌ NO (development infrastructure)
- **Live Store Impact:** ✅ ZERO
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** N/A (not deployed to production)
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Build Configuration
[ ] webpack.config.js or vite.config.js created
[ ] Build scripts in package.json
[ ] npm run build executes without errors
[ ] Build completes in < 5 seconds

Gate 2: Output Optimization
[ ] CSS minified (< 50KB gzipped)
[ ] JavaScript minified (< 100KB gzipped)
[ ] Source maps generated
[ ] No dead code (tree-shaken)
[ ] Bundle analysis available

Gate 3: CSS Processing
[ ] PostCSS configured
[ ] Autoprefixer applies vendor prefixes
[ ] CSS custom properties processed
[ ] CSS variables working in output

Gate 4: JavaScript Processing
[ ] ES6 transpiled to ES5 (if needed)
[ ] Modules bundled correctly
[ ] No missing imports
[ ] No circular dependencies

Gate 5: Development Workflow
[ ] npm run dev works locally
[ ] Hot reload/refresh available (if applicable)
[ ] Source maps work in browser DevTools
[ ] File watching enabled
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

BUILD EXECUTION:
[ ] npm run build executes successfully
[ ] No errors in console
[ ] No warnings in console
[ ] Build completes in < 5 seconds

OUTPUT FILES:
[ ] theme/dist/styles.min.css created
[ ] theme/dist/bundle.min.js created
[ ] Source maps created (.css.map, .js.map)
[ ] Output directory clean (no old files)

FILE SIZE VERIFICATION:
[ ] CSS size: < 50KB gzipped (measure with gzip -c)
[ ] JavaScript size: < 100KB gzipped
[ ] No size regression from baseline
[ ] Minification working (compare to source)

CSS PROCESSING:
[ ] PostCSS rules applied
[ ] Autoprefixer: vendor prefixes added
[ ] CSS Variables processed
[ ] No CSS syntax errors
[ ] Media queries working

JAVASCRIPT PROCESSING:
[ ] Modules bundled (verify with imports)
[ ] No broken imports
[ ] Tree-shaking: unused code removed
[ ] Minification: variable names shortened
[ ] No console.logs in production build

DEV WORKFLOW:
[ ] npm run dev starts dev server
[ ] Changes auto-refresh (if hot reload)
[ ] Source maps work in DevTools
[ ] File watcher detects changes
[ ] Build fast for iteration

VERIFICATION:
[ ] Deploy output to staging
[ ] Test functionality in staging
[ ] No broken functionality
[ ] All CSS/JS working as expected
```

**Rollback Plan:**

```
IF BUILD BREAKS:

1. Revert Configuration:
   [ ] Revert webpack/vite config
   [ ] Restore previous build settings
   [ ] Delete node_modules (if needed)
   [ ] npm install
   [ ] npm run build (should work)

2. If Specific Module Fails:
   [ ] Identify failing module
   [ ] Check imports
   [ ] Check for circular dependencies
   [ ] Fix in source
   [ ] Rebuild

3. Alternative Build Tool:
   [ ] If Webpack broken, try Vite
   [ ] Migrate config if needed
   [ ] Test thoroughly before proceeding
```

**Implementation Notes:**
- **Config:** Webpack or Vite (both work, Vite faster)
- **Output:** Optimized CSS and JS files
- **Development tool:** Speeds up iteration
- **No production impact** (local build only)

---

### Sprint 2.2 (Week 4: Apr 14-18)

---

#### Story TDB-2026-001.2.4: GitHub CI/CD Pipeline

**Epic:** TDB-2026-001
**Severity:** HIGH
**Priority:** P1 (Quality assurance automation)
**Effort:** 5-8 hours
**Owner:** [dev name TBD]
**Component:** CI/CD infrastructure

**User Story:**
```
As a developer,
I want automated CI/CD checks on every pull request,
So that code quality issues are caught before merging to main.
```

**Acceptance Criteria:**
- [ ] GitHub Actions workflow created: `.github/workflows/ci.yml`
- [ ] Workflow runs on every PR and push to main
- [ ] Lint check: `npm run lint` - must pass
- [ ] Type check: `npm run typecheck` - must pass (if applicable)
- [ ] Build check: `npm run build` - must pass
- [ ] Test check: `npm test` - must pass with 60%+ coverage
- [ ] Security scan: Dependency vulnerability check
- [ ] PR status checks require all to pass before merge
- [ ] Branch rules enforced: require PR review + status checks

**Definition of Done (AIOX):**
- [ ] CI/CD workflow operational on all PRs
- [ ] All checks passing on main branch
- [ ] Team can see check status in PRs
- [ ] Failed checks block merge
- [ ] Ready for team use

**Dependencies:**
- Depends on: TDB-2026-001.1.3 (Jest Testing)
- Depends on: TDB-2026-001.2.3 (Build Pipeline)

**Blockers:**
- Testing and build must be working first

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (GitHub infrastructure)
- **Breaking Change:** ❌ NO (development automation)
- **Live Store Impact:** ✅ ZERO
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** N/A (development tool)
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Workflow Configuration
[ ] .github/workflows/ci.yml created
[ ] Workflow triggers on: push to main, pull_request
[ ] Valid GitHub Actions YAML syntax
[ ] Workflow shows in "Actions" tab

Gate 2: Job Execution
[ ] Checkout code: PASS
[ ] Install dependencies: PASS
[ ] Lint check: PASS
[ ] Build check: PASS
[ ] Test check: PASS
[ ] All jobs complete in < 5 minutes

Gate 3: PR Status Checks
[ ] PR shows CI checks status
[ ] Failed check blocks merge (if branch rule set)
[ ] Check details visible (can click to see logs)
[ ] Passing check enables "Merge" button

Gate 4: Branch Rules
[ ] require-status-checks enabled
[ ] All required checks listed
[ ] Require PR review enabled (2 approvals)
[ ] Dismiss stale reviews enabled
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

WORKFLOW FILE:
[ ] .github/workflows/ci.yml exists
[ ] Syntax valid (no YAML errors)
[ ] Triggers configured correctly
[ ] Steps clearly defined

WORKFLOW EXECUTION:
[ ] Create test PR
[ ] Workflow runs automatically
[ ] All jobs complete
[ ] View logs without errors

INDIVIDUAL CHECKS:

Checkout & Install:
[ ] Code checked out correctly
[ ] npm install completes successfully
[ ] node_modules populated

Lint Check:
[ ] npm run lint executes
[ ] No linting errors
[ ] Check shows PASS
[ ] Time: < 30 seconds

Build Check:
[ ] npm run build executes
[ ] Build succeeds
[ ] Check shows PASS
[ ] Time: < 60 seconds

Test Check:
[ ] npm test executes
[ ] Tests pass (60%+ coverage)
[ ] Check shows PASS
[ ] Coverage report generated
[ ] Time: < 45 seconds

Security Check:
[ ] Dependency vulnerability scan runs
[ ] No critical vulnerabilities
[ ] Check shows PASS (or warn with no blockers)

PR STATUS:
[ ] PR shows all checks
[ ] Passed checks have green checkmark
[ ] Failed checks have red X
[ ] Details link works
[ ] Can view logs

BRANCH PROTECTION:
[ ] Merge button disabled if checks fail
[ ] Merge button enabled if checks pass
[ ] Required reviewers: enforce
[ ] Status checks required before merge

FULL WORKFLOW TEST:
[ ] Create PR with intentional lint error
[ ] Lint check fails
[ ] Merge button disabled
[ ] Fix lint error
[ ] Push new commit
[ ] Lint check passes
[ ] Can merge (if reviews approved)
```

**Rollback Plan:**

```
IF CI/CD BREAKS:

1. Disable Workflow Temporarily:
   [ ] Comment out workflow file or delete it
   [ ] Remove from .github/workflows/
   [ ] Commits no longer checked
   [ ] Restore when fixed

2. Fix Workflow Issues:
   [ ] View workflow logs in Actions tab
   [ ] Identify failing step
   [ ] Fix configuration
   [ ] Test in staging branch
   [ ] Commit fix to main
   [ ] Re-enable workflow

3. If Build/Tests Failing:
   [ ] Fix source code, not workflow
   [ ] Workflow correctly failing (that's the point)
   [ ] Merge fix, then workflow passes
```

**Implementation Notes:**
- **File:** `.github/workflows/ci.yml`
- **Jobs:** lint, typecheck, build, test, security
- **Matrix:** Can run on multiple node versions
- **Time:** Typically 5-10 minutes per PR

---

#### Story TDB-2026-001.2.5: JavaScript Testing (Jest/Cypress)

**Epic:** TDB-2026-001
**Severity:** HIGH
**Priority:** P1 (Quality assurance)
**Effort:** 6-10 hours
**Owner:** [dev name TBD]
**Component:** Testing infrastructure + JavaScript

**User Story:**
```
As a developer,
I want Jest unit tests and Cypress e2e tests for JavaScript functionality,
So that I can validate behavior changes and catch regressions early.
```

**Acceptance Criteria:**
- [ ] Jest configured for unit tests (already done in 1.3)
- [ ] Cypress installed for E2E testing: `npm install --save-dev cypress`
- [ ] 10+ unit tests for utilities and components
- [ ] 5+ E2E tests for critical user flows
- [ ] Test coverage: 70%+ for Phase 2
- [ ] All tests pass locally and in CI/CD
- [ ] Test documentation: `docs/TESTING.md` updated
- [ ] Team trained on writing tests

**Definition of Done (AIOX):**
- [ ] Jest + Cypress working
- [ ] Baseline test coverage: 70%
- [ ] CI/CD running tests
- [ ] Team can write new tests
- [ ] Ready for Phase 3

**Dependencies:**
- Depends on: TDB-2026-001.1.3 (Jest Setup)
- Depends on: TDB-2026-001.2.3 (Build Pipeline)
- Depends on: TDB-2026-001.2.4 (CI/CD)

**Blockers:**
- Jest and CI/CD must be working

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (development testing only)
- **Breaking Change:** ❌ NO (no production changes)
- **Live Store Impact:** ✅ ZERO
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** N/A
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Jest Unit Tests
[ ] 10+ test files created
[ ] Tests for: utilities, helpers, components
[ ] All tests passing locally
[ ] Coverage report generated (70%+)
[ ] npm test runs in < 30 seconds

Gate 2: Cypress E2E Tests
[ ] Cypress installed and configured
[ ] cypress.config.js created
[ ] 5+ E2E test spec files
[ ] Tests for: homepage, product page, cart, checkout
[ ] Tests pass locally
[ ] Cypress headless mode works

Gate 3: CI/CD Integration
[ ] Jest runs in GitHub Actions
[ ] Coverage reports published
[ ] Cypress runs in CI/CD (headless)
[ ] Tests pass on every PR

Gate 4: Test Quality
[ ] Tests have clear descriptions
[ ] Each test is independent (no shared state)
[ ] Tests use proper assertions
[ ] No flaky tests (all deterministic)
[ ] Good coverage of critical paths
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

JEST UNIT TESTS:

Test Files:
[ ] tests/utils/ - utility functions
[ ] tests/components/ - component tests
[ ] tests/helpers/ - helper functions
[ ] 10+ test files total

Test Coverage:
[ ] Statements: >= 70%
[ ] Branches: >= 60%
[ ] Functions: >= 70%
[ ] Lines: >= 70%
[ ] Key files: > 80% coverage

Test Execution:
[ ] npm test runs all tests
[ ] All tests pass locally
[ ] No timeout errors
[ ] < 30 seconds total time

CYPRESS E2E TESTS:

Test Specs:
[ ] cypress/e2e/homepage.cy.js
[ ] cypress/e2e/product.cy.js
[ ] cypress/e2e/cart.cy.js
[ ] cypress/e2e/checkout.cy.js
[ ] Other: (list)

Test Cases:
Homepage:
[ ] Page loads successfully
[ ] Navigation menu functional
[ ] Search bar functional
[ ] Product grid displays

Product Page:
[ ] Product details load
[ ] Images display
[ ] Add to cart button works
[ ] Related products show

Cart:
[ ] Add item works
[ ] Remove item works
[ ] Quantity update works
[ ] Total price calculated

Checkout:
[ ] Form fields functional
[ ] Submit button works
[ ] Validation messages appear
[ ] Order confirmation shows

Test Execution:
[ ] npm run cypress:open - interactive mode
[ ] npm run cypress:run - headless mode
[ ] All tests pass in headless
[ ] Tests run in CI/CD successfully

CI/CD INTEGRATION:
[ ] Jest runs on every PR
[ ] Cypress runs on every PR
[ ] Coverage reports visible
[ ] Failed tests block merge
[ ] All tests < 5 min total

TEAM TESTING:
[ ] Dev A runs tests locally: PASS
[ ] Dev B runs tests locally: PASS
[ ] Both can write new tests
[ ] QA can run and understand tests
```

**Rollback Plan:**

```
IF TESTS BREAK:

1. Fix Tests (not code):
   [ ] Identify failing test
   [ ] Understand why it fails
   [ ] Update test to match current behavior (if intentional)
   [ ] Re-run test
   [ ] Commit fix

2. If Test Framework Breaks:
   [ ] Revert Jest/Cypress config
   [ ] Reinstall dependencies
   [ ] Run tests again
   [ ] Fix configuration

3. If Tests Are Failing Due to Real Bug:
   [ ] That's good! Tests caught the bug
   [ ] Fix the bug in source code
   [ ] Re-run tests
   [ ] Tests should pass
```

**Implementation Notes:**
- **Jest:** Unit testing framework
- **Cypress:** End-to-end testing framework
- **No production impact:** Development testing only
- **Improves code quality and regression detection**

---

#### Story TDB-2026-001.2.6: GitHub Integration & Branch Rules

**Epic:** TDB-2026-001
**Severity:** MEDIUM
**Priority:** P2 (Development workflow)
**Effort:** 2-3 hours
**Owner:** [dev name TBD]
**Component:** Git + GitHub

**User Story:**
```
As a team lead,
I want GitHub branch rules and team permissions configured,
So that the team follows a consistent development workflow and code quality standards.
```

**Acceptance Criteria:**
- [ ] `main` branch protected: require PR review + status checks
- [ ] Require 2 approvals before merge (configurable)
- [ ] Dismiss stale reviews: enabled
- [ ] Require branches up-to-date before merge
- [ ] Require status checks to pass
- [ ] Allow force pushes: disabled
- [ ] Allow deletions: disabled
- [ ] Require branches behind main to be updated
- [ ] Team permissions configured: write access for team, read for others

**Definition of Done (AIOX):**
- [ ] Branch rules enforced on main
- [ ] Team following workflow
- [ ] No direct commits to main (all via PR)
- [ ] Ready for team use

**Dependencies:**
- Depends on: TDB-2026-001.2.4 (CI/CD Pipeline)

**Blockers:**
- CI/CD must be working for status checks

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (GitHub configuration)
- **Breaking Change:** ❌ NO
- **Live Store Impact:** ✅ ZERO
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** N/A
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Branch Protection Rules
[ ] Settings > Branches > main
[ ] "Require a pull request before merging" - enabled
[ ] "Require approvals" - 2 approvals
[ ] "Require status checks to pass" - enabled
[ ] "Require branches to be up to date" - enabled
[ ] "Restrict who can push to matching branches" - disabled (allow devs)

Gate 2: Workflow Enforcement
[ ] Attempt direct commit to main - should fail
[ ] Create PR → wait for checks → approve → merge → success
[ ] Force push disabled
[ ] Branch deletion disabled

Gate 3: Team Permissions
[ ] Team members: "write" access
[ ] Others: "read" access (if applicable)
[ ] Admin: leadership only
[ ] Org settings reviewed
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

BRANCH PROTECTION:
[ ] Navigate to repo > Settings > Branches
[ ] "main" branch rule exists
[ ] Rule section shows all required settings

REQUIRE PR:
[ ] "Require a pull request before merging" - CHECKED
[ ] "Require approvals" - 2
[ ] "Require code owner review" - CHECKED (if using CODEOWNERS)

REQUIRE STATUS CHECKS:
[ ] "Require status checks to pass before merging" - CHECKED
[ ] All CI checks listed (lint, build, test)
[ ] "Require branches to be up to date" - CHECKED

RESTRICTIONS:
[ ] "Allow force pushes" - UNCHECKED
[ ] "Allow deletions" - UNCHECKED
[ ] Enforce for administrators - UNCHECKED (admins can override if needed)

TEAM PERMISSIONS:
[ ] Organization members listed
[ ] Patagang Devs team: Write access
[ ] Others: Read access
[ ] No public push allowed

WORKFLOW TEST:
Create PR Test:
[ ] Create feature branch from main
[ ] Make code changes
[ ] Push to GitHub
[ ] GitHub auto-creates PR draft
[ ] Open PR
[ ] CI checks run automatically
[ ] Can't merge until checks pass

Approval Workflow:
[ ] PR submitted
[ ] Team member reviews
[ ] Team member approves
[ ] Another team member approves
[ ] CI all green
[ ] Click "Merge pull request"
[ ] Merge succeeds
[ ] PR auto-closes

Direct Commit Test:
[ ] Attempt: git push origin main (change)
[ ] Should fail with: "protected branch"
[ ] Can only push via PR → approve → merge

DOCUMENTATION:
[ ] Team trained on PR workflow
[ ] Branching strategy documented
[ ] Commit message convention documented
```

**Rollback Plan:**

```
IF BRANCH RULES CAUSE ISSUES:

1. Adjust Rules:
   [ ] Lower approval requirement: 2 → 1 (if needed)
   [ ] Disable status check requirement temporarily
   [ ] Make changes in Settings > Branches

2. Emergency Override:
   [ ] Repo admin can push --force if truly needed
   [ ] Document why override needed
   [ ] Re-establish rules afterward

3. No Code Rollback Needed:
   [ ] GitHub settings only
   [ ] Can adjust anytime
```

**Implementation Notes:**
- **Configuration:** GitHub Settings (web UI)
- **No code changes**
- **Enforces quality workflow**
- **Requires team discipline**

---

## PHASE 2 COMPLETION GATE

**Criteria to Proceed to Phase 3:**

- [ ] All 6 stories DONE (merged to main)
- [ ] Storybook live with 15+ components
- [ ] CI/CD pipeline passing all PRs
- [ ] 70%+ test coverage on Phase 2 work
- [ ] Build pipeline working (npm run build < 5s)
- [ ] Team trained on new tools
- [ ] Stakeholder approval to proceed

**Timeline: Weeks 3-5 Complete (April 18)**

---

## PHASE 3: PERFORMANCE & OPTIMIZATION (Weeks 6-7)

**Goals:** Lighthouse 85+ + Image optimization
**Stories:** 3
**Effort:** 28-40 hours
**Phase Gate:** Lighthouse 85+ on mobile

### Sprint 3.1 (Week 6: Apr 21-25)

---

#### Story TDB-2026-001.3.1: Image Optimization (WebP)

**Epic:** TDB-2026-001
**Severity:** HIGH
**Priority:** P1 (Lighthouse Performance)
**Effort:** 5-8 hours
**Owner:** [dev name TBD]
**Component:** Performance + Images

**User Story:**
```
As a user on a slow connection,
I want images to load quickly with modern compression,
So that the website loads faster and uses less data.
```

**Acceptance Criteria:**
- [ ] All product images converted to WebP format
- [ ] JPEG/PNG fallbacks maintained for browsers without WebP support
- [ ] `<picture>` elements used for responsive images
- [ ] Images serve appropriate size for viewport (srcset)
- [ ] Lazy loading implemented: `loading="lazy"`
- [ ] Image optimization: 50%+ file size reduction
- [ ] Lighthouse performance score: 80+
- [ ] LCP (Largest Contentful Paint): < 2.5s

**Definition of Done (AIOX):**
- [ ] All images optimized
- [ ] WebP + JPEG fallback working
- [ ] Lazy loading functional
- [ ] Performance metrics improved
- [ ] Ready for Lighthouse audit

**Dependencies:**
- Depends on: TDB-2026-001.1.2 (CSS Caching)
- Depends on: TDB-2026-001.1.5 (CSS Variables)

**Blockers:**
- Image optimization tools needed

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (static image files)
- **Breaking Change:** ❌ NO (fallbacks ensure compatibility)
- **Live Store Impact:** ✅ POSITIVE (faster load = better UX)
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** ⭐ LOW (revert images, use originals)
- **Risk Level:** LOW

**Validation Gates (Pre-Deploy):**

```
Gate 1: WebP Conversion
[ ] Product images converted to WebP
[ ] File size: 50%+ smaller than original
[ ] Quality: visually identical to original
[ ] All product images covered

Gate 2: Fallback Setup
[ ] <picture> elements with <source> tags
[ ] WebP source first (modern browsers)
[ ] JPEG/PNG fallback second (older browsers)
[ ] Both formats work
[ ] No broken images

Gate 3: Responsive Images
[ ] srcset attributes configured
[ ] Multiple sizes: mobile (small), tablet (medium), desktop (large)
[ ] Browser selects appropriate size
[ ] Correct images load per viewport

Gate 4: Lazy Loading
[ ] loading="lazy" attribute present
[ ] Images load only when near viewport
[ ] Scroll to product: image loads
[ ] No layout shift (CLS < 0.1)

Gate 5: Performance Metrics
[ ] Lighthouse Performance: >= 80
[ ] LCP: < 2.5 seconds
[ ] FCP: < 1.5 seconds
[ ] Cumulative Layout Shift: < 0.1
[ ] Image size: 50%+ reduction verified
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

IMAGE OPTIMIZATION:
[ ] Product listing images: WebP + JPEG
[ ] Product detail images: WebP + JPEG
[ ] Category images: WebP + JPEG
[ ] Homepage images: WebP + JPEG

FILE SIZE VERIFICATION:
Original sizes vs optimized:
[ ] JPEGs: 50%+ smaller in WebP
[ ] PNGs: 30-40% smaller in WebP
[ ] Total image payload reduced
[ ] Measure: DevTools Network tab

BROWSER COMPATIBILITY TEST:
Chrome:
[ ] Product page loads
[ ] WebP images loading
[ ] All images visible

Firefox:
[ ] Product page loads
[ ] JPEG fallbacks loading
[ ] All images visible

Safari:
[ ] Images load (has WebP support)
[ ] No broken images
[ ] Fast load

IE 11 (if needed):
[ ] JPEG fallbacks loading
[ ] No broken images
[ ] Graceful degradation

RESPONSIVE IMAGE TEST:
Mobile (320px):
[ ] Small images loading
[ ] Appropriate size for screen
[ ] No oversized images wasting data

Tablet (768px):
[ ] Medium images loading
[ ] Correct srcset value used
[ ] Visible and crisp

Desktop (1920px):
[ ] Large images loading
[ ] High quality
[ ] Full resolution

LAZY LOADING TEST:
[ ] Homepage: Above fold images load immediately
[ ] Below fold images: not loaded until scroll
[ ] Scroll down: images load on demand
[ ] No loading delay visible
[ ] Smooth scroll experience

PERFORMANCE AUDIT:
Lighthouse:
[ ] Run audit on product page
[ ] Performance score: >= 80
[ ] FCP: < 1.5s
[ ] LCP: < 2.5s
[ ] CLS: < 0.1
[ ] TBT: < 50ms

Network Simulation:
[ ] 4G: page loads in < 3s
[ ] 3G: page loads in < 5s
[ ] 2G: page loads (acceptably slow)
[ ] Slow network visible in DevTools

VISUAL CHECK:
[ ] All images visible
[ ] No stretched/distorted images
[ ] Colors accurate
[ ] No pixelation (except intentional low-res)
[ ] Layout correct

MOBILE TESTING:
[ ] iPhone: images load and display correctly
[ ] Android: images load and display correctly
[ ] Slow 3G: lazy load visible, images load when needed
[ ] Offline (after cache): images show from cache
```

**Rollback Plan:**

```
IF IMAGE OPTIMIZATION CAUSES ISSUES:

1. Broken WebP Serving:
   [ ] Verify MIME type configuration
   [ ] Check web server config for .webp type
   [ ] Fallback to JPEG if needed
   [ ] Re-test

2. Lazy Loading Issues:
   [ ] Some images not loading: remove loading="lazy" from specific images
   [ ] Replace with eager loading if critical
   [ ] Test with polyfill for older browsers

3. Responsive Image Issues:
   [ ] Image size not switching: check srcset syntax
   [ ] Fix breakpoints
   [ ] Re-test across devices

4. Full Rollback:
   [ ] Restore original image files
   [ ] Remove <picture> elements
   [ ] Use original <img> tags
   [ ] Remove loading="lazy"
   [ ] Re-deploy
   [ ] Performance returns to baseline
```

**Implementation Notes:**
- **Tools:** ImageMagick or ffmpeg for WebP conversion
- **Picture element:** HTML5 responsive images
- **Lazy loading:** Native browser support (Chrome 76+)
- **Fallbacks:** JPEG/PNG for compatibility
- **Expected result:** 50% file size reduction, Lighthouse +10 points

---

#### Story TDB-2026-001.3.2: Lighthouse Optimization & Performance

**Epic:** TDB-2026-001
**Severity:** HIGH
**Priority:** P1 (Lighthouse 85+ target)
**Effort:** 6-10 hours
**Owner:** [dev name TBD]
**Component:** Performance optimization

**User Story:**
```
As a user,
I want the website to load fast and be responsive,
So that I have a good browsing experience and complete purchases faster.
```

**Acceptance Criteria:**
- [ ] Lighthouse Performance score: 85+ (mobile)
- [ ] Lighthouse Accessibility score: 90+ (maintained)
- [ ] Lighthouse SEO score: 90+ (maintained)
- [ ] LCP (Largest Contentful Paint): < 2.5s
- [ ] FCP (First Contentful Paint): < 1.5s
- [ ] CLS (Cumulative Layout Shift): < 0.1
- [ ] TBT (Total Blocking Time): < 50ms
- [ ] First Input Delay: < 100ms

**Definition of Done (AIOX):**
- [ ] All performance metrics met
- [ ] Lighthouse 85+ achieved
- [ ] No regressions from previous phases
- [ ] Ready for Phase 4

**Dependencies:**
- Depends on: TDB-2026-001.3.1 (Image Optimization)
- Depends on: TDB-2026-001.2.3 (Build Pipeline)

**Blockers:**
- Image optimization must be complete

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (performance tuning)
- **Breaking Change:** ❌ NO (improves UX)
- **Live Store Impact:** ✅ POSITIVE (faster = better)
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** ⭐ TRIVIAL (revert optimizations)
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Performance Metrics
[ ] Lighthouse Performance: >= 85 (mobile)
[ ] Lighthouse Accessibility: >= 90
[ ] Lighthouse SEO: >= 90
[ ] All metrics measured on: moto g4 / 4G

Gate 2: Core Web Vitals
[ ] LCP: < 2.5s (Largest Contentful Paint)
[ ] FCP: < 1.5s (First Contentful Paint)
[ ] CLS: < 0.1 (Cumulative Layout Shift)
[ ] FID or INP: < 100ms (First Input Delay or Interaction to Next Paint)
[ ] TBT: < 50ms (Total Blocking Time)

Gate 3: No Regressions
[ ] Accessibility: still 90+
[ ] SEO: still 90+
[ ] Functionality: all features working
[ ] No new console errors

Gate 4: User Experience
[ ] Page loads fast (subjective, but measurable)
[ ] No janky animations
[ ] Buttons respond quickly
[ ] Forms feel snappy
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

LIGHTHOUSE AUDIT:

Run on Multiple Pages:
[ ] Homepage
[ ] Product listing page
[ ] Product detail page
[ ] Cart page (if applicable)
[ ] Checkout page (if applicable)

Performance Scores:
[ ] Homepage Performance: >= 85
[ ] Product listing: >= 85
[ ] Product detail: >= 85
[ ] Cart: >= 85
[ ] Checkout: >= 85

Accessibility Scores:
[ ] Homepage: >= 90
[ ] Product listing: >= 90
[ ] Product detail: >= 90
[ ] No regressions from Phase 1

SEO Scores:
[ ] Homepage: >= 90
[ ] All pages: >= 90
[ ] Mobile friendly: YES
[ ] Structured data: PASS

CORE WEB VITALS:

Largest Contentful Paint (LCP):
[ ] Homepage: < 2.5s
[ ] Product page: < 2.5s
[ ] Average: < 2.0s (good)

First Contentful Paint (FCP):
[ ] Homepage: < 1.5s
[ ] Product page: < 1.5s
[ ] Average: < 1.2s (good)

Cumulative Layout Shift (CLS):
[ ] Homepage: < 0.1
[ ] Product page: < 0.1
[ ] No visible jumping/shifting
[ ] Stable throughout load

First Input Delay (FID) or INP:
[ ] Homepage: < 100ms
[ ] Product page: < 100ms
[ ] All interactions responsive

Total Blocking Time (TBT):
[ ] Homepage: < 50ms
[ ] Product page: < 50ms
[ ] No long JavaScript tasks

OPTIMIZATION CHECKS:

Images:
[ ] Images optimized (WebP)
[ ] Lazy loading working
[ ] Responsive sizes
[ ] No unnecessary images

CSS:
[ ] CSS minified
[ ] Unused CSS removed
[ ] CSS delivery optimized
[ ] <80KB total

JavaScript:
[ ] JS minified
[ ] Tree-shaken (unused code removed)
[ ] No render-blocking JS
[ ] <100KB total

Fonts:
[ ] Font loading optimized
[ ] Font-display: swap (avoid FOIT)
[ ] Subset fonts (if custom)

Caching:
[ ] Browser caching configured
[ ] Service worker (if applicable)
[ ] CDN caching

NETWORK PERFORMANCE:

4G Network:
[ ] Homepage loads: < 3 seconds
[ ] Product page loads: < 4 seconds

3G Network:
[ ] Homepage loads: < 5 seconds
[ ] Product page loads: < 7 seconds

2G Network:
[ ] Homepage loads: < 10 seconds (acceptable)

DESKTOP TESTING:
[ ] Run Lighthouse on desktop
[ ] Performance: >= 90 (usually higher than mobile)
[ ] Verify no JavaScript errors

MOBILE TESTING:
[ ] Run on actual device
[ ] Moto G4 (if available) / mid-range Android
[ ] iPhone SE (if available) / mid-range iOS
[ ] Performance feels good
[ ] No lag or jank

REGRESSION TESTING:
[ ] Phase 1 features: still working
[ ] Phase 2 features: still working
[ ] No new console errors
[ ] No new accessibility issues
[ ] All tests still passing
```

**Rollback Plan:**

```
IF PERFORMANCE OPTIMIZATIONS BREAK FUNCTIONALITY:

1. Identify Issue:
   [ ] Run Lighthouse to see score details
   [ ] Check console for errors
   [ ] Identify which optimization caused issue

2. Rollback Specific Optimization:
   [ ] Remove the problematic change
   [ ] Keep other optimizations
   [ ] Re-test

3. Root Cause:
   [ ] Was a library not compatible?
   [ ] Was JavaScript incorrectly minified?
   [ ] Were CSS selectors broken by optimization?
   [ ] Fix root cause

4. Full Rollback (if needed):
   [ ] Revert all optimization changes
   [ ] Return to baseline performance
   [ ] Plan different optimization approach
```

**Implementation Notes:**
- **Tools:** Lighthouse, Chrome DevTools, WebPageTest
- **Profiling:** Chrome DevTools Performance tab
- **Common optimizations:**
  - CSS minification
  - JavaScript minification + tree-shaking
  - Font optimization
  - Image optimization (already done in 3.1)
  - Remove render-blocking resources
  - Optimize critical rendering path

---

#### Story TDB-2026-001.3.3: Template Deduplication

**Epic:** TDB-2026-001
**Severity:** MEDIUM
**Priority:** P2 (Code quality)
**Effort:** 3-5 hours
**Owner:** [dev name TBD]
**Component:** Frontend templates

**User Story:**
```
As a developer,
I want template files deduplicated so there's a single source of truth,
So that maintenance is easier and changes only need to be made once.
```

**Acceptance Criteria:**
- [ ] Identify duplicate template code blocks (>50 lines)
- [ ] Extract duplicates into reusable templates/components
- [ ] Reduce template file duplication by 30%+
- [ ] No visual regressions
- [ ] All pages render correctly
- [ ] Maintainability improved

**Definition of Done (AIOX):**
- [ ] Duplicate code removed
- [ ] Templates refactored
- [ ] No regressions
- [ ] Documentation updated
- [ ] Ready for future maintenance

**Dependencies:**
- None (code quality, can be done anytime)

**Blockers:**
- None

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (template refactoring)
- **Breaking Change:** ❌ NO (no functional changes)
- **Live Store Impact:** ✅ ZERO (code quality only)
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** ⭐ TRIVIAL (revert template files)
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Deduplication Audit
[ ] Identify duplicate blocks (>50 lines)
[ ] List all duplicates found
[ ] Document which files have duplicates

Gate 2: Refactoring
[ ] Extract duplicates into components/partials
[ ] All extracted once
[ ] No redundant files
[ ] Duplication reduced 30%+

Gate 3: Testing
[ ] All pages render correctly
[ ] Visual comparison: baseline vs refactored
[ ] No layout changes
[ ] All functionality working
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

DUPLICATE IDENTIFICATION:
[ ] Catalog listing template: duplicated? YES/NO
[ ] Product detail template: duplicated? YES/NO
[ ] Category page template: duplicated? YES/NO
[ ] Homepage sections: duplicated? YES/NO
[ ] Footer: duplicated? YES/NO
[ ] Header: duplicated? YES/NO
[ ] Total duplicates found: ___

REFACTORING:
[ ] Product card component created (used in listing, category, homepage)
[ ] Featured section component extracted
[ ] Sidebar component extracted
[ ] Footer block extracted
[ ] Header common sections extracted

VERIFICATION:
[ ] Product listing page: uses product card component
[ ] Category page: uses product card component
[ ] Homepage: uses product card component (featured products)
[ ] All pages use same components
[ ] No duplicate code remaining

VISUAL REGRESSION:
[ ] Homepage: pixel-perfect match
[ ] Product listing: pixel-perfect match
[ ] Category pages: pixel-perfect match
[ ] Product detail: pixel-perfect match
[ ] No layout shifts

FUNCTIONAL TESTING:
[ ] Navigation works
[ ] Filtering works (if applicable)
[ ] Sorting works (if applicable)
[ ] Add to cart works
[ ] All links functional

PERFORMANCE:
[ ] No performance impact
[ ] File size similar or smaller
[ ] Load time unchanged
```

**Rollback Plan:**

```
IF REFACTORING BREAKS PAGES:

1. Identify Issue:
   [ ] Which pages broken?
   [ ] What's wrong (styling, layout, functionality)?

2. Partial Rollback:
   [ ] Revert one component at a time
   [ ] Find the problematic component
   [ ] Fix it specifically

3. Full Rollback:
   [ ] Revert all template changes
   [ ] Return to original files
   [ ] Can re-attempt with different approach
```

**Implementation Notes:**
- **Manual process:** Audit templates, identify patterns
- **Extract:** Create reusable components/partials
- **Test:** Ensure visual/functional equivalence
- **Benefits:** Easier to maintain, smaller codebase

---

## PHASE 3 COMPLETION GATE

**Criteria to Proceed to Phase 4:**

- [ ] All 3 stories DONE (merged to main)
- [ ] Lighthouse 85+ on mobile (Performance)
- [ ] LCP < 2.5s, FCP < 1.5s, CLS < 0.1
- [ ] Image optimization complete (50% reduction)
- [ ] Templates deduplicated
- [ ] No regressions from Phase 1-2
- [ ] Stakeholder approval to proceed

**Timeline: Weeks 6-7 Complete (April 25)**

---

## PHASE 4: POLISH & MAINTENANCE (Week 8)

**Goals:** Reduced motion + UX polish + Training
**Stories:** 4 (1 sprint, compressed)
**Effort:** 4-7 hours
**Phase Gate:** Documentation complete + Team trained

### Sprint 4.1 (Week 8: Apr 28-May 2)

---

#### Story TDB-2026-001.4.1: Reduced Motion Support (a11y)

**Epic:** TDB-2026-001
**Severity:** MEDIUM
**Priority:** P2 (Accessibility - WCAG)
**Effort:** 1-2 hours
**Owner:** [dev name TBD]
**Component:** Accessibility + CSS

**User Story:**
```
As a user with vestibular disorders,
I want animations to be disabled when I enable reduced motion in my OS,
So that I can browse the website without experiencing motion sickness.
```

**Acceptance Criteria:**
- [ ] `@media (prefers-reduced-motion: reduce)` implemented
- [ ] All animations/transitions disabled for users with reduced motion setting
- [ ] Static fallback content shown
- [ ] WCAG 2.3.3 (Animation from Interactions): PASS
- [ ] Tested on macOS, iOS, Windows, Android
- [ ] Accessibility audit: 0 violations for motion

**Definition of Done (AIOX):**
- [ ] Reduced motion support working
- [ ] All animations respect user preference
- [ ] Accessibility audit passes
- [ ] Ready for production

**Dependencies:**
- Depends on: TDB-2026-001.1.5 (CSS Variables)

**Blockers:**
- CSS must be in place

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (CSS media query)
- **Breaking Change:** ❌ NO (enhancement)
- **Live Store Impact:** ✅ ZERO (accessibility improvement)
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** ⭐ TRIVIAL (remove media query)
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Media Query Implementation
[ ] @media (prefers-reduced-motion: reduce) in CSS
[ ] Affects all animations/transitions
[ ] No animations play when enabled
[ ] Static content shown instead

Gate 2: Testing
[ ] macOS: Enable "Reduce motion" → animations gone
[ ] iOS: Enable "Reduce motion" → animations gone
[ ] Windows 11: Settings > Ease of Access → Reduce motion
[ ] Android: Settings > Accessibility → Remove animations
[ ] All animations disabled correctly

Gate 3: Accessibility
[ ] axe DevTools: 0 violations for motion
[ ] WCAG 2.3.3: PASS
[ ] Screen reader: No animation announcements
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

REDUCED MOTION ENABLED (macOS):
[ ] Open System Preferences > Accessibility > Display
[ ] Enable "Reduce motion"
[ ] Refresh website
[ ] All animations: OFF
[ ] All transitions: OFF
[ ] Content displays instantly
[ ] No visual jank/jumping

REDUCED MOTION DISABLED (macOS):
[ ] Disable "Reduce motion"
[ ] Refresh website
[ ] Animations: ON
[ ] Transitions: ON
[ ] Smooth experience

CROSS-PLATFORM TEST:
[ ] macOS: works as above
[ ] iOS: Settings > Accessibility > Motion > Reduce Motion
[ ] Windows 11: Settings > Ease of Access > Display > Show animations
[ ] Android: Settings > Accessibility > Remove animations

ANIMATION AUDIT:
[ ] Hover animations: disabled with reduced motion
[ ] Page transitions: disabled
[ ] Carousel animations: disabled
[ ] Loading spinners: static when reduced motion enabled
[ ] Scroll animations: disabled
[ ] Other animations: all disabled

ACCESSIBILITY VERIFICATION:
[ ] axe DevTools: 0 animation violations
[ ] WCAG 2.3.3: PASS
[ ] Screen reader: No additional announcements needed
[ ] Keyboard navigation: still smooth
```

**Rollback Plan:**

```
IF REDUCED MOTION BREAKS ANIMATIONS:

1. Check CSS Syntax:
   [ ] Verify @media query syntax
   [ ] Check animation property names
   [ ] Verify no typos

2. Partial Rollback:
   [ ] If specific animation broken: fix that one
   [ ] Keep others disabled
   [ ] Re-test

3. Full Rollback:
   [ ] Remove @media (prefers-reduced-motion: reduce) block
   [ ] Animations always on
   [ ] Can re-implement with different approach
```

**Implementation Notes:**
- **Single CSS media query**
- **Respects OS accessibility settings**
- **No JavaScript needed**
- **Improves UX for users with vestibular disorders**

---

#### Story TDB-2026-001.4.2: Mobile Menu UX Polish

**Epic:** TDB-2026-001
**Severity:** MEDIUM
**Priority:** P2 (UX improvement)
**Effort:** 1-2 hours
**Owner:** [dev name TBD]
**Component:** Mobile UX

**User Story:**
```
As a mobile user,
I want the navigation menu to be easy to open, use, and close,
So that I can navigate the site efficiently on my phone.
```

**Acceptance Criteria:**
- [ ] Mobile menu button: 44px+ touch target
- [ ] Menu opens smoothly without janking
- [ ] Focus management: focus moves to menu on open
- [ ] Keyboard support: ESC key closes menu
- [ ] Tap outside: closes menu
- [ ] Scroll lock: page doesn't scroll while menu open
- [ ] No layout shift when menu opens (CLS < 0.01)
- [ ] Menu accessibility: proper ARIA labels

**Definition of Done (AIOX):**
- [ ] Mobile menu UX polished
- [ ] Accessibility verified
- [ ] No regressions
- [ ] Ready for production

**Dependencies:**
- None (independent UX improvement)

**Blockers:**
- None

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (mobile template)
- **Breaking Change:** ❌ NO (UX improvement)
- **Live Store Impact:** ✅ POSITIVE (better mobile UX)
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** ⭐ TRIVIAL
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Touch Target Size
[ ] Menu button: 44px x 44px minimum
[ ] All menu items: 44px height
[ ] Spacing between items: 8px+

Gate 2: Menu Interactions
[ ] Tap menu button: menu opens
[ ] Tap menu item: navigates (menu closes)
[ ] Tap outside menu: menu closes
[ ] ESC key: menu closes

Gate 3: Accessibility
[ ] ARIA labels on menu button
[ ] ARIA expanded: reflects menu state
[ ] Focus management: focus moves to first menu item on open
[ ] Keyboard navigation: TAB through menu
[ ] Screen reader: menu announced correctly

Gate 4: Visual Polish
[ ] No layout shift (CLS < 0.01)
[ ] Smooth animation (no jank)
[ ] Correct styling on all states
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

TOUCH DEVICE TESTING (Mobile):

iPhone:
[ ] Tap menu button → menu slides in smoothly
[ ] Tap menu item → navigates to page
[ ] Menu closes automatically
[ ] Tap outside menu → closes
[ ] ESC key → closes menu
[ ] No layout shift
[ ] Smooth animation

Android:
[ ] Same tests as iPhone
[ ] Touch responsiveness good
[ ] Menu works on various screen sizes

KEYBOARD NAVIGATION (Mobile Safari, Chrome):
[ ] TAB into menu button → focus visible
[ ] Enter/Space → opens menu
[ ] TAB through menu items → focus visible on each
[ ] First item focused on open
[ ] ESC key → closes menu, focus returns to button

ACCESSIBILITY:
[ ] Screen reader: menu button announced with label
[ ] Screen reader: "menu expanded" when open
[ ] Screen reader: menu items announced
[ ] Touch interaction: works smoothly
[ ] All interactive elements: 44px+

VISUAL REGRESSION:
[ ] Header looks correct
[ ] Menu button position correct
[ ] Menu overlay correct
[ ] No content pushed off screen
[ ] Mobile safe area respected (notch, etc.)

PERFORMANCE:
[ ] Menu opens instantly (no delay)
[ ] Smooth animation (60fps, no jank)
[ ] No cumulative layout shift
[ ] CLS: < 0.01

CROSS-BROWSER MOBILE:
[ ] iOS Safari: works
[ ] iOS Chrome: works
[ ] Android Chrome: works
[ ] Android Firefox: works
[ ] Samsung Internet: works
```

**Rollback Plan:**

```
IF MOBILE MENU BREAKS:

1. Identify Issue:
   [ ] Menu won't open? Check click handler
   [ ] Menu won't close? Check ESC handler
   [ ] Layout shift? Remove menu width reservation
   [ ] Animation janky? Simplify animation

2. Partial Rollback:
   [ ] Revert specific change
   [ ] Keep other improvements
   [ ] Re-test

3. Full Rollback:
   [ ] Revert all mobile menu changes
   [ ] Restore original menu behavior
```

**Implementation Notes:**
- **Focus:** Mobile user experience
- **JavaScript:** Event handlers for open/close
- **CSS:** Smooth animations, layout stability
- **A11y:** ARIA labels, keyboard support

---

#### Story TDB-2026-001.4.3: Complete Documentation

**Epic:** TDB-2026-001
**Severity:** MEDIUM
**Priority:** P2 (Knowledge transfer)
**Effort:** 2-3 hours
**Owner:** [dev name TBD]
**Component:** Documentation

**User Story:**
```
As a developer joining the team,
I want comprehensive documentation for all the changes,
So that I can understand the system and contribute effectively.
```

**Acceptance Criteria:**
- [ ] README.md updated with current architecture
- [ ] CHANGELOG.md with all Phase 1-4 changes
- [ ] DEPLOYMENT.md with production procedures
- [ ] docs/TESTING.md with testing guidelines
- [ ] docs/ACCESSIBILITY.md with a11y standards
- [ ] docs/PERFORMANCE.md with optimization tips
- [ ] ADRs (Architecture Decision Records) for major choices
- [ ] Troubleshooting guide for common issues

**Definition of Done (AIOX):**
- [ ] All documentation complete
- [ ] Peer reviewed
- [ ] Ready for team reference
- [ ] Accessible and searchable

**Dependencies:**
- Depends on: All previous stories (documentation is final phase)

**Blockers:**
- None (can be updated as stories complete)

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (documentation only)
- **Breaking Change:** ❌ NO
- **Live Store Impact:** ✅ ZERO
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** N/A
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Documentation Completeness
[ ] README.md: complete
[ ] CHANGELOG.md: complete
[ ] DEPLOYMENT.md: complete
[ ] TESTING.md: complete
[ ] ACCESSIBILITY.md: complete
[ ] PERFORMANCE.md: complete
[ ] ADRs: major decisions documented

Gate 2: Quality
[ ] Peer review: all docs reviewed
[ ] Accuracy: all docs technically correct
[ ] Clarity: can onboard new dev from these docs
[ ] Examples: code examples provided where helpful

Gate 3: Searchability
[ ] Docs use clear headings
[ ] Table of contents present
[ ] Cross-links between related docs
[ ] Index or navigation structure
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

DOCUMENTATION FILES:

README.md:
[ ] Overview of project
[ ] Quick start instructions
[ ] Key technologies listed
[ ] Link to relevant docs

CHANGELOG.md:
[ ] All Phase 1 changes listed
[ ] All Phase 2 changes listed
[ ] All Phase 3 changes listed
[ ] All Phase 4 changes listed
[ ] Format: Version, date, changes

DEPLOYMENT.md:
[ ] Pre-deployment checklist
[ ] Staging validation process
[ ] Production deployment steps
[ ] Rollback procedures
[ ] Support contact info

TESTING.md:
[ ] Jest setup instructions
[ ] How to run tests locally
[ ] How to write new tests
[ ] CI/CD test requirements
[ ] Coverage targets

ACCESSIBILITY.md:
[ ] WCAG AA standards summary
[ ] How to test accessibility
[ ] Common a11y patterns (labels, focus, etc.)
[ ] Tools: axe DevTools, screen readers
[ ] Team guidelines

PERFORMANCE.md:
[ ] Lighthouse targets
[ ] Core Web Vitals info
[ ] How to optimize images
[ ] CSS/JS optimization tips
[ ] Performance monitoring

ADRS (Architecture Decision Records):
[ ] ADR-001: CSS Variables approach
[ ] ADR-002: Storybook for components
[ ] ADR-003: Jest + Cypress for testing
[ ] ADR-004: GitHub Actions for CI/CD
[ ] ADR-005: Image optimization (WebP)
[ ] (Others as appropriate)

TROUBLESHOOTING.md:
[ ] Common issues and fixes
[ ] "CSS won't update" → solution
[ ] "Tests failing" → solutions
[ ] "Build broken" → fixes
[ ] Support escalation path

ONBOARDING:
[ ] Can new dev set up environment?
[ ] Can follow step-by-step guide?
[ ] Can run tests locally?
[ ] Can start dev server?
[ ] Can understand architecture?
```

**Rollback Plan:**

```
IF DOCUMENTATION HAS ERRORS:

1. Update Documentation:
   [ ] Identify error
   [ ] Correct it
   [ ] Re-review
   [ ] Publish

2. No Rollback Needed:
   [ ] Documentation-only
   [ ] Can iterate anytime
   [ ] No production impact
```

**Implementation Notes:**
- **Markdown format** for all docs
- **GitHub-native** (visible in repo)
- **Live docs** (no build needed)
- **Examples & screenshots** recommended
- **Keep updated** (maintenance task)

---

#### Story TDB-2026-001.4.4: Team Training & Knowledge Transfer

**Epic:** TDB-2026-001
**Severity:** MEDIUM
**Priority:** P2 (Team enablement)
**Effort:** 1-2 hours
**Owner:** [dev name TBD]
**Component:** Training

**User Story:**
```
As a team member,
I want hands-on training and knowledge transfer from the implementation team,
So that I can maintain and extend the codebase effectively.
```

**Acceptance Criteria:**
- [ ] 2-hour training session scheduled
- [ ] Cover: new tools (Storybook, Jest, Cypress, CI/CD)
- [ ] Cover: accessibility standards
- [ ] Cover: performance optimization
- [ ] Cover: deployment procedures
- [ ] Q&A session included
- [ ] Runbooks provided for common tasks
- [ ] Team confident to maintain codebase

**Definition of Done (AIOX):**
- [ ] Training session completed
- [ ] Runbooks distributed
- [ ] Q&A resolved
- [ ] Team sign-off

**Dependencies:**
- Depends on: All other stories (final step)

**Blockers:**
- None

**Nuvemshop Risk Assessment:**
- **Platform Compatible:** ✅ YES (team activity)
- **Breaking Change:** ❌ NO
- **Live Store Impact:** ✅ ZERO
- **Data Impact:** ✅ ZERO
- **Rollback Difficulty:** N/A
- **Risk Level:** NONE

**Validation Gates (Pre-Deploy):**

```
Gate 1: Training Preparation
[ ] Slides/agenda prepared
[ ] Live demo environment ready
[ ] All tools installed on trainer machine
[ ] Runbooks prepared

Gate 2: Training Delivery
[ ] 2-hour session conducted
[ ] All topics covered
[ ] Team asked questions
[ ] Q&A recorded
[ ] Feedback collected

Gate 3: Knowledge Transfer
[ ] Runbooks distributed
[ ] Demo materials provided
[ ] Access to Storybook, CI/CD verified
[ ] Team can navigate repos/tools
```

**Staging Validation Checklist:**

```
**Date:** ____________
**Validated By:** ____________

TRAINING SESSION:

Agenda:
[ ] Welcome & overview (5 min)
[ ] New tools & infrastructure (30 min)
    [ ] Storybook demo
    [ ] Jest + Cypress demo
    [ ] GitHub Actions demo
[ ] Accessibility standards (20 min)
    [ ] WCAG AA overview
    [ ] Testing with screen readers
    [ ] Common patterns
[ ] Performance optimization (20 min)
    [ ] Lighthouse audits
    [ ] Image optimization
    [ ] Core Web Vitals
[ ] Deployment procedures (15 min)
    [ ] Staging validation
    [ ] Production deployment
    [ ] Rollback procedures
[ ] Q&A (10 min)

MATERIALS PROVIDED:
[ ] Presentation slides
[ ] Runbook: "How to write a Jest test"
[ ] Runbook: "How to write a Cypress E2E test"
[ ] Runbook: "How to deploy to production"
[ ] Runbook: "How to rollback a deployment"
[ ] Accessibility guide (quick reference)
[ ] Performance optimization guide
[ ] Tool shortcuts & tips

TEAM FEEDBACK:
[ ] All team members attended: YES / NO
[ ] Team confidence level: 1-5 (rate)
[ ] Q&A resolved: YES / NO
[ ] Unresolved questions: (list)
[ ] Follow-up needed: YES / NO

FOLLOW-UP ACTIONS:
[ ] Schedule Q&A session (if needed)
[ ] Pair programming (if needed)
[ ] Additional documentation (if needed)
```

**Rollback Plan:**

```
IF TRAINING NEEDS FOLLOW-UP:

1. Schedule Follow-up:
   [ ] Identify gaps
   [ ] Schedule pair programming
   [ ] Create additional runbooks
   [ ] Repeat training on specific topics

2. Ongoing Support:
   [ ] Slack channel for questions
   [ ] Office hours for support
   [ ] Quarterly training updates
```

**Implementation Notes:**
- **Interactive session** with live demos
- **Q&A focused** on team's questions
- **Runbooks** for reference
- **Hands-on** exercises recommended
- **Follow-up:** Pair programming sessions if needed

---

## PHASE 4 COMPLETION GATE

**Criteria for EPIC COMPLETION:**

- [ ] All 21 stories DONE (merged to main)
- [ ] All phases complete
- [ ] WCAG AA compliance: 100%
- [ ] Lighthouse 85+ on mobile
- [ ] Test coverage: 80%+
- [ ] Documentation complete
- [ ] Team trained and confident
- [ ] Stakeholder approval: READY FOR PRODUCTION

**Timeline: Week 8 Complete (May 2)**

---

## OVERALL SUCCESS CRITERIA

### Metrics to Verify

| Metric | Target | Achieved |
|--------|--------|----------|
| WCAG AA Compliance | 100% | [ ] |
| Lighthouse Performance | 85+ (mobile) | [ ] |
| Lighthouse Accessibility | 90+ | [ ] |
| Lighthouse SEO | 90+ | [ ] |
| Test Coverage | 80%+ | [ ] |
| LCP | < 2.5s | [ ] |
| FCP | < 1.5s | [ ] |
| CLS | < 0.1 | [ ] |
| Image Size Reduction | 50%+ | [ ] |
| CSS File Size | < 50KB | [ ] |
| JavaScript File Size | < 100KB | [ ] |
| Build Time | < 5s | [ ] |
| Regression Rate | <5% | [ ] |

### Deliverables Checklist

- [ ] All 21 stories merged to main branch
- [ ] Code reviewed and approved (2+ eyes)
- [ ] Tests passing (Jest + Cypress)
- [ ] Linting passing (0 errors)
- [ ] Accessibility audit passing (axe DevTools)
- [ ] Lighthouse 85+ on mobile
- [ ] Staging validation completed
- [ ] Production deployment completed
- [ ] Documentation complete
- [ ] Team trained
- [ ] Stakeholder sign-off obtained

---

## APPENDIX: Story Matrix

### Complete Story List (21 Stories)

| Phase | Sprint | ID | Story | Status |
|-------|--------|----|----|--------|
| 1 | 1.1 | TDB-2026-001.1.1 | Focus Indicators | READY |
| 1 | 1.1 | TDB-2026-001.1.2 | CSS Caching Workaround | READY |
| 1 | 1.1 | TDB-2026-001.1.3 | Jest Testing Framework | READY |
| 1 | 1.2 | TDB-2026-001.1.4 | Alt Text for Images | READY |
| 1 | 1.2 | TDB-2026-001.1.5 | CSS Variables | READY |
| 1 | 1.2 | TDB-2026-001.1.6 | Form Labels (a11y) | READY |
| 2 | 2.1 | TDB-2026-001.2.1 | Design System Foundation | READY |
| 2 | 2.1 | TDB-2026-001.2.2 | Storybook MVP | READY |
| 2 | 2.2 | TDB-2026-001.2.3 | Build Pipeline | READY |
| 2 | 2.2 | TDB-2026-001.2.4 | GitHub CI/CD | READY |
| 2 | 2.3 | TDB-2026-001.2.5 | JS Testing (Jest/Cypress) | READY |
| 2 | 2.3 | TDB-2026-001.2.6 | GitHub Integration | READY |
| 3 | 3.1 | TDB-2026-001.3.1 | Image Optimization | READY |
| 3 | 3.1 | TDB-2026-001.3.2 | Lighthouse Optimization | READY |
| 3 | 3.2 | TDB-2026-001.3.3 | Template Deduplication | READY |
| 4 | 4.1 | TDB-2026-001.4.1 | Reduced Motion Support | READY |
| 4 | 4.1 | TDB-2026-001.4.2 | Mobile Menu UX Polish | READY |
| 4 | 4.1 | TDB-2026-001.4.3 | Complete Documentation | READY |
| 4 | 4.1 | TDB-2026-001.4.4 | Team Training | READY |

**Total Story Points:** 140
**Estimated Effort:** 156-234 hours
**With 2 Developers:** 3-4 weeks
**With 1 Developer:** 6-8 weeks
**With 3 Developers:** 2-3 weeks

---

## SCHEDULE OVERVIEW

```
Week 1 (Mar 24-28):   Sprint 1.1 - Focus, Caching, Testing Setup
Week 2 (Mar 31-Apr 4): Sprint 1.2 - Alt Text, CSS Variables, Forms
                        PHASE 1 GATE ✓
Week 3 (Apr 7-11):    Sprint 2.1 - Design System, Storybook
Week 4 (Apr 14-18):   Sprint 2.2 - Build Pipeline, CI/CD, Testing
Week 5 (Apr 21-25):   Sprint 2.3 - JS Tests, GitHub Rules
                        PHASE 2 GATE ✓
Week 6 (Apr 28-May 2): Sprint 3.1 - Image Optimization, Lighthouse
Week 7 (May 5-9):     Sprint 3.2 - Lighthouse, Templates
                        PHASE 3 GATE ✓
Week 8 (May 12-16):   Sprint 4.1 - Reduced Motion, Mobile Menu, Docs, Training
                        PHASE 4 GATE ✓
                        EPIC COMPLETE ✓

Target End: May 16, 2026 (8 weeks)
```

---

## APPROVAL CHECKLIST

Before starting implementation, obtain:

- [ ] Product Manager approval
- [ ] Engineering Manager approval
- [ ] Technical Lead approval
- [ ] QA Lead approval
- [ ] Budget approval (R$ 50,160 for 2 devs, 8 weeks)
- [ ] Resource allocation: 2 developers confirmed full-time
- [ ] Timeline agreement: 8 weeks acceptable
- [ ] Staging environment ready for validation
- [ ] Production access configured (FTP credentials)

---

## Document Status

**Status:** DRAFT (Awaiting Review & Approval)
**Created:** 2026-03-17
**Last Updated:** 2026-03-17
**Version:** 1.0

**Next Steps:**

1. [ ] Review with Product Manager
2. [ ] Review with Engineering Manager
3. [ ] Review with QA Lead
4. [ ] Approval meeting scheduled
5. [ ] Budget & resources approved
6. [ ] Kick-off meeting scheduled (target: 2026-03-24)
7. [ ] Begin Sprint 1.1

---

**Document Format:** AIOX 10/10 (Story ID + Title + Epic + User Story + AC + DoD + Dependencies + Risk + Validation Gates + Staging Checklist + Rollback Plan)

**Compliance:** All 21 stories include 10 required elements per AIOX standard.

---
