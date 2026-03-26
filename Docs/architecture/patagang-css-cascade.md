# Patagang CSS Cascade Architecture

**Status:** Post-Refactor Documentation (v1.5.133+)
**Date:** 2026-03-26
**Severity:** REFERENCE (Understanding CSS loading order is critical for modifications)

---

## 🎯 Overview

Patagang CSS is loaded in a specific order. Understanding this order is essential to predict which rules will be applied.

**Key Principle:** Later files override earlier files (cascade), BUT `!important` breaks this rule.

---

## 📊 CSS Loading Order (Timeline)

```
Timeline of CSS Loading:
┌─ PHASE 1: BASE LAYOUT (INLINE, blocks render)
│  ├─ style-critical.tpl (149 KB, 4,645 lines)
│  │  └─ 549 CSS classes
│  │  └─ Layout structure, components, mobile-first
│  │  └─ Contains media queries for responsive
│  │
│  ├─ style-menu-patagang.css.tpl (8.3 KB)
│  ├─ style-filters-patagang.css.tpl (15 KB)
│  ├─ style-help-sidebar.css.tpl (6.6 KB)
│  │  └─ Component-specific styles
│  │
│  ├─ layout.tpl <style> section (INLINE, 188 !important)
│  │  └─ ⚠️ CRITICAL: Overrides ALL above with !important
│  │  └─ ⚠️ Reason: Fixes body background cascading issue
│  │  └─ ⚠️ Note: This is a band-aid, should be refactored
│  │
│  └─ style-colors.scss.tpl (25 KB, 1,153 lines)
│     └─ Color overrides, typography
│     └─ Variables: $main-background, $main-foreground
│     └─ NOTE: Some rules are COMMENTED OUT (line 1048-1055)
│
└─ PHASE 2: ASYNC (Non-blocking, loads AFTER render)
   └─ style-async.scss.tpl (166 KB, 7,132 lines)
      └─ Non-critical styles
      └─ Can be delayed without hurting performance
      └─ ⚠️ Still has potential conflicts with Phase 1
```

---

## 🔴 Cascade War: Why Simple Changes Fail

### Case Study: Changing Banner Color

**What you want:** Change `.section-advertising` background color

**What happens (correct cascade):**
```
1. style-critical.tpl defines: .section-advertising { background-color: transparent; }
2. You want to override: .section-advertising { background-color: #EAFE67; }
3. Expected result: Yellow banner ✅
```

**What ACTUALLY happens (broken cascade):**
```
1. style-critical.tpl (line 1672):
   .section-advertising { background-color: transparent; }

2. layout.tpl (line 79-100, with !important):
   body { background-color: #ffffff !important; }
   section.patagang-section-top { background-color: transparent !important; }

3. style-colors.scss.tpl (line 1048-1055, COMMENTED OUT):
   /* .section-advertising { ... } */

4. Async CSS (loads later):
   ? Unknown rules that might override

RESULT: Cascade is unpredictable ❌
        You change CSS but nothing appears ❌
        You try 5 times, finally works by accident ❌
```

---

## 🚨 The !important Problem (188 occurrences)

**Location:** `theme-deploy-corrigido/layouts/layout.tpl` lines 79-511

**Example:**
```css
body {
  background-color: #ffffff !important;  /* Why !important? */
  background-image: none !important;
}

section.patagang-section-top {
  background-color: transparent !important;
  background-image: none !important;
}

main.patagang-section-content {
  background-color: #ffffff !important;
  /* ... 184 more !important declarations ... */
}
```

**Why it exists:**
Comment in code explains:
```
{# PATAGANG v1.5.31: CRITICAL FIX - Reset body background after style-colors loads #}
{# Reason: style-colors.scss defines body { background-color: $main-background } #}
{# If $main-background is gray/non-white, it cascades to ad-bar and header sections #}
{# Fix: Explicit white background + !important to override everything #}
```

**Translation:**
Someone tried to fix a cascade problem using `!important` in 188 places instead of refactoring CSS properly. This is a band-aid.

---

## ✅ Safe Way to Modify CSS (Until Refactor Completes)

### Rule 1: Understand the Target

```
Q: I want to change color of `.section-advertising`

A: Verify:
   - Is this class used in HTML? (grep theme-deploy-corrigido/snipplets/ --include="*.tpl")
   - Where is it defined? (grep in style-critical.tpl)
   - Are there media queries overriding it? (search @media)
   - Is there a !important in layout.tpl? (check lines 79-511)
```

### Rule 2: Edit the Right File

**Priority Order (first match wins):**
```
1. layout.tpl <style> section (lines 79-511)
   ├─ Use ONLY if you need !important to override something
   ├─ Add comment explaining why !important is needed
   └─ Example: /* CRITICAL: Overrides style-critical.tpl line 1672 */

2. style-critical.tpl (lines 1-4645)
   ├─ Most CSS lives here
   ├─ Safe to modify
   └─ Changes here cascade naturally

3. style-colors.scss.tpl (lines 1-1153)
   ├─ Use for color/typography changes ONLY
   ├─ Some rules here are commented out
   └─ Changes here cascade AFTER style-critical

4. style-async.scss.tpl (lines 1-7132)
   ├─ Only for non-critical styles
   └─ Changes might not appear immediately
```

### Rule 3: Test in Multiple Breakpoints

Always test:
- Desktop (1920px+)
- Tablet (768px-1023px)
- Mobile (< 768px)

Media queries in style-critical.tpl can override your change on specific breakpoints.

### Rule 4: Avoid !important

```
❌ DON'T:
   .section-advertising { background-color: #EAFE67 !important; }

✅ DO:
   .section-advertising { background-color: #EAFE67; }

   If that doesn't work, investigate WHY (don't just add !important)
```

---

## 📋 Checklist: Before Deploying CSS Changes

```
□ 1. Identify exact class/element you're changing
□ 2. Find where it's defined (grep search)
□ 3. Check for media queries that override it
□ 4. Check layout.tpl for !important blocking you
□ 5. Make change in correct file (Rule 2 above)
□ 6. Test: Desktop + Tablet + Mobile
□ 7. Deploy v1.5.x
□ 8. Gabriel validates in production
□ 9. If broken, document workaround in this file
```

---

## 🔮 Future: Epic 9.2 CSS Refactor

**When:** After Epic 8 stabilizes (2-3 weeks)

**What will change:**
- ✅ Remove 188 `!important` from layout.tpl
- ✅ Reorganize CSS into 3 clean files
- ✅ Fix cascade to flow naturally (parent → child)
- ✅ Remove orphaned classes
- ✅ Performance optimization (< 50 KB critical CSS)

**After refactor:**
- CSS changes become predictable
- No more "try 5 times until it works"
- Developer joy restored

---

## 📞 Questions?

If a CSS change doesn't work:

1. **Check this document** for cascade order
2. **Search layout.tpl** for !important blocking you
3. **Test all breakpoints** (media queries might override)
4. **Document workaround** in this file for future reference
5. **Report to @architect** if it's a pattern repeating

---

**Document Version:** 1.0
**Last Updated:** 2026-03-26
**Maintained by:** @aiox-master
**Status:** ACTIVE (Reference during development, deprecated after Epic 9.2)
