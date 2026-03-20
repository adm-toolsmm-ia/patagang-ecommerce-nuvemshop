# Nuvemshop FTP Customization Standards - AIOX Reference

**Document Type:** Technical Reference (Framework L2 - Framework Templates)
**Status:** FINAL - Consolidated from Official Nuvemshop Docs
**Source:** https://atendimento.nuvemshop.com.br/pt_BR/codigo-fonte-ftp/
**Date:** 2026-03-20
**Scope:** FTP customization rules, limitations, and structure for Nuvemshop theme projects

---

## Executive Summary

This document consolidates **official Nuvemshop FTP customization constraints** with project-specific implementation patterns used in Patagang e-commerce. It serves as the authoritative reference for what CAN and CANNOT be modified via FTP in Nuvemshop stores.

**Critical Finding:** Accessing FTP disables automatic platform updates. This is a deliberate design constraint that affects deployment strategy.

---

## Part 1: Official Nuvemshop FTP Restrictions

### ✅ Elements THAT CAN Be Modified via FTP

**Visual & Layout Components:**
- Logos, banners, and watermarks across all pages
- Navigation bar positioning and custom menus
- Background images (all locations)
- Font types (within supported frameworks)
- Informational text on buttons
- Product category and subcategory displays in navigation
- Pop-ups containing product measurements (via `product.tpl`)
- Visibility toggling of layout elements (except footer store name and checkout pages)

**Product Page Customization:**
- Installment information display (per product basis)
- Cash/upfront payment discount messaging
- Search bar personalization and styling

**Advanced Options:**
- URL redirects to non-homepage entry points (via meta refresh tags)
- Custom CSS and JavaScript injection
- Template overrides in `.tpl` files

**Source:** Nuvemshop Official Support - "O que da para ser alterado no layout da minha loja via FTP"

---

### ❌ Elements THAT CANNOT Be Modified via FTP

**Checkout System:**
- Structure and layout of checkout pages
- Form field arrangement or removal
- Payment method display/organization
- Shipping calculation display
- Cart review flow
- **Exception:** Can replicate PRIMARY COLORS ONLY to match brand identity

**Automatic Platform Elements:**
- Sitemap generation (auto-generated, read-only)
- RSS feeds (auto-generated, read-only)
- Platform-managed metadata

**Form & Integration Elements:**
- Contact forms (backend integration locked)
- Customer registration/login forms
- Newsletter subscription (backend integration)
- **Reason:** Platform integrations prevent structural modification without breaking functionality

**Access Control:**
- IP-based access restrictions (NOT available)
- Email-based blocking (NOT available)
- User authentication modifications

**Footer Attribution:**
- Store name/branding in footer (MANDATORY - cannot be hidden)
- Platform attribution (required by terms)

**Source:** Nuvemshop Official Support

---

## Part 2: Critical Limitations & Warnings

### ⚠️ Automatic Updates STOP When Using FTP

**Critical Constraint:**
```
Ao abrir o FTP (código-fonte), a loja não receberá as atualizações
de melhorias automaticamente.
```

**Translation & Impact:**
"When accessing FTP (source code), the store will NOT receive automatic
platform improvements updates."

**Implications:**
1. **No Automatic Fixes:** Platform bug fixes do not apply automatically
2. **Manual Reapplication:** Any Nuvemshop platform improvements must be manually merged into customized files
3. **Update Tracking Required:** Must monitor Nuvemshop release notes and manually integrate improvements
4. **Support Implications:** "No platform support for applied modifications unless platform errors occur"

**Mitigation Strategy (AIOX Project):**
- Maintain version tracking (see `VERSIONING_WORKFLOW.md`)
- Document all customizations with comments
- Subscribe to Nuvemshop release notes
- Implement staged rollback strategy (see `.aiox-core/development/docs/FTP_DEPLOY_GUIDE.md`)
- Create baseline backups before modifications

**Source:** Nuvemshop Official Support - Critical Finding

---

### 🔐 Access Requirements

