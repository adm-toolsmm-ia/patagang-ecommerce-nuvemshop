# Comparação Visual — Layout.tpl Antes vs Depois

**Objetivo:** Mostrar exatamente como ficará o layout.tpl após simplificação
**Data:** 2026-03-28

---

## VISTA MACRO (ESTRUTURA)

### ANTES (v1.5.245) — 974 linhas

```
layout.tpl (974 linhas)
├─ HEAD (linhas 1-387)
│  ├─ HTML basics (1-51)
│  │  └─ DOCTYPE, html, meta, link preload
│  ├─ ✅ CRITICAL CSS SECTION (52-78)
│  │  ├─ <style>
│  │  ├─ fonts component
│  │  ├─ include: style-critical.tpl (151 KB) ✅
│  │  ├─ include: style-menu-patagang.css.tpl (8 KB) ✅
│  │  ├─ include: style-filters-patagang.css.tpl (14 KB) ✅
│  │  ├─ include: style-help-sidebar.css.tpl (6 KB) ✅
│  │  ├─ include: style-whatsapp-button.css.tpl (1 KB) ✅
│  │  ├─ </style>
│  │  └─ colors inline (25 KB) ✅
│  ├─ ❌ BACKGROUND RESET INLINE CSS (80-107) — 28 linhas
│  ├─ ❌ GALLERY/BANNER INLINE CSS (109-248) — 140 linhas
│  ├─ ❌ ASYNC LINK (252) — 164 KB CSS corrompido
│  ├─ ⚠️ HOME V2 LINK (255-258) — 24 KB condicional
│  ├─ ⚠️ PRODUCT CARD V3 LINK (261) — 7 KB
│  ├─ ✅ BLOG ASYNC LINK (265) — 4 KB
│  ├─ ✅ CUSTOM SETTINGS (269-271)
│  ├─ ⚠️ AD BAR OVERRIDE INLINE CSS (273-357) — 85 linhas
│  ├─ ✅ HEADER STYLING (360-386) — 27 linhas
│  ├─ ✅ CATEGORY/SEARCH OVERRIDES (390-399)
│  ├─ ✅ BANNER RESPONSIVE (401-419)
│  ├─ ✅ HELP BUTTON STYLING (421-449)
│  └─ ✅ MOBILE SPACING FIX (450+)
└─ BODY (linhas 388-974)
   └─ HTML content (mantido intacto)
```

**Total CSS incluído:** 450 KB

---

### DEPOIS (v1.5.246 proposto) — ~520 linhas

```
layout.tpl (~520 linhas)
├─ HEAD (linhas 1-~160)
│  ├─ HTML basics (1-51)
│  │  └─ DOCTYPE, html, meta, link preload
│  ├─ ✅ CRITICAL CSS SECTION (52-78) — SIMPLIFICADO
│  │  ├─ <style>
│  │  ├─ fonts component
│  │  ├─ include: style-critical.tpl (151 KB) ✅
│  │  ├─ include: style-menu-patagang.css.tpl (8 KB) ✅
│  │  ├─ include: style-filters-patagang.css.tpl (14 KB) ✅
│  │  ├─ include: style-help-sidebar.css.tpl (6 KB) ✅
│  │  ├─ include: style-whatsapp-button.css.tpl (1 KB) ✅
│  │  ├─ </style>
│  │  └─ colors inline (25 KB) ✅
│  ├─ ✅ MINIMAL HEADER/ESSENTIAL INLINE CSS (~20 linhas)
│  │  ├─ Custom settings (269-271)
│  │  ├─ Header styling (essential only)
│  │  └─ (removed redundant/corrompido)
│  ├─ ✅ BLOG ASYNC LINK (265) — 4 KB
│  └─ (resto das custom rules, se ainda necessário)
└─ BODY (linhas ~160-~520)
   └─ HTML content (mantido intacto)
```

**Total CSS incluído:** 182-209 KB (redução de 59%)

---

## VISTA DETALHADA (LINHA POR LINHA)

### SEÇÃO HEAD — LINHAS 1-51 (✅ MANTÉM-SE IDÊNTICO)

```tpl
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />

        {# ... linhas 14-51: SEO, robots, canonical, etc. ... #}
        {# TODAS MANTIDAS IDENTICAMENTE #}

    </head>
```

**Linhas:** 1-51 (idêntico)

---

### SEÇÃO CRITICAL CSS — LINHAS 52-78 (✅ MANTÉM-SE COM PEQUENAS MUDANÇAS)

