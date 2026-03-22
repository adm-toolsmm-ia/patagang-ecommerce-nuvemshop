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

        {# SEO: Meta Robots - Controle de indexacao por tipo de pagina #}
        {% if template == 'cart' or template == 'account.login' or template == 'account.register' or template == 'account.addresses' or template == 'account.orders' or template == 'account.order' %}
            <meta name="robots" content="noindex, nofollow">
        {% elseif template == 'search' %}
            <meta name="robots" content="noindex, follow">
        {% else %}
            <meta name="robots" content="index, follow">
        {% endif %}

        {# SEO: Canonical URL - Evita conteudo duplicado #}
        <link rel="canonical" href="{{ canonical_url }}" />

        {# SEO: Google Search Console - Inserir meta tag de verificacao abaixo quando receber do especialista #}
        {# <meta name="google-site-verification" content="CODIGO_AQUI" /> #}

        <link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('300, 400, 700') }}" />
        <link rel="preload" href="{{ 'css/style-colors.scss.tpl' | static_url }}" as="style" />

        {# Preload LCP home, category and product page elements #}

        {% snipplet 'preload-images.tpl' %}

        {{ component('social-meta') }}

        {# Blog Post SEO - Meta Tags adicionais para Open Graph e Twitter Cards #}
        {% if template == 'blog-post' %}
            <meta property="og:type" content="article">
            {% if post.published_at %}
                <meta property="article:published_time" content="{{ post.published_at | date('c') }}">
            {% endif %}
            {% if post.updated_at %}
                <meta property="article:modified_time" content="{{ post.updated_at | date('c') }}">
            {% endif %}
            <meta property="article:author" content="{{ store.name }}">
            <meta name="twitter:card" content="summary_large_image">
            <meta name="twitter:site" content="@{{ store.name }}">
        {% endif %}

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
        </style>

        {# Colors and fonts used from settings.txt and defined on theme customization #}

        {{ 'css/style-colors.scss.tpl' | static_url | static_inline }}

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss.tpl' | static_url }}" media="print" onload="this.media='all'">

        {# HOME V2 - Estilos específicos da nova home page #}
        {% if template == 'home' %}
            {# Cache busting: força navegador a carregar versão mais recente #}
            <link rel="stylesheet" href="{{ 'css/style-home-v2.css' | static_url }}?v=2026-02-03T04-40">
        {% endif %}

        {# PRODUCT CARD V3 - Cards compactos e limpos (categoria, busca, similares, 404) #}
        <link rel="stylesheet" href="{{ 'css/product-card-v3.css' | static_url }}?v=2026-02-14">

        {# Blog styles - PATAGANG - Loaded asynchronously (not above-the-fold) #}

        <link rel="stylesheet" href="{{ 'css/style-blog.scss.tpl' | static_url }}" media="print" onload="this.media='all'">

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | raw }}
        </style>

        {# Ad Bar: override final (PATAGANG v1.5.17+ - Static layout, no fixed positioning) #}
        {# CRITICAL: Ensure advertising section remains VISUALLY SEPARATE from header #}
        {% if settings.ad_bar and settings.ad_text %}
        <style>
            body .section-advertising {
                background-color: transparent !important;
                position: static !important;
                z-index: auto !important;
                width: 100% !important;
                padding: 10px 20px !important;
                box-sizing: border-box !important;
                margin-bottom: 0 !important;
                border-bottom: 1px solid rgba(0, 0, 0, 0.05) !important;
            }
            body .section-advertising__marquee {
                display: flex !important;
                justify-content: center !important;
                align-items: center !important;
                width: 100% !important;
                max-width: 1200px !important;
                margin: 0 auto !important;
            }
            body .section-advertising__track {
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                text-align: center !important;
                width: 100% !important;
                padding: 0 !important;
                animation: none !important;
            }
            body .section-advertising__copy {
                display: block !important;
                font-size: 0.875rem !important;
                font-weight: 600 !important;
                letter-spacing: 0.3px !important;
                color: #000 !important;
                margin: 0 !important;
                line-height: 1.4 !important;
            }
            body .section-advertising__link {
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                text-decoration: none !important;
                color: inherit !important;
                outline: none !important;
                width: 100% !important;
                transition: opacity 0.2s ease !important;
            }
            body .section-advertising__link:hover {
                opacity: 0.8 !important;
            }
            @media (max-width: 576px) {
                body .section-advertising {
                    padding: 8px 15px !important;
                }
                body .section-advertising__copy {
                    font-size: 0.75rem !important;
                }
            }
            @media (min-width: 577px) and (max-width: 991px) {
                body .section-advertising {
                    padding: 9px 18px !important;
                }
                body .section-advertising__copy {
                    font-size: 0.8rem !important;
                }
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
                margin-top: 0 !important;
                padding-top: 50px !important;
                background: transparent !important;
                color: inherit !important;
            }
            {# Mobile: Ensure header stays independent when ad bar present #}
            @media (max-width: 768px) {
                body.has-ad-bar .pg-header {
                    min-height: 56px !important;
                    padding-top: 8px !important;
                    padding-bottom: 8px !important;
                }
                body.has-ad-bar .pg-header__logo-img {
                    max-height: 26px !important;
                }
            }
        </style>

        {# Konfidence widget removido - será reimplementado posteriormente #}

        {# Override V3: listagem (categoria/busca) - padding-top da página #}
        {% if template == 'category' or template == 'search' %}
        <style>
        body.template-category .pg-search-page,
        body.template-search .pg-search-page {
            padding-top: 120px !important;
        }
        /* Reduce header margin on Desktop */
        body.template-category .pg-search-page__header,
        body.template-search .pg-search-page__header {
            margin-bottom: 24px !important;
        }
        @media (max-width: 992px) {
            body.template-category .pg-search-page,
            body.template-search .pg-search-page {
                padding-top: 110px !important;
            }
        }
        @media (max-width: 768px) {
            body.template-category .pg-search-page,
            body.template-search .pg-search-page {
                padding-top: 110px !important;
            }
        }
        @media (max-width: 480px) {
            body.template-category .pg-search-page,
            body.template-search .pg-search-page {
                padding-top: 80px !important;
            }
        }
        </style>
        {% endif %}

        {# Banner responsive mobile - PATAGANG v3 #}
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

        {# Override final: Botões laterais - Help Button CLEAN DESIGN (gray) + WhatsApp keeps yellow #}
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
            font-weight: 700 !important;
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
            background-color: #F0F0F0 !important;
            border: 1px solid #E0E0E0 !important;
            padding: 12px 8px !important;
        }
        body .btn-whatsapp-left:hover {
            background-color: #E8E8E8 !important;
            border: 1px solid #D0D0D0 !important;
            padding-right: 12px !important;
        }
        body .btn-whatsapp-left svg {
            color: #25D366 !important;
        }
        body .btn-whatsapp-left span {
            font-weight: 700 !important;
            font-size: 12px !important;
            color: #666666 !important;
        }
        @media (max-width: 480px) {
            body .pg-help-btn__text { font-size: 11px !important; }
            body .btn-whatsapp-left span { font-size: 11px !important; }
        }
        </style>

        {#/*============================================================================
            #Javascript: Needed before HTML loads
        ==============================================================================*/#}

        {# Defines if async JS will be used by using script_tag(true) #}

        {% set async_js = true %}

        {# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

        {% set nojquery = true %}

        {# Jquery async by adding script_tag(true) #}

        {% if load_jquery %}

            {{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

        {% endif %}

        {# Loads private Tiendanube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data') }}


    
        {# PATAGANG v1.5.30: Structural Refactor - Section-level isolation with semantic HTML #}
        <style>
            /* L1: TOP SECTION — Ad Bar (completely isolated) */
            section.patagang-section-top {
                background-color: transparent !important;
                background-image: none !important;
                width: 100%;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            section.patagang-section-top .section-advertising {
                background-color: transparent !important;
                background-image: none !important;
                color: inherit !important;
                margin: 0 !important;
                padding: 10px 20px !important;
                border: none !important;
                box-shadow: none !important;
                width: 100% !important;
            }
            section.patagang-section-top .section-advertising * {
                background-color: transparent !important;
                background-image: none !important;
            }

            /* L2: HEADER SECTION — Navigation (completely independent) */
            section.patagang-section-header {
                background-color: transparent !important;
                background-image: none !important;
                color: inherit !important;
                width: 100%;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                clear: both;
                border: none;
                box-shadow: none;
            }
            section.patagang-section-header .pg-header {
                background-color: transparent !important;
                background-image: none !important;
                color: inherit !important;
                margin: 0 !important;
                padding: 0 !important;
                border: none !important;
                box-shadow: none !important;
                width: 100% !important;
            }

            /* L3: MAIN CONTENT (explicit background) */
            main.patagang-section-content {
                background-color: #ffffff;
                width: 100%;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Mobile breakpoint — explicit spacing between sections */
            @media (max-width: 768px) {
                section.patagang-section-top {
                    border-bottom: 1px solid rgba(0,0,0,0.05);
                }
                section.patagang-section-top .section-advertising {
                    padding-bottom: 10px !important;
                }

                section.patagang-section-header {
                    border-top: none;
                    border-bottom: 1px solid rgba(0,0,0,0.08);
                }
                section.patagang-section-header .pg-header {
                    min-height: 56px !important;
                    padding-top: 8px !important;
                    padding-bottom: 8px !important;
                }

                main.patagang-section-content {
                    margin-top: 0;
                }
            }
        </style>
    </head>
    <body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}{% if settings.ad_bar and settings.ad_text %} has-ad-bar{% endif %}">
        {# Facebook comments on product page #}

        {% if template == 'product' %}

            {# Facebook comment box JS #}
            {% if settings.show_product_fb_comment_box %}
                {{ fb_js }}
            {% endif %}

            {# Pinterest share button JS #}
            {{ pin_js }}

        {% endif %}

        {# Back to admin bar #}

        {{back_to_admin}}

        {# ========================================================================
           PATAGANG v1.5.30: Structural Layout — Three Independent Sections
           ======================================================================== #}

        {# SECTION 1: Top Banner (Ad Bar) — Completely isolated #}
        <section class="patagang-section-top" role="banner">
          {% if settings.ad_bar and settings.ad_text %}
            {% snipplet "header/header-advertising.tpl" %}
          {% endif %}
        </section>

        {# SECTION 2: Header Navigation — Completely independent #}
        <section class="patagang-section-header" role="navigation">
          {% snipplet "header/header-patagang.tpl" %}
        </section>

        {# SECTION 3: Main Content — Explicit background context #}
        <main class="patagang-section-content" role="main">
          {% template_content %}
        </main>

        {# Modals overlay #}

        <div class="js-modal-overlay modal-overlay" style="display: none;"></div>

        {# Cart Modal - ALWAYS LOADED (Modal Nativo Nuvemshop) #}
        {% if not store.is_catalog and settings.ajax_cart and template != 'cart' %}
          {% include "snipplets/cart-modal.tpl" %}
        {% endif %}

        {# Quickshop modal #}

        {% snipplet "grid/quick-shop.tpl" %}

        {# WhatsApp chat button #}

        {% snipplet "whatsapp-chat.tpl" %}

        {# WhatsApp Left Button (Fixed/Floating) #}
        {% snipplet "whatsapp-left.tpl" %}

        {# Help Sidebar (Floating Right) #}
        {% snipplet "help-sidebar.tpl" %}

        {# Footer #}

        {% snipplet "footer.tpl" %}

        {% if cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

            {# Minimum used for free shipping progress messages. Located on header so it can be accesed everywhere with shipping calculator active or inactive #}

            <span class="js-ship-free-min hidden" data-pricemin="{{ cart.free_shipping.min_price_free_shipping.min_price_raw }}"></span>
            <span class="js-free-shipping-config hidden" data-config="{{ cart.free_shipping.allFreeConfigurations }}"></span>
            <span class="js-cart-subtotal hidden" data-priceraw="{{ cart.subtotal }}"></span>
            <span class="js-cart-discount hidden" data-priceraw="{{ cart.promotional_discount_amount }}"></span>
        {% endif %}

        {#/*============================================================================
            #Javascript: Needed after HTML loads
        ==============================================================================*/#}

        {# Javascript used in the store #}

        <script type="text/javascript">

            {# Libraries that do NOT depend on other libraries, e.g: Jquery #}

            {% include "static/js/external-no-dependencies.js.tpl" %}

            {# LS.ready.then function waits to Jquery and private Tiendanube JS to be loaded before executing what´s inside #}

            LS.ready.then(function(){

                {# Libraries that requires Jquery to work #}

                {% include "static/js/external.js.tpl" %}

                {# Specific store JS functions: product variants, cart, shipping, etc #}
                {% include "static/js/store.js.tpl" %}
            });
        </script>

        {# Google reCAPTCHA on register page #}

        {% if template == 'account.register' %}
            {% if not store.hasContactFormsRecaptcha() %}
                {{ '//www.google.com/recaptcha/api.js' | script_tag(true) }}
            {% endif %}
            <script type="text/javascript">
                var recaptchaCallback = function() {
                    jQueryNuvem('.js-recaptcha-button').prop('disabled', false);
                };
            </script>
        {% endif %}

        {# Store external codes added from admin #}

        {{ component('assorted-js', {}) }}

        {# PATAGANG: Smooth scroll para newsletter #}
        <script src="{{ 'js/smooth-scroll.js' | static_url }}"></script>

        {# PATAGANG: Modal Newsletter para produtos em desenvolvimento #}
        {% snipplet "modal-newsletter.tpl" %}

        {# OBRIGATÓRIO: Loads Nuvemshop private JS for footer #}

        {{ foot_content }}

        {# ===================================================================
           PATAGANG V3 OVERRIDE FINAL
           Último CSS da página = vence QUALQUER regra anterior.
           Corrige conflitos com:
             - style-critical.tpl (.img-absolute: height auto, .img-absolute-centered: transform)
             - style-async.scss.tpl (object-fit cover, flex grid com calc(25%))
           NÃO REMOVER - é a garantia de que os estilos V3 funcionam.
        =================================================================== #}
        {% if template == 'category' or template == 'search' or template == '404' or template == 'product' %}
        <style id="pg-v3-override-final">
        /* ============================================
           GRID: CSS Grid real (centraliza com <4 items)
           Substitui flex + calc(25%) que deixava espaço vazio
        ============================================ */
        body.template-category .pg-product-grid,
        body.template-search .pg-product-grid,
        body.template-product .pg-product-grid,
        .pg-404-products__grid {
            display: grid !important;
            grid-template-columns: repeat(2, 1fr) !important; /* MOBILE: 2 colunas */
            gap: 16px !important;
            max-width: 1400px !important;
            margin: 0 auto !important;
            justify-content: center !important;
            float: none !important;
        }
        /* DESKTOP: 4 colunas (ou auto-fit para centralizar poucos itens) */
        @media (min-width: 769px) {
            body.template-category .pg-product-grid,
            body.template-search .pg-product-grid,
            body.template-product .pg-product-grid,
            .pg-404-products__grid {
                 gap: 24px !important;
                 grid-template-columns: repeat(auto-fit, minmax(260px, 300px)) !important;
                 justify-content: center !important;
            }
        }

        /* ============================================
           CARD: Reset flex/width herdados do tema
        ============================================ */
        body.template-category .pg-product-grid .pg-card,
        body.template-category .pg-product-grid .js-item-product,
        body.template-search .pg-product-grid .pg-card,
        body.template-search .pg-product-grid .js-item-product,
        body.template-product .pg-product-grid .pg-card,
        body.template-product .pg-product-grid .js-item-product {
            flex: none !important;
            max-width: none !important;
            min-width: 0 !important;
            width: 100% !important;
            float: none !important;
        }

        /* ============================================
           IMAGEM: Mostra completa, sem cortar
           Neutraliza .img-absolute (height:auto) e
           .img-absolute-centered (transform:translateX(-50%))
        ============================================ */
        body.template-category .pg-product-grid .pg-card__image-container img,
        body.template-category .pg-product-grid .item-image img,
        body.template-search .pg-product-grid .pg-card__image-container img,
        body.template-search .pg-product-grid .item-image img,
        body.template-product .pg-product-grid .pg-card__image-container img,
        body.template-product .pg-product-grid .item-image img,
        body.template-404 .pg-404-products__grid .item-image img,
        .pg-card .pg-card__image-container img,
        .pg-card .pg-card__image-container .img-absolute,
        .pg-card .pg-card__image-container .img-absolute-centered {
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
            width: 100% !important;
            height: 100% !important;
            object-fit: contain !important;
            object-position: center center !important;
            transform: none !important;
            -webkit-transform: none !important;
            -ms-transform: none !important;
        }

        /* ============================================
           TEXTO: Centraliza todas as informações
        ============================================ */
        body.template-category .pg-product-grid .item-product,
        body.template-search .pg-product-grid .item-product,
        body.template-category .pg-product-grid .item-description,
        body.template-search .pg-product-grid .item-description,
        body.template-product .pg-product-grid .item-product,
        body.template-product .pg-product-grid .item-description,
        .pg-card,
        .pg-card.item,
        .pg-card .pg-card__info,
        .pg-card .pg-card__name,
        .pg-card .pg-card__price,
        .pg-card .pg-card__discount,
        .pg-card .pg-card__installments {
            text-align: center !important;
        }
        .pg-card .pg-card__price {
            justify-content: center !important;
        }

        /* RESET */
        .pg-card.item {
            margin-bottom: 0 !important;
        }
        .pg-card .pg-card__image-container {
            margin-bottom: 0 !important;
        }
        /* ============================================
           CATEGORY DESCRIPTION: Match 'VISTA O PROPÓSITO' style
        ============================================ */
        .pg-category-desc {
            font-family: 'Familjen Grotesk', sans-serif !important;
            font-size: 14px !important;
            line-height: 1.45 !important;
            font-weight: 400 !important;
            color: #000000 !important;
            margin: 8px auto 0 !important;
            max-width: 800px !important;
            text-align: center !important;
        }

        </style>
        {% endif %}

        <style id="pg-mobile-spacing-fix">
        /* PATAGANG: Centralized Mobile Spacing Fix (Overrides Everything) */
        @media (max-width: 768px) {
            /* 1. Increase Top Space (Header to Page Title) */
            body.template-category .pg-search-page,
            body.template-search .pg-search-page {
                padding-top: 110px !important; 
            }

            /* 2. Reduce Gap (Page Title to Filters) */
            body.template-category .pg-search-page__header,
            body.template-search .pg-search-page__header {
                margin-bottom: 10px !important; /* Drastically reduced from 40px+ */
                margin-top: 0 !important;
            }
            
            /* 3. Reduce Filter Container Internal Spacing */
            body.template-category .pg-search-page .category-controls,
            body.template-search .pg-search-page .category-controls {
                padding-top: 0 !important;
                margin-bottom: 15px !important;
                gap: 8px !important;
                border-top: none !important;
            }
            
            /* Optional: Tweak Title Margin directly */
            body.template-category .pg-search-page__title,
            body.template-search .pg-search-page__title {
                margin-bottom: 5px !important;
            }
        }
        </style>

        <style id="pg-trust-strip-mobile-fix">
        /* PATAGANG: Trust Strip Mobile — grid 2x2: esquerda (textos maiores) | direita (textos menores) */
        @media (max-width: 768px) {
            .pg-trust-strip__content {
                display: grid !important;
                grid-template-columns: 1fr auto !important;
                grid-template-rows: auto auto !important;
                gap: 4px 12px !important;
                align-items: center !important;
                padding: 6px 12px !important;
            }
            .pg-trust-strip__item:nth-child(1),
            .pg-trust-strip__item:nth-child(2) {
                grid-column: 1 !important;
                text-align: left !important;
                font-size: 9px !important;
                white-space: normal !important;
            }
            .pg-trust-strip__item:nth-child(1) { grid-row: 1 !important; }
            .pg-trust-strip__item:nth-child(2) { grid-row: 2 !important; }
            .pg-trust-strip__item:nth-child(3),
            .pg-trust-strip__item:nth-child(4) {
                grid-column: 2 !important;
                text-align: right !important;
                font-size: 9px !important;
                white-space: nowrap !important;
            }
            .pg-trust-strip__item:nth-child(3) { grid-row: 1 !important; }
            .pg-trust-strip__item:nth-child(4) { grid-row: 2 !important; }
        }
        </style>

        {# PATAGANG Version Info - Deployment Status Console #}
        {# Cache busting: força navegador a carregar versão mais recente (sem cache) #}
        <script src="{{ 'js/version-info.js' | static_url }}?v={{ "now" | date('YmdHis') }}" defer></script>
    </body>
</html>

{# deploy touch - no output #}
