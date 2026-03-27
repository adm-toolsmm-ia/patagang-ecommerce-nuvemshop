{#
  PATAGANG - Banner de Serviço/Aviso (Refatorado)
  Estrutura centralizada com ícone + título + descrição
  Responsivo: mobile-first, melhora em tablet e desktop
  Design visual para captação de leads
#}

<div class="pg-service-item swiper-slide">
  <div class="pg-service-item__content">
    {# Ícone #}
    <div class="pg-service-item__icon">
      {% if banner_services_icon == 'shipping' %}
        {% include "snipplets/svg/truck.tpl" with {svg_custom_class: "pg-service-item__svg"} %}
      {% elseif banner_services_icon == 'card' %}
        {% include "snipplets/svg/credit-card-blank.tpl" with {svg_custom_class: "pg-service-item__svg"} %}
      {% elseif banner_services_icon == 'security' %}
        {% include "snipplets/svg/lock.tpl" with {svg_custom_class: "pg-service-item__svg"} %}
      {% elseif banner_services_icon == 'returns' %}
        {% include "snipplets/svg/sync-alt.tpl" with {svg_custom_class: "pg-service-item__svg"} %}
      {% elseif banner_services_icon == 'whatsapp' %}
        {% include "snipplets/svg/whatsapp.tpl" with {svg_custom_class: "pg-service-item__svg"} %}
      {% elseif banner_services_icon == 'promotions' %}
        {% include "snipplets/svg/tag.tpl" with {svg_custom_class: "pg-service-item__svg"} %}
      {% elseif banner_services_icon == 'cash' %}
        {% include "snipplets/svg/dollar-sign.tpl" with {svg_custom_class: "pg-service-item__svg"} %}
      {% endif %}
    </div>

    {# Texto (título + descrição) #}
    <div class="pg-service-item__text">
      {% if banner_services_url %}
        <a href="{{ banner_services_url | setting_url }}" class="pg-service-item__link">
      {% endif %}

      <h3 class="pg-service-item__title">{{ banner_services_title }}</h3>
      <p class="pg-service-item__description">{{ banner_services_description }}</p>

      {% if banner_services_url %}
        </a>
      {% endif %}
    </div>
  </div>
</div>
