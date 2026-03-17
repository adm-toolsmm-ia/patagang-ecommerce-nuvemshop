# Nuvemshop Acceptance Criteria - Definition of Done

**Detailed acceptance criteria for each of 21 technical debts**
**Use this to validate completion and quality**

---

## Format

For each debt:
- **Definition of Done:** What must be true to consider it complete
- **Testing Checklist:** How to verify completion
- **Quality Gates:** Automated checks that must pass
- **Sign-off:** Who reviews and approves

---

## PHASE 1: Critical Foundation (Weeks 1-2)

### SYS-1: CSS Server-Side Caching Issues

**Definition of Done:**
- [ ] Cache invalidation strategy documented in `docs/CSS-CACHE-STRATEGY.md`
- [ ] Version ID system implemented in `theme/layouts/layout.tpl`
- [ ] CSS override rules added to layout footer `<style id="pg-override-final">`
- [ ] Cache-busting script created in deployment pipeline
- [ ] No hardcoded URLs in CSS files (all use versioning)
- [ ] Deployment script automatically increments version ID
- [ ] Team trained on cache invalidation procedure

**Testing Checklist:**
- [ ] Deploy CSS change to staging
- [ ] Verify change appears immediately (no manual cache clear needed)
- [ ] Verify cache header includes version ID
- [ ] Test in 3 browsers (Chrome, Firefox, Safari)
- [ ] Test on mobile (iOS, Android)
- [ ] CSS override layer loads last (use DevTools)
- [ ] No layout shift or style flashing

**Quality Gates:**
```bash
[ ] npm run lint     # CSS valid
[ ] npm test         # No CSS parser errors
[ ] lighthouse       # Performance unchanged
[ ] accessibility    # WCAG score unchanged
```

**Validation Command:**
```bash
# Check cache headers
curl -I https://staging.patagang.com/css/main.css | grep "Cache-Control"
# Expected: Cache-Control: max-age=3600, ?v=[timestamp]

# Check override layer exists
grep -n "pg-override-final" theme/layouts/layout.tpl
# Expected: Found and contains CSS rules
```

**Sign-Off:**
- [ ] QA: Verified in staging
- [ ] Tech Lead: Reviewed strategy
- [ ] DevOps: Deployment script working

**Rollback Procedure:**
```
git revert <commit-hash>
npm run deploy:staging
Clear cache: Dashboard → Settings → Clear Cache
Verify in browser (incognito window)
```

---

### FE-4: Focus Indicators Missing (WCAG 2.4.7)

**Definition of Done:**
- [ ] `:focus-visible` CSS rules added to `theme/static/css/accessibility.css`
- [ ] Focus outline visible on ALL interactive elements
  - `<button>`
  - `<a>`
  - `<input>`
  - `<select>`
  - `<textarea>`
- [ ] Focus outline minimum 3px (WCAG requirement)
- [ ] Focus outline uses high-contrast color (4.5:1 contrast minimum)
- [ ] Focus outline has 2px offset to avoid element overlap
- [ ] No focus removal with `outline: none` anywhere in codebase
- [ ] All interactive elements keyboard navigable (Tab key)

**Testing Checklist:**
- [ ] WAVE accessibility audit: 0 focus visibility issues
- [ ] Keyboard navigation test:
  - [ ] Tab through entire page
  - [ ] Every interactive element shows focus indicator
  - [ ] Focus indicator never hidden
  - [ ] Focus order logical (left-to-right, top-to-bottom)
- [ ] Screen reader test (NVDA, JAWS, VoiceOver):
  - [ ] All elements announced
  - [ ] Focus announced correctly
  - [ ] No skipped elements
- [ ] Visual contrast check:
  - [ ] Focus outline readable on light background
  - [ ] Focus outline readable on dark background
  - [ ] Focus outline readable on image backgrounds
- [ ] Browser compatibility:
  - [ ] Chrome ✅
  - [ ] Firefox ✅
  - [ ] Safari ✅
  - [ ] Edge ✅

**Quality Gates:**
```bash
[ ] npm run lint             # CSS valid
[ ] npm run accessibility    # WCAG 2.4.7 PASS
[ ] npm run test             # No visual regression
[ ] axe audit                # 0 focus issues
```

**Validation Code:**
```javascript
// Check for focus removal anti-pattern
const hasOutlineNone = document.querySelectorAll('[style*="outline: none"]').length > 0;
console.assert(!hasOutlineNone, 'Found outline: none - FAIL');

// Check focus indicator styles
const style = window.getComputedStyle(document.querySelector(':focus-visible'));
console.assert(style.outline, 'No focus outline - FAIL');
console.log('✅ Focus indicator verified');
```

**Sign-Off:**
- [ ] QA: WAVE audit passing
- [ ] Accessibility Specialist: WCAG 2.4.7 compliant
- [ ] Tech Lead: Code review approved

---

### SYS-7: Auto Tests Setup (Unit Tests)

**Definition of Done:**
- [ ] Jest installed and configured: `npm install jest @testing-library/dom jsdom`
- [ ] Test configuration: `jest.config.js` created
- [ ] Test utilities created: `tests/utils/`
- [ ] Critical modules tested (60%+ coverage target):
  - [ ] `theme/static/js/cart.js`
  - [ ] `theme/static/js/filters.js`
  - [ ] `theme/static/js/search.js`
