// ============================================================================
// PATAGANG: Override de texto do componente payment-discount-price
// Substitui "com Boleto" / "com Pix" por "no boleto/pix"
// ============================================================================

(function () {
    'use strict';

    console.log('[PATAGANG OVERRIDE] Script carregado v2');

    // Múltiplos seletores para garantir compatibilidade
    var SELECTORS = [
        '[data-component="payment-discount-price"]',
        '.js-payment-discount-price-product',
        '.text-accent',  // Classe genérica da Nuvemshop para preços com desconto
        '.pg-card__discount' // Classe adicionada no CSS para garantir
    ];

    var REPLACEMENTS = [
        { from: /com Boleto/gi, to: 'no boleto/pix' },
        { from: /com Pix/gi, to: 'no boleto/pix' }
    ];

    var processedElements = new WeakSet();

    function customizePaymentText() {
        var totalFound = 0;
        var totalChanged = 0;

        SELECTORS.forEach(function (selector) {
            var elements = document.querySelectorAll(selector);

            if (elements.length > 0) {
                // console.log('[PATAGANG] Seletor "' + selector + '" encontrou', elements.length, 'elemento(s)');
                totalFound += elements.length;
            }

            for (var i = 0; i < elements.length; i++) {
                var el = elements[i];

                // Evita processar o mesmo elemento múltiplas vezes se já foi alterado com sucesso
                // Mas precisamos ter cuidado, pois o texto pode ser revertido pelo JS da Nuvemshop
                // Então vamos verificar o texto atual sempre

                var text = el.textContent || el.innerText || '';
                var originalText = text;
                var changed = false;

                for (var j = 0; j < REPLACEMENTS.length; j++) {
                    if (REPLACEMENTS[j].from.test(text)) {
                        text = text.replace(REPLACEMENTS[j].from, REPLACEMENTS[j].to);
                        changed = true;
                    }
                }

                if (changed) {
                    el.textContent = text;
                    processedElements.add(el);
                    totalChanged++;
                    console.log('[PATAGANG] ✓ Substituído:', originalText.trim(), '→', text.trim());
                }
            }
        });

        if (totalFound === 0) {
            // console.warn('[PATAGANG] ⚠ Nenhum elemento encontrado nesta verificação.');
        }
    }

    // Executa imediatamente
    customizePaymentText();

    // Executa após delays para garantir que componente renderizou
    setTimeout(function () { customizePaymentText(); }, 500);
    setTimeout(function () { customizePaymentText(); }, 1500);
    setTimeout(function () { customizePaymentText(); }, 3000);

    // Monitora mudanças dinâmicas (variantes, AJAX cart, infinite scroll)
    var debounceTimer = null;
    var observer = new MutationObserver(function () {
        if (debounceTimer) clearTimeout(debounceTimer);
        debounceTimer = setTimeout(customizePaymentText, 50);
    });

    observer.observe(document.body, {
        childList: true,
        subtree: true,
        characterData: true
    });

    console.log('[PATAGANG OVERRIDE] Observer instalado');
})();
