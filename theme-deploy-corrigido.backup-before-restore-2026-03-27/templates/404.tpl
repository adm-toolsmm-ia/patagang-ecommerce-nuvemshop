{# ============================================
   PÁGINA 404 - PATAGANG
   Segue o padrão das páginas institucionais
   ============================================ #}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}

{% if show_help %}
    <div id="product-example">
        {% snipplet 'defaults/show_help_product.tpl' %}
    </div>
{% else %}
    <section class="pg-page">
        <div class="pg-page__container">
            {# Título #}
            <h1 class="pg-page__title">{{ "Error 404" | translate }}</h1>
            
            <div class="pg-page__content pg-text-center">
                <p class="pg-text-large">{{ "La página que estás buscando no existe." | translate }}</p>
                
                <div class="pg-text-cta">
                    <a href="{{ store.url }}" class="pg-button">
                        {{ "Volver al inicio" | translate }}
                    </a>
                </div>
                
                {# Produtos relacionados #}
                {% set related_products = sections.primary.products | take(4) | shuffle %}
                {% if related_products | length > 1 %}
                    <div class="pg-404-products">
                        <h2 class="pg-404-products__title">{{ "Quizás te interesen estos productos" | translate }}</h2>
                        <div class="pg-404-products__grid">
                            {% for related in related_products %}
                                {% include 'snipplets/grid/item.tpl' with {product : related} %}
                            {% endfor %}
                        </div>
                    </div>
                {% endif %}
            </div>
        </div>
    </section>
{% endif %}
