{#/*============================================================================
  Patagang Store — Forms Module (Story 8.5 Priority 2)
  Extracted from store.js.tpl (linhas 2823-2857)

  Responsabilidades:
  - Gerenciar form de validação (Winnie Pooh form)
  - Ressend validation link em account pages
  - Toggle password visibility
  - Alert styling para campos inválidos

  Padrão: IIFE com typeof checks + namespace PatagangStore
  Auto-init: DOMContentLoaded
==============================================================================*/#}

(function() {
  'use strict';

  {# Verificar dependências #}
  if (typeof jQueryNuvem === 'undefined') {
    console.warn('[PatagangStore.forms] jQuery não disponível');
    return;
  }

  {# Função: Gerenciar Winnie Pooh form (anti-bot validation) #}
  const setupWinniePoohForm = function() {
    jQueryNuvem(".js-winnie-pooh-form").on("submit", function(e) {
      jQueryNuvem(e.currentTarget).attr('action', '');
    });
  };

  {# Função: Ressend validation email link #}
  const setupResendValidationLink = function() {
    {# Verificar se estamos em account pages #}
    const template = document.body.getAttribute('data-template');
    if (template !== 'account.register' && template !== 'account.login') {
      return;
    }

    jQueryNuvem(".js-resend-validation-link").on("click", function(e) {
      e.preventDefault();
      if (typeof window.accountVerificationService !== 'undefined') {
        const email = document.body.getAttribute('data-customer-email');
        if (email) {
          window.accountVerificationService.resendVerificationEmail(email);
        }
      }
    });
  };

  {# Função: Gerenciar alert styling em login page #}
  const setupLoginValidation = function() {
    const template = document.body.getAttribute('data-template');
    if (template !== 'account.login') {
      return;
    }

    {# Verificar se há erro de validação #}
    const hasError = document.body.getAttribute('data-login-invalid') === 'true';
    if (hasError) {
      jQueryNuvem(".js-account-input").addClass("alert-danger");

      {# Remover alert quando usuário focus no campo #}
      jQueryNuvem(".js-account-input.alert-danger").on("focus", function() {
        jQueryNuvem(".js-account-input").removeClass("alert-danger");
      });
    }
  };

  {# Função: Toggle password visibility #}
  const setupPasswordVisibility = function() {
    jQueryNuvem('.js-password-view').on("click", function(e) {
      e.preventDefault();
      const $button = jQueryNuvem(e.currentTarget);
      const $input = $button.parent().find(".js-password-input");
      const $eyeOpen = $button.find(".js-eye-open");
      const $eyeClosed = $button.find(".js-eye-closed");

      {# Toggle entre password e text #}
      if ($button.hasClass('password-view')) {
        {# Mostrar senha #}
        $input.attr('type', 'text');
        $eyeOpen.hide();
        $eyeClosed.show();
      } else {
        {# Esconder senha #}
        $input.attr('type', 'password');
        $eyeOpen.show();
        $eyeClosed.hide();
      }

      {# Toggle classe no botão #}
      $button.toggleClass('password-view');
    });
  };

  {# Função principal: Inicializar todos os form handlers #}
  const initForms = function() {
    setupWinniePoohForm();
    setupResendValidationLink();
    setupLoginValidation();
    setupPasswordVisibility();
    console.log('[PatagangStore.forms] ✓ Inicialisado');
  };

  {# Expor interface pública #}
  window.PatagangStore = window.PatagangStore || {};
  window.PatagangStore.forms = {
    init: initForms
  };

  {# Auto-inicializar quando DOM estiver pronto #}
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initForms);
  } else {
    initForms();
  }
})();