- [ ] Pre-commit hooks configured: `npm install husky`
- [ ] Pre-commit hook runs tests automatically
- [ ] Coverage report generated: `npm test -- --coverage`
- [ ] Coverage meets threshold: ≥60% for Phase 1
- [ ] CI/CD integration ready (Phase 2)
- [ ] Team trained on testing workflow

**Testing Checklist:**
- [ ] `npm test` runs without errors
- [ ] All tests pass on fresh checkout
- [ ] Tests pass in CI/CD environment
- [ ] Pre-commit hooks work:
  - [ ] Create bad code intentionally
  - [ ] Try to commit
  - [ ] Commit blocked by test failure ✅
- [ ] Coverage report shows:
  - [ ] Statements: ≥60%
  - [ ] Branches: ≥50%
  - [ ] Functions: ≥60%
  - [ ] Lines: ≥60%
- [ ] Mock setup working for Nuvemshop variables:
  - [ ] `window.Nuvem` available in tests
  - [ ] `localStorage` mocked
  - [ ] `fetch` mocked

**Quality Gates:**
```bash
[ ] npm test              # All tests pass
[ ] npm test -- --coverage  # Coverage ≥60%
[ ] npm run lint          # No style issues
[ ] git hooks working     # Pre-commit blocked bad commits
```

**Validation:**
```bash
# Run tests with coverage
npm test -- --coverage --watchAll=false
# Expected: Jest shows 60%+ coverage

# Test pre-commit hook
echo "console.log('broken syntax" >> theme/static/js/test.js
git add theme/static/js/test.js
git commit -m "test"
# Expected: Commit blocked ✅

# Clean up
git reset
rm theme/static/js/test.js
```

**Sign-Off:**
- [ ] QA: Coverage report verified
- [ ] Tech Lead: Test quality reviewed
- [ ] DevOps: CI/CD ready

---

### FE-5: Incomplete Image Alt Text (WCAG 1.1.1)

**Definition of Done:**
- [ ] ALL product images have alt text:
  - [ ] `featured_image` → Product name + key features
  - [ ] Thumbnail images → Product name + variant
  - [ ] Gallery images → Descriptive alt text
- [ ] Alt text format: `[Product Name] - [Key Feature 1], [Key Feature 2]`
- [ ] Alt text not duplicated (no excessive repetition)
- [ ] Alt text < 125 characters (best practice)
- [ ] Decorative images: `alt=""` (empty, role="presentation")
- [ ] All template files using product images updated:
  - [ ] `theme/snipplets/product-card-*.tpl`
  - [ ] `theme/templates/product.tpl`
  - [ ] `theme/templates/category.tpl`
  - [ ] `theme/templates/collection.tpl`

**Testing Checklist:**
- [ ] WAVE audit: 0 alt text issues
- [ ] Manual check of all product images:
  - [ ] 100% of product images have alt text
  - [ ] Alt text is meaningful (not "image", "photo", "pic")
  - [ ] Alt text includes product name
  - [ ] Alt text includes key features
- [ ] Screen reader test:
  - [ ] NVDA announces product correctly
  - [ ] VoiceOver announces product correctly
  - [ ] JAWS announces product correctly
- [ ] SEO check:
  - [ ] Alt text includes keywords naturally
  - [ ] Keywords not stuffed
  - [ ] Grammar correct
- [ ] Template coverage:
  - [ ] Product list pages ✅
  - [ ] Product detail pages ✅
  - [ ] Category pages ✅
  - [ ] Search results ✅
  - [ ] Related products ✅

**Quality Gates:**
```bash
[ ] npm run accessibility    # WCAG 1.1.1 PASS
[ ] grep -r 'alt=""' theme/ | grep -v 'role="presentation"'  # 0 results (allow decorative)
[ ] npm test                 # No visual regression
```

**Validation Script:**
```javascript
// Check all images have alt text
const images = document.querySelectorAll('img');
const missingAlt = Array.from(images).filter(img => !img.alt && img.role !== 'presentation');
console.assert(missingAlt.length === 0, `${missingAlt.length} images missing alt text`);

// Check alt text quality
const shortAlt = Array.from(images).filter(img => img.alt && img.alt.length < 10);
console.log(`⚠️ ${shortAlt.length} images with very short alt text`);
```

**Sign-Off:**
- [ ] QA: WAVE audit passing
- [ ] Content Team: Alt text quality verified
- [ ] Accessibility: WCAG 1.1.1 compliant

---

### FE-1: No CSS Variables

**Definition of Done:**
- [ ] CSS custom properties file created: `theme/static/scss/_tokens.scss`
- [ ] All tokens defined:
  - [ ] Colors (primary, secondary, accent, neutral, states)
  - [ ] Spacing (xs, sm, md, lg, xl)
  - [ ] Typography (font family, sizes, weights, line heights)
  - [ ] Shadows
  - [ ] Borders
  - [ ] Transitions/animations
- [ ] All hardcoded values replaced with variables
- [ ] No hardcoded color codes remaining (except in comments)
- [ ] Variables scoped to `:root` (global)
- [ ] Variables used consistently across all SCSS files
- [ ] Fallback values provided for older browsers
- [ ] Variable naming follows convention: `--category-property`

**Testing Checklist:**
- [ ] Visual regression test (Percy):
  - [ ] No visual changes from original
  - [ ] Colors match design system
  - [ ] Spacing consistent
