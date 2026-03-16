# 🤝 HANDOFF: Architect → Developer

**From**: Aria (Architect) 🏛️
**To**: Dex (Developer) @dev
**Date**: 2026-03-15
**Status**: READY FOR CODING
**Complexity**: STANDARD

---

## TL;DR for @dev

4 **trivial** HTML/CSS changes across 2-3 files. **Zero architectural risk**, all limitations identified & mitigated. **FTP deploy ready-to-go**.

**Est. Time**: 30 minutes coding + testing

---

## What You're Getting

✅ **architecture-analysis-patagang-v3.md** (👈 READ THIS FIRST)
- Complete codebase map
- CSS cascata documented
- All limitations analyzed
- Testing strategy included

This handoff = executive summary + implementation checklists

---

## 4 Adjustments: Implementation Order

### 1️⃣ ADJUST #2: Banner Responsive Mobile
**File**: `theme-deploy-corrigido/layouts/layout.tpl`
**Lines**: Before line 192 (before category/search/404 overrides)
**Type**: CSS only
**Complexity**: ⭐ TRIVIAL

**Add this CSS block:**
```css
{# Banner responsive mobile #}
{% if template == 'category' or template == 'search' %}
<style>
@media (max-width: 768px) {
  .category-banner {
    max-height: 200px;
    overflow: hidden;
    display: flex;
    align-items: center;
  }
  .category-banner img {
    width: 100%;
    height: auto;
    object-fit: contain;
    object-position: center;
  }
}
</style>
{% endif %}
```

**Why it works**:
- `object-fit: contain` = entire image visible (no crop)
- `height: auto` = maintains aspect ratio
- `max-height` = prevents overflow
- Media query = mobile only

**Testing**:
- Mobile 480px: banner visible, no text crop
- Mobile 768px: banner visible
- Desktop: visually unchanged

---

### 2️⃣ ADJUST #4: Help Button Design (Clean, Less Loud)
**File**: `theme-deploy-corrigido/layouts/layout.tpl`
**Lines**: 196-229 (REPLACE ENTIRE BLOCK)
**Type**: CSS override
**Complexity**: ⭐ TRIVIAL

**Current code** (lines 196-229):
```css
<style>
body .pg-help-btn {
  background: #EAFE67 !important;
}
...
```

**New code** (REPLACE):
```css
{# Help Button Design - PATAGANG v3: Clean, neutral gray #}
<style>
body .pg-help-btn {
  background: #F0F0F0 !important;
  color: #666666 !important;
  border: 1px solid #E0E0E0 !important;
  padding: 12px 8px !important;
}
body .pg-help-btn:hover {
  background: #E8E8E8 !important;
  color: #333333 !important;
  border: 1px solid #D0D0D0 !important;
  padding-right: 12px !important;
}
body .pg-help-btn__text {
  font-weight: 400 !important;
  font-size: 12px !important;
  color: #666666 !important;
}
body .pg-help-btn__icon {
  color: #666666 !important;
  width: 20px !important;
  height: 20px !important;
}
@media (max-width: 768px) {
  body .pg-help-btn {
    top: 50% !important;
    transform: translateY(-50%) !important;
    right: 0 !important;
    z-index: 9990 !important;
    padding: 10px 6px !important;
  }
  body .pg-help-btn__text { font-size: 11px !important; }
}
body .btn-whatsapp-left {
  background-color: #EAFE67 !important;
}
body .btn-whatsapp-left:hover {
  background-color: #d4e65d !important;
}
body .btn-whatsapp-left span {
  font-weight: 500 !important;
  font-size: 12px !important;
  color: #1A1A1A !important;
}
@media (max-width: 480px) {
  body .pg-help-btn__text { font-size: 11px !important; }
  body .btn-whatsapp-left span { font-size: 11px !important; }
}
</style>
```

