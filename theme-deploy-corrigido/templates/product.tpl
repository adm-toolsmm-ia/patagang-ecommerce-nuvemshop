{# PATAGANG - Product Detail Page (PDP) #}
{# Estrutura: Cada seção é independente e ocupa 100% da width #}

{# SEÇÃO 1: BANNER DE AVISO (full width) #}
<div class="pg-pdp-section pg-pdp-banner-warning">
    {% include 'snipplets/product/product-identity-banner.tpl' %}
</div>

{# SEÇÃO 2: BANNER ESPECÍFICO DO PRODUTO (full width) #}
<div class="pg-pdp-section pg-pdp-banner-informative">
    {% include 'snipplets/product/product-informative-banner.tpl' %}
</div>

{# SEÇÃO 3: CORPO DO PRODUTO (galeria + card, full width) #}
<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container pg-pdp-section pg-pdp-container" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
    <div class="row section-single-product g-0">
        <div class="pg-pdp-image-col" data-store="product-image-{{ product.id }}">
        	{% include 'snipplets/product/product-image.tpl' %}
        </div>
        <div class="pg-pdp-info-col" data-store="product-info-{{ product.id }}">
            {# Marca d'água do logo cachorro - elemento real para garantir visibilidade #}
            <img src="{{ 'images/logos/logo-mark.svg' | static_url }}"
                 alt=""
                 class="pg-pdp-watermark"
                 aria-hidden="true"
                 loading="lazy">
            <div class="pg-pdp-info-card">
            	{% include 'snipplets/product/product-form.tpl' %}
            </div>
        </div>
    </div>
</div>

{# SEÇÃO 4: COMENTÁRIOS E EXTRAS (full width) #}
{% if settings.show_product_fb_comment_box %}
    <div class="pg-pdp-section pg-pdp-extras-container">
        <div class="container">
            <div class="fb-comments section-fb-comments" data-href="{{ product.social_url }}" data-num-posts="5" data-width="100%"></div>
        </div>
    </div>
{% endif %}

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}
