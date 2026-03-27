{# PataGang Search Overlay - Busca avançada fullscreen #}
{# Estratégia 2026: Destaques (bestsellers curados) + Lançamentos (produtos novos) #}
{# Referência: ZeeDog - Overlay com seções dinâmicas #}

<div class="pg-search-overlay js-pg-search-overlay" aria-hidden="true" role="dialog" aria-label="{{ 'Buscar' | translate }}">
  <div class="pg-search-overlay__backdrop js-pg-search-overlay-close"></div>

  <div class="pg-search-overlay__panel">
    {# Barra superior: botão fechar #}
    <div class="pg-search-overlay__topbar">
      <button type="button" class="pg-search-overlay__close js-pg-search-overlay-close" aria-label="Fechar busca">
        <span class="pg-search-overlay__close-text">Fechar</span>
        <span class="pg-search-overlay__close-icon">&times;</span>
      </button>
    </div>

    {# Form de busca - DEVE ter js-search-container para LS.search() funcionar #}
    <div class="pg-search-overlay__form-wrapper">
      <form class="pg-search-overlay__form js-search-container js-search-form" action="{{ store.search_url }}" method="get">
        <div class="pg-search-overlay__input-group">
          <input type="search"
                 name="q"
                 class="pg-search-overlay__input js-search-input"
                 placeholder="O que você procura?"
                 autocomplete="off"
                 aria-label="{{ 'Buscar' | translate }}">
          <button type="submit" class="pg-search-overlay__submit" aria-label="{{ 'Buscar' | translate }}">
            <svg width="20" height="20" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
              <circle cx="28" cy="28" r="20" stroke="currentColor" stroke-width="8"/>
              <line x1="44" y1="44" x2="58" y2="58" stroke="currentColor" stroke-width="8" stroke-linecap="round"/>
            </svg>
          </button>
        </div>
      </form>
      {# LS.search() insere conteúdo aqui - DEVE ser irmão após .js-search-container #}
      <div class="js-search-suggest pg-search-overlay__suggestions" style="display:none;"></div>
    </div>

    {# Conteúdo padrão (visível quando input vazio, escondido quando há sugestões) #}
    <div class="pg-search-overlay__default-content js-pg-search-default-content">
      <div class="pg-search-overlay__columns">

        {# Coluna esquerda: Lançamentos - Categorias de busca rápida #}
        <div class="pg-search-overlay__col pg-search-overlay__col--tags">
          <h3 class="pg-search-overlay__section-title">Lançamentos</h3>
          <div class="pg-search-overlay__tags">
            {# Categorias de busca rápida (customizáveis) #}
            {% set launch_categories = ['Novidades', 'Em Alta', 'Exclusivos', 'Ofertas do Mês', 'Trending Now', 'Best Sellers'] %}
            {% for category in launch_categories %}
              <a href="{{ store.search_url }}?q={{ category | url_encode }}"
                 class="pg-search-overlay__tag js-pg-search-tag"
                 data-search-term="{{ category }}">
                {{ category }}
              </a>
            {% endfor %}
          </div>
        </div>

        {# Coluna direita: Destaques - Produtos curados da loja #}
        <div class="pg-search-overlay__col pg-search-overlay__col--products">
          <h3 class="pg-search-overlay__section-title">Destaques</h3>
          <div class="pg-search-overlay__products-carousel">
            {% set best_sellers = sections.primary.products | take(8) %}
            {% if best_sellers | length > 0 %}
              {% for product in best_sellers %}
                <a href="{{ product.url }}" class="pg-search-overlay__product-card">
                  <div class="pg-search-overlay__product-img">
                    {% if product.featured_image %}
                      {{ product.featured_image | product_image_url("small") | img_tag(product.featured_image.alt, {loading: 'lazy'}) }}
                    {% endif %}
                  </div>
                  <div class="pg-search-overlay__product-info">
                    <p class="pg-search-overlay__product-name">{{ product.name }}</p>
                    {% if product.display_price %}
                      {% if product.compare_at_price %}
                        <p class="pg-search-overlay__product-price pg-search-overlay__product-price--compare">
                          A partir de <strong>{{ product.price | money }}</strong>
                        </p>
                      {% else %}
                        <p class="pg-search-overlay__product-price">{{ product.price | money }}</p>
                      {% endif %}
                    {% endif %}
                  </div>
                </a>
              {% endfor %}
            {% else %}
              <p class="pg-search-overlay__empty">Produtos em breve...</p>
            {% endif %}
          </div>
        </div>

      </div>
    </div>
  </div>
</div>
