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
            itemSubtotal: '.js-pg-item-subtotal'
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
        });

        // ESC fecha
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && state.isOpen) closeDrawer();
        });
    }

    function init() {
        const currencyEl = $('.js-pg-cart-currency');
        if (currencyEl) state.currency = currencyEl.dataset.currency || 'R$';

        bindEvents();
        console.log('[PG Cart Drawer] Inicializado');
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
