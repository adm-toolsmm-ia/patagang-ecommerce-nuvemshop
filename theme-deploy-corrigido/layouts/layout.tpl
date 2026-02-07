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

        {# Versão do Deploy - Atualizado automaticamente pelo script de deploy #}
        {# DEPLOY_VERSION: PLACEHOLDER_VERSION_ID #}
        <meta name="deploy-version" content="PLACEHOLDER_VERSION_ID" />

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

        {# Blog styles - PATAGANG - Load immediately, not async #}

        <link rel="stylesheet" href="{{ 'css/style-blog.scss.tpl' | static_url }}">

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | raw }}
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


    
    </head>
    <body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}" data-deploy-version="PLACEHOLDER_VERSION_ID">
        {# Console log com versão do deploy - Para facilitar validação #}
        <script>
            console.log('%c📦 VERSÃO DO DEPLOY', 'color: #EAFE67; font-size: 16px; font-weight: bold; background: #000; padding: 4px 8px;');
            console.log('%cVersão ID: PLACEHOLDER_VERSION_ID', 'color: #00ff00; font-size: 14px;');
            console.log('%cPara validar: Verifique se esta versão corresponde ao deploy atual', 'color: #ffff00; font-size: 12px;');
            console.log('%cCódigo-fonte: Procure por "DEPLOY_VERSION" no HTML', 'color: #00ffff; font-size: 12px;');
        </script>
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

        {# Barra de anúncio - FIXO no topo (z-index 10000) #}
        {% if settings.ad_bar and settings.ad_text %}
          {% snipplet "header/header-advertising.tpl" %}
        {% endif %}

        {# Header = Logo + Search + Ajax Cart (top: 30px para não sobrepor banner) #}

        {% snipplet "header/header-patagang.tpl" %}

        {# Page content #}

        {% template_content %}

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

    </body>
</html>

{# deploy touch - no output #}
