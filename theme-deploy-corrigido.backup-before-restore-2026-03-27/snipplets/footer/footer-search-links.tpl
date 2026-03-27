{% set categories = store.categories | slice(0,4) %}
<section class="pg-footer__column">
  <span class="footer__title">{{ 'Busca' | translate }}</span>
  <ul class="pg-footer__list">
    {% if categories and categories|length > 0 %}
      {% for category in categories %}
        <li><a href="{{ category.url }}">{{ category.name }}</a></li>
      {% endfor %}
    {% else %}
      <li><a href="{{ store.url }}">{{ 'Início' | translate }}</a></li>
      <li><a href="{{ store.products_url }}">{{ 'Todos os produtos' | translate }}</a></li>
      <li><a href="{{ store.cart_url }}">{{ 'Minha sacola' | translate }}</a></li>
      <li><a href="{{ store.contact_url }}">{{ 'Contato' | translate }}</a></li>
    {% endif %}
  </ul>
</section>
