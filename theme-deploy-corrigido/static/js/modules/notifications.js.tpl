{#/*============================================================================
  Patagang Store — Notifications Module (Story 8.5 Priority 2)
  Extracted from store.js.tpl (linhas 87-165)

  Responsabilidades:
  - Mostrar/esconder notificações no site
  - Lidar com close button de notificações
  - Gerenciar notificações de status de pedido
  - Gerenciar notificações de carrinho
  - Cookie banner + positioning do Whatsapp

  Padrão: IIFE com typeof checks + namespace PatagangStore
  Auto-init: DOMContentLoaded
==============================================================================*/#}

(function() {
  'use strict';

  {# Verificar dependências #}
  if (typeof jQueryNuvem === 'undefined') {
    console.warn('[PatagangStore.notifications] jQuery não disponível');
    return;
  }

  {# Variáveis do módulo #}
  var $notification_status_page = jQueryNuvem(".js-notification-status-page");
  var $fixed_bottom_button = jQueryNuvem(".js-btn-fixed-bottom");

  {# Função: Fechar notificação genérica #}
  const closeNotification = function() {
    jQueryNuvem(".js-notification-close").on("click", function(e) {
      e.preventDefault();
      jQueryNuvem(e.currentTarget).closest(".js-notification").hide();
    });
  };

  {# Função: Gerenciar notificação de status de pedido #}
  const setupOrderStatusNotification = function() {
    if ($notification_status_page.length > 0) {
      if (typeof LS !== 'undefined' && LS.shouldShowOrderStatusNotification) {
        if (LS.shouldShowOrderStatusNotification($notification_status_page.data('url'))) {
          $notification_status_page.show();
        }
        jQueryNuvem(".js-notification-status-page-close").on("click", function(e) {
          e.preventDefault();
          if (typeof LS !== 'undefined' && LS.dontShowOrderStatusNotificationAgain) {
            LS.dontShowOrderStatusNotificationAgain($notification_status_page.data('url'));
          }
        });
      }
    }
  };

  {# Função: Gerenciar notificação "adicionado ao carrinho" #}
  const setupCartNotification = function() {
    jQueryNuvem(".js-cart-notification-close").on("click", function() {
      jQueryNuvem(".js-alert-added-to-cart")
        .removeClass("notification-visible")
        .addClass("notification-hidden");

      setTimeout(function() {
        jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
        jQueryNuvem(".js-alert-added-to-cart").hide();
      }, 2000);
    });
  };

  {# Função: Gerenciar cookie banner e posicionamento #}
  const setupCookieBanner = function() {
    {# Skip se em preview mode #}
    if (document.body.classList.contains('preview-mode')) {
      return;
    }

    const footer = jQueryNuvem(".js-footer");

    {# Callback para restaurar notificações quando cookie banner fecha #}
    window.restoreNotifications = function() {
      {# Whatsapp button position #}
      if (window.innerWidth < 768) {
        $fixed_bottom_button.css("marginBottom", "10px");
      }

      {# Remove offset do footer #}
      footer.removeAttr("style");
    };

    {# Verificar se cookie foi reconhecido #}
    if (typeof window.cookieNotificationService !== 'undefined' &&
        !window.cookieNotificationService.isAcknowledged()) {

      jQueryNuvem(".js-notification-cookie-banner").show();

      {# Adicionar offset para footer comportar cookie banner #}
      const cookieBannerHeight = jQueryNuvem(".js-notification-cookie-banner").outerHeight();
      footer.css("paddingBottom", (cookieBannerHeight + 10) + "px");

      {# Ajustar posição do Whatsapp button #}
      if (window.innerWidth < 768) {
        $fixed_bottom_button.css("marginBottom", "120px");
      } else {
        $fixed_bottom_button.css("marginBottom", "70px");
      }

      {# Listener para botão acknowledge #}
      jQueryNuvem(".js-acknowledge-cookies").on("click", function(e) {
        window.cookieNotificationService.acknowledge();
        window.restoreNotifications();
      });
    }
  };

  {# Função principal: Inicializar todos os handlers #}
  const initNotifications = function() {
    closeNotification();
    setupOrderStatusNotification();
    setupCartNotification();
    setupCookieBanner();
    console.log('[PatagangStore.notifications] ✓ Inicialisado');
  };

  {# Expor interface pública #}
  window.PatagangStore = window.PatagangStore || {};
  window.PatagangStore.notifications = {
    init: initNotifications
  };

  {# Auto-inicializar quando DOM estiver pronto #}
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initNotifications);
  } else {
    initNotifications();
  }
})();
