<section class="pg-footer__column">
  <span class="footer__title">{{ 'Suporte' | translate }}</span>
  <ul class="pg-footer__list">
    {% if store.email %}
      <li><a href="mailto:{{ store.email }}">{{ store.email }}</a></li>
    {% endif %}
    {% if store.phone %}
      <li><a href="tel:{{ store.phone | replace({' ': '', '-' : ''}) }}">{{ store.phone }}</a></li>
    {% endif %}
    {% if store.address %}
      <li>{{ store.address.street }}{% if store.address.number %}, {{ store.address.number }}{% endif %} - {{ store.address.city }}</li>
    {% endif %}
    <li><a href="{{ store.contact_url }}">{{ 'Central de atendimento' | translate }}</a></li>
    {% if settings.whatsapp_number %}
      <li><a href="https://wa.me/{{ settings.whatsapp_number | replace({' ': '', '-' : ''}) }}" target="_blank" rel="noopener">{{ 'Atendimento WhatsApp' | translate }}</a></li>
    {% endif %}
  </ul>
</section>