**FTP Access Availability:**
- NOT available on all Nuvemshop subscription plans
- Must verify plan eligibility before attempting FTP customizations
- Check Nuvemshop pricing page for FTP availability per tier

**Technical Requirements:**
- HTML, CSS, and JavaScript knowledge recommended
- Understanding of template syntax (`.tpl` files = Liquid/Template Language)
- FTP client software (command-line or GUI)
- Access to Nuvemshop control panel for credentials

**Alternative:** Hire Nuvemshop Certified Specialists for custom modifications

---

## Part 3: File Structure & Technical Organization

### Primary Template Files

| File Path | Purpose | Modifiable | Notes |
|-----------|---------|-----------|-------|
| `layouts/layout.tpl` | Master layout template | ✅ YES | Entry point for all pages |
| `product.tpl` | Product page template | ✅ YES | Product-specific overrides |
| `static/css/style-critical.tpl` | Critical CSS | ✅ YES | Inline styles, above-the-fold |
| `static/css/style-colors.scss.tpl` | Color definitions | ✅ YES | Theming variables |
| `static/css/style-async.scss.tpl` | Async/deferred CSS | ✅ YES | Below-fold styles |
| `static/checkout.scss.tpl` | Checkout styling | ⚠️ COLORS ONLY | Cannot modify structure |
| `static/js/store.js.tpl` | Main store JavaScript | ✅ YES | Custom behaviors |
| `static/js/external.js.tpl` | External dependencies | ✅ YES | jQuery, plugins, etc. |
| `static/js/external-no-dependencies.js.tpl` | Standalone libraries | ✅ YES | Lazysizes, Swiper, etc. |
| `snipplets/**/*.tpl` | Component templates | ✅ YES | Reusable components |

**Source:** Nuvemshop Base Theme v1.14.0 Documentation

---

### Directory Structure (Standard Nuvemshop Theme)

```
theme-root/
├── config/                          # Configuration files
├── layouts/
│   └── layout.tpl                  # Master layout
├── snipplets/                       # Reusable components
│   ├── banner-services/
│   ├── forms/
│   ├── grid/
│   ├── header/
│   ├── home/
│   ├── metas/
│   ├── navigation/
│   ├── payments/
│   ├── placeholders/
│   ├── product/
│   ├── shipping/
│   ├── shipping_suboptions/
│   ├── social/
│   ├── structured_data/
│   └── svg/
├── components/                      # Reusable components
├── static/
│   ├── css/
│   │   ├── style-critical.tpl      # Above-the-fold CSS
│   │   ├── style-colors.scss.tpl   # Colors & variables
│   │   ├── style-async.scss.tpl    # Deferred CSS
│   │   └── checkout.scss.tpl       # Checkout styles
│   ├── js/
│   │   ├── store.js.tpl            # Main store logic
│   │   ├── external.js.tpl         # jQuery + plugins
│   │   └── external-no-dependencies.js.tpl
│   └── images/
├── templates/                       # Dynamic templates
└── VERSION.json                     # Project version metadata

EXTERNAL LIBRARIES (Bundled):
├── Bootstrap Grid v4.1.3           # CSS framework
├── Swiper 4.4.2                    # Image carousel
└── jQuery 1.11.1                   # JavaScript framework
```

---

## Part 4: Template Language & Syntax

### Nuvemshop Template Engine

**Engine Type:** Liquid Template Language with Nuvemshop extensions
**File Extension:** `.tpl` (processed server-side)

**Common Variables & Filters:**
```liquid
{# Store metadata #}
{{ store_name }}
{{ store_description }}
{{ store_url }}

{# Product variables #}
{{ product.name }}
{{ product.price }}
{{ product.images }}

{# Page variables #}
{{ page.title }}
{{ page.description }}

{# Conditional rendering #}
{% if user.logged_in %}
  Show to logged-in users
{% endif %}

{# Loops #}
{% for product in products %}
  {{ product.name }}: {{ product.price }}
{% endfor %}
```

**Key Difference from Standard Liquid:** Nuvemshop adds platform-specific variables and filters for e-commerce functionality.

---

## Part 5: Patagang Project-Specific Patterns

### Version Tracking Integration

