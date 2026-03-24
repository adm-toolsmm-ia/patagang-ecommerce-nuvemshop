{#/*============================================================================
    #Specific store JS functions: product variants, cart, shipping, etc
==============================================================================*/#}

{#/*============================================================================

    Table of Contents

    #Lazy load
    #Notificactions
    #Modals
    #Tabs
    #Header and nav
        // Nav
        // Search suggestions
    #Sliders
        // Home slider
        // Banner services slider
    #Social
        // Youtube or Vimeo video
        // Facebook login
    #Product grid
        // Filters
        // Product item slider
        // Infinite scroll
    #Product detail functions
        // Installments
        // Change Variant
        // Product labels on variant change
        // Color and size variants change
        // Custom mobile variants change
        // Submit to contact
        // Product slider
        // Pinterest sharing
        // Product quantity
    #Cart
        // Toggle cart
        // Add to cart
        // Cart quantitiy changes
        // Empty cart alert
        // Go to checkout
    #Shipping calculator
        // Free shipping bar
        // Select and save shipping function
        // Calculate shipping function
        // Calculate shipping by submit
        // Shipping and branch click
        // Select shipping first option on results
        // Toggle branches link
        // Toggle more shipping options
        // Calculate shipping on page load
        // Shipping provinces
        // Change store country
    #Forms
    #Footer
    #Empty placeholders

==============================================================================*/#}

// Move to our_content
window.urls = {
    "shippingUrl": "{{ store.shipping_calculator_url | escape('js') }}"
}

{#/*============================================================================
  #Lazy load — CONSOLIDATED to native loading="lazy"
  Removed custom lazysizes implementation (replaced with browser native)
  lazysizes library events are no longer used as of v1.6.0
==============================================================================*/ #}

// Lazyload now handled by native HTML5 loading="lazy" attribute
// This section kept for backward compatibility reference
// If needed to support older browsers, lazysizes can be restored


DOMContentLoaded.addEventOrExecute(() => {

	{#/*============================================================================
	  #Lazy-load Olark (Story 8.5 Priority 1 — CORRIGIDO v1.5.74)
	  Moved from external.js.tpl para carregamento após renderização
	==============================================================================*/ #}
	{% if store.live_chat %}
	window.olark||(function(c){var f=window,d=document,l=f.location.protocol=="https:"?"https:":"http:",z=c.name,r="load";var nt=function(){f[z]=function(){(a.s=a.s||[]).push(arguments)};var a=f[z]._={},q=c.methods.length;while(q--){(function(n){f[z][n]=function(){f[z]("call",n,arguments)}})(c.methods[q])}a.l=c.loader;a.i=nt;a.p={0:+new Date};a.P=function(u){a.p[u]=new Date-a.p[0]};function s(){a.P(r);f[z](r)}f.addEventListener?f.addEventListener(r,s,false):f.attachEvent("on"+r,s);var ld=function(){function p(hd){hd="head";return["<",hd,"></",hd,"><",i,' onl' + 'oad="var d=',g,";d.getElementsByTagName('head')[0].",j,"(d.",h,"('script')).",k,"='",l,"//",a.l,"'",'"',"></",i,">"].join("")}var i="body",m=d[i];if(!m){return setTimeout(ld,100)}a.P(1);var j="appendChild",h="createElement",k="src",n=d[h]("div"),v=n[j](d[h](z)),b=d[h]("iframe"),g="document",e="domain",o;n.style.display="none";m.insertBefore(n,m.firstChild).id=z;b.frameBorder="0";b.id=z+"-loader";if(/MSIE[ ]+6/.test(navigator.userAgent)){b.src="javascript:false"}b.allowTransparency="true";v[j](b);try{b.contentWindow[g].open()}catch(w){c[e]=d[e];o="javascript:var d="+g+".open();d.domain='"+d.domain+"';";b[k]=o+"void(0);"}try{var t=b.contentWindow[g];t.write(p());t.close()}catch(x){b[k]=o+'d.write("'+p().replace(/"/g,String.fromCharCode(92)+'"')+'");d.close();'}a.P(2)};ld()};nt()})({loader: "static.olark.com/jsclient/loader0.js",name:"olark",methods:["configure","extend","declare","identify"]});
	olark.identify('{{store.live_chat | escape('js')}}');
	{% endif %}

	{# Story 8.5 Priority 2: #Notifications moved to modules/notifications.js #}

	{#/*============================================================================
      #Modals
    ==============================================================================*/ #}

    {% if settings.quick_shop %}

        restoreQuickshopForm = function(){

            {# Restore form to item when quickshop closes #}

            {# Clean quickshop modal #}

            jQueryNuvem("#quickshop-modal .js-item-product").removeClass("js-swiper-slide-visible js-item-slide");
            jQueryNuvem("#quickshop-modal .js-quickshop-container").attr( { 'data-variants' : '' , 'data-quickshop-id': '' } );
            jQueryNuvem("#quickshop-modal .js-item-product").attr('data-product-id', '');

            {# Wait for modal to become invisible before removing form #}

            setTimeout(function(){
                var $quickshop_form = jQueryNuvem("#quickshop-form").find('.js-product-form');
                var $item_form_container = jQueryNuvem(".js-quickshop-opened").find(".js-item-variants");

                $quickshop_form.detach().appendTo($item_form_container);
                jQueryNuvem(".js-quickshop-opened").removeClass("js-quickshop-opened");
            },350);

        };

    {% endif %}

    {# Full screen mobile modals back events #}

    if (window.innerWidth < 768) {	{# Story 8.5: URL hash utilities moved to modules/utilities.js #}
	

        {# Open full screen modal and url hash #}

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-open", function(e) {
            e.preventDefault();
            var modal_url_hash = jQueryNuvem(this).data("modalUrl");
            window.location.hash = modal_url_hash;
        });

        {# Close full screen modal: Remove url hash #}

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-close", function(e) {
            e.preventDefault();
            goBackBrowser();
        });

        {# Hide panels or modals on browser backbutton #}

        window.onhashchange = function() {
            if(window.location.href.indexOf("modal-fullscreen") <= -1) {

                {# Close opened modal #}

                if(jQueryNuvem(".js-fullscreen-modal").hasClass("modal-show")){

                    {# Remove body lock only if a single modal is visible on screen #}

                    if(jQueryNuvem(".js-modal.modal-show").length == 1){
                        jQueryNuvem("body").removeClass("overflow-none");
                    }

                    var $opened_modal = jQueryNuvem(".js-fullscreen-modal.modal-show");
                    var $opened_modal_overlay = $opened_modal.prev();

                    $opened_modal.removeClass("modal-show");
                    setTimeout(() => $opened_modal.hide(), 500);
                    $opened_modal_overlay.fadeOut(500);

                    {% if settings.quick_shop %}
                        restoreQuickshopForm();
                    {% endif %}
                }
            }
        }

    }

    modalOpen = function(modal_id, openType){
        var $overlay_id = jQueryNuvem('.js-modal-overlay[data-modal-id="' + modal_id + '"]');
        if (jQueryNuvem(modal_id).hasClass("modal-show")) {
            let modal = jQueryNuvem(modal_id).removeClass("modal-show");
            setTimeout(() => modal.hide(), 500);
        } else {

            {# Lock body scroll if there is no modal visible on screen #}

            if(!jQueryNuvem(".js-modal.modal-show").length){
                jQueryNuvem("body").addClass("overflow-none");
            }
            $overlay_id.fadeIn(400);
            jQueryNuvem(modal_id).detach().appendTo("body");
            $overlay_id.detach().insertBefore(modal_id);
            jQueryNuvem(modal_id).show().addClass("modal-show");

            {# PATAGANG: Se for o modal do carrinho, renderiza o Total #}
            if (modal_id === '#modal-cart') {
                setTimeout(function() {
                    var total = 0;

                    {# Tenta pegar do LS primeiro #}
                    if (typeof LS !== 'undefined' && LS.data && LS.data.cart) {
                        total = LS.data.cart.total;
                    }

                    {# Fallback: Tenta pegar do DOM se LS falhar ou total for 0 #}
                    if (!total) {
                        var $subtotal = jQueryNuvem('.js-subtotal-price');
                        if ($subtotal.length) {
                            total = $subtotal.data('priceraw');
                        }
                    }

                    if (total && typeof renderCartTotal === 'function') {
                        renderCartTotal(total, true);
                        console.log('[MODAL OPEN] ✓ Total renderizado ao abrir carrinho (Total: ' + total + ')');
                    } else {
                        console.warn('[MODAL OPEN] ⚠ Não foi possível obter o total do carrinho');
                    }
                }, 100);
            }
        }

        {# Add url hash to full screen modal if it is opened without click #}

        if(openType == 'openFullScreenWithoutClick' && window.innerWidth < 768 && jQueryNuvem(modal_id).hasClass("js-fullscreen-modal")){
            var modal_url_hash = jQueryNuvem(modal_id).data("modalUrl");
            window.location.hash = modal_url_hash;
        }
    };

    jQueryNuvem(document).on("click", ".js-modal-open", function(e) {
        e.preventDefault();
        var modal_id = jQueryNuvem(this).data('toggle');
        modalOpen(modal_id);
    });

    jQueryNuvem(document).on("click", ".js-modal-close", function(e) {
        e.preventDefault();
        {# Remove body lock only if a single modal is visible on screen #}

        if(jQueryNuvem(".js-modal.modal-show").length == 1){
            jQueryNuvem("body").removeClass("overflow-none");
        }
        var $modal = jQueryNuvem(this).closest(".js-modal");
        var modal_id = $modal.attr('id');
        var $overlay_id = jQueryNuvem('.js-modal-overlay[data-modal-id="#' + modal_id + '"]');
        $modal.removeClass("modal-show");
        setTimeout(() => $modal.hide(), 500);
        $overlay_id.fadeOut(500);
        {% if settings.quick_shop %}
            restoreQuickshopForm();
        {% endif %}

        {# Close full screen modal: Remove url hash #}

        if ((window.innerWidth < 768) && (jQueryNuvem(this).hasClass(".js-fullscreen-modal-close"))) {
            goBackBrowser();
        }
    });

    jQueryNuvem(document).on("click", ".js-modal-overlay", function(e) {
        e.preventDefault();
        {# Remove body lock only if a single modal is visible on screen #}

        if(jQueryNuvem(".js-modal.modal-show").length == 1){
            jQueryNuvem("body").removeClass("overflow-none");
        }
        var modal_id = jQueryNuvem(this).data('modalId');
        let modal = jQueryNuvem(modal_id).removeClass("modal-show");
        setTimeout(() => modal.hide(), 500);
        jQueryNuvem(this).fadeOut(500);
        {% if settings.quick_shop %}
            restoreQuickshopForm();
        {% endif %}

        if (jQueryNuvem(this).hasClass("js-fullscreen-overlay") && (window.innerWidth < 768)) {
            cleanURLHash();
        }
    });

    {% if template == 'home' and settings.home_promotional_popup %}

        {# /* // Home popup and newsletter popup */ #}

        jQueryNuvem('#news-popup-form').on("submit", function () {
            jQueryNuvem(".js-news-spinner").show();
            jQueryNuvem(".js-news-send, .js-news-popup-submit").hide();
            jQueryNuvem(".js-news-popup-submit").prop("disabled", true);
        });

        LS.newsletter('#news-popup-form-container', '#home-modal', '{{ store.contact_url | escape('js') }}', function (response) {
            jQueryNuvem(".js-news-spinner").hide();
            jQueryNuvem(".js-news-send, .js-news-popup-submit").show();
            var selector_to_use = response.success ? '.js-news-popup-success' : '.js-news-popup-failed';
            let newPopupAlert = jQueryNuvem(this).find(selector_to_use).fadeIn(100);
            setTimeout(() => newPopupAlert.fadeOut(500), 4000);
            if (jQueryNuvem(".js-news-popup-success").css("display") == "block") {
                setTimeout(function () {
                    jQueryNuvem('[data-modal-id="#home-modal"]').fadeOut(500);
                    let homeModal = jQueryNuvem("#home-modal").removeClass("modal-show");
                    setTimeout(() => homeModal.hide(), 500);
                }, 2500);
            }
            jQueryNuvem(".js-news-popup-submit").prop("disabled", false);
        });


        var callback_show = function(){
            jQueryNuvem('.js-modal-overlay[data-modal-id="#home-modal"]').fadeIn(500);
            jQueryNuvem("#home-modal").detach().appendTo("body").show().addClass("modal-show");
        }
        var callback_hide = function(){
            jQueryNuvem('.js-modal-overlay[data-modal-id="#home-modal"]').fadeOut(500);
            let homeModal = jQueryNuvem("#home-modal").removeClass("modal-show");
            setTimeout(() => homeModal.hide(), 500);
        }
        LS.homePopup({
            selector: "#home-modal",
            timeout: 10000,
            mobile_max_pixels: 0,
        }, callback_hide, callback_show);

    {% endif %}

    {#/*============================================================================
      #Newsletter Modal - Produtos em Desenvolvimento (PATAGANG)
    ==============================================================================*/ #}

    {# Open newsletter modal #}
    jQueryNuvem(document).on("click", ".js-open-newsletter-modal", function(e) {
        e.preventDefault();
        var $modal = jQueryNuvem(".js-modal-newsletter");
        if ($modal.length) {
            $modal.fadeIn(300);
            jQueryNuvem("body").addClass("overflow-none");
        }
    });

    {# Close newsletter modal #}
    jQueryNuvem(document).on("click", ".js-close-newsletter-modal", function(e) {
        e.preventDefault();
        var $modal = jQueryNuvem(".js-modal-newsletter");
        $modal.fadeOut(300);
        jQueryNuvem("body").removeClass("overflow-none");
    });

    {# Close modal with ESC key #}
    jQueryNuvem(document).on("keydown", function(e) {
        if (e.key === "Escape") {
            var $modal = jQueryNuvem(".js-modal-newsletter");
            if ($modal && $modal.length && jQueryNuvem($modal).is(":visible")) {
                $modal.fadeOut(300);
                jQueryNuvem("body").removeClass("overflow-none");
            }
        }
    });

    {# Newsletter modal form submission #}
    jQueryNuvem(document).on("submit", ".js-newsletter-modal-form", function(e) {
        var $form = jQueryNuvem(this);
        var $messages = $form.closest(".pg-modal-newsletter__content").find(".js-newsletter-messages");
        var $success = $messages.find(".js-newsletter-success");
        var $error = $messages.find(".js-newsletter-error");
        var email = $form.find('input[name="email"]').val();

        {# Basic email validation #}
        if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            e.preventDefault();
            $messages.show();
            $error.show();
            $success.hide();
            return false;
        }

        {# Show success message after form submission #}
        $messages.show();
        $success.show();
        $error.hide();

        {# Close modal after 3 seconds on success #}
        setTimeout(function() {
            jQueryNuvem(".js-modal-newsletter").fadeOut(300);
            jQueryNuvem("body").removeClass("overflow-none");
        }, 3000);
    });

    {#/*============================================================================
      #Accordions
    ==============================================================================*/ #}

    jQueryNuvem(document).on("click", ".js-accordion-toggle", function(e) {
        e.preventDefault();
        if(jQueryNuvem(this).hasClass("js-accordion-show-only")){
            jQueryNuvem(this).hide();
        }else{
            jQueryNuvem(this).find(".js-accordion-toggle-inactive").toggle();
            jQueryNuvem(this).find(".js-accordion-toggle-active").toggle();
        }
        jQueryNuvem(this).prev(".js-accordion-container").slideToggle();
    });

	{#/*============================================================================
      #Header and nav
    ==============================================================================*/ #}

    {# /* // Header */ #}

    {% if template == 'home' and settings.head_transparent %}
        {% if settings.slider and settings.slider is not empty %}

            var $swiper_height = window.innerHeight - 100;

            document.addEventListener("scroll", function() {
                if (document.documentElement.scrollTop > $swiper_height ) {
                    jQueryNuvem(".js-head-main").removeClass("head-transparent");
                } else {
                    jQueryNuvem(".js-head-main").addClass("head-transparent");
                }
            });

        {% endif %}
    {% endif %}

    {# /* // Nav */ #}

        var $top_nav = jQueryNuvem(".js-mobile-nav");
        var $page_main_content = jQueryNuvem(".js-main-content");
        var $search_backdrop = jQueryNuvem(".js-search-backdrop");

        $top_nav.addClass("move-down").removeClass("move-up");


        {# Nav subitems #}

        jQueryNuvem(".js-toggle-page-accordion").on("click", function (e) {
            e.preventDefault();
            jQueryNuvem(e.currentTarget).toggleClass("active").closest(".js-nav-list-toggle-accordion").next(".js-pages-accordion").slideToggle(300);
        });

        {# Focus search #}

        jQueryNuvem(".js-toggle-search").click(function (e) {
            e.preventDefault;
            jQueryNuvem(".js-search-input").each(el => el.focus());
        });


    {# /* // Search suggestions */ #}

        LS.search(jQueryNuvem(".js-search-input"), function (html, count) {
            $search_suggests = jQueryNuvem(this).closest(".js-search-container").next(".js-search-suggest");
            {# PataGang: Alternar conteúdo default/sugestões no overlay #}
            var $overlay = jQueryNuvem(this).closest('.pg-search-overlay');
            var $defaultContent = $overlay.find('.js-pg-search-default-content');

            if (count > 0) {
                $search_suggests.html(html).show();
                if ($defaultContent.length) $defaultContent.hide();
            } else {
                $search_suggests.hide();
                if ($defaultContent.length) $defaultContent.show();
            }
            if (jQueryNuvem(this).val().length == 0) {
                $search_suggests.hide();
                if ($defaultContent.length) $defaultContent.show();
            }
        }, {
            snipplet: 'header/header-search-results.tpl'
        });

        if (window.innerWidth > 768) {

            {# Hide search suggestions if user click outside results #}

            jQueryNuvem("body").on("click", function (e) {
                if (!jQueryNuvem(e.target).closest('.pg-search-overlay').length) {
                    jQueryNuvem(".js-search-suggest").hide();
                }
            });

            {# Maintain search suggestions visibility if user click on links inside #}

            jQueryNuvem(document).on("click", ".js-search-suggest a", function () {
                jQueryNuvem(".js-search-suggest").show();
            });
        }

        jQueryNuvem(".js-search-suggest").on("click", ".js-search-suggest-all-link", function (e) {
            e.preventDefault();
            $this_closest_form = jQueryNuvem(this).closest(".js-search-suggest").prev(".js-search-form");
            $this_closest_form.submit();
        });

    {# /* // Lang select */ #}


    changeLang = function(element) {
        var selected_country_url = element.find("option").filter((el) => el.selected).attr("data-country-url");
        location.href = selected_country_url;
    };

    jQueryNuvem('.js-lang-select').on("change", function (e) {
        lang_select_option = jQueryNuvem(this);

        changeLang(lang_select_option);
    });

	{#/*============================================================================
	  #Sliders
	==============================================================================*/ #}

	{% if template == 'home' %}

		{# /* // Home slider */ #}

        var width = window.innerWidth;
        if (width > 767) {
            var slider_autoplay = {delay: 6000,};
        } else {
            var slider_autoplay = false;
        }

        window.homeSlider = {
            getAutoRotation: function() {
                return slider_autoplay;
            },
            updateSlides: function(slides) {
                homeSwiper.removeAllSlides();
                slides.forEach(function(aSlide){
                    homeSwiper.appendSlide(
                        '<div class="swiper-slide slide-container">' +
                            (aSlide.link ? '<a href="' + aSlide.link + '">' : '' ) +
                                '<img src="' + aSlide.src + '" class="slider-image"/>' +
                                '<div class="swiper-text swiper-' + aSlide.color + '">' +
                                    (aSlide.title ? '<div class="swiper-title">' + aSlide.title + '</div>' : '' ) +
                                    (aSlide.description ? '<div class="swiper-description mb-3">' + aSlide.description + '</div>' : '' ) +
                                    (aSlide.button && aSlide.link ? '<div class="btn btn-primary d-inline-block mt-3">' + aSlide.button + '</div>' : '' ) +
                                '</div>' +
                            (aSlide.link ? '</a>' : '' ) +
                        '</div>'
                    );
                });
                if(!slides.length){
                    jQueryNuvem(".js-home-main-slider-container").addClass("hidden");
                    jQueryNuvem(".js-home-empty-slider-container").removeClass("hidden");
                    jQueryNuvem(".js-home-mobile-slider-visibility").removeClass("d-md-none");
                    {% if has_mobile_slider %}
                        jQueryNuvem(".js-home-main-slider-visibility").removeClass("d-none d-md-block");
                        homeMobileSwiper.update();
                    {% endif %}
                }else{
                    jQueryNuvem(".js-home-main-slider-container").removeClass("hidden");
                    jQueryNuvem(".js-home-empty-slider-container").addClass("hidden");
                    jQueryNuvem(".js-home-mobile-slider-visibility").addClass("d-md-none");
                    {% if has_mobile_slider %}
                        jQueryNuvem(".js-home-main-slider-visibility").addClass("d-none d-md-block");
                    {% endif %}
                }
            },
            changeAutoRotation: function(){

            },
        };

        var preloadImagesValue = false;
        var lazyValue = true;
        var loopValue = true;
        var watchOverflowValue = true;
        var paginationClickableValue = true;

        var homeSwiper = null;
        createSwiper(
            '.js-home-slider',
            {
                lazy: lazyValue,
                preloadImages: preloadImagesValue,
                {% if settings.slider | length > 1 %}
                    loop: loopValue,
                {% endif %}
                autoplay: slider_autoplay,
                watchOverflow: watchOverflowValue,
                pagination: {
                    el: '.js-swiper-home-pagination',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next',
                    prevEl: '.js-swiper-home-prev',
                },
            },
            function(swiperInstance) {
                homeSwiper = swiperInstance;
            }
        );

        var homeMobileSwiper = null;
        createSwiper(
            '.js-home-slider-mobile',
            {
                lazy: lazyValue,
                preloadImages: preloadImagesValue,
                {% if settings.slider_mobile | length > 1 %}
                    loop: loopValue,
                {% endif %}
                autoplay: slider_autoplay,
                watchOverflow: watchOverflowValue,
                pagination: {
                    el: '.js-swiper-home-pagination-mobile',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next-mobile',
                    prevEl: '.js-swiper-home-prev-mobile',
                },
            },
            function(swiperInstance) {
                homeMobileSwiper = swiperInstance;
            }
        );

        {% if sections.primary.products %}

            {% if settings.product_color_variants or settings.quick_shop %}

                {# Duplicate cloned slide elements for quickshop or colors forms #}

                updateClonedItemsIDs = function(element){
                    jQueryNuvem(element).each(function(el) {
                        var $this = jQueryNuvem(el);
                        var slide_index = $this.attr("data-swiper-slide-index");
                        var clone_quick_id = $this.find(".js-quickshop-container").attr("data-quickshop-id");
                        var clone_product_id = $this.attr("data-product-id");
                        $this.attr("data-product-id" , clone_product_id + "-clone-" + slide_index);
                        $this.find(".js-quickshop-container").attr("data-quickshop-id" , clone_quick_id + "-clone-" + slide_index);
                    });
                };

            {% endif %}

            {% set columns = settings.grid_columns %}
            createSwiper('.js-swiper-featured', {
                lazy: true,
                loop: true,
                spaceBetween: 30,
                threshold: 5,
                watchSlidesVisibility: true,
                slideVisibleClass: 'js-swiper-slide-visible',
                slidesPerView: {% if columns == 2 %}2{% else %}1{% endif %},
                pagination: {
                    el: '.js-swiper-featured-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.js-swiper-featured-next',
                    prevEl: '.js-swiper-featured-prev',
                },
                breakpoints: {
                    640: {
                        slidesPerView: {% if columns == 2 %}4{% else %}3{% endif %},
                    }
                },
                {% if settings.product_color_variants or settings.quick_shop %}
                    on: {
                        init: function () {
                            updateClonedItemsIDs(".js-swiper-featured .js-item-slide.swiper-slide-duplicate");
                        },
                    }
                {% endif %}
            });

        {% endif %}

        {# /* // Coming Soon Carousel - Removido: agora usa scroll nativo via JS inline em home.tpl */ #}

	{% endif %}

    {% if template == 'product' %}

        {# /* // Product Related */ #}


            // Set loop for related products products sliders

            {% set columns = settings.grid_columns %}
            const desktopColumns = {% if columns == 1 %}3{% else %}4{% endif %};

            function calculateRelatedLoopVal(sectionSelector) {
                let productsAmount = jQueryNuvem(sectionSelector).attr("data-related-amount");
                let loopVal = false;
                const applyLoop = (window.innerWidth < 768 && productsAmount > {{ columns }}) || (window.innerWidth > 768 && productsAmount > desktopColumns);

                if (applyLoop) {
                    loopVal = true;
                }

                return loopVal;
            }

            let alternativeLoopVal = calculateRelatedLoopVal(".js-related-products");
            let complementaryLoopVal = calculateRelatedLoopVal(".js-complementary-products");

            {# Alternative products #}

            createSwiper('.js-swiper-related', {
                lazy: true,
                watchOverflow: true,
                loop: alternativeLoopVal,
                centerInsufficientSlides: true,
                spaceBetween: 12,
                slidesPerView: 1,  /* Mobile: 1 card */
                pagination: {
                    el: '.js-swiper-related-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.js-swiper-related-next',
                    prevEl: '.js-swiper-related-prev',
                },
                breakpoints: {
                    480: {
                        slidesPerView: 2,
                        spaceBetween: 16,
                    },
                    768: {
                        slidesPerView: 3,
                        spaceBetween: 20,
                    },
                    1200: {
                        slidesPerView: 4,
                        spaceBetween: 24,
                    }
                }
            });

            {# Complementary products #}

            createSwiper('.js-swiper-complementary', {
                lazy: true,
                watchOverflow: true,
                loop: complementaryLoopVal,
                centerInsufficientSlides: true,
                spaceBetween: 12,
                slidesPerView: 1,  /* Mobile: 1 card */
                pagination: {
                    el: '.js-swiper-complementary-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.js-swiper-complementary-next',
                    prevEl: '.js-swiper-complementary-prev',
                },
                breakpoints: {
                    480: {
                        slidesPerView: 2,
                        spaceBetween: 16,
                    },
                    768: {
                        slidesPerView: 3,
                        spaceBetween: 20,
                    },
                    1200: {
                        slidesPerView: 4,
                        spaceBetween: 24,
                    }
                }
            });

    {% endif %}



	{% set has_banner_services = settings.banner_services %}

	{% if has_banner_services %}

		{# /* // Banner services slider */ #}

        createSwiper('.js-informative-banners', {
            pagination: {
                el: '.js-informative-banners-pagination',
                clickable: true,
            },
        });

    {% endif %}

	{#/*============================================================================
	  #Social
	==============================================================================*/ #}

    {% if template == 'home' %}
        {% set video_url = settings.video_embed %}
    {% elseif template == 'product' and product.video_url %}
        {% set video_url = product.video_url %}
    {% endif %}

    {% if video_url %}

        {# /* // Youtube or Vimeo video for home or each product */ #}

        LS.loadVideo('{{ video_url }}');

    {% endif %}

	{#/*============================================================================
	  #Product grid
	==============================================================================*/ #}

    var $category_controls = jQueryNuvem(".js-category-controls");
    var mobile_nav_height = jQueryNuvem(".js-head-main").outerHeight();

	{% if template == 'category' %}

        {# /* // Fixed category controls */ #}

        if (window.innerWidth < 768) {
            {% if settings.head_fix %}
                $category_controls.css("top" , mobile_nav_height.toString() + 'px');
            {% else %}
                jQueryNuvem(".js-category-controls").css("top" , "0px");
            {% endif %}

            {# Detect if category controls are sticky and add css #}

            var observer = new IntersectionObserver(function(entries) {
                if(entries[0].intersectionRatio === 0)
                    document.querySelector(".js-category-controls").classList.add("is-sticky");
                else if(entries[0].intersectionRatio === 1)
                    document.querySelector(".js-category-controls").classList.remove("is-sticky");
                }, { threshold: [0,1]
            });

            observer.observe(document.querySelector(".js-category-controls-prev"));
        }

        {# /* // Filters */ #}

        jQueryNuvem(document).on("click", ".js-apply-filter, .js-remove-filter", function(e) {
            e.preventDefault();
            var filter_name = jQueryNuvem(this).data('filterName');
            var filter_value = jQueryNuvem(this).data('filterValue');
            if(jQueryNuvem(this).hasClass("js-apply-filter")){
                jQueryNuvem(this).find("[type=checkbox]").prop("checked", true);
                LS.urlAddParam(
                    filter_name,
                    filter_value,
                    true
                );
            }else{
                jQueryNuvem(this).find("[type=checkbox]").prop("checked", false);
                LS.urlRemoveParam(
                    filter_name,
                    filter_value
                );
            }

            {# Toggle class to avoid adding double parameters in case of double click and show applying changes feedback #}

            if (jQueryNuvem(this).hasClass("js-filter-checkbox")){
                if (window.innerWidth < 768) {
                    jQueryNuvem(".js-filters-overlay").show();
                    if(jQueryNuvem(this).hasClass("js-apply-filter")){
                        jQueryNuvem(".js-applying-filter").show();
                    }else{
                        jQueryNuvem(".js-removing-filter").show();
                    }
                }
                jQueryNuvem(this).toggleClass("js-apply-filter js-remove-filter");
            }
        });

        jQueryNuvem(document).on("click", ".js-remove-all-filters", function(e) {
            e.preventDefault();
            LS.urlRemoveAllParams();
        });

	{% endif %}

    {% set has_item_slider = settings.product_item_slider %}

    {% if template == 'category' or template == 'search' %}

        {# /* // Product item slider */ #}

        function updateItemSliderElementsPosition(selector){
            const $productContainer = selector.closest('.js-product-container');
            const $itemColors = $productContainer.find('.js-item-colors');
            const $itemPagination = $productContainer.find('.js-product-item-slider-pagination-private');
            if($itemColors.length){
                $itemPagination.addClass('mb-4');
            }
        }

        {% if has_item_slider %}

            LS.productItemSlider({
                pagination_type: 'fraction',
                onInit: function(){
                    updateItemSliderElementsPosition(jQueryNuvem(this.el));
                }
            });

        {% endif %}

        !function() {

            {# /* // Infinite scroll */ #}

            {% if pages.current == 1 and not pages.is_last %}
                LS.hybridScroll({
                    productGridSelector: '.js-product-table',
                    spinnerSelector: '#js-infinite-scroll-spinner',
                    loadMoreButtonSelector: '.js-load-more',
                    hideWhileScrollingSelector: ".js-hide-footer-while-scrolling",
                    productsBeforeLoadMoreButton: 50,
                    productsPerPage: 12,
                    {% if has_item_slider %}
                        afterLoaded: function(){
                            LS.productItemSlider({
                                pagination_type: 'fraction',
                                onInit: function(){
                                    updateItemSliderElementsPosition(jQueryNuvem(this.el));
                                }
                            });
                        },
                    {% endif %}
                });
            {% endif %}
        }();

	{% endif %}

    	{# Story 8.5 Phase 2: #Product detail functions moved to modules/product-functions.js #}

		{# Story 8.5 Phase 2: #Cart moved to modules/cart-functions.js #}

		{# Story 8.5 Phase 2: #Shipping calculator moved to modules/shipping-functions.js #}