<form class="js-search-container js-search-form pg-search-nav" action="{{ store.search_url }}" method="get">
    <div class="form-group m-0 pg-search-nav__input">
        <input class="js-search-input form-control search-input pg-search-nav__field" autocomplete="off" type="search" name="q" placeholder="{{ 'Buscar' | translate }}" aria-label="{{ 'Buscador' | translate }}"/>
        <button type="submit" class="btn search-input-submit pg-search-nav__submit" value="{{ 'Buscar' | translate }}" aria-label="{{ 'Buscar' | translate }}">
            {% include "snipplets/svg/search.tpl" with {svg_custom_class: "icon-inline svg-icon-text"} %}
        </button>
    </div>

    <div class="pg-search-nav__quick">
        <span class="pg-search-nav__label">Filtros rápidos</span>
        <div class="pg-search-nav__chips">
            {% if settings.search_quick_filters %}
                {% set quick_filters = settings.search_quick_filters | split(',') %}
                {% for term in quick_filters %}
                    {% set term_clean = term | trim %}
                    {% if term_clean %}
                        <a href="{{ store.search_url }}?q={{ term_clean | url_encode }}" class="pg-search-nav__chip" data-search-term="{{ term_clean }}">
                            {{ term_clean }}
                        </a>
                    {% endif %}
                {% endfor %}
            {% else %}
                {# Fallback default filters if not configured #}
                {% set quick_filters = ['Cachorros', 'Passeio', 'Para o Tutor', 'Lancamentos', 'Camisetas', 'Acessorios'] %}
                {% for term in quick_filters %}
                    <a href="{{ store.search_url }}?q={{ term | url_encode }}" class="pg-search-nav__chip" data-search-term="{{ term }}">
                        {{ term }}
                    </a>
                {% endfor %}
            {% endif %}
        </div>
    </div>
</form>
<div class="js-search-suggest search-suggest pg-search-nav__suggest">
    {# AJAX container for search suggestions #}
</div>