**Related Documentation:** `VERSIONING_WORKFLOW.md`

**Files Modified During Deployment:**
```
ftp-deploy/VERSION                   # Single source of truth
theme-deploy-corrigido/VERSION.json  # Metadata
theme-deploy-corrigido/static/js/version-info.js  # Browser display
layouts/layout.tpl                   # Version script loader
```

**Sync Process Before Each Deploy:**
```bash
cd ftp-deploy/
node sync-version.js {new-version}
npm run deploy:critical
```

**Post-Deploy Validation:**
- Clear Nuvemshop admin cache: Admin → Temas → Menu (⋯) → Limpar Cache
- Wait 3-5 minutes for CDN propagation
- Verify console: `window.__PATAGANG_VERSION__.version`

---

### Critical Files Modified in Patagang

| File | Change | Status | Deploy Type |
|------|--------|--------|-------------|
| `layouts/layout.tpl` | Version script loader | Modified | CRITICAL |
| `snipplets/header/header-advertising.tpl` | Banner customization | Modified | CRITICAL |
| `static/css/style-critical.tpl` | PDP column proportions | Modified | CRITICAL |
| `static/js/version-info.js` | Version display | Modified | CRITICAL |
| `theme-deploy-corrigido/VERSION.json` | Version metadata | Generated | AUTO |

**Critical Deploy:** Uses `npm run deploy:critical` to minimize impact and validate only essential files

**Related Documentation:** `FTP_DEPLOY_PADRONIZACAO_AIOX.md`

---

## Part 6: Security & Performance Considerations

### Performance Implications of FTP Customization

**File Loading Optimization:**
```
✅ CAN optimize:
- CSS minification and concatenation
- JavaScript async/defer attributes
- Image lazy-loading
- Critical CSS inlining
- Font loading strategy

❌ CANNOT modify:
- Platform core assets (auto-generated)
- Nuvemshop CDN routing
- Cache-control headers (platform-managed)
```

**Bundle Size Constraints:**
- Style-critical.tpl: Keep < 50KB (impacts above-fold rendering)
- External JavaScript: Lazy-load non-essential libraries
- Image optimization: Use Nuvemshop native compression

### Security Considerations

**Protected By Platform:**
- User data encryption (handled by Nuvemshop)
- Payment processing (handled by Nuvemshop)
- SQL injection protection (handled by Nuvemshop)

**Developer Responsibility:**
- Avoid hardcoding sensitive data in `.tpl` files
- Use Nuvemshop variables for secure data access
- Follow Nuvemshop security best practices in custom JavaScript
- Sanitize user input in custom forms

---

## Part 7: Common Customizations Guide

### Use Case: Add Custom Logo with Watermark

**CAN DO:** ✅ Fully supported
```liquid
<!-- In snipplets/header/header-logo.tpl -->
<div class="logo-wrapper">
  <img src="{{ store_url }}/static/images/logo.png" alt="{{ store_name }}">
  <div class="watermark">Custom Design</div>
</div>
```

**Location:** `snipplets/header/` directory

**Deploy Method:** `npm run deploy:critical` (header is critical)

---

### Use Case: Customize Product Page Layout

**CAN DO:** ✅ Fully supported
```liquid
<!-- In product.tpl -->
<div class="product-details">
  <h1>{{ product.name }}</h1>
  <div class="price">{{ product.price }}</div>

  <!-- Custom installment info -->
  {% if product.installment_count > 0 %}
    <div class="installments">
      {{ product.installment_count }}x de {{ product.installment_price }}
    </div>
  {% endif %}
</div>
```

**Deploy Method:** `npm run deploy` (full deploy safe)

---

### Use Case: Hide Checkout Field

**CANNOT DO:** ❌ Will break functionality
```liquid
<!-- DO NOT DO THIS -->
{% if form_field.name == "street_number" %}
  {# Hidden - BREAKS SHIPPING CALCULATION #}
{% endif %}
```

**Why:** Shipping calculation, address validation, and order processing depend on all fields.

