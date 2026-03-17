# Nuvemshop Validation Matrix - Technical Debt Assessment

**Project:** Patagang E-commerce (Nuvemshop)
**Assessment Date:** 2026-03-15
**Purpose:** Validate 21 technical debt items against Nuvemshop platform limitations
**Status:** CRITICAL REVIEW - Production Safety Assessment

---

## Platform Constraints Reference

### Known Nuvemshop Limitations

| Constraint | Details | Impact |
|-----------|---------|--------|
| **Database Management** | Nuvemshop manages all data (products, orders, customers, analytics) | ❌ NO custom database access or modifications |
| **Backend API** | Limited Nuvemshop API (no custom backend) | ❌ NO Node.js, no custom services |
| **Theme Only** | Deployment = theme upload via FTP | ✅ Frontend/theme only |
| **Template Language** | Liquid + SCSS + JavaScript only | ✅ No frameworks, no build process |
| **CSS Compilation** | SCSS compiled server-side with server-side cache | ⚠️ Cache invalidation required |
| **JavaScript** | Vanilla ES5/ES6, no module system, no build tools | ⚠️ No bundling, limited optimization |
| **Plugin System** | Only Nuvemshop "Apps" (SaaS), no 3rd-party plugins | ❌ Cannot extend via plugins |
| **Cache Strategy** | Server-side caching on `style-async.scss.tpl` | ⚠️ Cache buster needed |
| **FTP Deployment** | Manual versioning, no automatic rollback | ⚠️ Requires manual backup/restore |
| **Build Tools** | No webpack/vite/rollup support | ❌ NO build pipeline at Nuvemshop level |

---

## Debt Validation Matrix

### CRITICAL DEBTS (Must Fix First)

#### 1. **SYS-1: CSS Server-Side Caching Issues**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | SYS-1 |
| **Type** | System/Infrastructure |
| **Severity** | CRITICAL |
| **Effort** | 12-16h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES |
| **Scope** | Theme only (layout.tpl override) |
| **Risk Level** | LOW |

**Problem:**
- `style-async.scss.tpl` is compiled and cached server-side by Nuvemshop
- CSS changes don't reflect until cache is cleared
- Current workaround: use `layout.tpl` override (fragile)

**Implementation Details:**
```
SAFE TO IMPLEMENT - This is purely frontend tooling

Actions:
1. Document Nuvemshop cache invalidation process
2. Implement version ID system in layout.tpl (e.g., ?v=20260315)
3. Create cache-busting headers in deployment script
4. Test cache clearing procedure manually
```

**Why It's Safe:**
- ✅ Only modifies theme files (layout.tpl, CSS override)
- ✅ Zero database/backend changes
- ✅ Zero API dependencies
- ✅ CSS layers are managed entirely in theme
- ✅ Rollback: revert layout.tpl

**Potential Impacts:**
- ℹ️ Development iteration slower until cache strategy documented
- ℹ️ No impact on production store functionality
- ℹ️ Requires manual QA after each CSS change

**Rollback Procedure:**
```
1. Revert layout.tpl to previous version (git checkout)
2. Redeploy via FTP
3. Clear browser cache (Cmd+Shift+Del)
4. Test in incognito window
```

**Status:** ✅ **SAFE** - Proceed immediately

---

#### 2. **FE-4: Focus Indicators Missing (WCAG 2.4.7 Failure)**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-4 |
| **Type** | Accessibility/Frontend |
| **Severity** | CRITICAL |
| **Effort** | 2-4h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES (100% backward compatible) |
| **Scope** | CSS only (theme/static/css/) |
| **Risk Level** | NONE |

**Problem:**
- No `:focus-visible` CSS rules
- Keyboard-only users cannot see focus
- WCAG 2.4.7 failure = legal accessibility risk

**Implementation:**
```scss
/* Add to theme/static/css/accessibility.css */
:focus-visible {
  outline: 3px solid var(--color-primary, #FF6B35);
  outline-offset: 2px;
  border-radius: 2px;
}

button:focus-visible,
a:focus-visible,
input:focus-visible,
select:focus-visible,
textarea:focus-visible {
  box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.3);
}
```

**Why It's Safe:**
- ✅ Pure CSS addition - no behavior changes
- ✅ Adds visual feedback only
- ✅ Zero JavaScript involved
- ✅ Zero database/API impact
- ✅ Keyboard navigation unchanged
- ✅ Touch interaction unaffected
- ✅ WCAG AA compliant

**Potential Impacts:**
- ℹ️ Visual change for keyboard users (DESIRED)
- ℹ️ No impact on non-keyboard users
- ℹ️ No performance impact

**Validation:**
```
Testing Required:
[ ] Tab through all interactive elements
[ ] Verify outline visible on every focusable element
[ ] Test on Chrome, Firefox, Safari
[ ] Verify outline doesn't obscure content
```

**Rollback Procedure:**
```
git revert <commit-hash>
Deploy via FTP
```

**Status:** ✅ **SAFE** - Highest priority, implement first

---

#### 3. **SYS-7: Auto Tests Setup (Unit Tests)**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | SYS-7 |
| **Type** | Testing/Infrastructure |
| **Severity** | CRITICAL |
| **Effort** | 24-40h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES (build process only) |
| **Scope** | Development environment (no theme changes) |
| **Risk Level** | NONE |

**Problem:**
- Zero unit tests
- Regressions escape to production
- Can't refactor safely

**Implementation Strategy:**
```
SAFE - Runs locally only, zero Nuvemshop impact

Phase 1 (SYS-7 - Week 1):
1. Install Jest + jsdom
   npm install --save-dev jest @testing-library/dom jsdom

2. Create test infrastructure:
   - jest.config.js (local only)
   - test utilities for Liquid template testing
   - Mock Nuvemshop variables

3. Write critical module tests:
   - theme/static/js/cart.js
   - theme/static/js/filters.js
   - theme/static/js/search.js
   Target: 60% coverage

4. Configure pre-commit hooks:
   npm install --save-dev husky
   - Run tests before commit
   - Prevent broken code from being committed
```

