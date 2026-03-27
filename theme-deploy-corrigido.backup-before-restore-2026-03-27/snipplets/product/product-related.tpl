{# Default related products visibility conditions #}

{% set related_products = [] %}
{% set related_products_ids_from_app = product.metafields.related_products.related_products_ids %}
{% set has_related_products_from_app = related_products_ids_from_app | get_products | length > 0 %}
{% if has_related_products_from_app %}
    {% set related_products = related_products_ids_from_app | get_products %}
{% endif %}
{% if related_products is empty %}
    {% set max_related_products_length = 8 %}
    {% set max_related_products_achieved = false %}
    {% set related_products_without_stock = [] %}
    {% set max_related_products_without_achieved = false %}

    {% if related_tag %}
        {% set products_from_category = related_products_from_controller %}
    {% else %}
        {% set products_from_category = category.products | shuffle %}
    {% endif %}

    {% for product_from_category in products_from_category if not max_related_products_achieved and product_from_category.id != product.id %}
        {%  if product_from_category.stock is null or product_from_category.stock > 0 %}
            {% set related_products = related_products | merge([product_from_category]) %}
        {% elseif (related_products_without_stock | length < max_related_products_length) %}
            {% set related_products_without_stock = related_products_without_stock | merge([product_from_category]) %}
        {% endif %}
        {%  if (related_products | length == max_related_products_length) %}
            {% set max_related_products_achieved = true %}
        {% endif %}
    {% endfor %}
    {% if (related_products | length < max_related_products_length) %}
        {% set number_of_related_products_for_refill = max_related_products_length - (related_products | length) %}
        {% set related_products_for_refill = related_products_without_stock | take(number_of_related_products_for_refill) %}

        {% set related_products = related_products | merge(related_products_for_refill)  %}
    {% endif %}
{% endif %}

{% set complementary_products = complementary_product_list | length > 0 %}

{# Show alternative products when there are default category alternatives with no complementaries or manually selected alternatives #}
{% set alternative_products = related_products | length > 0 and not (complementary_products and source_alternative == 'default') %}

{# Set related products classes #}

{% set section_class = 'section-products-related my-3' %}
{% set container_class = 'container' %}
{% set title_class = 'h3 text-center' %}
{% set products_container_class = 'position-relative swiper-container-horizontal' %}
{% set slider_container_class = 'swiper-container' %}
{% set swiper_wrapper_class = 'swiper-wrapper' %}
{% set slider_control_pagination_class = 'swiper-pagination' %}
{% set slider_control_class = 'icon-inline icon-w-8 icon-2x svg-icon-text' %}
{% set slider_control_prev_class = 'swiper-button-prev' %}
{% set slider_control_next_class = 'swiper-button-next' %}
{% set control_prev = include ('snipplets/svg/chevron-left.tpl', {svg_custom_class: slider_control_class}) %}
{% set control_next = include ('snipplets/svg/chevron-right.tpl', {svg_custom_class: slider_control_class}) %}

{# Alternative products #}

{% set alternative_data_component = source_alternative == 'default' ? 'related-products' : 'alternative-products' %}

{% if alternative_products %}
    <section id="related-products" class="section-products-related my-3" data-store="related-products">
        <div class="container">
            <h2 class="h3 text-center mb-4">{{ settings.products_related_title }}</h2>
            <div class="pg-product-grid">
                {% for product in related_products %}
                    {# Force original image to avoid cropping #}
                    {% set force_original_image = true %}
                    {% include 'snipplets/grid/item.tpl' %}
                {% endfor %}
            </div>
        </div>
    </section>
{% endif %}

{# Complementary products #}

{% set complementary_section_id = 'complementary-products' %}

{% if complementary_products %}
    <section id="complementary-products" class="section-products-related my-3" data-store="complementary-products">
        <div class="container">
             <h2 class="h3 text-center mb-4">{{ settings.products_complementary_title }}</h2>
            <div class="pg-product-grid">
                {% for product in complementary_product_list %}
                    {# Force original image to avoid cropping #}
                    {% set force_original_image = true %}
                    {% include 'snipplets/grid/item.tpl' %}
                {% endfor %}
            </div>
        </div>
    </section>
{% endif %}