**Alternative:** Style to hide visually while keeping functionally present
```liquid
<!-- CORRECT APPROACH -->
<div style="display: none;" aria-hidden="true">
  {{ form_field.street_number }}
</div>
```

---

### Use Case: Custom CSS Colors in Checkout

**CAN DO:** ✅ Partially supported (colors only)
```scss
// In static/checkout.scss.tpl
.checkout-button {
  background-color: #FF6B6B; /* Custom brand color */
  color: white;
}

.checkout-form input {
  border-color: #FF6B6B;
}
```

**Limitation:** Cannot modify form structure, field arrangement, or layout

---

## Part 8: Deployment Strategy for FTP Customizations

### Pre-Deployment Checklist (from AIOX standards)

See complete checklist: `.aiox-core/development/checklists/ftp-deploy-checklist.md`

**Quick Summary:**
1. ☐ All modifications in `theme-deploy-corrigido/` directory
2. ☐ Version synced: `node sync-version.js X.X.X`
3. ☐ All `.tpl` files validated for Liquid syntax
4. ☐ External dependencies checked (Bootstrap v4.1.3, Swiper 4.4.2, jQuery 1.11.1)
5. ☐ CSS critical path optimized (< 50KB)
6. ☐ No checkout structure modifications
7. ☐ No form field removals or restructuring
8. ☐ Backup created (automatic in FTP deploy script)

### Deployment Types

| Type | Command | Impact | Recovery Time |
|------|---------|--------|----------------|
| **Critical** | `npm run deploy:critical` | 2 files only | < 1 min |
| **Full** | `npm run deploy` | All files | 5-10 min |
| **Rollback** | `npm run rollback` | Previous version | < 5 min |

**Patagang Standard:** Use `npm run deploy:critical` for safety

---

## Part 9: Post-Deployment Validation

### Automated Validation Points

1. **Version Display**
   ```javascript
   // In browser console
   window.__PATAGANG_VERSION__.version  // Should match deployed version
   ```

2. **CSS Loading**
   ```javascript
   // In browser DevTools → Network tab
   // All .tpl CSS files should load with HTTP 200
   ```

3. **JavaScript Errors**
   ```javascript
   // In browser console
   // Should have NO errors (warnings OK)
   ```

4. **Critical Path Rendering**
   ```
   Page should render above-fold content within 2s (optimal < 1.5s)
   ```

### Manual Validation Checklist (QA responsibility)

- [ ] Admin console shows correct version
- [ ] Page loads without JavaScript errors
- [ ] Custom logos/banners display correctly
- [ ] Product pages render without layout issues
- [ ] Checkout buttons are visible and clickable
- [ ] Footer Nuvemshop attribution visible
- [ ] Cache cleared: Temas → Menu (⋯) → Limpar Cache
- [ ] Validated in multiple browsers (Chrome, Firefox, Safari, Edge)
- [ ] Validated on mobile (iOS Safari, Android Chrome)

---

## Part 10: Troubleshooting & Recovery

### Common Issues

**Problem:** Version still shows old number after deploy
```
Cause: Nuvemshop cache not cleared
Solution:
1. Admin → Temas → Menu (⋯) → Limpar Cache
2. Wait 3-5 minutes
3. Open store in incognito tab (Ctrl+Shift+N)
4. Hard refresh (Ctrl+Shift+Del) to clear browser cache
```

**Problem:** Custom CSS not applying
```
Cause: CSS cascade or specificity issue
Solution:
1. Check DevTools for CSS conflicts
2. Use !important temporarily to test
3. Increase selector specificity
4. Check critical.tpl load order
```

**Problem:** Images not displaying
```
Cause: Path incorrect or file not uploaded
Solution:
1. Verify images uploaded to /static/images/
2. Use {{ store_url }}/static/images/filename.ext
3. Check file permissions (644)
4. Clear CDN cache: Admin → Temas → Limpar Cache
```

**Problem:** Checkout broken after modifications
```
Cause: Form field removed or structure changed
Solution:
1. IMMEDIATE: Restore from backup via FTP
2. Never remove checkout form fields
3. Only customize styling, not structure
4. Test on staging before production
```