**Why It's Safe:**
- ✅ Pure development infrastructure (local only)
- ✅ No changes to theme files initially
- ✅ Tests run in Node.js environment
- ✅ Zero impact on deployed theme
- ✅ Optional for developers (can skip)
- ✅ Pre-commit hooks prevent accidental commits only

**Potential Impacts:**
- ℹ️ Slightly slower development setup (npm install)
- ℹ️ Pre-commit hooks add 5-10 seconds per commit
- ℹ️ Initially time-consuming to write tests
- ℹ️ Long-term: 30-40% faster debugging
- ℹ️ ZERO impact on production

**Dependency Conflicts:**
- ✅ Jest + jsdom are industry standard
- ✅ Compatible with vanilla JavaScript
- ✅ No conflicts with FTP deployment
- ✅ Package.json stays local (not deployed)

**Validation:**
```
[ ] npm test runs successfully
[ ] Pre-commit hooks work
[ ] Tests pass before deployment
[ ] Coverage report generated
[ ] CI/CD integration ready (Phase 2)
```

**Rollback Procedure:**
```
Remove test files and package.json entries:
rm -rf tests/
npm uninstall jest @testing-library/dom jsdom husky
rm .husky pre-commit
```

**Status:** ✅ **SAFE** - No theme changes, development-only infrastructure

---

#### 4. **FE-12: JS Testing (E2E Tests)**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-12 |
| **Type** | Testing/QA |
| **Severity** | CRITICAL |
| **Effort** | 16-24h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES (QA infrastructure only) |
| **Scope** | Development environment (external browser testing) |
| **Risk Level** | NONE |

**Problem:**
- Zero E2E tests
- JavaScript bugs escape to production
- Can't validate user flows

**Implementation Strategy:**
```
SAFE - Runs against deployed site, no code changes required

Phase 2 (FE-12 - Week 3):
1. Install Cypress
   npm install --save-dev cypress

2. Create E2E test suite:
   - tests/e2e/shopping-flow.spec.js
   - tests/e2e/product-detail.spec.js
   - tests/e2e/checkout.spec.js
   Target: Critical user paths only

3. Configure visual regression testing:
   npm install --save-dev @percy/cypress
   Integration with Percy Cloud (optional)

4. Integrate with CI/CD:
   GitHub Actions workflow to run tests on each PR
```

**Why It's Safe:**
- ✅ Tests run against live Nuvemshop URLs
- ✅ Zero code changes to theme
- ✅ E2E tests verify user behavior (read-only)
- ✅ No modification to Nuvemshop data
- ✅ Can be run against staging environment
- ✅ Cypress browser automation is isolated

**Potential Impacts:**
- ℹ️ E2E tests take 10-15 minutes per run
- ℹ️ Requires Cypress installation (~500MB)
- ℹ️ Percy Cloud optional (visual regression)
- ℹ️ No impact on production performance
- ℹ️ CI/CD runs add 15 min to deployment

**Non-Breaking Validation:**
- ✅ E2E tests are read-only operations
- ✅ Tests verify existing functionality
- ✅ Do NOT modify store data
- ✅ Do NOT interact with payment system
- ✅ Safe to run against production (with caution)

**Validation:**
```
[ ] Cypress tests run against staging
[ ] All critical flows pass
[ ] Visual regression baseline established
[ ] CI/CD integration tested
[ ] Performance impact acceptable
```

**Rollback Procedure:**
```
rm -rf tests/e2e/
npm uninstall cypress @percy/cypress
rm .github/workflows/e2e.yml
```

**Status:** ✅ **SAFE** - No code changes, external testing infrastructure

---

### HIGH PRIORITY DEBTS (Phase 1-2)

#### 5. **FE-5: Incomplete Image Alt Text (WCAG 1.1.1)**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-5 |
| **Type** | Accessibility/Content |
| **Severity** | HIGH |
| **Effort** | 4-6h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES (100% SEO+ benefit) |
| **Scope** | Theme templates only |
| **Risk Level** | NONE |

**Problem:**
- Product images have name only
- Missing key features in alt text
- WCAG 1.1.1 failure + SEO impact

**Implementation:**
```liquid
<!-- Update in theme/snipplets/product-card-*.tpl -->

<!-- BEFORE -->
<img src="{{ product.featured_image }}" alt="{{ product.name }}">

<!-- AFTER -->
<img
  src="{{ product.featured_image }}"
  alt="{{ product.name }} - {{ product.description_short | strip_html | truncate: 50 }}">
```

**Why It's Safe:**
- ✅ Pure HTML content change
- ✅ No functionality impact
- ✅ Nuvemshop variables are available
- ✅ Text-only change
- ✅ Screen reader improvement (WCAG compliant)
- ✅ Better SEO (Google loves descriptive alt text)

**Potential Impacts:**
- ✅ POSITIVE: WCAG 1.1.1 compliance
- ✅ POSITIVE: Better SEO ranking
- ✅ POSITIVE: Screen reader compatibility
- ℹ️ NEUTRAL: No visual change
- ℹ️ NEUTRAL: No performance impact

**Validation:**
```
[ ] Run accessibility audit (WAVE extension)
[ ] Verify all product images have alt text
[ ] Screen reader test (NVDA, VoiceOver)
[ ] Check alt text quality (meaningful, not duplicated)
```

**Rollback Procedure:**
```
git revert <commit-hash>
Redeploy via FTP
```

**Status:** ✅ **SAFE** - Immediate implementation, WCAG critical

---

#### 6. **FE-1: No CSS Variables**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-1 |
| **Type** | Frontend/CSS |
| **Severity** | HIGH |
| **Effort** | 6-8h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES |
| **Scope** | CSS files only |
| **Risk Level** | LOW |

**Problem:**
- Colors/spacing hardcoded across files
- Difficult to maintain branding
- No design system tokens

**Implementation:**
```css
/* Create theme/static/css/tokens.css */

:root {
  /* Colors */
  --color-primary: #FF6B35;
  --color-secondary: #004E89;
  --color-accent: #F7B801;
  --color-success: #06A77D;
  --color-error: #D62828;
  --color-neutral-50: #F9F9F9;
  --color-neutral-900: #1A1A1A;

  /* Spacing */
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 16px;
  --space-lg: 24px;
  --space-xl: 32px;

  /* Typography */
  --font-family-sans: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
  --font-size-xs: 12px;
  --font-size-sm: 14px;
  --font-size-md: 16px;
  --font-size-lg: 18px;
}
```