**Why it works**:
- #F0F0F0 (light gray) = neutral, non-competing
- #666666 (medium gray) = readable but subtle
- Hover #E8E8E8 = user knows it's clickable
- Removed yellow (#EAFE67) = clean aesthetic

**Testing**:
- Desktop: button appears gray, not yellow
- Hover: slightly darker gray
- Mobile: smaller text, same gray color
- Accessibility: no color change needed, contrast is fine

---

### 3️⃣ ADJUST #1: WhatsApp Condicional (Hide from non-product pages)
**File**: `theme-deploy-corrigido/snipplets/whatsapp-left.tpl`
**Lines**: 1-5 (WRAP ENTIRE CONTENT)
**Type**: Twig conditional
**Complexity**: ⭐ TRIVIAL

**Current code**:
```tpl
<a href="https://api.whatsapp.com/send/?phone=5547996263577&text&type=phone_number&app_absent=0" target="_blank" class="btn-whatsapp-left" aria-label="{{ 'Compre pelo WhatsApp' | translate }}">
    {% include "snipplets/svg/whatsapp.tpl" with {svg_custom_class: "icon-inline icon-2x"} %}
    <span>Compre pelo Whats</span>
</a>
```

**New code** (WRAP):
```tpl
{# PATAGANG: Show WhatsApp button ONLY on product/search/category pages #}
{% if template == 'product' or template == 'search' or template == 'category' %}
<a href="https://api.whatsapp.com/send/?phone=5547996263577&text&type=phone_number&app_absent=0" target="_blank" class="btn-whatsapp-left" aria-label="{{ 'Compre pelo WhatsApp' | translate }}">
    {% include "snipplets/svg/whatsapp.tpl" with {svg_custom_class: "icon-inline icon-2x"} %}
    <span>Compre pelo Whats</span>
</a>
{% endif %}
```

**Why it works**:
- Twig `template` variable = global in NuvemShop
- `template == 'product'` = product detail page
- `template == 'search'` = search results
- `template == 'category'` = category listing
- Button doesn't render = no CSS conflicts, clean HTML

**Testing**:
- Homepage: button NOT visible ✓
- Category: button visible ✓
- Search: button visible ✓
- Product: button visible ✓
- Contact: button NOT visible ✓
- Cart: button NOT visible ✓

---

### 4️⃣ ADJUST #3: Plugin Reviews (Verify + Optional CSS Fix)
**File**: `theme-deploy-corrigido/templates/product.tpl`
**Lines**: 33-38 (VERIFY ONLY)
**Type**: Already exists, possible CSS tweak
**Complexity**: ⭐ VERIFY FIRST

**Current code** (already correct):
```tpl
{# Seção Avaliações e Perguntas (Konfidency) - entre produto e similares #}
<div class="pg-pdp-reviews-section">
    <div class="container">
        <div id="reviewsapp"></div>
    </div>
</div>
```

**Status**: ✅ PLUGIN ALREADY CONFIGURED

**What to do**:
1. Open `/admin` → Settings → Comments & Reviews
2. Check if plugin is **ENABLED**
3. If enabled: Done! Plugin will auto-inject content
4. If disabled: Enable it

**If plugin loads but appears hidden** (rare):
Add this to layout.tpl (after line 159):
```css
{% if template == 'product' %}
<style>
  body #reviewsapp {
    position: relative !important;
    z-index: 10 !important;
    display: block !important;
    visibility: visible !important;
    opacity: 1 !important;
    min-height: 200px;
  }
</style>
{% endif %}
```

**Testing**:
- Open product page
- F12 → Elements → search "reviewsapp"
- If found + has content = working ✓
- If found but empty = plugin needs activation in admin
- If not found = plugin disabled in settings

---

## 🎯 Exact Changes Summary

| File | Lines | Change | Risk | Time |
|------|-------|--------|------|------|
| layout.tpl | Insert before 192 | Add banner CSS | ✅ ZERO | 2 min |
| layout.tpl | 196-229 | Replace help button CSS | ✅ ZERO | 5 min |
| whatsapp-left.tpl | 1-5 | Wrap Twig conditional | ✅ ZERO | 3 min |
| product.tpl | 33-38 | Verify only (no code change) | ✅ ZERO | 2 min |
| **Total** | — | — | — | **12 min** |

---

## ✅ Pre-Implementation Checklist

```
□ Read architecture-analysis-patagang-v3.md (full context)
□ Have theme-deploy-corrigido folder open
□ Have layout.tpl, whatsapp-left.tpl, product.tpl ready
□ CSS code copied and tested locally (if possible)
□ Understand CSS cascata (read section 1.2 of architecture doc)
```

## ✅ Testing Checklist (After Implementation)

```
Test on MOBILE (480px, 768px):
□ Homepage: WhatsApp button NOT visible
□ Category: WhatsApp button visible
□ Product: WhatsApp button visible
□ Banner: fully visible, no text crop
□ Help button: gray not yellow
□ Help button: clickable, sidebar opens

Test on DESKTOP (1920px):
□ Category: banner responsive
□ Help button: gray color matches
□ WhatsApp button: visible on product/search/category
□ No visual regressions

Test ADMIN:
□ Settings → Comments & Reviews → plugin enabled?
□ FTP deployment successful?
□ LAST_DEPLOY_VERSION.txt updated?
```

## 🔧 Notes for @dev

**CSS Cascata**: Layout.tpl `<style>` overrides EVERYTHING (style-critical, style-async, settings.css_code). That's intentional - it's the final override layer.

**Mobile First**: All media queries already in place. Just need to add the new ones for banner.

**FTP Deploy**: Script handles automatically. Just push files to FTP.

**No JS needed**: All changes are HTML/CSS only. Zero JavaScript modifications.

**Backwards Compatible**: Changes don't break existing functionality. 100% additive.

---

## 🚀 Implementation Steps

1. **Backup** current files (git is fine)
2. **Edit layout.tpl**: Add banner CSS + replace help button CSS
3. **Edit whatsapp-left.tpl**: Add Twig conditional
4. **Verify product.tpl**: Check reviews plugin in admin
5. **Test mobile + desktop**
6. **Commit & Push to FTP**
7. **Monitor deploy version** (check LAST_DEPLOY_VERSION.txt)

---

## 📞 Questions During Implementation

**Q: "Why Twig conditional instead of CSS display:none?"**
A: Performance + semantics. Doesn't render HTML if not needed.

**Q: "Will CSS override break other things?"**
A: No. Layout.tpl is the final override layer. Nothing after it.

**Q: "Mobile srcset in category-banner already correct?"**
A: Yes. We're just adding CSS responsiveness on top.

**Q: "Do I need to touch style-help-sidebar.css.tpl?"**
A: No. Layout.tpl overrides it anyway (!important).

---

## 📊 File Dependency Graph

```
layout.tpl (MASTER)
  ├─→ whatsapp-left.tpl (snippet included at line 319)
  ├─→ help-sidebar.tpl (snippet included at line 322)
  ├─→ product.tpl (if template == 'product')
  └─→ category-banner.tpl (included by category.tpl)

Changes to make:
✏️  layout.tpl (2 CSS blocks)
✏️  whatsapp-left.tpl (1 Twig conditional)
🔍 product.tpl (verify only)

Zero circular dependencies. Safe to modify.
```

---

## 🎬 Next Steps After Dev Implementation

1. **@dev**: Implement + test locally
2. **@qa**: Run test suite (if exists)
3. **@devops**: Deploy to staging
4. **Manual Testing**: Mobile/desktop verification
5. **@devops**: Deploy to production
6. **Monitor**: Check analytics for WhatsApp clicks drop

---

**Prepared by**: Aria (Architect) 🏛️
**Ready for**: Dex (Developer) @dev
**Time to Implement**: 30 minutes
**Risk Level**: 🟢 ZERO
