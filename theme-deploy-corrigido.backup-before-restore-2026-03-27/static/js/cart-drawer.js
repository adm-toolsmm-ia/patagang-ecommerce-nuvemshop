/**
 * ============================================
 * PATAGANG - CART DRAWER CONTROLLER v2
 * Performance otimizada - resposta instantânea
 * ============================================
 */

try {
(function() {
    'use strict';

    // ============================================
    // CONFIGURAÇÃO - Otimizada para velocidade
    // ============================================
    
    const CONFIG = {
        debounceDelay: 150,        // Reduzido de 500ms para 150ms - muito mais rápido
        animationDuration: 200,    // Animações mais rápidas
        selectors: {
            drawer: '#pg-cart-drawer',
            closeBtn: '.js-pg-drawer-close',
            itemsList: '.js-pg-cart-items-list',
            emptyState: '.js-pg-cart-empty',
            footer: '.js-pg-cart-footer',
            subtotal: '.js-pg-cart-subtotal',
            total: '.js-pg-cart-total',
            checkoutBtn: '.js-pg-checkout-btn',
            minimumAlert: '.js-pg-cart-minimum',
            cartCount: '.js-cart-widget-amount',
            item: '.js-pg-cart-item',
            itemLoading: '.js-pg-item-loading',
            qtyInput: '.js-pg-qty-input',
            qtyMinus: '.js-pg-qty-minus',
            qtyPlus: '.js-pg-qty-plus',
            removeBtn: '.js-pg-item-remove',
            itemSubtotal: '.js-pg-item-subtotal',
            // Cupom (v1.5.72 - Funcionalidade de cupom GANGDAPATA)
            couponForm: '.pg-drawer__coupon-form',
            couponInput: '.pg-drawer__coupon-input',
            couponBtn: '.pg-drawer__coupon-btn',
            couponSection: '.pg-drawer__coupon-section'
        }
    };

    // ============================================
    // ESTADO
    // ============================================
    
    const state = {
        isOpen: false,
        pendingUpdates: new Map(),
        currency: 'R$'
    };

    // ============================================
    // UTILIDADES
    // ============================================
    
    function formatMoney(cents) {
        const value = (cents / 100).toFixed(2).replace('.', ',');
        return state.currency + ' ' + value;
    }

    function $(selector, parent = document) {
        return parent.querySelector(selector);
    }

    function $$(selector, parent = document) {
        return parent.querySelectorAll(selector);
    }

    // ============================================
    // DRAWER CONTROL
    // ============================================
    
    function openDrawer() {
        const drawer = $(CONFIG.selectors.drawer);
        if (!drawer) return;

        drawer.style.display = 'block';
        document.body.style.overflow = 'hidden';
        requestAnimationFrame(() => {
            drawer.classList.add('is-open');
        });
        state.isOpen = true;
    }

    function closeDrawer() {
        const drawer = $(CONFIG.selectors.drawer);
        if (!drawer) return;

        drawer.classList.remove('is-open');
        state.isOpen = false;
        document.body.style.overflow = '';

        setTimeout(() => {
            drawer.style.display = 'none';
        }, CONFIG.animationDuration);
    }

    // ============================================
    // CART API - Otimizada
    // ============================================
    
    /**
     * Atualiza quantidade - RÁPIDO com UI instantânea
     */
    function updateQuantity(itemId, newQuantity) {
        // Cancela update pendente anterior
        const existing = state.pendingUpdates.get(itemId);
        if (existing) clearTimeout(existing);

        // Atualiza UI IMEDIATAMENTE (feedback instantâneo)
        const input = $(`${CONFIG.selectors.qtyInput}[data-item-id="${itemId}"]`);
        if (input) input.value = newQuantity;

        // Agenda requisição com debounce curto
        const timeout = setTimeout(() => {
            executeUpdate(itemId, newQuantity);
        }, CONFIG.debounceDelay);

        state.pendingUpdates.set(itemId, timeout);
    }

    /**
     * Executa update via API Nuvemshop - Otimizado
     */
    function executeUpdate(itemId, quantity) {
        state.pendingUpdates.delete(itemId);
        
        const item = $(`[data-item-id="${itemId}"]`);
        if (item) item.classList.add('is-loading');

        // Usa API LS da Nuvemshop diretamente - mais rápido
        if (typeof LS !== 'undefined' && LS.changeQuantity) {
            LS.changeQuantity(itemId, quantity, true, function(cart) {
                if (item) item.classList.remove('is-loading');
                if (cart) updateUI(cart);
            });
        }
    }

    /**
     * Remove item - Rápido
     */
    function removeItem(itemId) {
        const item = $(`[data-item-id="${itemId}"]`);
        if (item) {
            item.classList.add('is-removing');
        }

        if (typeof LS !== 'undefined' && LS.removeItem) {
            LS.removeItem(itemId, true, function(cart) {
                if (cart) updateUI(cart);
            });
        }
    }

    /**
     * Aplica cupom de desconto (Nuvemshop integration - v1.5.72)
     */
    function applyCoupon(couponCode) {
        if (!couponCode || couponCode.trim() === '') {
            return;
        }

        const couponBtn = $(CONFIG.selectors.couponBtn);
        const couponInput = $(CONFIG.selectors.couponInput);
        if (!couponBtn) return;

        // Feedback visual: desabilita botão e mostra loading
        couponBtn.disabled = true;
        couponBtn.classList.add('is-loading');
        const originalText = couponBtn.textContent;
        couponBtn.textContent = 'Processando...';

        // Usa API Nuvemshop LS.addCoupon ou POST tradicional
        if (typeof LS !== 'undefined' && LS.addCoupon) {
            // Melhor: usa LS API se disponível (sem reload)
            LS.addCoupon(couponCode, function(cart) {
                couponBtn.disabled = false;
                couponBtn.classList.remove('is-loading');
                couponBtn.textContent = originalText;

                if (cart) {
                    // Sucesso: cupom aplicado
                    if (couponInput) couponInput.value = '';
                    updateUI(cart);
                    showNotification(`Cupom "${couponCode}" aplicado com sucesso!`, 'success');
                } else {
                    // Erro: cupom inválido
                    showNotification('Cupom inválido ou expirado', 'error');
                }
            });
        } else {
            // Fallback: POST direto (será reload, mas funciona)
            // Nuvemshop espera: POST para cart_url com discount_code + apply_discount
            const couponForm = $(CONFIG.selectors.couponForm);
            if (couponForm) {
                // Simula POST sem reload (tenta LS primeiro)
                fetch(couponForm.action, {
                    method: 'POST',
                    body: new FormData(couponForm),
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                .then(response => response.text())
                .then(() => {
                    couponBtn.disabled = false;
                    couponBtn.classList.remove('is-loading');
                    couponBtn.textContent = originalText;
                    if (couponInput) couponInput.value = '';
                    showNotification(`Cupom "${couponCode}" aplicado!`, 'success');
                    // Recarrega carrinho da Nuvemshop
                    if (typeof LS !== 'undefined' && LS.getCart) {
                        LS.getCart(updateUI);
                    }
                })
                .catch(() => {
                    couponBtn.disabled = false;
                    couponBtn.classList.remove('is-loading');
                    couponBtn.textContent = originalText;
                    showNotification('Erro ao aplicar cupom', 'error');
                });
            }
        }
    }

    /**
     * Mostra notificação inline (v1.5.72)
     */
    function showNotification(message, type = 'info') {
        // Cria elemento de notificação simples (pode ser expandido)
        const notification = document.createElement('div');
        notification.className = `pg-drawer__notification pg-drawer__notification--${type}`;
        notification.textContent = message;
        notification.style.cssText = `
            padding: 10px 12px;
            margin: 8px 0;
            border-radius: 4px;
            font-size: 12px;
            background: ${type === 'success' ? '#d4edda' : '#f8d7da'};
            color: ${type === 'success' ? '#155724' : '#721c24'};
            border: 1px solid ${type === 'success' ? '#c3e6cb' : '#f5c6cb'};
        `;

        const couponSection = $(CONFIG.selectors.couponSection);
        if (couponSection) {
            couponSection.appendChild(notification);
            setTimeout(() => notification.remove(), 3000);
        }
    }

    // ============================================
    // UI UPDATES - Simplificado
    // ============================================
    
    function updateUI(cart) {
        if (!cart) return;

        // Totais
        const subtotalEl = $(CONFIG.selectors.subtotal);
        const totalEl = $(CONFIG.selectors.total);
        
        if (subtotalEl) subtotalEl.textContent = formatMoney(cart.subtotal);
        if (totalEl) totalEl.textContent = formatMoney(cart.total);

        // Contador header
        $$(CONFIG.selectors.cartCount).forEach(el => {
            el.textContent = cart.items_count || 0;
        });

        // Checkout button
        const checkoutBtn = $(CONFIG.selectors.checkoutBtn);
        if (checkoutBtn) checkoutBtn.disabled = !cart.checkout_enabled;

        // Minimum alert
        const minAlert = $(CONFIG.selectors.minimumAlert);
        if (minAlert) minAlert.style.display = cart.checkout_enabled ? 'none' : 'block';

        // Empty state
        const isEmpty = !cart.items || cart.items.length === 0;
        const itemsList = $(CONFIG.selectors.itemsList);
        const emptyState = $(CONFIG.selectors.emptyState);
        const footer = $(CONFIG.selectors.footer);

        if (itemsList) itemsList.style.display = isEmpty ? 'none' : 'flex';
        if (emptyState) emptyState.style.display = isEmpty ? 'flex' : 'none';
        if (footer) footer.style.display = isEmpty ? 'none' : 'block';

        // Atualiza preços dos itens
        if (cart.items) {
            cart.items.forEach(item => {
                const priceEl = $(`${CONFIG.selectors.itemSubtotal}[data-item-id="${item.id}"]`);
                if (priceEl) priceEl.textContent = formatMoney(item.subtotal);
                
                const qtyInput = $(`${CONFIG.selectors.qtyInput}[data-item-id="${item.id}"]`);
                if (qtyInput) {
                    qtyInput.value = item.quantity;
                    qtyInput.dataset.original = item.quantity;
                }
            });
        }
    }

    // ============================================
    // EVENT HANDLERS - Simplificado
    // ============================================
    
    function handleMinus(itemId, input) {
        let qty = parseInt(input.value) || 1;
        if (qty > 1) {
            updateQuantity(itemId, qty - 1);
        } else {
            removeItem(itemId);
        }
    }

    function handlePlus(itemId, input) {
        let qty = parseInt(input.value) || 1;
        updateQuantity(itemId, qty + 1);
    }

    // ============================================
    // INICIALIZAÇÃO
    // ============================================
    
    function bindEvents() {
        // Click delegation - mais eficiente
        document.addEventListener('click', (e) => {
            // Fechar
            if (e.target.closest(CONFIG.selectors.closeBtn)) {
                e.preventDefault();
                closeDrawer();
                return;
            }

            // Abrir - PATAGANG: usa classe específica para evitar conflito com JS nativo
            if (e.target.closest('[data-toggle="cart-drawer"], .js-pg-cart-open')) {
                e.preventDefault();
                openDrawer();
                return;
            }

            // Minus
            const minus = e.target.closest(CONFIG.selectors.qtyMinus);
            if (minus) {
                e.preventDefault();
                const itemId = minus.dataset.itemId;
                const input = $(`${CONFIG.selectors.qtyInput}[data-item-id="${itemId}"]`);
                if (input) handleMinus(itemId, input);
                return;
            }

            // Plus
            const plus = e.target.closest(CONFIG.selectors.qtyPlus);
            if (plus) {
                e.preventDefault();
                const itemId = plus.dataset.itemId;
                const input = $(`${CONFIG.selectors.qtyInput}[data-item-id="${itemId}"]`);
                if (input) handlePlus(itemId, input);
                return;
            }

            // Remove
            const remove = e.target.closest(CONFIG.selectors.removeBtn);
            if (remove) {
                e.preventDefault();
                removeItem(remove.dataset.itemId);
                return;
            }

            // Aplicar Cupom (v1.5.72 - Nuvemshop integration)
            const couponBtn = e.target.closest(CONFIG.selectors.couponBtn);
            if (couponBtn) {
                e.preventDefault();
                const couponInput = $(CONFIG.selectors.couponInput);
                if (couponInput) {
                    applyCoupon(couponInput.value);
                }
                return;
            }
        });

        // Form submit do cupom (Enter key + form submit tradicional)
        const couponForm = $(CONFIG.selectors.couponForm);
        if (couponForm) {
            couponForm.addEventListener('submit', (e) => {
                e.preventDefault();
                const couponInput = $(CONFIG.selectors.couponInput);
                if (couponInput) {
                    applyCoupon(couponInput.value);
                }
            });
        }

        // ESC fecha
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && state.isOpen) closeDrawer();
        });
    }

    function init() {
        const currencyEl = $('.js-pg-cart-currency');
        if (currencyEl) state.currency = currencyEl.dataset.currency || 'R$';

        bindEvents();
        console.log('[PG Cart Drawer] Inicializado v1.5.72 com suporte a cupom GANGDAPATA');
        console.log('[PG Cart Drawer] Cupom: input.pg-drawer__coupon-input → btn.pg-drawer__coupon-btn');

        // Verifica disponibilidade da API Nuvemshop
        if (typeof LS !== 'undefined') {
            console.log('[PG Cart Drawer] LS API disponível - cupom usará LS.addCoupon()');
        } else {
            console.log('[PG Cart Drawer] LS API não disponível - cupom usará fallback (POST)');
        }
    }

    // IMPORTANTE: Expõe API global IMEDIATAMENTE para garantir disponibilidade
    window.PGCartDrawer = {
        open: openDrawer,
        close: closeDrawer,
        toggle: () => state.isOpen ? closeDrawer() : openDrawer()
    };

    // Inicializa eventos quando DOM estiver pronto
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

})();
} catch(e) { console.warn('[PG Cart Drawer] Erro na inicialização:', e); }
