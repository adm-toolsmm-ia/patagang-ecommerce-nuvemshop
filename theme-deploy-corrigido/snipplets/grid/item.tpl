{# /*============================================================================
  #Item grid - PATAGANG V3
  Card de produto compacto e limpo.
  Componentes: imagem+hover, nome, preço, desconto PIX/Boleto, parcelas, botão.
==============================================================================*/ #}

{% set slide_item = slide_item | default(false) %}
{% set columns = settings.grid_columns %}

{# PATAGANG: Verificar se é produto em desenvolvimento pela tag #}
{% set is_development_product = false %}
{% for tag in product.tags %}
    {% if tag == 'em-desenvolvimento' %}
        {% set is_development_product = true %}
    {% endif %}
{% endfor %}

{# Secondary images (hover) #}
{% set show_secondary_image = settings.product_hover %}

{% set product_url_with_selected_variant = has_filters ? (product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url %}

<div class="js-item-product pg-card{% if slide_item %} js-item-slide swiper-slide{% endif %}{% if not product.display_price %} no-price{% endif %}" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}">

    {% if (settings.quick_shop or settings.product_color_variants) and not reduced_item %}
        <div class="js-product-container js-quickshop-container {% if product.variations %}js-quickshop-has-variants{% endif %}" data-variants="{{ product.variants_object | json_encode }}" data-quickshop-id="quick{{ product.id }}{% if slide_item and section_name %}-{{ section_name }}{% endif %}">
    {% endif %}

    {# === IMAGEM === #}
    <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" class="pg-card__image-link">
        <div class="pg-card__image">
            {% set image_classes = 'js-item-image lazyload img-absolute img-absolute-centered fade-in' %}
            {% set data_expand = '-10' %}

            {% set floating_elements %}
                {% if not reduced_item %}
                    {% if settings.product_color_variants %}
                        {% include 'snipplets/labels.tpl' with {color: true} %}
                        {% include 'snipplets/grid/item-colors.tpl' %}
                    {% else %}
                        {% include 'snipplets/labels.tpl' %}
                    {% endif %}
                {% endif %}
            {% endset %}

            {{ component(
                'product-item-image', {
                    image_lazy: true,
                    image_lazy_js: true,
                    image_thumbs: ['small', 'medium', 'large', 'huge', 'original'],
                    image_data_expand: data_expand,
                    image_secondary_data_sizes: 'auto',
                    secondary_image: show_secondary_image,
                    slider: false,
                    placeholder: true,
                    svg_sprites: false,
                    custom_content: floating_elements,
                    product_item_image_classes: {
                        image_container: 'pg-card__image-container',
                        image_padding_container: 'p-relative',
                        image: image_classes,
                        image_featured: 'pg-card__img-featured',
                        image_secondary: 'pg-card__img-hover',
                        placeholder: 'placeholder-fade',
                    },
                })
            }}
        </div>
    </a>

    {# === Hidden quickshop form (needed by Nuvemshop JS) === #}
    {% if
        ((settings.quick_shop and not product.isSubscribable()) or settings.product_color_variants)
        and product.available
        and product.display_price
        and product.variations and not reduced_item
    %}
        <div class="js-item-variants hidden">
            <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                {% if product.variations %}
                    {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
                {% endif %}
                {% if product.available and product.display_price and settings.quick_shop %}
                    {% include "snipplets/product/product-quantity.tpl" with {quickshop: true} %}
                {% endif %}
                {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}
                <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary btn-block mx-auto {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />
                {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-block mx-auto"} %}
            </form>
        </div>
    {% endif %}

    {# === INFO DO PRODUTO === #}
    <div class="pg-card__info" data-store="product-item-info-{{ product.id }}">
        <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" class="pg-card__link">
            {# Nome #}
            <div class="js-item-name pg-card__name" data-store="product-item-name-{{ product.id }}">{{ product.name }}</div>

            {# Preço principal #}
            {% if product.display_price %}
                <div class="pg-card__price" data-store="product-item-price-{{ product.id }}">
                    {% if not reduced_item and product.compare_at_price and product.display_price %}
                        <span class="js-compare-price-display pg-card__price-old">
                            {{ product.compare_at_price | money }}
                        </span>
                    {% endif %}
                    <span class="js-price-display pg-card__price-main">
                        {{ product.price | money }}
                    </span>
                </div>
            {% endif %}
        </a>

        {# Desconto PIX/Boleto #}
        {{ component('payment-discount-price', {
                visibility_condition: settings.payment_discount_price and not reduced_item,
                location: 'product',
                container_classes: "pg-card__discount",
            })
        }}

        {# Parcelamento #}
        {% if not reduced_item %}
            {{ component('installments', {'location' : 'product_item', container_classes: { installment: "pg-card__installments"}}) }}
        {% endif %}
    </div>

    {# === BOTÃO === #}
    {% if is_development_product and not reduced_item %}
        <a href="{{ product_url_with_selected_variant }}" class="pg-card__btn pg-card__btn--dev" title="Seja o primeiro a conhecer {{ product.name }}">
            SEJA O PRIMEIRO A CONHECER
        </a>
    {% elseif product.available and product.display_price and not reduced_item %}
        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
        {% set texts = {'cart': "Comprar", 'contact': "Consultar preço", 'nostock': "Sem estoque", 'catalog': "Consultar"} %}
        <a href="{{ product_url_with_selected_variant }}" class="pg-card__btn" title="{{ texts[state] }}">
            <svg class="pg-card__btn-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 01-8 0"/></svg>
            {{ texts[state] }}
        </a>
    {% elseif not product.available and not reduced_item %}
        <span class="pg-card__btn pg-card__btn--disabled">Sem estoque</span>
    {% endif %}

    {# Structured data (SEO) #}
    {{ component('structured-data', {'item': true}) }}

    {% if (settings.quick_shop or settings.product_color_variants) and not reduced_item %}
        </div>
    {% endif %}
</div>