**Why It's Safe:**
- ✅ Pure CSS variable definition
- ✅ Backward compatible (custom properties fallback)
- ✅ No HTML changes
- ✅ No JavaScript impact
- ✅ Nuvemshop supports CSS custom properties
- ✅ Progressive enhancement

**Potential Impacts:**
- ✅ POSITIVE: Easier branding changes
- ✅ POSITIVE: Consistency across components
- ✅ POSITIVE: Maintenance time reduced 20-30%
- ℹ️ MINIMAL: 0 performance impact
- ℹ️ MINIMAL: Old browsers fallback to hardcoded values

**Browser Support:**
- ✅ Chrome 49+ (all modern browsers)
- ⚠️ IE 11 not supported (custom properties fallback)
- ℹ️ Nuvemshop typically serves modern browsers

**Validation:**
```
[ ] CSS tokenization complete
[ ] All hardcoded colors replaced
[ ] All spacing values replaced
[ ] Visual regression test (Percy)
[ ] Performance audit (unchanged)
```

**Rollback Procedure:**
```
git revert <commit-hash>
Redeploy via FTP
```

**Status:** ✅ **SAFE** - High ROI, zero breaking changes

---

#### 7. **FE-2: No Component Library**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-2 |
| **Type** | Documentation/Frontend |
| **Severity** | MEDIUM |
| **Effort** | 16-24h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES (documentation only) |
| **Scope** | Development infrastructure (local only) |
| **Risk Level** | NONE |

**Problem:**
- 80+ snippets with no documentation
- Difficult onboarding
- Inconsistent component patterns

**Implementation:**
```
SAFE - Documentation infrastructure, no code changes

Phase 2 (Week 3):
1. Install Storybook for static HTML
   npm install --save-dev @storybook/html

2. Document top 15 components:
   - Product Card (variations)
   - Search Form
   - Navigation Menu
   - Footer Links
   - Button styles
   - Badge components
   - Rating display
   - Price display
   - Category filter
   - Sort dropdown
   - Pagination
   - Breadcrumb
   - Alert/Message
   - Loading spinner
   - Modal/Popup

3. Create stories (HTML templates):
   stories/ProductCard.stories.js
   stories/SearchForm.stories.js
   etc.

4. Deploy to static hosting:
   npm run build-storybook
   Deploy to GitHub Pages or Vercel (free)
```

**Why It's Safe:**
- ✅ Zero changes to theme files
- ✅ Local documentation infrastructure
- ✅ Storybook is read-only HTML preview
- ✅ No impact on deployed site
- ✅ Optional for developers
- ✅ Versioned in git, not deployed

**Potential Impacts:**
- ℹ️ Documentation adds 5-10 minutes per component initially
- ℹ️ Onboarding time reduced 50% for new team members
- ℹ️ Development velocity increases over time
- ℹ️ ZERO impact on production

**Non-Breaking Validation:**
- ✅ Storybook is external documentation
- ✅ Does not modify theme files
- ✅ Does not affect Nuvemshop functionality
- ✅ Can be deployed separately

**Validation:**
```
[ ] Storybook builds successfully
[ ] 15+ components documented
[ ] Stories render correctly
[ ] Component variations shown
[ ] Dev team trained
```

**Rollback Procedure:**
```
rm -rf stories/ storybook-static/
npm uninstall @storybook/html
```

**Status:** ✅ **SAFE** - Documentation infrastructure, high long-term ROI

---

#### 8. **SYS-2: No Build Pipeline**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | SYS-2 |
| **Type** | Infrastructure/Build |
| **Severity** | MEDIUM |
| **Effort** | 16-24h |
| **Nuvemshop Compatible?** | ⚠️ CAUTION |
| **Non-Breaking?** | ✅ YES (optional optimization) |
| **Scope** | Local build process only |
| **Risk Level** | LOW |

**Problem:**
- SCSS compiled server-side only
- No local optimization
- Can't minify/bundle JavaScript
- All builds go to production

**Implementation Strategy:**
```
REQUIRES CAREFUL PLANNING - Local build only

Phase 2 (Week 3):
1. Create local build with Webpack/Vite
   npm install --save-dev webpack webpack-cli sass

2. Configure webpack.config.js:
   - Input: theme/static/scss/
   - Output: theme/static/css/ (minified)
   - Minify CSS and JavaScript
   - Source maps for debugging

3. Create build process:
   npm run build  # Build for production
   npm run dev    # Watch mode development

4. Workflow:
   - Develop locally with hot reload
   - Build produces minified CSS/JS
   - Deploy minified files to Nuvemshop
```

**Critical Constraint - Nuvemshop SCSS Compilation:**
```
⚠️ IMPORTANT: Do NOT replace Nuvemshop's server-side SCSS compilation!

Nuvemshop compiles style-*.scss.tpl files server-side.
Your local build can:
  ✅ Minify theme/static/css/ (regular CSS)
  ✅ Minify theme/static/js/ (JavaScript)
  ✅ Concatenate files for fewer HTTP requests
  ❌ CANNOT modify style-*.scss.tpl (Nuvemshop owns these)

Solution: Dual compilation strategy
1. Nuvemshop compiles: style-async.scss.tpl → CSS
2. Your build process: theme/static/*.css → minified.css
3. Deploy both to Nuvemshop
```

**Why It's Safe:**
- ✅ Local build runs on developer machine
- ✅ Zero impact on Nuvemshop server
- ✅ Minified files are just optimized CSS/JS
- ✅ Functionality unchanged
- ✅ Optional (can deploy non-minified if needed)
- ✅ Respects Nuvemshop's SCSS compilation

**Potential Impacts:**
- ✅ POSITIVE: File sizes reduced 20-40%
- ✅ POSITIVE: Page load faster
- ✅ POSITIVE: Developer experience improved
- ℹ️ NEUTRAL: Build adds ~2 seconds per deploy
- ⚠️ CAUTION: Minified files harder to debug

**Non-Breaking Validation:**
- ✅ Minified CSS is functionally identical
- ✅ Minified JavaScript behaves the same
- ✅ Source maps available for debugging
- ✅ Can disable minification if issues arise

