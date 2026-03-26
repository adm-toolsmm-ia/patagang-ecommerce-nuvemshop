---
name: CSS Bootstrap Override Patterns - Development Memory
description: Critical CSS patterns for overriding Bootstrap in Nuvemshop themes
type: dev-memory
created_at: "2026-03-26"
source: "STORY-9.1-UX-UI-RESTRUCTURE (v1.5.149 bug fix)"
priority: HIGH
applies_to:
  - Nuvemshop theme development
  - Bootstrap CSS overrides
  - Mobile responsive fixes
---

# CSS Bootstrap Override Patterns — Development Memory

## Quick Reference

**When overriding Bootstrap classes: Use `!important` + explicit property reset**

```css
/* ✅ CORRECT PATTERN */
.pg-custom-class {
  max-width: 100% !important;      /* Layer 1: Direct override */
  width: 100% !important;           /* Layer 2: Ensure width */
  padding-right: 0 !important;     /* Layer 3: Remove inherited padding */
  padding-left: 0 !important;
  flex: 0 0 100% !important;       /* Layer 4: Flex basis override */
}

/* ❌ INCORRECT (WILL FAIL) */
.pg-custom-class {
  width: 100%;                     /* Missing !important */
  max-width: 100%;                 /* Missing !important */
  /* Bootstrap padding still applies (15px) */
}
```

---

## Problem Pattern: Bootstrap Media Query Cascade

**Issue:** Bootstrap defines rules in media queries, but they DON'T deactivate in smaller viewports

```css
/* This is ACTIVE in mobile EVEN THOUGH it says col-lg-5 */
@media (min-width: 992px) {
  .col-lg-5 {
    max-width: 41.666667%;  /* ❌ Still applies in mobile! */
  }
}
```

**Why:** CSS cascade doesn't "turn off" properties outside media query—they remain in inheritance chain.

**Solution:** Explicitly set property in mobile-first context:

```css
/* Mobile first (all breakpoints) */
.pg-custom-element {
  max-width: 100% !important;
}

/* Desktop only (if you need to change it) */
@media (min-width: 992px) {
  .pg-custom-element {
    max-width: 41.666667% !important;
  }
}
```

---

## Case Study: STORY-9.1 Bug #3 (PDP Mobile Card)

### Symptom
Card info occupied only 41.67% width in mobile (compacted to left), while gallery occupied 100%.

### Root Cause
HTML: `<div class="col-12 col-lg-5 pg-pdp-info-col">`
- Bootstrap `.col-lg-5` defines `max-width: 41.666667%` in `@media (min-width: 992px)`
- In mobile (< 992px), this rule was NOT deactivated by media query
- Our CSS `width: 100%` without `!important` lost to Bootstrap's more specific property

### Symptoms in DevTools
```
✓ width: 100%                    (strikethrough—overridden)
✓ max-width: 41.666667%          (active—from Bootstrap)
✓ padding-right: 15px            (active—from Bootstrap .col)
```

### Applied Fix (v1.5.149)
```css
/* Before (BROKEN) */
.pg-pdp-info-col {
  width: 100%;                   /* ❌ Lost to Bootstrap */
  max-width: 100%;               /* ❌ Lost to Bootstrap */
  padding: 0 !important;         /* ❌ Padding still 15px */
}

/* After (FIXED) */
.pg-pdp-info-col {
  max-width: 100% !important;    /* ✅ Wins vs col-lg-5 */
  width: 100% !important;        /* ✅ Explicit */
  padding-right: 0 !important;   /* ✅ Remove 15px default */
  padding-left: 0 !important;    /* ✅ Remove 15px default */
  flex: 0 0 100% !important;     /* ✅ Flex safety net */
}

/* Parent container support */
.pg-pdp-container .section-single-product {
  display: flex !important;
  flex-direction: column !important;
  align-items: stretch !important;  /* Children span 100% */
}
```

**Result:** ✅ Card now occupies 100% width, matches gallery layout