#### ANTES (linhas 52-78 + 80-107)

```tpl
        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

        {# Critical CSS needed to show first elements of store while CSS async is loading #}

        <style>

            {# Font families #}

            {{ component(
                'fonts',{
                    font_weights: '300, 400, 700',
                    font_settings: 'settings.font_headings, settings.font_rest'
                })
            }}

            {% include "static/css/style-critical.tpl" %}
            {% include "static/css/style-menu-patagang.css.tpl" %}
            {% include "static/css/style-filters-patagang.css.tpl" %}
            {% include "static/css/style-help-sidebar.css.tpl" %}
            {% include "static/css/style-whatsapp-button.css.tpl" %}
        </style>

        {# Colors and fonts used from settings.txt and defined on theme customization #}

        {{ 'css/style-colors.scss.tpl' | static_url | static_inline }}

        {# PATAGANG v1.5.31: CRITICAL FIX - Reset body background after style-colors loads #}
        {# Reason: style-colors.scss defines body { background-color: $main-background } #}
        {# If $main-background is gray/non-white, it cascades to ad-bar and header sections #}
        {# Fix: Explicit white background + section-level transparent overrides #}
        <style>
            /* CRITICAL: Force body background to WHITE to prevent gray cascade */
            body {
                background-color: #ffffff !important;
                background-image: none !important;
            }

            /* CRITICAL: Ad bar section must match header (WHITE background) */
            /* PATAGANG v1.5.152: Changed from transparent to white (#ffffff) */
            section.patagang-section-top {
                background-color: #ffffff !important;
                background-image: none !important;
            }

            /* CRITICAL: Header section stays transparent to inherit body color */
            section.patagang-section-header {
                background-color: transparent !important;
            }

            /* CRITICAL: Main content section is explicit white (no inheritance issues) */
            main.patagang-section-content {
                background-color: #ffffff !important;
            }
        </style>
```

#### DEPOIS (linhas 52-78 — removido background reset)

```tpl
        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

        {# Critical CSS needed to show first elements of store while CSS async is loading #}

        <style>

            {# Font families #}

            {{ component(
                'fonts',{
                    font_weights: '300, 400, 700',
                    font_settings: 'settings.font_headings, settings.font_rest'
                })
            }}

            {% include "static/css/style-critical.tpl" %}
            {% include "static/css/style-menu-patagang.css.tpl" %}
            {% include "static/css/style-filters-patagang.css.tpl" %}
            {% include "static/css/style-help-sidebar.css.tpl" %}
            {% include "static/css/style-whatsapp-button.css.tpl" %}
        </style>

        {# Colors and fonts used from settings.txt and defined on theme customization #}

        {{ 'css/style-colors.scss.tpl' | static_url | static_inline }}

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-blog.scss.tpl' | static_url }}" media="print" onload="this.media='all'">

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | raw }}
        </style>
```

**Mudanças:**
- ❌ REMOVER linhas 80-107 (background reset)
- ✅ MANTER linhas 52-78 (critical CSS)
- ✅ Mover link para blog CSS para aqui (era linha 265)
- ✅ Mover custom settings para aqui

---

### SEÇÃO INLINE CSS REMOVIDA — LINHAS 80-248 (❌ DELETADO)

#### ANTES (linhas 80-248)

```tpl
        {# PATAGANG v1.5.31: CRITICAL FIX - Reset body background ... #}
        <style>
            body {
                background-color: #ffffff !important;
                ... 25 linhas ...
            }
        </style>

        {# PATAGANG v1.5.32: Product Layout Refinements ... #}
        {# Fase 1: CSS-only improvements for gallery + card alignment #}
        {# PATAGANG v1.5.34: Gallery 2-Column Grid ... #}
        {# PATAGANG v1.5.35: Gallery Height Alignment ... #}
        {# PATAGANG v1.5.153-FIX: Banner Services 3-Column Grid #}
        <style>
            /* ===== BANNER SERVICES (HOME) — 3 Colunas ===== */
            .js-informative-banners {
                display: grid !important;
                grid-template-columns: repeat(3, 1fr) !important;
                ... ~130 linhas de CSS para gallery, banner, card ...
            }
        </style>
```

#### DEPOIS

```
(DELETADO COMPLETAMENTE)
(Será re-adicionado em arquivo separado se necessário)
```

**Impacto:**
- Redução: -168 linhas
- Redução CSS: -~16 KB

---

### SEÇÃO ASYNC CSS — LINHA 252 (❌ DELETADO)

