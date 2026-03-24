{#/*============================================================================
  Patagang Store — Utilities Module (Story 8.5 Priority 2)
  Extracted from store.js.tpl (linhas 200-219 + 266-318)

  Responsabilidades:
  - Limpar hash da URL (remover #modal-fullscreen, etc)
  - Voltar navegação do browser
  - Gerenciar modais fullscreen (abrir/fechar com hash)
  - Gerenciar hash changes (fechar modal ao clicar back)
  - modalOpen() função principal

  Padrão: IIFE com typeof checks + namespace PatagangStore
  Auto-init: DOMContentLoaded (setupModalHashHandlers)
  Manual init: modalOpen(modal_id, openType)
==============================================================================*/#}

(function() {
  'use strict';

  {# Verificar dependências #}
  if (typeof jQueryNuvem === 'undefined') {
    console.warn('[PatagangStore.utilities] jQuery não disponível');
    return;
  }

  {# ========================================================================
     URL Hash Management — Funções auxiliares
     ======================================================================== #}

  {# Função: Limpar hash da URL (remove #modal-fullscreen) #}
  const cleanURLHash = function() {
    const uri = window.location.toString();
    const clean_uri = uri.substring(0, uri.indexOf("#"));
    window.history.replaceState({}, document.title, clean_uri);
  };

  {# Função: Voltar um passo no histórico e limpar hash #}
  const goBackBrowser = function() {
    cleanURLHash();
    history.back();
  };

  {# ========================================================================
     Modal Management — Handlers para abrir/fechar modais
     ======================================================================== #}

  {# Função: Setup inicial de handlers de hash em page load #}
  const setupModalHashHandlers = function() {
    {# Se página carregou com #modal-fullscreen na URL, limpar #}
    if (window.location.href.indexOf("modal-fullscreen") > -1) {
      cleanURLHash();
    }

    {# Handler: Click para abrir fullscreen modal #}
    jQueryNuvem(document).on("click", ".js-fullscreen-modal-open", function(e) {
      e.preventDefault();
      const modal_url_hash = jQueryNuvem(this).data("modalUrl");
      if (modal_url_hash) {
        window.location.hash = modal_url_hash;
      }
    });

    {# Handler: Click para fechar fullscreen modal #}
    jQueryNuvem(document).on("click", ".js-fullscreen-modal-close", function(e) {
      e.preventDefault();
      goBackBrowser();
    });

    {# Handler: Fechar modal quando usuário clica back button #}
    window.onhashchange = function() {
      if (window.location.href.indexOf("modal-fullscreen") <= -1) {
        {# Se há fullscreen modal aberto, fechar #}
        const $fullscreenModal = jQueryNuvem(".js-fullscreen-modal.modal-show");
        if ($fullscreenModal.length > 0) {
          {# Remove body lock se é o único modal #}
          if (jQueryNuvem(".js-modal.modal-show").length === 1) {
            jQueryNuvem("body").removeClass("overflow-none");
          }

          {# Fechar com animação #}
          const $overlay = $fullscreenModal.prev();
          $fullscreenModal.removeClass("modal-show");
          setTimeout(() => $fullscreenModal.hide(), 500);
          $overlay.fadeOut(500);

          {# Callback para limpar quick shop se aplicável #}
          if (typeof window.restoreQuickshopForm === 'function') {
            window.restoreQuickshopForm();
          }
        }
      }
    };
  };

  {# Função: Abrir modal (pode ser normal ou fullscreen) #}
  const modalOpen = function(modal_id, openType) {
    const $modal = jQueryNuvem(modal_id);
    const $overlay = jQueryNuvem('.js-modal-overlay[data-modal-id="' + modal_id + '"]');

    {# Se modal já está aberto, fechar #}
    if ($modal.hasClass("modal-show")) {
      $modal.removeClass("modal-show");
      setTimeout(() => $modal.hide(), 500);
      return;
    }

    {# Lock body scroll se não há modal aberto #}
    if (!jQueryNuvem(".js-modal.modal-show").length) {
      jQueryNuvem("body").addClass("overflow-none");
    }

    {# Abrir modal com animação #}
    $overlay.fadeIn(400);
    $modal.detach().appendTo("body");
    $overlay.detach().insertBefore(modal_id);
    $modal.show().addClass("modal-show");

    {# SPECIAL: Se é modal de carrinho, renderizar total #}
    if (modal_id === '#modal-cart') {
      setTimeout(function() {
        let total = 0;

        {# Tentar obter total do LS API #}
        if (typeof LS !== 'undefined' && LS.data && LS.data.cart) {
          total = LS.data.cart.total;
        }

        {# Fallback: obter do DOM se LS falhar #}
        if (!total) {
          const $subtotal = jQueryNuvem('.js-subtotal-price');
          if ($subtotal.length) {
            total = $subtotal.data('priceraw');
          }
        }

        {# Renderizar total se função disponível #}
        if (total && typeof window.renderCartTotal === 'function') {
          window.renderCartTotal(total, true);
          console.log('[MODAL OPEN] ✓ Total renderizado (Total: ' + total + ')');
        } else {
          console.warn('[MODAL OPEN] ⚠ Não foi possível obter total');
        }
      }, 100);
    }

    {# Adicionar hash URL se é fullscreen modal #}
    if (openType === 'openFullScreenWithoutClick' &&
        window.innerWidth < 768 &&
        $modal.hasClass("js-fullscreen-modal")) {
      const modal_url_hash = $modal.data("modalUrl");
      if (modal_url_hash) {
        window.location.hash = modal_url_hash;
      }
    }
  };

  {# Função principal: Inicializar utilities #}
  const initUtilities = function() {
    setupModalHashHandlers();
    console.log('[PatagangStore.utilities] ✓ Inicialisado');
  };

  {# Expor interface pública #}
  window.PatagangStore = window.PatagangStore || {};
  window.PatagangStore.utilities = {
    init: initUtilities,
    modalOpen: modalOpen,
    cleanURLHash: cleanURLHash,
    goBackBrowser: goBackBrowser
  };

  {# Expor funções globais para backward compatibility #}
  window.modalOpen = modalOpen;
  window.cleanURLHash = cleanURLHash;
  window.goBackBrowser = goBackBrowser;

  {# Auto-inicializar quando DOM estiver pronto #}
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initUtilities);
  } else {
    initUtilities();
  }
})();