---

## Part 11: Documentation References

### Nuvemshop Official Resources

- **Main Support:** https://atendimento.nuvemshop.com.br/pt_BR/codigo-fonte-ftp/
- **Web Designer Docs:** https://docs.nuvemshop.com.br/help
- **Theme Templates:** Nuvemshop Base Theme v1.14.0 (included in backup)

### Patagang AIOX Documentation

| Document | Location | Purpose |
|----------|----------|---------|
| Versioning Workflow | `VERSIONING_WORKFLOW.md` | Version management system |
| Deployment Standard | `.aiox-core/development/docs/FTP_DEPLOY_GUIDE.md` | Complete deployment procedure |
| Deployment Task | `.aiox-core/development/tasks/deploy-ftp-standard.md` | Executable deployment task |
| Deployment Checklist | `.aiox-core/development/checklists/ftp-deploy-checklist.md` | Pre/post deployment validation |
| Deployment Workflow | `.aiox-core/development/workflows/ftp-deployment.yaml` | Workflow definition |
| Integration Docs | `.aiox-core/development/docs/FTP_DEPLOY_AIOX_INTEGRATION.md` | AIOX framework integration |

---

## Part 12: Gaps Between Official Docs and Patagang Implementation

### Findings from Consolidation

| Aspect | Official Nuvemshop | Patagang Implementation | Gap Resolution |
|--------|-------------------|------------------------|-----------------|
| **Version Tracking** | Not mentioned | Implemented via sync-version.js | AIOX adds version control |
| **Critical Files** | No prioritization | Critical = `npm run deploy:critical` | AIOX optimizes deployment |
| **Backup Strategy** | Implied | Implemented with auto-backup per deploy | AIOX adds safety mechanisms |
| **Deployment Validation** | Manual only | Semi-automated checklist | AIOX adds QA gates |
| **Rollback Procedure** | Not documented | Implemented with version history | AIOX adds recovery procedures |
| **Performance Optimization** | General guidance | Specific CSS budget (< 50KB) | AIOX adds metrics |
| **Cache Management** | Manual (Limpar Cache) | Documented in workflow | AIOX standardizes |

**Conclusion:** Patagang AIOX implementation EXTENDS official Nuvemshop standards with enterprise-grade practices while maintaining full compatibility.

---

## Part 13: Key Takeaways

### ✅ DO's (Officially Supported)
1. Modify layout.tpl, product.tpl, and snipplets freely
2. Customize colors, fonts, images across the theme
3. Add custom JavaScript in store.js.tpl
4. Modify CSS in style-critical.tpl and other style files
5. Use version tracking and staged deployments
6. Create backups before modifications
7. Monitor Nuvemshop release notes for platform updates

### ❌ DON'Ts (Officially Restricted)
1. Modify checkout page structure
2. Remove or restructure form fields
3. Hide footer store attribution
4. Rely on automatic platform updates (they stop)
5. Deploy without testing on staging
6. Skip post-deployment validation
7. Assume modifications work without cache clear

### ⚠️ Critical Risks
1. **Update Discontinuation:** FTP access = no automatic fixes from Nuvemshop
2. **Integration Breakage:** Form modifications = broken shipping/payments
3. **Cache Issues:** Changes won't appear without manual cache clear
4. **Form Field Changes:** Any structural change breaks backend validation

---

## Conclusion

Nuvemshop FTP customization is powerful but constrained. The Patagang AIOX project successfully navigates these constraints by:

1. **Documenting all restrictions** in this reference
2. **Implementing safe deployment** via standardized tasks
3. **Tracking changes** via versioning system
4. **Validating thoroughly** via QA gates
5. **Providing recovery** via documented rollback procedures

**This document serves as the authoritative reference** for all FTP-related decisions in Patagang and can be reused for future Nuvemshop e-commerce projects.

---

**Document Version:** 1.0
**Last Updated:** 2026-03-20
**Framework:** Synkra AIOX L2 (Framework Templates)
**Author:** @analyst (Research & Consolidation)
**Status:** FINAL - Ready for implementation reference