- [ ] CSS validation:
  - [ ] No undefined variables
  - [ ] All variables have valid values
  - [ ] No circular dependencies
- [ ] Browser compatibility:
  - [ ] Chrome 49+ ✅
  - [ ] Firefox 31+ ✅
  - [ ] Safari 9.1+ ✅
  - [ ] Edge 15+ ✅
  - [ ] IE 11: ⚠️ No support (but fallback works)
- [ ] Performance:
  - [ ] Build time unchanged
  - [ ] File size unchanged
  - [ ] No runtime performance impact
- [ ] Maintainability:
  - [ ] Variables easy to find
  - [ ] Documentation complete
  - [ ] Team can update tokens

**Quality Gates:**
```bash
[ ] npm run lint             # SCSS validation
[ ] npm run build            # Build succeeds
[ ] npm test                 # No regressions
[ ] lighthouse               # Score unchanged
[ ] grep -r "color: #" theme/static/scss/ | wc -l  # < 5 (only in comments)
```

**Validation:**
```bash
# Check that variables are defined
grep -c "^[[:space:]]*--" theme/static/scss/_tokens.scss
# Expected: > 30 variables

# Check that old colors are gone
grep -r "color: #[0-9A-Fa-f]" theme/static/scss/ | grep -v "//.*#" | wc -l
# Expected: < 5 (comments only)

# Check CSS output is valid
npm run build
# Expected: Build succeeds, CSS loads in browser
```

**Sign-Off:**
- [ ] QA: Visual regression test passed
- [ ] Design Lead: Tokens match design system
- [ ] Tech Lead: Architecture approved

---

### FE-6: Form Labels Inconsistent

**Definition of Done:**
- [ ] ALL form inputs have associated `<label>` elements
- [ ] Label-input association done via `for` attribute and `id`
- [ ] Form structure semantically correct:
  - [ ] `<form>` wrapper
  - [ ] `<fieldset>` for grouped inputs
  - [ ] `<legend>` for fieldset titles
- [ ] Placeholder text is NOT substitute for label (label required)
- [ ] Error messages associated with inputs (via `aria-describedby`)
- [ ] Required fields marked:
  - [ ] `required` attribute
  - [ ] Visual indicator (asterisk, color)
  - [ ] aria-label: "required"
- [ ] Form validation feedback clear:
  - [ ] Error message visible
  - [ ] Error message associated to field
  - [ ] Error color + icon (not color alone)

**Testing Checklist:**
- [ ] WAVE audit: 0 form labeling issues
- [ ] Keyboard navigation:
  - [ ] Tab through all form fields
  - [ ] Focus order logical
  - [ ] All fields keyboard accessible
  - [ ] Submit button reachable via keyboard
- [ ] Screen reader test:
  - [ ] NVDA announces label + field type
  - [ ] VoiceOver announces label + field type
  - [ ] Error messages announced
  - [ ] Required status announced
- [ ] Visual check:
  - [ ] Labels visible and readable
  - [ ] Labels above or left of input (good UX)
  - [ ] Click label focuses input
- [ ] Mobile test:
  - [ ] Labels visible on mobile
  - [ ] Touch targets large enough (44px+)
  - [ ] No horizontal scroll

**Quality Gates:**
```bash
[ ] npm run accessibility    # No form labeling issues
[ ] grep -r '<input' theme/ | grep -v '<label'  # < 5 (account for hidden inputs)
[ ] npm test                 # No regressions
```

**Validation Template:**
```html
<!-- ✅ CORRECT structure -->
<form>
  <label for="email-input">Email Address <span aria-label="required">*</span></label>
  <input
    type="email"
    id="email-input"
    name="email"
    required
    aria-required="true"
    aria-describedby="email-error">
  <span id="email-error" role="alert" class="error-message">
    ❌ Invalid email format
  </span>
</form>
```

**Sign-Off:**
- [ ] QA: WAVE audit passing
- [ ] UX: Form usability improved
- [ ] Accessibility: WCAG 1.3.1 compliant

---

### FE-7: Color Alone for Status

**Definition of Done:**
- [ ] ALL status indicators include:
  - [ ] Color
  - [ ] Icon (SVG or Unicode symbol)
  - [ ] Text label
- [ ] No reliance on color alone for information
- [ ] Icons accessible:
  - [ ] `aria-hidden="true"` on decorative icons
  - `aria-label` on semantic icons
- [ ] Status states covered:
  - [ ] Success (green + ✓ icon + "Active"/"Approved")
  - [ ] Warning (orange + ⚠️ icon + "Pending"/"Warning")
  - [ ] Error (red + ✗ icon + "Error"/"Failed")
  - [ ] Info (blue + ℹ️ icon + "Info"/"Notice")
  - [ ] Neutral (gray + ○ icon + "Inactive"/"Disabled")
- [ ] All badge, tag, status components updated
- [ ] Consistent icon library used

**Testing Checklist:**
- [ ] WAVE audit: 0 color contrast issues
- [ ] Color-blind simulation:
  - [ ] Deuteranopia (red-green blind) ✅
  - [ ] Protanopia (red-green blind) ✅
  - [ ] Tritanopia (blue-yellow blind) ✅
  - [ ] Achromatic (completely colorblind) ✅
- [ ] Visual regression (Percy):
  - [ ] All status indicators visible
  - [ ] Icons render correctly
  - [ ] Text readable on all backgrounds
