{# PATAGANG v1.5.63: WhatsApp Button — Only Product Page (Side Left)
   Purpose: Offer WhatsApp contact alternative on product page
   Responsive: Fixed position, visible on all breakpoints
   Accessibility: aria-label for screen readers
#}
{% if template == 'product' %}
<a href="https://api.whatsapp.com/send/?phone=5547996263577&text&type=phone_number&app_absent=0"
   target="_blank"
   class="btn-whatsapp-left"
   aria-label="{{ 'Compre pelo WhatsApp' | translate }}">
    {% include "snipplets/svg/whatsapp.tpl" with {svg_custom_class: "icon-inline icon-2x"} %}
    <span>Compre pelo Whats</span>
</a>
{% endif %}