**Validation:**
```
[ ] Build runs successfully
[ ] Minified files load in browser
[ ] Visual regression testing (Percy)
[ ] JavaScript functionality unchanged
[ ] Performance improvement verified (Lighthouse)
```

**Rollback Procedure:**
```
git revert webpack changes
rm -rf dist/
Deploy non-minified files to Nuvemshop
```

**Status:** ⚠️ **CAUTION** - Safe but requires Nuvemshop constraint awareness

---

#### 9. **SYS-3: No CI/CD Pipeline**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | SYS-3 |
| **Type** | DevOps/Deployment |
| **Severity** | MEDIUM |
| **Effort** | 12-16h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES |
| **Scope** | GitHub Actions workflow (external) |
| **Risk Level** | LOW |

**Problem:**
- Manual FTP deploy with Node scripts
- No safety gates before deploy
- No automated testing before production

**Implementation Strategy:**
```
SAFE - GitHub Actions runs externally, doesn't modify Nuvemshop

Phase 2 (Week 3):
1. Create GitHub Actions workflow:
   .github/workflows/deploy.yml

2. Workflow pipeline:
   Push to main branch
   ├─ Run lint (npm run lint)
   ├─ Run tests (npm test)
   ├─ Run a11y audit (axe-core)
   ├─ Build assets (webpack)
   ├─ Manual approval required
   └─ Deploy to Nuvemshop (FTP)

3. Safety gates:
   - Tests must pass
   - Lint errors block deployment
   - Accessibility audit runs automatically
   - Manual review before FTP deploy

4. Configuration:
   - Secrets stored in GitHub (FTP credentials)
   - Deployment logs captured
   - Rollback link in approval message
```

**Why It's Safe:**
- ✅ GitHub Actions is external to Nuvemshop
- ✅ Workflow only runs linting, testing, building
- ✅ Manual approval required before FTP
- ✅ FTP credentials encrypted in GitHub
- ✅ No automatic pushes (requires approval)
- ✅ Deployments still go through FTP (same as before)
- ✅ Can be disabled if issues arise

**Potential Impacts:**
- ✅ POSITIVE: Bugs caught before production
- ✅ POSITIVE: Quality improved 30-40%
- ✅ POSITIVE: Deployment confidence increased
- ✅ POSITIVE: Audit trail for compliance
- ℹ️ NEUTRAL: ~5 minutes added to deployment time
- ℹ️ NEUTRAL: Requires GitHub.com account

**Non-Breaking Validation:**
- ✅ CI/CD checks don't modify code
- ✅ Manual approval prevents accidental deployments
- ✅ FTP deploy is identical to current process
- ✅ Can use old manual process as fallback

**Secrets Management:**
```
GitHub Actions encrypted secrets:
FTP_HOST      = (encrypted)
FTP_USER      = (encrypted)
FTP_PASSWORD  = (encrypted)

Security best practices:
- Secrets only available to GitHub Actions
- Not visible in logs
- Rotation recommended quarterly
```

**Validation:**
```
[ ] GitHub Actions workflow runs successfully
[ ] Lint check passes
[ ] Tests pass
[ ] Build succeeds
[ ] Manual approval works
[ ] FTP deployment completes
```

**Rollback Procedure:**
```
If CI/CD breaks deployments:
1. Disable workflow: .github/workflows/deploy.yml
2. Use manual deploy script: npm run deploy (existing)
3. Re-enable after fix
```

**Status:** ✅ **SAFE** - High ROI, external infrastructure, manual controls

---

#### 10. **SYS-4: No Design System**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | SYS-4 |
| **Type** | Design/Architecture |
| **Severity** | MEDIUM |
| **Effort** | 20-32h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES (documentation + refactoring) |
| **Scope** | Theme structure + documentation |
| **Risk Level** | MEDIUM |

**Problem:**
- Design pattern duplication
- Inconsistent component structure
- Difficult to scale

**Implementation Strategy:**
```
MODERATE COMPLEXITY - Requires refactoring of theme components

Phase 2 (Extended - 3-4 weeks):

1. Design System Documentation (8-12h):
   docs/design-system/
   ├── principles.md (design philosophy)
   ├── colors.md (color palette)
   ├── typography.md (font hierarchy)
   ├── spacing.md (layout grid)
   ├── components.md (component taxonomy)
   └── patterns.md (interaction patterns)

2. Component Refactoring (12-20h):
   Group similar components:
   ├── Cards (product, category, blog)
   ├── Forms (inputs, selects, buttons)
   ├── Navigation (menu, breadcrumb, pagination)
   ├── Modals (login, newsletter, alerts)
   ├── Media (images, videos, galleries)
   └── Info Display (badges, tags, ratings)

3. Standardize naming:
   OLD: product-card-v2.tpl, item-card.tpl, pg-card.tpl
   NEW: components/ProductCard.tpl (single source of truth)

4. Create shared utilities:
   theme/static/css/_utilities.scss
   (spacing, colors, typography)
```

**Critical Implementation Warning:**
```
⚠️ REFACTORING RISK: Component consolidation can break templates

Risk Areas:
1. Product card variants (v1, v2, v3 co-exist)
   - Some templates reference old files
   - Consolidation requires template audit

2. CSS class duplication
   - .item-product and .pg-card do same thing
   - Consolidation can break style precedence

3. Snippet dependencies
   - Some snippets call other snippets
   - Change one = cascade of changes

Mitigation Strategy:
- Implement incrementally (one component at a time)
- Keep old components during transition (duplication acceptable)
- Use feature flags in CSS (keep both class names)
- Test heavily after each change
- Plan 20% time buffer for unexpected breakage
```

**Why It's Safe (With Caveats):**
- ✅ Documentation is pure content (zero risk)
- ⚠️ Refactoring requires careful testing
- ✅ Can be done incrementally
- ✅ Old components can co-exist during transition
- ✅ Git allows easy rollback

**Potential Impacts:**
- ✅ POSITIVE: Easier to maintain long-term
- ✅ POSITIVE: New features faster to implement
- ⚠️ RISK: Refactoring can introduce regressions
- ⚠️ RISK: Requires comprehensive testing
- ℹ️ NEUTRAL: Production store unaffected during work

