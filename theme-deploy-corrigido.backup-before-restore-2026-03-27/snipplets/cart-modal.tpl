{% embed "snipplets/modal.tpl" with{
  modal_id: 'modal-cart',
  modal_class: 'modal-cart modal-docked-md js-modal-cart',
  modal_position: 'right',
  modal_transition: 'slide',
  modal_width: 'docked-md',
  modal_zindex: '10000',
  custom_data_attribute: 'cart-open-type',
  custom_data_attribute_value: settings.cart_open_type
} %}

{% block modal_head %}
  SACOLA
{% endblock %}

{% block modal_body %}
  <form id="cart-form-modal" action="{{ store.cart_url }}" method="post" class="js-cart-form" data-store="cart-form">
    {% include "snipplets/cart-panel.tpl" %}
  </form>
{% endblock %}

{% endembed %}
