{#/*============================================================================
style.css

    -This file contains all the theme non critical styles wich will be loaded asynchronously
    -Rest of styling can be found in:
      --static/css/style-colors.scss.tpl --> For color and font styles related to config/settings.txt
      --static/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

    LAST UPDATED: 2026-03-21 17:51 — Blog CSS adjustments (margin-top: 40px + flex alignment) [v1.5.8 DEPLOY]
==============================================================================*/#}

{#/*============================================================================
  Table of Contents

  #Components
    // Margin and Padding
    // Mixins
    // Animations
    // Buttons
    // Forms
    // Icons
    // Alerts and Notifications
    // Modals
    // Tabs
    // Cards
    // Captcha
  #Header and nav
    // Nav
    // Search
  #Footer
    // Nav
    // Newsletter
  #Home page
    // Instafeed
    // Banners
    // Placeholder
  #Product grid
    // Filters
  #Product detail
  	// Image
  	// Form and info
  #Media queries

    // Min width 768px
      //// Components
      //// Footer
  #Critical path utilities

==============================================================================*/#}

{#/*============================================================================
  #Components
==============================================================================*/#}

{# /* // Margin and Padding */ #}

%section-margin {
  margin-bottom: 70px;
}
%element-margin {
  margin-bottom: 35px;
}
%element-margin-small {
  margin-bottom: 20px;
}

{# /* // Mixins */ #}

{# This mixin adds browser prefixes to a CSS property #}

@mixin prefix($property, $value, $prefixes: ()) {
  @each $prefix in $prefixes {
    #{'-' + $prefix + '-' + $property}: $value;
  }
  #{$property}: $value;
}


{# /* // Animations */ #}

.transition-soft {
  @include prefix(transition, all 0.3s ease, webkit ms moz o);
}

.transition-up {
  position: relative;
  top: -8px;
  z-index: 10;
  @include prefix(transition, all 0.5s ease, webkit ms moz o);
  pointer-events: none;
  &-active {
    top: 0;
    opacity: 1;
    z-index: 100;
    pointer-events: all;
  }
}

.beat {
  animation: .8s 2 beat;
}
@keyframes beat {
  0% {
    @include prefix(transform, scale(1), webkit ms moz o);
  }
  25% {
    @include prefix(transform, scale(1.3), webkit ms moz o);
  }
  40% {
    @include prefix(transform, scale(1), webkit ms moz o);
  }
  60% {
    @include prefix(transform, scale(1.3), webkit ms moz o);
  }
  100% {
    @include prefix(transform, scale(1), webkit ms moz o);
  }
}

@keyframes bounceIn{
  0%{
    transform: scale(1) translate3d(0,0,0);
  }
  50%{
    transform: scale(1.2);
  }
  80%{
    transform: scale(0.89);
  }
  100%{
    transform: scale(1) translate3d(0,0,0);
  }
}

{# /* // Buttons */ #}

.btn-transition {
  position: relative;
  overflow: hidden;
  .transition-container {
    position: absolute;
    top: 50%;
    left: 0;
    width: 100%;
    margin-top: -7px;
    opacity: 0;
    text-align: center;
    @include prefix(transition, all 0.5s ease, webkit ms moz o);
    cursor: not-allowed;
    pointer-events: none;
    &.active {
      opacity: 1;
    }
  }
}

{# /* // Forms */ #}

.form-group{
  @extend %element-margin;
  .form-label{
    float: left;
    width: 100%;
    margin-bottom: 10px;
  }
  .alert{
    margin: 10px 0 0 0;
  }
}

.checkbox-container{
  .checkbox {
    position: relative;
    display: block;
    margin-bottom: 15px;
    padding-left: 30px;
    line-height: 20px;
    cursor: pointer;
    @include prefix(user-select, none, webkit ms moz o);

    &-color {
      display: inline-block;
      width: 10px;
      height: 10px;
      margin: 0 0 2px 5px;
      vertical-align: middle;
      border-radius: 100%;
    }

    input {
      display: none;
      &:checked ~ .checkbox-icon:after {
        display: block;
      }
    }

    &-icon {
      position: absolute;
      top: -1px;
      left: 0;
      width: 20px;
      height: 20px;

      &:after {
        position: absolute;
        top: 1px;
        left: 6px;
        display: none;
        width: 7px;
        height: 12px;
        content: '';
        @include prefix(transform, rotate(45deg), webkit ms moz o);
      }
    }
  }
}

.input-clear-content {
  position: absolute;
  right: 0;
  bottom: 7px;
  width: 22px;
  height: 30px;
  padding: 1px;
  cursor: pointer;
  &:before {
    display: block;
    margin: 9px 0 0 5px;
  }
}

.form-select {
  display: block;
  width: 100%;
  &:focus{
    outline:0;
  }
  &::-ms-expand {
    display: none;
  }
  .form-select-icon {
    @include prefix(transition, all 0.2s ease, webkit ms moz o);
  }

  &.open .form-select-icon {
    @include prefix(transform, translateY(-50%) rotate(180deg), webkit ms moz o);
  }
}

.form-select-options {
  position: absolute;
  top: 100%;
  left: 0;
  z-index: 200;
  width: 100%;
  max-height: 200px;
  margin-top: 5px;
  list-style: none;
  overflow-y: auto;
  @include prefix(transition, all 0.2s ease, webkit ms moz o);
  opacity: 0;
  &.open {
    opacity: 1;
  }
}

.form-select-option {
  padding: 12px;
  font-size: var(--font-small);
  @include prefix(transition, all 0.4s ease, webkit ms moz o);
  cursor: pointer;
}

{# /* // Newsletter */ #}

.newsletter form {
  position: relative;
  .newsletter-btn {
    position: absolute;
    top: 0;
    right: 0;
    padding: 10px;
  }
}

{# /* Lists */ #}

.list-readonly{
  .radio-button-label{
    width: 100%;
    padding-left: 0;
    cursor: default;
  }
  .list-item{
    position: relative;
    width: 100%;
    float: left;
    padding: 15px;
    clear: both;
    cursor: default;
    .radio-button-content{
      padding: 0;
    }
  }
}

{# /* Disabled controls */ #}

input,
select,
textarea{
  &[disabled],
  &[disabled]:hover,
  &[readonly],
  &[readonly]:hover{
    background-color: #DDD;
    cursor: not-allowed;
  }
}

{# /* // Icons */ #}

.social-icon {
  display: inline-block;
  padding: 8px;
  font-size: 22px;
}

{# /* // Alerts and notifications */ #}

.alert {
  clear: both;
  padding: 8px;
  border: 1px solid;
  text-align: center;
  @extend %element-margin;
}

.subscription-btn-alert {
  margin-top: -15px;
}

.notification-hidden{
  transition: all .1s cubic-bezier(.16,.68,.43,.99);
  @include prefix(transform, rotatex(90deg), webkit ms moz o);
  pointer-events: none;
}
.notification-visible{
  transition: all .5s cubic-bezier(.16,.68,.43,.99);
  @include prefix(transform, rotatex(0deg), webkit ms moz o);
}
.notification-close {
  position: absolute;
  top: 5px;
  right: 10px;
  z-index: 1;
  font-size: 20px;
  cursor: pointer;
}

/* // Progress bar */

.bar-progress {
  position: relative;
  height: 7px;
  .bar-progress-active {
    width: 0%;
    height: 7px;
  }
}

.ship-free-rest-message {
  position: relative;
  height: 45px;
  .ship-free-rest-text {
    position: absolute;
    top: -5px;
    width: 100%;
    text-align: center;
    line-height: 36px;
    opacity: 0;
  }
  &.success .bar-progress-success,
  &.amount .bar-progress-amount,
  &.condition .bar-progress-condition {
    top: 0;
    opacity: 1;
  }
}

{# /* // Modals */ #}

.modal {
  position: fixed;
  top: 0;
  display: block;
  width: 80%;
  height: 100%;
  padding: 10px;
  -webkit-overflow-scrolling: touch;
  overflow-y: auto;
  transition: all .2s cubic-bezier(.16,.68,.43,.99);
  z-index: 20000;
  &-img-full{
    max-width: 100%;
    max-height: 190px;
  }
  &-header{
    width: calc(100% + 20px);
    margin: -10px 0 10px -20px;
    padding: 10px 15px 10px 25px;
    font-size: 20px;
  }
  &-footer{
    padding: 10px 0;
    clear: both;
  }
  &-with-fixed-footer {
    display: flex;
    flex-direction: column;
    height: 100%;
    .modal-scrollable-area {
      height: 100%;
      overflow: auto;
    }
  }
  &-full {
    width: 100%;
  }
  &-docked-md{
    width: 100%;
  }
  &-docked-small{
    width: 80%;
  }
  &-top{
    top: -100%;
    left: 0;
  }
  &-bottom{
    top: 100%;
    left: 0;
  }
  &-left{
    left: -100%;
  }
  &-right{
    right: -100%;
  }
  &-centered{
    height: 100%;
    width: 100%;
    &-small{
      left: 50%;
      width: 80%;
      height: auto;
      @include prefix(transform, translate(-50%, 0), webkit ms moz o);
      .modal-body{
        min-height: 150px;
        max-height: 400px;
        overflow: auto;
      }
    }
    &-md.modal-show {
        left: 50%;
        transform: translateX(-50%);
        &.modal-bottom-md,
        &.modal-bottom {
          top: 50%;
          bottom: auto;
          left: 50%;
          height: fit-content;
          transform: translate(-50%, -50%);
        }
      }
  }
  &-top.modal-show,
  &-bottom.modal-show {
    top: 0;
    &.modal-centered-small{
      top: 50%;
      @include prefix(transform, translate(-50%, -50%), webkit ms moz o);
    }
  }
  &-bottom-sheet {
    top: initial;
    bottom: -100%;
    height: auto;
    &.modal-show {
      top: initial;
      bottom: 0;
      height: auto;
    }
  }
  &-left.modal-show {
    left: 0;
  }
  &-right.modal-show {
    right: 0;
  }
  &-close {
    display: inline-block;
    padding: 1px 5px 5px 0;
    margin-right: 5px;
    font-size: 20px;
    vertical-align: middle;
    cursor: pointer;
    border: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background: none;
  }
  .tab-group{
    margin:  0 -10px 20px -10px;
  }
}

.modal-overlay{
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: #00000047;
  z-index: 10000;
  &.modal-zindex-top{
    z-index: 20000;
  }
}

{# /* // Tabs */ #}


.tab-group{
  width: 100vw;
  padding: 0;
  overflow-x: scroll;
  white-space: nowrap;
  .tab{
    display: inline-flex;
    float: none;
    &-link{
      float: left;
      padding: 10px;
      text-align: center;
      text-transform: uppercase;
    }
  }
}

.tab-panel:not(.active){
  display: none;
}
.tab-panel.active{
  display: block;
}

{# /* // Cards */ #}

.card {
	position: relative;
	display: -ms-flexbox;
	display: flex;
	margin-bottom: 20px;
	-ms-flex-direction: column;
	flex-direction: column;
	min-width: 0;
	word-wrap: break-word;
	background-clip: border-box;
}

.card-body {
	-ms-flex: 1 1 auto;
	flex: 1 1 auto;
	padding: 15px;
}

.card-header {
	padding: 15px 15px 0 15px;
	margin-bottom: 0;
}

.card-footer {
	padding: 0 15px 15px 15px;
}

{# /* // Captcha */ #}

.g-recaptcha {
  margin-bottom: 24px;
}

.g-recaptcha > div {
  margin: 0 auto;
}

.grecaptcha-badge {
  bottom: 100px !important;
}

{#/*============================================================================
  #Header and nav
==============================================================================*/#}

{# /* // Nav */ #}

.modal-full-width {
  width: 100%;
  max-width: 100%;
}
.modal-body-scrollable-auto .modal-body {
  max-height: calc(100vh - 100px);
  overflow-y: auto;
}

.modal-nav-hamburger {
  text-align: center;
  .modal-header {
      width: 100%;
      margin: 25px 0 -10px 0;
      .modal-close {
        margin: 0;
        padding: 5px;
      }
  }
}

.nav-primary {
  padding: 0 0 80px;
  .nav-list {
    padding: 10px 0 10px;
    list-style: none;
    .item-with-subitems {
      position: relative;
    }
    .nav-list-link {
      display: block;
      padding: 15px;
      font-size: 18px;
      font-weight: 700;
      border-bottom: 0;
      }
    &-arrow {
      position: absolute;
      top: 15px;
      right: 20px;
      font-size: 14px;
      cursor: pointer;
    }
    .selected .nav-list-arrow  {
      transform: rotate(90deg);
    }
    .list-subitems {
      padding: 0;
      list-style: none;
      .nav-list-link {
        font-weight: 400;
      }
    }
  }

}

.nav-account {
  margin: 10px -15px -10px -15px;
  padding: 0;
  list-style: none;
  .nav-accounts-item {
    display: inline-block;
    margin: 10px;
    font-size: 14px;
  }
}

.hamburger-panel{
    box-shadow: none;
    .btn-hamburger-close {
        right: 15px;
        top: 6px;
        font-size: 18px;
    }
    .list-items {
        padding: 45px 0 10px;
        .hamburger-panel-link {
            display: block;
            padding: 20px;
            letter-spacing: 1px;
            font-weight: 400;
            border-bottom: 0;
        }
        .list-subitems {
            padding: 0;
        }
    }
    .hamburger-panel-arrow {
        font-size: 12px;
        &.selected {
            transform: rotate(90deg);
        }
    }
    .hamburger-panel-first-row {
        background: none;
        .mobile-accounts{
            padding: 0 12px;
            .mobile-accounts-item {
                width: auto;
                display: inline-block;
                .mobile-accounts-link {
                    padding: 10px 5px;
                    font-size: 12px;
                    opacity: 0.6;
                }
                &:first-child a:after {
                position: relative;
                right: -7px;
                content: "|";
                }
            }
        }
    }
  &-arrow{
    top: 15px;
    right: 10px;
    margin-top: -10px;
    &.selected svg{
      transform-origin: center;
      transform: rotate(180deg);
      -webkit-transform: rotate(180deg);
      -moz-transform: rotate(180deg);
      -ms-transform: rotate(180deg);
      -o-transform: rotate(180deg);
    }
  }
}

/* ============================================
   PATAGANG NAVIGATION DRAWER - MOVIDO PARA CRITICAL
   Os estilos foram movidos para style-critical.tpl para garantir
   que estejam disponiveis imediatamente ao abrir o drawer
   ============================================ */

/* ============================================
   FIM PATAGANG NAVIGATION DRAWER
   ============================================ */

.nav-dropdown-content:hover,
.nav-dropdown:hover .nav-dropdown-content {
  visibility: visible;
  opacity: 1;
  transition-delay: 0s;
}

.desktop-dropdown-small {
  top: calc(100% - 10px);
  left: -10px;
  z-index: 9;
  width: 150px;
  padding: 15px;
}

{# /* // Search */ #}

.search-input {
  padding-right: 30px;
}

.search-input[type="search"]::-webkit-search-cancel-button {
  -webkit-appearance:none
}

.search-input-submit {
  position: absolute;
  top: 5px;
  right: 0;
  font-size: 18px;
  background: none;
  border: 0;
}

.search-suggest-list {
  margin: 0 0 10px 0;
  padding: 0;
}

.search-suggest-item {
  padding: 10px 15px;
  list-style: none;
}

.search-suggest-text,
.search-suggest-name {
  margin-bottom: 5px;
  line-height: 18px;
}
.search-suggest-icon {
  margin: 0 10px;
  font-size: 14px;
}

{#/*============================================================================
  #Footer
==============================================================================*/#}

footer {
  margin-top: 20px;
  padding: 30px 0;
}

{# /* // Nav */ #}

.footer-menu {
  list-style: none;
  .footer-menu-item{
  }
}

{# /* // Newsletter */ #}

.newsletter {
  form {
    position: relative;
    .newsletter-btn {
      position: absolute;
      top: 0;
      right: 0px;
      padding: 10px;
    }
  }
}

.footer-payments-shipping-logos{
  img {
    width: auto;
    max-height: 35px;
    margin: 2px;
    padding: 5px;
    border: 1px solid #eaeaea;
  }
}

.powered-by-text {
  display: inline-block; }

.powered-by-logo {
  display: inline-block;
  width: 160px;
}

.footer-logo {
  img {
    max-width: 100px;
    margin: 2px;
    padding: 5px;
  }
}

{#/*============================================================================
  #Home Page
==============================================================================*/#}

.section-slider-home,
.section-banners-home,
.section-video-home,
.section-home-modules,
.section-featured-home,
.section-welcome-home {
  @extend %section-margin;
}

{# /* // Instafeed */ #}

.instafeed-user {
	display: inline-block;
	margin: 0 0 0 5px;
  line-height: 24px;
  vertical-align: top;
}

.instafeed-link {
  position: relative;
  display: block;
  padding-top: 100%;
  overflow: hidden;
  &:hover,
  &:focus {
    .instafeed-img {
      @include prefix(transform, scale(1.03), webkit ms moz o);
    }
    .instafeed-info {
      opacity: 1;
    }
  }
  .instafeed-img {
    position: absolute;
    top: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    @include prefix(transition, all 0.8s ease, webkit ms moz o);
  }
  .instafeed-info {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    padding: 0;
    text-align: center;
    opacity: 0;
    @include prefix(transition, all 0.8s ease, webkit ms moz o);
    .instafeed-info-item {
      display: inline-block;
      margin-top: 45%;
    }
  }
}

{# /* // Banners */ #}

.textbanner {
  .textbanner-image.overlay {
    @include prefix(transition, all 0.8s ease, webkit ms moz o);
  }
  &:hover .textbanner-image.overlay,
  &:focus .textbanner-image.overlay {
    @include prefix(transform, scale(1.03), webkit ms moz o);
  }
}

{# /* // Placeholder */ #}

.placeholder-overlay {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 9;
  width: 100%;
  height: 100%;
}

.placeholder-info {
  position: relative;
  top: 50%;
  left: 50%;
  width: 330px;
  padding: 30px 25px;
  text-align: center;
  line-height: 18px;
  transform: translate(-50%, -50%);
  box-sizing: border-box;
  .placeholder-description {
    margin: 20px 0;
  }
}

{#/*============================================================================
  #Product grid
==============================================================================*/#}

{# /* // Filters */ #}

.filters-overlay {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 30000;
  width: 100%;
  height: 100%;
  .filters-updating-message {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 80%;
    text-align: center;
    @include prefix(transform, translate(-50%, -50%), webkit ms moz o);
    * {
      font-size: 24px;
      font-weight: normal;
    }
  }
}

.filter-input-price-container {
  position: relative;
  display: inline-block;
  width: 85px;
  margin-right: 5px;
  .filter-input-price {
    padding: 10px 25px 10px 10px;
  }
}

{#/*============================================================================
  #Product detail
==============================================================================*/#}

{# /* // Image */ #}

.fancybox__container .has-inline .fancybox__content {
  width: 100%;
  height: calc(100% - 20px);
  padding: 0;
  @include prefix(transform, translateY(20px), webkit ms moz o);
  background: transparent;
  .fancybox-close-small {
    {# Hardcoded neutral color to match non iframe fancybox modal #}
    color: #ccc!important;
  }
}

.fancybox__container .fancybox__slide.has-inline::before {
  display: none
}

.fancybox-toolbar {
  opacity: 1!important;
  visibility: visible!important;
  .fancybox-button {
    display: none!important;
    &.fancybox-button--close{
      display: block!important;
    }
  }
}

.fancybox-close-small {
  display: none!important;
}

.carousel{position:relative;box-sizing:border-box}.carousel *,.carousel *:before,.carousel *:after{box-sizing:inherit}.carousel.is-draggable{cursor:move;cursor:grab}.carousel.is-dragging{cursor:move;cursor:grabbing}.carousel__viewport{position:relative;overflow:hidden;max-width:100%;max-height:100%}.carousel__track{display:flex}.carousel__slide{flex:0 0 auto;width:var(--carousel-slide-width, 60%);max-width:100%;padding:1rem;position:relative;overflow-x:hidden;overflow-y:auto;overscroll-behavior:contain}.has-dots{margin-bottom:calc(0.5rem + 22px)}.carousel__dots{margin:0 auto;padding:0;position:absolute;top:calc(100% + 0.5rem);left:0;right:0;display:flex;justify-content:center;list-style:none;user-select:none}.carousel__dots .carousel__dot{margin:0;padding:0;display:block;position:relative;width:22px;height:22px;cursor:pointer}.carousel__dots .carousel__dot:after{content:"";width:8px;height:8px;border-radius:50%;position:absolute;top:50%;left:50%;transform:translate(-50%, -50%);background-color:currentColor;opacity:.25;transition:opacity .15s ease-in-out}.carousel__dots .carousel__dot.is-selected:after{opacity:1}.carousel__button{width:var(--carousel-button-width, 48px);height:var(--carousel-button-height, 48px);padding:0;border:0;display:flex;justify-content:center;align-items:center;pointer-events:all;cursor:pointer;color:var(--carousel-button-color, currentColor);background:var(--carousel-button-bg, transparent);border-radius:var(--carousel-button-border-radius, 50%);box-shadow:var(--carousel-button-shadow, none);transition:opacity .15s ease}.carousel__button.is-prev,.carousel__button.is-next{position:absolute;top:50%;transform:translateY(-50%)}.carousel__button.is-prev{left:10px}.carousel__button.is-next{right:10px}.carousel__button[disabled]{cursor:default;opacity:.3}.carousel__button svg{width:var(--carousel-button-svg-width, 50%);height:var(--carousel-button-svg-height, 50%);fill:none;stroke:currentColor;stroke-width:var(--carousel-button-svg-stroke-width, 1.5);stroke-linejoin:bevel;stroke-linecap:round;filter:var(--carousel-button-svg-filter, none);pointer-events:none}html.with-fancybox{scroll-behavior:auto}body.compensate-for-scrollbar{overflow:hidden !important;touch-action:none}.fancybox__container{position:fixed;top:0;left:0;bottom:0;right:0;direction:ltr;margin:0;padding:env(safe-area-inset-top, 0px) env(safe-area-inset-right, 0px) env(safe-area-inset-bottom, 0px) env(safe-area-inset-left, 0px);box-sizing:border-box;display:flex;flex-direction:column;color:var(--fancybox-color, #fff);-webkit-tap-highlight-color:rgba(0,0,0,0);overflow:hidden;z-index:1050;outline:none;transform-origin:top left;--carousel-button-width: 48px;--carousel-button-height: 48px;--carousel-button-svg-width: 24px;--carousel-button-svg-height: 24px;--carousel-button-svg-stroke-width: 2.5;--carousel-button-svg-filter: drop-shadow(1px 1px 1px rgba(0, 0, 0, 0.4))}.fancybox__container *,.fancybox__container *::before,.fancybox__container *::after{box-sizing:inherit}.fancybox__container :focus{outline:none}body:not(.is-using-mouse) .fancybox__container :focus{box-shadow:0 0 0 1px #fff,0 0 0 2px var(--fancybox-accent-color, rgba(1, 210, 232, 0.94))}@media all and (min-width: 1024px){.fancybox__container{--carousel-button-width:48px;--carousel-button-height:48px;--carousel-button-svg-width:27px;--carousel-button-svg-height:27px}}.fancybox__backdrop{position:absolute;top:0;right:0;bottom:0;left:0;z-index:-1;background:var(--fancybox-bg, rgba(24, 24, 27, 0.92))}.fancybox__carousel{position:relative;flex:1 1 auto;min-height:0;height:100%;z-index:10}.fancybox__carousel.has-dots{margin-bottom:calc(0.5rem + 22px)}.fancybox__viewport{position:relative;width:100%;height:100%;overflow:visible;cursor:default}.fancybox__track{display:flex;height:100%}.fancybox__slide{flex:0 0 auto;width:100%;max-width:100%;margin:0;padding:48px 8px 8px 8px;position:relative;overscroll-behavior:contain;display:flex;flex-direction:column;outline:0;overflow:auto;--carousel-button-width: 36px;--carousel-button-height: 36px;--carousel-button-svg-width: 22px;--carousel-button-svg-height: 22px}.fancybox__slide::before,.fancybox__slide::after{content:"";flex:0 0 0;margin:auto}@media all and (min-width: 1024px){.fancybox__slide{padding:64px 100px}}.fancybox__content{margin:0 env(safe-area-inset-right, 0px) 0 env(safe-area-inset-left, 0px);padding:36px;color:var(--fancybox-content-color, #374151);background:var(--fancybox-content-bg, #fff);position:relative;align-self:center;display:flex;flex-direction:column;z-index:20}.fancybox__content :focus:not(.carousel__button.is-close){outline:thin dotted;box-shadow:none}.fancybox__caption{align-self:center;max-width:100%;margin:0;padding:1rem 0 0 0;line-height:1.375;color:var(--fancybox-color, currentColor);visibility:visible;cursor:auto;flex-shrink:0;overflow-wrap:anywhere}.is-loading .fancybox__caption{visibility:hidden}.fancybox__container>.carousel__dots{top:100%;color:var(--fancybox-color, #fff)}.fancybox__nav .carousel__button{z-index:40}.fancybox__nav .carousel__button.is-next{right:8px}@media all and (min-width: 1024px){.fancybox__nav .carousel__button.is-next{right:40px}}.fancybox__nav .carousel__button.is-prev{left:8px}@media all and (min-width: 1024px){.fancybox__nav .carousel__button.is-prev{left:40px}}.carousel__button.is-close{position:absolute;top:8px;right:8px;top:calc(env(safe-area-inset-top, 0px) + 8px);right:calc(env(safe-area-inset-right, 0px) + 8px);z-index:40}@media all and (min-width: 1024px){.carousel__button.is-close{right:40px}}.fancybox__content>.carousel__button.is-close{position:absolute;top:-40px;right:0;color:var(--fancybox-color, #fff)}.fancybox__no-click,.fancybox__no-click button{pointer-events:none}.fancybox__spinner{position:absolute;top:50%;left:50%;transform:translate(-50%, -50%);width:50px;height:50px;color:var(--fancybox-color, currentColor)}.fancybox__slide .fancybox__spinner{cursor:pointer;z-index:1053}.fancybox__spinner svg{animation:fancybox-rotate 2s linear infinite;transform-origin:center center;position:absolute;top:0;right:0;bottom:0;left:0;margin:auto;width:100%;height:100%}.fancybox__spinner svg circle{fill:none;stroke-width:2.75;stroke-miterlimit:10;stroke-dasharray:1,200;stroke-dashoffset:0;animation:fancybox-dash 1.5s ease-in-out infinite;stroke-linecap:round;stroke:currentColor}@keyframes fancybox-rotate{100%{transform:rotate(360deg)}}@keyframes fancybox-dash{0%{stroke-dasharray:1,200;stroke-dashoffset:0}50%{stroke-dasharray:89,200;stroke-dashoffset:-35px}100%{stroke-dasharray:89,200;stroke-dashoffset:-124px}}.fancybox__backdrop,.fancybox__caption,.fancybox__nav,.carousel__dots,.carousel__button.is-close{opacity:var(--fancybox-opacity, 1)}.fancybox__container.is-animated[aria-hidden=false] .fancybox__backdrop,.fancybox__container.is-animated[aria-hidden=false] .fancybox__caption,.fancybox__container.is-animated[aria-hidden=false] .fancybox__nav,.fancybox__container.is-animated[aria-hidden=false] .carousel__dots,.fancybox__container.is-animated[aria-hidden=false] .carousel__button.is-close{animation:.15s ease backwards fancybox-fadeIn}.fancybox__container.is-animated.is-closing .fancybox__backdrop,.fancybox__container.is-animated.is-closing .fancybox__caption,.fancybox__container.is-animated.is-closing .fancybox__nav,.fancybox__container.is-animated.is-closing .carousel__dots,.fancybox__container.is-animated.is-closing .carousel__button.is-close{animation:.15s ease both fancybox-fadeOut}.fancybox-fadeIn{animation:.15s ease both fancybox-fadeIn}.fancybox-fadeOut{animation:.1s ease both fancybox-fadeOut}.fancybox-zoomInUp{animation:.2s ease both fancybox-zoomInUp}.fancybox-zoomOutDown{animation:.15s ease both fancybox-zoomOutDown}.fancybox-throwOutUp{animation:.15s ease both fancybox-throwOutUp}.fancybox-throwOutDown{animation:.15s ease both fancybox-throwOutDown}@keyframes fancybox-fadeIn{from{opacity:0}to{opacity:1}}@keyframes fancybox-fadeOut{to{opacity:0}}@keyframes fancybox-zoomInUp{from{transform:scale(0.97) translate3d(0, 16px, 0);opacity:0}to{transform:scale(1) translate3d(0, 0, 0);opacity:1}}@keyframes fancybox-zoomOutDown{to{transform:scale(0.97) translate3d(0, 16px, 0);opacity:0}}@keyframes fancybox-throwOutUp{to{transform:translate3d(0, -30%, 0);opacity:0}}@keyframes fancybox-throwOutDown{to{transform:translate3d(0, 30%, 0);opacity:0}}.fancybox__carousel .carousel__slide{scrollbar-width:thin;scrollbar-color:#ccc rgba(255,255,255,.1)}.fancybox__carousel .carousel__slide::-webkit-scrollbar{width:8px;height:8px}.fancybox__carousel .carousel__slide::-webkit-scrollbar-track{background-color:rgba(255,255,255,.1)}.fancybox__carousel .carousel__slide::-webkit-scrollbar-thumb{background-color:#ccc;border-radius:2px;box-shadow:inset 0 0 4px rgba(0,0,0,.2)}.fancybox__carousel.is-draggable .fancybox__slide,.fancybox__carousel.is-draggable .fancybox__slide .fancybox__content{cursor:move;cursor:grab}.fancybox__carousel.is-dragging .fancybox__slide,.fancybox__carousel.is-dragging .fancybox__slide .fancybox__content{cursor:move;cursor:grabbing}.fancybox__carousel .fancybox__slide .fancybox__content{cursor:auto}.fancybox__carousel .fancybox__slide.can-zoom_in .fancybox__content{cursor:zoom-in}.fancybox__carousel .fancybox__slide.can-zoom_out .fancybox__content{cursor:zoom-out}.fancybox__carousel .fancybox__slide.is-draggable .fancybox__content{cursor:move;cursor:grab}.fancybox__carousel .fancybox__slide.is-dragging .fancybox__content{cursor:move;cursor:grabbing}.fancybox__image{transform-origin:0 0;user-select:none;transition:none}.has-image .fancybox__content{padding:0;background:rgba(0,0,0,0);min-height:1px}.is-closing .has-image .fancybox__content{overflow:visible}.has-image[data-image-fit=contain]{overflow:visible;touch-action:none}.has-image[data-image-fit=contain] .fancybox__content{flex-direction:row;flex-wrap:wrap}.has-image[data-image-fit=contain] .fancybox__image{max-width:100%;max-height:100%;object-fit:contain}.has-image[data-image-fit=contain-w]{overflow-x:hidden;overflow-y:auto}.has-image[data-image-fit=contain-w] .fancybox__content{min-height:auto}.has-image[data-image-fit=contain-w] .fancybox__image{max-width:100%;height:auto}.has-image[data-image-fit=cover]{overflow:visible;touch-action:none}.has-image[data-image-fit=cover] .fancybox__content{width:100%;height:100%}.has-image[data-image-fit=cover] .fancybox__image{width:100%;height:100%;object-fit:cover}.fancybox__carousel .fancybox__slide.has-iframe .fancybox__content,.fancybox__carousel .fancybox__slide.has-map .fancybox__content,.fancybox__carousel .fancybox__slide.has-pdf .fancybox__content,.fancybox__carousel .fancybox__slide.has-video .fancybox__content,.fancybox__carousel .fancybox__slide.has-html5video .fancybox__content{max-width:100%;flex-shrink:1;min-height:1px;overflow:visible}.fancybox__carousel .fancybox__slide.has-iframe .fancybox__content,.fancybox__carousel .fancybox__slide.has-map .fancybox__content,.fancybox__carousel .fancybox__slide.has-pdf .fancybox__content{width:100%;height:80%}.fancybox__carousel .fancybox__slide.has-video .fancybox__content,.fancybox__carousel .fancybox__slide.has-html5video .fancybox__content{width:960px;height:540px;max-width:100%;max-height:100%}.fancybox__carousel .fancybox__slide.has-map .fancybox__content,.fancybox__carousel .fancybox__slide.has-pdf .fancybox__content,.fancybox__carousel .fancybox__slide.has-video .fancybox__content,.fancybox__carousel .fancybox__slide.has-html5video .fancybox__content{padding:0;background:rgba(24,24,27,.9);color:#fff}.fancybox__carousel .fancybox__slide.has-map .fancybox__content{background:#e5e3df}.fancybox__html5video,.fancybox__iframe{border:0;display:block;height:100%;width:100%;background:rgba(0,0,0,0)}.fancybox-placeholder{position:absolute;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0, 0, 0, 0);white-space:nowrap;border-width:0}.fancybox__thumbs{flex:0 0 auto;position:relative;padding:0px 3px;opacity:var(--fancybox-opacity, 1)}.fancybox__container.is-animated[aria-hidden=false] .fancybox__thumbs{animation:.15s ease-in backwards fancybox-fadeIn}.fancybox__container.is-animated.is-closing .fancybox__thumbs{opacity:0}.fancybox__thumbs .carousel__slide{flex:0 0 auto;width:var(--fancybox-thumbs-width, 96px);margin:0;padding:8px 3px;box-sizing:content-box;display:flex;align-items:center;justify-content:center;overflow:visible;cursor:pointer}.fancybox__thumbs .carousel__slide .fancybox__thumb::after{content:"";position:absolute;top:0;left:0;right:0;bottom:0;border-width:5px;border-style:solid;border-color:var(--fancybox-accent-color, rgba(34, 213, 233, 0.96));opacity:0;transition:opacity .15s ease;border-radius:var(--fancybox-thumbs-border-radius, 4px)}.fancybox__thumbs .carousel__slide.is-nav-selected .fancybox__thumb::after{opacity:.92}.fancybox__thumbs .carousel__slide>*{pointer-events:none;user-select:none}.fancybox__thumb{position:relative;width:100%;padding-top:calc(100%/(var(--fancybox-thumbs-ratio, 1.5)));background-size:cover;background-position:center center;background-color:rgba(255,255,255,.1);background-repeat:no-repeat;border-radius:var(--fancybox-thumbs-border-radius, 4px)}.fancybox__toolbar{position:absolute;top:0;right:0;left:0;z-index:20;background:linear-gradient(to top, hsla(0deg, 0%, 0%, 0) 0%, hsla(0deg, 0%, 0%, 0.006) 8.1%, hsla(0deg, 0%, 0%, 0.021) 15.5%, hsla(0deg, 0%, 0%, 0.046) 22.5%, hsla(0deg, 0%, 0%, 0.077) 29%, hsla(0deg, 0%, 0%, 0.114) 35.3%, hsla(0deg, 0%, 0%, 0.155) 41.2%, hsla(0deg, 0%, 0%, 0.198) 47.1%, hsla(0deg, 0%, 0%, 0.242) 52.9%, hsla(0deg, 0%, 0%, 0.285) 58.8%, hsla(0deg, 0%, 0%, 0.326) 64.7%, hsla(0deg, 0%, 0%, 0.363) 71%, hsla(0deg, 0%, 0%, 0.394) 77.5%, hsla(0deg, 0%, 0%, 0.419) 84.5%, hsla(0deg, 0%, 0%, 0.434) 91.9%, hsla(0deg, 0%, 0%, 0.44) 100%);padding:0;touch-action:none;display:flex;justify-content:space-between;--carousel-button-svg-width: 20px;--carousel-button-svg-height: 20px;opacity:var(--fancybox-opacity, 1);text-shadow:var(--fancybox-toolbar-text-shadow, 1px 1px 1px rgba(0, 0, 0, 0.4))}@media all and (min-width: 1024px){.fancybox__toolbar{padding:8px}}.fancybox__container.is-animated[aria-hidden=false] .fancybox__toolbar{animation:.15s ease-in backwards fancybox-fadeIn}.fancybox__container.is-animated.is-closing .fancybox__toolbar{opacity:0}.fancybox__toolbar__items{display:flex}.fancybox__toolbar__items--left{margin-right:auto}.fancybox__toolbar__items--center{position:absolute;left:50%;transform:translateX(-50%)}.fancybox__toolbar__items--right{margin-left:auto}@media(max-width: 640px){.fancybox__toolbar__items--center:not(:last-child){display:none}}.fancybox__counter{min-width:72px;padding:0 10px;line-height:var(--carousel-button-height, 48px);text-align:center;font-size:17px;font-variant-numeric:tabular-nums;-webkit-font-smoothing:subpixel-antialiased}.fancybox__progress{background:var(--fancybox-accent-color, rgba(34, 213, 233, 0.96));height:3px;left:0;position:absolute;right:0;top:0;transform:scaleX(0);transform-origin:0;transition-property:transform;transition-timing-function:linear;z-index:30;user-select:none}.fancybox__container:fullscreen::backdrop{opacity:0}.fancybox__button--fullscreen g:nth-child(2){display:none}.fancybox__container:fullscreen .fancybox__button--fullscreen g:nth-child(1){display:none}.fancybox__container:fullscreen .fancybox__button--fullscreen g:nth-child(2){display:block}.fancybox__button--slideshow g:nth-child(2){display:none}.fancybox__container.has-slideshow .fancybox__button--slideshow g:nth-child(1){display:none}.fancybox__container.has-slideshow .fancybox__button--slideshow g:nth-child(2){display:block}

.user-content img {
	max-width: 100%;
	height: auto !important;
}

{# /* // Form and info */ #}

.social-share-button {
  display: inline-block;
  padding: 8px;
  font-size: 22px;
  &:hover,
  &:focus{
    opacity: 0.8;
  }
}

.section-single-product,
.section-fb-comments,
.section-products-related {
  @extend %section-margin;
}

.label-top-left {
  top: 25px;
  left: 25px;
  z-index: 2;
}

.product-image-limited {
  max-height: 320px;
  max-width: 100%;
  object-fit: contain;
}

{#/*============================================================================
  #Cart detail
==============================================================================*/#}


{# /* Table */ #}

.cart-table-row{
  padding: 10px 0;
}

.cart-item{
  position: relative;
  @extend %element-margin;
  &-name{
    float: left;
    width: 100%;
    padding: 0 40px 10px 0;
  }
  &-subtotal{
    float: right;
    margin: 10px 0;
    text-align: right;
    font-weight: normal;
  }
  &-btn{
    padding: 6px;
    display: inline-block;
    background: transparent;
    font-size: 16px;
    opacity: 0.8;
    &:hover{
      opacity: 0.6;
    }
  }
  &-input{
    display: inline-block;
    width: 40px;
    height: 30px;
    font-size: 16px;
    text-align: center;
    -moz-appearance:textfield;
    &::-webkit-outer-spin-button,
    &::-webkit-inner-spin-button{
      -webkit-appearance: none;
    }
  }
  .fa-cog{
    display: none;
  }
  &-spinner{
    display: inline-block;
    width: 40px;
    text-align: center;
  }
  &-delete{
    position: absolute;
    right: 0;
    .btn{
      padding-right:0;
    }
  }
}

.cart-quantity-input-container svg{
  padding: 6px 14px;
}

.cart-unit-price{
  float: left;
  width: 100%;
  margin: 5px 0 2px 0;
}

.cart-promotion-detail{
  float: left;
  width: 65%;
  text-align: left;
}
.cart-promotion-number{
  position: absolute;
  right: 0;
  bottom: 0;
  float: right;
  text-align: right;
  font-weight: bold;
}


{# /* // Totals */ #}

.cart-subtotal{
  float: right;
  clear: both;
  margin: 0 0 10px 0;
}
.total-promotions-row{
  float: right;
  width: 100%;
  margin-bottom: 10px;
  position: relative;
  .cart-promotion-number{
    margin-left: 5px;
  }
}
.cart-total{
  clear: both;
  margin: 10px 0;
  font-weight: bold;
}

{# /* Totals */ #}

.cart-promotion-detail{
  width: 65%;
  float: left;
}
.cart-promotion-number{
  position: absolute;
  right: 0;
  bottom: 0;
  width: 35%;
  float: right;
  margin: 0;
  text-align: right;
}

{#/*============================================================================
#Blog
==============================================================================*/

.post-item-image-container {
  position: relative;
  height: 200px;
  overflow: hidden;
}

.post-item-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.post-item-title,
.post-item-summary {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 3;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.5em;
}

.post-content,
.post-content p {
  font-size: 16px;
  line-height: 1.8rem;
}

.post-content img {
  max-width: 100%;
  height: auto;
}

.post-content h1,
.post-content h2,
.post-content h3,
.post-content h4,
.post-content h5,
.post-content h6 {
  margin: 2rem 0 1rem 0;
  line-height: initial;
}

.post-content h1,
.post-content .h1 {
  font-size: 28px;
}

.post-content h2,
.post-content .h2 {
  font-size: 24px;
}

.post-content h3,
.post-content .h3 {
  font-size: 20px;
}

.post-content h4,
.post-content .h4 {
  font-size: 18px;
}

.post-content h5,
.post-content .h5 {
  font-size: 16px;
}

.post-content h6,
.post-content .h6 {
  font-size: 14px;
}

/* Blog PataGang Custom */
.pg-blog-page {
  padding: 48px 0;
  background-color: #f5f5f5;
}

.pg-blog-header {
  text-align: center;
  margin-bottom: 48px;
  padding: 40px 20px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.pg-blog-header h1 {
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 40px;
  font-weight: 700;
  color: #000;
  margin: 0;
  padding: 0;
}

.pg-blog-grid {
  display: grid;
  grid-template-columns: repeat(1, 1fr);
  gap: 24px;
}

@media (min-width: 768px) {
  .pg-blog-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1024px) {
  .pg-blog-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

.pg-blog-card {
  background: #fff;
  border-radius: 16px;
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.pg-blog-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
}

.pg-blog-card__image {
  position: relative;
  height: 220px;
  overflow: hidden;
}

.pg-blog-card__image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.pg-blog-card:hover .pg-blog-card__image img {
  transform: scale(1.05);
}

.pg-blog-card__content {
  padding: 24px;
}

.pg-blog-card__title {
  font-family: 'Familjen Grotesk', sans-serif;
  font-weight: 700;
  font-size: 20px;
  color: #000;
  margin-bottom: 12px;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
}

.pg-blog-card__summary {
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 14px;
  color: #666;
  line-height: 1.6;
  margin-bottom: 16px;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 3;
  overflow: hidden;
}

.pg-blog-card__link {
  display: inline-block;
  background: #EAFE67;
  color: #000;
  padding: 10px 20px;
  border-radius: 4px;
  font-family: 'Familjen Grotesk', sans-serif;
  font-weight: 700;
  font-size: 14px;
  text-decoration: none;
  text-transform: uppercase;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.pg-blog-card__link:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(234, 254, 103, 0.4);
}

/* Blog Post Page */
.pg-blog-post {
  padding: 48px 0;
}

.pg-blog-post__header {
  text-align: center;
  margin-bottom: 32px;
}

.pg-blog-post__title {
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 36px;
  font-weight: 700;
  color: #000;
  margin-bottom: 16px;
}

@media (min-width: 768px) {
  .pg-blog-post__title {
    font-size: 48px;
  }
}

.pg-blog-post__date {
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 14px;
  color: #666;
}

.pg-blog-post__image {
  margin-bottom: 32px;
  border-radius: 16px;
  overflow: hidden;
}

.pg-blog-post__image img {
  width: 100%;
  height: auto;
}

.pg-blog-post__content {
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 18px;
  line-height: 1.8;
  color: #333;
}

.pg-blog-post__content p {
  margin-bottom: 24px;
}

.pg-blog-post__content h2 {
  font-size: 28px;
  font-weight: 700;
  margin: 40px 0 20px;
}

.pg-blog-post__content h3 {
  font-size: 24px;
  font-weight: 700;
  margin: 32px 0 16px;
}

/* Social Share */
.pg-blog-post__share {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  gap: 16px;
  margin: 40px 0;
  padding: 24px 0;
  border-top: 1px solid #e5e5e5;
  border-bottom: 1px solid #e5e5e5;
}

.pg-blog-post__share-title {
  width: 100%;
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #000;
  text-transform: uppercase;
  margin-bottom: 8px;
}

.share-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 10px 16px;
  border-radius: 4px;
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 14px;
  font-weight: 600;
  text-decoration: none;
  white-space: nowrap;
  transition: transform 0.2s ease, opacity 0.2s ease;
}

.share-btn:hover {
  transform: translateY(-2px);
  opacity: 0.9;
}

.share-btn--whatsapp {
  background: #25D366;
  color: #fff;
}

.share-btn--facebook {
  background: #1877F2;
  color: #fff;
}

.share-btn--twitter {
  background: #000;
  color: #fff;
}

.share-btn svg {
  width: 18px;
  height: 18px;
  fill: currentColor;
}


/*============================================================================
  #Media queries
==============================================================================*/

{# /* // Min width 768px */ #}

@media (min-width: 768px) {

  {# /* //// Nav */ #}

  .logo-img {
    max-width: 320px;
  }

  {# /* //// Placeholders */ #}

  .blur-up {
    -webkit-filter: blur(4px);
    filter: blur(4px);
    -moz-filter: blur(4px);
    -ms-filter: blur(4px);
    -o-filter: blur(4px);
    transition: filter .5s, -webkit-filter .2s;
  }

  {# /* //// Components */ #}

  .container-narrow {
    max-width: 680px;
  }

  .h1-md {
    font-size: 28px;
    font-weight: 700;
  }

  .h2-md {
    font-size: 24px;
    font-weight: 700;
  }

  .h3-md {
    font-size: 20px;
    font-weight: 700;
  }

  .h4-md {
    font-size: 18px;
    font-weight: 700;
  }

  .h5-md {
    font-size: 16px;
    font-weight: 700;
  }

  .h6-md {
    font-size: 14px;
    font-weight: 700;
  }

  .font-md-normal {
    font-size: 14px;
  }


  {# /* //// Banners */ #}

  {# /* Home Banners */ #}

  .textbanner-text {
    padding: 30px 20%;
  }

  {# /* //// Home */ #}

  {# /* //// Product grid */ #}

  .category-controls {
    position: relative;
    padding: 0;
  }

  .item-colors {
    padding: 10px 0;
  }

  .item-product-reduced .item-image,
  .item-product-reduced .item-image img {
    height: 180px;
  }

  .item-slider-controls-container {
    opacity: 0;
    transition: opacity .2s ease;
  }
  .item-slider-controls-container.swiper-button-disabled {
    opacity: 0;
    cursor: auto;
  }
  .item-image:hover .item-slider-controls-container:not(.swiper-button-disabled) {
    opacity: 1;
  }


  {# /* //// Product detail */ #}

  .product-video .video-image,
  .product-video .embed-responsive {
    width: 100%;
    height: auto;
  }

  .product-video .embed-responsive {
    padding-bottom: 56.25%;
  }

  {# /* //// Helper classes */ #}

  {# /* // Float */ #}

  .float-md-left{float:left!important}.float-md-right{float:right!important}.float-md-none{float:none!important}

  {# /* // Position */ #}

  .position-relative-md{position:relative!important;}.position-sticky-md{position:sticky!important;position:-webkit-sticky!important;}
}

/*============================================================================
  #Media queries
==============================================================================*/ #}

{# /* // Max width 767px */ #}
@media (max-width: 767px) {
  .product-image-limited {
    max-height: 210px;
  }
}

{# /* // Min width 768px */ #}

@media (min-width: 768px) {

  {# /* //// Components */ #}

  {# /* Header */ #}

  .desktop-dropdown-small {
    left: 50%;
    transform: translateX(-50%);
    -webkit-transform: translateX(-50%);
    -ms-transform: translateX(-50%);
  }

  {# /* Modals */ #}

  .modal{
    &-centered{
      height: 80%;
      width: 80%;
      left: 10%;
      margin: 5% auto;
      &-small{
        left: 50%;
        width: 30%;
        height: auto;
        max-height: 80%;
        margin: 0;
      }
      &-md-600px {
        left: 50%;
        width: 600px;
        transform: translateX(-50%);
      }
    }
    &-centered-md.modal-show {
      left: initial;
      transform: none;
      &.modal-bottom {
        top: 50%;
      }
    }
    &-docked-md{
      width: 500px;
      overflow-x: hidden;
      &-centered{
        left: calc(50% - 250px);
        bottom: auto;
        height: auto;
      }
    }
    &-bottom-sheet {
      top: 100%;
      &.modal-show {
        top: 0;
        bottom: auto;
      }
    }
    &-docked-small{
      width: 350px;
    }
    &-md-width-400px {
      width: 400px;
      max-width: 90vw;
    }
  }

  .fancybox__container .has-inline .fancybox__content{
    width: 85%;
    height: auto;
    padding: 44px;
  }

  {# /*  Navigation */ #}

  .nav-secondary .nav-account {
    margin: 10px -5px -10px -5px;
  }

  {# /*  Notifications */ #}

  .notification-floating .notification{
    width: 350px;
  }

  {# /* Filters */ #}

  .filter-input-price-container {
    width: 90px;
    .filter-input-price {
      padding: 10px;
    }
  }

  {# /* Tabs */ #}

  .tab-group{
    width: calc(100% + 20px);
    overflow-x: auto;
    white-space: normal;
    .tab{
      float: left;
    }
  }

  {# /* //// Footer */ #}

  .footer-menu {
    list-style: none;
    .footer-menu-item{
      display: inline-block;
      padding: 0 15px;
    }
  }
}

{#/*============================================================================
  #Critical path utilities
==============================================================================*/#}

.visible-when-content-ready{
  visibility: visible!important;
}
.display-when-content-ready{
  display: block!important;
}

/* ========================================
   CUSTOMIZACOES PATAGANG
   ======================================== */

/**
 * PATAGANG E-COMMERCE - TEMA CUSTOMIZADO
 * Design System + Layout Pixel-Perfect
 */

/* ============================================
   RESET & BASE
   ============================================ */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    font-size: 16px;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}

body {
    font-family: 'Familjen Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    font-weight: 400;
    line-height: 1.5;
    color: #000000;
    background-color: #FFFFFF;
}

img {
    max-width: 100%;
    height: auto;
    display: block;
}

a {
    text-decoration: none;
    color: inherit;
}

button {
    border: none;
    background: none;
    cursor: pointer;
    font-family: inherit;
}

/* ============================================
   DESIGN SYSTEM - CSS VARIABLES
   ============================================ */

:root {
    /* Cores */
    --color-primary: #EAFE67;
    --color-black: #000000;
    --color-white: #FFFFFF;
    --color-gray-light: #E5E5E5;
    --color-gray-medium: #CCCCCC;
    --color-gray-dark: #666666;

    /* Tipografia */
    --font-family-base: 'Familjen Grotesk', sans-serif;
    --font-weight-regular: 400;
    --font-weight-bold: 700;

    --font-size-xs: 12px;
    --font-size-sm: 14px;
    --font-size-base: 16px;
    --font-size-lg: 18px;
    --font-size-xl: 24px;
    --font-size-2xl: 32px;
    --font-size-3xl: 40px;

    /* Espaçamentos */
    --spacing-xs: 4px;
    --spacing-sm: 8px;
    --spacing-md: 16px;
    --spacing-lg: 24px;
    --spacing-xl: 32px;
    --spacing-2xl: 48px;

    /* Border Radius */
    --radius-sm: 4px;
    --radius-md: 8px;
    --radius-lg: 16px;

    /* Sombras */
    --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
    --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);

    /* Layout */
    --header-height: 60px;
    --container-max-width: 1280px;

    /* Logo sizes */
    --logo-icon-size: 40px;
    --logo-text-width: 100px;
}

/* ============================================
   HEADER
   ============================================ */

.header {
    /* AJUSTADO: Header totalmente transparente conforme protótipo */
    /* Permite que o fundo da página apareça naturalmente */
    background: transparent !important;
    height: var(--header-height) !important;
    position: fixed !important; /* Fixed para sobrepor o conteúdo */
    top: 0 !important;
    left: 0 !important;
    width: 100% !important;
    z-index: 1000 !important;
    border-bottom: none !important;
    /* REMOVIDO: backdrop-filter e overlay para seguir protótipo */
}

.header__container {
    max-width: var(--container-max-width);
    margin: 0 auto;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 var(--spacing-md);
}

/* Menu Button (esquerda) */
.header__menu-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: var(--spacing-sm);
}

.header__menu-btn img {
    width: 24px;
    height: 24px;
    /* AJUSTADO: Inverter cor de branco para preto conforme protótipo */
    filter: invert(1) brightness(0);
}

/* Logo Central */
.header__logo {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
}

.header__logo-icon {
    width: var(--logo-icon-size);
    height: var(--logo-icon-size);
    /* AJUSTADO: Inverter cor de branco para preto conforme protótipo */
    filter: invert(1) brightness(0);
}



.header__logo-text {
    width: var(--logo-text-width);
    height: auto;
    /* AJUSTADO: Inverter cor de branco para preto conforme protótipo */
    filter: invert(1) brightness(0);
}

/* Logo Transition Styles */
.header__logo {
    position: relative;
}

.header__logo-default {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
    transition: opacity 0.4s ease;
    opacity: 1;
}

.header__logo-hover {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    opacity: 0;
    transition: opacity 0.4s ease;
    pointer-events: none;
    width: 200px;
    display: flex;
    justify-content: center;
}

.header__logo:hover .header__logo-default {
    opacity: 0;
}

.header__logo:hover .header__logo-hover {
    opacity: 1;
}

/* Actions (direita) */
.header__actions {
    display: flex;
    align-items: center;
    gap: var(--spacing-lg);
    margin-left: auto;
}

.header__action-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: var(--spacing-sm);
    position: relative;
}

.header__action-btn img {
    width: 20px;
    height: 20px;
    /* AJUSTADO: Inverter cor de branco para preto conforme protótipo */
    filter: invert(1) brightness(0);
}

/* Cart Badge */
.header__cart-badge {
    position: absolute;
    top: 0;
    right: 0;
    background-color: var(--color-black);
    color: var(--color-white);
    font-size: var(--font-size-xs);
    font-weight: var(--font-weight-bold);
    width: 18px;
    height: 18px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* ============================================
   MOBILE MENU
   ============================================ */

.mobile-menu {
    position: fixed;
    top: 0;
    left: -100%;
    width: 280px;
    height: 100vh;
    background-color: var(--color-white);
    z-index: 2000;
    transition: left 0.3s ease;
    box-shadow: var(--shadow-lg);
}

.mobile-menu.is-open {
    left: 0;
}

.mobile-menu__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: var(--spacing-lg);
    border-bottom: 1px solid var(--color-gray-light);
}

.mobile-menu__title {
    font-weight: var(--font-weight-bold);
    font-size: var(--font-size-lg);
}

.mobile-menu__close {
    padding: var(--spacing-sm);
}

.mobile-menu__nav {
    padding: var(--spacing-md);
}

.mobile-menu__list {
    list-style: none;
}

.mobile-menu__item {
    border-bottom: 1px solid var(--color-gray-light);
}

.mobile-menu__link {
    display: block;
    padding: var(--spacing-md) 0;
    font-weight: var(--font-weight-bold);
    text-transform: uppercase;
    transition: color 0.2s;
}

.mobile-menu__link:hover {
    color: var(--color-gray-dark);
}

/* ============================================
   SEARCH OVERLAY
   ============================================ */

.search-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.9);
    z-index: 2000;
    display: none;
    align-items: center;
    justify-content: center;
    padding: var(--spacing-lg);
}

.search-overlay.is-open {
    display: flex;
}

.search-overlay__container {
    width: 100%;
    max-width: 600px;
    position: relative;
}

.search-overlay__close {
    position: absolute;
    top: -40px;
    right: 0;
    color: var(--color-white);
}

.search-form__input {
    width: 100%;
    padding: var(--spacing-lg);
    font-size: var(--font-size-xl);
    font-family: var(--font-family-base);
    font-weight: var(--font-weight-bold);
    border: none;
    border-bottom: 2px solid var(--color-white);
    background: transparent;
    color: var(--color-white);
    outline: none;
}

.search-form__input::placeholder {
    color: rgba(255, 255, 255, 0.6);
}

.search-form__btn {
    margin-top: var(--spacing-lg);
    padding: var(--spacing-md) var(--spacing-xl);
    background-color: var(--color-primary);
    color: var(--color-black);
    font-weight: var(--font-weight-bold);
    text-transform: uppercase;
    border-radius: var(--radius-sm);
    transition: opacity 0.2s;
}

.search-form__btn:hover {
    opacity: 0.9;
}

/* ============================================
   HERO BANNER
   ============================================ */

.hero {
    /* CORRIGIDO: Hero com background #E5E5E5 para continuidade com header */
    /* Conforme validação cliente 18/11/2025 - ANALISE-COMPARATIVA-PROTOTIPO.md Alteração #3 */
    /* Compartilha mesma imagem de fundo do header */
    background-color: #E5E5E5; /* Fallback */
    background-image: url('{{ 'images/banner-dk-1.png' | static_url }}');
    background-size: cover;
    background-position: top center; /* CORRIGIDO 25/11: Top center para não cortar parte superior da imagem */
    background-repeat: no-repeat;
    padding: 0;
    /* padding-top removido para permitir header transparente sobrepor o hero */
    margin: 0;
    position: relative;
    min-height: 100vh;
    width: 100%;
}

/* Background mobile diferente */
@media (max-width: 767px) {
    .hero {
        background-image: url('{{ 'images/banner-mo-1.png' | static_url }}');
    }
}

.hero__container {
    /* Container com posicionamento relativo para scroll indicator absoluto */
    width: 100%;
    margin: 0;
    padding: 0;
    position: relative;
    min-height: 100vh; /* Garante altura completa */
    display: flex;
    flex-direction: column;
    justify-content: center;
}

/* REMOVIDO: .hero__image-wrapper e .hero__image não são mais necessários */
/* Imagem de fundo agora está via background-image no .hero */

.hero__content {
    /* CORRIGIDO: Centralização perfeita vertical e horizontal */
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 100vh; /* Altura completa da viewport para centralizar com header transparente sobreposto */
    width: 100%;
    max-width: 100%;
    margin: 0 auto;
    padding: var(--spacing-2xl) var(--spacing-md);
    padding-top: calc(var(--header-height, 60px) + var(--spacing-2xl)); /* Adiciona espaço para o header transparente */
    gap: var(--spacing-2xl);
    position: relative; /* Para posicionar scroll indicator */
}

/* Desktop: Grid 2 colunas - CENTRALIZAÇÃO PERFEITA */
@media (min-width: 1024px) {
    .hero__content {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: var(--spacing-3xl);
        align-items: center;
        justify-items: center; /* Centraliza itens horizontalmente */
        max-width: 1200px;
        width: 90%;
        min-height: calc(100vh - var(--header-height, 80px));
    }
}

/* Coluna esquerda: Texto SVG */
.hero__text-column {
    display: flex;
    align-items: center;
    justify-content: center;
}

.hero__text-svg {
    width: 100%;
    max-width: 500px;
}

@media (min-width: 768px) {
    .hero__text-svg {
        max-width: 600px;
    }
}

@media (min-width: 1024px) {
    .hero__text-svg {
        max-width: 100%;
    }
}

.hero__svg-image {
    width: 100%;
    height: auto;
    filter: drop-shadow(0 4px 12px rgba(0, 0, 0, 0.7));
}

/* Coluna direita: CTA e Scroll Indicator */
.hero__cta-column {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: var(--spacing-xl);
}

@media (min-width: 1024px) {
    .hero__cta-column {
        align-items: flex-start;
        justify-content: center;
    }
}

.hero__cta {
    display: inline-block;
    padding: 16px 32px;
    background-color: var(--color-primary);
    color: var(--color-black);
    font-weight: var(--font-weight-bold);
    font-size: var(--font-size-base);
    text-transform: uppercase;
    border-radius: var(--radius-sm);
    transition: transform 0.2s, box-shadow 0.2s;
    letter-spacing: 0.5px;
}

@media (min-width: 768px) {
    .hero__cta {
        padding: 18px 40px;
        font-size: var(--font-size-lg);
    }
}

.hero__cta:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
}

/* Scroll Indicator - Moderno e maior */
.hero__scroll-indicator {
    display: none; /* Oculto no mobile */
    position: absolute;
    bottom: var(--spacing-xl); /* Posicionado no final do bloco */
    left: 50%;
    transform: translateX(-50%);
    cursor: pointer;
}

@media (min-width: 1024px) {
    .hero__scroll-indicator {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 8px;
        animation: bounce 2s infinite;
    }
}

.hero__scroll-indicator svg {
    width: 40px; /* Tamanho maior */
    height: 40px;
    opacity: 0.9;
    filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.3));
    transition: all 0.3s ease;
}

.hero__scroll-indicator:hover svg {
    opacity: 1;
    transform: scale(1.1);
}

/* Cor amarela no stroke do SVG */
.hero__scroll-indicator svg path {
    stroke: var(--color-primary); /* Amarelo neon #EAFE67 */
    stroke-width: 2.5;
}

/* Animação de bounce para scroll indicator */
@keyframes bounce {
    0%, 20%, 50%, 80%, 100% {
        transform: translateY(0);
    }
    40% {
        transform: translateY(-10px);
    }
    60% {
        transform: translateY(-5px);
    }
}

/* ============================================
   YELLOW GRADIENT WRAPPER - Conforme Adobe XD
   ============================================ */

/* WRAPPER com degradê amarelo que engloba Featured Product + Products Grid + Footer */
/* Gradiente conforme especificação Adobe XD: #EAFE67 → transparente */
.yellow-gradient-wrapper {
    background: linear-gradient(180deg,
        #EAFE67 0%,           /* Featured Product - amarelo sólido 100% */
        #EAFE67C4 74%,        /* Products Grid início - 77% opacidade */
        #EAFE678D 86%,        /* Products Grid meio - 55% opacidade */
        #EAFE6700 100%        /* Footer - 0% opacidade (transparente para revelar #CCCCCC) */
    );
    width: 100%;
}

/* ============================================
   FEATURED PRODUCT - Layout 2 colunas
   ============================================ */

.featured-product {
    /* REMOVIDO background-color: gradient agora vem do wrapper */
    background-color: transparent !important;
    padding: var(--spacing-3xl) var(--spacing-md);
}

.featured-product__container {
    max-width: var(--container-max-width);
    margin: 0 auto;
}

/* Layout Responsivo: Vertical mobile, Horizontal desktop (2 colunas) */
.featured-product__grid {
    display: flex;
    flex-direction: column; /* Mobile: empilha verticalmente */
    gap: 80px; /* Espaço entre produto e newsletter mobile */
    align-items: center; /* Centraliza horizontalmente */
    padding: 60px 16px; /* Padding vertical e horizontal */
}

@media (min-width: 768px) {
    .featured-product__grid {
        flex-direction: row; /* Desktop: lado a lado */
        gap: 60px; /* Gap horizontal entre colunas */
        padding: 80px 40px; /* Padding maior no desktop */
        align-items: center; /* Centraliza verticalmente */
        justify-content: center; /* Centraliza horizontalmente */
    }
}

/* Container do Card do Produto */
.featured-product__card-wrapper {
    display: flex;
    justify-content: center; /* Centraliza o card horizontalmente */
    align-items: center; /* Centraliza o card verticalmente */
    width: 100%; /* Mobile: ocupa toda a largura */
}

@media (min-width: 768px) {
    .featured-product__card-wrapper {
        flex: 1; /* Desktop: ocupa metade do espaço disponível */
        max-width: 50%; /* Limita a 50% da largura */
        justify-content: center; /* Centraliza o card */
        padding: 0 15px; /* Padding lateral para separação */
    }

    /* Primeiro card alinha à direita */
    .featured-product__card-wrapper:first-child {
        justify-content: flex-end;
        padding-right: 30px;
        padding-left: 0;
    }

    /* Segundo card alinha à esquerda */
    .featured-product__card-wrapper:last-child {
        justify-content: flex-start;
        padding-left: 30px;
        padding-right: 0;
    }
}

/* CARD DO PRODUTO - Tamanho maior conforme protótipo */
.featured-product__card {
    background-color: #FFFFFF; /* Branco conforme protótipo */
    border-radius: 24px; /* Bordas bem arredondadas */
    padding: 48px 40px; /* Padding generoso */
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 32px; /* Gap maior entre imagem e botão */
    width: 100%; /* Mobile 100% */
    max-width: 480px; /* Tamanho maior mobile */
    min-height: 500px; /* Altura mínima para proporção */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08); /* Sombra sutil */
}

@media (min-width: 768px) {
    .featured-product__card {
        padding: 60px 50px; /* Padding ainda maior no desktop */
        max-width: 520px; /* Tamanho maior desktop conforme protótipo */
        min-height: 580px; /* Altura mínima maior */
    }
}

@media (min-width: 1024px) {
    .featured-product__card {
        padding: 70px 60px;
        max-width: 580px; /* Tamanho grande em telas maiores */
        min-height: 620px;
    }
}

.featured-product__image {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0;
    flex: 1; /* Ocupa espaço disponível */
}

.featured-product__image a {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
}

.featured-product__image img {
    width: 100%;
    max-width: 380px; /* Imagem maior */
    height: auto;
    object-fit: contain;
    transition: transform 0.3s ease;
}

.featured-product__image img:hover {
    transform: scale(1.02); /* Leve zoom no hover */
}

@media (min-width: 768px) {
    .featured-product__image img {
        max-width: 360px; /* Tamanho maior no desktop */
    }
}

@media (min-width: 1024px) {
    .featured-product__image img {
        max-width: 400px; /* Imagem ainda maior em telas grandes */
    }
}

/* Botão Shop - Texto sublinhado conforme protótipo */
.featured-product__btn {
    display: inline-block;
    padding: 8px 0; /* Padding mínimo para texto simples */
    background-color: transparent; /* Sem background conforme protótipo */
    color: var(--color-black); /* Texto preto */
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 400; /* Regular conforme protótipo */
    font-size: 18px; /* Tamanho adequado */
    text-transform: capitalize; /* "Shop" com S maiúsculo */
    border: none;
    border-radius: 0;
    transition: all 0.3s ease;
    text-decoration: underline; /* Sublinhado conforme protótipo */
    text-underline-offset: 4px; /* Espaçamento do underline */
    cursor: pointer;
}

.featured-product__btn:hover {
    color: #333; /* Leve escurecimento no hover */
    text-decoration-thickness: 2px; /* Underline mais grosso no hover */
}

/* Placeholder quando não há produto com tag */
.featured-product__placeholder {
    display: none; /* Oculto quando não há produto */
}

/* Container do Newsletter */
.featured-product__newsletter-wrapper {
    display: flex;
    justify-content: center; /* Centraliza o newsletter horizontalmente */
    align-items: center; /* Centraliza o newsletter verticalmente */
    width: 100%; /* Mobile: ocupa toda a largura */
}

@media (min-width: 768px) {
    .featured-product__newsletter-wrapper {
        flex: 1; /* Desktop: ocupa metade do espaço disponível */
        max-width: 50%; /* Limita a 50% da largura */
        justify-content: flex-start; /* Alinha à esquerda (centralizado na metade direita) */
        padding-left: 30px; /* Adiciona espaço para separação */
    }
}

/* NEWSLETTER */
.featured-product__newsletter {
    display: flex;
    flex-direction: column;
    align-items: flex-start; /* Alinhamento à esquerda */
    justify-content: center;
    text-align: left; /* Texto alinhado à esquerda */
    gap: 32px;
    width: 100%;
    max-width: 420px; /* Mobile: mesma largura do card */
}

@media (min-width: 768px) {
    .featured-product__newsletter {
        max-width: 520px; /* Desktop: largura maior para o formulário */
    }
}

.featured-product__newsletter-title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 400; /* Regular conforme protótipo */
    font-style: italic; /* Itálico conforme protótipo */
    font-size: 28px; /* Tamanho adequado mobile */
    color: var(--color-black);
    margin: 0;
    line-height: 1.3;
    letter-spacing: -0.3px;
}

@media (min-width: 768px) {
    .featured-product__newsletter-title {
        font-size: 36px; /* Tamanho reduzido no desktop */
    }
}

@media (min-width: 1024px) {
    .featured-product__newsletter-title {
        font-size: 40px; /* Reduzido em telas grandes */
    }
}

/* Form newsletter - Layout horizontal conforme protótipo */
.featured-product__newsletter-form {
    display: flex;
    flex-direction: column; /* Mobile: vertical */
    gap: 16px;
    width: 100%;
}

@media (min-width: 768px) {
    .featured-product__newsletter-form {
        flex-direction: row; /* Desktop: horizontal - input + botão na mesma linha */
        align-items: flex-end; /* Alinha na base */
        gap: 16px;
    }
}

.featured-product__newsletter-input {
    flex: 1; /* Ocupa espaço disponível */
    padding: 12px 0; /* Padding apenas vertical */
    border: none;
    border-bottom: 1px solid var(--color-black); /* Linha conforme protótipo */
    background-color: transparent;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 16px;
    color: var(--color-black);
    outline: none;
    transition: border-color 0.3s ease;
    min-width: 0; /* Permite encolher no flex */
}

.featured-product__newsletter-input::placeholder {
    color: rgba(0, 0, 0, 0.5); /* Placeholder mais visível */
    font-size: 16px;
}

.featured-product__newsletter-input:focus {
    border-bottom-color: var(--color-black);
    border-bottom-width: 2px;
}

.featured-product__newsletter-btn {
    padding: 14px 32px;
    background-color: var(--color-black);
    color: var(--color-white);
    border: none;
    border-radius: 50px; /* Bordas bem arredondadas conforme protótipo */
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 600;
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 1px;
    cursor: pointer;
    transition: all 0.3s ease;
    white-space: nowrap; /* Evita quebra de linha */
    flex-shrink: 0; /* Não encolhe */
}

.featured-product__newsletter-btn:hover {
    background-color: #333;
    transform: translateY(-1px);
}

.featured-product__newsletter-btn:disabled {
    opacity: 0.7;
    cursor: not-allowed;
    transform: none;
}

/* Pingback Feedback Messages */
.pingback-feedback {
    padding: 12px 16px;
    border-radius: 8px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    margin-bottom: 16px;
    text-align: center;
}

.pingback-feedback--success {
    background-color: rgba(0, 0, 0, 0.1);
    color: #1a1a1a;
    border: 1px solid rgba(0, 0, 0, 0.2);
}

.pingback-feedback--error {
    background-color: rgba(220, 53, 69, 0.15);
    color: #a71d2a;
    border: 1px solid rgba(220, 53, 69, 0.3);
}

/* ============================================
   MOBILE: CENTRALIZAÇÃO DO WIDGET PINGBACK
   ============================================ */
@media (max-width: 767px) {
    /* Wrapper do newsletter - centraliza tudo */
    .featured-product__newsletter-wrapper {
        display: flex !important;
        justify-content: center !important;
        align-items: center !important;
        width: 100% !important;
        padding: 0 20px !important;
        box-sizing: border-box !important;
    }

    /* Newsletter container - centraliza conteúdo */
    .featured-product__newsletter {
        align-items: center !important;
        text-align: center !important;
        width: 100% !important;
        max-width: 100% !important;
        padding: 0 !important;
    }

    /* Container do widget Pingback - centraliza */
    .pingback-widget-container,
    #pingback-container {
        width: 100% !important;
        max-width: 100% !important;
        display: flex !important;
        flex-direction: column !important;
        align-items: center !important;
        justify-content: center !important;
        text-align: center !important;
        margin: 0 auto !important;
        padding: 0 !important;
        box-sizing: border-box !important;
    }

    /* Elemento pb-embeddable-form do Pingback */
    pb-embeddable-form,
    #pingback-container pb-embeddable-form {
        width: 100% !important;
        max-width: 100% !important;
        display: flex !important;
        flex-direction: column !important;
        align-items: center !important;
        text-align: center !important;
        margin: 0 auto !important;
        box-sizing: border-box !important;
    }

    /* Todos os elementos dentro do Pingback - centraliza */
    #pingback-container *,
    .pingback-widget-container * {
        text-align: center !important;
        margin-left: auto !important;
        margin-right: auto !important;
    }

    /* Títulos dentro do Pingback */
    #pingback-container h1,
    #pingback-container h2,
    #pingback-container h3,
    #pingback-container h4,
    #pingback-container h5,
    #pingback-container h6,
    .pingback-widget-container h1,
    .pingback-widget-container h2,
    .pingback-widget-container h3,
    .pingback-widget-container h4,
    .pingback-widget-container h5,
    .pingback-widget-container h6 {
        text-align: center !important;
        width: 100% !important;
        margin: 0 auto 12px auto !important;
    }

    /* Parágrafos e textos dentro do Pingback */
    #pingback-container p,
    .pingback-widget-container p {
        text-align: center !important;
        width: 100% !important;
        margin: 0 auto 16px auto !important;
    }

    /* Forms dentro do Pingback */
    #pingback-container form,
    .pingback-widget-container form {
        width: 100% !important;
        max-width: 100% !important;
        display: flex !important;
        flex-direction: column !important;
        align-items: center !important;
        gap: 12px !important;
        margin: 0 auto !important;
        padding: 0 !important;
        box-sizing: border-box !important;
    }

    /* Inputs dentro do Pingback */
    #pingback-container input,
    #pingback-container select,
    #pingback-container textarea,
    .pingback-widget-container input,
    .pingback-widget-container select,
    .pingback-widget-container textarea {
        width: 100% !important;
        max-width: 100% !important;
        margin: 0 auto !important;
        box-sizing: border-box !important;
        text-align: left !important; /* Texto do input alinhado à esquerda para melhor UX */
    }

    /* Botões dentro do Pingback */
    #pingback-container button,
    .pingback-widget-container button {
        width: 100% !important;
        max-width: 100% !important;
        margin: 0 auto !important;
        box-sizing: border-box !important;
    }

    /* Labels dentro do Pingback */
    #pingback-container label,
    .pingback-widget-container label {
        text-align: center !important;
        width: 100% !important;
        display: block !important;
        margin: 0 auto 8px auto !important;
    }

    /* Divs e containers dentro do Pingback - EXCETO seletor de bandeiras */
    #pingback-container div:not([class*="iti"]):not([class*="flag"]):not([class*="country"]),
    .pingback-widget-container div:not([class*="iti"]):not([class*="flag"]):not([class*="country"]) {
        width: 100% !important;
        max-width: 100% !important;
        box-sizing: border-box !important;
    }

    /* Correção específica para o seletor de bandeiras intl-tel-input */
    #pingback-container .iti,
    #pingback-container .iti__flag-container,
    #pingback-container .iti__selected-flag,
    #pingback-container .iti__country-list,
    .pingback-widget-container .iti,
    .pingback-widget-container .iti__flag-container,
    .pingback-widget-container .iti__selected-flag,
    .pingback-widget-container .iti__country-list {
        width: auto !important;
        max-width: none !important;
        display: inline-block !important;
    }

    /* Container do input de telefone com bandeira */
    #pingback-container .iti,
    .pingback-widget-container .iti {
        width: 100% !important;
        display: block !important;
    }

    /* Input de telefone dentro do iti */
    #pingback-container .iti input[type="tel"],
    .pingback-widget-container .iti input[type="tel"] {
        width: 100% !important;
    }

    /* Ajuste fino: ícone de seta do seletor de bandeiras */
    #pingback-container .iti__arrow,
    #pingback-container .iti__selected-flag .iti__arrow,
    .pingback-widget-container .iti__arrow,
    .pingback-widget-container .iti__selected-flag .iti__arrow {
        width: auto !important;
        height: auto !important;
        border: none !important;
        margin-left: 6px !important;
        display: inline-block !important;
        vertical-align: middle !important;
    }

    /* Container da bandeira selecionada - alinhamento */
    #pingback-container .iti__selected-flag,
    .pingback-widget-container .iti__selected-flag {
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        padding: 0 8px !important;
        height: 100% !important;
    }
}

/* ============================================
   SEÇÃO EM DESENVOLVIMENTO
   ============================================ */

.coming-soon {
    background-color: #EAFE67; /* Mesmo amarelo da featured product */
    padding: 60px 16px;
}

@media (min-width: 768px) {
    .coming-soon {
        padding: 80px 40px;
    }
}

.coming-soon__container {
    max-width: var(--container-max-width);
    margin: 0 auto;
}

.coming-soon__grid {
    display: grid;
    grid-template-columns: 1fr; /* Mobile: 1 coluna */
    gap: 40px;
}

@media (min-width: 768px) {
    .coming-soon__grid {
        grid-template-columns: repeat(2, 1fr); /* Desktop: 2 colunas */
        gap: 60px;
    }
}

/* Card Individual - Agora é um link clicável */
.coming-soon__card {
    position: relative;
    border-radius: 20px;
    overflow: hidden;
    aspect-ratio: 4 / 3; /* Proporção mais horizontal como no protótipo */
    background-color: #F5F5F5; /* Fundo claro como no protótipo */
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    display: block;
    text-decoration: none;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.coming-soon__card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

/* Imagem com Blur */
.coming-soon__image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    filter: blur(12px);
    transform: scale(1.1); /* Evita bordas brancas do blur */
}

/* Overlay Centralizado */
.coming-soon__overlay {
    position: absolute;
    inset: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 24px;
    padding: 24px;
}

/* Frame com Brackets Amarelos nos Cantos - SEM BORDA */
.coming-soon__frame {
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 24px 40px;
    background: transparent;
    /* SEM borda - apenas os brackets nos cantos */
}

/* Brackets Amarelos nos 4 cantos do frame */
.coming-soon__frame::before,
.coming-soon__frame::after {
    content: '';
    position: absolute;
    width: 16px;
    height: 16px;
    border: 3px solid #EAFE67; /* Amarelo neon */
}

/* Canto superior esquerdo */
.coming-soon__frame::before {
    top: 0;
    left: 0;
    border-right: none;
    border-bottom: none;
}

/* Canto superior direito */
.coming-soon__frame::after {
    top: 0;
    right: 0;
    border-left: none;
    border-bottom: none;
}

/* Badge "EM DESENVOLVIMENTO" - texto centralizado */
.coming-soon__badge {
    position: relative;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 600;
    font-size: 11px;
    color: #EAFE67; /* Amarelo neon */
    text-transform: uppercase;
    text-align: center;
    letter-spacing: 1.5px;
    white-space: nowrap;
    padding: 0 8px;
}

/* Brackets inferiores - alinhados com os superiores */
.coming-soon__badge::before,
.coming-soon__badge::after {
    content: '';
    position: absolute;
    width: 16px;
    height: 16px;
    border: 3px solid #EAFE67;
}

/* Canto inferior esquerdo - alinhado com o frame */
.coming-soon__badge::before {
    bottom: -24px;
    left: -32px;
    border-right: none;
    border-top: none;
}

/* Canto inferior direito - alinhado com o frame */
.coming-soon__badge::after {
    bottom: -24px;
    right: -32px;
    border-left: none;
    border-top: none;
}

@media (min-width: 768px) {
    .coming-soon__badge {
        font-size: 13px;
        letter-spacing: 2px;
    }

    .coming-soon__frame {
        padding: 28px 48px;
    }

    .coming-soon__frame::before,
    .coming-soon__frame::after,
    .coming-soon__badge::before,
    .coming-soon__badge::after {
        width: 18px;
        height: 18px;
    }

    .coming-soon__badge::before {
        left: -40px;
    }

    .coming-soon__badge::after {
        right: -40px;
    }
}

/* Botão "Seja o primeiro a conhecer" - Link com underline */
.coming-soon__button {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 600;
    font-size: 14px;
    color: #000000;
    text-decoration: underline;
    text-underline-offset: 4px;
    text-decoration-style: solid;
    text-align: center;
    font-style: italic;
    padding: 8px 16px;
    transition: all 0.3s ease;
    cursor: pointer;
    background: transparent;
    border: none;
    display: block;
}

.coming-soon__card:hover .coming-soon__button {
    color: #333;
    transform: scale(1.02);
}

/* ============================================
   PRODUCTS GRID
   ============================================ */

.products-grid {
    /* REMOVIDO background-color: gradient agora vem do wrapper */
    background-color: transparent !important;
    padding: var(--spacing-2xl) var(--spacing-md);
}

.products-grid__container {
    max-width: var(--container-max-width);
    margin: 0 auto;
}

.products-grid__title {
    font-size: var(--font-size-2xl);
    font-weight: var(--font-weight-bold);
    text-align: center;
    margin-bottom: var(--spacing-xl);
    text-transform: uppercase;
}

.products-grid__items {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: var(--spacing-lg);
}

/* ============================================
   RESPONSIVE - TABLET & DESKTOP
   ============================================ */

@media (min-width: 768px) {
    :root {
        --header-height: 80px;
        --font-size-3xl: 56px;
        --logo-icon-size: 60px;
        --logo-text-width: 140px;
    }

    .hero__title {
        font-size: 56px;
    }

    .hero__cta {
        font-size: var(--font-size-base);
        padding: 18px 40px;
    }

    .featured-product__card {
        padding: var(--spacing-2xl);
    }
}

@media (min-width: 1024px) {
    .products-grid__items {
        grid-template-columns: repeat(4, 1fr);
    }
}

/* ============================================
   PÁGINA 404 CUSTOMIZADA - PATAGANG
   ============================================ */

.pg-404-section {
    background-color: #EAFE67; /* Amarelo neon Patagang */
    min-height: 80vh;
    padding: 80px 20px 60px;
    font-family: 'Familjen Grotesk', sans-serif;
}

/* Hero Section */
.pg-404-hero {
    margin-bottom: 48px;
}

.pg-404-logo {
    margin-bottom: 40px;
}

.pg-404-logo-img {
    max-width: 200px;
    height: auto;
}

.pg-404-title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 120px;
    font-weight: 700;
    color: #000000;
    margin: 0 0 16px 0;
    line-height: 1;
    letter-spacing: -2px;
}

.pg-404-subtitle {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 32px;
    font-weight: 700;
    color: #000000;
    margin: 0 0 24px 0;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.pg-404-description {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 18px;
    font-weight: 400;
    color: #000000;
    line-height: 1.6;
    margin: 0;
    max-width: 600px;
    margin: 0 auto;
}

/* Search Form */
.pg-404-search-form {
    margin-bottom: 0;
}

.pg-404-search-wrapper {
    position: relative;
    display: flex;
    align-items: center;
    background: #FFFFFF;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.pg-404-search-input {
    flex: 1;
    border: none;
    padding: 16px 20px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 16px;
    color: #000000;
    outline: none;
    background: transparent;
}

.pg-404-search-input::placeholder {
    color: #999999;
}

.pg-404-search-btn {
    background: #000000;
    border: none;
    padding: 16px 24px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
}

.pg-404-search-btn:hover {
    background: #1a1a1a;
}

.pg-404-search-btn svg {
    color: #FFFFFF;
}

/* CTA Buttons */
.pg-404-cta-container {
    display: flex;
    gap: 16px;
    justify-content: center;
    flex-wrap: wrap;
}

.pg-404-btn {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    padding: 14px 32px;
    border-radius: 6px;
    text-decoration: none;
    display: inline-block;
    transition: all 0.3s ease;
    min-width: 180px;
    text-align: center;
}

.pg-404-btn-primary {
    background-color: #000000;
    color: #FFFFFF;
    border: 2px solid #000000;
}

.pg-404-btn-primary:hover {
    background-color: #1a1a1a;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
    color: #FFFFFF;
    text-decoration: none;
}

.pg-404-btn-secondary {
    background-color: transparent;
    color: #000000;
    border: 2px solid #000000;
}

.pg-404-btn-secondary:hover {
    background-color: #000000;
    color: #EAFE67;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    text-decoration: none;
}

/* Products Section */
.pg-404-products-title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 24px;
    font-weight: 700;
    color: #000000;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin: 0;
}

/* Responsive Adjustments */
@media (max-width: 767px) {
    .pg-404-section {
        padding: 60px 16px 40px;
    }

    .pg-404-title {
        font-size: 80px;
    }

    .pg-404-subtitle {
        font-size: 24px;
    }

    .pg-404-description {
        font-size: 16px;
    }

    .pg-404-logo-img {
        max-width: 150px;
    }

    .pg-404-btn {
        width: 100%;
        max-width: 300px;
    }

    .pg-404-cta-container {
        flex-direction: column;
        align-items: center;
    }
}

@media (min-width: 768px) and (max-width: 1023px) {
    .pg-404-title {
        font-size: 100px;
    }

    .pg-404-subtitle {
        font-size: 28px;
    }
}

/* ============================================
   PÁGINA PRODUTOS EM DESENVOLVIMENTO
   ============================================ */

/* Hero Section */
.dev-products-hero {
    background: linear-gradient(180deg, #FFFFFF 0%, #F5F5F5 100%);
    padding: 120px 20px 80px;
    position: relative;
    overflow: hidden;
}

/* Grid pattern background - sutil */
.dev-products-hero::before {
    content: '';
    position: absolute;
    inset: 0;
    background-image:
        repeating-linear-gradient(0deg, transparent, transparent 39px, rgba(234, 254, 103, 0.25) 39px, rgba(234, 254, 103, 0.25) 40px),
        repeating-linear-gradient(90deg, transparent, transparent 39px, rgba(234, 254, 103, 0.25) 39px, rgba(234, 254, 103, 0.25) 40px);
    pointer-events: none;
}

.dev-products-hero__container {
    max-width: 1200px;
    margin: 0 auto;
    text-align: center;
    position: relative;
    z-index: 1;
}

.dev-products-hero__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    font-size: 32px;
    color: #000000;
    margin: 0 0 16px 0;
    text-transform: uppercase;
    letter-spacing: 1px;
}

@media (min-width: 768px) {
    .dev-products-hero__title {
        font-size: 44px;
        letter-spacing: 2px;
    }
}

@media (min-width: 1024px) {
    .dev-products-hero__title {
        font-size: 56px;
    }
}

.dev-products-hero__subtitle {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 400;
    font-style: italic;
    font-size: 18px;
    color: #666666;
    margin: 0;
}

@media (min-width: 768px) {
    .dev-products-hero__subtitle {
        font-size: 22px;
    }
}

/* Products Section */
.dev-products-section {
    background: linear-gradient(180deg, #F5F5F5 0%, #FFFFFF 100%);
    padding: 60px 20px 100px;
    position: relative;
}

/* Grid pattern background */
.dev-products-section::before {
    content: '';
    position: absolute;
    inset: 0;
    background-image:
        repeating-linear-gradient(0deg, transparent, transparent 39px, rgba(234, 254, 103, 0.20) 39px, rgba(234, 254, 103, 0.20) 40px),
        repeating-linear-gradient(90deg, transparent, transparent 39px, rgba(234, 254, 103, 0.20) 39px, rgba(234, 254, 103, 0.20) 40px);
    pointer-events: none;
}

.dev-products-section__container {
    max-width: 1400px;
    margin: 0 auto;
    position: relative;
    z-index: 1;
}

.dev-products-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 50px;
}

@media (min-width: 768px) {
    .dev-products-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 70px;
    }
}

/* Product Card */
.dev-product-card {
    position: relative;
    border-radius: 20px;
    overflow: hidden;
    aspect-ratio: 4 / 5;
    background-color: #E5E5E5;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.dev-product-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.16);
}

/* Background com imagem blur */
.dev-product-card__background {
    position: absolute;
    inset: 0;
    z-index: 1;
}

.dev-product-card__bg-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    filter: blur(15px);
    scale: 1.15; /* Evita bordas do blur */
}

/* Overlay escuro sutil */
.dev-product-card__overlay {
    position: absolute;
    inset: 0;
    background: rgba(0, 0, 0, 0.25);
    z-index: 2;
}

/* Modal central com glassmorphism */
.dev-product-card__modal {
    position: absolute;
    inset: 0;
    z-index: 3;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 48px;
    padding: 40px 24px;
}

/* Frame com brackets decorativos */
.dev-product-card__frame {
    position: relative;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.8);
    border-radius: 16px;
    padding: 40px 32px;
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.25);
    max-width: 90%;
}

@media (min-width: 768px) {
    .dev-product-card__frame {
        padding: 48px 40px;
    }
}

/* Brackets nos 4 cantos do frame */
.dev-product-card__frame::before,
.dev-product-card__frame::after,
.dev-product-card__badge::before,
.dev-product-card__badge::after {
    content: '';
    position: absolute;
    width: 32px;
    height: 32px;
    border: 5px solid #EAFE67;
}

/* Canto superior esquerdo */
.dev-product-card__frame::before {
    top: -2px;
    left: -2px;
    border-right: none;
    border-bottom: none;
}

/* Canto superior direito */
.dev-product-card__frame::after {
    top: -2px;
    right: -2px;
    border-left: none;
    border-bottom: none;
}

/* Canto inferior esquerdo */
.dev-product-card__badge::before {
    bottom: -2px;
    left: -2px;
    border-right: none;
    border-top: none;
}

/* Canto inferior direito */
.dev-product-card__badge::after {
    bottom: -2px;
    right: -2px;
    border-left: none;
    border-top: none;
}

/* Badge "PRODUTO EM DESENVOLVIMENTO" */
.dev-product-card__badge {
    position: relative;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    font-size: 18px;
    color: #EAFE67;
    text-transform: uppercase;
    text-align: center;
    letter-spacing: 1.5px;
    line-height: 1.4;
    display: block;
    text-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
}

@media (min-width: 768px) {
    .dev-product-card__badge {
        font-size: 20px;
        letter-spacing: 2px;
    }
}

@media (min-width: 1024px) {
    .dev-product-card__badge {
        font-size: 22px;
    }
}

/* CTA Button */
.dev-product-card__cta {
    display: inline-block;
    padding: 16px 40px;
    background-color: #000000;
    color: #EAFE67;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 1.2px;
    border-radius: 8px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.3);
    text-decoration: none;
}

.dev-product-card__cta:hover {
    background-color: #1a1a1a;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4);
    color: #EAFE67;
    text-decoration: none;
}

@media (min-width: 768px) {
    .dev-product-card__cta {
        padding: 18px 50px;
        font-size: 16px;
    }
}

/* Newsletter Section */
.dev-products-newsletter {
    background-color: #EAFE67;
    padding: 100px 20px;
}

.dev-products-newsletter__container {
    max-width: 800px;
    margin: 0 auto;
}

.dev-products-newsletter__content {
    text-align: center;
}

.dev-products-newsletter__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    font-size: 32px;
    color: #000000;
    margin: 0 0 16px 0;
    text-transform: uppercase;
    letter-spacing: 1px;
}

@media (min-width: 768px) {
    .dev-products-newsletter__title {
        font-size: 42px;
    }
}

.dev-products-newsletter__text {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 400;
    font-size: 16px;
    color: #333333;
    margin: 0 0 40px 0;
    line-height: 1.6;
}

@media (min-width: 768px) {
    .dev-products-newsletter__text {
        font-size: 18px;
    }
}

/* Newsletter Form */
.dev-products-newsletter__form {
    display: flex;
    flex-direction: column;
    gap: 16px;
    max-width: 500px;
    margin: 0 auto;
}

@media (min-width: 768px) {
    .dev-products-newsletter__form {
        flex-direction: row;
        align-items: center;
        gap: 16px;
    }
}

.dev-products-newsletter__input {
    flex: 1;
    padding: 16px 20px;
    border: 2px solid #000000;
    background-color: #FFFFFF;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 16px;
    color: #000000;
    border-radius: 8px;
    outline: none;
    transition: all 0.3s ease;
}

.dev-products-newsletter__input::placeholder {
    color: rgba(0, 0, 0, 0.5);
}

.dev-products-newsletter__input:focus {
    border-color: #000000;
    box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.1);
}

.dev-products-newsletter__btn {
    padding: 16px 32px;
    background-color: #000000;
    color: #FFFFFF;
    border: 2px solid #000000;
    border-radius: 8px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 1px;
    cursor: pointer;
    transition: all 0.3s ease;
    white-space: nowrap;
}

.dev-products-newsletter__btn:hover {
    background-color: #1a1a1a;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}

/* Alert messages */
.dev-products-newsletter .alert {
    max-width: 500px;
    margin: 0 auto 24px;
    padding: 16px 20px;
    border-radius: 8px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
}

.dev-products-newsletter .alert-success {
    background-color: rgba(0, 0, 0, 0.1);
    color: #000000;
    border: 2px solid #000000;
}

.dev-products-newsletter .alert-danger {
    background-color: rgba(255, 0, 0, 0.1);
    color: #cc0000;
    border: 2px solid #cc0000;
}

/* Responsive - Mobile Adjustments */
@media (max-width: 767px) {
    .dev-products-newsletter {
        padding: 60px 20px !important; /* Padding uniforme */
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .dev-products-newsletter__container {
        max-width: 100% !important;
        width: 100% !important;
        margin: 0 auto !important;
        padding: 0 !important;
        display: flex;
        justify-content: center;
    }

    .dev-products-newsletter__content {
        text-align: center !important;
        width: 100% !important;
        max-width: 100% !important;
        margin: 0 auto !important;
        padding: 0 16px !important;
        display: flex;
        flex-direction: column;
        align-items: center;
        box-sizing: border-box;
    }

    .dev-products-newsletter__title {
        font-size: 24px !important;
        margin: 0 auto 12px auto !important;
        letter-spacing: 0.5px;
        line-height: 1.2;
        text-align: center !important;
        width: 100%;
    }

    .dev-products-newsletter__text {
        font-size: 14px !important;
        margin: 0 auto 24px auto !important;
        padding: 0 !important;
        line-height: 1.5;
        text-align: center !important;
        width: 100%;
        max-width: 100%;
    }

    .dev-products-newsletter__form {
        flex-direction: column !important;
        gap: 12px !important;
        max-width: 100% !important;
        width: 100% !important;
        padding: 0 !important;
        margin: 0 auto !important;
        display: flex !important;
        align-items: center !important;
    }

    .dev-products-newsletter__input {
        width: 100% !important;
        max-width: 100% !important;
        padding: 14px 16px !important;
        font-size: 14px !important;
        box-sizing: border-box !important;
        margin: 0 auto !important;
        display: block !important;
    }

    .dev-products-newsletter__btn {
        width: 100% !important;
        max-width: 100% !important;
        padding: 14px 24px !important;
        font-size: 13px !important;
        box-sizing: border-box !important;
        margin: 0 auto !important;
        display: block !important;
    }

    .dev-products-newsletter .alert {
        max-width: 100% !important;
        width: 100% !important;
        margin: 0 auto 20px auto !important;
        padding: 14px 16px !important;
        font-size: 13px !important;
        box-sizing: border-box !important;
    }
}

/* ============================================
   PÁGINAS DE PESQUISA E CATEGORIA - PATAGANG
   Degradê idêntico ao PDP para consistência visual
   ============================================ */

/* Estilos compartilhados - DEGRADÊ PARA O FOOTER */
.pg-search-page,
.pg-category-page {
    min-height: 60vh;
    /* DEGRADÊ IGUAL AO PDP - Branco no topo, conecta com footer amarelo */
    background: linear-gradient(180deg,
        #FFFFFF 0%,           /* Topo - branco */
        #FFFFFF 40%,          /* Mantém branco na área dos produtos */
        #F5F5DC 60%,          /* Transição para tom creme/bege */
        #E8F5A3 80%,          /* Amarelo bem claro */
        #EAFE67 100%          /* Conecta com início do footer amarelo */
    );
    padding: 100px 0 60px;
    padding-bottom: 0; /* Sem padding inferior - degradê conecta direto */
    position: relative;
}

/* MARCA D'ÁGUA DO CACHORRO - Fundo da página */
.pg-page-watermark {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 400px;
    height: 400px;
    object-fit: contain;
    opacity: 0.08;
    pointer-events: none;
    z-index: 0;
}

@media (min-width: 992px) {
    .pg-page-watermark {
        width: 500px;
        height: 500px;
        opacity: 0.06;
    }
}

@media (min-width: 1200px) {
    .pg-page-watermark {
        width: 600px;
        height: 600px;
        opacity: 0.05;
    }
}

.pg-search-page__container,
.pg-category-page__container {
    max-width: 1400px; /* Mais largo para produtos maiores */
    margin: 0 auto;
    padding: 0 32px;
    padding-bottom: 80px; /* Espaço antes do footer */
    position: relative;
    z-index: 1;
}

/* Header */
.pg-search-page__header,
.pg-category-page__header {
    text-align: center;
    margin-bottom: 48px;
}

/* Título - PADRÃO PATAGANG com fonte display */
.pg-search-page__title,
.pg-category-page__title {
    font-family: 'Familjen Grotesk', 'Bebas Neue', Impact, sans-serif;
    font-size: 56px;
    font-weight: 700;
    color: #000;
    margin: 0 0 16px;
    text-transform: uppercase;
    letter-spacing: 4px;
    line-height: 1.1;
    /* Estilo bold/impacto característico da Patagang */
    text-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.pg-search-page__term {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 18px;
    color: #333;
    margin: 0;
    font-weight: 500;
}

.pg-category-page__description {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 18px;
    color: #333;
    margin: 0;
    max-width: 700px;
    margin: 0 auto;
    line-height: 1.6;
}

/* Banner */
.pg-category-page__banner {
    margin-bottom: 48px;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 8px 32px rgba(0,0,0,0.08);
}

/* Controles */
.pg-category-page__controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 32px;
    padding: 18px 24px;
    background: rgba(255, 255, 255, 0.7);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.04);
}

.pg-filter-btn {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    font-weight: 600;
    color: #000;
    text-decoration: none;
    padding: 12px 20px;
    background: #fff;
    border-radius: 10px;
    transition: all 0.25s ease;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.pg-filter-btn:hover {
    background: #000;
    color: #fff;
    transform: translateY(-1px);
}

.pg-category-page__applied-filters {
    margin-bottom: 28px;
}

/* Resultados */
.pg-search-page__results,
.pg-category-page__results {
    margin-top: 24px;
}

.pg-search-page__count {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 15px;
    color: #666;
    margin-bottom: 24px;
    text-align: center;
}

/* Grid de Produtos - MÁXIMO 4 COLUNAS, CENTRALIZADOS - Estilo PATAGANG */
.pg-product-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center; /* CENTRALIZA cards quando menos de 4 */
    align-items: stretch; /* Garante que todos os cards tenham a mesma altura */
    gap: 32px;
    max-width: 1400px;
    margin: 0 auto;
}

/* ============================================
   CARD DE PRODUTO - GLASSMORPHISM PATAGANG
   Cards maiores, centralizados, máximo 4 por linha
   ============================================ */

/* Container do item de produto - CARD MINIMALISTA E IMPACTANTE */
.pg-product-grid .item-product {
    background: #FFFFFF;
    border-radius: 16px;
    padding: 16px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    border: 1px solid rgba(0, 0, 0, 0.06);
    /* LARGURA FIXA - Máximo 4 por linha */
    flex: 0 0 calc(25% - 24px); /* 4 colunas com gap */
    max-width: calc(25% - 24px);
    min-width: 280px; /* Mínimo para não ficar muito pequeno */
    text-align: center; /* CENTRALIZA textos */
    /* FLEX COLUMN - Para alinhar botões na base */
    display: flex !important;
    flex-direction: column;
    overflow: hidden;
}

/* Quickshop container também precisa ser flex para herdar comportamento */
.pg-product-grid .item-product .js-quickshop-container {
    display: flex;
    flex-direction: column;
    flex: 1;
}

.pg-product-grid .item-product:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 32px rgba(0, 0, 0, 0.12);
    border-color: rgba(0, 0, 0, 0.1);
}

/* Imagem do produto - MINIMALISTA E CLEAN */
.pg-product-grid .item-image {
    border-radius: 12px;
    overflow: hidden;
    margin-bottom: 16px;
    background: #F9F9F9;
}

.pg-product-grid .item-image img {
    border-radius: 12px;
    transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
    width: 100%;
}

.pg-product-grid .item-product:hover .item-image img {
    transform: scale(1.06);
}

/* Info Card - Container das informações - CENTRALIZADO */
.pg-product-grid .item-description {
    background: rgba(255, 255, 255, 0.55);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    border-radius: 14px;
    padding: 16px 18px;
    margin-top: 14px;
    text-align: center; /* CENTRALIZA */
}

/* Nome do produto - CENTRALIZADO */
.pg-product-grid .item-name {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    color: #000;
    line-height: 1.4;
    margin-bottom: 10px !important;
    text-align: center;
}

/* Container de preço - CENTRALIZADO */
.pg-product-grid .item-price-container {
    display: flex;
    align-items: center;
    justify-content: center; /* CENTRALIZA */
    gap: 12px;
    flex-wrap: wrap;
}

/* Preço principal - MAIOR */
.pg-product-grid .item-price {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 18px;
    font-weight: 700;
    color: #000;
    letter-spacing: 0.3px;
}

/* Preço comparativo (riscado) */
.pg-product-grid .price-compare {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    color: #888;
    text-decoration: line-through;
}

/* Link do item - remove underline */
.pg-product-grid .item-link {
    text-decoration: none !important;
    display: block;
    text-align: center;
}

/* Parcelamento - CENTRALIZADO */
.pg-product-grid .item-installments {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 12px;
    color: #666;
    margin-top: 8px;
    text-align: center;
}

/* Botão de ação (adicionar ao carrinho) - CENTRALIZADO E ALINHADO NA BASE */
.pg-product-grid .item-actions {
    margin-top: auto !important; /* Empurra para o final do card */
    padding-top: 16px;
    text-align: center;
}

/* BOTÃO PADRÃO PATAGANG - Igual ao botão da HOME */
.pg-product-grid .item-actions .btn {
    width: 100%;
    min-height: 48px; /* Altura padrão fixa para alinhamento */
    background: #EAFE67; /* Amarelo neon */
    color: #000; /* Texto preto */
    border-radius: 4px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 700; /* Bold igual home */
    text-transform: uppercase;
    letter-spacing: 0.05em; /* Igual home */
    padding: 14px 20px;
    transition: all 0.2s ease;
    border: none; /* Sem borda - igual home */
    box-shadow: none; /* Sem sombra - igual home */
    display: flex;
    align-items: center;
    justify-content: center;
    line-height: 1.3;
}

.pg-product-grid .item-actions .btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    color: #000;
}

.pg-product-grid .item-actions .btn:active {
    transform: translateY(0);
    box-shadow: none;
}

/* Labels (desconto, novo, etc) */
.pg-product-grid .labels {
    position: absolute;
    top: 10px;
    left: 10px;
    z-index: 5;
    display: flex;
    flex-direction: column;
    gap: 6px;
}

.pg-product-grid .label {
    background: #000;
    color: #fff;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 10px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding: 5px 10px;
    border-radius: 6px;
}

.pg-product-grid .label-accent {
    background: #EAFE67;
    color: #000;
}

/* ============================================
   BOTÃO PRODUTO EM DESENVOLVIMENTO - GRID
   Texto "SEJA O PRIMEIRO A CONHECER"
   Estilo IMPACTANTE igual ao botão padrão
   ============================================ */

/* Botão especial para produtos em desenvolvimento - Igual ao botão da HOME */
.pg-product-grid .btn-development {
    width: 100%;
    min-height: 48px; /* Mesma altura padrão para alinhamento */
    background: #EAFE67; /* Amarelo neon */
    color: #000; /* Texto preto */
    border-radius: 4px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 11px; /* Menor para caber o texto longo */
    font-weight: 700; /* Bold igual home */
    text-transform: uppercase;
    letter-spacing: 0.05em; /* Igual home */
    padding: 14px 12px;
    transition: all 0.2s ease;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
    border: none; /* Sem borda - igual home */
    box-shadow: none; /* Sem sombra - igual home */
    line-height: 1.3;
}

.pg-product-grid .btn-development:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    color: #000;
}

.pg-product-grid .btn-development:active {
    transform: translateY(0);
    box-shadow: none;
}

/* Responsivo mobile */
@media (max-width: 768px) {
    .pg-product-grid .btn-development {
        font-size: 9px;
        padding: 12px 10px;
        min-height: 44px;
    }
}

/* Estado Vazio */
.pg-search-page__empty,
.pg-category-page__empty {
    text-align: center;
    padding: 100px 32px;
    background: rgba(255, 255, 255, 0.6);
    border-radius: 28px;
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    box-shadow: 0 8px 32px rgba(0,0,0,0.06);
}

.pg-search-page__empty-icon,
.pg-category-page__empty-icon {
    color: #000;
    margin-bottom: 28px;
    opacity: 0.4;
}

.pg-search-page__empty-title,
.pg-category-page__empty-title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 32px;
    font-weight: 700;
    color: #000;
    margin: 0 0 16px;
}

.pg-search-page__empty-text,
.pg-category-page__empty-text {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 17px;
    color: #666;
    margin: 0 0 36px;
    line-height: 1.6;
}

.pg-search-page__empty-btn,
.pg-category-page__empty-btn {
    display: inline-block;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    font-weight: 600;
    color: #fff;
    background: #000;
    padding: 16px 36px;
    border-radius: 50px;
    text-decoration: none;
    text-transform: uppercase;
    letter-spacing: 1.2px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 16px rgba(0,0,0,0.15);
}

.pg-search-page__empty-btn:hover,
.pg-category-page__empty-btn:hover {
    background: #333;
    transform: translateY(-2px);
    box-shadow: 0 6px 24px rgba(0,0,0,0.2);
}

/* Responsivo - Desktop menor / Tablet grande */
@media (max-width: 1200px) {
    /* 3 colunas em telas médias */
    .pg-product-grid .item-product {
        flex: 0 0 calc(33.333% - 22px);
        max-width: calc(33.333% - 22px);
    }
}

/* Responsivo - Tablet */
@media (max-width: 992px) {
    .pg-search-page,
    .pg-category-page {
        padding-top: 90px;
    }

    .pg-product-grid {
        gap: 24px;
    }

    /* 2 colunas em tablet */
    .pg-product-grid .item-product {
        flex: 0 0 calc(50% - 12px);
        max-width: calc(50% - 12px);
        min-width: 240px;
    }

    .pg-search-page__container,
    .pg-category-page__container {
        padding: 0 24px;
        padding-bottom: 60px;
    }

    .pg-search-page__title,
    .pg-category-page__title {
        font-size: 42px;
        letter-spacing: 2px;
    }
}

/* Responsivo - Mobile */
@media (max-width: 768px) {
    .pg-search-page,
    .pg-category-page {
        padding-top: 80px;
    }

    .pg-search-page__title,
    .pg-category-page__title {
        font-size: 32px;
        letter-spacing: 1.5px;
    }

    .pg-category-page__controls {
        flex-direction: column;
        gap: 14px;
        padding: 16px;
    }

    .pg-product-grid {
        gap: 16px;
    }

    /* 2 colunas em mobile */
    .pg-product-grid .item-product {
        flex: 0 0 calc(50% - 8px);
        max-width: calc(50% - 8px);
        min-width: 150px;
        padding: 12px;
        border-radius: 18px;
    }

    .pg-product-grid .item-image {
        border-radius: 14px;
        margin-bottom: 12px;
    }

    .pg-product-grid .item-description {
        padding: 12px 14px;
        border-radius: 12px;
    }

    .pg-product-grid .item-name {
        font-size: 12px;
        letter-spacing: 0.5px;
    }

    .pg-product-grid .item-price {
        font-size: 15px;
    }

    .pg-product-grid .item-actions .btn {
        padding: 12px 18px;
        font-size: 11px;
    }

    .pg-search-page__empty,
    .pg-category-page__empty {
        padding: 60px 24px;
        border-radius: 20px;
    }

    .pg-search-page__empty-title,
    .pg-category-page__empty-title {
        font-size: 24px;
    }
}

/* Responsivo - Mobile pequeno */
@media (max-width: 480px) {
    .pg-search-page__title,
    .pg-category-page__title {
        font-size: 26px;
        letter-spacing: 1px;
    }

    /* 1 coluna em mobile pequeno - CENTRALIZADO */
    .pg-product-grid {
        gap: 20px;
    }

    .pg-product-grid .item-product {
        flex: 0 0 100%;
        max-width: 320px; /* Limita largura para não ficar muito grande */
        min-width: auto;
        padding: 14px;
    }
}

/* ============================================
   PÁGINAS INSTITUCIONAIS - PATAGANG
   Layout padronizado igual à página /comunidade
   Formatação clean e consistente em todas as páginas
   ============================================ */

.pg-page {
    min-height: 100vh;
    padding: 100px 0 0;
    position: relative;
    /* FUNDO CLARO com degradê suave para o footer amarelo - igual página de produto */
    background: linear-gradient(180deg,
        #FFFFFF 0%,           /* Topo - branco */
        #FFFFFF 50%,          /* Mantém branco na área do conteúdo */
        #F5F5DC 70%,          /* Transição para tom creme/bege */
        #E8F5A3 85%,          /* Amarelo bem claro */
        #EAFE67 100%          /* Conecta com início do footer amarelo */
    );
}

/* ============================================
   RESET TOTAL - Remove TODA formatação inline do admin Nuvemshop
   Garante que o conteúdo editado seja limpo e padronizado
   ============================================ */
.pg-page__content,
.pg-page__content *,
.pg-page .user-content,
.pg-page .user-content * {
    /* Remove backgrounds */
    background: transparent !important;
    background-color: transparent !important;
    /* Remove cores de texto inline - força preto */
    color: inherit !important;
    /* Remove fontes inline - usa a fonte padrão */
    font-family: inherit !important;
}

/* Exceção: Links mantêm comportamento próprio */
.pg-page__content a,
.pg-page .user-content a {
    color: #000 !important;
}

/* Exceção: Cabeçalhos de tabela */
.pg-page__content th,
.pg-page .user-content th {
    color: #fff !important;
    background: #000 !important;
}

/* Remove spans vazios e formata spans com texto */
.pg-page__content span,
.pg-page .user-content span {
    font-size: inherit !important;
    line-height: inherit !important;
    letter-spacing: inherit !important;
    font-weight: inherit !important;
    display: inline !important;
}

/* Marca d'água do cachorro - centralizada */
.pg-page__watermark {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 50vw;
    max-width: 450px;
    height: auto;
    opacity: 0.06;
    pointer-events: none;
    z-index: 0;
}

/* Container - MAIS LARGO, apenas margens */
.pg-page__container {
    max-width: 1100px;
    margin: 0 auto;
    padding: 0 48px 120px; /* Padding maior para dar espaço ao gradiente */
    position: relative;
    z-index: 1;
}

/* Título GRANDE e impactante */
.pg-page__title {
    font-family: 'Familjen Grotesk', Impact, sans-serif;
    font-size: 72px;
    font-weight: 800;
    color: #000;
    text-transform: uppercase;
    letter-spacing: 8px;
    line-height: 1;
    margin: 0 0 48px;
    text-align: center;
}

/* ============================================
   CONTEÚDO - Formatação limpa e padronizada
   Igual página /comunidade
   ============================================ */

.pg-page__content {
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 15px;
    line-height: 1.8;
    color: #111;
}

/* Títulos - Padronizados com estilo Patagang */
.pg-page__content h1,
.pg-page__content h2,
.pg-page__content h3,
.pg-page__content h4,
.pg-page__content h5,
.pg-page__content h6 {
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-weight: 800 !important;
    color: #000 !important;
    text-transform: uppercase;
    letter-spacing: 3px;
    margin: 48px 0 20px;
    line-height: 1.2;
    /* Remove qualquer formatação inline */
    background: transparent !important;
}

.pg-page__content h1 { font-size: 32px !important; }
.pg-page__content h2 { font-size: 26px !important; }
.pg-page__content h3 { font-size: 22px !important; }
.pg-page__content h4 { font-size: 18px !important; }
.pg-page__content h5 { font-size: 16px !important; }
.pg-page__content h6 { font-size: 14px !important; }

/* Primeiro elemento sem margin-top */
.pg-page__content > *:first-child {
    margin-top: 0 !important;
}

/* Parágrafos - Limpos e espaçados */
.pg-page__content p {
    margin: 0 0 10px;
    font-size: 15px;
    line-height: 1.6;
    /* Remove qualquer formatação inline */
    text-align: left;
}

/* Parágrafos vazios (linha em branco) */
.pg-page__content p:empty,
.pg-page__content p br:only-child {
    display: block;
    height: 0.5em;
    margin: 0;
}

/* Links - Destaque amarelo Patagang */
.pg-page__content a {
    color: #000 !important;
    font-weight: 600;
    text-decoration: underline;
    text-decoration-color: #EAFE67;
    text-decoration-thickness: 3px;
    text-underline-offset: 4px;
    transition: all 0.2s ease;
    background: transparent !important;
}

.pg-page__content a:hover {
    background: #EAFE67 !important;
}

/* Listas - Bem formatadas */
.pg-page__content ul,
.pg-page__content ol {
    margin: 0 0 24px;
    padding-left: 24px;
}

.pg-page__content li {
    margin-bottom: 10px;
    line-height: 1.7;
    font-size: 15px;
}

/* Citações - Estilo editorial */
.pg-page__content blockquote {
    margin: 32px 0;
    padding: 24px 32px;
    background: transparent !important;
    border-left: 4px solid #000;
    font-weight: 600;
    font-style: normal;
    color: #000 !important;
}

/* Negrito - Destaque sutil */
.pg-page__content strong,
.pg-page__content b {
    font-weight: 700 !important;
    color: #000 !important;
}

/* Itálico - Convertido para semi-bold (mais clean) */
.pg-page__content em,
.pg-page__content i {
    font-style: normal;
    font-weight: 600;
}

/* Divs internas - Limpa qualquer formatação */
.pg-page__content div {
    background: transparent !important;
    margin: 0;
    padding: 0;
}

/* Separadores - Minimalista */
.pg-page__content hr {
    border: none;
    height: 3px;
    background: #000 !important;
    margin: 48px 0;
    max-width: 100px;
}

/* Tabelas - Estilo editorial */
.pg-page__content table {
    width: 100%;
    margin: 32px 0;
    border-collapse: collapse;
    background: transparent !important;
}

.pg-page__content th,
.pg-page__content td {
    padding: 14px 18px;
    text-align: left;
    border-bottom: 2px solid rgba(0,0,0,0.1);
}

.pg-page__content th {
    background: #000 !important;
    color: #fff !important;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.pg-page__content td {
    background: transparent !important;
}

/* Imagens - Sem bordas ou sombras */
.pg-page__content img {
    max-width: 100%;
    height: auto;
    margin: 24px 0;
    border: none !important;
    box-shadow: none !important;
}

/* ============================================
   ELEMENTOS ESPECIAIS - Limpeza de formatação
   ============================================ */

/* Remove qualquer classe de cor do editor */
.pg-page__content [style*="color"],
.pg-page__content [style*="background"],
.pg-page__content [style*="font-family"],
.pg-page__content [style*="font-size"] {
    color: inherit !important;
    background: transparent !important;
    font-family: inherit !important;
    font-size: inherit !important;
}

/* Remove formatação de fonte específica comum no editor Nuvemshop */
.pg-page__content font {
    font-family: inherit !important;
    font-size: inherit !important;
    color: inherit !important;
}

/* Código inline - Destaque sutil */
.pg-page__content code {
    background: rgba(0,0,0,0.05) !important;
    padding: 2px 6px;
    font-family: 'Monaco', 'Consolas', monospace !important;
    font-size: 0.9em;
}

/* Preformatado */
.pg-page__content pre {
    background: rgba(0,0,0,0.03) !important;
    padding: 20px;
    overflow-x: auto;
    margin: 24px 0;
}

/* Sublinhado - Estilo Patagang com amarelo */
.pg-page__content u {
    text-decoration: underline;
    text-decoration-color: #EAFE67;
    text-decoration-thickness: 2px;
    text-underline-offset: 3px;
}

/* ============================================
   RESPONSIVO
   ============================================ */

@media (max-width: 992px) {
    .pg-page__container {
        padding: 0 36px 100px;
    }

    .pg-page__title {
        font-size: 56px;
        letter-spacing: 5px;
    }
}

@media (max-width: 768px) {
    .pg-page {
        padding-top: 80px;
        /* Gradiente ajustado para mobile */
        background: linear-gradient(180deg,
            #FFFFFF 0%,
            #FFFFFF 40%,
            #F5F5DC 65%,
            #E8F5A3 85%,
            #EAFE67 100%
        );
    }

    .pg-page__container {
        padding: 0 24px 80px;
    }

    .pg-page__title {
        font-size: 42px !important;
        letter-spacing: 4px;
        margin-bottom: 36px;
    }

    .pg-page__content {
        font-size: 14px;
    }

    .pg-page__content p,
    .pg-page__content li {
        font-size: 16px;
    }

    .pg-page__content h1 { font-size: 26px !important; }
    .pg-page__content h2 { font-size: 22px !important; }
    .pg-page__content h3 { font-size: 18px !important; }
    .pg-page__content h4 { font-size: 16px !important; }

    .pg-page__watermark {
        width: 70vw;
        opacity: 0.05;
    }
}

@media (max-width: 480px) {
    .pg-page__container {
        padding: 0 20px 60px;
    }

    .pg-page__title {
        font-size: 32px !important;
        letter-spacing: 3px;
        margin-bottom: 28px;
    }

    .pg-page__content {
        font-size: 15px;
    }

    .pg-page__content p,
    .pg-page__content li {
        font-size: 14px;
    }

    .pg-page__content blockquote {
        padding: 18px 20px;
        margin: 24px 0;
    }

    /* Títulos ainda menores em mobile pequeno */
    .pg-page__content h1 { font-size: 22px !important; }
    .pg-page__content h2 { font-size: 20px !important; }
    .pg-page__content h3 { font-size: 17px !important; }
}

/* ============================================
   PÁGINAS DE TEXTO PADRONIZADAS - PATAGANG
   Contato, Blog, 404, etc.
   ============================================ */

/* Container mais largo para grids */
.pg-page__container--wide {
    max-width: 1200px;
}

/* ============================================
   CONTATO - Informações estilizadas
   ============================================ */

.pg-text-contact {
    display: flex;
    flex-direction: column;
    gap: 20px;
    margin-bottom: 48px;
    padding-bottom: 32px;
    border-bottom: 2px solid rgba(0,0,0,0.1);
}

.pg-text-contact__item {
    display: flex;
    align-items: center;
    gap: 16px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 18px;
    color: #000;
}

.pg-text-contact__icon {
    width: 28px;
    height: 28px;
    flex-shrink: 0;
    fill: #000;
}

.pg-text-contact__item a {
    color: #000;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.2s ease;
    border-bottom: 2px solid #EAFE67;
}

.pg-text-contact__item a:hover {
    background: #EAFE67;
}

/* ============================================
   ELEMENTOS DE TEXTO - Utilitários
   ============================================ */

.pg-text-center {
    text-align: center;
}

.pg-text-large {
    font-size: 20px;
    line-height: 1.6;
    margin-bottom: 32px;
}

.pg-text-intro {
    font-size: 18px;
    margin-bottom: 32px;
    color: #333;
}

.pg-text-notice {
    padding: 24px;
    background: rgba(234, 254, 103, 0.15);
    border-left: 4px solid #EAFE67;
    margin-bottom: 32px;
}

.pg-text-notice p {
    margin: 0;
}

.pg-text-link {
    color: #000;
    font-weight: 700;
    text-decoration: none;
    border-bottom: 3px solid #EAFE67;
    transition: all 0.2s ease;
}

.pg-text-link:hover {
    background: #EAFE67;
}

.pg-text-cta {
    margin: 40px 0;
}

.pg-text-product-info {
    margin: 24px 0;
    padding: 24px;
    background: #f8f8f8;
}

.pg-text-product-info img {
    max-width: 150px;
    margin-top: 16px;
}

/* Alertas */
.pg-text-alert {
    padding: 20px 24px;
    margin: 24px 0;
    font-weight: 500;
}

.pg-text-alert--success {
    background: rgba(34, 197, 94, 0.1);
    border-left: 4px solid #22c55e;
    color: #166534;
}

.pg-text-alert--error {
    background: rgba(239, 68, 68, 0.1);
    border-left: 4px solid #ef4444;
    color: #991b1b;
}

/* Formulário padronizado */
.pg-text-form {
    margin-top: 40px;
}

.pg-form .form-control,
.pg-form input[type="text"],
.pg-form input[type="email"],
.pg-form input[type="tel"],
.pg-form textarea {
    border: 2px solid #000;
    border-radius: 0;
    padding: 14px 16px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 16px;
    transition: all 0.2s ease;
}

.pg-form .form-control:focus,
.pg-form input:focus,
.pg-form textarea:focus {
    border-color: #EAFE67;
    box-shadow: 0 0 0 3px rgba(234, 254, 103, 0.3);
    outline: none;
}

.pg-form label {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    font-size: 13px;
    color: #000;
    margin-bottom: 8px;
}

.pg-form .btn-primary,
.pg-form button[type="submit"] {
    background: #000;
    color: #fff;
    border: none;
    padding: 16px 40px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 2px;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.pg-form .btn-primary:hover,
.pg-form button[type="submit"]:hover {
    background: #EAFE67;
    color: #000;
}

/* Botão padrão */
.pg-button {
    display: inline-block;
    background: #000;
    color: #fff;
    border: none;
    padding: 16px 40px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 2px;
    font-size: 14px;
    text-decoration: none;
    transition: all 0.2s ease;
}

.pg-button:hover {
    background: #EAFE67;
    color: #000;
}

/* ============================================
   OVERRIDE GLOBAL - BOTOES btn-primary
   Garante que TODOS os botões tenham o padrão Patagang
   ============================================ */

.btn-primary,
input.btn-primary,
button.btn-primary,
input[type="submit"].btn-primary {
    background: #000 !important;
    color: #fff !important;
    border: none !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-weight: 700 !important;
    text-transform: uppercase !important;
    letter-spacing: 1px !important;
    padding: 14px 32px !important;
    cursor: pointer;
    transition: all 0.2s ease;
    border-radius: 4px !important;
}

.btn-primary:hover,
input.btn-primary:hover,
button.btn-primary:hover,
input[type="submit"].btn-primary:hover {
    background: #EAFE67 !important;
    color: #000 !important;
}

/* ============================================
   BLOG - Estilos padronizados
   ============================================ */

.pg-blog-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 32px;
    margin-bottom: 48px;
}

/* Blog cards - Padrão original com border-radius e sombra suave */
.pg-blog-card {
    background: #fff;
    border-radius: 16px;
    overflow: hidden;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.pg-blog-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
}

.pg-blog-card__image {
    position: relative;
    height: 220px;
    overflow: hidden;
}

.pg-blog-card__image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.pg-blog-card:hover .pg-blog-card__image img {
    transform: scale(1.05);
}

.pg-blog-card__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    font-size: 20px;
    color: #000;
    padding: 24px 24px 12px;
    margin: 0;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
}

/* Remove underline amarelo dos links no título */
.pg-blog-card__title a {
    color: #000 !important;
    text-decoration: none !important;
    font-weight: 700;
}

.pg-blog-card__summary {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    color: #000;
    font-weight: 400;
    line-height: 1.6;
    padding: 0 24px 16px;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 3;
    overflow: hidden;
}

/* Remove underline amarelo dos links no summary */
.pg-blog-card__summary a {
    color: #000 !important;
    text-decoration: none !important;
    font-weight: 400;
}

.pg-blog-card__link {
    display: inline-block;
    margin: 0 24px 24px;
    background: transparent !important;
    color: #000 !important;
    padding: 10px 0;
    border-radius: 0;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    font-size: 14px;
    text-decoration: none !important;
    text-transform: uppercase;
    transition: opacity 0.2s ease;
    text-decoration-color: transparent !important;
}

.pg-blog-card__link:hover {
    opacity: 0.7;
    transform: none;
    box-shadow: none;
    background: transparent !important;
}

/* Blog Post Individual */
.pg-blog-post__date {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 2px;
    color: #666;
    margin-bottom: 24px;
}

.pg-blog-post__image {
    width: 100%;
    max-width: 100%;
    height: auto;
    margin-bottom: 32px;
}

.pg-blog-post__content {
    margin-bottom: 40px;
}

.pg-blog-share {
    padding: 24px 0;
    border-top: 2px solid rgba(0,0,0,0.1);
    border-bottom: 2px solid rgba(0,0,0,0.1);
    margin-bottom: 24px;
}

.pg-blog-back {
    margin-top: 24px;
}

.pg-pagination {
    margin-top: 40px;
    text-align: center;
}

/* ============================================
   404 - Estilos padronizados
   ============================================ */

.pg-404-products {
    margin-top: 60px;
    padding-top: 40px;
    border-top: 2px solid rgba(0,0,0,0.1);
}

.pg-404-products__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 20px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 2px;
    margin-bottom: 32px;
}

.pg-404-products__grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 24px;
}

/* ============================================
   RESPONSIVO - Páginas de Texto
   ============================================ */

@media (max-width: 768px) {
    .pg-text-contact {
        gap: 16px;
        margin-bottom: 32px;
        padding-bottom: 24px;
    }

    .pg-text-contact__item {
        font-size: 16px;
    }

    .pg-text-contact__icon {
        width: 24px;
        height: 24px;
    }

    .pg-text-large {
        font-size: 18px;
    }

    .pg-blog-grid {
        grid-template-columns: 1fr;
        gap: 24px;
    }

    .pg-blog-card__title {
        padding: 20px 20px 10px;
        font-size: 18px;
    }

    .pg-blog-card__summary {
        padding: 0 20px 14px;
        font-size: 13px;
    }

    .pg-blog-card__link {
        margin: 0 20px 20px;
    }

    .pg-404-products__grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 16px;
    }
}

@media (max-width: 480px) {
    .pg-text-contact__item {
        font-size: 14px;
        gap: 12px;
    }

    .pg-text-notice {
        padding: 18px;
    }

    .pg-button,
    .pg-form button[type="submit"] {
        width: 100%;
        text-align: center;
    }

    .pg-404-products__grid {
        grid-template-columns: 1fr;
    }
}

/* ============================================
   PATAGANG - Página de Login
   Padrão com degradê amarelo igual ao footer
   ============================================ */

.pg-login-page {
    min-height: calc(100vh - 100px);
    background: linear-gradient(180deg,
        #FFFFFF 0%,
        #FFFFFF 50%,
        #F5FFC7 70%,
        #EAFE67 100%
    );
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    padding: 120px 20px 100px; /* Aumentado padding-top para compensar o header */
}

/* Container do Card */
.pg-login-page__container {
    width: 100%;
    max-width: 420px;
    margin: 0 auto;
}

/* Card Principal - Clean e Compacto */
.pg-login-card {
    background: #FFFFFF;
    border: 2px solid #000000;
    border-radius: 12px;
    padding: 32px 28px;
}

/* Título do Card */
.pg-login-card__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 28px;
    font-weight: 700;
    color: #000;
    margin: 0 0 6px 0;
    text-align: center;
}

.pg-login-card__subtitle {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    color: #666;
    margin: 0 0 24px 0;
    text-align: center;
}

/* Form Groups */
.pg-login-card__form {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.pg-form-group {
    display: flex;
    flex-direction: column;
    gap: 6px;
}

.pg-form-label {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 12px;
    font-weight: 600;
    color: #000;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.pg-form-input {
    width: 100%;
    padding: 12px 14px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 15px;
    color: #000;
    background: #FAFAFA;
    border: 1px solid #E0E0E0;
    border-radius: 8px;
    transition: all 0.2s ease;
    outline: none;
}

.pg-form-input:focus {
    border-color: #000;
    background: #FFFFFF;
}

.pg-form-input::placeholder {
    color: #999;
}

/* Link Esqueceu Senha */
.pg-login-card__forgot {
    text-align: center;
    margin-top: -4px;
}

.pg-login-card__link {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    color: #000;
    text-decoration: underline;
    text-underline-offset: 2px;
    transition: all 0.2s ease;
    cursor: pointer;
}

.pg-login-card__link:hover {
    opacity: 0.7;
}

/* Botão Principal */
.pg-login-card__button {
    width: 100%;
    padding: 14px 20px;
    background: #000000;
    color: #FFFFFF;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.2s ease;
    margin-top: 4px;
}

.pg-login-card__button:hover {
    background: #EAFE67;
    color: #000000;
}

/* Seção Criar Conta */
.pg-login-card__register {
    margin-top: 24px;
    padding-top: 20px;
    border-top: 1px solid #E0E0E0;
    text-align: center;
}

.pg-login-card__register p {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    color: #666;
    margin: 0 0 10px 0;
}

.pg-login-card__register-link {
    display: inline-block;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 600;
    color: #000;
    text-decoration: none;
    padding: 10px 24px;
    background: transparent;
    border: 1px solid #000;
    border-radius: 6px;
    transition: all 0.2s ease;
}

.pg-login-card__register-link:hover {
    background: #000;
    color: #fff;
}

/* Alertas */
.pg-login-card__messages {
    margin-bottom: 24px;
}

.pg-alert {
    padding: 14px 18px;
    border-radius: 8px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    margin-bottom: 12px;
}

.pg-alert p {
    margin: 0;
}

.pg-alert--success {
    background: #D4EDDA;
    border: 1px solid #28A745;
    color: #155724;
}

.pg-alert--error {
    background: #F8D7DA;
    border: 1px solid #DC3545;
    color: #721C24;
}

.pg-alert--warning {
    background: #FFF3CD;
    border: 1px solid #FFC107;
    color: #856404;
}

/* Responsividade Login */
@media (max-width: 768px) {
    .pg-login-page {
        padding: 100px 16px 80px; /* Mantém padding-top adequado no tablet */
        min-height: calc(100vh - 100px);
    }

    .pg-login-card {
        padding: 28px 24px;
    }

    .pg-login-card__title {
        font-size: 24px;
    }
}

@media (max-width: 480px) {
    .pg-login-page {
        padding: 90px 12px 60px; /* Padding-top menor no mobile mas ainda suficiente */
    }

    .pg-login-card {
        padding: 24px 20px;
        border-radius: 10px;
    }

    .pg-login-card__title {
        font-size: 22px;
    }

    .pg-form-input {
        padding: 11px 12px;
        font-size: 14px;
    }

    .pg-login-card__button {
        padding: 12px 16px;
        font-size: 13px;
    }
}

/* ============================================
   PATAGANG - NOVO CARRINHO DRAWER (CART DRAWER)
   Design: Cards flutuantes com fundo transparente
   Usa #pg-cart-drawer para especificidade
   ============================================ */

/* Drawer Base - CARRINHO */
#pg-cart-drawer {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 9999;
    pointer-events: none;
}

#pg-cart-drawer.is-open {
    pointer-events: auto;
}

/* Overlay com Blur forte - CARRINHO */
#pg-cart-drawer .pg-drawer__overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.4);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    cursor: pointer;
    opacity: 0;
    transition: opacity 0.3s ease;
}

#pg-cart-drawer.is-open .pg-drawer__overlay {
    opacity: 1;
}

/* Panel - Sólido - CARRINHO (lado direito) */
#pg-cart-drawer .pg-drawer__panel {
    position: absolute;
    top: 0;
    right: 0;
    left: auto;
    width: 100%;
    max-width: 380px;
    height: 100%;
    background: #FFFFFF;
    display: flex;
    flex-direction: column;
    transform: translateX(100%);
    transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: -15px 0 40px rgba(0, 0, 0, 0.4);
    border-right: none;
    border-left: 2px solid #000000;
}

#pg-cart-drawer.is-open .pg-drawer__panel {
    transform: translateX(0);
}

/* Header - Sólido */
.pg-drawer__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 16px 18px;
    background: #FFFFFF;
    border-bottom: 2px solid #000000;
    flex-shrink: 0;
}

.pg-drawer__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 600;
    color: #000;
    margin: 0;
    letter-spacing: 1.5px;
    text-transform: uppercase;
}

.pg-drawer__close {
    width: 28px;
    height: 28px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: none;
    border: none;
    cursor: pointer;
    color: #000;
    transition: opacity 0.2s ease;
    padding: 0;
}

.pg-drawer__close:hover {
    opacity: 0.5;
}

.pg-drawer__close svg {
    width: 16px;
    height: 16px;
}

/* Content Area - Transparente, altura automática */
.pg-drawer__content {
    flex: 1;
    overflow-y: auto;
    padding: 14px;
    background: transparent;
    -webkit-overflow-scrolling: touch;
    /* Limita altura para ~3 produtos + scroll */
    max-height: calc(100vh - 280px);
}

/* Empty State */
.pg-drawer__empty {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 200px;
    text-align: center;
    padding: 30px 20px;
}

.pg-drawer__empty-icon {
    margin-bottom: 14px;
    opacity: 0.25;
}

.pg-drawer__empty-icon svg {
    width: 48px;
    height: 48px;
}

.pg-drawer__empty-text {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    color: #666;
    margin: 0 0 16px 0;
}

.pg-drawer__empty-link {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 600;
    color: #000;
    text-decoration: underline;
    text-underline-offset: 3px;
}

/* Items Container - Compacto */
.pg-drawer__items {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

/* Loading State */
.pg-drawer__loading {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 200px;
}

.pg-drawer__spinner,
.pg-cart-card__spinner {
    width: 24px;
    height: 24px;
    border: 2px solid #E0E0E0;
    border-top-color: #000;
    border-radius: 50%;
    animation: pg-spin 0.7s linear infinite;
}

@keyframes pg-spin {
    to { transform: rotate(360deg); }
}

/* ============================================
   CART ITEM CARD - Design Brutalista Minimalista
   ============================================ */

.pg-cart-card {
    position: relative;
    display: grid;
    grid-template-columns: 100px 1fr auto;
    gap: 14px;
    align-items: start;
    background: transparent;
    border-radius: 0;
    padding: 14px 0;
    border-bottom: 1px solid #EAEAEA;
    transition: opacity 0.2s ease, transform 0.2s ease;
}

.pg-cart-card.is-loading {
    opacity: 0.5;
    pointer-events: none;
}

.pg-cart-card.is-removing {
    transform: translateX(100%);
    opacity: 0;
}

/* Card Loading Overlay */
.pg-cart-card__loading {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.9);
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 10;
}

.pg-cart-card__spinner {
    width: 20px;
    height: 20px;
}

/* Card Image - Maior para destacar o produto */
.pg-cart-card__image {
    width: 100px;
    height: 100px;
    border-radius: 0;
    overflow: hidden;
    background: #F5F5F5;
    flex-shrink: 0;
}

.pg-cart-card__image a {
    display: block;
    width: 100%;
    height: 100%;
}

.pg-cart-card__image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* Card Info */
.pg-cart-card__info {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    gap: 4px;
    min-width: 0;
    padding-top: 2px;
}

.pg-cart-card__name {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 500;
    color: #000;
    margin: 0;
    line-height: 1.35;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.pg-cart-card__name a {
    color: inherit;
    text-decoration: none;
}

.pg-cart-card__variant {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 12px;
    color: #888;
}

/* Card Price - posicionado no canto superior direito */
.pg-cart-card__price {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    font-weight: 600;
    color: #000;
    text-align: right;
    padding-right: 20px;
    white-space: nowrap;
}

/* Remove Button - X pequeno */
.pg-cart-card__remove {
    position: absolute;
    top: 10px;
    right: 10px;
    width: 20px;
    height: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: none;
    border: none;
    cursor: pointer;
    color: #bbb;
    padding: 0;
    transition: color 0.2s ease;
}

.pg-cart-card__remove:hover {
    color: #666;
}

.pg-cart-card__remove svg {
    width: 12px;
    height: 12px;
}

/* ============================================
   QUANTITY SELECTOR - Geométrico Patagang
   ============================================ */

.pg-cart-card__qty {
    margin-top: 8px;
}

.pg-qty-pill {
    display: inline-flex;
    align-items: center;
    border: 1px solid #000000;
    border-radius: 0;
    background: transparent;
    overflow: hidden;
}

.pg-qty-pill__btn {
    width: 28px;
    height: 28px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: none;
    border: none;
    cursor: pointer;
    color: #000;
    font-size: 16px;
    font-weight: 400;
    transition: background 0.15s ease;
    padding: 0;
}

.pg-qty-pill__btn:hover {
    background: rgba(0, 0, 0, 0.05);
}

.pg-qty-pill__btn:active {
    background: rgba(0, 0, 0, 0.1);
}

.pg-qty-pill__btn span {
    line-height: 1;
}

.pg-qty-pill__input {
    width: 28px;
    height: 28px;
    text-align: center;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 500;
    color: #000;
    background: none;
    border: none;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    padding: 0;
    -moz-appearance: textfield;
}

.pg-qty-pill__input::-webkit-outer-spin-button,
.pg-qty-pill__input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

/* ============================================
   DRAWER FOOTER - Fixo no bottom, sólido
   ============================================ */

.pg-drawer__footer {
    background: #FFFFFF;
    padding: 14px 18px 18px;
    flex-shrink: 0;
    border-top: 2px solid #000000;
    margin-top: auto;
}

/* Summary Rows */
.pg-drawer__summary {
    margin-bottom: 12px;
}

.pg-drawer__summary-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 5px 0;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
}

.pg-drawer__summary-row--total {
    padding-top: 8px;
    margin-top: 4px;
    border-top: 1px solid rgba(0, 0, 0, 0.08);
}

.pg-drawer__summary-label {
    color: #777;
}

.pg-drawer__summary-row--total .pg-drawer__summary-label {
    font-weight: 600;
    color: #000;
    font-size: 14px;
}

.pg-drawer__summary-value {
    font-weight: 500;
    color: #000;
}

.pg-drawer__summary-value--total {
    font-size: 15px;
    font-weight: 700;
}

.pg-drawer__summary-link {
    color: #000;
    text-decoration: underline;
    text-underline-offset: 2px;
    font-weight: 500;
    font-size: 13px;
}

.pg-drawer__summary-link:hover {
    opacity: 0.6;
}

/* Shipping Calculator no Drawer */
.pg-drawer__summary-shipping {
    margin: 8px 0 12px;
    width: 100%;
}

.pg-drawer__summary-shipping .shipping-calculator-head {
    margin: 0;
}

.pg-drawer__summary-shipping .js-shipping-calculator-form {
    width: 100%;
}

.pg-drawer__summary-shipping .form-row {
    margin: 0 !important;
}

.pg-drawer__summary-shipping .js-shipping-input {
    font-size: 12px;
    padding: 8px 10px;
    border-radius: 4px;
}

.pg-drawer__summary-shipping .js-calculate-shipping {
    font-size: 12px;
    padding: 8px 12px;
    border-radius: 4px;
}

.pg-drawer__summary-shipping .js-shipping-calculator-response {
    margin-top: 8px;
    font-size: 12px;
}

.pg-drawer__summary-shipping .shipping-option {
    padding: 8px;
    margin: 4px 0;
    background: #f9f9f9;
    border-radius: 4px;
}

.pg-drawer__summary-shipping .js-shipping-calculator-spinner {
    padding: 12px 0;
}

/* Checkout Button */
.pg-drawer__checkout-form {
    margin: 0;
}

.pg-drawer__checkout-btn {
    width: 100%;
    padding: 14px 20px;
    background: #000;
    color: #FFF;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 800;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    border: none;
    border-radius: 0;
    cursor: pointer;
    transition: all 0.2s ease;
}

.pg-drawer__checkout-btn:hover:not(:disabled) {
    background: #222;
}

.pg-drawer__checkout-btn:disabled {
    opacity: 0.4;
    cursor: not-allowed;
}

/* Minimum Alert */
.pg-drawer__minimum-alert {
    margin-top: 8px;
    padding: 8px 12px;
    background: rgba(255, 243, 205, 0.9);
    border-radius: 6px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 11px;
    color: #856404;
    text-align: center;
}

/* ============================================
   RESPONSIVIDADE CART DRAWER
   ============================================ */

@media (max-width: 480px) {
    #pg-cart-drawer .pg-drawer__panel {
        max-width: 100%;
    }

    .pg-drawer__header {
        padding: 14px 16px;
    }

    .pg-drawer__content {
        padding: 12px;
        max-height: calc(100vh - 260px);
    }

    .pg-drawer__items {
        gap: 10px;
    }

    .pg-cart-card {
        grid-template-columns: 85px 1fr auto;
        gap: 12px;
        padding: 12px;
        border-radius: 14px;
    }

    .pg-cart-card__image {
        width: 85px;
        height: 85px;
        border-radius: 10px;
    }

    .pg-cart-card__name {
        font-size: 13px;
    }

    .pg-cart-card__variant {
        font-size: 11px;
    }

    .pg-cart-card__price {
        font-size: 13px;
        padding-right: 18px;
    }

    .pg-qty-pill {
        border-width: 1px;
    }

    .pg-qty-pill__btn {
        width: 26px;
        height: 26px;
        font-size: 14px;
    }

    .pg-qty-pill__input {
        width: 26px;
        height: 26px;
        font-size: 12px;
    }

    .pg-drawer__footer {
        padding: 12px 14px 16px;
    }

    .pg-drawer__summary-row {
        padding: 4px 0;
        font-size: 12px;
    }

    .pg-drawer__checkout-btn {
        padding: 12px 16px;
        font-size: 11px;
    }
}

/* ============================================
   PATAGANG - MODAL CART ITEMS & SUMMARY
   Design limpo para modal nativo #modal-cart
   ============================================ */

/* Cart Item - Modal */
.pg-cart-item {
    display: flex;
    align-items: flex-start;
    gap: 12px;
    padding: 16px 0;
    border-bottom: 1px solid #eee;
    position: relative;
}

.pg-cart-item__image {
    flex-shrink: 0;
    width: 80px;
    height: 80px;
    overflow: hidden;
    border-radius: 8px;
    background: #f5f5f5;
}

.pg-cart-item__image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.pg-cart-item__content {
    flex: 1;
    min-width: 0;
}

.pg-cart-item__header {
    margin-bottom: 8px;
}

.pg-cart-item__name {
    font-size: 14px;
    font-weight: 600;
    color: #000;
    margin: 0;
    line-height: 1.3;
}

.pg-cart-item__name a {
    color: inherit;
    text-decoration: none;
}

.pg-cart-item__name a:hover {
    text-decoration: underline;
}

.pg-cart-item__variant {
    font-size: 12px;
    color: #666;
    display: block;
    margin-top: 4px;
}

.pg-cart-item__price {
    font-size: 14px;
    font-weight: 700;
    color: #000;
    margin-bottom: 8px;
}

.pg-cart-item__quantity {
    margin-top: 8px;
}

.pg-cart-item__remove {
    position: absolute;
    top: 16px;
    right: 0;
    background: none;
    border: none;
    padding: 4px;
    cursor: pointer;
    color: #999;
    transition: color 0.2s;
}

.pg-cart-item__remove:hover {
    color: #e74c3c;
}

.pg-cart-item__remove svg {
    width: 16px;
    height: 16px;
}

/* Cart Summary - Modal */
.pg-cart-summary {
    padding: 16px 0;
    border-top: 2px solid #000;
}

.pg-cart-summary__row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 8px 0;
    font-size: 14px;
}

.pg-cart-summary__row--total {
    border-top: 1px solid #eee;
    margin-top: 8px;
    padding-top: 12px;
}

.pg-cart-summary__label {
    color: #666;
}

.pg-cart-summary__label--bold {
    color: #000;
    font-size: 16px;
    font-weight: 700;
}

.pg-cart-summary__value {
    font-weight: 600;
    color: #000;
}

.pg-cart-summary__value--bold {
    font-size: 18px;
    font-weight: 700;
}

.pg-cart-summary__link {
    color: #808E25;
    text-decoration: underline;
    font-size: 14px;
    transition: color 0.2s;
}

.pg-cart-summary__link:hover {
    color: #5f6b1c;
}

.pg-cart-summary__shipping {
    padding: 12px 0;
}

/* PATAGANG: Seção de Total (completamente separada, fora do pg-cart-summary) */
.pg-cart-total-section {
    width: 100%;
    padding: 16px 0;
    margin-top: 16px;
}

.pg-cart-total-section__row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    padding: 8px 0;
}

.pg-cart-total-section__label {
    color: #000;
    font-size: 16px;
    font-weight: 700;
}

.pg-cart-total-section__value {
    color: #000;
    font-size: 18px;
    font-weight: 700;
}

.pg-cart-total-section__installments {
    padding: 8px 0 0 0;
    font-size: 13px;
    color: #666;
    width: 100%;
}

.pg-cart-total-section__installments-text {
    color: #666;
}

.pg-cart-summary__installments {
    padding: 8px 0;
    font-size: 13px;
    color: #666;
}

.pg-cart-summary__installments-text {
    color: #666;
}

/* Melhor contraste para text-accent em elementos do carrinho */
.pg-cart-summary .text-accent,
.pg-cart-item .text-accent {
    color: #5f6b1c !important; /* Versão mais escura do #808E25 para melhor contraste */
    font-weight: 600;
}

/* Labels de promoção */
.pg-cart-item__labels {
    display: flex;
    flex-wrap: wrap;
    gap: 4px;
    margin-top: 8px;
}

.pg-cart-item__label {
    font-size: 11px;
    padding: 2px 6px;
    border-radius: 3px;
    font-weight: 600;
}

.pg-cart-item__label--shipping {
    background: #e8f5e9;
    color: #2e7d32;
}

.pg-cart-item__label--promo {
    background: #fff3e0;
    color: #e65100;
}

/* CORREÇÕES ESPECÍFICAS PARA MODAL #modal-cart */

/* Força TODOS os textos em PRETO - Override agressivo */
.modal-cart *:not(.btn):not(.icon-inline):not(svg):not(path) {
    color: #000 !important;
}

/* Remove cores inline e amarelas */
.modal-cart [style*="color"],
.modal-cart .text-accent {
    color: #000 !important;
}

/* Tamanho do produto - estilo limpo sem fundo */
.pg-cart-item__variant {
    font-size: 12px;
    color: #666 !important;
    font-weight: 400;
    background: transparent;
    padding: 0;
    margin-top: 2px;
    display: block;
}

.pg-cart-item__variant::before {
    content: "Tam: ";
    font-weight: 400;
}

/* Responsivo */
@media (max-width: 767px) {
    .pg-cart-item {
        gap: 10px;
    }

    .pg-cart-item__image {
        width: 60px;
        height: 60px;
    }

    .pg-cart-item__name {
        font-size: 13px;
    }

    .pg-cart-summary__row {
        font-size: 13px;
    }

    .pg-cart-summary__value--bold {
        font-size: 16px;
    }

    .pg-cart-item__variant {
        font-size: 11px;
    }
}

/* ============================================
   CORREÇÃO DE LAYOUT - VISUAL FINAL (ESTRUTURA & DEGRADÊ)
   ============================================ */

/* 0. Fundo da Página com Degradê Conectado ao Rodapé */
body.template-search,
body.template-category {
    /* Degradê do branco para o amarelo suave da marca */
    background: linear-gradient(180deg, #FFFFFF 0%, #FCFFF0 50%, #F4FFC3 100%) !important;
    min-height: 100vh;
}

/* Espaçamento para o Header Fixo */
.template-search .page-content,
.template-category .category-header {
    padding-top: 140px;
}

@media (max-width: 768px) {
    .template-search .page-content,
    .template-category .category-header {
        padding-top: 100px;
    }
}

/* 1. Estrutura do Grid para Alinhamento */
.js-product-table.row {
    display: flex;
    flex-wrap: wrap;
}

.js-product-table.row > [class*='col-'] {
    display: flex;
    flex-direction: column;
}

/* 2. Card dos Produtos - Textura Premium (Glass/Soft) */
.item-product {
    background-color: rgba(255, 255, 255, 0.85) !important; /* Branco levemente translúcido */
    backdrop-filter: blur(12px); /* Efeito de vidro fosco */
    -webkit-backdrop-filter: blur(12px);
    border-radius: 24px;
    padding: 16px;
    display: flex;
    flex-direction: column;
    height: 100%; /* Ocupa toda a altura da coluna flex */
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    border: 1px solid rgba(255, 255, 255, 0.6); /* Borda sutil de vidro */
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.04); /* Sombra difusa premium */
    gap: 12px;
}

.item-product:hover {
    transform: translateY(-6px);
    background-color: rgba(255, 255, 255, 0.95) !important;
    box-shadow: 0 12px 40px rgba(234, 254, 103, 0.15); /* Glow amarelo muito suave */
    border-color: #fff;
}

/* Container da Imagem */
.item-image {
    background-color: #FFFFFF !important; /* Imagem em fundo branco puro para destaque */
    border-radius: 20px;
    padding: 20px;
    aspect-ratio: 1/1;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    position: relative;
    margin-bottom: 0;
    box-shadow: inset 0 0 20px rgba(0,0,0,0.02); /* Profundidade interna sutil */
}

.item-image img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    transition: transform 0.6s cubic-bezier(0.25, 0.8, 0.25, 1);
    filter: drop-shadow(0 4px 8px rgba(0,0,0,0.05));
}

.item-product:hover .item-image img {
    transform: scale(1.08);
}

/* Descrição e Alinhamento */
.item-description {
    flex-grow: 1; /* CRUCIAL: Ocupa todo o espaço vertical disponível */
    display: flex;
    flex-direction: column;
    text-align: center;
    padding: 8px 4px;
    height: auto; /* CORREÇÃO: Remove height 100% que quebrava o layout flex */
}

.item-name {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 800;
    font-size: 14px;
    line-height: 1.4;
    margin-bottom: 8px;
    color: #000;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.item-price-container {
    margin-top: auto; /* Empurra para baixo dentro da descrição */
    margin-bottom: 12px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 46px; /* Altura mínima para reservar espaço mesmo sem preço */
}

.item-price {
    font-weight: 800;
    font-size: 18px;
    color: #000;
    margin-bottom: 4px;
}

.item-installments {
    font-size: 12px;
    color: #666;
    font-weight: 400;
}

/* Botões - Alinhamento Perfeito */
.item-actions {
    margin-top: auto; /* Garante que fique no rodapé do card */
    width: 100%;
}

.item-actions .btn {
    width: 100%;
    min-height: 48px; /* Altura fixa para garantir alinhamento entre diferentes botões */
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px; /* Curvatura moderna */
    font-weight: 800;
    text-transform: uppercase;
    padding: 0 16px; /* Padding lateral */
    font-size: 12px; /* Fonte levemente menor para caber textos longos */
    letter-spacing: 1px;
    border: none;
    background-color: #EAFE67 !important;
    color: #000 !important;
    transition: all 0.2s ease;
    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    line-height: 1.2; /* Para textos que quebram linha */
}

.item-actions .btn:hover {
    background-color: #d4e655 !important;
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(234, 254, 103, 0.3);
}

/* Botão Desenvolvimento (Preto) */
/* Botão Desenvolvimento (Padronizado Amarelo) */
.item-actions .btn-development {
    background-color: #EAFE67 !important;
    color: #000 !important;
    border: none;
}

.item-actions .btn-development:hover {
    background-color: #d4e655 !important;
    color: #000 !important;
}

/* 2. Rodapé Transparente (Conectado ao Fundo) */
#layout-footer {
    background: transparent !important; /* Remove fundo próprio para usar o do body */
    border-top: none;
    padding-top: 60px;
    margin-top: 0; /* Remove margem para conectar */
    position: relative;
}

/* Linha decorativa sutil para separar visualmente */
#layout-footer::before {
    content: '';
    position: absolute;
    top: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 90%;
    height: 1px;
    background: rgba(0,0,0,0.05);
}

/* =========================================
   PATAGANG - SEARCH & CATEGORY ADJUSTMENTS
   ========================================= */

/* 1. Background Gradient for Search and Category Pages */
.category-body {
    /* Gradient from white to footer color (#CCCCCC) - matches home page footer */
    background: linear-gradient(to bottom, #ffffff 0%, #CCCCCC 100%);
    padding-bottom: 80px;
    padding-top: 40px;
}

/* 2. Product Card Alignment & Styling */
.item-product {
    display: flex;
    flex-direction: column;
    height: 100%;
    min-height: 480px; /* Ensure a minimum height for uniformity */
}

/* Ensure the link container grows to fill space */
.item-product .item-link {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}

/* Ensure description container allows growth but doesn't force height */
.item-product .item-description {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    height: auto; /* CORREÇÃO: Height auto para não esticar demais */
}

/* Push price to bottom of description area */
.item-product .item-price-container {
    margin-top: auto;
    padding-bottom: 10px;
}

/* Align Actions (Buttons) to bottom */
.item-product .item-actions {
    margin-top: auto; /* Garante que fique no rodapé do card */
    width: 100%;
    text-align: center;
    padding-top: 5px;
}

/* 3. Button Standardization (Yellow) - Matches Home CTA and Development Button */
.item-product .item-actions .btn {
    background-color: #EAFE67 !important; /* Neon Yellow (Patagang Primary) */
    color: #000000 !important;
    border: none !important;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    width: 100%;
    border-radius: 4px;
    padding: 14px 0;
    transition: all 0.3s ease;
    box-shadow: none;
    line-height: 1.3;
    display: flex;
    align-items: center;
    justify-content: center;
}

.item-product .item-actions .btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    background-color: #d4e655 !important; /* Slightly darker on hover */
}

.item-product .item-actions .btn:hover {
    background-color: #D4E600 !important;
    border-color: #D4E600 !important;
    transform: translateY(-2px);
    box-shadow: 0 4px 10px rgba(212, 230, 0, 0.3);
}

/* Ensure Development Button matches */
.item-product .item-actions .btn-development {
    background-color: #EAFE67 !important; /* Standard Neon Yellow */
    color: #000000 !important;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.item-product .item-actions .btn-development:hover {
    background-color: #d4e655 !important;
    color: #000000 !important;
}

/* ==========================================================================
   CRITICAL OVERRIDE: DEVELOPMENT BUTTON
   Forces the "SEJA O PRIMEIRO A CONHECER" button to match the standard styling.
   Uses high specificity to defeat global !important rules on .btn-primary.
   ========================================================================== */
body .item-product .item-actions .btn.btn-development,
body .pg-product-grid .item-product .item-actions .btn.btn-development,
body .item-actions .btn.btn-development {
    background: #EAFE67 !important;
    background-color: #EAFE67 !important;
    color: #000000 !important;
    font-size: 12px !important; /* Match global button size */
    font-weight: 800 !important; /* Match global button weight */
    text-transform: uppercase !important;
    letter-spacing: 1px !important; /* Match global button spacing */
    border: none !important;
    border-radius: 12px !important; /* Match global button radius */
    box-shadow: 0 4px 10px rgba(0,0,0,0.05) !important; /* Match global button shadow */
    opacity: 1 !important;
    visibility: visible !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    min-height: 48px !important;
    padding: 0 16px !important;
    line-height: 1.2 !important;
}

/* ==========================================================================
   CRITICAL FIX: PRODUCT GRID ALIGNMENT & SIZING
   Ensures perfect grid alignment with equal height cards and bottom-aligned buttons.
   ========================================================================== */

/* 1. Grid Container Override */
.pg-product-grid {
    display: flex !important;
    flex-wrap: wrap !important;
    align-items: stretch !important; /* Key for equal height */
    justify-content: center !important;
}

/* 2. Grid Item (Card) Override */
.pg-product-grid .item-product {
    display: flex !important;
    flex-direction: column !important;
    height: auto !important; /* Let flexbox control height */
    align-self: stretch !important; /* Force stretch to row height */
    float: none !important; /* Disable floats */
    margin-bottom: 0 !important; /* Let gap handle spacing */
}

/* 3. Content Expansion (Pushes footer down) */
.pg-product-grid .item-product .item-description {
    flex-grow: 1 !important;
    display: flex !important;
    flex-direction: column !important;
    justify-content: flex-start !important;
}

.pg-product-grid .item-product .item-link {
    flex-grow: 1 !important;
    display: flex !important;
    flex-direction: column !important;
}

/* 4. Action Button Alignment (Always at bottom) */
.pg-product-grid .item-product .item-actions {
    margin-top: auto !important;
    width: 100% !important;
    padding-top: 16px !important;
}

body .item-product .item-actions .btn.btn-development:hover,
body .pg-product-grid .item-product .item-actions .btn.btn-development:hover,
body .item-actions .btn.btn-development:hover {
    background: #d4e655 !important;
    background-color: #d4e655 !important;
    color: #000000 !important;
    transform: translateY(-2px) !important;
    box-shadow: 0 6px 16px rgba(234, 254, 103, 0.3) !important;
}

/* PATAGANG: Fix border on shipping calculator items */
.js-shipping-calculator-response .list-item,
.js-shipping-calculator-response .radio-button-item,
.js-shipping-calculator-response .radio-button-container {
    border: none !important;
}
#Blog
==============================================================================*/


/*============================================================================
  EXTRACTED FROM style-critical.tpl (Story 8.2 Optimization)
  Non-critical sections moved to async loading: Product Grid, Detail, Cart, Contact
==============================================================================*/

  #Product grid
==============================================================================*/

{# /* // Category controls */ #}

.category-controls-sticky-detector {
  height: 1px;
}

.category-controls {
  position: sticky;
  z-index: 100;
  padding: 15px 0;
}

{# /* // Category header */ #}

.filter-link {
  display: inline-block;
  width: 100%;
  padding: 10px 0;
}

{# /* // Grid item */ #}

.item {
  margin-bottom: 30px;      /* Reduzido de 50px para 30px */
  text-align: center;
}

/* Seção de produtos relacionados - espaçamento reduzido */
.section-products-related {
  padding: 30px 0 40px;     /* Padding vertical reduzido */
}

.section-products-related .h3,
.section-products-related .title {
  margin-bottom: 20px;      /* Espaçamento mais compacto */
  font-size: 1.5rem;
}

.item-image {
  position: relative;
  overflow: hidden;
  background: #FFFFFF;        /* Fundo branco como no protótipo */
  border-radius: 16px;        /* Bordas arredondadas */
  padding: 20px;              /* Padding ao redor da imagem */
  margin-bottom: 16px;
  display: flex;              /* Flex para centralizar */
  align-items: center;
  justify-content: center;
  aspect-ratio: 1 / 1;        /* Container quadrado */
}

.item-image img {
  width: 100%;
  height: 100%;
  object-fit: contain;        /* Mantém proporção */
  object-position: center;
  display: block;
}
.item-image-slide img{
  max-width: 100%;
  object-fit: contain;
  object-position: top;
}
.item-thumbnail {
  display: block;
  width: 100%;
}
.item-image:not(.product-item-image-secondary).lazyloaded {
  z-index: 9;
  opacity: 1;
}
.item-image-secondary,
.item-image-secondary.fade-in.lazyloaded  {
  display: none;
  opacity: 0;
}
.product-item-secondary-images-loaded:not(.product-item-secondary-images-disabled):hover .item-image-featured{
  opacity: 0;
  transition-delay: .05s;
}
.product-item-secondary-images-loaded:not(.product-item-secondary-images-disabled):hover .item-image-featured ~ .item-image-secondary {
  opacity: 1;
}
.item-colors {
  position: absolute;
  bottom: 0;
  z-index: 9;
  width: 100%;
  padding: 5px 0;
}
.item-colors-bullet {
  display: inline-block;
  min-width: 18px;
  height: 18px;
  margin: 0 3px;
  font-size: 10px;
  text-transform: uppercase;
  line-height: 19px;
  vertical-align: top;
  border-radius: 18px;
  cursor: pointer;
  opacity: 0.8;
  -webkit-transition: all 0.4s ease;
  -ms-transition: all 0.4s ease;
  -moz-transition: all 0.4s ease;
  -o-transition: all 0.4s ease;
  transition: all 0.4s ease;
}
.item-colors-bullet:hover,
.item-colors-bullet.selected {
  opacity: 1;
}
.item-name {
  font-size: 11px;
  line-height: 15px;
  text-transform: uppercase;
  letter-spacing: 1px;
  text-overflow: ellipsis;
  overflow: hidden;
  -webkit-line-clamp: 2;
  display: -webkit-box;
  -webkit-box-orient: vertical;
}
.item-price-container {
  margin-bottom: 10px;
  font-size: 12px;
}
.item-installments {
  font-size: 10px;
}
.item-product-reduced .item-image {
  height: 145px;
}
.item-product-reduced .item-image img {
  width: 100%;
  height: 145px;
  object-fit: cover;
}

.item-more-images-message {
  position: absolute;
  top: 10px;
  right: 15px;
  z-index: 1;
  opacity: 0;
  text-transform: uppercase;
  transform: initial;
  transition: all 0.2s ease;
}

{# /* // Labels */ #}

.labels {
  position: absolute;
  top: 0;
  z-index: 9;
}

.label {
  width: fit-content;
  margin-bottom: 10px;
  padding: 5px 10px;
  font-size: 12px;
  text-align: left;
}

/*============================================================================
  #Product detail
==============================================================================*/

{# /* // Image */ #}

.nube-slider-product {
  max-height: 900px;
  overflow: hidden;
}

.product-slider-image {
  width: auto;
  height: 100%;
  max-width: 100%;
  max-height: 900px;
}

.product-video-container {
  display: block;
  width: 100%;
  height: 100%;
}
.product-video {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
}
.product-video .embed-responsive {
  width: 100%;
  height: 100%;
  padding-bottom: 0;
}
.product-video .video-image{
  width: auto;
  height: 100%;
}

/*============================================================================
  #Cart detail
==============================================================================*/

{# /* // Shipping Calculator */ #}

.free-shipping-title {
  position: relative;
  width: 100%;
  height: 55px;
}
.shipping-calculator-head.with-zip {
  height: 65px;
}
.shipping-calculator-head.with-zip.with-free-shipping {
  height: 110px;
}
.shipping-calculator-head.with-form {
  height: 110px;
}
.shipping-calculator-head.with-form + .shipping-spinner-container {
  margin-top: -20px;
}
.shipping-calculator-head.with-error {
  height: 155px;
}

/*============================================================================
  #Contact page
==============================================================================*/

{# /* // Data contact */ #}

.contact-info {
  margin-top: 0;
  padding-left: 0;
}

.contact-icon {
  display: block;
  margin: 0 auto 10px auto;
}

.contact-item {
  list-style: none;
}

.contact-link {
  list-style: none;
}

/*============================================================================
