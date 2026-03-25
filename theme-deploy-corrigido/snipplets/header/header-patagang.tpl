{# PataGang Header - v2.2 - Navegação Desktop + Ícones menores (plano executado) #}
{% set is_fixed = settings.head_fix %}
<header class="pg-header {% if is_fixed %}pg-header--sticky{% endif %}" data-store="head">
  {# Banner de anúncio movido para layout.tpl para evitar sobreposição #}


  <div class="pg-header__container pg-container">
    <div class="pg-header__row">
      <div class="pg-header__left-group">
        {# Hambúrguer - Visível APENAS no mobile #}
        <button class="pg-header__icon-button pg-header__hamburger-btn js-modal-open"
                data-toggle="#nav-hamburger"
                aria-label="{{ 'Menu de navegação' | translate }}">
          <img src="{{ 'images/icons/menu.svg' | static_url }}" alt="" width="14" height="14" loading="lazy">
        </button>

        {# Navegação Desktop - Links dinâmicos do menu principal com dropdown #}
        <nav class="pg-header__nav-desktop" aria-label="Navegação principal">
          {% for item in navigation %}
            {% if item.subitems %}
              {# Item com subcategorias - Dropdown ao clicar #}
              <div class="pg-header__nav-item pg-header__nav-item--has-dropdown">
                <button type="button" class="pg-header__nav-link pg-header__nav-link--dropdown js-dropdown-toggle" data-dropdown="{{ loop.index }}">
                  {{ item.name }}
                  <svg class="pg-header__nav-arrow" width="10" height="10" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  </svg>
                </button>
                <div class="pg-header__dropdown js-dropdown-content" data-dropdown-id="{{ loop.index }}" style="display: none;">
                  <div class="pg-header__dropdown-inner">
                    {% if item.isCategory %}
                      <a href="{{ item.url }}" class="pg-header__dropdown-link pg-header__dropdown-link--all">
                        Ver tudo em {{ item.name }}
                      </a>
                    {% endif %}
                    {% for subitem in item.subitems %}
                      <a href="{{ subitem.url }}" class="pg-header__dropdown-link">{{ subitem.name }}</a>
                    {% endfor %}
                  </div>
                </div>
              </div>
            {% else %}
              {# Item simples - Link direto #}
              <a href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}" class="pg-header__nav-link">
                {{ item.name }}
              </a>
            {% endif %}
          {% endfor %}
          {# A GANG - Link fixo na navegação desktop #}
          <a href="/comunidade" class="pg-header__nav-link">A GANG</a>
        </nav>
      </div>

      <a class="pg-header__logo" href="{{ store.url }}">
        <img src="{{ 'images/logos/logotipo.svg' | static_url }}" alt="{{ store.name }}" class="pg-header__logo-img" loading="lazy">
        <img src="{{ 'images/logos/logo-mark.svg' | static_url }}" alt="{{ store.name }}" class="pg-header__logo-img--hover" loading="lazy">
      </a>

      <div class="pg-header__actions">
        {# Busca - Abre modal padrão #}
        <button type="button"
                class="pg-header__icon-button js-modal-open"
                data-toggle="#nav-search"
                aria-label="{{ 'Buscar' | translate }}">
          <svg width="14" height="14" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="28" cy="28" r="20" stroke="currentColor" stroke-width="4"/>
            <line x1="44" y1="44" x2="58" y2="58" stroke="currentColor" stroke-width="4" stroke-linecap="round"/>
          </svg>
        </button>

        <a href="{{ store.customer_login_url }}" class="pg-header__icon-button" aria-label="{{ 'Entrar' | translate }}">
          {# ÍCONE PERFIL - PATAGANG Official - Traços Refinados #}
          <svg width="14" height="14" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="32" cy="26" r="18" stroke="currentColor" stroke-width="4"/>
            <line x1="22" y1="40" x2="10" y2="60" stroke="currentColor" stroke-width="4" stroke-linecap="butt"/>
            <line x1="42" y1="40" x2="54" y2="60" stroke="currentColor" stroke-width="4" stroke-linecap="butt"/>
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
            {# ÍCONE SACOLA - PATAGANG Official - Traços Refinados #}
            <svg width="14" height="15" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M22 6 H42 V18 H22 Z" stroke="currentColor" stroke-width="4" stroke-linejoin="round"/>
              <path d="M14 22 L8 60 H56 L50 22 H14 Z" stroke="currentColor" stroke-width="4" stroke-linejoin="round"/>
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

      {# A GANG - Link único no Mobile #}
      <div class="pg-menu-movimento">
        <a href="/comunidade" class="nav-list-link pg-menu-movimento__link">A GANG</a>
      </div>

      {# Divisor Visual #}
      <div class="pg-menu-divider"></div>

      {# Links Secundários (Conta e Idioma) - Movidos para o corpo #}
      {% include "snipplets/navigation/navigation-panel.tpl" %}
    </div>
  {% endblock %}
{% endembed %}

{# Modal de busca simples (campo padrão) #}
{% embed "snipplets/modal.tpl" with{
  modal_id: 'nav-search',
  modal_class: 'nav-search',
  modal_header_class: 'd-none',
  modal_transition: 'fade',
  modal_header_title: false,
  modal_mobile_full_screen: true
} %}
  {% block modal_body %}
    {% include "snipplets/header/header-search.tpl" with {search_modal: true} %}
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


{# Ícones do header menores (exceto logo) - 30px botão, 14px svg/img #}
<style>.pg-header__icon-button{width:30px!important;height:30px!important;min-width:30px!important;min-height:30px!important;display:flex!important;align-items:center!important;justify-content:center!important;padding:0!important}.pg-header__icon-button svg,.pg-header__icon-button img{width:14px!important;height:14px!important;flex-shrink:0}.pg-header__icon-button svg[height="15"]{height:15px!important}@media(max-width:768px){.pg-header__icon-button{width:30px!important;height:30px!important;background:rgba(255,255,255,0.35)!important;backdrop-filter:blur(8px)!important;-webkit-backdrop-filter:blur(8px)!important;border:1px solid rgba(0,0,0,0.08)!important;border-radius:6px!important}.pg-header__icon-button img{width:14px!important;height:14px!important;filter:none!important}body:not(.has-ad-bar) .pg-header{min-height:56px!important;padding-top:6px!important}.pg-header__logo-img{max-height:26px!important}.pg-header__container{padding-left:16px!important;padding-right:16px!important}}</style>
<script>document.addEventListener("DOMContentLoaded",function(){document.querySelectorAll('[data-toggle="#nav-hamburger"]').forEach(function(e){e.addEventListener("click",function(e){e.preventDefault(),e.stopPropagation();var t=this.getAttribute("data-toggle"),o=document.querySelector(t),n=document.querySelector(".js-modal-overlay");if(o){o.classList.add("modal-show"),o.style.display="block",document.body.classList.add("modal-open"),n&&(n.style.display="block",n.onclick=function(){o.classList.remove("modal-show"),o.style.display="none",document.body.classList.remove("modal-open"),n.style.display="none"});var l=o.querySelector(".modal-close");l&&(l.onclick=function(){o.classList.remove("modal-show"),o.style.display="none",document.body.classList.remove("modal-open"),n&&(n.style.display="none")})}})})});</script>

{# CSS para Navegação Desktop #}
<style>
/* Desktop: Container à esquerda agrupando hambúrguer e navegação */
.pg-header__left-group {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-shrink: 0;
  z-index: 2;
}

/* Navegação Desktop - Links horizontais */
.pg-header__nav-desktop {
  display: none; /* Escondido no mobile por padrão */
}

.pg-header__nav-link {
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 10px; /* Reduzido de 11px para 10px */
  font-weight: 600;
  color: #000;
  text-decoration: none;
  text-transform: uppercase;
  letter-spacing: 0.3px; /* Reduzido de 0.5px para 0.3px */
  white-space: nowrap;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-height: 26px; /* Reduzido de 30px para 26px */
  padding: 0 8px; /* Reduzido de 10px para 8px */
  border-radius: 5px;
  border: 1px solid rgba(0, 0, 0, 0.08);
  background: rgba(255, 255, 255, 0.35);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  transition: all 0.2s ease;
}

.pg-header__nav-link:hover {
  background: rgba(255, 255, 255, 0.5);
  border-color: rgba(0, 0, 0, 0.15);
}

/* Desktop: Mostrar navegação, ocultar hambúrguer */
@media (min-width: 769px) {
  .pg-header__nav-desktop {
    display: flex;
    align-items: center;
    gap: 4px;
    flex-wrap: nowrap;
    flex-shrink: 0;
    margin-left: 20px; /* Afasta da borda esquerda */
  }

  .pg-header__hamburger-btn {
    display: none !important;
  }
}

/* Ajuste responsivo para telas menores */
@media (min-width: 769px) and (max-width: 1100px) {
  .pg-header__nav-desktop {
    margin-left: 10px; /* Menos margem em telas médias */
    gap: 3px;
  }
}

/* Telas grandes - mais espaço */
@media (min-width: 1400px) {
  .pg-header__nav-desktop {
    margin-left: 40px; /* Mais afastado em telas grandes */
    gap: 6px;
  }
}

/* Mobile: Esconder navegação desktop, mostrar hambúrguer */
@media (max-width: 768px) {
  .pg-header__left-group {
    display: flex;
    align-items: center;
    gap: 0;
  }

  .pg-header__nav-desktop {
    display: none !important;
  }
}

/* ============================================
   HEADER LAYOUT FIX
   Protege alinhamento da Logo e Menu
   (Nota: CSS da BARRA DE FRETE movido para style-critical.tpl)
   ============================================ */
.pg-header__row {
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 100%;
}

/* Centraliza Logo Absolutamente para evitar deslocamento pelo menu */
@media (min-width: 992px) {
  .pg-header__row {
    display: grid;
    grid-template-columns: minmax(0, 1fr) auto minmax(0, 1fr);
    align-items: center;
    column-gap: 24px;
  }

  .pg-header__logo {
    position: relative;
    transform: none;
    justify-self: center;
    z-index: 10;
  }

  .pg-header__left-group {
    flex: 0 1 auto;
    justify-content: flex-end;
    min-width: 0;
    padding-right: 24px;
  }

  .pg-header__actions {
    flex: 0 0 auto;
    justify-content: flex-end;
    justify-self: end;
    min-width: 0;
    padding-left: 24px;
  }

  .pg-header__nav-desktop {
    justify-content: flex-end;
  }
}

.pg-header__logo-img--hover {
  opacity: 0;
}

.pg-header__logo:hover .pg-header__logo-img--hover {
  opacity: 1;
}

/* Mobile Menu: Link O Movimento - Delegado ao style-menu-patagang.css.tpl */
/* Estilos inline removidos - agora controlados pelo CSS externo */
</style>

{# JavaScript para Dropdown Desktop ao Clicar #}
<script>
document.addEventListener('DOMContentLoaded', function() {
  var dropdownToggles = document.querySelectorAll('.js-dropdown-toggle');
  
  dropdownToggles.forEach(function(toggle) {
    toggle.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      
      var dropdownId = this.getAttribute('data-dropdown');
      var dropdown = document.querySelector('.js-dropdown-content[data-dropdown-id="' + dropdownId + '"]');
      var isActive = this.classList.contains('is-active');
      
      // Fecha todos os outros dropdowns
      document.querySelectorAll('.js-dropdown-toggle').forEach(function(t) {
        t.classList.remove('is-active');
      });
      document.querySelectorAll('.js-dropdown-content').forEach(function(d) {
        d.classList.remove('is-open');
      });
      
      // Toggle do dropdown clicado
      if (!isActive && dropdown) {
        this.classList.add('is-active');
        dropdown.classList.add('is-open');
      }
    });
  });
  
  // Fecha dropdown ao clicar fora
  document.addEventListener('click', function(e) {
    if (!e.target.closest('.pg-header__nav-item--has-dropdown')) {
      document.querySelectorAll('.js-dropdown-toggle').forEach(function(t) {
        t.classList.remove('is-active');
      });
      document.querySelectorAll('.js-dropdown-content').forEach(function(d) {
        d.classList.remove('is-open');
      });
    }
  });
});
</script>
