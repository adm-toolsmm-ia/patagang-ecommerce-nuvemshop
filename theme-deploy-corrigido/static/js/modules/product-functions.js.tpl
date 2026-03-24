{#/*============================================================================
  Patagang Store — Product Functions Module (Story 8.5 Priority 2 Phase 2)
  Extracted from store.js.tpl (linhas 926-1810)

  Responsabilidades:
  - Installments (sem juros, com juros)
  - Variant selection e mudanças
  - Product labels on variant change
  - Payment discounts
  - Custom mobile variant display

  Padrão: IIFE com typeof checks + namespace PatagangStore
  Auto-init: DOMContentLoaded
==============================================================================*/#}

(function() {
  'use strict';

  {# Verificar dependências #}
  if (typeof jQueryNuvem === 'undefined' || typeof LS === 'undefined') {
    console.warn('[PatagangStore.productFunctions] Dependências não disponíveis');
    return;
  }

	  #Product detail functions
	==============================================================================*/ #}

	{# /* // Installments */ #}

	{# Installments without interest #}

    function get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests) {
        if (parseInt(number_of_installment) > parseInt(max_installments_without_interests[0])) {
            if (installment_data.without_interests) {
                return [number_of_installment, installment_data.installment_value.toFixed(2)];
            }
        }
        return max_installments_without_interests;
    }

    {# Installments with interest #}

    function get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests) {
        if (parseInt(number_of_installment) > parseInt(max_installments_with_interests[0])) {
            if (installment_data.without_interests == false) {
                return [number_of_installment, installment_data.installment_value.toFixed(2)];
            }
        }
        return max_installments_with_interests;
    }

	{# Updates installments on payment popup for native integrations #}

    function refreshInstallmentv2(price){
        jQueryNuvem(".js-modal-installment-price" ).each(function( el ) {
            const installment = Number(jQueryNuvem(el).data('installment'));
            jQueryNuvem(el).text(LS.currency.display_short + (price/installment).toLocaleString('de-DE', {maximumFractionDigits: 2, minimumFractionDigits: 2}));
        });
    }

    {# Refresh price on payments popup with payment discount applied #}

    function refreshPaymentDiscount(price){
        jQueryNuvem(".js-price-with-discount" ).each(function( el ) {
            const payment_discount = jQueryNuvem(el).data('paymentDiscount');
            jQueryNuvem(el).text(LS.formatToCurrency(price - ((price * payment_discount) / 100)))
        });
    }

    {% set should_show_discount = product.maxPaymentDiscount.value > 0 %}
    {% if should_show_discount %}

        {# Shows/hides price with discount and strikethrough original price for every payment method #}

        function togglePaymentDiscounts(variant){
            jQueryNuvem(".js-payment-method-total").each(function( paymentMethodTotalElement ){
                const priceComparerElement = jQueryNuvem(paymentMethodTotalElement).find(".js-compare-price-display");
                const installmentsOnePaymentElement = jQueryNuvem(paymentMethodTotalElement).find('.js-installments-no-discount');
                const priceWithDiscountElement = jQueryNuvem(paymentMethodTotalElement).find('.js-price-with-discount');

                priceComparerElement.hide();
                installmentsOnePaymentElement.hide();
                priceWithDiscountElement.hide();

                const discount = priceWithDiscountElement.data('paymentDiscount');

                if (discount > 0 && showMaxPaymentDiscount(variant)){
                    priceComparerElement.show();
                    priceWithDiscountElement.show()
                } else {
                    installmentsOnePaymentElement.show();
                }
            })
        }

        {# Toggle discount and discount disclaimer both on product details and popup #}

        function updateDiscountDisclaimers(variant){
            updateProductDiscountDisclaimer(variant);
            updatePopupDiscountDisclaimers(variant);
        }

        {# Toggle discount and discount disclaimer in product details #}

        function updateProductDiscountDisclaimer(variant){
            jQueryNuvem(".js-product-discount-container, .js-product-discount-disclaimer").hide();

            if (showMaxPaymentDiscount(variant)){
                jQueryNuvem(".js-product-discount-container").show();
            }

            if (showMaxPaymentDiscountNotCombinableDisclaimer(variant)){
                jQueryNuvem(".js-product-discount-disclaimer").show();
            }
        }

        {# Shows/hides discount message for payment method and discount disclaimer in popup, for every payment method #}

        function updatePopupDiscountDisclaimers(variant){
            jQueryNuvem(".js-modal-tab-discount, .js-payment-method-discount").hide();

            {% if product.maxPaymentDiscount.value > 0 %}
                if (showMaxPaymentDiscount(variant)){
                    {% for key, method in product.payment_methods_config %}
                        {% if method.max_discount > 0 %}
                            {% if method.allows_discount_combination %}
                                jQueryNuvem("#method_{{ key | sanitize }} .js-modal-tab-discount").show();
                            {% elseif not product.free_shipping %}
                                if (!variantHasPromotionalPrice(variant)){
                                    jQueryNuvem("#method_{{ key | sanitize }} .js-modal-tab-discount").show();
                                }
                            {% endif %}
                        {% endif %}
                    {% endfor %}
                }
            {% endif %}

            jQueryNuvem(".js-info-payment-method-container").each(function(infoPaymentMethodElement){
                {# For each payment method this will show the payment method discount and discount explanation #}

                const infoPaymentMethod = jQueryNuvem(infoPaymentMethodElement)
                infoPaymentMethod.find(".js-discount-explanation").hide();
                infoPaymentMethod.find(".js-discount-disclaimer").hide();

                const priceWithDiscountElement = infoPaymentMethod.find('.js-price-with-discount');
                const discount = priceWithDiscountElement.data('paymentDiscount');

                if (discount > 0 && showMaxPaymentDiscount(variant)){
                    infoPaymentMethod.find(".js-discount-explanation").show();
                    infoPaymentMethod.find(".js-payment-method-discount").show();
                }

                if (discount > 0 && showMaxPaymentDiscountNotCombinableDisclaimer(variant)){
                    infoPaymentMethod.find(".js-discount-disclaimer").show();
                }
            })
        }

        function variantHasPromotionalPrice(variant) { return variant.compare_at_price_number > variant.price_number }

        function showMaxPaymentDiscount(variant) {
            {% if product.maxPaymentDiscount()["allowsDiscountCombination"] %}
                return true;
            {% elseif product.free_shipping %}
                return false;
            {% else %}
                return !variantHasPromotionalPrice(variant);
            {% endif %}
        }

        function showMaxPaymentDiscountNotCombinableDisclaimer(variant) {
            {% if product.maxPaymentDiscount()["allowsDiscountCombination"] or product.free_shipping %}
                return false
            {% else %}
                return !variantHasPromotionalPrice(variant)
            {% endif %}
        }

    {% endif %}

    {# /* // Variants without stock */ #}

    {% set is_button_variant = settings.bullet_variants %}

    {% if is_button_variant %}
        const noStockVariants = (container = null) => {

            {# Configuration for variant elements #}
            const config = {
                variantsGroup: ".js-product-variants-group",
                variantButton: ".js-insta-variant",
                noStockClass: "btn-variant-no-stock",
                dataVariationId: "data-variation-id",
                dataOption: "data-option"
            };

            {# Product container wrapper #}
            const wrapper = container ? container : jQueryNuvem('#single-product');
            if (!wrapper) return;

            {# Fetch the variants data from the container #}
            const dataVariants = wrapper.data('variants');
            const variantsLength = wrapper.find(config.variantsGroup).length;

            {# Get selected options from product variations #}
            const getOptions = (productVariationId, variantOption) => {
                if (productVariationId === 2) {
                    return {
                        option0: String(wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="0"] select`).val()),
                        option1: String(wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="1"] select`).val()),
                        option2: String(jQueryNuvem(variantOption).attr('data-option')),
                    };
                } else if (productVariationId === 1) {
                    return {
                        option0: String(wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="0"] select`).val()),
                        option1: String(jQueryNuvem(variantOption).attr('data-option')),
                    };
                } else {
                    return {
                        option0: String(jQueryNuvem(variantOption).attr('data-option')),
                    };
                }
            };

            {# Filter available variants based on selected options #}
            const filterVariants = (options) => {
                return dataVariants.filter(variant => {
                    return Object.keys(options).every(optionKey => variant[optionKey] === options[optionKey]) && variant.available;
                });
            };

            {# Update stock status for variant buttons #}
            const updateStockStatus = (productVariationId) => {
                const variationGroup = wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="${productVariationId}"]`);
                variationGroup.find(`${config.variantButton}.${config.noStockClass}`).removeClass(config.noStockClass);

                variationGroup.find(config.variantButton).each((variantOption, item) => {
                    const options = getOptions(productVariationId, variantOption);
                    const itemsAvailable = filterVariants(options);
                    const button = wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="${productVariationId}"] ${config.variantButton}[${config.dataOption}="${options[`option${productVariationId}`].replace(/"/g, '\\"')}"]`);

                    if (!itemsAvailable.length) {
                        button.addClass(config.noStockClass);
                    }
                });
            };

            {# Iterate through all variant and update stock status #}
            for (let productVariationId = variantsLength - 1; productVariationId >= 0; productVariationId--) {
                updateStockStatus(productVariationId);
            }
        };

        noStockVariants();

    {% endif %}

    {% if settings.quick_shop %}

        jQueryNuvem(document).on("click", ".js-quickshop-modal-open", function (e) {
            e.preventDefault();
            var $this = jQueryNuvem(this);
            if($this.hasClass("js-quickshop-slide")){
                jQueryNuvem("#quickshop-modal .js-item-product").addClass("js-swiper-slide-visible js-item-slide");
            }

            {% if is_button_variant %}
                {# Updates variants without stock #}
                let container = jQueryNuvem(this).closest('.js-quickshop-container');
                if (!container.length) return;
                noStockVariants(container);
            {% endif %}

            LS.fillQuickshop($this);
        });

        {# Get width of the placeholder button #}

        var productButttonWidth = jQueryNuvem(".js-addtocart-placeholder-inline").prev(".js-addtocart").innerWidth();
        jQueryNuvem(".js-addtocart-placeholder-inline").width(productButttonWidth-20);
    {% endif %}

	{# /* // Change variant */ #}

    {# Updates price, installments, labels and CTA on variant change #}

	function changeVariant(variant){

	    jQueryNuvem(".js-product-detail .js-shipping-calculator-response").hide();
	    jQueryNuvem("#shipping-variant-id").val(variant.id);

	    var parent = jQueryNuvem("body");
	    if (variant.element){
	        parent = jQueryNuvem(variant.element);
	    }

        {% if is_button_variant %}
            {# Updates variants without stock #}
            if(parent.hasClass("js-quickshop-container")){
                let container = parent.closest('.js-quickshop-container');
                noStockVariants(container);
            } else {
                noStockVariants();
            }
        {% endif %}

	    var sku = parent.find('#sku');
	    if(sku.length) {
	        sku.text(variant.sku).show();
	    }

        {# Updates installments on list item and inside payment popup for Payments Apps #}

	    var installment_helper = function($element, amount, price){
            $element.find('.js-installment-amount').text(amount);
            $element.find('.js-installment-price').attr("data-value", price);
            $element.find('.js-installment-price').text(LS.currency.display_short + parseFloat(price).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
            if(variant.price_short && Math.abs(variant.price_number - price * amount) < 1) {
                $element.find('.js-installment-total-price').text((variant.price_short).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
            } else {
                $element.find('.js-installment-total-price').text(LS.currency.display_short + (price * amount).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
            }
        };

        if (variant.installments_data) {
            var variant_installments = JSON.parse(variant.installments_data);
            var max_installments_without_interests = [0,0];
            var max_installments_with_interests = [0,0];

            {# Hide all installments rows on payments modal #}
            jQueryNuvem('.js-payment-provider-installments-row').hide();

            for (let payment_method in variant_installments) {

                {# Identifies the minimum installment value #}
                var paymentMethodId = '#installment_' + payment_method.replace(" ", "_") + '_1';
                var minimumInstallmentValue = jQueryNuvem(paymentMethodId).closest('.js-info-payment-method').attr("data-minimum-installment-value");

                let installments = variant_installments[payment_method];
                for (let number_of_installment in installments) {
                    let installment_data = installments[number_of_installment];
                    max_installments_without_interests = get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests);
                    max_installments_with_interests = get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests);
                    var installment_container_selector = '#installment_' + payment_method.replace(" ", "_") + '_' + number_of_installment;

                    {# Shows installments rows on payments modal according to the minimum value #}
                    if(minimumInstallmentValue <= installment_data.installment_value) {
                        jQueryNuvem(installment_container_selector).show();
                    }

                    if(!parent.hasClass("js-quickshop-container")){
                        installment_helper(jQueryNuvem(installment_container_selector), number_of_installment, installment_data.installment_value.toFixed(2));
                    }
                }
            }
            var $installments_container = jQueryNuvem(variant.element + ' .js-max-installments-container .js-max-installments');
            var $installments_modal_link = jQueryNuvem(variant.element + ' #btn-installments');
            var $payments_module = jQueryNuvem(variant.element + ' .js-product-payments-container');
            var $installmens_card_icon = jQueryNuvem(variant.element + ' .js-installments-credit-card-icon');

	        {% if product.has_direct_payment_only %}
	        var installments_to_use = max_installments_without_interests[0] >= 1 ? max_installments_without_interests : max_installments_with_interests;

	        if(installments_to_use[0] <= 0 ) {
	        {%  else %}
	        var installments_to_use = max_installments_without_interests[0] > 1 ? max_installments_without_interests : max_installments_with_interests;

	        if(installments_to_use[0] <= 1 ) {
	        {% endif %}
	            $installments_container.hide();
	            $installments_modal_link.hide();
	            $payments_module.hide();
	            $installmens_card_icon.hide();
	        } else {
	            $installments_container.show();
	            $installments_modal_link.show();
	            $payments_module.show();
	            $installmens_card_icon.show();
	            installment_helper($installments_container, installments_to_use[0], installments_to_use[1]);
	        }
	    }

	    if(!parent.hasClass("js-quickshop-container")){
	    	jQueryNuvem('#installments-modal .js-installments-one-payment').text(variant.price_short).attr("data-value", variant.price_number);
		}

	    if (variant.price_short){
            parent.find('.js-price-display').text(variant.price_short).show();
            parent.find('.js-price-display').attr("content", variant.price_number).data('productPrice', variant.price_number_raw);

            parent.find('.js-payment-discount-price-product').text(variant.price_with_payment_discount_short);
            parent.find('.js-payment-discount-price-product-container').show();

            parent.find('.js-price-without-taxes').text(variant.price_without_taxes);
            parent.find('.js-price-without-taxes-container').show();
	    } else {
	        parent.find('.js-price-display, .js-payment-discount-price-product-container, .js-price-without-taxes-container').hide();
	    }

	    if ((variant.compare_at_price_short) && !(parent.find(".js-price-display").css("display") == "none")) {
	        parent.find('.js-compare-price-display').text(variant.compare_at_price_short).show();
	    } else {
	        parent.find('.js-compare-price-display').hide();
	    }

	    var button = parent.find('.js-addtocart');
	    button.removeClass('cart').removeClass('contact').removeClass('nostock');
	    var $product_shipping_calculator = parent.find("#product-shipping-container");

        {# Update CTA wording and status #}

	    {% if not store.is_catalog %}
	    if (!variant.available){
	        button.val('{{ "Sin stock" | translate }}');
            button.addClass('nostock');
            button.attr('disabled', 'disabled');
	        $product_shipping_calculator.hide();
	    } else if (variant.contact) {
	        button.val('{{ "Consultar precio" | translate }}');
            button.addClass('contact');
            button.removeAttr('disabled');
            $product_shipping_calculator.hide();
	    } else {
	        button.val('{{ "Agregar al carrito" | translate }}');
            button.addClass('cart');
            button.removeAttr('disabled');
            $product_shipping_calculator.show();
	    }

	    {% endif %}

        {% if template == 'product' %}
            const base_price = Number(jQueryNuvem("#price_display").attr("content"));
            refreshInstallmentv2(base_price);
            refreshPaymentDiscount(variant.price_number);
            {% if should_show_discount %}
                togglePaymentDiscounts(variant);
                updateDiscountDisclaimers(variant);
            {% endif %}

            {% if settings.last_product and product.variations %}
                if(variant.stock == 1) {
                    jQueryNuvem('.js-last-product').show();
                } else {
                    jQueryNuvem('.js-last-product').hide();
                }
            {% endif %}
        {% endif %}

        {# Update shipping on variant change #}

        LS.updateShippingProduct();

        zipcode_on_changevariant = jQueryNuvem("#product-shipping-container .js-shipping-input").val();
        jQueryNuvem("#product-shipping-container .js-shipping-calculator-current-zip").text(zipcode_on_changevariant);

        {% if cart.free_shipping.min_price_free_shipping.min_price %}
            {# Updates free shipping bar #}

            LS.freeShippingProgress(true, parent);

        {% endif %}

        LS.subscriptionChangeVariant(variant);
	}

	{# /* // Product labels on variant change */ #}

	{# Stock, Offer and discount labels update #}

	jQueryNuvem(document).on("change", ".js-variation-option", function(e) {

        var $parent = jQueryNuvem(this).closest(".js-product-variants");
        var $variants_group = jQueryNuvem(this).closest(".js-product-variants-group");
        var $quickshop_parent_wrapper = jQueryNuvem(this).closest(".js-quickshop-container");

        {# If quickshop is used from modal, use quickshop-id from the item that opened it #}

        if($quickshop_parent_wrapper.hasClass("js-quickshop-modal")){
            var quick_id = jQueryNuvem(".js-quickshop-opened .js-quickshop-container").data("quickshopId");
        }else{
            var quick_id = $quickshop_parent_wrapper.data("quickshopId");
        }

        if($parent.hasClass("js-product-quickshop-variants")){

            var $quickshop_parent = jQueryNuvem(this).closest(".js-item-product");

            {# Target visible slider item if necessary #}

            if($quickshop_parent.hasClass("js-item-slide")){
                var $quickshop_variant_selector = '.js-swiper-slide-visible .js-quickshop-container[data-quickshop-id="'+quick_id+'"]';
            }else{
                var $quickshop_variant_selector = '.js-quickshop-container[data-quickshop-id="'+quick_id+'"]';
            }

            LS.changeVariant(changeVariant, $quickshop_variant_selector);

            {% if settings.product_color_variants %}
                {# Match selected color variant with selected quickshop variant #}

                if(($variants_group).hasClass("js-color-variants-container")){
                    var selected_option_id = jQueryNuvem(this).find("option").filter((el) => el.selected).val();
                    if($quickshop_parent.hasClass("js-item-slide")){
                        var $color_parent_to_update = jQueryNuvem('.js-swiper-slide-visible .js-quickshop-container[data-quickshop-id="'+quick_id+'"]');
                    }else{
                        var $color_parent_to_update = jQueryNuvem('.js-quickshop-container[data-quickshop-id="'+quick_id+'"]');
                    }

                    {# Update all color buttons on several places (quickshop, item, product detail) #}
                    $color_parent_to_update.find('.js-color-variant[data-option="'+selected_option_id+'"]').addClass("selected").siblings().removeClass("selected");
                    {# Update this specific variant button #}
                    $variants_group.find('.js-insta-variant[data-option="'+selected_option_id+'"]').addClass("selected").siblings().removeClass("selected");
                }
            {% endif %}
        } else {
            LS.changeVariant(changeVariant, '#single-product');
        }

        {# Offer and discount labels update #}

        var $this_product_container = jQueryNuvem(this).closest(".js-product-container");

        if($this_product_container.hasClass("js-quickshop-container")){
            var this_quickshop_id = $this_product_container.attr("data-quickshop-id");
            var $this_product_container = jQueryNuvem('.js-product-container[data-quickshop-id="'+this_quickshop_id+'"]');
        }
        var $this_compare_price = $this_product_container.find(".js-compare-price-display");
        var $this_price = $this_product_container.find(".js-price-display");
        var $installment_container = $this_product_container.find(".js-product-payments-container");
        var $installment_text = $this_product_container.find(".js-max-installments-container");
        var $this_add_to_cart = $this_product_container.find(".js-prod-submit-form");

        // Get the current product discount percentage value
        var current_percentage_value = $this_product_container.find(".js-offer-percentage");

        // Get the current product price and promotional price
        var compare_price_value = $this_compare_price.html();
        var price_value = $this_price.html();

        // Calculate new discount percentage based on difference between filtered old and new prices
        const percentageDifference = window.moneyDifferenceCalculator.percentageDifferenceFromString(compare_price_value, price_value);
        if(percentageDifference){
            $this_product_container.find(".js-offer-percentage").text(percentageDifference);
            $this_product_container.find(".js-offer-label").css("display" , "table");
        }

	    if ($this_compare_price.css("display") == "none" || !percentageDifference) {
	        $this_product_container.find(".js-offer-label").hide();
	    }

	    if ($this_add_to_cart.hasClass("nostock")) {
	        $this_product_container.find(".js-stock-label").show();
	    }
	    else {
	        $this_product_container.find(".js-stock-label").hide();
	    }
	    if ($this_price.css('display') == 'none'){
	        $installment_container.hide();
	        $installment_text.hide();
	    }else{
	        $installment_text.show();
	    }
	});

    {% if settings.product_color_variants %}

        {# Product color variations #}

        jQueryNuvem(document).on("click", ".js-color-variant", function(e) {
            e.preventDefault();
            $this = jQueryNuvem(this);

            var option_id = $this.data('option');
            $selected_option = $this.closest('.js-item-product').find('.js-variation-option option').filter(function(el) {
                return el.value == option_id;
            });

            $selected_option.prop('selected', true).trigger('change');
            var available_variant = jQueryNuvem(this).closest(".js-quickshop-container").data('variants');

            var available_variant_color = jQueryNuvem(this).closest('.js-color-variant-active').data('option');

            for (var variant in available_variant) {
                if (option_id == available_variant[variant]['option'+ available_variant_color ]) {

                    if (available_variant[variant]['stock'] == null || available_variant[variant]['stock'] > 0 ) {

                        var otherOptions = getOtherOptionNumbers(available_variant_color);

                        var otherOption = available_variant[variant]['option' + otherOptions[0]];
                        var anotherOption = available_variant[variant]['option' + otherOptions[1]];

                        changeSelect(jQueryNuvem(this), otherOption, otherOptions[0]);
                        changeSelect(jQueryNuvem(this), anotherOption, otherOptions[1]);
                        break;

                    }
                }
            }
            $this.siblings().removeClass("selected");
            $this.addClass("selected");
        });

        function getOtherOptionNumbers(selectedOption) {
            switch (selectedOption) {
                case 0:
                    return [1, 2];
                case 1:
                    return [0, 2];
                case 2:
                    return [0, 1];
            }
        }

        function changeSelect(element, optionToSelect, optionIndex) {
            if (optionToSelect != null) {
                var selected_option_attribute = element.closest('.js-item-product').find('.js-color-variant-available-' + (optionIndex + 1)).data('value');
                var selected_option = element.closest('.js-item-product').find('#' + selected_option_attribute + " option").filter(function(el) {
                    return el.value == optionToSelect;
                });

                selected_option.prop('selected', true).trigger('change');
            }
        }

    {% endif %}

    {% if settings.bullet_variants %}

        changeVariantButton = function(selector, parentSelector) {
            selector.siblings().removeClass("selected");
            selector.addClass("selected");
            var option_id = selector.attr('data-option');
            var parent = selector.closest(parentSelector);
            var selected_option = parent.find('.js-variation-option option').filter(function (el) {
                return el.value == option_id;
            });
            selected_option.prop('selected', true).trigger('change');
        }

        jQueryNuvem(document).on("click", ".js-insta-variant", function (e) {
            e.preventDefault();
            $this = jQueryNuvem(this);
            changeVariantButton($this, '.js-product-variants-group');
        });

    {% endif %}

    {% if settings.product_color_variants or settings.quick_shop %}

        {# Product quickshop for color variations #}

        LS.registerOnChangeVariant(function(variant){
            {# Show product image on color change #}

            const productContainer = jQueryNuvem('.js-item-product[data-product-id="'+variant.product_id+'"]');
            const current_image = productContainer.find('.js-item-image');
            current_image.attr('srcset', variant.image_url);

            {% if has_item_slider %}

                {# Remove slider when variant changes #}

                const swiperElement = productContainer.find('.js-product-item-slider-container-private.swiper-container-initialized');

                if(swiperElement.length){
                    productContainer.find('.js-product-item-slider-slide-private').removeClass('item-image-slide');
                    setTimeout(function(){
                        const productImageLink = productContainer.find('.js-product-item-image-link-private');
                        const imageToKeep = productContainer.find('.js-swiper-slide-visible img').clone();

                        // Destroy the Swiper instance
                        if (itemProductSliders[variant.product_id]) {
                            itemProductSliders[variant.product_id].destroy(true, true);
                            delete itemProductSliders[variant.product_id];
                        }
                         // Remove the Swiper elements
                         swiperElement.remove();
                         productContainer.find('.js-product-item-slider-pagination-container').remove();

                        // Insert the cloned image into the link
                        productImageLink.append(imageToKeep);

                    },300);
                }
            {% endif %}

            {% if settings.product_hover %}
                {# Remove secondary feature on image updated from changeVariant #}
                productContainer.find(".js-product-item-private-with-secondary-images").addClass("product-item-secondary-images-disabled");
            {% endif %}
        });


    {% endif %}

	{# /* // Submit to contact */ #}

	{# Submit to contact form when product has no price #}

	jQueryNuvem(".js-product-form").on("submit", function (e) {
        var button = jQueryNuvem(e.currentTarget).find('[type="submit"]');
        button.attr('disabled', 'disabled');
        if ((button.hasClass('contact')) || (button.hasClass('catalog'))) {
            e.preventDefault();
            var product_id = jQueryNuvem(e.currentTarget).find("input[name='add_to_cart']").val();
            window.location = "{{ store.contact_url | escape('js') }}?product=" + product_id;
        } else if (button.hasClass('cart')) {
            button.val('{{ "Agregando..." | translate }}');
        }
    });

	{% if template == 'product' %}

	    {# /* // Product slider */ #}

            {% set has_multiple_slides = product.images_count > 1 or video_url %}

            var productSwiper = null;
            createSwiper(
                '.js-swiper-product',
                {
                    direction: 'horizontal',
                    lazy: true,
                    loop: false,
                    pagination: {
                        el: '.js-swiper-product-pagination',
                        type: 'fraction',
                        clickable: true,
                    },
                    navigation: {
                        nextEl: '.js-swiper-product-button-next',
                        prevEl: '.js-swiper-product-button-prev',
                    },
                    on: {
                        init: function () {
                            jQueryNuvem(".js-product-slider-placeholder").hide();
                            jQueryNuvem(".js-swiper-product").css("visibility", "visible");
                            {% if video_url %}
                                productSwiperHeight = jQueryNuvem(".js-swiper-product").height();
                                jQueryNuvem(".js-product-video-slide").height(productSwiperHeight);
                            {% endif %}
                        },
                        {% if video_url %}
                            slideChangeTransitionEnd: function () {
                                const $parent = jQueryNuvem(this.el).closest(".js-product-detail");
                                const $labelsFloatingGroup = $parent.find(".js-labels-floating-group");
                                if(jQueryNuvem(".js-product-video-slide").hasClass("swiper-slide-active")){
                                    $labelsFloatingGroup.fadeOut(100);
                                }else{
                                    $labelsFloatingGroup.fadeIn(100);
                                }
                                jQueryNuvem('.js-video').show();
                                jQueryNuvem('.js-video-iframe').hide().find("iframe").remove();
                            },
                        {% endif %}
                    },
                },
                function(swiperInstance) {
                    productSwiper = swiperInstance;
                }
            );

            // ============================================================================
            // PATAGANG: Modal Customizado de Galeria com Thumbnails
            // ============================================================================
            
            (function() {
                const modal = document.getElementById('pg-modal-gallery');
                if (!modal) return;
                
                const mainImage = document.getElementById('pg-modal-main-image');
                const currentCounter = document.getElementById('pg-modal-current');
                const thumbs = modal.querySelectorAll('.js-modal-thumb');
                const closeButtons = modal.querySelectorAll('.js-close-modal-gallery');
                const navButtons = modal.querySelectorAll('.js-modal-nav');
                const openButtons = document.querySelectorAll('.js-open-modal-gallery');
                
                let currentIndex = 0;
                const totalImages = thumbs.length;
                
                // Função para abrir o modal
                function openModal(index) {
                    currentIndex = index;
                    updateMainImage();
                    modal.classList.add('is-open');
                    modal.setAttribute('aria-hidden', 'false');  // Dynamic toggle
                    document.body.style.overflow = 'hidden';
                }

                // Função para fechar o modal
                function closeModal() {
                    modal.classList.remove('is-open');
                    modal.setAttribute('aria-hidden', 'true');  // Dynamic toggle
                    document.body.style.overflow = '';
                }
                
                // Função para atualizar a imagem principal
                function updateMainImage() {
                    const activeThumb = thumbs[currentIndex];
                    if (!activeThumb) return;
                    
                    const imageUrl = activeThumb.dataset.imageOriginal || activeThumb.dataset.imageLarge;
                    mainImage.src = imageUrl;
                    
                    // Atualizar estado ativo dos thumbnails
                    thumbs.forEach((thumb, i) => {
                        thumb.classList.toggle('is-active', i === currentIndex);
                    });
                    
                    // Atualizar contador
                    if (currentCounter) {
                        currentCounter.textContent = currentIndex + 1;
                    }
                    
                    // Scroll para o thumbnail ativo
                    activeThumb.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                }
                
                // Navegação para próximo/anterior
                function navigate(direction) {
                    if (direction === 'next') {
                        currentIndex = (currentIndex + 1) % totalImages;
                    } else {
                        currentIndex = (currentIndex - 1 + totalImages) % totalImages;
                    }
                    updateMainImage();
                }
                
                // Event listeners para abrir o modal
                openButtons.forEach(btn => {
                    btn.addEventListener('click', function(e) {
                        e.preventDefault();
                        const index = parseInt(this.dataset.imageIndex) || 0;
                        openModal(index);
                    });
                });
                
                // Event listeners para fechar o modal
                closeButtons.forEach(btn => {
                    btn.addEventListener('click', closeModal);
                });
                
                // Event listeners para thumbnails
                thumbs.forEach((thumb, index) => {
                    thumb.addEventListener('click', function() {
                        currentIndex = index;
                        updateMainImage();
                    });
                });
                
                // Event listeners para navegação
                navButtons.forEach(btn => {
                    btn.addEventListener('click', function() {
                        navigate(this.dataset.direction);
                    });
                });
                
                // Fechar com ESC
                document.addEventListener('keydown', function(e) {
                    if (!modal.classList.contains('is-open')) return;
                    
                    if (e.key === 'Escape') {
                        closeModal();
                    } else if (e.key === 'ArrowRight') {
                        navigate('next');
                    } else if (e.key === 'ArrowLeft') {
                        navigate('prev');
                    }
                });
            })();

	    {% if has_multiple_slides %}
	        LS.registerOnChangeVariant(function(variant){
                var liImage = jQueryNuvem('.js-swiper-product').find("[data-image='"+variant.image+"']");
                var selectedPosition = liImage.data('imagePosition');
                var slideToGo = parseInt(selectedPosition);
                productSwiper.slideTo(slideToGo);
                jQueryNuvem(".js-product-slide-img").removeClass("js-active-variant");
                liImage.find(".js-product-slide-img").addClass("js-active-variant");
            });
	    {% endif %}

        {# /* // Pinterest sharing */ #}

        jQueryNuvem('.js-pinterest-share').on("click", function(e){
            e.preventDefault();
            jQueryNuvem(".pinterest-hidden a").get()[0].click();
        });

	{% endif %}

    {# Product quantitiy #}

    jQueryNuvem('.js-quantity .js-quantity-up').on('click', function(e) {
        $quantity_input = jQueryNuvem(e.currentTarget).closest(".js-quantity").find(".js-quantity-input");
        $quantity_input.val( parseInt($quantity_input.val(), 10) + 1);
    });

    jQueryNuvem('.js-quantity .js-quantity-down').on('click', function(e) {
        $quantity_input = jQueryNuvem(e.currentTarget).closest(".js-quantity").find(".js-quantity-input");
        quantity_input_val = $quantity_input.val();
        if (quantity_input_val>1) {
            $quantity_input.val( parseInt($quantity_input.val(), 10) - 1);
        }
    });

	{#/*============================================================================

  {# Função principal: Inicializar product functions #}
  const initProductFunctions = function() {
    console.log('[PatagangStore.productFunctions] ✓ Inicialisado');
  };

  {# Expor interface pública #}
  window.PatagangStore = window.PatagangStore || {};
  window.PatagangStore.productFunctions = {
    init: initProductFunctions,
    {# Public API exports for backward compatibility #}
    get_max_installments_without_interests: typeof get_max_installments_without_interests !== 'undefined' ? get_max_installments_without_interests : null,
    get_max_installments_with_interests: typeof get_max_installments_with_interests !== 'undefined' ? get_max_installments_with_interests : null,
    refreshInstallmentv2: typeof refreshInstallmentv2 !== 'undefined' ? refreshInstallmentv2 : null,
    changeVariant: typeof changeVariant !== 'undefined' ? changeVariant : null
  };

  {# Auto-inicializar quando DOM estiver pronto #}
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initProductFunctions);
  } else {
    initProductFunctions();
  }
})();