**Non-Breaking Strategy:**
```
Phase 2a: Documentation Only (0% risk)
- Write design system docs
- No code changes yet
- Team reviews and approves

Phase 2b: Create Unified Components (low risk)
- Create new consolidated component templates
- Keep old components in place
- CSS supports both (no breaking changes)

Phase 2c: Migrate Templates (medium risk)
- Update templates to use new components
- One page at a time
- Regression test each page
- Deploy incrementally
```

**Validation:**
```
[ ] Design system documented
[ ] Component taxonomy defined
[ ] New unified components created
[ ] Old components still functional (parallel)
[ ] Templates migrated page by page
[ ] Visual regression testing (Percy)
[ ] Accessibility audit post-migration
[ ] Performance metrics unchanged
```

**Rollback Procedure:**
```
If migration breaks styles:
1. git revert <commit-range>
2. Redeploy old templates
3. Keep design system documentation
4. Retry migration with more time budget
```

**Status:** ⚠️ **CAUTION** - Feasible but requires careful planning and testing

---

### MEDIUM PRIORITY DEBTS (Phase 2-3)

#### 11. **FE-6: Form Labels Inconsistent**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-6 |
| **Type** | Accessibility/Frontend |
| **Severity** | MEDIUM |
| **Effort** | 3-5h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES |
| **Scope** | HTML templates only |
| **Risk Level** | NONE |

**Problem:**
- Form inputs missing labels
- Label/input association broken
- Screen readers can't identify fields
- WCAG 1.3.1 failure

**Implementation:**
```html
<!-- BEFORE -->
<input type="text" placeholder="Email">

<!-- AFTER -->
<label for="email-input">Email Address</label>
<input type="text" id="email-input" name="email" placeholder="Email">
```

**Why It's Safe:**
- ✅ Pure HTML association (no behavior change)
- ✅ Backward compatible
- ✅ Labels improve usability (not just accessibility)
- ✅ Nuvemshop supports `<label>` elements
- ✅ Zero CSS/JavaScript changes

**Potential Impacts:**
- ✅ POSITIVE: WCAG 1.3.1 compliance
- ✅ POSITIVE: Better UX (larger click area)
- ✅ POSITIVE: Mobile usability improved
- ℹ️ NEUTRAL: No performance impact
- ℹ️ NEUTRAL: No visual change required

**Validation:**
```
[ ] All form inputs have <label> elements
[ ] Labels use "for" attribute
[ ] ID attributes match
[ ] Screen reader test (NVDA, JAWS)
[ ] Mobile testing (tap targets 44px+)
```

**Status:** ✅ **SAFE** - Quick win, high impact

---

#### 12. **FE-7: Color Alone for Status**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-7 |
| **Type** | Accessibility/Frontend |
| **Severity** | LOW-MEDIUM |
| **Effort** | 3-4h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES |
| **Scope** | CSS + HTML templates |
| **Risk Level** | NONE |

**Problem:**
- Status shown by color only
- Color-blind users can't identify state
- WCAG 1.4.1 failure

**Implementation:**
```html
<!-- BEFORE: Color only -->
<span class="badge badge--success">Active</span>

<!-- AFTER: Color + Icon + Text -->
<span class="badge badge--success">
  <svg class="badge__icon" aria-hidden="true">
    <use xlink:href="#icon-checkmark"></use>
  </svg>
  <span class="badge__text">Active</span>
</span>
```

**Why It's Safe:**
- ✅ Adds icons and text (no removal)
- ✅ Backward compatible
- ✅ Enhances for all users (not just accessibility)
- ✅ Zero JavaScript impact
- ✅ Minor CSS additions

**Potential Impacts:**
- ✅ POSITIVE: WCAG 1.4.1 compliance
- ✅ POSITIVE: Better UX for all users
- ℹ️ MINIMAL: Slight visual change (addition of icons)
- ℹ️ MINIMAL: Slightly larger badge size

**Validation:**
```
[ ] All color-coded states have icons/text
[ ] Visual regression testing
[ ] Accessibility audit (WAVE)
[ ] Color-blind simulation test
```

**Status:** ✅ **SAFE** - Quick win, accessibility improvement

---

#### 13. **FE-13: Touch Target Sizes**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-13 |
| **Type** | Accessibility/Mobile |
| **Severity** | MEDIUM |
| **Effort** | 3-5h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES |
| **Scope** | CSS only |
| **Risk Level** | LOW |

**Problem:**
- Some buttons/links < 44px (WCAG minimum)
- Mobile users mis-tap
- WCAG 2.5.5 failure

**Implementation:**
```css
/* Ensure all interactive elements are 44px minimum */
button, a, input, select {
  min-height: 44px;
  min-width: 44px;
  padding: 12px 16px; /* Increase if needed */
}

/* Account for spacing around elements */
a, button {
  margin: 8px; /* Space between targets */
}
```

**Why It's Safe:**
- ✅ CSS-only change
- ✅ Improves mobile usability
- ✅ No functional changes
- ✅ Backward compatible
- ✅ WCAG 2.5.5 compliant

**Potential Impacts:**
- ✅ POSITIVE: Mobile usability significantly improved
- ✅ POSITIVE: Conversion rate likely increased
- ℹ️ MINIMAL: Slight layout spacing changes
- ℹ️ MINIMAL: May require padding adjustments

**Validation:**
```
[ ] All interactive elements 44px+
[ ] Tested on mobile (iOS + Android)
[ ] No overlap with adjacent elements
[ ] Visual regression test
[ ] WCAG audit passes
```

**Status:** ✅ **SAFE** - Mobile UX improvement

---

#### 14. **FE-3: Breakpoints Not Documented**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-3 |
| **Type** | Documentation/CSS |
| **Severity** | MEDIUM |
| **Effort** | 4-6h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES |
| **Scope** | SCSS variables + documentation |
| **Risk Level** | NONE |

**Problem:**
- Breakpoints hard-coded everywhere
- No clear mobile/tablet/desktop strategy
- Inconsistent responsive design