- [ ] Accessibility audit:
  - [ ] No issues related to color alone
  - [ ] Icons properly labeled

**Quality Gates:**
```bash
[ ] npm run accessibility    # 0 color-only status issues
[ ] grep -r 'badge--' theme/ | wc -l  # All badges have icons
[ ] npm test                 # No visual regression
```

**Validation Pattern:**
```html
<!-- ✅ CORRECT - Color + Icon + Text -->
<span class="status status--success">
  <svg aria-hidden="true" class="status__icon">
    <use xlink:href="#icon-checkmark"></use>
  </svg>
  <span class="status__text">Active</span>
</span>

<!-- ❌ WRONG - Color only -->
<span class="badge badge--success">Active</span>
```

**Sign-Off:**
- [ ] QA: Color-blind simulation passed
- [ ] Design: Icons approved
- [ ] Accessibility: WCAG 1.4.1 compliant

---

### FE-13: Touch Target Sizes

**Definition of Done:**
- [ ] ALL interactive elements are 44px × 44px minimum (WCAG 2.5.5)
- [ ] Touch targets include padding (not just element size)
- [ ] Spacing between targets: minimum 8px
- [ ] No overlapping touch targets
- [ ] Target size applies to:
  - [ ] Buttons
  - [ ] Links
  - [ ] Form inputs
  - [ ] Checkboxes
  - [ ] Radio buttons
  - [ ] Select dropdowns
  - [ ] Custom controls
- [ ] Mobile viewport tested (< 320px width)
- [ ] Tablet viewport tested (768px width)

**Testing Checklist:**
- [ ] Mobile device testing:
  - [ ] iPhone SE (375px) - smallest modern phone
  - [ ] iPhone 12 (390px)
  - [ ] Android phone (360-412px)
  - [ ] iPad (768px tablet)
- [ ] Tap accuracy test:
  - [ ] Can tap each button without hitting adjacent element
  - [ ] Tall narrow buttons work (like mobile menu)
  - [ ] Small icons work (48px minimum)
- [ ] WCAG audit:
  - [ ] 2.5.5 Touch Target Size: PASS
- [ ] Layout test:
  - [ ] No horizontal scroll required
  - [ ] Page responsive at mobile sizes
  - [ ] Touch targets stack vertically (mobile)

**Quality Gates:**
```bash
[ ] npm run accessibility    # 2.5.5 PASS
[ ] npm run lighthouse -- --mobile  # Mobile score checked
[ ] npm test                 # No layout regression
```

**Validation Script:**
```javascript
// Check all interactive elements meet 44px minimum
const interactives = document.querySelectorAll('button, a, input, select, [role="button"]');
const tooSmall = Array.from(interactives).filter(el => {
  const rect = el.getBoundingClientRect();
  return rect.width < 44 || rect.height < 44;
});
console.assert(tooSmall.length === 0, `${tooSmall.length} elements too small`);
```

**Sign-Off:**
- [ ] QA: Mobile testing passed
- [ ] UX: Touch targets verified on devices
- [ ] Accessibility: WCAG 2.5.5 compliant

---

## PHASE 2: Architecture & Scalability (Weeks 3-4)

### FE-2: No Component Library (Storybook)

**Definition of Done:**
- [ ] Storybook installed and configured
- [ ] 15+ core components documented:
  - [ ] Product Card (variants: standard, minimal, featured)
  - [ ] Search Form
  - [ ] Navigation Menu
  - [ ] Footer Links
  - [ ] Button Styles (primary, secondary, outline, ghost)
  - [ ] Badge Components
  - [ ] Rating Display
  - [ ] Price Display
  - [ ] Category Filter
  - [ ] Sort Dropdown
  - [ ] Pagination
  - [ ] Breadcrumb
  - [ ] Alert/Message
  - [ ] Loading Spinner
  - [ ] Modal/Popup
- [ ] Each component has:
  - [ ] HTML template
  - [ ] Variants/states documented
  - [ ] Usage code example
  - [ ] Props/parameters documented
  - [ ] Accessibility notes
- [ ] Storybook builds successfully
- [ ] Storybook deployed to GitHub Pages or Vercel
- [ ] Team trained on component library

**Testing Checklist:**
- [ ] Storybook builds: `npm run build-storybook`
- [ ] Storybook runs locally: `npm run storybook`
- [ ] All 15+ components render in Storybook
- [ ] Each component has ≥2 stories (states/variants)
- [ ] Documentation readable and complete
- [ ] Deployment successful:
  - [ ] GitHub Pages / Vercel link working
  - [ ] All components visible
  - [ ] Responsive on mobile
- [ ] Team feedback:
  - [ ] Developers find components useful
  - [ ] Onboarding time reduced

**Quality Gates:**
```bash
[ ] npm run storybook           # Runs locally
[ ] npm run build-storybook     # Builds successfully
[ ] npm run lint                # No style issues
[ ] npm test                    # No regressions
```

**Validation:**
```bash
# Count documented components
find stories/ -name "*.stories.js" | wc -l
# Expected: ≥ 15

# Check each component has stories
for file in stories/*.stories.js; do
  grep -c "export const" "$file"
  # Expected: ≥ 2 per file
done
```

**Sign-Off:**
- [ ] QA: All components render correctly
- [ ] Tech Lead: Documentation quality approved
- [ ] Team: Ready to use as reference

