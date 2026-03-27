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
        debounceDelay: 50,         // Reduzido para 50ms - resposta quase instantânea
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

    /**
     * Recarrega conteúdo do carrinho via AJAX e API LS
     */
    function reloadCartContent(callback) {
        const loadingEl = $('.js-pg-cart-loading');
        const itemsList = $(CONFIG.selectors.itemsList);

        if (loadingEl) loadingEl.style.display = 'flex';

        // Primeiro tenta recarregar HTML completo do carrinho
        if (typeof jQueryNuvem !== 'undefined' && jQueryNuvem.get) {
            jQueryNuvem.get('{{ store.cart_url | escape("js") }}', function(html) {
                if (html) {
                    const tempDiv = document.createElement('div');
                    tempDiv.innerHTML = html;

                    // Extrai itens do carrinho - busca tanto cart-item-ajax quanto cart-item-new
                    const cartItemsContainer = tempDiv.querySelector('.js-ajax-cart-list, .cart-row');
                    if (cartItemsContainer && itemsList) {
                        itemsList.innerHTML = '';

                        // Busca itens em ambos os formatos (ajax e new)
                        const cartItems = cartItemsContainer.querySelectorAll('.js-cart-item, .js-pg-cart-item, [data-component="cart.line-item"], .pg-cart-card');

                        if (cartItems.length > 0) {
                            cartItems.forEach(item => {
                                const cloned = item.cloneNode(true);
                                itemsList.appendChild(cloned);
                            });

                            const emptyState = $(CONFIG.selectors.emptyState);
                            const footer = $(CONFIG.selectors.footer);
                            if (emptyState) emptyState.style.display = 'none';
                            if (footer) footer.style.display = 'block';
                            if (itemsList) itemsList.style.display = 'flex';
                        } else {
                            // Carrinho vazio
                            const emptyState = $(CONFIG.selectors.emptyState);
                            const footer = $(CONFIG.selectors.footer);
                            if (emptyState) emptyState.style.display = 'flex';
                            if (footer) footer.style.display = 'none';
                            if (itemsList) itemsList.style.display = 'none';
                        }
                    } else {
                        // Se não encontrou container, tenta usar API LS para obter dados
                        if (typeof LS !== 'undefined' && LS.getCart) {
                            LS.getCart(function(cart) {
                                if (cart && cart.items && cart.items.length > 0) {
                                    // Renderiza itens manualmente usando dados do LS
                                    renderCartItems(cart.items);
                                }
                                if (callback) callback();
                            });
                            return;
                        }
                    }

                    // Extrai totais do HTML
                    const cartSubtotalEl = tempDiv.querySelector('.js-cart-subtotal, [data-component="cart.subtotal"]');
                    const cartTotalEl = tempDiv.querySelector('.js-cart-total, [data-component="cart.total"]');
                    const cartCountEl = tempDiv.querySelector('.js-cart-widget-amount');

                    if (cartSubtotalEl) {
                        const subtotalEl = $(CONFIG.selectors.subtotal);
                        if (subtotalEl) subtotalEl.textContent = cartSubtotalEl.textContent.trim();
                    }

                    if (cartTotalEl) {
                        const totalEl = $(CONFIG.selectors.total);
                        if (totalEl) totalEl.textContent = cartTotalEl.textContent.trim();
                    }

                    if (cartCountEl) {
                        const count = parseInt(cartCountEl.textContent) || 0;
                        $$(CONFIG.selectors.cartCount).forEach(el => {
                            el.textContent = count;
                        });
                    }
                }

                if (loadingEl) loadingEl.style.display = 'none';
                if (callback) callback();
            }).fail(function() {
                console.warn('[Cart Drawer] Erro ao recarregar carrinho via AJAX, tentando API LS');
                // Fallback: usa API LS
                reloadCartViaLS(callback);
            });
        } else {
            // Fallback: usa API LS
            reloadCartViaLS(callback);
        }
    }

    /**
     * Recarrega carrinho usando API LS da Nuvemshop
     */
    function reloadCartViaLS(callback) {
        const loadingEl = $('.js-pg-cart-loading');
        const itemsList = $(CONFIG.selectors.itemsList);

        if (typeof LS !== 'undefined' && LS.getCart) {
            LS.getCart(function(cart) {
                if (cart) {
                    // Atualiza UI completa
                    updateUI(cart);

                    // Renderiza itens se disponíveis
                    if (cart.items && cart.items.length > 0) {
                        renderCartItems(cart.items);
                    } else {
                        // Carrinho vazio
                        const emptyState = $(CONFIG.selectors.emptyState);
                        const footer = $(CONFIG.selectors.footer);
                        if (emptyState) emptyState.style.display = 'flex';
                        if (footer) footer.style.display = 'none';
                        if (itemsList) itemsList.style.display = 'none';
                    }
                }

                if (loadingEl) loadingEl.style.display = 'none';
                if (callback) callback();
            });
        } else {
            console.warn('[Cart Drawer] LS.getCart não disponível');
            if (loadingEl) loadingEl.style.display = 'none';
            if (callback) callback();
        }
    }


    function openDrawer(reloadBeforeOpen = false) {
        console.log('[PG Cart Drawer] openDrawer chamado, reloadBeforeOpen:', reloadBeforeOpen);

        const drawer = $(CONFIG.selectors.drawer);
        if (!drawer) {
            console.error('[PG Cart Drawer] ERRO CRÍTICO: Drawer (#pg-cart-drawer) não encontrado no DOM!');
            return;
        }

        function doOpen() {
            console.log('[PG Cart Drawer] Executando doOpen - abrindo drawer');
            drawer.style.display = 'block';
            document.body.style.overflow = 'hidden';
            requestAnimationFrame(() => {
                drawer.classList.add('is-open');
            });
            state.isOpen = true;
            console.log('[PG Cart Drawer] Drawer aberto com sucesso');
        }

        if (reloadBeforeOpen) {
            console.log('[PG Cart Drawer] Recarregando conteúdo do carrinho antes de abrir...');
            // Mostra loading enquanto recarrega
            const loadingEl = $('.js-pg-cart-loading');
            if (loadingEl) loadingEl.style.display = 'flex';

            reloadCartContent(function() {
                console.log('[PG Cart Drawer] Conteúdo recarregado, abrindo drawer');
                // Aguarda um pouco para garantir que HTML foi atualizado
                setTimeout(function() {
                    if (loadingEl) loadingEl.style.display = 'none';
                    doOpen();
                }, 200);
            });
        } else {
            console.log('[PG Cart Drawer] Abrindo drawer sem reload');
            doOpen();
        }
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
    // RENDERIZAÇÃO DE ITENS
    // ============================================

    /**
     * Renderiza itens do carrinho usando dados do LS
     */
    function renderCartItems(items) {
        const itemsList = $(CONFIG.selectors.itemsList);
        if (!itemsList) return;

        itemsList.innerHTML = '';

        items.forEach(function(item) {
            const itemCard = createCartItemCard(item);
            itemsList.appendChild(itemCard);
        });

        const emptyState = $(CONFIG.selectors.emptyState);
        const footer = $(CONFIG.selectors.footer);
        if (emptyState) emptyState.style.display = 'none';
        if (footer) footer.style.display = 'block';
        if (itemsList) itemsList.style.display = 'flex';
    }

    /**
     * Cria card de item do carrinho a partir dos dados
     */
    function createCartItemCard(item) {
        const card = document.createElement('div');
        card.className = 'pg-cart-card js-pg-cart-item';
        card.setAttribute('data-item-id', item.id);

        const productId = item.product_id || (item.product ? item.product.id : '');
        const variantId = item.variant_id || (item.variant ? item.variant.id : '');
        if (productId) card.setAttribute('data-product-id', productId);
        if (variantId) card.setAttribute('data-variant-id', variantId);

        // Formata subtotal
        let subtotalFormatted = '';
        if (item.subtotal) {
            if (typeof item.subtotal === 'number') {
                subtotalFormatted = formatMoney(item.subtotal);
            } else {
                subtotalFormatted = item.subtotal;
            }
        }

        // Obtém imagem
        const imageUrl = item.featured_image || item.image || (item.product ? item.product.featured_image : '') || '';
        const itemName = item.short_name || item.name || '';
        const itemUrl = item.url || '#';

        card.innerHTML = `
            <div class="pg-cart-card__loading js-pg-item-loading" style="display: none;">
                <div class="pg-cart-card__spinner"></div>
            </div>
            <div class="pg-cart-card__image">
                <a href="${itemUrl}" class="js-pg-drawer-close">
                    <img src="${imageUrl}" alt="${itemName}" loading="lazy" />
                </a>
            </div>
            <div class="pg-cart-card__info">
                <h4 class="pg-cart-card__name">
                    <a href="${itemUrl}" class="js-pg-drawer-close">${itemName}</a>
                </h4>
                ${item.short_variant_name ? `<span class="pg-cart-card__variant">Tam: ${item.short_variant_name}</span>` : ''}
                <div class="pg-cart-card__qty">
                    <div class="pg-qty-pill">
                        <button type="button" class="pg-qty-pill__btn pg-qty-pill__btn--minus" onclick="LS.minusQuantity(${item.id}, true)" aria-label="Diminuir quantidade">
                            <span>−</span>
                        </button>
                        <input type="text" class="pg-qty-pill__input js-pg-qty-input" value="${item.quantity || 1}" data-item-id="${item.id}" data-original="${item.quantity || 1}" readonly aria-label="Quantidade" />
                        <button type="button" class="pg-qty-pill__btn pg-qty-pill__btn--plus" onclick="LS.plusQuantity(${item.id}, true)" aria-label="Aumentar quantidade">
                            <span>+</span>
                        </button>
                    </div>
                </div>
            </div>
            <div class="pg-cart-card__price">
                <span class="js-pg-item-subtotal" data-item-id="${item.id}">${subtotalFormatted}</span>
            </div>
            <button type="button" class="pg-cart-card__remove js-pg-item-remove" data-item-id="${item.id}" aria-label="Remover">
                <svg class="icon-inline" width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M18 6L6 18" stroke="currentColor" stroke-width="2"/>
                    <path d="M6 6L18 18" stroke="currentColor" stroke-width="2"/>
                </svg>
            </button>
        `;

        return card;
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

        if (subtotalEl && cart.subtotal !== undefined) {
            subtotalEl.textContent = typeof cart.subtotal === 'number' ? formatMoney(cart.subtotal) : cart.subtotal;
        }
        if (totalEl && cart.total !== undefined) {
            totalEl.textContent = typeof cart.total === 'number' ? formatMoney(cart.total) : cart.total;
        }

        // Contador header
        const itemCount = cart.items_count || (cart.items ? cart.items.length : 0);
        $$(CONFIG.selectors.cartCount).forEach(el => {
            el.textContent = itemCount;
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
        if (cart.items && cart.items.length > 0) {
            cart.items.forEach(item => {
                const priceEl = $(`${CONFIG.selectors.itemSubtotal}[data-item-id="${item.id}"]`);
                if (priceEl && item.subtotal !== undefined) {
                    priceEl.textContent = typeof item.subtotal === 'number' ? formatMoney(item.subtotal) : item.subtotal;
                }

                const qtyInput = $(`${CONFIG.selectors.qtyInput}[data-item-id="${item.id}"]`);
                if (qtyInput && item.quantity !== undefined) {
                    qtyInput.value = item.quantity;
                    qtyInput.dataset.original = item.quantity;
                }
            });
        }
    }

    // ============================================
    // INICIALIZAÇÃO
    // ============================================
    // PATAGANG: Handlers handleMinus/handlePlus removidos
    // Agora usamos onclick com LS.minusQuantity/LS.plusQuantity nativo

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
            const cartOpenBtn = e.target.closest('[data-toggle="cart-drawer"], .js-pg-cart-open');
            if (cartOpenBtn) {
                e.preventDefault();

                // Verifica se drawer existe no DOM
                const drawer = $(CONFIG.selectors.drawer);
                if (drawer) {
                    openDrawer(false); // false = não recarregar (já está atualizado)
                } else {
                    // Fallback: tenta abrir modal nativo se drawer não existir
                    const modalCart = document.getElementById('modal-cart');
                    if (modalCart && typeof modalOpen === 'function') {
                        modalOpen('#modal-cart', 'openFullScreenWithoutClick');
                    } else {
                        // Último fallback: redireciona para página do carrinho
                        window.location.href = cartOpenBtn.href || '{{ store.cart_url | escape("js") }}';
                    }
                }
                return;
            }

            // PATAGANG: Handlers de Minus/Plus REMOVIDOS
            // Agora usamos onclick com LS.minusQuantity/LS.plusQuantity
            // diretamente nos templates para sincronização nativa com Nuvemshop

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
    // Isso garante que window.PGCartDrawer exista mesmo antes da inicialização completa
    window.PGCartDrawer = window.PGCartDrawer || {};

    // Atribui métodos que podem ser chamados antes da inicialização
    window.PGCartDrawer.open = function(reloadBeforeOpen = false) {
        // Se já inicializou, usa função real
        if (typeof openDrawer === 'function') {
            return openDrawer(reloadBeforeOpen);
        }
        // Se não, marca para abrir após inicialização
        window.PGCartDrawer._pendingOpen = true;
        window.PGCartDrawer._pendingReload = reloadBeforeOpen;
    };

    window.PGCartDrawer.close = function() {
        if (typeof closeDrawer === 'function') {
            return closeDrawer();
        }
    };

    window.PGCartDrawer.toggle = function() {
        if (typeof openDrawer === 'function' && typeof closeDrawer === 'function') {
            return state.isOpen ? closeDrawer() : openDrawer();
        }
    };

    // Métodos para integração com sistema unificado (atualizados após inicialização)
    window.PGCartDrawer.updateQuantity = function(itemId, quantity) {
        if (typeof updateQuantity === 'function') {
            updateQuantity(itemId, quantity);
        }
    };

    window.PGCartDrawer.removeItem = function(itemId) {
        if (typeof removeItem === 'function') {
            removeItem(itemId);
        }
    };

    window.PGCartDrawer.updateUI = function(cart) {
        if (typeof updateUI === 'function') {
            updateUI(cart);
        }
    };

    // Inicializa eventos quando DOM estiver pronto
    function finalInit() {
        init();

        // Verifica se há abertura pendente
        if (window.PGCartDrawer._pendingOpen) {
            const shouldReload = window.PGCartDrawer._pendingReload || false;
            window.PGCartDrawer._pendingOpen = false;
            window.PGCartDrawer._pendingReload = false;
            setTimeout(() => {
                if (typeof openDrawer === 'function') {
                    openDrawer(shouldReload);
                }
            }, 100);
        }

        // Atualiza métodos com referências reais após inicialização
        window.PGCartDrawer.open = openDrawer;
        window.PGCartDrawer.reloadCart = reloadCartContent;
        window.PGCartDrawer.close = closeDrawer;
        window.PGCartDrawer.toggle = () => state.isOpen ? closeDrawer() : openDrawer();
        window.PGCartDrawer.updateQuantity = updateQuantity;
        window.PGCartDrawer.removeItem = removeItem;
        window.PGCartDrawer.updateUI = updateUI;

        // Função de sincronização com modal nativo
        window.syncCartModal = function() {
            if (typeof LS !== 'undefined' && LS.getCart) {
                LS.getCart(function(cart) {
                    // Atualiza contador do header
                    const countEls = document.querySelectorAll('.js-cart-widget-amount, .js-pg-cart-count');
                    countEls.forEach(el => {
                        if (cart && cart.items_count !== undefined) {
                            el.textContent = cart.items_count;
                        }
                    });
                });
            }
        };
    }

    // Inicialização: já estamos dentro de LS.ready.then(), então DOM está pronto
    // Mas aguardamos um tick para garantir que todos os elementos estão no DOM
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', finalInit);
    } else {
        // DOM já está pronto, mas aguarda um tick para garantir que modal está renderizado
        setTimeout(finalInit, 0);
    }

})();
} catch(e) { console.warn('[PG Cart Drawer] Erro na inicialização:', e); }
