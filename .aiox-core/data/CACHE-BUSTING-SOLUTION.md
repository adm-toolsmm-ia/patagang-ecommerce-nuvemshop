# Cache Busting Solution — Nuvemshop CSS Auto-Refresh

**Problem:** Nuvemshop caches CSS files aggressively  
**Current Symptom:** CSS changes don't appear until cache expires (hours/days)  
**Solution:** Add version query strings to CSS includes  

---

## 🔍 WHAT WE FOUND

In `layout.tpl`, CSS includes vary:

### Already Has Cache Busting ✅
```html
<link rel="stylesheet" href="{{ 'css/style-home-v2.css' | static_url }}?v=2026-02-03T04-40">
<link rel="stylesheet" href="{{ 'css/product-card-v3.css' | static_url }}?v=2026-02-14">
```

### Missing Cache Busting ❌
```html
<link rel="preload" href="{{ 'css/style-colors.scss.tpl' | static_url }}" as="style" />
<link rel="stylesheet" href="{{ 'css/style-async.scss.tpl' | static_url }}" ...>
```

### Inline CSS (Can't Cache Bust) ⚠️
```liquid
{% include "static/css/style-critical.tpl" %}  ← Included directly
```

---

## ✅ AUTOMATIC CACHE BUSTING STRATEGY

### Option 1: Add Version to CSS Links (RECOMMENDED)
Update `layout.tpl` to add `?v={{VERSION}}` to all CSS:

```liquid
<!-- Before -->
<link rel="stylesheet" href="{{ 'css/style-colors.scss.tpl' | static_url }}" as="style" />

<!-- After -->
<link rel="stylesheet" href="{{ 'css/style-colors.scss.tpl' | static_url }}?v={{ site.now | date: '%Y%m%d%H%M%S' }}" as="style" />
```

**Benefit:** Forces browser to re-fetch on every deploy  
**Downside:** Works with Nuvemshop's `site.now` filter (need to verify)

### Option 2: Modify Deploy Script (EASIER)
Add automatic version injection when deploying:

```javascript
// In deploy.js phase 5 (before FTP upload)
// Replace CSS URLs to add version query string

const layoutContent = fs.readFileSync('theme-deploy-corrigido/layouts/layout.tpl', 'utf8');
const timestamp = new Date().toISOString().replace(/[^0-9]/g, '').slice(0, 14);

const updatedLayout = layoutContent.replace(
  /href="([^"]*\.css[^"]*)"(?!\?v=)/g,
  `href="$1?v=${timestamp}"`
);

fs.writeFileSync('theme-deploy-corrigido/layouts/layout.tpl', updatedLayout);
```

**Benefit:** Automatic, no manual changes needed  
**Downside:** Modifies template on every deploy (commits show version changes)

### Option 3: HTTP Headers (BEST BUT REQUIRES SERVER CONTROL)
Add `.htaccess` with cache control headers:

```apache
# Force CSS refresh every hour
<FilesMatch "\.(css|scss)$">
  Header set Cache-Control "max-age=3600, must-revalidate"
</FilesMatch>

# Or disable caching entirely
<FilesMatch "\.(css|scss)$">
  Header set Cache-Control "no-cache, no-store, must-revalidate"
</FilesMatch>
```

**Benefit:** Server-level, works globally  
**Downside:** Need FTP access to `.htaccess` (Nuvemshop may restrict)

---

## 🎯 RECOMMENDED: Quick Fix for v1.5.139

To force cache clear for **current banner color fix**, add version to `layout.tpl`:

```bash
# Find line with style-colors.scss.tpl and add ?v=v1.5.139
sed -i 's/style-colors\.scss\.tpl'"'"' /style-colors.scss.tpl?v=v1.5.139"/' theme-deploy-corrigido/layouts/layout.tpl

# Find line with style-async.scss.tpl and add ?v=v1.5.139
sed -i 's/style-async\.scss\.tpl'"'"' /style-async.scss.tpl?v=v1.5.139"/' theme-deploy-corrigido/layouts/layout.tpl
```

Then deploy v1.5.140 with this change.

---

## ✅ PERMANENT FIX

Modify deploy script to auto-inject version:

```javascript
// Add this to phase 5 (before FTP upload)

function injectVersionIntoCSSLinks(layoutPath, version) {
  let content = fs.readFileSync(layoutPath, 'utf8');
  
  // Add ?v=VERSION to all CSS files that don't already have it
  content = content.replace(
    /href="([^"]*\.(css|scss\.tpl)[^"]*)"/g,
    (match, url) => {
      if (url.includes('?v=')) return match; // Skip if already has version
      return `href="${url}?v=${version}"`;
    }
  );
  
  fs.writeFileSync(layoutPath, content);
}
```

---

## 📝 HOW TO IMPLEMENT

### For Immediate Fix (v1.5.140)
1. Manually add `?v=v1.5.140` to CSS links in `layout.tpl`
2. Deploy v1.5.140
3. Test banner color in production (should show transparent now)

### For Permanent Fix
1. Update `deploy.js` to auto-inject version
2. Test with next deployment
3. No more cache issues

---

## 🧪 HOW TO TEST

```bash
# After deploying with cache busting:

1. Open: https://www.patagang.com.br/
2. F12 → Network tab
3. Reload (Ctrl+Shift+R = hard refresh)
4. Look for CSS files
5. Check "Name" column:
   - Should show: style-colors.scss.tpl?v=v1.5.140
   - If yes: ✅ Cache busting working
   - If no: ❌ Still using old cache

6. If still yellow:
   - Clear browser cache: Ctrl+Shift+Delete
   - Clear Nuvemshop cache (Admin panel if available)
   - Wait 5 minutes (CDN propagation)
```

---

## 💡 NUVEMSHOP CACHE SPECIFICS

Nuvemshop uses multiple cache layers:
1. **Browser cache** (client-side) → Fixed by query string
2. **CDN cache** (Akamai/CloudFlare) → Fixed by query string + CDN purge
3. **Nuvemshop cache** (server-side) → May need manual purge

**If still yellow after cache busting:**
- Option A: Wait 1-2 hours (CDN auto-refresh)
- Option B: Contact Nuvemshop support to purge cache
- Option C: Change filename (e.g., style-colors-v2.scss.tpl)

---

## 📋 CHECKLIST FOR NEXT DEPLOY

Before deploying CSS changes:
- [ ] Add `?v=VERSION` to all CSS links
- [ ] Test with hard refresh (Ctrl+Shift+R)
- [ ] Verify Network tab shows new version
- [ ] Wait 5 minutes for CDN propagation
- [ ] If still cached, ask Nuvemshop to purge

---

**Quick Fix:** Add ?v=v1.5.140 to CSS links + deploy
**Permanent Fix:** Modify deploy.js to auto-inject version
**Expected Result:** CSS changes visible immediately after deploy
