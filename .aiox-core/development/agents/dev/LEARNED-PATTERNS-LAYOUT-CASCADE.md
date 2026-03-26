---
name: Layout Cascade and CSS Specificity Debugging (Quick Reference)
description: Fast reference for @dev when CSS changes aren't applying - identify which file to edit
type: dev-memory
created_at: "2026-03-26"
source_story: "STORY-9.2-UX-AJUSTES-LAYOUT (v1.5.151 fixes)"
priority: HIGH
applies_to:
  - Nuvemshop theme development
  - CSS debugging
  - Layout/component styling
---

# Quick Reference: When CSS Changes Don't Work

## 🔴 Problem: "I edited style-critical.tpl but nothing changed"

### Step 1: Check DevTools Computed Tab
```
F12 → Inspect Element → Computed tab
Look at which rule is BOLD (active) vs STRIKETHROUGH (overridden)
```

### Step 2: Identify Rule Source
Is the active rule coming from:
- ✅ `style-critical.tpl` → Keep editing there
- ❌ `layout.tpl` (inline `<style>`) → SWITCH to editing layout.tpl
- ❌ `settings.css_code` (Admin custom CSS) → Might override both

### Step 3: Check Specificity
If both files have the rule:

```css
/* style-critical.tpl */
.section-advertising { font-size: 0.7rem; }        /* Loses if layout.tpl has !important */

/* layout.tpl */
body .section-advertising { font-size: 0.875rem !important; }  /* Wins! */
```

**Rule:** `layout.tpl` uses `body .selector` (higher specificity) + `!important`
**Action:** Edit `layout.tpl`, not `style-critical.tpl`

---

## 🎯 Key Files and Their Purpose

| File | Role | Notes |
|------|------|-------|
| `style-critical.tpl` | Global component styling | Base styles, loaded first |
| `layout.tpl` (lines 230-500) | Inline override styles | Loaded AFTER style-critical, uses `!important` |
| `style-colors.scss.tpl` | Color variables | May be overridden in layout.tpl |
| `settings.css_code` | Admin custom CSS | Can inject colors/styles dynamically |

---

## 📋 Affected Elements by Layout.tpl Inline Styles

### Ad Bar (Banner)
```
File: layout.tpl lines 230-291
Elements: .section-advertising, .section-advertising__copy, etc.
!important: YES on most rules
Action: EDIT layout.tpl for ad bar changes
```

**Common issue:** Changing font-size in style-critical doesn't work → layout.tpl has it hardcoded

### Header
```
File: layout.tpl lines 293-319
Elements: .pg-header, .pg-header__logo, etc.
!important: YES on most rules
Action: EDIT layout.tpl for header changes
```

### Sections (Top/Header/Content)
```
File: layout.tpl lines 439-529
Elements: section.patagang-section-*, etc.
!important: NO, but specific selectors
Action: May work from style-critical or layout.tpl
```

---

## 🚀 Quick Decision Tree

```
Does CSS change work?
├─ YES → Continue
└─ NO → Check DevTools
    ├─ Rule from style-critical.tpl?
    │  └─ Try: Add !important or higher specificity
    │
    ├─ Rule from layout.tpl?
    │  └─ SWITCH: Edit layout.tpl instead
    │  └─ Match specificity: Use "body .selector" format
    │  └─ Ensure !important is present
    │
    ├─ Rule from settings.css_code (admin)?
    │  └─ Check: Admin → Theme → Custom CSS
    │  └─ Remove/modify there or override with !important
    │
    └─ Still not working?
       └─ Hard refresh: Ctrl+Shift+Delete
       └─ Check: FTP deploy (local changes don't affect FTP)
       └─ Verify: Browser cached old version
```

---

## 💾 Height & Overflow Patterns

### ❌ Pattern to AVOID

```css
.gallery-container {
    height: 100%;  /* Grows infinitely! */
    display: flex;
}
```

### ✅ Pattern to USE

```css
.parent-column {
    max-height: calc(100vh - 200px);  /* Viewport constraint */
    overflow-y: auto;  /* Scroll when content exceeds */
}

.gallery-container {
    max-height: 100%;  /* Cap to parent's max-height */
    overflow-y: auto;
}
```

---

## 🖼️ Responsive Image Patterns

### ❌ Not Responsive

```css
.modal-image {
    /* No constraints - loads at original size (2400x3000px) */
    width: auto;
    height: auto;
}
```

### ✅ Responsive

```css
.modal-image {
    max-width: 90vw !important;      /* 90% viewport width */
    max-height: 90vh !important;     /* 90% viewport height */
    width: auto !important;          /* Keep aspect ratio */
    height: auto !important;         /* Keep aspect ratio */
    object-fit: contain !important;  /* Fit inside box */
}
```

---

## 📱 Testing on 3 Breakpoints

Always test changes on:
- **Mobile:** < 576px (iPhone-sized)
- **Tablet:** 768px (iPad-sized)
- **Desktop:** 1200px+ (Computer)

DevTools responsive mode: `F12 → Toggle device toolbar (Ctrl+Shift+M)`

---

## 🐛 Common Debugging Commands

```bash
# Hard refresh (clear cache)
Ctrl+Shift+Delete → Select "All time" → Clear

# Inspect element
F12 → Click element icon → Click on page element

# Check computed CSS
Inspect → Computed tab → Look for BOLD (active) vs STRIKETHROUGH

# Check FTP deployment
Version console → 📦 PATAGANG vX.X.X
If old version shows: FTP hasn't deployed yet
```

---

## 📚 Reference Files

- **Full Pattern Guide:** `.aiox-core/data/learned-patterns-layout-cascade-issues.yaml`
- **Story:** `docs/stories/STORY-9.2-UX-AJUSTES-LAYOUT.md`
- **Bootstrap Patterns:** `.aiox-core/data/learned-patterns-bootstrap-css-override.yaml`

---

## ✨ Pro Tips

1. **Always check DevTools first** — it shows the truth
2. **Match the specificity** — if rule has `body .class !important`, use same format
3. **Don't assume load order** — verify with DevTools
4. **Hard refresh after changes** — browser caches aggressively
5. **Check FTP version** — local changes don't affect production until deployed

---

**Last Updated:** 2026-03-26
**Used In:** v1.5.151 fixes
**Maintainer:** @dev (Dex)

