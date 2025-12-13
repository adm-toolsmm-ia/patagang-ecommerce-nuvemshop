{# ============================================
   PATAGANG - CART ITEM CARD
   Design: Card flutuante branco com sombra suave
   ============================================ #}

<div class="pg-cart-card js-pg-cart-item"
     data-item-id="{{ item.id }}"
     data-product-id="{{ item.product.id }}"
     data-variant-id="{{ item.variant.id }}"
     data-store="cart-item-{{ item.id }}"
     data-component="cart.line-item">

    {# Loading overlay do card #}
    <div class="pg-cart-card__loading js-pg-item-loading" style="display: none;">
        <div class="pg-cart-card__spinner"></div>
    </div>

    {# Imagem do produto #}
    <div class="pg-cart-card__image">
        <a href="{{ item.url }}" class="js-pg-drawer-close">
            <img src="{{ item.featured_image | product_image_url('medium') }}"
                 alt="{{ item.short_name }}"
                 loading="lazy" />
        </a>
    </div>

    {# Informações do produto #}
    <div class="pg-cart-card__info">

        {# Nome do produto #}
        <span class="pg-cart-card__name">
            <a href="{{ item.url }}" class="js-pg-drawer-close">{{ item.short_name }}</a>
        </span>

        {# Variante (tamanho, cor, etc) #}
        {% if item.short_variant_name %}
            <span class="pg-cart-card__variant">Tam: {{ item.short_variant_name }}</span>
        {% endif %}

        {# Seletor de quantidade - Formato Pílula #}
        {# PATAGANG: Usa métodos nativos LS.plusQuantity/LS.minusQuantity para sincronização em tempo real #}
        <div class="pg-cart-card__qty">
            <div class="pg-qty-pill">
                <button type="button"
                        class="pg-qty-pill__btn pg-qty-pill__btn--minus"
                        onclick="LS.minusQuantity({{ item.id }}, true)"
                        data-component="quantity.minus"
                        aria-label="Diminuir quantidade">
                    <span>−</span>
                </button>

                <input type="text"
                       class="pg-qty-pill__input js-pg-qty-input js-cart-quantity-input"
                       value="{{ item.quantity }}"
                       name="quantity[{{ item.id }}]"
                       data-item-id="{{ item.id }}"
                       data-component="quantity.value"
                       readonly
                       aria-label="Quantidade" />

                <button type="button"
                        class="pg-qty-pill__btn pg-qty-pill__btn--plus"
                        onclick="LS.plusQuantity({{ item.id }}, true)"
                        data-component="quantity.plus"
                        aria-label="Aumentar quantidade">
                    <span>+</span>
                </button>
            </div>
        </div>

    </div>

    {# Preço #}
    <div class="pg-cart-card__price">
        <span class="js-pg-item-subtotal" data-item-id="{{ item.id }}" data-line-item-id="{{ item.id }}" data-component="subtotal.value" data-component-value="{{ item.subtotal | money }}">{{ item.subtotal | money }}</span>
    </div>

    {# Botão remover (X) #}
    <button type="button"
            class="pg-cart-card__remove js-pg-item-remove"
            data-item-id="{{ item.id }}"
            aria-label="Remover {{ item.short_name }}">
        {% include "snipplets/svg/times.tpl" with {svg_custom_class: "icon-inline"} %}
    </button>

</div>

