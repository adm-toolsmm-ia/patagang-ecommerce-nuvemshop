{# ============================================
   PATAGANG - NOVO CARRINHO LATERAL (CART DRAWER)
   Design: Cards flutuantes com fundo cinza
   JS: Debounce para evitar múltiplas requisições
   ============================================ #}

<div id="pg-cart-drawer" class="pg-drawer js-pg-cart-drawer" style="display: none;" data-store="cart-form">

    {# Overlay #}
    <div class="pg-drawer__overlay js-pg-drawer-close"></div>

    {# Drawer Panel #}
    <div class="pg-drawer__panel">

        {# Header #}
        <div class="pg-drawer__header">
            <h2 class="pg-drawer__title">SACOLA</h2>
            <button type="button" class="pg-drawer__close js-pg-drawer-close" aria-label="Fechar sacola">
                {% include "snipplets/svg/times.tpl" with {svg_custom_class: "icon-inline"} %}
            </button>
        </div>

        {# Content - Lista de produtos em cards #}
        <div class="pg-drawer__content js-pg-cart-items">

            {# Loading state inicial #}
            <div class="pg-drawer__loading js-pg-cart-loading" style="display: none;">
                <div class="pg-drawer__spinner"></div>
            </div>

            {# Empty state #}
            <div class="pg-drawer__empty js-pg-cart-empty" {% if cart.items_count > 0 %}style="display: none;"{% endif %}>
                <div class="pg-drawer__empty-icon">
                    {% include "snipplets/svg/shopping-bag.tpl" with {svg_custom_class: "icon-inline"} %}
                </div>
                <p class="pg-drawer__empty-text">{{ "Sua sacola está vazia" | translate }}</p>
                <a href="{{ store.products_url }}" class="pg-drawer__empty-link">{{ "Ver produtos" | translate }}</a>
            </div>

            {# Cart items #}
            <div class="pg-drawer__items js-pg-cart-items-list" {% if cart.items_count == 0 %}style="display: none;"{% endif %}>
                {% for item in cart.items %}
                    {% include "snipplets/cart-item-new.tpl" %}
                {% endfor %}
            </div>

        </div>

        {# Footer - Totais e botão checkout #}
        <div class="pg-drawer__footer js-pg-cart-footer" {% if cart.items_count == 0 %}style="display: none;"{% endif %}>

            {# Resumo #}
                <div class="pg-drawer__summary">

                {# Subtotal (oculto temporariamente para reimplementação) #}
                <div class="pg-drawer__summary-row" style="display:none;">
                    <span class="pg-drawer__summary-label">Subtotal</span>
                    <span class="pg-drawer__summary-value js-pg-cart-subtotal" data-raw="{{ cart.subtotal }}" style="display:none;">{{ cart.subtotal | money }}</span>
                </div>

                {# Frete - Calculadora inline #}
                {% if settings.shipping_calculator_cart_page and store.has_shipping %}
                    <div id="cart-shipping-container" class="pg-drawer__summary-shipping js-shipping-calculator-container" data-shipping-url="{{ store.shipping_calculator_url }}">
                        <span id="cart-selected-shipping-method" data-code="{{ cart.shipping_data.code }}" class="hidden">{{ cart.shipping_data.name }}</span>
                        {% include "snipplets/shipping/shipping-calculator.tpl" with {'product_detail': false} %}
                    </div>
                {% else %}
                    <div class="pg-drawer__summary-row">
                        <span class="pg-drawer__summary-label">Frete</span>
                        <a href="{{ store.cart_url }}" class="pg-drawer__summary-link js-pg-drawer-close">Calcular</a>
                    </div>
                {% endif %}

                {# Cupom - Input Field + Botão (inline na sacola) #}
                <div class="pg-drawer__coupon-section">
                    <form action="{{ store.cart_url }}" method="post" class="pg-drawer__coupon-form">
                        <div class="pg-drawer__coupon-group">
                            <input
                                type="text"
                                name="discount_code"
                                class="pg-drawer__coupon-input"
                                placeholder="Código promocional"
                                aria-label="Código promocional"
                            />
                            <button
                                type="submit"
                                name="apply_discount"
                                class="pg-drawer__coupon-btn"
                                data-component="cart.apply-coupon"
                            >
                                Aplicar
                            </button>
                        </div>
                    </form>
                </div>

                {# Total (oculto temporariamente para reimplementação) #}
                <div class="pg-drawer__summary-row pg-drawer__summary-row--total" style="display:none;">
                    <span class="pg-drawer__summary-label">Total</span>
                    <span class="pg-drawer__summary-value pg-drawer__summary-value--total js-pg-cart-total" data-raw="{{ cart.total }}" style="display:none;">{{ cart.total | money }}</span>
                </div>

            </div>

            {# Botão Finalizar #}
            <form action="{{ store.cart_url }}" method="post" class="pg-drawer__checkout-form">
                <button type="submit" name="go_to_checkout" class="pg-drawer__checkout-btn js-pg-checkout-btn" {% if not cart.checkout_enabled %}disabled{% endif %} data-component="cart.checkout-button">
                    FINALIZAR COMPRA
                </button>
            </form>

            {# Alerta de mínimo #}
            {% set cart_minimum = (settings.cart_minimum_value * 100) %}
            <div class="pg-drawer__minimum-alert js-pg-cart-minimum" {% if cart.checkout_enabled %}style="display: none;"{% endif %}>
                {{ "O valor mínimo de compra é de {1}" | t(cart_minimum | money) }}
            </div>

        </div>

    </div>
</div>

{# Hidden helpers para JS #}
<div class="pg-cart-helpers" style="display: none;">
    <span class="js-pg-cart-currency" data-currency="{{ cart.currency }}"></span>
    <span class="js-pg-cart-count" data-count="{{ cart.items_count }}"></span>
    <span class="js-pg-free-shipping-min" data-min="{{ cart.free_shipping.min_price_free_shipping.min_price_raw }}"></span>
</div>

