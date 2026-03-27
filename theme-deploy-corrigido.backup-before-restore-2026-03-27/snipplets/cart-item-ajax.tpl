{# PATAGANG Cart Item - Design clean e funcional #}
<div class="js-cart-item pg-cart-item {% if item.product.is_non_shippable %}js-cart-item-non-shippable{% else %}js-cart-item-shippable{% endif %}" data-item-id="{{ item.id }}" data-store="cart-item-{{ item.product.id }}" data-component="cart.line-item">

  {# Imagem do produto #}
  <div class="pg-cart-item__image">
    <a href="{{ item.url }}">
      <img src="{{ item.featured_image | product_image_url('medium') }}" alt="{{ item.short_name }}" />
    </a>
  </div>

  {# Informações do produto #}
  <div class="pg-cart-item__content">

    {# Nome e variante #}
    <div class="pg-cart-item__header">
      <span class="pg-cart-item__name" data-component="line-item.name">
        <a href="{{ item.url }}" data-component="name.short-name">{{ item.short_name }}</a>
      </span>
      {% if item.short_variant_name %}
        <span class="pg-cart-item__variant" data-component="name.short-variant-name">{{ item.short_variant_name }}</span>
      {% endif %}
    </div>

    {# Preço #}
    <div class="pg-cart-item__price">
      <span class="js-cart-item-subtotal" data-line-item-id="{{ item.id }}" data-component="subtotal.value" data-component-value="{{ item.subtotal | money }}">{{ item.subtotal | money }}</span>
    </div>

    {# Controle de quantidade - PATAGANG: Usa métodos nativos LS para sincronização em tempo real #}
    <div class="pg-cart-item__quantity" data-component="line-item.subtotal">
      <div class="pg-qty-pill">
        <button type="button"
                class="pg-qty-pill__btn pg-qty-pill__btn--minus"
                onclick="LS.minusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})"
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
                onclick="LS.plusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})"
                data-component="quantity.plus"
                aria-label="Aumentar quantidade">
          <span>+</span>
        </button>
      </div>
    </div>

    {# Labels de promoção #}
    {{ component(
      'cart-labels', {
        group: true,
        labels_classes: {
          group: 'pg-cart-item__labels',
          label: 'pg-cart-item__label',
          shipping: 'pg-cart-item__label--shipping',
          promotion: 'pg-cart-item__label--promo',
        },
      })
    }}
  </div>

  {# Botão remover #}
  <button type="button"
          class="pg-cart-item__remove js-cart-item-remove"
          data-item-id="{{ item.id }}"
          data-component="line-item.remove"
          onclick="if (typeof event !== 'undefined') { event.preventDefault(); event.stopPropagation(); } if (confirm('{{ '¿Seguro que quieres borrar este artículo?' | translate | escape('js') }}')) { if (typeof LS !== 'undefined' && LS.removeItem) { LS.removeItem({{ item.id }}, true); } } return false;"
          aria-label="Remover item">
    {% include "snipplets/svg/trash-alt.tpl" with {svg_custom_class: "icon-inline"} %}
  </button>
</div>