**Implementation:**
```scss
/* Create theme/static/scss/_breakpoints.scss */

// Mobile-first breakpoints
$breakpoint-mobile: 320px;      // Default
$breakpoint-tablet: 768px;      // Tablets
$breakpoint-desktop: 1024px;    // Desktops
$breakpoint-large: 1440px;      // Large screens

// Usage in SCSS
.product-grid {
  grid-template-columns: 1fr; // Mobile: 1 column

  @media (min-width: $breakpoint-tablet) {
    grid-template-columns: repeat(2, 1fr); // Tablet: 2 columns
  }

  @media (min-width: $breakpoint-desktop) {
    grid-template-columns: repeat(3, 1fr); // Desktop: 3 columns
  }
}
```

**Why It's Safe:**
- ✅ Documentation + variable centralization
- ✅ Zero behavior changes
- ✅ Just refactoring hardcoded values
- ✅ Improves consistency
- ✅ Easier maintenance

**Potential Impacts:**
- ✅ POSITIVE: Responsive design consistency
- ✅ POSITIVE: Maintenance time reduced
- ℹ️ NEUTRAL: No visual change
- ℹ️ NEUTRAL: No performance impact

**Validation:**
```
[ ] Breakpoint variables created
[ ] All media queries refactored
[ ] Documentation complete
[ ] Responsive design tested (3+ devices)
[ ] Visual regression test
```

**Status:** ✅ **SAFE** - Documentation refactoring

---

#### 15. **SYS-5: JS Not Modularized**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | SYS-5 |
| **Type** | Code Architecture |
| **Severity** | MEDIUM |
| **Effort** | 12-16h |
| **Nuvemshop Compatible?** | ⚠️ CAUTION |
| **Non-Breaking?** | ✅ YES (with careful integration) |
| **Scope** | JavaScript refactoring |
| **Risk Level** | MEDIUM |

**Problem:**
- JavaScript is one large file
- No module system
- Hard to maintain and test
- Global scope pollution

**Implementation Strategy:**
```
MODERATE RISK - Refactoring existing JavaScript

Phase 2 (Week 4):
1. Organize into modules (global scope):
   theme/static/js/
   ├── utils/
   │   ├── dom.js (DOM helpers)
   │   ├── api.js (Nuvemshop API calls)
   │   └── format.js (String/number formatting)
   ├── components/
   │   ├── cart.js (Cart functionality)
   │   ├── filter.js (Product filters)
   │   ├── search.js (Search box)
   │   └── menu.js (Mobile menu)
   └── index.js (Entry point - loads all modules)

2. Create module pattern (IIFE - Immediately Invoked Function Expression):
   // theme/static/js/components/cart.js
   const CartModule = (function() {
     // Private state
     let cart = [];

     // Public API
     return {
       add: function(item) { /* ... */ },
       remove: function(id) { /* ... */ },
       get: function() { return cart; }
     };
   })();

3. Load in layout.tpl:
   <script src="/static/js/utils/api.js"></script>
   <script src="/static/js/components/cart.js"></script>
   <!-- etc -->

⚠️ IMPORTANT: No bundling yet (keep vanilla JS)
   - Local webpack build is separate (SYS-2)
   - Modules can be bundled later
```

**Critical Constraint:**
```
⚠️ Nuvemshop does NOT support ES6 modules (import/export)

Cannot use:
  ❌ import { utils } from './utils.js'
  ❌ export function myFunc() { }

Must use:
  ✅ IIFE (Immediately Invoked Function Expression)
  ✅ Namespace pattern (window.MyApp.Module)
  ✅ Global references
```

**Why It's Risky:**
- ⚠️ Refactoring global scope can introduce bugs
- ⚠️ Variable name collisions possible
- ⚠️ Execution order matters
- ✅ But: Backward compatible if done carefully

**Potential Impacts:**
- ✅ POSITIVE: Code easier to maintain
- ✅ POSITIVE: Testing easier (isolated modules)
- ✅ POSITIVE: Future ES6 modules possible
- ⚠️ RISK: Scope pollution still exists (global)
- ⚠️ RISK: More HTTP requests (multiple files)

**Non-Breaking Strategy:**
```
1. Create modules alongside existing code
2. No deletion of original code yet
3. Test each module independently
4. Gradually replace old functions
5. Keep both versions for comparison
6. Once tested, remove old code
```

**Validation:**
```
[ ] Each module has tests (SYS-7)
[ ] No global scope conflicts
[ ] Manual testing on all browsers
[ ] JavaScript console: zero errors
[ ] Functionality unchanged
[ ] Performance metrics (monitor load time)
```

**Rollback Procedure:**
```
if (issues detected) {
  git revert <commit-range>
  Redeploy old monolithic JS file
}
```

**Status:** ⚠️ **CAUTION** - Risky refactoring, requires testing

---

#### 16. **SYS-6: Limited Git Integration**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | SYS-6 |
| **Type** | DevOps/Tooling |
| **Severity** | LOW |
| **Effort** | 6-8h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES |
| **Scope** | GitHub configuration only |
| **Risk Level** | NONE |

**Problem:**
- Git repository exists but limited integration
- No branch protection rules
- No PR reviews
- No forced commit messages

**Implementation:**
```
SAFE - GitHub configuration only, no code changes

1. Set up branch protection (main):
   Settings → Branches → Add rule
   - Require pull request reviews (1 minimum)
   - Require status checks (tests, lint, build)
   - Include administrators
   - Require branches up to date before merge

2. Create PR template:
   .github/pull_request_template.md
   Ensures consistent PR documentation

3. Add commit message convention:
   .husky/commit-msg (from SYS-7)
   Enforces conventional commits:
   - feat: new feature
   - fix: bug fix
   - chore: maintenance
   etc.

4. Create GitHub Actions status checks:
   (Covered in SYS-3: CI/CD)
```

**Why It's Safe:**
- ✅ GitHub configuration (no code changes)
- ✅ Improves code review process
- ✅ Zero functional impact
- ✅ Can be disabled if problematic
- ✅ Purely workflow improvement

**Potential Impacts:**
- ✅ POSITIVE: Code quality improved
- ✅ POSITIVE: Better PR documentation
- ✅ POSITIVE: Fewer production bugs
- ℹ️ NEUTRAL: Deployment slightly slower (review required)
- ℹ️ NEUTRAL: Developers must follow conventions