---

### FE-12: JS Testing (E2E Tests)

**Definition of Done:**
- [ ] Cypress installed and configured
- [ ] E2E test suite covers critical flows:
  - [ ] Product browsing (search, filter, pagination)
  - [ ] Product detail page (images, reviews, add to cart)
  - [ ] Shopping cart (add, remove, update quantity)
  - [ ] Checkout flow (address, payment, confirmation)
  - [ ] User account (login, profile, orders)
  - [ ] Mobile navigation (menu, filters on mobile)
- [ ] Each test:
  - [ ] Clear description of what it tests
  - [ ] Follows AAA pattern (Arrange, Act, Assert)
  - [ ] Independent (can run in any order)
  - [ ] Deterministic (same result every time)
  - [ ] Fast (< 30 seconds per test)
- [ ] Test data setup (fixtures):
  - [ ] Sample products created
  - [ ] Test user accounts available
  - [ ] Staging database prepared
- [ ] CI/CD integration:
  - [ ] Tests run on every PR
  - [ ] Tests must pass before merge
  - [ ] Results reported in PR
- [ ] Visual regression (optional):
  - [ ] Percy integration configured
  - [ ] Baseline screenshots created
  - [ ] Visual changes detected on CI

**Testing Checklist:**
- [ ] Tests run locally: `npx cypress open`
- [ ] Tests run headless: `npm run test:e2e`
- [ ] All tests pass:
  - [ ] Shopping flow ✅
  - [ ] Product pages ✅
  - [ ] Search ✅
  - [ ] Mobile menu ✅
- [ ] Test environment:
  - [ ] Staging Nuvemshop accessible
  - [ ] Test data consistent
  - [ ] Database reset between test runs
- [ ] Performance:
  - [ ] Full test suite < 15 minutes
  - [ ] No flaky tests (100% pass rate)
  - [ ] No timeout issues
- [ ] Integration with CI:
  - [ ] GitHub Actions runs tests
  - [ ] Notifications on failure
  - [ ] Deployment blocked if tests fail

**Quality Gates:**
```bash
[ ] npm run test:e2e          # All tests pass
[ ] npm run test:e2e -- --headed  # Visual inspection
[ ] cypress check             # Cypress lint
```

**Validation Test:**
```javascript
// Example: Shopping cart E2E test
describe('Shopping Cart', () => {
  it('should add product to cart and checkout', () => {
    cy.visit('/');
    cy.contains('Products').click();
    cy.get('[data-product-id="1"]').first().click();
    cy.contains('Add to Cart').click();
    cy.get('[data-cart-count]').should('have.text', '1');
    cy.visit('/cart');
    cy.contains('Proceed to Checkout').click();
    cy.url().should('include', '/checkout');
  });
});
```

**Sign-Off:**
- [ ] QA: E2E tests comprehensive
- [ ] DevOps: CI/CD integration working
- [ ] Tech Lead: Test strategy approved

---

### SYS-2: Build Pipeline (Webpack)

**Definition of Done:**
- [ ] Webpack installed and configured: `npm install --save-dev webpack webpack-cli`
- [ ] Configuration file created: `webpack.config.js`
- [ ] Build process configured:
  - [ ] Input: `theme/static/scss/` and `theme/static/js/`
  - [ ] Output: `dist/css/` and `dist/js/` (minified)
  - [ ] SCSS compiled to CSS
  - [ ] CSS minified (30-40% reduction)
  - [ ] JavaScript minified (20-30% reduction)
  - [ ] Source maps generated (debugging)
- [ ] Build scripts added to `package.json`:
  - [ ] `npm run build` - Production build
  - [ ] `npm run dev` - Development with hot reload
  - [ ] `npm run watch` - Watch mode for development
- [ ] File optimization:
  - [ ] CSS minified and vendor-prefixed
  - [ ] JavaScript bundled and uglified
  - [ ] Images optimized (if applicable)
  - [ ] No source maps in production
- [ ] Build output tested:
  - [ ] Minified files load in browser
  - [ ] Styling applies correctly
  - [ ] JavaScript functionality unchanged
  - [ ] No console errors or warnings
- [ ] Deployment updated:
  - [ ] Deploy script uses minified files
  - [ ] Original files NOT deployed
  - [ ] Versioning includes build timestamp

**Testing Checklist:**
- [ ] Build succeeds: `npm run build`
- [ ] Build output verified:
  - [ ] Minified CSS created
  - [ ] Minified JS created
  - [ ] Source maps created (but not deployed)
  - [ ] File sizes reduced 20-40%
- [ ] Minified code testing:
  - [ ] CSS loads without errors
  - [ ] Styling applies correctly
  - [ ] JavaScript executes
  - [ ] No console errors
- [ ] Browser compatibility:
  - [ ] Chrome ✅
  - [ ] Firefox ✅
  - [ ] Safari ✅
  - [ ] Edge ✅
- [ ] Development experience:
  - [ ] `npm run dev` works
  - [ ] Hot reload functional
  - [ ] Source maps available for debugging
  - [ ] Build time acceptable (< 30 seconds)

**Quality Gates:**
```bash
[ ] npm run build             # Build succeeds
[ ] npm run lint              # No errors
[ ] npm test                  # All tests pass
[ ] webpack validate          # Config valid
[ ] lighthouse                # Performance improved
```

