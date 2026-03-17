# Sprint Plan - Comprehensive Rollback Procedures

**Epic:** TDB-2026-001
**Platform:** Nuvemshop (FTP, theme-only)
**Rollback Authority:** DevOps (@devops / Gage)
**Emergency Contact:** Engineering Manager

---

## ROLLBACK DECISION CRITERIA

### Automatic Rollback Triggers

These issues REQUIRE immediate rollback without waiting:

1. **Critical Functionality Broken**
   - Checkout not working
   - Images not loading
   - Navigation broken
   - Payment processing broken
   - Examples: CSS error, JS error affecting core UX

2. **Performance Degradation > 30%**
   - Page load time: baseline 2s → now 3s+ (50% slower)
   - Lighthouse score drop: 85 → 75 (10+ point drop)
   - LCP increase: 2.0s → 3.5s (75% slower)

3. **Accessibility Regression**
   - WCAG AA compliance lost (new critical violations)
   - Focus indicators not working (regression)
   - Keyboard navigation broken
   - Screen reader announcement broken

4. **Data Loss or Security Risk**
   - Customer data exposed (even read-only breach)
   - Form data not submitted
   - Cart items lost
   - Session data corrupted

5. **Store Availability**
   - Website unreachable
   - 503 Service Unavailable
   - Template rendering errors
   - FTP deployment failed mid-way

### Manual Rollback Decision (Requires Discussion)

These issues SHOULD be discussed before rolling back:

