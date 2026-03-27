{# PATAGANG - Product Form (Prototipo Adobe XD) #}

{# Verificar se é produto em desenvolvimento pela tag #}
{% set is_development_product = false %}
{% for tag in product.tags %}
    {% if tag == 'em-desenvolvimento' %}
        {% set is_development_product = true %}
    {% endif %}
{% endfor %}

{% if is_development_product %}
    {# Card especial para produtos em desenvolvimento #}
    {% include 'snipplets/product/product-form-development.tpl' %}
{% else %}
{# Card de compra normal — Redesign PDP V2 #}
<div class="pg-product-card-content">
    
    {# ==========================================
       1. TÍTULO — Destaque principal
    ========================================== #}
    <div class="pg-product-header">
        <h1 class="pg-product-title">{{ product.name }}</h1>
    </div>
    
    {# ==========================================
       2. BLOCO DE PREÇOS — Hierarquia visual clara
    ========================================== #}
    {% if product.display_price %}
    <div class="pg-price-block" data-store="product-price-{{ product.id }}">
        
        {# Preço PIX/Boleto — DESTAQUE PRINCIPAL — Componente nativo Nuvemshop #}
        {{ component('payment-discount-price', {
                visibility_condition: settings.payment_discount_price,
                location: 'product',
                container_classes: "pg-price-pix-highlight",
            })
        }}
        
        {# Preço normal (sem desconto PIX) — sempre tachado abaixo do PIX #}
        <span class="js-price-display pg-price-original" id="price_display" data-product-price="{{ product.price }}">
            {{ product.price | money }}
        </span>
        
        {# Compare at price (de/por) se houver — opcional #}
        {% if product.compare_at_price and product.compare_at_price > product.price %}
            <span class="js-compare-price-display pg-price-compare-at">
                {{ product.compare_at_price | money }}
            </span>
        {% endif %}
        
        {# Parcelamento — Componente nativo Nuvemshop (mesmo do grid) #}
        {{ component('installments', {
            'location': 'product_item',
            container_classes: { installment: "pg-price-installments" }
        }) }}
        
    </div>
    {% endif %}
    
    {# ==========================================
       3. VARIANTES — Cor, Tamanho, Tabela de Medidas
    ========================================== #}
    <form id="product_form" class="js-product-form pg-product-form" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
        
        {% if product.variations %}
            <div class="pg-variants-container">
                {% for variation in product.variations %}
                    
                    {# Color Selector #}
                    {% if variation.name in ['Color', 'Cor'] %}
                        <div class="pg-variant-group js-product-variants-group js-color-variants-container" data-variation-id="{{ variation.id }}">
                            <div class="pg-color-swatches">
                                {% for option in variation.options if option.custom_data %}
                                    <button type="button" 
                                            class="pg-color-swatch js-insta-variant {% if product.default_options[variation.id] is same as(option.id) %}active{% endif %}"
                                            data-option="{{ option.id }}"
                                            data-variation-id="{{ variation.id }}"
                                            style="background-color: {{ option.custom_data }};"
                                            title="{{ option.name }}"
                                            aria-label="{{ option.name }}">
                                    </button>
                                {% endfor %}
                            </div>
                            <select name="variation[{{ variation.id }}]" class="js-variation-option js-refresh-installment-data d-none" data-variation-id="{{ variation.id }}">
                                {% for option in variation.options %}
                                    <option value="{{ option.id }}" {% if product.default_options[variation.id] is same as(option.id) %}selected="selected"{% endif %}>{{ option.name }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    {% endif %}
                    
                    {# Size Selector #}
                    {% if variation.name in ['Talle', 'Talla', 'Tamanho', 'Size'] %}
                        <div class="pg-variant-group js-product-variants-group" data-variation-id="{{ variation.id }}">
                            <div class="pg-size-selector-header">
                                <div class="pg-size-buttons">
                                    {% for option in variation.options %}
                                        <button type="button"
                                                class="pg-size-btn js-insta-variant {% if product.default_options[variation.id] is same as(option.id) %}active{% endif %}"
                                                data-option="{{ option.id }}"
                                                data-variation-id="{{ variation.id }}">
                                            {{ option.name }}
                                        </button>
                                    {% endfor %}
                                </div>
                                {% if settings.size_guide_url %}
                                    {% set size_guide_url_handle = settings.size_guide_url | trim('/') | split('/') | last %}
                                    {% for page in pages if page.handle == size_guide_url_handle %}
                                        <a href="#" class="pg-size-guide-link js-modal-open js-fullscreen-modal-open" data-toggle="#size-guide-modal" data-modal-url="modal-fullscreen-size-guide">
                                            TABELA DE MEDIDAS
                                        </a>
                                    {% endfor %}
                                {% endif %}
                            </div>
                            <select name="variation[{{ variation.id }}]" class="js-variation-option js-refresh-installment-data d-none" data-variation-id="{{ variation.id }}">
                                {% for option in variation.options %}
                                    <option value="{{ option.id }}" {% if product.default_options[variation.id] is same as(option.id) %}selected="selected"{% endif %}>{{ option.name }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    {% endif %}
                    
                {% endfor %}
            </div>
        {% endif %}
        
        {# ==========================================
           4. BOTÃO ADICIONAR — Amarelo Patagang
        ========================================== #}
        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
        {% set texts = {'cart': "Adicionar", 'contact': "Consultar preço", 'nostock': "Sin stock", 'catalog': "Consultar"} %}
        
        <button type="submit" class="js-addtocart js-prod-submit-form pg-product-add-btn {{ state }}" {% if state == 'nostock' %}disabled{% endif %} data-store="product-buy-button" data-component="product.add-to-cart">
            {{ texts[state] | translate | upper }}
        </button>
        
        {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-block mb-4 d-none"} %}
        
    </form>
    
    {# ==========================================
       5. BANNER CUPOM — Destaque promocional
    ========================================== #}
    <div class="pg-coupon-banner">
        {# Logo SVG no lugar do emoji #}
        <img src="{{ 'images/logos/logo-mark.svg' | static_url }}" alt="Patagang" class="pg-coupon-banner__icon" loading="lazy">
        
        <div class="pg-coupon-banner__content">
            <div class="pg-coupon-banner__highlight">
                <strong>10% OFF</strong> na primeira compra
            </div>
            <div class="pg-coupon-banner__code">
                Use o cupom <span class="pg-coupon-banner__coupon">GANGDAPATA</span> no checkout
            </div>
        </div>
    </div>
    
    {# ==========================================
       6. ACCORDIONS — Descrição, Cuidados, Trocas
    ========================================== #}
    <div class="pg-product-accordions">
        
        {% if product.description is not empty %}
            <div class="pg-accordion-item active">
                <button type="button" class="pg-accordion-header">
                    <span>{{ "DESCRIÇÃO" | translate }}</span>
                    <span class="pg-accordion-icon">×</span>
                </button>
                <div class="pg-accordion-content">
                    <div class="user-content">
                        {{ product.description }}
                    </div>
                </div>
            </div>
        {% endif %}
        
        <div class="pg-accordion-item">
            <button type="button" class="pg-accordion-header">
                <span>{{ "CUIDADOS" | translate }}</span>
                <span class="pg-accordion-icon">+</span>
            </button>
            <div class="pg-accordion-content">
                <div class="user-content">
                    <p>• Lavar à mão ou na máquina em ciclo delicado<br>
                    • Usar água fria<br>
                    • Não usar alvejante<br>
                    • Secar à sombra<br>
                    • Passar em temperatura baixa se necessário</p>
                </div>
            </div>
        </div>
        
        <div class="pg-accordion-item">
            <button type="button" class="pg-accordion-header">
                <span>{{ "TROCAS E DEVOLUÇÕES" | translate }}</span>
                <span class="pg-accordion-icon">+</span>
            </button>
            <div class="pg-accordion-content">
                <div class="user-content">
                    <p>Você tem até 30 dias para trocar ou devolver seu produto.<br><br>
                    Para realizar a troca ou devolução, o produto deve estar em perfeito estado, sem uso, com todas as etiquetas originais e na embalagem.</p>
                </div>
            </div>
        </div>
        
    </div>
    
</div>

{# Hidden elements for price updates and cart functionality #}
<div class="d-none">
    <div class="js-price-container" data-store="product-price-{{ product.id }}">
        <span id="compare_price_display" class="js-compare-price-display">
            {% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}
        </span>
    </div>
</div>

{# Custom JS for product page interactions #}
<script src="{{ 'js/product-page-custom.js' | static_url }}" defer></script>
{% endif %}