**Validation Metrics:**
```bash
# Check file size reduction
du -sh dist/css/main.min.css theme/static/css/main.css
# Expected: dist/ ~30-40% smaller

# Check minified JavaScript
du -sh dist/js/main.min.js theme/static/js/main.js
# Expected: dist/ ~20-30% smaller

# Verify no unmapped CSS
grep -r "\.map" dist/
# Expected: No .map files in production build (only in dev)
```

**Sign-Off:**
- [ ] QA: Minified code tested
- [ ] DevOps: Deployment updated
- [ ] Tech Lead: Build config approved

---

### SYS-3: CI/CD Pipeline (GitHub Actions)

**Definition of Done:**
- [ ] GitHub Actions workflow created: `.github/workflows/deploy.yml`
- [ ] Workflow triggers on `push` to `main` branch
- [ ] Workflow steps:
  - [ ] Lint check: `npm run lint`
  - [ ] Type check: `npm run typecheck` (if applicable)
  - [ ] Unit tests: `npm test`
  - [ ] E2E tests: `npm run test:e2e`
  - [ ] Accessibility audit: `npm run a11y`
  - [ ] Build: `npm run build`
  - [ ] Manual approval gate (before deploy)
  - [ ] Deploy to Nuvemshop: FTP via Node script
- [ ] Workflow configuration:
  - [ ] Concurrency limited (sequential deployments)
  - [ ] Secrets configured (FTP credentials)
  - [ ] Environment variables set
  - [ ] Notifications enabled (Slack/email)
- [ ] Deployment safety:
  - [ ] Backup created before deploy
  - [ ] Deployment logged
  - [ ] Rollback link provided
  - [ ] Success/failure notification sent
- [ ] Branch protection rules:
  - [ ] Require PR reviews (1 minimum)
  - [ ] Require status checks passing
  - [ ] Require branches up to date
  - [ ] Include administrators

**Testing Checklist:**
- [ ] Workflow file valid: `npm run validate-workflow`
- [ ] Manual workflow run successful
  - [ ] Lint passes
  - [ ] Tests pass
  - [ ] Build succeeds
  - [ ] Approval prompt appears
- [ ] Approval gate works:
  - [ ] Can review and approve in GitHub UI
  - [ ] Can reject deployment
  - [ ] Comments recorded
- [ ] Deployment successful:
  - [ ] Files deployed to Nuvemshop via FTP
  - [ ] Cache busted
  - [ ] Notification sent
- [ ] Rollback procedure:
  - [ ] Documented in workflow comments
  - [ ] Quick rollback link provided
  - [ ] Team knows how to use it
- [ ] Failure handling:
  - [ ] Lint failure blocks deploy ✅
  - [ ] Test failure blocks deploy ✅
  - [ ] A11y failure blocks deploy ✅
  - [ ] Build failure blocks deploy ✅

**Quality Gates:**
```bash
[ ] .github/workflows/deploy.yml exists
[ ] github actions validate .github/workflows/deploy.yml
[ ] Test workflow run successful
```

**Validation Workflow:**
```yaml
name: Deploy CI/CD

on:
  push:
    branches: [main]

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: npm ci
      - run: npm run lint
      - run: npm test
      - run: npm run test:e2e
      - run: npm run build

  deploy:
    needs: check
    runs-on: ubuntu-latest
    environment: production  # Manual approval required
    steps:
      - uses: actions/checkout@v2
      - run: npm ci
      - run: npm run deploy
        env:
          FTP_HOST: ${{ secrets.FTP_HOST }}
          FTP_USER: ${{ secrets.FTP_USER }}
          FTP_PASS: ${{ secrets.FTP_PASS }}
```

**Sign-Off:**
- [ ] DevOps: Workflow tested
- [ ] Tech Lead: Configuration reviewed
- [ ] Team: Training completed

---

### SYS-4: Design System

**Definition of Done:**
- [ ] Design system documentation:
  - [ ] `docs/design-system/principles.md` - Design philosophy
  - [ ] `docs/design-system/colors.md` - Color palette with examples
  - [ ] `docs/design-system/typography.md` - Font hierarchy
  - [ ] `docs/design-system/spacing.md` - Layout grid and spacing
  - [ ] `docs/design-system/components.md` - Component taxonomy
  - [ ] `docs/design-system/patterns.md` - Interaction patterns
- [ ] Component consolidation (Phase 2b-2c):
  - [ ] Unified product card component
  - [ ] Unified form component library
  - [ ] Unified navigation components
  - [ ] Unified modal/popup components
- [ ] CSS token system:
  - [ ] Colors centralized in `_tokens.scss`
  - [ ] Spacing standardized
  - [ ] Typography variables defined
- [ ] Component variations:
  - [ ] Each component has clear variations documented
  - [ ] Accessibility built-in
  - [ ] Mobile responsiveness included
- [ ] Team knowledge:
  - [ ] Design system training completed
  - [ ] Guidelines understood and followed
  - [ ] Future components follow pattern

**Testing Checklist:**
- [ ] Documentation complete:
  - [ ] All documents written
  - [ ] Examples provided
  - [ ] Team reviewed and approved
- [ ] Component consolidation:
  - [ ] Old and new components co-exist (no breaking changes)
  - [ ] Templates updated to use new components
  - [ ] Visual regression testing passed
  - [ ] No layout shifts