#### ANTES (linha 252)

```tpl
        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss.tpl' | static_url }}" media="print" onload="this.media='all'">
```

#### DEPOIS

```
(DELETADO COMPLETAMENTE)
```

**Impacto:**
- Redução: -1 linha
- Redução CSS: -164 KB (file removido)
- ✅ Elimina "content:??" error

---

### SEÇÃO HOME V2 & PRODUCT CARD — LINHAS 255-261 (⚠️ AVALIAR)

#### ANTES (linhas 255-261)

```tpl
        {# HOME V2 - Estilos específicos da nova home page #}
        {% if template == 'home' %}
            <link rel="stylesheet" href="{{ 'css/style-home-v2.css' | static_url }}?v=2026-02-03T04-40">
        {% endif %}

        {# PRODUCT CARD V3 - Cards compactos e limpos (categoria, busca, similares, 404) #}
        <link rel="stylesheet" href="{{ 'css/product-card-v3.css' | static_url }}?v=2026-02-14">
```

#### DEPOIS (se validado)

```tpl
        {# PRODUCT CARD V3 - Verificar se necessário ou mover para critical #}
        {# <link rel="stylesheet" href="{{ 'css/product-card-v3.css' | static_url }}?v=2026-02-14"> #}

        {# HOME V2 - Validar se necessário antes de remover #}
        {# {% if template == 'home' %} #}
        {#    <link rel="stylesheet" href="{{ 'css/style-home-v2.css' | static_url }}?v=2026-02-03T04-40"> #}
        {# {% endif %} #}
```

**Status:** ⚠️ COMENTADO (não deletado até validação local passar)

**Impacto:**
- Potencial redução: -4 linhas, -31 KB (se ambos removidos)
- Risco: HOME PAGE pode quebrar (VALIDAR ANTES)

---

### SEÇÃO ADVERTISING & HEADER — LINHAS 273-386 (⚠️ REVISAR)

#### ANTES (linhas 273-357 + 360-386)

```tpl
        {# Ad Bar: override final (PATAGANG v1.5.17+ - Static layout, no fixed positioning) #}
        {# CRITICAL: Ensure advertising section remains VISUALLY SEPARATE from header #}
        {# PATAGANG v1.5.151: Force transparency - remove any inherited background from parent/style-colors #}
        {% if settings.ad_bar and settings.ad_text %}
        <style>
            body .section-advertising {
                position: static !important;
                z-index: auto !important;
                ... ~70 CSS rules ...
            }
        </style>
        {% endif %}

        {# Header styling - ensure visual independence from advertising bar #}
        <style>
            {# Header container: transparent by default, can have bg from design #}
            body .pg-header {
                background: transparent !important;
                border: none !important;
                clear: both !important;
            }

            {# Ensure header has proper spacing from ad bar #}
            body.has-ad-bar .pg-header {
                ... ~20 CSS rules ...
            }
        </style>
```

#### DEPOIS (se validado em style-critical)

```
(DELETADO SE REDUNDANTE COM style-critical.tpl)
ou
(MANTIDO SE NECESSÁRIO)
```

**Status:** ⚠️ REVISAR (depende de validação com grep)

---

### SEÇÃO CATEGORY/SEARCH/HELP/MOBILE — RESTO (✅ MANTÉM-SE)

#### ANTES (linhas 390-974)

```tpl
        {# Override V3: listagem (categoria/busca) - Margens do Header #}
        {% if template == 'category' or template == 'search' %}
        <style>
        /* Reduce header margin on Desktop */
        ... rules ...
        </style>
        {% endif %}

        {# Banner responsive mobile - PATAGANG v3 #}
        {% if template == 'category' or template == 'search' %}
        <style>
        @media (max-width: 768px) {
          .category-banner {
            ... rules ...
          }
        }
        </style>
        {% endif %}

        {# Override final: Botões laterais - Help Button ... #}
        <style>
        body .pg-help-btn {
            ... ~100 CSS rules para help button, whatsapp, product listing, mobile spacing ...
        }
        </style>

        ... HTML Body content (intacto) ...

    </head>
    <body class="...">
        ... HTML content, loops, snippets, etc. ...
    </body>
</html>
```

#### DEPOIS (idêntico)

```tpl
        {# Override V3: listagem (categoria/busca) - Margens do Header #}
        {% if template == 'category' or template == 'search' %}
        <style>
        /* Reduce header margin on Desktop */
        ... rules ... ✅ MANTÉM-SE
        </style>
        {% endif %}

        ... (todo o resto mantido intacto) ...
    </body>
</html>
```

