{#/*============================================================================
    #PATAGANG - Cart Utilities - Sistema Unificado de Atualização
    #Performance otimizada com feedback visual imediato
==============================================================================*/#}

(function() {
    'use strict';

    // ============================================
    // CONFIGURAÇÃO
    // ============================================

    const CONFIG = {
        debounceDelay: 150,
        animationDuration: 200
    };

    // ============================================
    // ESTADO - Rastreamento de atualizações pendentes
    // ============================================

    const pendingUpdates = new Map();
    const loadingItems = new Set();

    // ============================================
    // UTILIDADES
    // ============================================

    function $(selector, parent = document) {
        return parent.querySelector(selector);
    }

    function $$(selector, parent = document) {
        return Array.from(parent.querySelectorAll(selector));
    }

    function showSpinner(itemId) {
        // Suporta ambos seletores (.js-cart-* e .js-pg-*)
        const spinner = $(`.js-cart-input-spinner[data-item-id="${itemId}"], .js-cart-item[data-item-id="${itemId}"] .js-cart-input-spinner, .js-pg-item-loading[data-item-id="${itemId}"], .js-pg-cart-item[data-item-id="${itemId}"] .js-pg-item-loading`);
        if (spinner) {
            spinner.style.display = 'inline-block';
        }

        // Adiciona classe de loading ao item (suporta ambos seletores)
        const item = $(`.js-cart-item[data-item-id="${itemId}"], .js-pg-cart-item[data-item-id="${itemId}"]`);
        if (item) {
            item.classList.add('is-updating');
        }

        loadingItems.add(itemId);
    }

    function hideSpinner(itemId) {
        // Suporta ambos seletores (.js-cart-* e .js-pg-*)
        const spinner = $(`.js-cart-input-spinner[data-item-id="${itemId}"], .js-cart-item[data-item-id="${itemId}"] .js-cart-input-spinner, .js-pg-item-loading[data-item-id="${itemId}"], .js-pg-cart-item[data-item-id="${itemId}"] .js-pg-item-loading`);
        if (spinner) {
            spinner.style.display = 'none';
        }

        // Remove classe de loading do item (suporta ambos seletores)
        const item = $(`.js-cart-item[data-item-id="${itemId}"], .js-pg-cart-item[data-item-id="${itemId}"]`);
        if (item) {
            item.classList.remove('is-updating');
        }

        loadingItems.delete(itemId);
    }

    function disableButtons(itemId, disabled = true) {
        // PATAGANG: Função mantida para compatibilidade, mas não mais necessária
        // Os métodos nativos LS.plusQuantity/LS.minusQuantity gerenciam o estado internamente
        const buttons = $$(`.js-cart-item[data-item-id="${itemId}"] .js-cart-quantity-btn, .js-pg-cart-item[data-item-id="${itemId}"] .pg-qty-pill__btn`);
        buttons.forEach(btn => {
            btn.disabled = disabled;
            if (disabled) {
                btn.classList.add('is-disabled');
            } else {
                btn.classList.remove('is-disabled');
            }
        });
    }

    function updateInputValue(itemId, newValue) {
        // Suporta ambos seletores
        const inputs = $$(`.js-cart-quantity-input[data-item-id="${itemId}"], .js-pg-qty-input[data-item-id="${itemId}"]`);
        inputs.forEach(input => {
            // Salva valor original antes de atualizar
            if (!input.dataset.original) {
                input.dataset.original = input.value;
            }
            input.value = newValue;
            // Dispara evento para notificar outros sistemas
            input.dispatchEvent(new Event('input', { bubbles: true }));
        });
    }

    // ============================================
    // ATUALIZAÇÃO UNIFICADA DE QUANTIDADE
    // ============================================

    /**
     * Atualiza quantidade com feedback visual imediato
     * @param {number} itemId - ID do item no carrinho
     * @param {number} newQuantity - Nova quantidade
     * @param {boolean} updateDrawer - Se deve atualizar drawer (true = drawer, false = página carrinho)
     */
    function updateQuantity(itemId, newQuantity, updateDrawer = false) {
        // Cancela update pendente anterior para este item
        const existing = pendingUpdates.get(itemId);
        if (existing) {
            clearTimeout(existing.timeout);
        }

        // Atualiza UI IMEDIATAMENTE (feedback instantâneo)
        updateInputValue(itemId, newQuantity);

        // Mostra spinner e desabilita botões
        showSpinner(itemId);
        disableButtons(itemId, true);

        // Agenda requisição com debounce muito curto para resposta mais rápida
        const timeout = setTimeout(() => {
            executeQuantityUpdate(itemId, newQuantity, updateDrawer);
        }, 50); // Reduzido de 150ms para 50ms para resposta quase instantânea

        pendingUpdates.set(itemId, { timeout, quantity: newQuantity });
    }

    /**
     * Executa update via API Nuvemshop com tratamento de erros
     */
    function executeQuantityUpdate(itemId, quantity, updateDrawer) {
        pendingUpdates.delete(itemId);

        // Salva valor original para reversão em caso de erro
        const input = $(`.js-cart-quantity-input[data-item-id="${itemId}"]`);
        const originalValue = input ? (input.dataset.original || input.value) : quantity;

        // Sempre usa API LS da Nuvemshop para consistência
        if (typeof LS !== 'undefined' && LS.changeQuantity) {
            LS.changeQuantity(itemId, quantity, updateDrawer, function(cart) {
                hideSpinner(itemId);
                disableButtons(itemId, false);

                if (cart) {
                    updateCartUI(cart, itemId);

                    // Atualiza valor original após sucesso
                    if (input) {
                        input.dataset.original = quantity;
                    }
                } else {
                    // Se não retornou cart, reverte para valor original
                    revertQuantityUpdate(itemId, originalValue);
                }
            });
        } else {
            // Fallback: recarrega a página
            hideSpinner(itemId);
            disableButtons(itemId, false);
            console.warn('[Cart Utils] LS.changeQuantity não disponível, recarregando página');

            // Tenta reverter antes de recarregar
            revertQuantityUpdate(itemId, originalValue);

            setTimeout(function() {
                window.location.reload();
            }, 500);
        }
    }

    /**
     * Reverte atualização em caso de erro
     */
    function revertQuantityUpdate(itemId, originalValue) {
        const input = $(`.js-cart-quantity-input[data-item-id="${itemId}"]`);
        if (input) {
            input.value = originalValue;
        }

        hideSpinner(itemId);
        disableButtons(itemId, false);

        console.error('[Cart Utils] Erro ao atualizar quantidade, revertido para:', originalValue);

        // Mostra mensagem amigável ao usuário
        const item = $(`.js-cart-item[data-item-id="${itemId}"]`);
        if (item) {
            const errorMsg = document.createElement('div');
            errorMsg.className = 'cart-error-message';
            errorMsg.textContent = 'Erro ao atualizar quantidade. Por favor, tente novamente.';
            errorMsg.style.cssText = 'position: absolute; top: 10px; left: 50%; transform: translateX(-50%); background: #ff4444; color: white; padding: 8px 16px; border-radius: 4px; font-size: 12px; z-index: 1000;';

            item.style.position = 'relative';
            item.appendChild(errorMsg);

            setTimeout(function() {
                if (errorMsg.parentNode) {
                    errorMsg.parentNode.removeChild(errorMsg);
                }
            }, 3000);
        }
    }

    // ============================================
    // ATUALIZAÇÃO DA UI DO CARRINHO
    // ============================================

    function updateCartUI(cart, itemId) {
        if (!cart || !cart.items) return;

        // Atualiza subtotal do item específico
        const item = cart.items.find(i => i.id === itemId);
        if (item) {
            // Atualiza subtotal com ambos seletores
            const subtotalEls = $$(`.js-cart-item-subtotal[data-line-item-id="${itemId}"], .js-pg-item-subtotal[data-item-id="${itemId}"]`);
            subtotalEls.forEach(el => {
                if (item.subtotal) {
                    el.textContent = formatMoney(item.subtotal);
                    if (el.setAttribute) el.setAttribute('data-component-value', item.subtotal);
                }
            });

            // Atualiza quantidade no input (suporta ambos seletores)
            updateInputValue(itemId, item.quantity);
        }

        // Atualiza totais globais
        updateTotals(cart);

        // Atualiza contador do header
        updateCartCount(cart.items_count || 0);
    }

    function updateTotals(cart) {
        // Atualiza subtotal do carrinho
        $$('.js-cart-subtotal, .js-pg-cart-subtotal').forEach(el => {
            if (cart.subtotal) {
                el.textContent = formatMoney(cart.subtotal);
            }
        });

        // Atualiza total do carrinho
        $$('.js-cart-total, .js-pg-cart-total').forEach(el => {
            if (cart.total) {
                el.textContent = formatMoney(cart.total);
            }
        });
    }

    function updateCartCount(count) {
        // Atualiza contador em todos os seletores possíveis
        $$('.js-cart-widget-amount, .js-pg-cart-count').forEach(el => {
            el.textContent = count || 0;
        });

        // Atualiza plural/singular se existir
        if (count > 1) {
            $$('.js-cart-counts-plural').forEach(el => el.style.display = '');
            $$('.js-cart-counts-singular').forEach(el => el.style.display = 'none');
        } else {
            $$('.js-cart-counts-plural').forEach(el => el.style.display = 'none');
            $$('.js-cart-counts-singular').forEach(el => el.style.display = '');
        }
    }

    function formatMoney(cents) {
        if (typeof cents === 'string') {
            return cents; // Já formatado
        }
        const value = (cents / 100).toFixed(2).replace('.', ',');
        return 'R$ ' + value;
    }

    // ============================================
    // FUNÇÕES PÚBLICAS - Plus/Minus Quantity
    // ============================================

    /**
     * Aumenta quantidade em 1
     */
    window.PGCartUtils = window.PGCartUtils || {};
    window.PGCartUtils.plusQuantity = function(itemId, updateDrawer = false) {
        // Suporta ambos seletores
        const input = $(`.js-cart-quantity-input[data-item-id="${itemId}"], .js-pg-qty-input[data-item-id="${itemId}"]`);
        if (!input) {
            console.warn('[Cart Utils] Input não encontrado para item:', itemId);
            return;
        }

        const currentQty = parseInt(input.value) || 1;
        const newQty = currentQty + 1;

        console.log('[Cart Utils] Plus clicked - ItemID:', itemId, 'CurrentQty:', currentQty, 'NewQty:', newQty, 'UpdateDrawer:', updateDrawer);
        updateQuantity(itemId, newQty, updateDrawer);
    };

    /**
     * Diminui quantidade em 1
     */
    window.PGCartUtils.minusQuantity = function(itemId, updateDrawer = false) {
        // Suporta ambos seletores
        const input = $(`.js-cart-quantity-input[data-item-id="${itemId}"], .js-pg-qty-input[data-item-id="${itemId}"]`);
        if (!input) {
            console.warn('[Cart Utils] Input não encontrado para item:', itemId);
            return;
        }

        const currentQty = parseInt(input.value) || 1;

        if (currentQty <= 1) {
            // Remove item se quantidade for 1 ou menor
            window.PGCartUtils.removeItem(itemId, updateDrawer);
            return;
        }

        const newQty = currentQty - 1;
        console.log('[Cart Utils] Minus clicked - ItemID:', itemId, 'CurrentQty:', currentQty, 'NewQty:', newQty, 'UpdateDrawer:', updateDrawer);
        updateQuantity(itemId, newQty, updateDrawer);
    };

    /**
     * Remove item do carrinho
     */
    window.PGCartUtils.removeItem = function(itemId, updateDrawer = false) {
        // Suporta ambos seletores
        const item = $(`.js-cart-item[data-item-id="${itemId}"], .js-pg-cart-item[data-item-id="${itemId}"]`);
        if (item) {
            item.classList.add('is-removing');
        }

        if (typeof LS !== 'undefined' && LS.removeItem) {
            LS.removeItem(itemId, updateDrawer, function(cart) {
                if (cart) {
                    updateCartUI(cart, itemId);
                    // Se carrinho ficou vazio, recarrega página
                    if (!cart.items || cart.items.length === 0) {
                        window.location.reload();
                    }
                }
            });
        } else {
            console.warn('[Cart Utils] Nenhum método de remoção disponível');
            if (item) {
                item.classList.remove('is-removing');
            }
        }
    };

    // ============================================
    // INICIALIZAÇÃO - Event Listeners
    // ============================================

    function bindEvents() {
        // PATAGANG: Handlers de +/- REMOVIDOS
        // Agora usamos onclick com LS.minusQuantity/LS.plusQuantity
        // diretamente nos templates para sincronização nativa com Nuvemshop

        // Mantido apenas handler de remover item (botão lixeira)
        document.addEventListener('click', function(e) {
            // Botão remover
            const removeBtn = e.target.closest('.js-cart-item-remove, .pg-cart-item__remove, .js-pg-item-remove');
            if (removeBtn) {
                e.preventDefault();
                const itemId = removeBtn.getAttribute('data-item-id') ||
                               removeBtn.closest('.js-cart-item')?.getAttribute('data-item-id');

                if (itemId) {
                    if (confirm('Tem certeza que deseja remover este item?')) {
                        window.PGCartUtils.removeItem(itemId, false);
                    }
                }
                return;
            }
        });
    }

    // Inicialização: já estamos dentro de LS.ready.then(), então DOM está pronto
    // Mas aguardamos um tick para garantir que todos os elementos estão no DOM
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', bindEvents);
    } else {
        // DOM já está pronto, inicializa imediatamente
        bindEvents();
    }

    console.log('[Cart Utils] Sistema unificado de atualização inicializado');

})();

