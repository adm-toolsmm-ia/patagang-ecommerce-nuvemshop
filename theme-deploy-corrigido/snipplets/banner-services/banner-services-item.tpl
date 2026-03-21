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

<style>
.pg-service-item {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1.5rem 1rem;
  min-height: 120px;
  background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
  border-radius: 8px;
}

.pg-service-item__content {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  width: 100%;
  gap: 1rem;
}

.pg-service-item__icon {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 50px;
  height: 50px;
}

.pg-service-item__svg {
  width: 100%;
  height: 100%;
  color: #000;
  transition: transform 0.3s ease;
}

.pg-service-item:hover .pg-service-item__svg {
  transform: scale(1.1);
}

.pg-service-item__text {
  flex: 1;
  width: 100%;
}

.pg-service-item__link {
  text-decoration: none;
  color: inherit;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}

.pg-service-item__title {
  font-size: 1.125rem;
  font-weight: 700;
  line-height: 1.3;
  margin: 0;
  color: #000;
  letter-spacing: 0.5px;
}

.pg-service-item__description {
  font-size: 0.95rem;
  line-height: 1.4;
  margin: 0;
  color: #666;
  font-weight: 500;
}

@media (min-width: 768px) {
  .pg-service-item {
    padding: 2rem 2rem;
    min-height: 140px;
  }

  .pg-service-item__icon {
    width: 60px;
    height: 60px;
  }

  .pg-service-item__title {
    font-size: 1.25rem;
  }

  .pg-service-item__description {
    font-size: 1rem;
  }
}

@media (min-width: 992px) {
  .pg-service-item {
    padding: 2.5rem 2.5rem;
    min-height: 160px;
  }

  .pg-service-item__icon {
    width: 70px;
    height: 70px;
  }

  .pg-service-item__title {
    font-size: 1.375rem;
    letter-spacing: 0.8px;
  }

  .pg-service-item__description {
    font-size: 1.0625rem;
    max-width: 320px;
    margin: 0 auto;
  }
}
</style>