1. **Minor Visual Issues**
   - Color slightly off (#FF6B35 vs #FF6C35)
   - Spacing adjustment needed (24px vs 20px)
   - Font size adjustment
   - Animation timing tweak

2. **Low Impact Bugs**
   - Button text missing for non-critical feature
   - Hover state not quite right
   - Mobile menu animation janky
   - Tooltip positioning slightly off

3. **Known Workarounds**
   - CSS not updating → cache-buster deployed
   - Build slow → optimization in progress
   - Warning message in console → non-blocking

### No Rollback Needed

These don't require rollback, just patch:

1. **Documentation Updates**
   - README typo
   - Changelog formatting
   - Comment corrections

2. **Development-Only Changes**
   - Test file additions
   - Storybook component updates (non-prod)
   - Unused code removal

3. **Staged Improvements**
   - Additional optimization (non-blocking)
   - Code refactoring (no behavior change)
   - Testing coverage increase

---

## ROLLBACK PROCEDURES BY STORY

### PHASE 1 ROLLBACKS

---

#### Story 1.1: Focus Indicators
**Severity:** LOW
**Type:** CSS Addition

**Issue Detection:**
```
[ ] Focus outlines not appearing
[ ] Focus outlines causing layout shift
[ ] Focus outlines breaking page layout
[ ] Accessibility score drop
[ ] Browser compatibility issue
```

**Rollback Procedure:**

```
TIMELINE: < 5 minutes from detection
DECISION: Automatic (critical CSS issue)

STEPS:

1. Staging Verification (if not urgent):
   [ ] Identify which CSS rule causes issue
   [ ] Revert specific CSS selector
   [ ] Test in staging
   [ ] Verify fix works
   [ ] If OK: deploy fix
   [ ] If NOT OK: proceed to #2

2. Full Rollback:
   [ ] SSH to FTP server: ssh ftp.nuvemshop.com.br
   [ ] Navigate: cd /theme/static/css/
   [ ] Backup current: cp accessibility.css accessibility.css.backup
   [ ] Restore previous: cp accessibility.css.previous accessibility.css
   [ ] Verify: Check file dates (should be 1 week old)
   [ ] FTP sync: Upload restored file
   [ ] Clear browser cache (version bump)
   [ ] Test in production: http://patagang.nuvemshop.com.br
   [ ] TAB through page: verify focus gone
   [ ] All pages accessible

3. Post-Rollback Analysis:
   [ ] Review CSS syntax (was there a typo?)
   [ ] Check browser compatibility issue
   [ ] Identify why staging didn't catch this
   [ ] Document root cause
   [ ] Plan re-implementation with fix

4. Communication:
   [ ] Message support: "Rolled back focus CSS - investigating issue"
   [ ] Notify Product: deployment reverted
   [ ] Schedule post-mortem (next day)
   [ ] Plan re-attempt (next sprint)

5. Re-Implementation:
   [ ] Fix identified issue
   [ ] Test thoroughly in staging
   [ ] Use more specific CSS selectors
   [ ] Get additional review
   [ ] Deploy when confident
```

**Prevention for Re-Implementation:**
- Use more specific selectors (avoid global `:focus-visible`)
- Test on actual Nuvemshop template, not locally
- Verify all element types (button, a, input, select, etc.)
- Check for CSS cascade issues with existing styles

---

#### Story 1.2: CSS Caching Workaround
**Severity:** CRITICAL
**Type:** Infrastructure

**Issue Detection:**
```
[ ] CSS not updating after deploy
[ ] Cache-buster parameter not incrementing
[ ] Old CSS still in browser cache
[ ] Version number not changing
[ ] FTP file uploaded but old CSS shown
```

**Rollback Procedure:**

```
TIMELINE: < 10 minutes from detection
DECISION: Automatic (blocks all CSS changes)

STEPS:

1. Quick Fix (if simple parameter issue):
   [ ] Check HTML: <link href="style.css?v=20260324001">
   [ ] Verify version number is NEW (not old)
   [ ] If old version: update to new number
   [ ] Save HTML file
   [ ] FTP upload
   [ ] Clear browser cache (Ctrl+Shift+Delete)
   [ ] Test: CSS changes appear immediately

2. If Fix Didn't Work:
   [ ] Verify version number actually incremented
   [ ] Check FTP file upload completed
   [ ] Verify MIME type is correct (text/css)
   [ ] Check web server caching headers
   [ ] If caching headers wrong: contact Nuvemshop support

3. Fallback: Filename-Based Cache Bust:
   [ ] Stop using query param: ?v=
   [ ] Start using filename: theme-20260324.css
   [ ] Update HTML: <link href="theme-20260324.css">
   [ ] Increment filename on each CSS change
   [ ] Upload renamed file
   [ ] Delete old theme files
   [ ] Test: CSS updates immediately

4. Last Resort: Clear Browser Cache Headers:
   [ ] Contact Nuvemshop: request cache clear
   [ ] Ask for: max-age=0 on CSS responses
   [ ] Or: add version header to CSS URL
   [ ] Wait for Nuvemshop response (usually < 30 min)
   [ ] Verify fix works
   [ ] Document workaround

5. Rollback to Baseline:
   [ ] If Nuvemshop cannot help: revert to manual CSS management
   [ ] Accept that CSS caching is a known limitation
   [ ] Plan migration to external CDN (future)
   [ ] Continue with caching workaround as best effort
```

**Prevention:**
- Test workaround on staging BEFORE implementation
- Verify version increment mechanism works
- Have fallback (filename-based) ready immediately
- Document exact steps for future use

---

#### Story 1.3: Jest Testing Framework
**Severity:** MEDIUM
**Type:** Development Infrastructure

**Issue Detection:**
```
[ ] Tests not running locally
[ ] npm test throws error
[ ] Jest config invalid
[ ] Tests failing in CI/CD
[ ] Code coverage incorrect
[ ] Module not found errors
```

**Rollback Procedure:**

```
TIMELINE: < 15 minutes from detection
DECISION: Automatic if CI/CD broken, manual if local only

STEPS:

1. Local Jest Failure:
   [ ] Run: npm test --verbose
   [ ] Check error message
   [ ] Likely causes:
       - jest.config.js syntax error
       - Missing node_modules (run: npm install)
       - Wrong Node version (need 16+)
       - Path configuration wrong
   [ ] Fix the specific issue
   [ ] Re-run: npm test
   [ ] If still broken: proceed to #2

2. Revert Jest Installation:
   [ ] npm uninstall jest @testing-library/dom
   [ ] Remove jest.config.js
   [ ] Remove tests/ directory
   [ ] Revert package.json
   [ ] npm install
   [ ] Verify: project builds without Jest
   [ ] Commit: "Revert: Jest setup (debug needed)"

3. Re-Attempt Jest with Simpler Config:
   [ ] Reinstall Jest: npm install --save-dev jest
   [ ] Use minimal jest.config.js:
      ```javascript
      module.exports = {
        testEnvironment: 'node',
        collectCoverageFrom: ['src/**/*.js']
      };
      ```
   [ ] Create simple test:
      ```javascript
      test('example', () => {
        expect(1 + 1).toBe(2);
      });
      ```
   [ ] Run: npm test
   [ ] If works: proceed to add complexity
   [ ] If fails: check Jest version compatibility

4. CI/CD Jest Failure:
   [ ] Check GitHub Actions logs
   [ ] Identify failing step
   [ ] Likely causes:
       - npm install timeout
       - Jest version mismatch
       - Missing test file
   [ ] Disable Jest in CI temporarily
   [ ] Continue other checks (lint, build)
   [ ] Fix Jest locally
   [ ] Re-enable in CI when working

5. Rollback CI/CD Jest Check:
   [ ] Edit .github/workflows/ci.yml
   [ ] Comment out: - run: npm test
   [ ] Push change
   [ ] CI/CD should pass (without test check)
   [ ] Fix Jest locally meanwhile
   [ ] Re-enable test check next sprint
```

**Prevention:**
- Test Jest locally before committing
- Start with simplest possible config
- Gradually add complexity (coverage, reporters, etc.)
- Test CI/CD integration early (don't wait until PR)

---

#### Story 1.4: Alt Text for Images
**Severity:** MEDIUM
**Type:** Content

**Issue Detection:**
```
[ ] Images completely missing (no alt, no fallback)
[ ] Alt text breaking HTML (quotes not escaped)
[ ] HTML not rendering (template syntax error)
[ ] Images showing as broken (src incorrect)
[ ] Alt text too long (causing layout shift)
```

**Rollback Procedure:**

```
TIMELINE: < 5 minutes from detection
DECISION: Automatic if major issue, manual if minor

STEPS:

1. Broken Images Quick Fix:
   [ ] Check error: Console → Network tab
   [ ] Identify broken image:
       - 404 Not Found: wrong file path
       - CORS error: image from different domain
       - Syntax error: template broken
   [ ] Fix the specific issue:
       - Wrong path: correct in template
       - CORS issue: contact Nuvemshop
       - Syntax: fix quote escaping in alt text
   [ ] Redeploy: FTP upload template
   [ ] Test: Images visible and alt text appears

2. Partial Rollback (if specific category broken):
   [ ] Identify which page/category broken
   [ ] Revert just that template file
   [ ] Keep alt text updates on other pages
   [ ] Test reverted page
   [ ] FTP upload reverted template
   [ ] Verify other pages unaffected

3. Full Rollback (if widespread issue):
   [ ] Restore all product templates from backup
   [ ] Remove all alt text additions
   [ ] Verify: all images display
   [ ] FTP upload restored templates
   [ ] Test: all pages working
   [ ] Plan re-attempt: simpler alt text values

4. Root Cause Analysis:
   [ ] Were alt texts not escaped properly?
   [ ] Were template syntax wrong?
   [ ] Were images not optimized for alt?
   [ ] Document: what went wrong
   [ ] Fix: before next attempt
```

**Prevention:**
- Test alt text with special characters in staging
- Escape quotes and special chars properly
- Start with English-only text (no special chars)
- Use template comments to document alt fields

---

#### Story 1.5: CSS Variables
**Severity:** HIGH
**Type:** CSS Infrastructure

**Issue Detection:**
```
[ ] Colors not displaying (fallback not set)
[ ] Layout broken (spacing vars not working)
[ ] Browser compatibility issue (old browsers)
[ ] CSS file size bloated
[ ] Performance degradation
```

**Rollback Procedure:**

```
TIMELINE: < 5 minutes from detection
DECISION: Automatic (CSS break is critical)

STEPS:

1. CSS Variable Syntax Check:
   [ ] Open DevTools: Inspect element
   [ ] Check computed color: should be #FF6B35
   [ ] If color is purple/broken: variable not set
   [ ] Check CSS file: var(--primary-color, #FF6B35)
   [ ] Verify fallback color exists
   [ ] Save CSS file with fix
   [ ] FTP upload
   [ ] Test: colors display correctly

2. Partial Rollback (remove problematic variable):
   [ ] Identify which variable broken (color? spacing?)
   [ ] Revert just that section in variables.css
   [ ] Keep other variables working
   [ ] Test: only fixed section fixed
   [ ] FTP upload
   [ ] Verify no other regressions

3. Full Rollback:
   [ ] Delete variables.css
   [ ] Restore all original color values in component CSS
   [ ] Remove var() references
   [ ] Use hardcoded hex colors instead
   [ ] FTP upload all CSS files
   [ ] Test: all colors correct
   [ ] Site should render identically to before

4. Re-Implementation Strategy:
   [ ] Create variables for colors only (simpler)
   [ ] Skip spacing variables initially
   [ ] Start with 5-6 colors (primary, secondary, grays)
   [ ] Add fallbacks for each color
   [ ] Test extensively in staging
   [ ] Gradual expansion (add spacing next sprint)
```

**Prevention:**
- Always include fallback colors: var(--color, #FF6B35)
- Test variables in all modern browsers first
- Don't refactor everything at once
- Verify old browsers still work (use fallbacks)

---

#### Story 1.6: Form Labels (Accessibility)
**Severity:** LOW
**Type:** HTML/Accessibility

**Issue Detection:**
```
[ ] Forms don't submit (label breaking form)
[ ] Form validation broken
[ ] Labels appearing twice
[ ] Labels not associated with inputs
[ ] Screen reader reading incorrectly
```

**Rollback Procedure:**

```
TIMELINE: < 5 minutes from detection
DECISION: Automatic if form broken, manual otherwise

STEPS:

1. Form Submission Quick Fix:
   [ ] Check error: Console → Network tab
   [ ] Test form submission: does it work?
   [ ] If works: minor cosmetic issue (no rollback needed)
   [ ] If broken: identify which field broken
   [ ] Revert just that form's label changes
   [ ] Redeploy template
   [ ] Test: form submits

2. Partial Rollback (one form):
   [ ] Identify broken form (contact? checkout? account?)
   [ ] Restore original template
   [ ] Keep label changes on other forms
   [ ] FTP upload reverted template
   [ ] Test all forms

3. Full Rollback (all forms):
   [ ] Restore all original form templates
   [ ] Remove all <label> additions
   [ ] Verify: all forms work
   [ ] FTP upload restored templates
   [ ] Plan re-attempt: simpler label approach

4. Common Issues:
   [ ] "label not associated": for="inputId" wrong
       Fix: match label for= to input id=
   [ ] "HTML validation error": unclosed <label> tag
       Fix: properly close all <label> tags
   [ ] "Form not submitting": JavaScript event handler broken
       Fix: check onsubmit handlers, restore if broken
```

**Prevention:**
- Test form submission in staging before deploy
- Validate HTML: W3C validator
- Use browser DevTools to check label association
- Test with screen reader

---

### PHASE 2 ROLLBACKS

---

#### Story 2.1: Design System Foundation
**Severity:** LOW
**Type:** Documentation

**Issue Detection:**
```
[ ] Documentation misleading
[ ] Design tokens incorrect
[ ] Brand guidelines wrong
[ ] Storybook can't import tokens
[ ] Team confused about system
```

**Rollback Procedure:**

```
TIMELINE: < 30 minutes (documentation-only)
DECISION: Manual (low impact)

STEPS:

1. Update Documentation:
   [ ] Identify error in docs
   [ ] Correct the document
   [ ] Re-review with stakeholders
   [ ] Publish updated version
   [ ] No rollback needed (iterate)

2. Fix Design Tokens:
   [ ] Identify wrong token value
   [ ] Correct tokens.json
   [ ] Re-validate JSON syntax
   [ ] Update Storybook
   [ ] Test: tokens display correctly

3. No True Rollback:
   [ ] Documentation is versioned (not production)
   [ ] Can iterate quickly
   [ ] No need to rollback (just update)
   [ ] Keep latest version in git
```

**Prevention:**
- Review design system with stakeholders BEFORE Storybook
- Have multiple eyes on tokens.json
- Test tokens in Storybook integration

---

#### Story 2.2: Storybook MVP
**Severity:** MEDIUM
**Type:** Development Infrastructure

**Issue Detection:**
```
[ ] Storybook won't start (npm run storybook fails)
[ ] Components don't display
[ ] Storybook deployment fails
[ ] Components inaccessible to team
[ ] Build-time errors
```

**Rollback Procedure:**

```
TIMELINE: < 20 minutes (development-only)
DECISION: Automatic if CI broken, manual if local only

STEPS:

1. Local Storybook Failure:
   [ ] npm run storybook
   [ ] Check error: likely port conflict or config
   [ ] Common fixes:
       - Kill existing process on port 6006
       - npm install (missing dependencies)
       - Delete node_modules/.cache
   [ ] Retry: npm run storybook
   [ ] If works: proceed
   [ ] If not: #2

2. Revert Storybook Installation:
   [ ] npm uninstall @storybook/html
   [ ] Delete .storybook/ directory
   [ ] Revert package.json
   [ ] npm install
   [ ] Verify: project builds without Storybook
   [ ] Commit: "Revert: Storybook (debug needed)"

3. Re-Attempt with Simpler Setup:
   [ ] Reinstall: npm install --save-dev @storybook/html
   [ ] Create minimal config: .storybook/main.js
   [ ] Create one test story: stories/Button.stories.js
   [ ] Run: npm run storybook
   [ ] If works: add more stories gradually
   [ ] If fails: check Storybook version compatibility

4. Storybook Deployment Failure:
   [ ] Check deployment logs (Netlify or similar)
   [ ] Identify failing step (build? upload? cache?)
   [ ] Fix configuration
   [ ] Re-deploy
   [ ] Verify: Storybook accessible

5. No Production Impact:
   [ ] Storybook is development-only
   [ ] Rollback doesn't affect store
   [ ] Take time to debug
   [ ] Re-attempt when confident
```

**Prevention:**
- Test Storybook locally BEFORE pushing
- Use official Storybook templates as guide
- Start with minimal setup, add complexity gradually

---

#### Story 2.3: Build Pipeline
**Severity:** HIGH
**Type:** Infrastructure

**Issue Detection:**
```
[ ] npm run build fails
[ ] Build output corrupted
[ ] CSS minification breaks styling
[ ] JavaScript minification breaks functionality
[ ] Source maps missing
[ ] File size exploded (not minified)
```

**Rollback Procedure:**

```
TIMELINE: < 15 minutes from detection
DECISION: Automatic if CI broken

STEPS:

1. Build Debugging:
   [ ] npm run build --verbose
   [ ] Check error message
   [ ] Common causes:
       - Syntax error in CSS/JS source
       - Missing import/require
       - Invalid webpack config
   [ ] Fix the source issue
   [ ] Retry: npm run build
   [ ] If works: done
   [ ] If not: #2

2. Revert Build Configuration:
   [ ] Backup current: webpack.config.js.new
   [ ] Restore previous: webpack.config.js.old
   [ ] Delete dist/ directory
   [ ] npm run build
   [ ] Verify: build succeeds
   [ ] Commit: "Revert: Build pipeline (debug needed)"

3. Alternative: Use Fallback Build:
   [ ] If webpack broken: try Vite instead
   [ ] Install: npm install -D vite
   [ ] Create: vite.config.js
   [ ] Configure: inputs, outputs
   [ ] Test: npm run build
   [ ] If works: use Vite as new build tool

4. Incremental Re-Implementation:
   [ ] Start with minimal webpack config
   [ ] Just bundle CSS and JS (no optimization)
   [ ] Verify build works
   [ ] Add optimization step-by-step:
       - Add CSS minification
       - Add JS minification
       - Add source maps
   [ ] Test after each change
   [ ] Commit working config before next change

5. No Production Impact:
   [ ] Build is development-only (runs locally)
   [ ] Rollback doesn't affect store
   [ ] Can iterate and debug
```

**Prevention:**
- Test build locally BEFORE pushing to main
- Verify build output size (should be small)
- Check source maps work
- Test in CI/CD early

---

#### Story 2.4: GitHub CI/CD Pipeline
**Severity:** HIGH
**Type:** Infrastructure

**Issue Detection:**
```
[ ] Workflow doesn't run on PR
[ ] Workflow errors (YAML syntax)
[ ] Tests always fail in CI
[ ] CI/CD hanging/timeout
[ ] Status checks not blocking merge
```

**Rollback Procedure:**

```
TIMELINE: < 10 minutes from detection
DECISION: Automatic if CI broken

STEPS:

1. Workflow Debugging:
   [ ] Go to GitHub: Actions tab
   [ ] Click failing workflow
   [ ] View logs: identify failing step
   [ ] Common issues:
       - Syntax error in .yml file
       - Timeout (npm install slow)
       - Test failure (code broken, not CI)
   [ ] Fix the issue
   [ ] Commit fix
   [ ] Workflow should pass on next PR

2. Quick Rollback (if urgent):
   [ ] Delete workflow: .github/workflows/ci.yml
   [ ] Push change
   [ ] CI/CD disabled temporarily
   [ ] Continue without automated checks
   [ ] Fix workflow offline
   [ ] Re-create workflow when working
   [ ] Commit: "Re-enable CI/CD"

3. Disable Specific Check:
   [ ] If only one check failing (e.g., tests)
   [ ] Comment out that step in workflow
   [ ] Keep other checks (lint, build)
   [ ] Fix that check locally
   [ ] Re-enable when working

4. Escalate to DevOps:
   [ ] If CI/CD broken and can't fix quickly
   [ ] Message @devops
   [ ] DevOps can:
       - Temporarily disable workflow
       - Fix permissions/secrets
       - Investigate platform issues
   [ ] Continue development meantime
   [ ] DevOps re-enables when fixed

5. No Production Impact:
   [ ] CI/CD is development automation
   [ ] Rollback doesn't affect store
   [ ] Can debug and iterate
   [ ] Use manual review meantime
```

**Prevention:**
- Test workflow file locally (validate YAML)
- Start with simple workflow (just lint)
- Add complexity step-by-step
- Watch for first PR to verify it works

---

#### Story 2.5: JavaScript Testing
**Severity:** MEDIUM
**Type:** Testing Infrastructure

**Issue Detection:**
```
[ ] Tests don't run (npm test fails)
[ ] Tests flaky (intermittent failures)
[ ] Coverage doesn't increase
[ ] Cypress tests timeout
[ ] CI/CD test timeout
```

**Rollback Procedure:**

```
TIMELINE: < 20 minutes for local, < 10 for CI issue
DECISION: Manual (testing tools)

STEPS:

1. Failing Tests Quick Fix:
   [ ] npm test --verbose
   [ ] Identify failing test:
       - Actual bug (fix source code)
       - Test too strict (fix test)
       - Timeout (increase Jest timeout)
   [ ] If source code bug: fix code, re-run tests
   [ ] If test issue: fix test, re-run

2. Flaky Tests:
   [ ] Tests pass sometimes, fail sometimes
   [ ] Causes: async issues, timing, shared state
   [ ] Solutions:
       - Add await for async operations
       - Increase timeout (jest.setTimeout)
       - Clean up state (beforeEach)
   [ ] Re-run test 5 times: should all pass
   [ ] Commit fix

3. Revert Testing Framework:
   [ ] If Jest fundamentally broken:
       [ ] npm uninstall jest @testing-library/dom
       [ ] Remove tests/ directory
       [ ] Remove jest.config.js
       [ ] npm install
   [ ] If Cypress broken:
       [ ] npm uninstall cypress
       [ ] Delete cypress/ directory
       [ ] npm install
   [ ] Verify: project builds without tests
   [ ] Commit: "Revert: Jest/Cypress (debug needed)"
   [ ] Re-attempt with simpler setup next sprint

4. CI/CD Test Timeout:
   [ ] GitHub Actions npm install timeout?
       - Increase timeout in workflow (default 60s)
       - Use npm ci instead of npm install
       - Cache node_modules
   [ ] Tests timeout?
       - Increase Jest timeout
       - Simplify tests (remove slow operations)
       - Run tests in parallel: npm test -- --maxWorkers=2
   [ ] Re-commit with fix
   [ ] CI/CD should succeed on next PR

5. No Production Impact:
   [ ] Tests are development-only
   [ ] Rollback doesn't affect store
   [ ] Continue without automated tests meantime
   [ ] Fix tests in next sprint
```

**Prevention:**
- Write tests against real code (not mocked too much)
- Keep tests simple and fast (< 1s each)
- Avoid flaky tests (timing-dependent)
- Test locally before pushing to CI

---

#### Story 2.6: GitHub Branch Rules
**Severity:** MEDIUM
**Type:** Workflow

**Issue Detection:**
```
[ ] Rules too strict (can't merge anything)
[ ] Rules not enforcing properly
[ ] Force push not blocked
[ ] Stale reviews not dismissed
[ ] Team can't commit
```

**Rollback Procedure:**

```
TIMELINE: < 5 minutes (GitHub web UI)
DECISION: Manual (workflow adjustment)

STEPS:

1. Adjust Rules (not rollback):
   [ ] Go to: Repo Settings > Branches > main
   [ ] Review rules
   [ ] If too strict: reduce approval requirement (2 → 1)
   [ ] If not enforced: re-enable rule
   [ ] If blocking team: disable temporarily, fix later
   [ ] Save changes
   [ ] Test on next PR: verify rule works as expected

2. Emergency Override:
   [ ] If rules completely blocking:
       [ ] Repo admin can push --force
       [ ] or use: git push -f origin main
       [ ] (only for emergencies!)
   [ ] Document why override needed
   [ ] Plan post-mortem
   [ ] Re-establish rules next sprint

3. No Code Rollback:
   [ ] Rules are settings-only (GitHub web)
   [ ] No code to rollback
   [ ] Just adjust settings as needed

4. Communicate Changes:
   [ ] If rules adjusted: notify team
   [ ] Document new rules
   [ ] Explain why changed
[ ] Get approval before re-tightening rules
```

**Prevention:**
- Implement rules gradually (start permissive)
- Announce changes to team
- Offer period to adjust (no surprises)
- Monitor for genuine problems before tightening

---

### PHASE 3 ROLLBACKS

---

#### Story 3.1: Image Optimization
**Severity:** MEDIUM
**Type:** Assets

**Issue Detection:**
```
[ ] Images not appearing (broken WebP)
[ ] Images blurry/low quality
[ ] Image size didn't reduce much
[ ] Wrong images loading on mobile
[ ] Lazy loading not working
```

**Rollback Procedure:**

```
TIMELINE: < 10 minutes from detection
DECISION: Automatic if broken, manual if quality issue

STEPS:

1. Broken Images Quick Fix:
   [ ] Check: <picture> element syntax correct?
   [ ] Check: <source> tags in right order (WebP first)
   [ ] Check: MIME types correct (type="image/webp")
   [ ] Check: Fallback <img> src exists
   [ ] Fix: corrected HTML
   [ ] FTP upload fixed template
   [ ] Test: images display with correct format

2. Lazy Loading Issues:
   [ ] Some images not loading?
       - Check: loading="lazy" attribute present
       - Fix: remove loading="lazy" from critical images
       - Keep lazy loading on non-critical images
   [ ] Redeploy template
   [ ] Test: critical images load, others lazy-load

3. Quality Issue:
   [ ] WebP too compressed (looks blurry)?
       - Use higher quality setting in converter
       - Decrease compression (quality 85 → 90)
   [ ] Re-convert images with better quality
   [ ] Verify: file size still reasonable
   [ ] Update WebP images on FTP
   [ ] Test: quality acceptable

4. Partial Rollback (use JPEG only):
   [ ] Remove WebP from <picture> element
   [ ] Keep only JPEG/PNG
   [ ] Revert <picture> to simple <img src="...jpg">
   [ ] Remove loading="lazy" if it was problem
   [ ] FTP upload simplified template
   [ ] Test: images display (without WebP benefit)
   [ ] Performance drops slightly, but images work
   [ ] Plan: re-optimize WebP next sprint

5. Full Rollback:
   [ ] Restore original images from backup
   [ ] Delete all WebP files
   [ ] Revert templates to original <img> tags
   [ ] FTP upload restored images and templates
   [ ] Verify: all images appear
   [ ] Performance returns to baseline
   [ ] Note: Lighthouse score won't improve
```

**Prevention:**
- Test WebP format in all browsers (staging)
- Verify file size reduction (should be 50%+)
- Test lazy loading (scroll to images)
- Check fallbacks work (WebP fails → JPEG loads)

---

#### Story 3.2: Lighthouse Optimization
**Severity:** HIGH
**Type:** Performance

**Issue Detection:**
```
[ ] Lighthouse score dropped (after optimization)
[ ] Performance degraded (slower load)
[ ] Layout broken from optimization
[ ] JavaScript minification broke functionality
[ ] CSS optimization caused styling issues
```

**Rollback Procedure:**

```
TIMELINE: < 10 minutes from detection
DECISION: Automatic if major regression

STEPS:

1. Identify Optimization Breaking Functionality:
   [ ] Run Lighthouse audit (locally or staging)
   [ ] Check score drop: 85 → 78? (critical)
   [ ] Check what changed: compare before/after
   [ ] Likely culprits:
       - JavaScript minification removed important code
       - CSS optimization removed needed selectors
       - Async script loading breaks functionality
   [ ] Identify specific optimization causing issue

2. Revert Specific Optimization:
   [ ] Disable minification? → remove from build config
   [ ] Remove async script loading? → make synchronous
   [ ] Revert font optimization? → use original fonts
   [ ] Re-run: npm run build
   [ ] Test: functionality works
   [ ] Lighthouse score: should recover
   [ ] If OK: keep this reversion, redo other optimizations

3. Gradual Re-Optimization:
   [ ] Don't optimize everything at once
   [ ] Start with: CSS minification only
   [ ] Test: Lighthouse score
   [ ] Add: JavaScript minification
   [ ] Test: functionality still works
   [ ] Add: Font optimization
   [ ] Test: score improves
   [ ] Add: Image lazy loading
   [ ] Continue step-by-step...

4. Full Rollback (if too many issues):
   [ ] Revert all optimizations: git revert <commit>
   [ ] Delete dist/ directory
   [ ] npm run build (with original config)
   [ ] FTP upload original files
   [ ] Test: site works, performance baseline
   [ ] Plan: slower, more careful optimization next time

5. Root Cause Analysis:
   [ ] Why did optimization break functionality?
   [ ] Was minification too aggressive?
   [ ] Was something removed that shouldn't be?
   [ ] Was async loading misconfigured?
   [ ] Document: what went wrong
   [ ] Plan: how to prevent (more testing)
```

**Prevention:**
- Test functionality AFTER optimization
- Don't optimize multiple things at once
- Use source maps to debug minified code
- Monitor Lighthouse score as you optimize
- Keep previous working version as fallback

---

#### Story 3.3: Template Deduplication
**Severity:** LOW
**Type:** Code Refactoring

**Issue Detection:**
```
[ ] Template rendering broken
[ ] Duplicated component not rendering
[ ] Component behavior changed
[ ] Layout different from before
```

**Rollback Procedure:**

```
TIMELINE: < 10 minutes from detection
DECISION: Automatic if rendering broken

STEPS:

1. Template Rendering Issue:
   [ ] Identify broken page
   [ ] Check page in staging: broken?
   [ ] Check DevTools console: errors?
   [ ] Common issues:
       - Component path wrong
       - Component include syntax wrong
       - Component parameters not passed
   [ ] Fix the specific component reference
   [ ] Redeploy
   [ ] Test: page renders

2. Component Behavior Different:
   [ ] Did extracted component lose some logic?
   [ ] Review original component code
   [ ] Verify extracted component has same code
   [ ] Add missing code if needed
   [ ] Re-test all pages using component

3. Partial Rollback:
   [ ] Revert just the problematic component
   [ ] Keep other deduplications working
   [ ] Restore original template code for broken component
   [ ] Test: broken component works again
   [ ] Verify other components still using shared code

4. Full Rollback:
   [ ] Revert all deduplication changes
   [ ] Restore all original template files
   [ ] Delete newly created component files
   [ ] Verify: all pages render correctly
   [ ] Performance similar to before
   [ ] Note: maintainability worse (code duplication returns)
   [ ] Plan: more careful refactoring next time

5. No Production Impact:
   [ ] Deduplication is code quality, not feature
   [ ] Rollback doesn't affect store functionality
   [ ] Can iterate and debug
```

**Prevention:**
- Test each page AFTER extracting component
- Visual regression testing (screenshot compare)
- Use version control to track changes
- Code review by another developer

---

### PHASE 4 ROLLBACKS

---

#### Story 4.1: Reduced Motion Support
**Severity:** LOW
**Type:** CSS Enhancement

**Issue Detection:**
```
[ ] All animations removed (even without user setting)
[ ] Media query not working
[ ] Animations still playing despite setting
[ ] Browser compatibility issue
```

**Rollback Procedure:**

```
TIMELINE: < 5 minutes
DECISION: Manual (low impact)

STEPS:

1. Media Query Debug:
   [ ] Check CSS: @media (prefers-reduced-motion: reduce)
   [ ] Open DevTools: check media query in console
   [ ] Test on device: macOS Reduce Motion toggle
   [ ] Verify: query applies when setting enabled
   [ ] If working: no rollback needed
   [ ] If not working: check syntax, media query name

2. Browser Compatibility:
   [ ] Is browser old (pre-2017)?
       - Older browsers: ignore media query (graceful degradation)
       - Animations play normally
       - That's OK (fallback behavior)
   [ ] Modern browsers: should respect setting
   [ ] Test on current browsers only

3. Revert (if needed):
   [ ] Remove @media (prefers-reduced-motion: reduce) block
   [ ] Animations always on
   [ ] No rollback, just remove enhancement

4. No Production Impact:
   [ ] Reduced motion is enhancement (not critical)
   [ ] Rollback doesn't break anything
   [ ] Just removes accessibility feature
   [ ] Can iterate next sprint
```

**Prevention:**
- Test on actual device with reduced motion enabled
- Test on multiple browsers
- Verify media query with DevTools

---

#### Story 4.2: Mobile Menu UX Polish
**Severity:** LOW
**Type:** UX Improvement

**Issue Detection:**
```
[ ] Menu won't open
[ ] Menu won't close
[ ] Touch targets too small
[ ] Menu overlays content
[ ] Mobile layout broken
```

**Rollback Procedure:**

```
TIMELINE: < 5 minutes
DECISION: Manual (can iterate)

STEPS:

1. Quick UX Fix:
   [ ] Identify issue: won't open? won't close?
   [ ] Check JavaScript: event handlers attached?
   [ ] Check CSS: menu display property correct?
   [ ] Fix the specific issue
   [ ] Test on mobile device

2. Touch Target Issue:
   [ ] Button < 44px? → make larger
   [ ] Menu items < 44px? → increase padding
   [ ] Recalculate:
       - Button height + padding = 44px
       - Menu item height + padding = 44px
   [ ] Redeploy

3. Revert Menu Changes:
   [ ] Restore original mobile menu HTML
   [ ] Remove new JavaScript event handlers
   [ ] Verify: menu works (original behavior)
   [ ] Performance improves (less JavaScript)
   [ ] Accessibility: check if regressed

4. No Production Impact:
   [ ] Mobile menu is UX, not critical functionality
   [ ] Rollback doesn't break checkout
   [ ] Can iterate next sprint
```

**Prevention:**
- Test on real mobile device (not simulator)
- Test on slow 3G (slow event handlers)
- Verify touch targets are 44px+

---

#### Story 4.3: Documentation
**Severity:** VERY LOW
**Type:** Documentation

**Issue Detection:**
```
[ ] Documentation has errors
[ ] Instructions unclear
[ ] Missing sections
[ ] Outdated information
```

**Rollback Procedure:**

```
TIMELINE: < 30 minutes
DECISION: Manual (update, don't rollback)

STEPS:

1. Update (Not Rollback):
   [ ] Identify error in documentation
   [ ] Correct the document
   [ ] Re-review
   [ ] Publish updated version
   [ ] No rollback needed (iterate)

2. No True Rollback:
   [ ] Documentation is versioned in git
   [ ] Can view history if needed
   [ ] Just update to latest version
   [ ] No impact on production

3. Version Control:
   [ ] Commit: "docs: fix typo in TESTING.md"
   [ ] Commit: "docs: update deployment process"
   [ ] Build documentation versioning if needed
```

**Prevention:**
- Have peer review documentation
- Use spell checker
- Test instructions (follow them yourself)
- Get feedback from team

---

#### Story 4.4: Team Training
**Severity:** VERY LOW
**Type:** Training Event

**Issue Detection:**
```
[ ] Training materials incomplete
[ ] Team doesn't understand
[ ] Questions unanswered
[ ] Training doesn't prepare for support
```

**Rollback Procedure:**

```
TIMELINE: N/A (training event, not code)
DECISION: Manual (follow-up, not rollback)

STEPS:

1. Training Follow-Up (Not Rollback):
   [ ] Identify gaps in training
   [ ] Schedule follow-up session
   [ ] Create additional runbooks
   [ ] Pair programming as needed
   [ ] No rollback (iterate with training)

2. No Code Rollback:
   [ ] Training is knowledge transfer (not code)
   [ ] No production code to rollback
   [ ] Team training issues don't affect store

3. Continuous Education:
   [ ] Document common questions
   [ ] Create FAQ
   [ ] Schedule monthly training updates
   [ ] Build knowledge base
```

**Prevention:**
- Record training session
- Provide written runbooks
- Allow Q&A time
- Follow up after training

---

## ESCALATION MATRIX

### Who to Contact

**If issue is:**
- CSS/styling broken → Contact **Dev A** or **Dev B**
- JavaScript broken → Contact **Dev A** or **Dev B**
- Build/CI pipeline broken → Contact **Dev A** (Build lead)
- Testing framework broken → Contact **Dev B** (QA lead)
- Performance issue → Contact **Dev A**
- GitHub configuration → Contact **@devops** (Gage)
- Production emergency → Contact **Engineering Manager**
- Nuvemshop platform issue → Contact **Nuvemshop Support**

### Escalation Path

```
Developer detects issue
         ↓
[Can fix in < 10 min? YES → fix immediately]
[Can fix in < 10 min? NO ↓]
         ↓
Team lead (if needed)
         ↓
[Major issue (Lighthouse broken, checkout down)? YES → @devops]
[Major issue? NO → continue debugging]
         ↓
Engineering Manager (if issue > 30 min to resolve)
         ↓
Product Manager (if affecting production)
```

---

## EMERGENCY PROCEDURES

### Website Down (500 Error / Not Responding)

**Immediate Actions (< 2 minutes):**

1. [ ] Confirm website is actually down
   - [ ] Try different browsers
   - [ ] Try mobile connection
   - [ ] Check: http://patagang.nuvemshop.com.br

2. [ ] Message #emergency Slack channel
   - "Website is down - investigating cause"

3. [ ] Identify likely cause
   - [ ] Latest deployment? (check LAST_DEPLOY_VERSION)
   - [ ] Nuvemshop issue? (no changes by us)
   - [ ] Template rendering error?
   - [ ] CSS/JS broken?

4. [ ] Immediate actions
   - [ ] If our deployment: prepare rollback
   - [ ] If Nuvemshop: contact Nuvemshop support
   - [ ] Start rollback process (#2 below)

**Rollback Process (< 15 minutes total):**

```
IF DEPLOYMENT CAUSED OUTAGE:

1. Access FTP:
   [ ] ssh ftp.nuvemshop.com.br
   [ ] or FTP client: ftp.nuvemshop.com.br

2. Identify problematic files:
   [ ] Check: theme/static/css/ for broken files
   [ ] Check: theme/static/js/ for broken files
   [ ] Check: theme/templates/ for broken templates

3. Restore backups:
   [ ] Restore previous version of problematic files
   [ ] Or delete broken files to use defaults

4. Verify fix:
   [ ] Refresh website: http://patagang.nuvemshop.com.br
   [ ] Should return to working state
   [ ] Check: checkout works
   [ ] Check: images load
   [ ] Check: no console errors

5. Communicate:
   [ ] Post in Slack: "Website restored - investigating root cause"
   [ ] Contact support team: brief them on issue
   [ ] Schedule post-mortem within 24h
   [ ] Document what went wrong
```

### Checkout Not Working

**Immediate Actions:**

1. [ ] Test checkout locally
   - [ ] Add item to cart
   - [ ] Click checkout
   - [ ] Does form appear?
   - [ ] Can enter information?

2. [ ] Check for JavaScript errors
   - [ ] DevTools console: any errors?
   - [ ] Check Network tab: failed requests?
   - [ ] Check: form submission works

3. [ ] If form broken
   - [ ] Revert recent form changes (if any)
   - [ ] Check: labels not breaking form submission
   - [ ] Test: form submits after fix

4. [ ] If Nuvemshop issue
   - [ ] Contact Nuvemshop support
   - [ ] They'll investigate server-side

### Production Fire Drill (Test)

**First Friday of each month, 2:00 PM:**

- [ ] Simulate emergency
- [ ] Practice rollback steps
- [ ] Verify procedures work
- [ ] Document any issues
- [ ] Improve procedures

---

## POST-ROLLBACK CHECKLIST

After ANY rollback, complete:

```
IMMEDIATELY AFTER ROLLBACK:

[ ] Website verified working (manual testing)
[ ] Checkout tested (add to cart → complete order simulation)
[ ] Images verified loading
[ ] Navigation working
[ ] No console errors

COMMUNICATION:

[ ] Support team notified (rollback complete)
[ ] Product manager notified (issue, timeline to fix)
[ ] Team aware of rollback (avoid same mistake)
[ ] Slack: document what happened

ROOT CAUSE ANALYSIS:

[ ] What went wrong? (document)
[ ] Why didn't staging catch it? (process improvement)
[ ] How to prevent in future? (guidelines)
[ ] Updated checklist? (before next deployment)

CODE FIX:

[ ] Fix committed to development branch
[ ] Tested in staging thoroughly
[ ] Code reviewed (2+ eyes)
[ ] Ready to re-deploy when confident

RE-DEPLOYMENT:

[ ] Plan: when to re-deploy fix?
[ ] Wait for: appropriate business window
[ ] Test: 1-2 hours in staging
[ ] Deploy: with team standing by
```

---

## DOCUMENT METADATA

**Status:** DRAFT
**Created:** 2026-03-17
**Version:** 1.0
**Last Updated:** 2026-03-17

**Related Documents:**
- `SPRINT-PLAN-AIOX-10-10.md` - Full story details
- `SPRINT-PLAN-SCHEDULE.md` - Timeline
- `SPRINT-PLAN-DEPENDENCIES.md` - Dependencies

**Emergency Contacts:**
- Engineering Manager: [contact info]
- DevOps Lead (@devops): [contact info]
- Nuvemshop Support: support@nuvemshop.com.br

---