**Status:** ✅ MANTÉM-SE IDÊNTICO

---

## RESUMO: MUDANÇAS LADO A LADO

| Seção | Antes | Depois | Mudança | Motivo |
|-------|-------|--------|---------|--------|
| HTML basics (1-51) | ✅ | ✅ | Nenhuma | Essential |
| Critical CSS (52-78) | ✅ | ✅ | Nenhuma | Essential |
| Colors inline (78) | ✅ | ✅ | Nenhuma | Essential |
| Background reset (80-107) | ❌ | ✅ | REMOVE | Redundante |
| Gallery/banner CSS (109-248) | ❌ | ✅ | REMOVE | Separar em arquivo |
| Async CSS link (252) | ❌ | ✅ | REMOVE | Corrompido |
| Home V2 link (255-258) | ❌ | ⚠️ | COMENTAR | Validar antes |
| Product card link (261) | ❌ | ⚠️ | COMENTAR | Validar antes |
| Blog CSS link (265) | ✅ | ✅ | MANTER | Essential |
| Settings CSS (269-271) | ✅ | ✅ | MANTER | Essential |
| Ad bar override (273-357) | ⚠️ | ⚠️ | REVISAR | Pode ser redundante |
| Header styling (360-386) | ✅ | ✅ | MANTER | Essential |
| Category/search (390-399) | ✅ | ✅ | MANTER | Essential |
| Banner responsive (401-419) | ✅ | ✅ | MANTER | Essential |
| Help button (421-449) | ✅ | ✅ | MANTER | Essential |
| Mobile spacing (450+) | ✅ | ✅ | MANTER | Essential |
| HTML body (388-974) | ✅ | ✅ | MANTER | Essential |

---

## ESTIMATIVA DE LINHAS FINAIS

### CÁLCULO

```
ANTES (v1.5.245):
- Total: 974 linhas

DEPOIS (v1.5.246):
- Total = 974 - 168 (background reset + gallery/banner) - 1 (async link) - 4 (home v2) - 1 (product card) + 0 (outras mudanças)
- Total = 974 - 174 = 800 linhas (sem avaliação)

OU (se adicionar comentários ao invés de deletar):
- Total = 974 - 168 - 1 = 805 linhas

OU (se adicionar back em arquivo separado):
- Total = 974 - 168 - 1 = 805 linhas (já que será novo arquivo)

ESTIMATIVA FINAL: 800-850 linhas
COMPARAÇÃO: 974 → 800 (-17% vs atual, ou -77% vs base Nuvemshop 182)
```

(Meu cálculo anterior de 520 foi otimista — considera 800-850 como realista)

---

## CHECKPOINT: O QUE MUDA?

### ✅ MANTÉM-SE (90% do arquivo)

```
✅ HTML basics (DOCTYPE, meta, preload)
✅ Critical CSS section (style-critical + 4 customizados)
✅ Colors inline
✅ Blog CSS link
✅ Settings CSS
✅ Header styling
✅ Category/search CSS
✅ Banner responsive CSS
✅ Help button CSS
✅ Mobile spacing CSS
✅ ALL HTML body content
✅ ALL HTML structure
```

### ❌ REMOVIDO (5% do arquivo)

```
❌ Background reset CSS (28 linhas, ~3 KB)
❌ Gallery/banner CSS (140 linhas, ~8 KB)
❌ style-async.scss.tpl link (1 linha, 164 KB)
```

### ⚠️ POTENCIALMENTE REMOVIDO (5%, se validado)

```
⚠️ Home V2 link (4 linhas, ~24 KB) — validar antes
⚠️ Product card link (1 linha, ~7 KB) — validar antes
⚠️ Ad bar override (85 linhas, ~8 KB) — revisar se em style-critical
```

---

## CONCLUSÃO

**O layout.tpl vai perder:**
- 168 linhas de CSS inline
- 1 linha de link para CSS corrompido
- ~175 KB de CSS invalid/redundante

**O layout.tpl vai ganhar:**
- Alinhamento mais próximo com base Nuvemshop
- Melhor manutenção (menos inline CSS)
- Performance (+59% redução de CSS)
- HTTP 200 (sem erro 500)

**Funcionalidade:**
- 95% mantida (apenas CSS cosmético removido)
- 5% risco (gallery, home page — validar antes)

---

*Comparação v1.0 — 2026-03-28*
