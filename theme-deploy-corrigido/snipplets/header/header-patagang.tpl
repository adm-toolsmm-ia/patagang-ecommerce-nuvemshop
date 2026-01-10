{# PataGang Header - v2.0 - Glassmorphism #}
{% set is_fixed = settings.head_fix %}
<header class="pg-header {% if is_fixed %}pg-header--sticky{% endif %}" data-store="head">
  {# Banner de anúncio movido para layout.tpl para evitar sobreposição #}


  <div class="pg-header__container pg-container">
    <div class="pg-header__row">
      <div class="pg-header__left-group">
        <button class="pg-header__icon-button js-modal-open"
                data-toggle="#nav-hamburger"
                aria-label="{{ 'Menu de navegação' | translate }}">
          <img src="{{ 'images/icons/menu.svg' | static_url }}" alt="" width="24" height="24" loading="lazy">
        </button>

        {# O Movimento - Link Direto (Desktop) #}
        <a href="/comunidade" class="pg-header__movimento-link-direct">
          <span>O Movimento</span>
        </a>
      </div>

      <a class="pg-header__logo" href="{{ store.url }}">
        <img src="{{ 'images/logos/logotipo.svg' | static_url }}" alt="{{ store.name }}" class="pg-header__logo-img" loading="lazy">
        <img src="{{ 'images/logos/logo-mark.svg' | static_url }}" alt="{{ store.name }}" class="pg-header__logo-img--hover" loading="lazy">
      </a>

      <div class="pg-header__actions">
        {# Busca inline expansível #}
        <div class="pg-header__search-wrapper">
          <form class="pg-header__search-form js-search-form" action="{{ store.search_url }}" method="get">
            <input type="search"
                   name="q"
                   class="pg-header__search-input js-search-input"
                   placeholder="{{ 'Buscar' | translate }}"
                   autocomplete="off"
                   aria-label="{{ 'Buscar' | translate }}">
            <button type="submit" class="pg-header__search-submit" aria-label="{{ 'Buscar' | translate }}">
              {# ÍCONE LUPA - PATAGANG Official (patagang-icon-search.svg) #}
              <svg width="18" height="18" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                <circle cx="28" cy="28" r="20" stroke="currentColor" stroke-width="8"/>
                <line x1="44" y1="44" x2="58" y2="58" stroke="currentColor" stroke-width="8" stroke-linecap="round"/>
              </svg>
            </button>
          </form>
          {# TOGGLE REMOVIDO - Apenas o form com submit (lupa) é usado no mobile #}
        </div>

        <a href="{{ store.customer_login_url }}" class="pg-header__icon-button" aria-label="{{ 'Entrar' | translate }}">
          {# ÍCONE PERFIL - PATAGANG Official (patagang-icon-profile.svg) #}
          <svg width="20" height="20" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="32" cy="26" r="18" stroke="currentColor" stroke-width="8"/>
            <line x1="22" y1="40" x2="10" y2="60" stroke="currentColor" stroke-width="8" stroke-linecap="butt"/>
            <line x1="42" y1="40" x2="54" y2="60" stroke="currentColor" stroke-width="8" stroke-linecap="butt"/>
          </svg>
        </a>

        {% if not store.is_catalog %}
          {% set cart_href = settings.ajax_cart and template != 'cart' ? '#' : store.cart_url %}
          <a href="{{ cart_href }}"
             class="pg-header__icon-button js-modal-open js-fullscreen-modal-open"
             {% if settings.ajax_cart and template != 'cart' %}
               data-toggle="#modal-cart"
               data-modal-url="modal-fullscreen-cart"
               data-component="header.cart-button"
             {% endif %}
             aria-label="{{ 'Abrir sacola' | translate }}">
            {# ÍCONE SACOLA - PATAGANG Official (patagang-icon-bag.svg) #}
            <svg width="20" height="22" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M22 6 H42 V18 H22 Z" stroke="currentColor" stroke-width="8" stroke-linejoin="round"/>
              <path d="M14 22 L8 60 H56 L50 22 H14 Z" stroke="currentColor" stroke-width="8" stroke-linejoin="round"/>
            </svg>
            <span class="pg-header__cart-count js-cart-widget-amount">{{ "{1}" | translate(cart.items_count) }}</span>
          </a>
        {% endif %}
      </div>
    </div>
  </div>

  {% include "snipplets/notification.tpl" with {order_notification: true} %}
</header>

{% if not settings.head_fix %}
  {% include "snipplets/notification.tpl" with {add_to_cart: true, add_to_cart_fixed: true} %}
{% endif %}

{% include "snipplets/notification.tpl" with {show_cookie_banner: true} %}

{# Menu Hambúrguer Padrão Nuvemshop - Customizado Patagang #}
{% embed "snipplets/modal.tpl" with{
  modal_id: 'nav-hamburger',
  modal_class: 'nav-hamburger modal-docked-small',
  modal_position: 'left',
  modal_transition: 'fade',
  modal_width: 'full',
  modal_fixed_footer: false,
  modal_footer: false,
  modal_header: true
} %}
  {% block modal_head %}
    <div class="pg-menu-logo">
      <img src="{{ 'images/logos/logotipo.svg' | static_url }}" alt="Patagang" class="pg-menu-logo__img">
    </div>
  {% endblock %}
  {% block modal_body %}
    <div class="pg-menu-container">
      {# Links Principais #}
      {% include "snipplets/navigation/navigation-panel.tpl" with {primary_links: true} %}

      {# O Movimento - Link único no Mobile #}
      <div class="pg-menu-movimento">
        <a href="/comunidade" class="nav-list-link pg-menu-movimento__link">O Movimento</a>
      </div>

      {# Divisor Visual #}
      <div class="pg-menu-divider"></div>

      {# Links Secundários (Conta e Idioma) - Movidos para o corpo #}
      {% include "snipplets/navigation/navigation-panel.tpl" %}
    </div>
  {% endblock %}
{% endembed %}

{# CART MODAL - Agora carregado em layout.tpl #}
{% if false %}
{# {% if not store.is_catalog and settings.ajax_cart and template != 'cart' %}
  {% include "snipplets/cart-modal.tpl" %}
{% endif %} #}
{% endif %}

{% if settings.add_to_cart_recommendations %}
  {% embed "snipplets/modal.tpl" with{
    modal_id: 'related-products-notification',
    modal_class: 'bottom modal-overflow-none modal-bottom-sheet h-auto',
    modal_header_class: 'px-0 pt-0 mb-2 m-0 w-100',
    modal_position: 'bottom',
    modal_transition: 'slide',
    modal_width: 'centered modal-centered-md-600px p-3'
  } %}
    {% block modal_head %}
      {% block page_header_text %}{{ '¡Agregado al carrito!' | translate }}{% endblock page_header_text %}
    {% endblock %}
    {% block modal_body %}
      {% include "snipplets/notification-cart.tpl" with {related_products: true} %}
      <div class="js-related-products-notification-container" style="display: none"></div>
    {% endblock %}
  {% endembed %}
{% endif %}

{% embed "snipplets/modal.tpl" with {
  modal_id: 'js-cross-selling-modal',
  modal_class: 'bottom modal-bottom-sheet h-auto overflow-none modal-body-scrollable-auto',
  modal_header: true,
  modal_header_class: 'm-0 w-100',
  modal_position: 'bottom',
  modal_transition: 'slide',
  modal_footer: true,
  modal_width: 'centered-md m-0 p-0 modal-full-width modal-md-width-400px'
} %}
  {% block modal_head %}
    {{ '¡Descuento exclusivo!' | translate }}
  {% endblock %}
  {% block modal_body %}
    <div class="js-cross-selling-modal-body" style="display: none"></div>
  {% endblock %}
{% endembed %}

{# Script para busca inline - suporte mobile, foco e hover melhorado #}
<script>
(function() {
  document.addEventListener('DOMContentLoaded', function() {
    var wrapper = document.querySelector('.pg-header__search-wrapper');
    var input = document.querySelector('.pg-header__search-input');
    var searchForm = document.querySelector('.pg-header__search-form');
    var submitBtn = searchForm ? searchForm.querySelector('.pg-header__search-submit') : null;
    var closeTimeout;
    var isMobile = window.innerWidth < 768;

    if (!wrapper || !input || !searchForm) return;

    // Referência ao header row para controlar visibilidade da logo
    var headerRow = document.querySelector('.pg-header__row');

    // Funções auxiliares para abrir/fechar busca
    function openSearch() {
      wrapper.classList.add('is-open');
      if (headerRow) headerRow.classList.add('is-search-open');
    }

    function closeSearch() {
      wrapper.classList.remove('is-open');
      if (headerRow) headerRow.classList.remove('is-search-open');
    }

    // MOBILE: Comportamento específico
    if (isMobile) {
      // Criar botão de fechar (X)
      var closeBtn = document.createElement('button');
      closeBtn.className = 'pg-header__search-close';
      closeBtn.innerHTML = '✕';
      closeBtn.setAttribute('type', 'button');
      closeBtn.setAttribute('aria-label', 'Fechar busca');
      searchForm.appendChild(closeBtn);

      // Ao clicar no botão submit (lupa) - expande a busca
      if (submitBtn) {
        submitBtn.addEventListener('click', function(e) {
          if (!wrapper.classList.contains('is-open')) {
            // Primeiro clique: apenas expande, não submete
            e.preventDefault();
            e.stopPropagation();
            openSearch();
            setTimeout(function() {
              input.focus();
            }, 100);
          }
          // Se já está aberto e tem texto, deixa submeter normalmente
        });
      }

      // Ao clicar no X, fecha a busca
      closeBtn.addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation();

        // Remove classes (isso faz a logo voltar via CSS)
        closeSearch();

        // Limpa o campo
        input.value = '';

        // Remove foco
        input.blur();
      });

      // Fechar com ESC
      input.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
          closeSearch();
          input.value = '';
          input.blur();
        }
      });

    } else {
      // DESKTOP: Comportamento hover original

      // Expande no mouse enter (hover)
      wrapper.addEventListener('mouseenter', function() {
        clearTimeout(closeTimeout);
        openSearch();
        // Pequeno delay antes de focar para não ser muito agressivo
        setTimeout(function() {
          if (wrapper.matches(':hover')) {
            input.focus();
          }
        }, 150);
      });

      // Delay para fechar ao sair com o mouse
      wrapper.addEventListener('mouseleave', function() {
        // Só fecha se input não tiver foco
        if (document.activeElement !== input) {
          closeTimeout = setTimeout(function() {
            closeSearch();
          }, 500); // Delay de 500ms - tempo confortável para o usuário
        }
      });

      // Manter aberto enquanto tem foco no input
      input.addEventListener('focus', function() {
        clearTimeout(closeTimeout);
        openSearch();
      });

      // Fechar ao perder foco (com delay para permitir cliques)
      input.addEventListener('blur', function() {
        closeTimeout = setTimeout(function() {
          // Só fecha se mouse não estiver sobre o wrapper
          if (!wrapper.matches(':hover')) {
            closeSearch();
          }
        }, 300);
      });

      // ESC fecha imediatamente
      input.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
          clearTimeout(closeTimeout);
          closeSearch();
          input.blur();
        }
      });
    }

    // Atualizar isMobile quando redimensiona janela
    window.addEventListener('resize', function() {
      var newIsMobile = window.innerWidth < 768;
      if (newIsMobile !== isMobile) {
        location.reload(); // Recarrega para aplicar comportamento correto
      }
    });
  });
})();
</script>

{# SOLUÇÃO DEFINITIVA: CSS + JS inline para garantir funcionamento do menu #}
<style>@media(max-width:768px){.pg-header__icon-button{width:44px!important;height:44px!important;background:rgba(255,255,255,0.35)!important;backdrop-filter:blur(8px)!important;-webkit-backdrop-filter:blur(8px)!important;border:1px solid rgba(0,0,0,0.08)!important;border-radius:6px!important;display:flex!important;align-items:center!important;justify-content:center!important;padding:0!important}.pg-header__icon-button img{width:20px!important;height:20px!important;filter:none!important}.pg-header{min-height:60px!important;padding-top:8px!important}.pg-header__logo-img{max-height:28px!important}}</style>
<script>document.addEventListener("DOMContentLoaded",function(){document.querySelectorAll('[data-toggle="#nav-hamburger"]').forEach(function(e){e.addEventListener("click",function(e){e.preventDefault(),e.stopPropagation();var t=this.getAttribute("data-toggle"),o=document.querySelector(t),n=document.querySelector(".js-modal-overlay");if(o){o.classList.add("modal-show"),o.style.display="block",document.body.classList.add("modal-open"),n&&(n.style.display="block",n.onclick=function(){o.classList.remove("modal-show"),o.style.display="none",document.body.classList.remove("modal-open"),n.style.display="none"});var l=o.querySelector(".modal-close");l&&(l.onclick=function(){o.classList.remove("modal-show"),o.style.display="none",document.body.classList.remove("modal-open"),n&&(n.style.display="none")})}})})});</script>

{# CSS para "O Movimento" - Link Direto #}
<style>
/* Desktop: Container à esquerda agrupando hambúrguer e O Movimento */
.pg-header__left-group {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-shrink: 0;
  z-index: 2;
}

/* Desktop: Link "O Movimento" - Estilo consistente com header */
.pg-header__movimento-link-direct {
  box-sizing: border-box;
  height: 44px;
  min-height: 44px;
  border-radius: 6px;
  border: 1px solid rgba(0, 0, 0, 0.08);
  background: rgba(255, 255, 255, 0.35);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  padding: 0 16px;
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 14px;
  font-weight: 600;
  color: #000;
  text-decoration: none;
  white-space: nowrap;
}

.pg-header__movimento-link-direct:hover {
  background: rgba(255, 255, 255, 0.5);
  border-color: rgba(0, 0, 0, 0.15);
}

/* Mobile: Esconder link direto (aparece no menu hambúrguer) */
@media (max-width: 768px) {
  .pg-header__left-group {
    display: flex;
    align-items: center;
    gap: 0;
  }

  .pg-header__movimento-link-direct {
    display: none;
  }
}

/* Mobile Menu: Link O Movimento */
.pg-menu-movimento__link {
  display: block;
  font-family: 'Familjen Grotesk', sans-serif !important;
  font-weight: normal !important;
  font-size: 17px !important;
  line-height: 50px !important;
  letter-spacing: 0px !important;
  color: #EAFE67 !important;
  text-transform: uppercase !important;
  text-align: left !important;
  padding: 0 !important;
  margin: 0 !important;
  border: none !important;
  border-bottom: 1px solid #EAFE67 !important;
  transition: opacity 0.2s ease;
}

.pg-menu-movimento__link:hover {
  opacity: 0.8 !important;
}
</style>

