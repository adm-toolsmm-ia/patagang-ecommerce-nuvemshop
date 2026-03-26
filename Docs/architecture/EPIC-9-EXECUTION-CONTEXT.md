# EPIC 9 — Contexto de Execução & Mapeamento Arquitetural

**Versão:** 1.0
**Data:** 2026-03-26
**Status:** REFERÊNCIA ATIVA para EPIC 9 execution (Stories 9.1-9.6)
**Criado em:** Story 9.1 Deep Investigation
**Mantido por:** @aiox-master, @architect

---

## 📋 TABLE OF CONTENTS

1. [Executive Summary](#executive-summary)
2. [Architecture Overview](#architecture-overview)
3. [CSS Architecture Deep Dive](#css-architecture-deep-dive)
4. [HTML/Template Structure](#htmltemplate-structure)
5. [Nuvemshop Constraints](#nuvemshop-constraints)
6. [Current Issues & Workarounds](#current-issues--workarounds)
7. [Execution Guidelines for Stories 9.1-9.6](#execution-guidelines-for-stories-91-96)
8. [Known Patterns & Anti-Patterns](#known-patterns--anti-patterns)
9. [Future: Epic 9.2 CSS Refactor](#future-epic-92-css-refactor)
10. [FAQ & Troubleshooting](#faq--troubleshooting)

---

## EXECUTIVE SUMMARY

### What We Discovered

During Story 9.1 investigation, deep analysis revealed **critical architectural issues** in Patagang's CSS:

| Finding | Severity | Impact | Status |
|---------|----------|--------|--------|
| Broken CSS Cascade | 🔴 CRITICAL | Simple changes fail 5x | Band-aid (188 !important) |
| Monolithic CSS Files | 🔴 CRITICAL | Hard to maintain | Will refactor Epic 9.2 |
| Orphaned CSS Classes | 🔴 HIGH | Code clutter | Fixed in v1.5.133 |
| Performance Violation | 🔴 HIGH | LCP slow | Will fix Epic 9.2 |
| Dead Code | 🔴 HIGH | 5-10% unused CSS | Partial cleanup v1.5.133 |

### What We Fixed (v1.5.133)

✅ Removed 2 orphaned CSS classes (`.pg-pdp-banner-warning`, `.pg-pdp-banner-informative`)
✅ Fixed actual banner color (`.section-advertising` → #EAFE67)
✅ Created CSS Cascade documentation

### What Remains (Planned Epic 9.2)

🟠 Remove 188 `!important` from layout.tpl
🟠 Modularize CSS (3 files instead of 10+)
🟠 Performance optimization (< 50 KB critical CSS)
🟠 Full refactor of cascade

---

## ARCHITECTURE OVERVIEW

### PROJECT STRUCTURE (Patagang FTP Theme)

```
patagang-ecommerce-nuvemshop/
├── .claude/
│   ├── CLAUDE.md (Project rules)
│   └── rules/ (Contextual rules)
│       ├── nuvemshop-ftp-constraints.md ⭐ READ THIS
│       ├── patagang-ftp-production-standard.md ⭐ READ THIS
│       └── patagang-css-cascade.md (NEW - v1.5.133)
│
├── .aiox-core/
│   └── data/
│       └── patagang-architecture-state.yaml ⭐ THIS FILE (L3)
│
├── Docs/
│   ├── architecture/
│   │   ├── README.md (Guides this section)
│   │   ├── patagang-css-cascade.md (HOW-TO modify CSS)
│   │   ├── EPIC-9-EXECUTION-CONTEXT.md (THIS FILE)
│   │   └── [other architecture docs]
│   ├── guides/
│   │   └── nuvemshop/ (FTP best practices)
│   ├── reports/
│   │   ├── 9.1-COLOR-BACKGROUND-ANALYSIS.md (Investigation report)
│   │   └── [other analysis]
│   └── stories/ (User stories)
│
├── theme-deploy-corrigido/ (MAIN: FTP deployable theme)
│   ├── layouts/
│   │   └── layout.tpl ⚠️ CONTAINS 188 !important (Band-aid)
│   ├── templates/
│   │   ├── product.tpl (PDP page)
│   │   └── [other pages]
│   ├── snipplets/ (Reusable components)
│   │   ├── header/header-advertising.tpl (.section-advertising)
│   │   ├── product/ (product-related)
│   │   └── [other snipplets]
│   └── static/css/ (MAIN: CSS files)
│       ├── style-critical.tpl (149 KB, 4,645 lines) 🔴 Monolithic
│       ├── style-colors.scss.tpl (25 KB, partially commented)
│       ├── style-async.scss.tpl (166 KB, 7,132 lines)
│       ├── style-menu-patagang.css.tpl
│       ├── style-filters-patagang.css.tpl
│       └── [other CSS files]
│
├── ftp-deploy/ (Deployment script)
│   └── deploy.js (AUTO-VERSIONS, backs up, validates on FTP)
│
└── backups/ (FTP deployment backups)
    ├── deployment-1.5.130/
    ├── deployment-1.5.131/
    ├── deployment-1.5.132/
    └── deployment-1.5.133/ ⭐ Current
```

### Tech Stack

- **Language:** Liquid (Nuvemshop templating)
- **CSS:** SCSS (compiled to CSS)
- **Build:** Node.js FTP deploy (custom script)
- **Hosting:** Nuvemshop (FTP-based, no staging)
- **Version Control:** Git + GitHub

---

## CSS ARCHITECTURE DEEP DIVE

### How CSS is Loaded (Critical for Understanding Failures)

**PHASE 1: CRITICAL CSS** (Blocks page render) — 224 KB total

```
Timeline:
1. style-critical.tpl (149 KB, 549 classes)
   │
   ├─ style-menu-patagang.css.tpl (8.3 KB)
   ├─ style-filters-patagang.css.tpl (15 KB)
   ├─ style-help-sidebar.css.tpl (6.6 KB)
   │
   ├─> layout.tpl <style> section ⚠️ CRITICAL
   │   └─ 188 !important declarations
   │   └─ Overrides EVERYTHING above
   │
   └─> style-colors.scss.tpl (25 KB)
       └─ Color overrides
       └─ Some rules commented out (30%)
```

**PHASE 2: ASYNC CSS** (Non-blocking, loads after render) — 166 KB

```
1. style-async.scss.tpl (7,132 lines, 697 classes)
   └─ Non-critical styles
   └─ Can be delayed
```

### Why Simple CSS Changes Fail (Root Cause Analysis)

**Example: Changing banner color**

```
YOU TRY:
  Change: .section-advertising { background-color: yellow; }
  Expected: Yellow banner appears ✅

WHAT ACTUALLY HAPPENS:
  1. style-critical.tpl defines: .section-advertising { background-color: transparent; }
  2. layout.tpl overrides parent with: !important (line 79-100)
  3. style-colors.scss rules are COMMENTED OUT (lines 1048-1055)
  4. Async CSS loads late, might override again
  5. Nuvemshop platform applies defaults
  6. Result: Still not yellow ❌

WHY IT FAILS 5 TIMES:
  - Each time you make change, different layer wins
  - Cascade is UNPREDICTABLE due to 188 !important
  - No clear "source of truth" for which CSS wins
  - You can't predict which file controls which element
```

### The 188 !important Problem

**Location:** `theme-deploy-corrigido/layouts/layout.tpl` lines 79-511

**Count:** 188 `!important` declarations

**Why they exist:**
```
{# PATAGANG v1.5.31: CRITICAL FIX - Reset body background #}
{# Reason: style-colors.scss defines body { background-color: $main-background } #}
{# If $main-background is gray, it cascades to banner sections and breaks everything #}
{# Fix: Use !important to force white background everywhere #}
```

**Translation:** Someone tried to fix a cascade problem with a band-aid (188 !important) instead of refactoring properly.

**Impact:**
- You can't change CSS "cleanly" — everything needs !important to override
- Cascade is broken — normal CSS rules don't work
- Developer friction — simple changes take 5x longer

**Solution:** Epic 9.2 refactor (remove ALL !important, fix cascade)

---

## HTML/TEMPLATE STRUCTURE

### Key Classes & Their Purpose

| Class | File | Purpose | CSS Where | Status |
|-------|------|---------|-----------|--------|
| `.section-advertising` | `snipplets/header/header-advertising.tpl` | Advertising banner (top of page) | `style-critical.tpl:1672` | 🟢 CORRECT |
| `.section-advertising__marquee` | header-advertising.tpl | Marquee container | `style-critical.tpl:1680` | 🟢 CORRECT |
| `.section-advertising__copy` | header-advertising.tpl | Banner text | `style-critical.tpl:1690` | 🟢 CORRECT |
| `.pg-identity-banner` | `snipplets/product/product-identity-banner.tpl` | PDP identity statements | `style-critical.tpl` | 🟢 CORRECT |
| `.product-informative-banner` | `snipplets/product/product-informative-banner.tpl` | PDP info banner | `style-critical.tpl` | 🟢 CORRECT |
| `.pg-pdp-container` | `templates/product.tpl` | PDP main container | `style-critical.tpl` | 🟢 CORRECT |
| `.pg-pdp-banner-warning` | ~~NOWHERE~~ | ❌ ORPHANED (removed v1.5.133) | Was in `style-critical.tpl` | ❌ REMOVED |
| `.pg-pdp-banner-informative` | ~~NOWHERE~~ | ❌ ORPHANED (removed v1.5.133) | Was in `style-critical.tpl` | ❌ REMOVED |

### Template Hierarchy

```
layout.tpl (MAIN WRAPPER)
├── section.patagang-section-header
│   └── header.pg-header
├── section.patagang-section-top
│   └── header/header-advertising.tpl
│       └── .section-advertising (THE BANNER)
│           └── .section-advertising__marquee
│               └── .section-advertising__copy
└── main.patagang-section-content
    └── [PAGE CONTENT]
        ├── product.tpl (if PDP)
        │   ├── snipplets/product/product-identity-banner.tpl
        │   ├── snipplets/product/product-informative-banner.tpl
        │   └── [product content]
        └── [other pages]
```

---

## NUVEMSHOP CONSTRAINTS

### Hard Rules (MUST NOT VIOLATE)

**From `.claude/rules/nuvemshop-ftp-constraints.md`:**

| Constraint | Severity | Detail |
|-----------|----------|--------|
| **Checkout form** | 🔴 CRITICAL | Do NOT modify structure/fields — breaks payments |
| **Footer attribution** | 🔴 CRITICAL | MUST remain visible — Nuvemshop ToS |
| **Contact form** | 🔴 CRITICAL | Do NOT modify structure/fields |
| **Registration form** | 🔴 CRITICAL | Do NOT modify structure/fields |
| **Newsletter form** | 🔴 CRITICAL | Do NOT modify structure/fields |

### Safe to Modify (Always)

✅ Colors, fonts, spacing, shadows, gradients
✅ Animations, transitions, responsive breakpoints
✅ Custom CSS classes (non-structure)

### Performance Constraints

| Constraint | Current | Limit | Status |
|-----------|---------|-------|--------|
| Critical CSS | 224 KB | 50 KB | 🔴 VIOLATION (4.48x) |
| Core Web Vitals | ? (not measured) | > 90 (mobile) | ⚠️ LIKELY SLOW |

---

## CURRENT ISSUES & WORKAROUNDS

### Issue 1: Broken CSS Cascade (BAND-AID)

**Problem:** CSS changes don't appear or require 5+ attempts

**Root Cause:** 188 `!important` in layout.tpl override normal CSS

**Workaround (Until Epic 9.2):**
1. Always check `layout.tpl` lines 79-511 for conflicting `!important`
2. If change doesn't appear, use `!important` as last resort
3. Add comment explaining why (for future Epic 9.2 refactor)
4. Test on 3+ breakpoints (media queries can override you)

**Permanent Fix:** Epic 9.2 CSS Refactor (remove ALL `!important`, fix cascade)

---

### Issue 2: Orphaned CSS Classes (FIXED v1.5.133)

**Fixed:**
- ~~`.pg-pdp-banner-warning`~~ (removed)
- ~~`.pg-pdp-banner-informative`~~ (removed)

**Lesson:** Always verify HTML uses new CSS classes before deploying

---

### Issue 3: Monolithic CSS Files (PLANNED EPIC 9.2)

**Problem:** 4,645 + 7,132 lines in 2 files (hard to maintain)

**Current:**
- `style-critical.tpl`: 149 KB, 549 classes (messy)
- `style-async.scss.tpl`: 166 KB, 697 classes (messy)

**Permanent Fix:** Epic 9.2 split into:
- `style-layout.css` (< 20 KB)
- `style-components.css` (< 30 KB)
- `style-utilities.css` (async)

---

## EXECUTION GUIDELINES FOR STORIES 9.1-9.6

### Before Each Story

**Read These First:**
1. ✅ `.claude/rules/nuvemshop-ftp-constraints.md` (Constraints)
2. ✅ `.claude/rules/patagang-ftp-production-standard.md` (Deployment standard)
3. ✅ `Docs/architecture/patagang-css-cascade.md` (How to safely modify CSS)

### Quality Gate Checklist

**Before committing CSS changes:**

```
□ 1. Identify exact element/class you're changing
□ 2. Find where it's defined (grep in style-critical.tpl)
□ 3. Search layout.tpl (lines 79-511) for !important blocking you
□ 4. Check for media queries overriding your change
□ 5. Verify Nuvemshop constraints NOT violated
□ 6. Make change in correct file:
     - Mostly layout/structure? → style-critical.tpl
     - Mostly colors/fonts? → style-colors.scss.tpl
     - Non-critical? → style-async.scss.tpl
□ 7. Test on 3+ breakpoints (mobile, tablet, desktop)
□ 8. Deploy v1.5.x
□ 9. Gabriel validates in production
□ 10. If broken, reference Docs/architecture/patagang-css-cascade.md
```

### Safe Way to Modify CSS

**Rule 1: Understand the cascade**
```
Don't just change CSS. Understand WHY it's not working:
- Is layout.tpl !important blocking you?
- Is another media query overriding you?
- Is the class even used in HTML?
```

**Rule 2: Prefer style-critical.tpl (most predictable)**
```
Priority for edits:
1. style-critical.tpl (safest, clearest)
2. style-colors.scss.tpl (for colors/fonts)
3. style-async.scss.tpl (only if truly non-critical)
4. layout.tpl (ONLY with !important as last resort, with comment)
```

**Rule 3: Avoid !important (use as last resort)**
```
❌ DON'T:
   .my-class { color: blue !important; }

✅ DO:
   .my-class { color: blue; }

   If that doesn't work, investigate WHY instead of using !important.
```

**Rule 4: Test ALL breakpoints**
```
Desktop: 1920px+
Tablet: 768px-1023px
Mobile: < 768px

Media queries in style-critical.tpl can override your change.
```

---

## KNOWN PATTERNS & ANTI-PATTERNS

### ✅ PATTERNS TO KEEP

1. **Semantic HTML Classes**
   - `.section-advertising` (clear purpose)
   - `.pg-identity-banner` (descriptive)

2. **BEM-like Structure** (partial)
   - `.section-advertising__marquee` (block__element)
   - `.section-advertising__copy` (block__element)

3. **Mobile-First Responsive**
   - Defaults for mobile (small screen)
   - Media queries add desktop (good approach)

4. **Settings-Driven Colors**
   - `$main-background` from Nuvemshop
   - Allows theme customization in admin

### ❌ ANTI-PATTERNS (Will Fix Epic 9.2)

1. **188 !important** — Ban-aid, breaks cascade
2. **Monolithic Files** — Hard to maintain
3. **Inline <style> in layout.tpl** — Defeats separation of concerns
4. **Dead Code** — Orphaned classes, commented rules
5. **No Cascade Documentation** — Fixed v1.5.133

---

## FUTURE: EPIC 9.2 CSS REFACTOR

**Planned:** After Epic 8 stabilizes (2-3 weeks)
**Duration:** 12 days (2 weeks)
**Scope:** 7 stories

### Expected Improvements

| Metric | Current | After Epic 9.2 |
|--------|---------|----------------|
| CSS Critical Size | 224 KB | < 50 KB ✅ |
| !important Count | 188 | 0 (utilities only) ✅ |
| Cascade Health | Broken | Functional ✅ |
| Dev Time for Changes | 3-5x normal | 1x normal ✅ |
| Dead Code | 5-10% | 0% ✅ |

### Stories 9.2.1 — 9.2.7

**9.2.1: Audit & Classification (2d)**
- Map all 1,246+ CSS classes
- Categorize: Layout / Components / Utilities / Dead

**9.2.2: Extract Dead Code (1d)**
- Remove orphaned classes
- Archive commented rules

**9.2.3: Reorganize Files (2d)**
- Create 3 semantic files
- Redistribute 1,246+ classes

**9.2.4: Fix Cascade (3d, riskiest)**
- Remove 188 !important
- Fix parent→child cascade

**9.2.5: Modularize (2d)**
- Extract `.section-advertising` component
- Extract `.pg-pdp-*` components

**9.2.6: Performance (1d)**
- Minify critical CSS < 50 KB
- Validate Core Web Vitals improve

**9.2.7: Documentation (1d)**
- CSS Architecture Guide
- Component registry

---

## FAQ & TROUBLESHOOTING

### Q: I changed CSS but it doesn't appear!

**A:** Cascade is broken (188 !important). Follow this:

1. **Verify HTML uses your class**
   ```bash
   grep -r "your-class-name" theme-deploy-corrigido/snipplets/ --include="*.tpl"
   ```

2. **Find where it's defined**
   ```bash
   grep -n "\.your-class-name" theme-deploy-corrigido/static/css/style-critical.tpl
   ```

3. **Check layout.tpl blocking you**
   ```bash
   grep -n "!important" theme-deploy-corrigido/layouts/layout.tpl | grep "your-element"
   ```

4. **Look for media queries overriding**
   ```bash
   grep -n "@media" theme-deploy-corrigido/static/css/style-critical.tpl
   ```

5. **If all else fails:** Use `!important` + add comment explaining why (for Epic 9.2 refactor)

---

### Q: Should I modify style-critical.tpl or style-colors.scss.tpl?

**A:** Priority:

1. **If layout/structure change** → `style-critical.tpl` (responsive structure)
2. **If color/font change** → `style-colors.scss.tpl` (semantic)
3. **If non-critical** → `style-async.scss.tpl` (safe to delay)
4. **If needs !important** → Add comment in `layout.tpl` explaining why (for 9.2 refactor)

---

### Q: I see code like `.section-advertising__marquee`. What's that?

**A:** BEM (Block Element Modifier) naming:
- **Block:** `.section-advertising`
- **Element:** `__marquee` (part of block)
- **Modifier:** `--active` (variant, if it exists)

This is a CSS naming convention making code more organized (good pattern, keep it).

---

### Q: What's the difference between the 3 CSS files?

**A:**

| File | Purpose | Size | Load |
|------|---------|------|------|
| `style-critical.tpl` | Layout, components, responsive | 149 KB | INLINE (blocks render) |
| `style-colors.scss.tpl` | Colors, typography, theme | 25 KB | INLINE (blocks render) |
| `style-async.scss.tpl` | Non-critical, nice-to-have | 166 KB | ASYNC (non-blocking) |

**Until Epic 9.2:** Ignore the mess, just follow Rules above.

---

### Q: Can I deploy CSS changes without Gabriel?

**A:** No. Always follow workflow:

```
Code → Commit → FTP Deploy → Gabriel Validates (https://patagang.com.br/) → GitHub Push
```

Gabriel is the QA gate in production (there's no staging environment).

---

### Q: How do I rollback if something breaks?

**A:**

```bash
node ftp-deploy/rollback-incremental.js --version v1.5.132
```

Backup exists for every deployment in `backups/deployment-1.5.x/`.

---

## SUMMARY FOR STORY DEVELOPERS

**Key Takeaways:**

1. ✅ **Read** `.claude/rules/patagang-css-cascade.md` before modifying CSS
2. ✅ **Always test** on mobile, tablet, desktop (media queries matter)
3. ✅ **Avoid !important** (use only as last resort with comment)
4. ✅ **Deploy early, validate often** (Gabriel must test in production)
5. ✅ **Document workarounds** (for Epic 9.2 refactor)

**Don't Panic:**

CSS is fragile until Epic 9.2, but it works. Use the workarounds, follow the checklist, and you'll ship clean code.

---

**Document Version:** 1.0.0
**Status:** ACTIVE (Reference for EPIC 9 execution)
**Next Update:** After Epic 9.2 CSS Refactor completion
**Maintained by:** @architect, @aiox-master
