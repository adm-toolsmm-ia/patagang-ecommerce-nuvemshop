{#/*============================================================================
  Patagang Store — Cart Functions Module (Story 8.5 Priority 2 Phase 2)
  Extracted from store.js.tpl (linhas 1811-2316)

  Responsabilidades:
  - Toggle cart drawer
  - Add to cart
  - Cart quantity changes
  - Remove from cart
  - Empty cart alerts
  - Go to checkout

  Padrão: IIFE com typeof checks + namespace PatagangStore
  Auto-init: DOMContentLoaded
==============================================================================*/#}

(function() {
  'use strict';

  {# Verificar dependências #}
  if (typeof jQueryNuvem === 'undefined' || typeof LS === 'undefined') {
    console.warn('[PatagangStore.cartFunctions] Dependências não disponíveis');
    return;
  }

	  #Cart
	==============================================================================*/ #}

    {# /* // Free shipping bar */ #}

    {% if cart.free_shipping.min_price_free_shipping.min_price %}

        {# Updates free progress on page load #}

        LS.freeShippingProgress(true);

    {% endif %}

    {# /* // Position of cart page summary */ #}

    var head_height = jQueryNuvem(".js-head-main").outerHeight();

    if (window.innerWidth > 768) {
        {% if settings.head_fix %}
            jQueryNuvem("#cart-sticky-summary").css("top" , (head_height + 10).toString() + 'px');
        {% else %}
            jQueryNuvem("#cart-sticky-summary").css("top" , "10px");
        {% endif %}
    }

    {# /* // Add to cart */ #}

    {# PATAGANG v1.5.81 FIX: Handler UNIVERSAL que funciona INDEPENDENTEMENTE de settings.ajax_cart #}
    {# Intercepta Add to Cart ANTES do bloco {% if settings.ajax_cart %} e abre drawer em QUALQUER caso #}
    jQueryNuvem(document).on("click", ".js-addtocart:not(.js-addtocart-placeholder)", function (e) {
        var $btn = jQueryNuvem(this);
        var $form = $btn.closest('form.js-product-form');

        if (!$form.length) return; {# Não é um formulário válido #}

        {# Se drawer está disponível, SEMPRE abre (independentemente de settings.ajax_cart) #}
        if (typeof window.PGCartDrawer !== 'undefined' && window.PGCartDrawer.open) {
            {# Aguarda um pouco para o produto ser adicionado à sessão antes de abrir drawer #}
            setTimeout(function() {
                window.PGCartDrawer.open();
            }, 100);
        }
    });

	jQueryNuvem(document).on("click", ".js-addtocart:not(.js-addtocart-placeholder)", function (e) {

        {# PATAGANG: Validação - Bloqueia produtos em desenvolvimento #}
        var $form = jQueryNuvem(this).closest('form.js-product-form');
        if ($form.length) {
            var productId = $form.find('input[name="add_to_cart"]').val();
            var $productContainer = jQueryNuvem(this).closest('.js-product-container, .js-item-product');

            // Verifica se é produto em desenvolvimento pela presença do card especial
            var isDevProduct = $productContainer.find('.pg-dev-card').length > 0 ||
                               jQueryNuvem(this).closest('.js-item-product').find('.btn-development').length > 0 ||
                               $form.closest('.js-product-container').find('.pg-dev-card').length > 0;

            if (isDevProduct) {
                e.preventDefault();
                e.stopPropagation();
                console.log('[Store] Produto em desenvolvimento - adição ao carrinho bloqueada');
                // Produtos em desenvolvimento não devem ser adicionados ao carrinho
                return false;
            }
        }

        {# Button variables for transitions on add to cart #}

        var $productContainer = jQueryNuvem(this).closest('.js-product-container');
        var $productVariants = $productContainer.find(".js-variation-option");
        var $productButton = $productContainer.find("input[type='submit'].js-addtocart");
        var $productButtonPlaceholder = $productContainer.find(".js-addtocart-placeholder");
        var $productButtonText = $productButtonPlaceholder.find(".js-addtocart-text");
        var $productButtonAdding = $productButtonPlaceholder.find(".js-addtocart-adding");
        var $productButtonSuccess = $productButtonPlaceholder.find(".js-addtocart-success");

        {# Define if event comes from quickshop, product page or cross selling #}

        var isQuickShop = $productContainer.hasClass('js-quickshop-container');
        var isCrossSelling = $productContainer.hasClass('js-cross-selling-container');

        {# Add item information for notification #}

        if (isCrossSelling) {
            var imageSrc = $productContainer.find('.js-cross-selling-product-image').attr('src');
            var quantity = $productContainer.data('quantity')
            var name = $productContainer.find('.js-cross-selling-product-name').text();
            var price = $productContainer.find('.js-cross-selling-promo-price').text();
            var addedToCartCopy = $productContainer.data('add-to-cart-translation');
        } else if (!isQuickShop) {
            if(jQueryNuvem(".js-product-slide-img.js-active-variant").length) {
                var $activeVariantImg = $productContainer.find('.js-product-slide-img.js-active-variant');
                var imageSrc = $activeVariantImg.attr('srcset') || $activeVariantImg.data('srcset');
            } else {
                var $defaultImg = $productContainer.find('.js-product-slide-img');
                var imageSrc = $defaultImg.attr('srcset') || $defaultImg.data('srcset');
            }

            imageSrc = imageSrc ? imageSrc.split(' ')[0] : '';
            var name = $productContainer.find('.js-product-name').text();
            var price = $productContainer.find('.js-price-display').text();
        } else {
            var imageSrc = jQueryNuvem(this).closest('.js-quickshop-container').find('img').attr('srcset');
            var name = $productContainer.find('.js-item-name').text();
            var price = $productContainer.find('.js-price-display').text().trim();
        }

        var quantity = $productContainer.find('.js-quantity-input').val();
        var addedToCartCopy = "{{ 'Agregar al carrito' | translate }}";


        if (!jQueryNuvem(this).hasClass('contact')) {

            {# Hide real button and show button placeholder during event #}

            $productButton.hide();
            $productButtonPlaceholder.show().addClass("active");
            $productButtonText.removeClass("active");
            setTimeout(function(){
                $productButtonAdding.addClass("active");
            },300);

            {# Restore button state in case of error #}

            function restore_button_initial_state(){
                $productButtonPlaceholder.removeClass("active");
                $productButtonText.fadeIn();
                $productButtonAdding.removeClass("active");
                $productButtonPlaceholder.hide();
                $productButton.css('display' , 'inline-block');
            }

            {# Restore button state for subscriptions stock error #}

            var subscription_callback_error = function() {
                setTimeout(function() {
                    restore_button_initial_state();
                }, 500);
            }

            {# Handle subscribable product submit #}

            const subscriptionValidResult = LS.subscriptionSubmit($productContainer, subscription_callback_error, e);
            if (subscriptionValidResult && subscriptionValidResult.changeCartSubmit) {
                return;
            }

            {% if settings.ajax_cart %}

                e.preventDefault();

                var callback_add_to_cart = function(html_notification_related_products, html_notification_cross_selling) {

                    {# Animate cart amount #}
                    {# LS.addToCartEnhanced já atualiza o contador automaticamente via AJAX #}
                    {# Apenas animamos o contador existente #}

                    jQueryNuvem(".js-cart-widget-amount, .js-pg-cart-count").addClass("beat");

                    setTimeout(function(){
                        jQueryNuvem(".js-cart-widget-amount, .js-pg-cart-count").removeClass("beat");
                    },4000);

                    {# PATAGANG: Atualiza parcelamento após adicionar produto #}
                    console.log('[ADD TO CART] Produto adicionado, atualizando parcelamento...');
                    setTimeout(function() {
                        if (typeof LS !== 'undefined' && LS.data && LS.data.cart) {
                            var cart = LS.data.cart;
                            var total = cart.total;
                            console.log('[ADD TO CART] Total do carrinho:', total);

                            {# Atualiza parcelamento via métodos nativos da Nuvemshop apenas #}
                            if (typeof LS.updateInstallments === 'function') {
                                LS.updateInstallments(total);
                                console.log('[ADD TO CART] ✓ Parcelamento atualizado via LS.updateInstallments');
                            } else if (typeof LS.refreshInstallments === 'function') {
                                LS.refreshInstallments();
                                console.log('[ADD TO CART] ✓ Parcelamento atualizado via LS.refreshInstallments');
                            }
                        }
                    }, 300);

                    {# Fill notification info #}

                    jQueryNuvem('.js-cart-notification-item-img').attr('srcset', imageSrc);
                    jQueryNuvem('.js-cart-notification-item-name').text(name);
                    jQueryNuvem('.js-cart-notification-item-quantity').text(quantity);
                    jQueryNuvem('.js-cart-notification-item-price').text(price);

                    if($productVariants.length){
                        var output = [];

                        $productVariants.each( function(el){
                            var variants = jQueryNuvem(el);
                            output.push(variants.val());
                        });
                        jQueryNuvem(".js-cart-notification-item-variant-container").show();
                        jQueryNuvem(".js-cart-notification-item-variant").text(output.join(', '))
                    }else{
                        jQueryNuvem(".js-cart-notification-item-variant-container").hide();
                    }

                    {# Set products amount wording visibility #}

                    var cartItemsAmount = jQueryNuvem(".js-cart-widget-amount").text();

                    if(cartItemsAmount > 1){
                        jQueryNuvem(".js-cart-counts-plural").show();
                        jQueryNuvem(".js-cart-counts-singular").hide();
                    }else{
                        jQueryNuvem(".js-cart-counts-singular").show();
                        jQueryNuvem(".js-cart-counts-plural").hide();
                    }

                    {# Show button placeholder with transitions #}

                    $productButtonAdding.removeClass("active");

                    setTimeout(function(){
                        $productButtonSuccess.addClass("active");
                    },300);
                    setTimeout(function(){
                        $productButtonSuccess.removeClass("active");
                        setTimeout(function(){
                            $productButtonText.addClass("active");
                        },300);
                        $productButtonPlaceholder.removeClass("active");
                    },2000);

                    setTimeout(function(){
                        $productButtonPlaceholder.hide();
                        $productButton.css('display' , 'inline-block');
                    },4000);

                    $productContainer.find(".js-added-to-cart-product-message").slideDown();

                    if (isQuickShop) {
                        jQueryNuvem("#quickshop-modal").removeClass('modal-show');
                        jQueryNuvem(".js-modal-overlay[data-modal-id='#quickshop-modal']").hide();
                        jQueryNuvem("body").removeClass("overflow-none");
                        restoreQuickshopForm();
                        if (window.innerWidth < 768) {
                            cleanURLHash();
                        }
                    }

                    let notificationWithRelatedProducts = false;

                    {% if settings.add_to_cart_recommendations %}

                        {# Show added to cart product related products #}

                        function recommendProductsOnAddToCart(){

                            jQueryNuvem('.js-related-products-notification-container').html("");

                            modalOpen('#related-products-notification');

                            jQueryNuvem('.js-related-products-notification-container').html(html_notification_related_products).show();

                            {# Recommendations swiper #}

                            // Set loop for recommended products

                            function calculateRelatedNotificationLoopVal(sectionSelector) {
                                let productsAmount = jQueryNuvem(sectionSelector).attr("data-related-amount");
                                let loopVal = false;
                                const applyLoop = (window.innerWidth < 768 && productsAmount > 2) || (window.innerWidth > 768 && productsAmount > 3);

                                if (applyLoop) {
                                    loopVal = true;
                                }

                                return loopVal;
                            }

                            let cartRelatedLoopVal = calculateRelatedNotificationLoopVal(".js-related-products-notification");

                            // Create new swiper on add to cart

                            createSwiper('.js-swiper-related-products-notification', {
                                lazy: true,
                                loop: cartRelatedLoopVal,
                                watchOverflow: true,
                                threshold: 5,
                                watchSlideProgress: true,
                                watchSlidesVisibility: true,
                                spaceBetween: 15,
                                slideVisibleClass: 'js-swiper-slide-visible',
                                slidesPerView: 2,
                                pagination: {
                                    el: '.js-swiper-related-products-notification-pagination',
                                    clickable: true,
                                },
                                navigation: {
                                    nextEl: '.js-swiper-related-products-notification-next',
                                    prevEl: '.js-swiper-related-products-notification-prev',
                                },
                                breakpoints: {
                                    768: {
                                        slidesPerView: 3,
                                    }
                                }
                            });
                        }

                        notificationWithRelatedProducts = html_notification_related_products != null;

                        if(notificationWithRelatedProducts){
                            if (isQuickShop) {
                                setTimeout(function(){
                                    recommendProductsOnAddToCart();
                                },300);
                            }else{
                                recommendProductsOnAddToCart();
                            }
                        }

                    {% endif %}

                    let shouldShowCrossSellingModal = html_notification_cross_selling != null;

                    {# PATAGANG: Lógica corrigida - sempre verifica cart_open_type #}
                    {# A sacola deve abrir se cart_open_type = show_cart, mesmo com related products #}

                    // Lê configuração do modal (data-cart-open-type)
                    // Tenta múltiplas formas de ler para garantir que funciona
                    let cartOpenType = null;

                    // Tentativa 1: Via jQuery no elemento
                    const modalCartEl = document.getElementById('modal-cart');
                    if (modalCartEl) {
                        cartOpenType = modalCartEl.getAttribute('data-cart-open-type') ||
                                      jQueryNuvem(modalCartEl).attr('data-cart-open-type') ||
                                      jQueryNuvem("#modal-cart").attr('data-cart-open-type');
                    }

                    // Tentativa 2: Via jQuery direto (caso elemento não esteja no DOM ainda)
                    if (!cartOpenType) {
                        cartOpenType = jQueryNuvem("#modal-cart").attr('data-cart-open-type');
                    }

                    // Tentativa 3: Fallback para settings (se não encontrou no DOM)
                    if (!cartOpenType) {
                        cartOpenType = '{{ settings.cart_open_type | default("show_cart") }}';
                        console.warn('[Store] cart_open_type não encontrado no DOM, usando settings:', cartOpenType);
                    }

                    // Se configurado para abrir carrinho E não há cross-selling bloqueando
                    if((cartOpenType === 'show_cart') && !shouldShowCrossSellingModal){

                        {# Open cart on add to cart - NEW CART DRAWER (v1.5.79 Story 8.5) #}

                        if (isQuickShop) {
                            setTimeout(function(){
                                if (typeof window.PGCartDrawer !== 'undefined' && window.PGCartDrawer.open) {
                                    window.PGCartDrawer.open();
                                }
                            }, 500);
                        } else {
                            setTimeout(function(){
                                if (typeof window.PGCartDrawer !== 'undefined' && window.PGCartDrawer.open) {
                                    window.PGCartDrawer.open();
                                }
                            }, 300);
                        }

                    } else {
                        {# Show notification only (cart_open_type = show_notification ou cross-selling bloqueando) #}

                        if(!notificationWithRelatedProducts){
                            setTimeout(function(){
                                jQueryNuvem(".js-alert-added-to-cart").show().addClass("notification-visible").removeClass("notification-hidden");
                            },500);

                            if (!cookieService.get('first_product_added_successfully')) {
                                cookieService.set('first_product_added_successfully', 1, 7 );
                            } else{
                                setTimeout(function(){
                                    jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
                                    setTimeout(function(){
                                        jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
                                        jQueryNuvem(".js-alert-added-to-cart").hide();
                                    },2000);
                                },8000);
                            }
                        }
                    }

                    {# Display cross-selling promotion modal #}

                    if (shouldShowCrossSellingModal) {
                        jQueryNuvem('.js-cross-selling-modal-body').html("");
                        modalOpen('#js-cross-selling-modal');
                        jQueryNuvem('.js-cross-selling-modal-body').html(html_notification_cross_selling).show();
                    }

                    {# Change prices on cross-selling promotion modal #}

                    const crossSellingContainer = document.querySelector('.js-cross-selling-container');

                    if (crossSellingContainer) {
                        LS.fillCrossSelling(crossSellingContainer);
                    }

                    {# Update shipping input zipcode on add to cart #}

                    {# Use zipcode from input if user is in product page, or use zipcode cookie if is not #}

                    if (jQueryNuvem("#product-shipping-container .js-shipping-input").val()) {
                        zipcode_on_addtocart = jQueryNuvem("#product-shipping-container .js-shipping-input").val();
                        jQueryNuvem("#cart-shipping-container .js-shipping-input").val(zipcode_on_addtocart);
                        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_on_addtocart);
                    } else if (cookieService.get('calculator_zipcode')){
                        var zipcode_from_cookie = cookieService.get('calculator_zipcode');
                        jQueryNuvem('.js-shipping-input').val(zipcode_from_cookie);
                        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);
                    }

                    {# Automatically close the cross-selling modal by triggering its close button #}

                    if (isCrossSelling) {
                        jQueryNuvem('#js-cross-selling-modal .js-modal-close').trigger('click');
                    }
                }
                var callback_error = function(){
                    {# Restore real button visibility in case of error #}
                    restore_button_initial_state();
                }
                $prod_form = jQueryNuvem(this).closest("form");
                LS.addToCartEnhanced(
                    $prod_form,
                    '{{ "Agregar al carrito" | translate }}',
                    '{{ "Agregando..." | translate }}',
                    '{{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito." | translate }}',
                    {{ store.editable_ajax_cart_enabled ? 'true' : 'false' }},
                        callback_add_to_cart,
                        callback_error
                );
            {% endif %}
        }
    });


    {# /* // Função auxiliar para atualizar totais do carrinho */ #}
    function updateCartTotal() {
        if (typeof LS !== 'undefined' && LS.cart) {
            LS.cart.then(function(cart) {
                console.log('[CART] Atualizando totais', cart);

                // Atualiza subtotal
                if (cart.subtotal) {
                    jQueryNuvem('.js-ajax-cart-total, .js-cart-subtotal, .js-pg-cart-subtotal').text(LS.currency.display_short + ' ' + LS.formatToCurrency(cart.subtotal));
                }

                // Atualiza total
                    if (cart.total) {
                    jQueryNuvem('.js-cart-total, .js-pg-cart-total').text(LS.currency.display_short + ' ' + LS.formatToCurrency(cart.total));
                }

                // Atualiza contador de itens
                if (typeof cart.item_count !== 'undefined') {
                    jQueryNuvem('.js-cart-widget-amount').text(cart.item_count);
                }

                // Atualiza preços individuais dos itens
                if (cart.items) {
                    cart.items.forEach(function(item) {
                        var $itemTotal = jQueryNuvem('.js-cart-item[data-item-id="' + item.id + '"] .js-cart-item-total, .js-pg-cart-item[data-item-id="' + item.id + '"] .js-pg-item-total');
                        if ($itemTotal.length && item.subtotal) {
                            $itemTotal.text(LS.currency.display_short + ' ' + LS.formatToCurrency(item.subtotal));
                        }
                    });
                }
            });
        }
    }


    {# /* // Cart quantity changes - DESATIVADO
       ===============================================
       PATAGANG: Handlers customizados REMOVIDOS.
       Agora usamos os métodos nativos da Nuvemshop:
       - LS.plusQuantity(itemId, true)
       - LS.minusQuantity(itemId, true)

       Esses métodos são chamados diretamente via onclick
       nos templates cart-item-new.tpl e cart-item-ajax.tpl,
       garantindo sincronização correta com o backend.
       =============================================== */ #}

    {# Botão remover (lixeira) #}
    jQueryNuvem(document).on("click", ".js-cart-item-remove", function (e) {
        e.preventDefault();
        var $button = jQueryNuvem(this);
        var itemId = $button.attr("data-item-id");
        var r = confirm("{{ '¿Seguro que quieres borrar este artículo?' | translate }}");
        if (r == true) {
            LS.removeItem(itemId, true);
        }
    });

    {# /* // Empty cart alert */ #}

    jQueryNuvem(".js-trigger-empty-cart-alert").on("click", function (e) {
        e.preventDefault();
        let emptyCartAlert = jQueryNuvem(".js-mobile-nav-empty-cart-alert").fadeIn(100);
        setTimeout(() => emptyCartAlert.fadeOut(500), 1500);
    });

    {# /* // Go to checkout */ #}

    {# Clear cart notification cookie after consumers continues to checkout #}

    jQueryNuvem('form[action="{{ store.cart_url | escape('js') }}"]').on("submit", function() {
        cookieService.remove('first_product_added_successfully');
    });

    {# /* // ONG Selector - PATAGANG */ #}

    {# Handler para seleção de ONG (dropdown) #}
    jQueryNuvem(document).on("change", ".js-ong-input", function() {
        var selectedOng = jQueryNuvem(this).val();
        {# Atualiza hidden input #}
        jQueryNuvem('#selected-ong-value').val(selectedOng);
    });


  {# Função principal: Inicializar cart functions #}
  const initCartFunctions = function() {
    console.log('[PatagangStore.cartFunctions] ✓ Inicialisado');
  };

  {# Expor interface pública #}
  window.PatagangStore = window.PatagangStore || {};
  window.PatagangStore.cartFunctions = {
    init: initCartFunctions,
    {# Public API exports for backward compatibility #}
    renderCartTotal: typeof renderCartTotal !== 'undefined' ? renderCartTotal : null,
    toggleCart: typeof toggleCart !== 'undefined' ? toggleCart : null
  };

  {# Auto-inicializar quando DOM estiver pronto #}
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCartFunctions);
  } else {
    initCartFunctions();
  }
})();
