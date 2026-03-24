{#/*============================================================================
  Patagang Store — Shipping Functions Module (Story 8.5 Priority 2 Phase 2)
  Extracted from store.js.tpl (linhas 2318-fim)

  Responsabilidades:
  - Select shipping option
  - Calculate shipping
  - Free shipping bar
  - Toggle branches link
  - Shipping on page load
  - Store country/province change

  Padrão: IIFE com typeof checks + namespace PatagangStore
  Auto-init: DOMContentLoaded
==============================================================================*/#}

(function() {
  'use strict';

  {# Verificar dependências #}
  if (typeof jQueryNuvem === 'undefined' || typeof LS === 'undefined') {
    console.warn('[PatagangStore.shippingFunctions] Dependências não disponíveis');
    return;
  }

	  #Shipping calculator
	  ==============================================================================*/ #}

	{# /* // Select and save shipping function */ #}

    selectShippingOption = function(elem, save_option) {
        jQueryNuvem(".js-shipping-method, .js-branch-method").removeClass('js-selected-shipping-method');
        jQueryNuvem(elem).addClass('js-selected-shipping-method');

        if (save_option) {
            LS.saveCalculatedShipping(true);
        }

        if(jQueryNuvem(elem).hasClass("js-shipping-method-hidden")){

            {# Toggle other options visibility depending if they are pickup or delivery for cart and product at the same time #}

            if(jQueryNuvem(elem).hasClass("js-pickup-option")){
                jQueryNuvem(".js-other-pickup-options, .js-show-other-pickup-options .js-shipping-see-less").show();
                jQueryNuvem(".js-show-other-pickup-options .js-shipping-see-more").hide();

            }else{
                jQueryNuvem(".js-other-shipping-options, .js-show-more-shipping-options .js-shipping-see-less").show();
                jQueryNuvem(".js-show-more-shipping-options .js-shipping-see-more").hide()
            }
        }
    };

    {# Apply zipcode saved by cookie if there is no zipcode saved on cart from backend #}

    if (cookieService.get('calculator_zipcode')) {

        {# If there is a cookie saved based on previous calcualtion, add it to the shipping input to triggert automatic calculation #}

        var zipcode_from_cookie = cookieService.get('calculator_zipcode');

        {% if settings.ajax_cart %}

            {# If ajax cart is active, target only product input to avoid extra calulation on empty cart #}

            jQueryNuvem('#product-shipping-container .js-shipping-input').val(zipcode_from_cookie);

        {% else %}

            {# If ajax cart is inactive, target the only input present on screen #}

            jQueryNuvem('.js-shipping-input').val(zipcode_from_cookie);

        {% endif %}

        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);

        {# Hide the shipping calculator and show spinner  #}

        jQueryNuvem(".js-shipping-calculator-head").addClass("with-zip").removeClass("with-form");
        jQueryNuvem(".js-shipping-calculator-with-zipcode").addClass("transition-up-active");
        jQueryNuvem(".js-shipping-calculator-spinner").show();
    } else {

        {# If there is no cookie saved, show calcualtor #}

        jQueryNuvem(".js-shipping-calculator-form").addClass("transition-up-active");
    }

    {# Remove shipping suboptions from DOM to avoid duplicated modals #}

    removeShippingSuboptions = function(){
        var shipping_suboptions_id = jQueryNuvem(".js-modal-shipping-suboptions").attr("id");
        jQueryNuvem("#" + shipping_suboptions_id).remove();
        jQueryNuvem('.js-modal-overlay[data-modal-id="#' + shipping_suboptions_id + '"').remove();
    };

    {# /* // Interceptor para LS.calculateShippingAjax - NÃO dispara auto-select (causava loop) */ #}
    {# O auto-select agora é feito APENAS pelo handler do evento shipping.options.checked da Nuvemshop #}
    if (typeof LS !== 'undefined' && LS.calculateShippingAjax) {
        var originalCalculateShipping = LS.calculateShippingAjax;
        var lastCalculateShippingTime = 0;
        var CALCULATE_SHIPPING_COOLDOWN = 1000; {# 1 segundo entre cálculos #}

        LS.calculateShippingAjax = function(zipcode, url, container) {
            var now = Date.now();

            {# Previne chamadas múltiplas muito próximas #}
            if (now - lastCalculateShippingTime < CALCULATE_SHIPPING_COOLDOWN) {
                console.log('[LS.calculateShippingAjax] Cooldown ativo, ignorando chamada duplicada');
                return false;
            }

            lastCalculateShippingTime = now;
            console.log('[LS.calculateShippingAjax] INTERCEPTADO - Chamando original');

            {# Chama a função original #}
            var result = originalCalculateShipping.apply(this, arguments);
            return result;
        };
        console.log('[SHIPPING INTERCEPT] Interceptor instalado com sucesso');
    } else {
        console.warn('[SHIPPING INTERCEPT] LS.calculateShippingAjax não encontrado no carregamento');
    }

    {# /* // Calculate shipping function */ #}

	jQueryNuvem(".js-calculate-shipping").on("click", function (e) {
        e.preventDefault();

        console.log('[SHIPPING CALC] Clique no botão CALCULAR FRETE');

        {# Detecta contexto: sacola (antiga ou nova) vs produto #}
        var em_sacola = jQueryNuvem(".js-cart-item").length > 0 || jQueryNuvem(".js-pg-cart-item").length > 0;
        var em_produto = jQueryNuvem(".js-product-detail").length > 0;
        var cart_container = jQueryNuvem('#cart-shipping-container').length;
        var product_container = jQueryNuvem('#product-shipping-container').length;

        console.log('[SHIPPING CALC] Contexto: ', {
            em_sacola: em_sacola,
            em_produto: em_produto,
            cart_container: cart_container,
            product_container: product_container
        });

        {# Take the Zip code to all shipping calculators on screen #}
        let shipping_input_val = jQueryNuvem(e.currentTarget).closest(".js-shipping-calculator-form").find(".js-shipping-input").val();

        console.log('[SHIPPING CALC] CEP informado: ' + shipping_input_val);

        if (!shipping_input_val || shipping_input_val.trim() === '') {
            console.error('[SHIPPING CALC] ❌ CEP vazio, cancelando');
            return;
        }

        jQueryNuvem(".js-shipping-input").val(shipping_input_val);
        jQueryNuvem(".js-shipping-calculator-current-zip").html(shipping_input_val);
        removeShippingSuboptions();

        {# Calculate shipping for Cart or Product #}
        if (em_sacola) {
            {# Cart calculator - DETECTA TANTO CARRINHO ANTIGO (.js-cart-item) QUANTO NOVO (.js-pg-cart-item) #}
            console.log('[SHIPPING CALC] Chamando LS.calculateShippingAjax para sacola');

            {# Coleta todos os parâmetros ANTES de chamar #}
            var cep = jQueryNuvem('#cart-shipping-container').find(".js-shipping-input").val();
            var url = '{{store.shipping_calculator_url | escape('js')}}';

            {# CORREÇÃO: #cart-shipping-container JÁ TEM a classe js-shipping-calculator-container #}
            {# Não precisa usar .closest(), basta usar o próprio elemento #}
            var $container = jQueryNuvem("#cart-shipping-container");

            console.log('[SHIPPING CALC] Parâmetros da chamada:');
            console.log('[SHIPPING CALC]   - CEP:', cep);
            console.log('[SHIPPING CALC]   - URL:', url);
            console.log('[SHIPPING CALC]   - Container jQuery:', $container.length, 'elementos');
            console.log('[SHIPPING CALC]   - Container HTML:', $container[0]);
            console.log('[SHIPPING CALC]   - Container ID:', $container.attr('id'));
            console.log('[SHIPPING CALC]   - Container classes:', $container.attr('class'));
            console.log('[SHIPPING CALC]   - Container tem classe js-shipping-calculator-container?', $container.hasClass('js-shipping-calculator-container'));

            {# Verifica se o container tem os elementos necessários #}
            var hasResponse = jQueryNuvem('#cart-shipping-container').find('.js-shipping-calculator-response').length;
            var hasSpinner = jQueryNuvem('#cart-shipping-container').find('.js-shipping-calculator-spinner').length;
            var hasForm = jQueryNuvem('#cart-shipping-container').find('.js-shipping-calculator-form').length;

            console.log('[SHIPPING CALC]   - Container tem .js-shipping-calculator-response?', hasResponse);
            console.log('[SHIPPING CALC]   - Container tem .js-shipping-calculator-spinner?', hasSpinner);
            console.log('[SHIPPING CALC]   - Container tem .js-shipping-calculator-form?', hasForm);

            console.log('[SHIPPING CALC] Função calculateShippingAjax acionada');
            LS.calculateShippingAjax(cep, url, $container);
        } else if (em_produto) {
            {# Product calculator #}
            console.log('[SHIPPING CALC] Chamando LS.calculateShippingAjax para produto');
            LS.calculateShippingAjax(
                jQueryNuvem('#product-shipping-container').find(".js-shipping-input").val(),
                '{{store.shipping_calculator_url | escape('js')}}',
                jQueryNuvem("#product-shipping-container").closest(".js-shipping-calculator-container")
            );
        } else {
            console.error('[SHIPPING CALC] ❌ Contexto não identificado (nem sacola nem produto)');
        }
    });	{# /* // Calculate shipping by submit */ #}

	jQueryNuvem(".js-shipping-input").on('keydown', function (e) {
        var key = e.which ? e.which : e.keyCode;
        var enterKey = 13;
        if (key === enterKey) {
            e.preventDefault();
            jQueryNuvem(e.currentTarget).closest(".js-shipping-calculator-form").find(".js-calculate-shipping").trigger('click');
            if (window.innerWidth < 768) {
                jQueryNuvem(e.currentTarget).trigger('blur');
            }
        }
    });

    {# /* // Shipping and branch click */ #}

    jQueryNuvem(document).on("change", ".js-shipping-method, .js-branch-method", function (e) {
        selectShippingOption(this, true);
        jQueryNuvem(".js-shipping-method-unavailable").hide();
        {# A atualização de totais é feita pelo evento shipping.options.checked disparado pela Nuvemshop #}
    });

    {# /* // Select shipping first option on results - Evento nativo da Nuvemshop */ #}

    {# PATAGANG: Renderiza o Total dinamicamente no container separado #}
    function renderCartTotal(totalValue, showInstallments) {
        console.log('[RENDER TOTAL] Renderizando total:', totalValue);

        var $totalContainer = jQueryNuvem('#pg-cart-total-dynamic');
        if (!$totalContainer.length) {
            console.error('[RENDER TOTAL] Container #pg-cart-total-dynamic não encontrado');
            return;
        }

        {# Formata o valor do total #}
        var formattedTotal = LS.formatToCurrency(totalValue / 100);

        {# Monta o HTML do Total #}
        var totalHTML = '<div class="pg-cart-total-section__row">' +
            '<span class="pg-cart-total-section__label">Total</span>' +
            '<span class="js-cart-total pg-cart-total-section__value" data-component="cart.total" data-component-value="' + totalValue + '">' + formattedTotal + '</span>' +
            '</div>';

        {# Adiciona parcelamento se solicitado #}
        if (showInstallments) {
            {# Busca o componente de parcelamento existente ou cria placeholder #}
            var $existingInstallments = jQueryNuvem('[data-component="installments"]');
            if ($existingInstallments.length) {
                var installmentsHTML = $existingInstallments.clone().wrap('<div>').parent().html();
                totalHTML += '<div class="pg-cart-total-section__installments">' + installmentsHTML + '</div>';
            }
        }

        {# Insere o HTML e mostra o container #}
        $totalContainer.html(totalHTML);
        $totalContainer.show();

        console.log('[RENDER TOTAL] ✓ Total renderizado com sucesso');

        {# Atualiza o parcelamento se a função existir #}
        if (showInstallments && typeof LS.updateInstallments === 'function') {
            setTimeout(function() {
                LS.updateInstallments(totalValue);
                console.log('[RENDER TOTAL] ✓ Parcelamento atualizado');
            }, 100);
        }
    }

    {# Handler para quando uma opção de frete é selecionada (evento disparado pela Nuvemshop) #}
    var shippingUpdateInProgress = false; {# Flag para evitar atualizações simultâneas #}

    jQueryNuvem(document).on('shipping.options.checked', '.js-shipping-method', function (e) {
        {# Previne propagação para evitar listeners duplicados #}
        e.stopImmediatePropagation();

        {# Evita processar múltiplos eventos simultaneamente #}
        if (shippingUpdateInProgress) {
            console.log('[SHIPPING SELECTED] Atualização já em progresso, ignorando...');
            return;
        }

        shippingUpdateInProgress = true;
        console.log('[SHIPPING SELECTED] Opção de frete selecionada');

        let shippingPrice = parseFloat(jQueryNuvem(this).attr("data-price")) || 0;
        console.log('[SHIPPING SELECTED] Preço do frete:', shippingPrice);

        {# Atualiza total usando método nativo da Nuvemshop #}
        LS.addToTotal(shippingPrice);

        {# Seleciona a opção de frete #}
        selectShippingOption(this, false);

        {# PATAGANG: Atualiza TOTAL e PARCELAMENTO após selecionar frete #}
        setTimeout(function() {
            console.log('[SHIPPING SELECTED] Atualizando total e parcelamento...');

            {# Obtém o carrinho atualizado #}
            if (typeof LS !== 'undefined' && LS.data && LS.data.cart) {
                var cart = LS.data.cart;
                var subtotal = cart.subtotal || 0;
                var shippingCents = Math.round(shippingPrice * 100);
                var total = subtotal + shippingCents;

                console.log('[SHIPPING SELECTED] Subtotal:', subtotal, 'Frete:', shippingCents, 'Total:', total);

                {# Renderiza o Total dinamicamente no container separado #}
                renderCartTotal(total, true);

                {# Atualiza o widget do carrinho #}
                jQueryNuvem(".js-cart-widget-total").html(LS.formatToCurrency(total / 100));

                {# Chama updateDisplay se disponível #}
                if (typeof updateDisplay === 'function') {
                    updateDisplay(cart);
                }
            }

            {# Libera a flag após 500ms para permitir nova atualização se necessário #}
            setTimeout(function() {
                shippingUpdateInProgress = false;
                console.log('[SHIPPING SELECTED] ✓ Atualização concluída, flag liberada');
            }, 500);
        }, 250);
    });

    {# PATAGANG: Auto-select removido - A Nuvemshop já dispara shipping.options.checked automaticamente #}
    {# Não precisamos interceptar ou forçar, basta reagir ao evento nativo #}



    {# /* // Toggle branches link */ #}    jQueryNuvem(document).on("click", ".js-toggle-branches", function (e) {
        e.preventDefault();
        jQueryNuvem(".js-store-branches-container").slideToggle("fast");
        jQueryNuvem(".js-see-branches, .js-hide-branches").toggle();
    });

    {# /* // Toggle more shipping options */ #}

    jQueryNuvem(document).on("click", ".js-toggle-more-shipping-options", function(e) {
        e.preventDefault();

        {# Toggle other options depending if they are pickup or delivery for cart and product at the same time #}

        if(jQueryNuvem(this).hasClass("js-show-other-pickup-options")){
            jQueryNuvem(".js-other-pickup-options").slideToggle(600);
            jQueryNuvem(".js-show-other-pickup-options .js-shipping-see-less, .js-show-other-pickup-options .js-shipping-see-more").toggle();
        }else{
            jQueryNuvem(".js-other-shipping-options").slideToggle(600);
            jQueryNuvem(".js-show-more-shipping-options .js-shipping-see-less, .js-show-more-shipping-options .js-shipping-see-more").toggle();
        }
    });

    {# /* // Calculate shipping on page load */ #}

    {# Only shipping input has value, cart has saved shipping and there is no branch selected #}

    calculateCartShippingOnLoad = function(){
        console.log('[SHIPPING LOAD] Iniciando cálculo de frete ao carregar página');
        var cepSalvo = jQueryNuvem("#cart-shipping-container .js-shipping-input").val();
        console.log('[SHIPPING LOAD] CEP salvo:', cepSalvo);

        {# Detecta se existem itens com frete no carrinho #}
        var temItensComFrete = jQueryNuvem(".js-cart-item, .js-pg-cart-item").length > 0;
        console.log('[SHIPPING LOAD] Carrinho tem produtos com frete:', temItensComFrete);

        if(cepSalvo){
            {# If user already had calculated shipping: recalculate shipping #}
            console.log('[SHIPPING LOAD] Recalculando frete com CEP salvo:', cepSalvo);
            setTimeout(function() {
                LS.calculateShippingAjax(
                    jQueryNuvem('#cart-shipping-container').find(".js-shipping-input").val(),
                    '{{store.shipping_calculator_url | escape('js')}}',
                    jQueryNuvem("#cart-shipping-container")
                );
                removeShippingSuboptions();
            }, 100);
        } else if (temItensComFrete) {
            console.log('[SHIPPING LOAD] Carrinho tem produtos com frete, iniciando cálculo ao carregar');
        } else {
            console.log('[SHIPPING LOAD] Nenhum CEP encontrado, aguardando entrada do usuário');
        }

        if(jQueryNuvem(".js-branch-method").hasClass('js-selected-shipping-method')){
            {% if store.branches|length > 1 %}
                jQueryNuvem(".js-store-branches-container").slideDown("fast");
                jQueryNuvem(".js-see-branches").hide();
                jQueryNuvem(".js-hide-branches").show();
            {% endif %}
        }
    };

    {% if cart.has_shippable_products %}
        calculateCartShippingOnLoad();
    {% endif %}

    {# /* // Change CP */ #}

    jQueryNuvem(document).on("click", ".js-shipping-calculator-change-zipcode", function(e) {
        e.preventDefault();
        jQueryNuvem(".js-shipping-calculator-response").fadeOut(100);
        jQueryNuvem(".js-shipping-calculator-head").addClass("with-form").removeClass("with-zip");
        jQueryNuvem(".js-shipping-calculator-with-zipcode").removeClass("transition-up-active");
        jQueryNuvem(".js-shipping-calculator-form").addClass("transition-up-active");
    });

    {# /* // Shipping provinces */ #}

    {% if provinces_json %}
        jQueryNuvem('select[name="country"]').on("change", function (e) {
            var provinces = {{ provinces_json | default('{}') | raw }};
            LS.swapProvinces(provinces[jQueryNuvem(e.currentTarget).val()]);
        }).trigger('change');
    {% endif %}

    {# /* // Change store country: From invalid zipcode message */ #}

    jQueryNuvem(document).on("click", ".js-save-shipping-country", function(e) {

        e.preventDefault();

        {# Change shipping country #}

        lang_select_option = jQueryNuvem(this).closest(".js-modal-shipping-country");
        changeLang(lang_select_option);

        jQueryNuvem(this).text('{{ "Aplicando..." | translate }}').addClass("disabled");
    });	{# Story 8.5 Priority 2: #Forms moved to modules/forms.js #}	{# Story 8.5 Priority 2: #Footer moved to modules/footer.js #}

	{#/*============================================================================
      #Empty placeholders
    ==============================================================================*/ #}

    {% set show_help = not has_products %}

    {% if template == 'home' %}

        {# /* // Home slider */ #}

        var width = window.innerWidth;
        if (width > 767) {
            var slider_empty_autoplay = {delay: 6000,};
        } else {
            var slider_empty_autoplay = false;
        }

        window.homeEmptySlider = {
            getAutoRotation: function() {
                return slider_empty_autoplay;
            },
        };
        createSwiper('.js-home-empty-slider', {
            loop: true,
            autoplay: slider_empty_autoplay,
            pagination: {
                el: '.js-swiper-empty-home-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.js-swiper-empty-home-next',
                prevEl: '.js-swiper-empty-home-prev',
            },
        });

        {# /* // Home demo products slider */ #}

        {% set columns = settings.grid_columns %}

        createSwiper('.js-swiper-featured-demo', {
            slidesPerView: {% if columns == 2 %}2{% else %}1{% endif %},
            spaceBetween: 30,
            navigation: {
                nextEl: '.js-swiper-featured-demo-next',
                prevEl: '.js-swiper-featured-demo-prev',
            },
            pagination: {
                el: '.js-swiper-featured-demo-pagination',
                clickable: true,
            },
            breakpoints: {
                640: {
                    slidesPerView: {% if columns == 2 %}4{% else %}3{% endif %},
                }
            },
        });

        {# /* // Banner services slider */ #}

        if (width < 767) {
            createSwiper('.js-informative-banners-demo', {
                pagination: {
                    el: '.js-informative-banners-demo-pagination',
                    clickable: true,
                },
            });
        }

    {% endif %}

    {% if template == '404' and show_help %}

        {# /* // Product Related */ #}

        {% set columns = settings.grid_columns %}
        const desktopColumns = {% if columns == 1 %}3{% else %}4{% endif %};

        createSwiper('.js-swiper-related-demo', {
            lazy: true,
            watchOverflow: true,
            loop: true,
            spaceBetween: 30,
            slidesPerView: {{ columns }},
            pagination: {
                el: '.js-swiper-related-demo-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.js-swiper-related-demo-next',
                prevEl: '.js-swiper-related-demo-prev',
            },
            breakpoints: {
                767: {
                    slidesPerView: desktopColumns,
                }
            }
        });

        {# /* // Product slider */ #}

        createSwiper('.js-swiper-product-demo', {
            lazy: true,
            loop: false,
            pagination: {
                el: '.js-swiper-product-demo-pagination',
                type: 'fraction',
                clickable: true,
            },
        });

        {# /* 404 handling to show the example product */ #}

        if (/\/product\/example\/?$/.test(window.location.pathname)) {
            document.title = "{{ "Producto de ejemplo" | translate | escape('js') }}";
            $("#404").hide();
            $("#product-example").show();
        } else {
            $("#product-example").hide();
        }

    {% endif %}







});


  {# Função principal: Inicializar shipping functions #}
  const initShippingFunctions = function() {
    console.log('[PatagangStore.shippingFunctions] ✓ Inicialisado');
  };

  {# Expor interface pública #}
  window.PatagangStore = window.PatagangStore || {};
  window.PatagangStore.shippingFunctions = {
    init: initShippingFunctions,
    {# Public API exports for backward compatibility #}
    selectShippingOption: typeof selectShippingOption !== 'undefined' ? selectShippingOption : null,
    calculateShipping: typeof calculateShipping !== 'undefined' ? calculateShipping : null
  };

  {# Auto-inicializar quando DOM estiver pronto #}
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initShippingFunctions);
  } else {
    initShippingFunctions();
  }
})();