**Validation:**
```
[ ] Branch protection rules active
[ ] PR template works
[ ] Status checks block bad PRs
[ ] Team trained on process
[ ] First PR review successful
```

**Status:** ✅ **SAFE** - Process improvement, high quality ROI

---

### LOW PRIORITY DEBTS (Phase 3-4, Deferrable)

#### 17. **FE-8: Reduced Motion Support**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-8 |
| **Type** | Accessibility |
| **Severity** | LOW |
| **Effort** | 2-3h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES |
| **Scope** | CSS media query |
| **Risk Level** | NONE |

**Problem:**
- Animations not respecting user preferences
- Vestibular disorder users experience motion sickness
- WCAG 2.3.3 best practice

**Implementation:**
```css
/* Detect reduced motion preference */
@media (prefers-reduced-motion: reduce) {
  * {
    animation: none !important;
    transition: none !important;
  }
}
```

**Why It's Safe:**
- ✅ CSS media query (zero code change)
- ✅ User preference respected
- ✅ No functional changes
- ✅ Backward compatible

**Status:** ✅ **SAFE** - Low effort, Phase 4

---

#### 18. **FE-10: Mobile Menu UX Polish**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-10 |
| **Type** | UX |
| **Severity** | LOW |
| **Effort** | 2-4h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES |
| **Scope** | JavaScript + CSS |
| **Risk Level** | LOW |

**Problem:**
- Mobile menu needs UX improvements
- Users report difficulty navigating

**Improvements:**
- Smooth scroll animation
- Better visual feedback
- Faster closing on item select
- Keyboard support

**Status:** ✅ **SAFE** - Phase 4 polish

---

#### 19. **FE-9: Image Optimization Missing**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-9 |
| **Type** | Performance |
| **Severity** | MEDIUM |
| **Effort** | 8-12h |
| **Nuvemshop Compatible?** | ⚠️ CAUTION |
| **Non-Breaking?** | ✅ YES |
| **Scope** | Image handling, HTML templates |
| **Risk Level** | LOW |

**Problem:**
- Images not optimized (no WebP)
- Responsive images missing
- Large file sizes impact LCP

**Implementation:**
```html
<!-- Use Nuvemshop image service for WebP -->
<picture>
  <source
    type="image/webp"
    srcset="{{ product.featured_image | image_url: width: 400, format: 'webp' }}">
  <img
    src="{{ product.featured_image | image_url: width: 400 }}"
    alt="{{ product.name }}">
</picture>
```

**Why It's Safe:**
- ✅ Nuvemshop image service handles WebP
- ✅ Liquid filter transformations
- ✅ Backward compatible (`<picture>` fallback)
- ✅ No Nuvemshop API changes

**Status:** ✅ **SAFE** - Phase 3, performance boost

---

#### 20. **FE-11: Lighthouse 85+ Score**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | FE-11 |
| **Type** | Performance |
| **Severity** | MEDIUM |
| **Effort** | 12-16h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ✅ YES |
| **Scope** | Various optimizations |
| **Risk Level** | LOW |

**Problem:**
- Lighthouse score ~70 (target: 85+)
- Core Web Vitals not green
- Performance impacts conversion

**Improvements:**
1. FE-9: Image optimization
2. SYS-2: Build pipeline (minification)
3. CSS caching strategy (SYS-1)
4. JavaScript lazy loading
5. Font loading optimization

**Status:** ✅ **SAFE** - Phase 3, multi-effort optimization

---

#### 21. **SYS-8: Template Duplication**

| Category | Assessment | Details |
|----------|-----------|---------|
| **ID** | SYS-8 |
| **Type** | Code Quality |
| **Severity** | LOW |
| **Effort** | 8-12h |
| **Nuvemshop Compatible?** | ✅ YES |
| **Non-Breaking?** | ⚠️ CAUTION |
| **Scope** | Template consolidation |
| **Risk Level** | MEDIUM |

**Problem:**
- Similar templates duplicated
- Hard to maintain consistency
- Style changes require updates in multiple places

**Implementation:**
```
Create reusable snippets for common patterns

theme/snipplets/
├── card.tpl (generic card)
├── card-product.tpl (product card)
├── card-category.tpl (category card)
└── card-blog.tpl (blog card)

Pass variables to control output:
{% include 'snipplet' 'card-product', product: product, variant: 'minimal' %}
```

**Why Risky:**
- ⚠️ Template consolidation can break pages
- ⚠️ Nuvemshop expects certain snippets
- ✅ But: Can create new snippets without removing old

**Status:** ⚠️ **CAUTION** - Phase 3 optimization, test heavily

---

## Summary: Risk Classification

### ✅ SAFE (Proceed Immediately)
- **SYS-1** CSS Caching
- **FE-4** Focus Indicators
- **FE-5** Alt Text
- **FE-1** CSS Variables
- **FE-2** Component Library
- **FE-6** Form Labels
- **FE-7** Color Alternatives
- **FE-13** Touch Targets
- **FE-3** Breakpoints Doc
- **SYS-6** Git Integration
- **FE-8** Reduced Motion
- **FE-10** Mobile Menu UX
- **FE-9** Image Optimization
- **FE-11** Lighthouse Optimization

### ⚠️ CAUTION (Requires Testing)
- **SYS-7** Unit Tests (low risk, infrastructure only)
- **FE-12** E2E Tests (low risk, external testing)
- **SYS-2** Build Pipeline (understand Nuvemshop constraints)
- **SYS-3** CI/CD (external infrastructure, manual approval)
- **SYS-4** Design System (refactoring, high testing burden)
- **SYS-5** JS Modules (refactoring risk)
- **SYS-8** Template Deduplication (consolidation risk)

### ❌ BLOCKED (Not Feasible)
- **None** - All 21 items are achievable within Nuvemshop constraints

---

## Implementation Roadmap

### Phase 1: Critical Foundation (Weeks 1-2)
**Target:** WCAG AA compliance + testing infrastructure

