{# PataGang Header - v2.1 - Navegação Desktop + Ícones Refinados #}
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
          <img src="{{ 'images/icons/menu.svg' | static_url }}" alt="" width="24" height="24" loading="lazy">
        </button>

        {# Navegação Desktop - Links dinâmicos do menu principal #}
        <nav class="pg-header__nav-desktop" aria-label="Navegação principal">
          {% for item in navigation %}
            <a href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}" class="pg-header__nav-link">
              {{ item.name }}
            </a>
          {% endfor %}
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
          <svg width="20" height="20" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="28" cy="28" r="20" stroke="currentColor" stroke-width="4"/>
            <line x1="44" y1="44" x2="58" y2="58" stroke="currentColor" stroke-width="4" stroke-linecap="round"/>
          </svg>
        </button>

        <a href="{{ store.customer_login_url }}" class="pg-header__icon-button" aria-label="{{ 'Entrar' | translate }}">
          {# ÍCONE PERFIL - PATAGANG Official - Traços Refinados #}
          <svg width="20" height="20" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
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
            <svg width="20" height="22" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
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


{# SOLUÇÃO DEFINITIVA: CSS + JS inline para garantir funcionamento do menu #}
<style>@media(max-width:768px){.pg-header__icon-button{width:44px!important;height:44px!important;background:rgba(255,255,255,0.35)!important;backdrop-filter:blur(8px)!important;-webkit-backdrop-filter:blur(8px)!important;border:1px solid rgba(0,0,0,0.08)!important;border-radius:6px!important;display:flex!important;align-items:center!important;justify-content:center!important;padding:0!important}.pg-header__icon-button img{width:20px!important;height:20px!important;filter:none!important}.pg-header{min-height:60px!important;padding-top:8px!important}.pg-header__logo-img{max-height:28px!important}}</style>
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
  font-size: 12px;
  font-weight: 600;
  color: #000;
  text-decoration: none;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  white-space: nowrap;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-height: 44px;
  padding: 0 14px;
  border-radius: 6px;
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
    gap: 8px;
  }

  .pg-header__hamburger-btn {
    display: none !important;
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
   BARRA DE FRETE TRANSPARENTE - FORCE
   ============================================ */
.section-advertising,
.section-advertising * {
    background-color: transparent !important;
    background: transparent !important;
    color: #000 !important;
}

.section-advertising .link-contrast {
    color: #000 !important; /* Garante visibilidade do texto */
}

/* ============================================
   HEADER LAYOUT FIX
   Protege alinhamento da Logo e Menu
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
