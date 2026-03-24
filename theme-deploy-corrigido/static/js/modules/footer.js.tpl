{#/*============================================================================
  Patagang Store — Footer Module (Story 8.5 Priority 2)
  Extracted from store.js.tpl (linhas 2863-2869)

  Responsabilidades:
  - Adicionar atributo alt a logos AFIP (para SEO)

  Padrão: IIFE com typeof checks + namespace PatagangStore
  Auto-init: DOMContentLoaded
==============================================================================*/#}

(function() {
  'use strict';

  {# Verificar dependências #}
  if (typeof jQueryNuvem === 'undefined') {
    console.warn('[PatagangStore.footer] jQuery não disponível');
    return;
  }

  {# Função: Adicionar alt attr a logo AFIP (SEO) #}
  const setupAFIPLogo = function() {
    {# Verificar se store possui AFIP #}
    const hasAFIP = document.body.getAttribute('data-store-afip') === 'true';
    if (!hasAFIP) {
      return;
    }

    {# Encontrar img AFIP e adicionar alt #}
    const $afipLogo = jQueryNuvem('img[src*="www.afip.gob.ar"]');
    if ($afipLogo.length > 0) {
      $afipLogo.attr('alt', 'Logo de AFIP');
    }
  };

  {# Função principal: Inicializar footer handlers #}
  const initFooter = function() {
    setupAFIPLogo();
    console.log('[PatagangStore.footer] ✓ Inicialisado');
  };

  {# Expor interface pública #}
  window.PatagangStore = window.PatagangStore || {};
  window.PatagangStore.footer = {
    init: initFooter
  };

  {# Auto-inicializar quando DOM estiver pronto #}
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initFooter);
  } else {
    initFooter();
  }
})();