```
Week 1:
  [ ] FE-4: Focus Indicators (2-4h) - MUST DO FIRST
  [ ] SYS-1: CSS Caching Strategy (4-8h) - Testing in parallel
  [ ] FE-5: Alt Text (4-6h) - Parallel with SYS-1

Week 2:
  [ ] SYS-7: Unit Tests Setup (16-24h) - Major push
  [ ] FE-1: CSS Variables (6-8h)
  [ ] FE-6: Form Labels (3-5h)
  [ ] FE-13: Touch Targets (3-5h)
  [ ] FE-7: Color Alternatives (3-4h)

Total Phase 1: 57-82 hours
Team: 1-2 developers
Outcomes:
  ✅ WCAG AA compliance
  ✅ Testing infrastructure
  ✅ CSS variables foundation
```

### Phase 2: Architecture (Weeks 3-4)
**Target:** Design system + CI/CD

```
Week 3-4:
  [ ] FE-2: Component Library / Storybook (16-24h)
  [ ] SYS-2: Build Pipeline (12-16h)
  [ ] SYS-3: CI/CD GitHub Actions (8-12h)
  [ ] FE-3: Breakpoints Documentation (4-6h)
  [ ] FE-12: E2E Tests (start) (8h)

Total Phase 2: 48-74 hours (parallel work)
Team: 2-3 developers
Outcomes:
  ✅ Design system documented
  ✅ Local build working
  ✅ CI/CD gates active
  ✅ Component library live
```

### Phase 3: Optimization (Weeks 5-6)
**Target:** Performance 85+ Lighthouse

```
Week 5-6:
  [ ] FE-9: Image Optimization (8-12h)
  [ ] FE-11: Lighthouse Tuning (12-16h)
  [ ] SYS-8: Template Deduplication (8-12h)
  [ ] FE-12: E2E Tests (complete) (8h)

Total Phase 3: 36-48 hours
Team: 1-2 developers
Outcomes:
  ✅ Lighthouse 85+ score
  ✅ WebP images deployed
  ✅ E2E tests comprehensive
```

### Phase 4: Polish (Weeks 7-8)
**Target:** Final refinements + knowledge transfer

```
Week 7-8:
  [ ] FE-8: Reduced Motion (2-3h)
  [ ] FE-10: Mobile Menu Polish (2-4h)
  [ ] SYS-4: Design System Finalization (8-12h)
  [ ] SYS-5: JS Modules (if time permits) (4-8h)
  [ ] Documentation & Training (8h)

Total Phase 4: 24-35 hours
Team: 1 developer
Outcomes:
  ✅ All debts resolved
  ✅ Team trained
  ✅ Documentation complete
```

---

## Critical Success Factors

### 1. Respect Nuvemshop Constraints
- ❌ DO NOT try to modify database (Nuvemshop managed)
- ❌ DO NOT try to create custom backend services
- ❌ DO NOT try to use ES6 modules directly
- ✅ DO work within theme/template/CSS/JS layers
- ✅ DO use Nuvemshop API for dynamic content
- ✅ DO test in Nuvemshop staging first

### 2. FTP Deployment Safety
- ⚠️ NO automatic rollback (manual backup required)
- ✅ Always run `backup-full-ftp.js` before major deploys
- ✅ Keep incremental backups for all versions
- ✅ Test in staging Nuvemshop store first
- ✅ Deploy during low-traffic hours if possible

### 3. CSS Caching Awareness
- ⚠️ `style-async.scss.tpl` cached server-side
- ✅ Use `layout.tpl` override for urgent CSS fixes
- ✅ Implement version ID system (cache buster)
- ✅ Document cache invalidation process
- ✅ Plan migration to local SCSS build (long-term)

### 4. Testing Requirements
- ✅ All CSS changes: visual regression (Percy)
- ✅ All JavaScript: unit tests (Jest)
- ✅ All templates: E2E tests (Cypress)
- ✅ Accessibility: WAVE + keyboard navigation
- ✅ Performance: Lighthouse audit

### 5. Production Safety
- ⚠️ Production store is live (any change impacts customers)
- ✅ Deploy during low-traffic windows
- ✅ Monitor error logs in real-time
- ✅ Have quick rollback plan ready
- ✅ Notify support team before deploy

---

## Final Recommendations

### 🟢 Proceed Immediately (Phase 1 - Week 1)
1. **FE-4: Focus Indicators** (2-4h) - Legal requirement, zero risk
2. **SYS-1: CSS Caching** (4-8h) - Blocks other CSS work, easy win
3. **FE-5: Alt Text** (4-6h) - WCAG + SEO, quick win

### 🟡 Plan for Week 2 (Phase 1 - Week 2)
4. **SYS-7: Unit Tests** (16-24h) - Critical infrastructure, no risk
5. **FE-1: CSS Variables** (6-8h) - Foundation for design system
6. **FE-6, FE-7, FE-13** - Form accessibility (remaining Phase 1)

### 🔵 Sequence for Phase 2-4
- Parallel: SYS-2 (build), SYS-3 (CI/CD), FE-2 (component library)
- Then: Performance optimization (FE-9, FE-11)
- Finally: Polish and polish (FE-8, FE-10, SYS-4)

---

## Risk Summary

| Risk | Probability | Mitigation | Owner |
|------|-----------|-----------|-------|
| CSS changes don't appear | Medium | Implement cache buster (SYS-1) | Dev |
| Regression on refactoring | Medium | Tests before deploy (SYS-7, FE-12) | QA |
| Production downtime | Low | Backup before deploy, rollback plan | DevOps |
| Timeline slip | Low | Agile tracking, daily standups | PM |
| Nuvemshop API changes | Very Low | Monitor release notes | Dev |

---

## Approval Checklist

Before starting Phase 1, confirm:

- [ ] Budget approved (R$ 49,080 - R$ 73,080 depending on team size)
- [ ] Team assigned (2 developers recommended)
- [ ] Staging Nuvemshop store available for testing
- [ ] FTP backup automation working
- [ ] GitHub repository access confirmed
- [ ] Stakeholder communication plan ready
- [ ] 24/7 escalation contact identified
- [ ] Documentation storage (GitHub/Notion) established

---

**Document Status:** READY FOR IMPLEMENTATION
**Generated:** 2026-03-15
**Next Step:** Phase 1 Kickoff Meeting
**Contact:** Technical Lead / Project Manager

