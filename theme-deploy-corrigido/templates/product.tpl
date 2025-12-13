{# PATAGANG - Product Detail Page (PDP) #}
<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container pg-pdp-container" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
    <div class="row section-single-product g-0">
        <div class="col-12 col-lg-7 pg-pdp-image-col" data-store="product-image-{{ product.id }}">
        	{% include 'snipplets/product/product-image.tpl' %}
        </div>
        <div class="col-12 col-lg-5 pg-pdp-info-col" data-store="product-info-{{ product.id }}">
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
    {# Container para FB Comments e Reviews - SOMENTE SE HABILITADO #}
    {% if settings.show_product_fb_comment_box %}
        <div class="container pg-pdp-extras-container">
            <div class="fb-comments section-fb-comments" data-href="{{ product.social_url }}" data-num-posts="5" data-width="100%"></div>
        </div>
    {% endif %}
    {# Reviews app - container oculto por padrão, visível apenas quando há app de reviews #}
    <div id="reviewsapp" class="pg-pdp-reviews-container"></div>
</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}