---

## Development Checklist

When fixing Bootstrap CSS conflicts:

```
CODE ANALYSIS:
  [ ] Identify all Bootstrap classes (.col-*, .row, etc.)
  [ ] Check media queries (rules may not deactivate in mobile)
  [ ] Look for conflicting properties (width vs max-width)
  [ ] Check specificity (more specific property wins)

IMPLEMENTATION:
  [ ] Add !important to custom override (not ideal, but necessary)
  [ ] Explicitly reset conflicting properties (max-width, padding, margin)
  [ ] Use flex shorthand as safety net (flex: 0 0 100%)
  [ ] Test parent container flex properties (align-items: stretch)

TESTING:
  [ ] Test in mobile view (F12 > responsive mode)
  [ ] Test in 3+ breakpoints (mobile, tablet, desktop)
  [ ] Check DevTools > Computed tab (verify rules are active, not strikethrough)
  [ ] Test in incognito (avoid cache issues)
  [ ] Verify no console errors (F12 > Console)

DEBUGGING:
  [ ] If still failing, check media query is truly active (F12 responsive)
  [ ] Count specificity: ID(100) > class(10) > element(1)
  [ ] Check for conflicting Bootstrap utilities (might have higher specificity)
  [ ] Try browser DevTools "Toggle Element State" to test pseudo-classes
```

---

## Anti-Patterns (What NOT to Do)

```css
/* ❌ Missing !important (will lose to Bootstrap) */
.col-custom {
  width: 100%;
}

/* ❌ Only setting width (max-width still restricted) */
.col-custom {
  width: 100% !important;
  /* max-width still 41.67% from Bootstrap */
}

/* ❌ Not removing padding (effective width < 100%) */
.col-custom {
  width: 100% !important;
  /* padding-left/right still 15px from .col */
}

/* ❌ Assuming media query deactivates (it doesn't) */
.col-lg-5 { max-width: 41.67%; }
/* In mobile, this still applies! */

/* ❌ Over-specificity (bad for maintenance) */
.container .row .col-lg-5.pg-custom {
  /* Too many selectors, hard to override later */
}
```

---

## Best Practices

1. **Always use `!important` when overriding Bootstrap grid classes**
   - Bootstrap uses inline styles and multiple specificity levels
   - Without `!important`, will lose in media queries and responsive changes

2. **Reset inherited properties explicitly**
   - Don't assume properties don't cascade
   - Explicitly set `padding: 0 !important` even if you think you already removed it

3. **Test across ALL breakpoints**
   - Mobile (< 576px)
   - Tablet (576-991px)
   - Desktop (992px+)

4. **Use DevTools Computed tab**
   - Strikethrough = overridden
   - Bold = active
   - This is your source of truth

5. **Document conflicts found**
   - Add comments explaining why `!important` was necessary
   - Reference story/issue number (e.g., `/* STORY-9.1 v1.5.149 */`)

---

## References

- **File:** `.aiox-core/data/learned-patterns-bootstrap-css-override.yaml`
- **Story:** STORY-9.1-UX-UI-RESTRUCTURE
- **Issue:** PDP mobile card compacted (v1.5.148) → Fixed (v1.5.149)
- **Commit:** f1abafb (fix: resolve Bootstrap col-lg-5 max-width conflict)
- **CSS File:** `theme-deploy-corrigido/static/css/style-critical.tpl` (lines 3402-3430)

---

## For Next Developer

When you encounter similar "CSS doesn't apply" issues:
1. Read this memory
2. Check `.aiox-core/data/learned-patterns-bootstrap-css-override.yaml`
3. Use the 4-layer override pattern
4. Follow the development checklist
5. Add your findings to this file

---

**Last Updated:** 2026-03-26
**Status:** ACTIVE (Reference for all future Bootstrap overrides)
**Maintainer:** @dev (Dex)
**Tags:** #bootstrap #css #specificity #nuvemshop #mobile-responsive