- [ ] Consistency audit:
  - [ ] All colors use tokens
  - [ ] All spacing uses grid values
  - [ ] Typography follows system
  - [ ] No style duplication
- [ ] Team feedback:
  - [ ] Design system meets team needs
  - [ ] Easy to reference
  - [ ] Fast to implement new components

**Quality Gates:**
```bash
[ ] Design system docs complete
[ ] npm test                 # No visual regressions
[ ] npm run lighthouse       # Score maintained
[ ] grep -r 'color: #' theme/static/scss/ | wc -l  # < 5
```

**Sign-Off:**
- [ ] QA: Component consolidation tested
- [ ] Design Lead: System approved
- [ ] Tech Lead: Architecture validated

---

## PHASE 3: Performance Optimization (Weeks 5-6)

### FE-9: Image Optimization

**Definition of Done:**
- [ ] WebP format support added
- [ ] Responsive images implemented
- [ ] Image optimization:
  - [ ] Product images: 400px, 600px, 1200px widths
  - [ ] Thumbnail images: 100px, 200px widths
  - [ ] Banner images: 600px, 1200px widths
- [ ] Picture element with fallback:
  ```html
  <picture>
    <source type="image/webp" srcset="...">
    <img src="..." alt="...">
  </picture>
  ```
- [ ] Lazy loading implemented:
  - [ ] `loading="lazy"` attribute on below-fold images
  - [ ] Nuvemshop JavaScript bridge for dynamic images
- [ ] Image file sizes:
  - [ ] WebP 50% smaller than JPG
  - [ ] No quality loss visible
- [ ] Liquid filters optimized:
  - [ ] Uses Nuvemshop image service
  - [ ] Correct dimensions requested
  - [ ] Format parameter set to "webp"

**Testing Checklist:**
- [ ] WebP format:
  - [ ] Browser support verified (Chrome, Firefox, Safari, Edge)
  - [ ] Fallback to JPG works
  - [ ] IE 11: falls back to JPG gracefully
- [ ] Image dimensions:
  - [ ] Mobile: 400px width ✅
  - [ ] Tablet: 600px width ✅
  - [ ] Desktop: 1200px width ✅
  - [ ] Correct image served per device
- [ ] Lazy loading:
  - [ ] Below-fold images load on scroll
  - [ ] Performance improvement visible
  - [ ] No visual shift on load
- [ ] Lighthouse audit:
  - [ ] LCP improved (target: < 2s)
  - [ ] CLS stable (target: < 0.1)
  - [ ] FCP improved
- [ ] File size audit:
  - [ ] Images 40-60% smaller (WebP benefit)
  - [ ] Page load faster
  - [ ] Bandwidth usage reduced

**Quality Gates:**
```bash
[ ] npm run lighthouse -- --mobile
[ ] grep -c 'picture' theme/snipplets/  # All images use picture tag
[ ] npm test                             # No visual regression
```

**Validation Script:**
```javascript
// Check WebP format usage
const images = document.querySelectorAll('img');
const hasWebP = Array.from(images).every(img => {
  const picture = img.parentElement;
  return picture && picture.tagName === 'PICTURE';
});
console.assert(hasWebP, 'Not all images use picture tag');

// Check lazy loading
const lazyImages = document.querySelectorAll('img[loading="lazy"]');
console.log(`✅ ${lazyImages.length} images use lazy loading`);
```

**Sign-Off:**
- [ ] QA: WebP format tested
- [ ] DevOps: File sizes verified
- [ ] Performance: Lighthouse approved

---

### FE-11: Lighthouse 85+ Score

**Definition of Done:**
- [ ] Lighthouse score targets:
  - [ ] Mobile: 85+ (all pages)
  - [ ] Desktop: 90+ (bonus)
- [ ] Core Web Vitals targets:
  - [ ] LCP: < 2.5s mobile, < 1.2s desktop
  - [ ] FID: < 100ms
  - [ ] CLS: < 0.1
- [ ] Performance improvements:
  - [ ] Images optimized (FE-9)
  - [ ] CSS minified (SYS-2)
  - [ ] JavaScript minified (SYS-2)
  - [ ] Fonts optimized (font-display: swap)
  - [ ] Critical CSS inlined
  - [ ] Unused CSS removed
  - [ ] JavaScript deferred/lazy loaded
- [ ] Browser rendering optimized:
  - [ ] No render-blocking resources
  - [ ] Minimal layout shifts
  - [ ] Smooth animations (60fps)
- [ ] Each page category tested:
  - [ ] Homepage
  - [ ] Category page
  - [ ] Product detail page
  - [ ] Shopping cart
  - [ ] Checkout page

**Testing Checklist:**
- [ ] Lighthouse audit run on:
  - [ ] Mobile device (4G throttling)
  - [ ] Desktop (default)
  - [ ] All major page types
- [ ] Core Web Vitals:
  - [ ] LCP measured: < 2.5s mobile
  - [ ] FID measured: < 100ms
  - [ ] CLS measured: < 0.1
- [ ] Performance budget:
  - [ ] JavaScript: < 200KB minified
  - [ ] CSS: < 50KB minified
  - [ ] Images: < 500KB per page (lazy loaded)
- [ ] Real-world testing:
  - [ ] WebPageTest audit
  - [ ] Chrome DevTools Lighthouse
  - [ ] PageSpeed Insights
- [ ] Monitor ongoing:
  - [ ] Lighthouse CI integrated
  - [ ] Score tracked over time
  - [ ] Regressions detected

**Quality Gates:**
```bash
[ ] npm run lighthouse -- --mobile
# Expected output: Score ≥ 85

[ ] npm run lighthouse -- --desktop
# Expected output: Score ≥ 90

[ ] npm run lighthouse:ci
# Check if score regressed
```

**Validation Metrics:**
```bash
# Check performance scores
npm run lighthouse -- https://staging.patagang.com/ --desktop

# Should show:
# Performance: 90+
# Accessibility: 95+
# Best Practices: 95+
# SEO: 95+
```

**Sign-Off:**
- [ ] QA: Lighthouse 85+ verified
- [ ] Performance Team: Core Web Vitals approved
- [ ] DevOps: Performance budget monitored

---

## PHASE 4: Polish & Maintenance (Weeks 7-8)

### FE-8: Reduced Motion Support

**Definition of Done:**
- [ ] `prefers-reduced-motion` media query implemented
- [ ] All animations respect user preference:
  - [ ] Transitions: disabled if `prefers-reduced-motion: reduce`
  - [ ] Animations: disabled if preference set
  - [ ] Page changes: no animation if preference set
- [ ] Fallback behavior:
  - [ ] Content still visible without animations
  - [ ] Functionality unchanged
  - [ ] No confusion from instant transitions

**Testing Checklist:**
- [ ] OS settings:
  - [ ] macOS: System Preferences → Accessibility → Reduce Motion → On
  - [ ] Windows: Settings → Ease of Access → Display → Show animations → Off
  - [ ] iPhone: Settings → Accessibility → Motion → Reduce Motion → On
  - [ ] Android: Developer Options → Animation Scale → 0x
- [ ] Visual verification:
  - [ ] With motion: animations smooth
  - [ ] Without motion: no animations, instant changes
  - [ ] Content accessible either way

**Quality Gates:**
```bash
[ ] npm test                 # No regressions
[ ] npm run accessibility    # Still compliant
```

**Sign-Off:**
- [ ] QA: Reduced motion verified
- [ ] Accessibility: WCAG 2.3.3 best practice

---

### FE-10: Mobile Menu UX Polish

**Definition of Done:**
- [ ] Menu interactions improved:
  - [ ] Smooth open/close animation
  - [ ] Click item closes menu
  - [ ] Click outside closes menu
  - [ ] Escape key closes menu
- [ ] Mobile-specific UX:
  - [ ] Touch-friendly interaction areas
  - [ ] Visual feedback on tap
  - [ ] No jank on open/close
  - [ ] Proper z-index stacking
- [ ] Accessibility:
  - [ ] Keyboard navigation (Tab, Enter, Escape)
  - [ ] Screen reader friendly
  - [ ] Focus management correct

**Testing Checklist:**
- [ ] Mobile device testing:
  - [ ] Tap menu icon opens
  - [ ] Tap menu item closes menu
  - [ ] Tap outside closes menu
  - [ ] Smooth animation
  - [ ] No layout shift
- [ ] Desktop testing:
  - [ ] Menu still works on hover
  - [ ] Keyboard navigation works
  - [ ] No double-firing
- [ ] Performance:
  - [ ] No jank (60fps animations)
  - [ ] No memory leaks
  - [ ] No console errors

**Sign-Off:**
- [ ] QA: Mobile menu UX verified
- [ ] UX Lead: Polish approved

---

### SYS-5: JS Modules (Optional if time permits)

**Definition of Done:**
- [ ] JavaScript modules created using IIFE pattern
- [ ] Module structure:
  - [ ] `utils/` - Utility functions
  - [ ] `components/` - Component modules
  - [ ] `index.js` - Entry point
- [ ] Module patterns:
  - [ ] Encapsulation (private variables)
  - [ ] Public API (exported functions)
  - [ ] No global scope pollution
- [ ] Each module tested independently
- [ ] Integration testing for module interactions

**Testing Checklist:**
- [ ] npm test: Module tests pass
- [ ] Browser: No console errors
- [ ] Functionality: All features work
- [ ] Performance: No regression

**Sign-Off:**
- [ ] QA: Module tests passing
- [ ] Tech Lead: Architecture approved

---

## Final Sign-Off Template

```
═══════════════════════════════════════════════════════
  PHASE [X] COMPLETION SIGN-OFF
═══════════════════════════════════════════════════════

Date: 2026-MM-DD
Reviewed By: [Name] / [Name]

✅ All acceptance criteria met
✅ All quality gates passing
✅ Testing checklist complete
✅ No blockers or concerns

Debts Completed:
  [ ] Item 1: Description
  [ ] Item 2: Description
  [ ] Item 3: Description

Known Issues:
  (None | List any minor issues found)

Comments:
  (Additional notes)

─────────────────────────────────────────────────────
QA Review:     ________________  Date: __________
Tech Lead:     ________________  Date: __________
Product Lead:  ________________  Date: __________
═══════════════════════════════════════════════════════
```

---

## Document Control

| Field | Value |
|-------|-------|
| **Created** | 2026-03-15 |
| **Purpose** | Detailed acceptance criteria for all 21 debts |
| **Audience** | QA, Developers, Tech Leads |
| **Updated** | Updated per phase completion |
| **Status** | ACTIVE - Use throughout implementation |

