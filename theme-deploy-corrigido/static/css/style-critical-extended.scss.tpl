
.pg-header__logo:hover .pg-header__logo-img--hover {
  transform: translateY(0);
}

.pg-header__actions {
  display: flex;
  align-items: center;
  gap: var(--pg-spacing-2);
  height: 100%;
}

/* Busca inline expansvel - hover */
.pg-header__search-wrapper {
  display: flex;
  align-items: center;
  position: relative;
  height: 44px; /* Mesma altura dos botes */
}

.pg-header__search-form {
  position: absolute;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  align-items: center;
  overflow: hidden;
  width: 44px; /* Mesma largura dos botes */
  height: 44px; /* Mesma altura dos botes */
  border-radius: 6px;
  background: rgba(200, 200, 200, 0.7);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  transition: width 0.3s ease;
}

.pg-header__search-wrapper:hover .pg-header__search-form,
.pg-header__search-wrapper:focus-within .pg-header__search-form,
.pg-header__search-wrapper.is-open .pg-header__search-form {
  width: 200px;
}

@media (min-width: 768px) {
  .pg-header__search-wrapper:hover .pg-header__search-form,
  .pg-header__search-wrapper:focus-within .pg-header__search-form,
  .pg-header__search-wrapper.is-open .pg-header__search-form {
    width: 240px;
  }
}

.pg-header__search-input {
  flex: 1;
  height: 100%;
  padding: 0 8px 0 12px;
  border: none;
  background: transparent;
  font-size: 0.875rem;
  font-family: inherit;
  color: var(--pg-color-black);
  outline: none;
  min-width: 0;
  opacity: 0;
  transition: opacity 0.2s ease 0.1s;
}

.pg-header__search-wrapper:hover .pg-header__search-input,
.pg-header__search-wrapper:focus-within .pg-header__search-input,
.pg-header__search-wrapper.is-open .pg-header__search-input {
  opacity: 1;
}

.pg-header__search-input::placeholder {
  color: #EAFE67;
  font-weight: 500;
}

.pg-header__search-submit {
  width: 44px;
  height: 44px;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: none;
  cursor: pointer;
  padding: 0;
}

.pg-header__search-submit img {
  width: 18px;
  height: 18px;
  opacity: 0.7;
  pointer-events: none;
}

.pg-header__search-toggle {
  position: absolute;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
  z-index: 2;
  opacity: 1;
  transition: opacity 0.2s ease;
}

.pg-header__search-wrapper:hover .pg-header__search-toggle,
.pg-header__search-wrapper:focus-within .pg-header__search-toggle,
.pg-header__search-wrapper.is-open .pg-header__search-toggle {
  opacity: 0;
  pointer-events: none; /* Desabilitar apenas quando invisvel */
}

.pg-header__cart-count {
  position: absolute;
  top: -4px;
  right: -4px;
  background: var(--pg-color-black); /* AJUSTADO: Preto discreto (opo 2) */
  color: #fff; /* Texto branco para contraste */
  border-radius: var(--pg-radius-pill);
  padding: 0 var(--pg-spacing-2);
  font-size: 0.65rem;
  font-weight: 700;
  min-width: 16px;
  height: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  line-height: 1;
}

/* MOBILE SEARCH FIX - Opo 1: Logo oculta ao expandir busca */
@media (max-width: 767px) {
  /* Logo: aplicar z-index menor para ficar atrs da busca */
  .pg-header__logo {
    position: absolute;
    z-index: 5;
    transition: opacity 0.3s ease, visibility 0.3s ease;
  }

  /* Wrapper da busca: z-index maior quando expandida */
  .pg-header__search-wrapper {
    position: relative;
    z-index: 10;
  }

  .pg-header__search-wrapper.is-open {
    z-index: 100; /* Garante que fica sobre a logo */
  }

  /* Logo oculta quando busca est expandida */
  .pg-header__search-wrapper.is-open ~ .pg-header__logo {
    opacity: 0;
    visibility: hidden;
    pointer-events: none;
  }

  /* Busca expande ocupando espao disponvel */
  .pg-header__search-wrapper.is-open .pg-header__search-form {
    width: calc(100vw - 180px); /* Mais espao - apenas menu (44px) + perfil (44px) + carrinho (44px) + gaps (48px) */
    background: rgba(255, 255, 255, 0.98); /* Mais opaco para cobrir logo */
    border: 1px solid rgba(234, 254, 103, 0.3);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    z-index: 110; /* Sobre tudo */
  }

  /* Ocultar boto toggle (lupa externa) quando busca aberta */
  .pg-header__search-wrapper.is-open .pg-header__search-toggle {
    opacity: 0;
    pointer-events: none;
  }

  /* Boto de fechar (X) - oculto por padro */
  .pg-header__search-close {
    display: none;
    width: 44px;
    height: 44px;
    flex-shrink: 0;
    align-items: center;
    justify-content: center;
    background: transparent;
    border: none;
    cursor: pointer;
    padding: 0;
    font-size: 20px;
    color: var(--pg-color-black);
    font-weight: 300;
    line-height: 1;
    z-index: 120; /* Acima de tudo para ser clicvel */
    position: relative;
    pointer-events: auto; /* Garantir que seja clicvel */
    -webkit-tap-highlight-color: transparent;
    user-select: none;
    -webkit-user-select: none;
  }

  /* Mostra boto X quando busca expandida */
  .pg-header__search-wrapper.is-open .pg-header__search-close {
    display: flex;
    pointer-events: auto; /* Forar clicvel quando visvel */
  }

  /* Boto submit dentro do form: sempre visvel mas muda comportamento via JS */
  .pg-header__search-submit {
    /* Mantm visvel, JS controla o comportamento */
  }

  /* ========================================= */
  /* FIX: Remover cor azul padro do mobile   */
  /* ========================================= */

  /* Remover highlight azul ao tocar (Safari/iOS/Android) */
  .pg-header__search-toggle,
  .pg-header__search-submit,
  .pg-header__search-close,
  .pg-header__icon-button {
    -webkit-tap-highlight-color: transparent;
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    tap-highlight-color: transparent;
  }

  /* Forar apenas STROKE (contorno) nos SVGs - SEM FILL (preenchimento) */
  .pg-header__search-toggle svg,
  .pg-header__search-submit svg,
  .pg-header__icon-button svg {
    fill: none; /* Remove preenchimento */
    stroke: currentColor; /* Mantm apenas contorno */
    color: var(--pg-color-black);
  }

  /* Remover estilos azuis de :active, :focus, :visited */
  .pg-header__search-toggle:active,
  .pg-header__search-toggle:focus,
  .pg-header__search-toggle:visited,
  .pg-header__search-submit:active,
  .pg-header__search-submit:focus,
  .pg-header__search-submit:visited,
  .pg-header__icon-button:active,
  .pg-header__icon-button:focus,
  .pg-header__icon-button:visited {
    color: var(--pg-color-black);
    background-color: transparent;
    outline: none;
    border: none;
  }

  /* Garantir que SVGs dentro dos botes tambm fiquem apenas com contorno */
  .pg-header__search-toggle:active svg,
  .pg-header__search-toggle:focus svg,
  .pg-header__search-submit:active svg,
  .pg-header__search-submit:focus svg,
  .pg-header__icon-button:active svg,
  .pg-header__icon-button:focus svg {
    fill: none; /* Remove preenchimento */
    stroke: currentColor; /* Apenas contorno */
    color: var(--pg-color-black);
  }
}

{# /* // Placeholders and preloaders */ #}

.placeholder-line-medium{
  height: 25px;
}
.placeholder-icon{
  position: absolute;
  top: 50%;
  left: 50%;
  width: 20%;
  transform: translate(-50%, -50%);
  -webkit-transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
}
.placeholder-full-height{
  position: relative;
  height: 100%;
}
.home-placeholder-icons{
  position: absolute;
  top: calc(50% - 75px);;
}
.product-placeholder-container{
  position: relative;
  max-height: 900px;
  margin-bottom: 20px;
  overflow: hidden;
}
.placeholder-shine{
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0.5;
  -moz-animation: placeholder-shine 1.5s infinite;
  -webkit-animation: placeholder-shine 1.5s infinite;
  animation: placeholder-shine 1.5s infinite;
}
@keyframes placeholder-shine {
  0%{
    opacity: 0.1;
  }
  50% {
    opacity: 0.5;
  }
  100% {
    opacity: 0.1;
  }
}
.placeholder-fade{
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0.1;
  -moz-animation: placeholder-fade 1.5s infinite;
  -webkit-animation: placeholder-fade 1.5s infinite;
  animation: placeholder-fade 1.5s infinite;
}
@keyframes placeholder-fade {
  0%{
    opacity: 0.1;
  }
  50% {
    opacity: 0.2;
  }
  100% {
    opacity: 0.1;
  }
}
.blur-up {
  position: absolute;
  top: 0;
  -webkit-filter: blur(2px);
  filter: blur(2px);
  -moz-filter: blur(2px);
  -ms-filter: blur(2px);
  -o-filter: blur(2px);
  transition: opacity .2s, -webkit-filter .2s;
}
.blur-up-big {
  -webkit-filter: blur(6px);
  filter: blur(6px);
  -moz-filter: blur(6px);
  -ms-filter: blur(6px);
  -o-filter: blur(6px);
  transition: filter .2s, -webkit-filter .2s;
}
.blur-up-huge {
  -webkit-filter: blur(8px);
  filter: blur(8px);
  -moz-filter: blur(8px);
  -ms-filter: blur(8px);
  -o-filter: blur(8px);
  transition: filter .2s, -webkit-filter .2s;
}
.blur-up.lazyloaded,
.blur-up-big.lazyloaded,
.blur-up-huge.lazyloaded,
.blur-up.swiper-lazy-loaded,
.blur-up-big.swiper-lazy-loaded,
.blur-up-huge.swiper-lazy-loaded {
  -webkit-filter: none;
  filter: none;
  -moz-filter: none;
  -ms-filter: none;
  -o-filter: none;
}
.preloader-bg-img{
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  -webkit-filter: blur(4px);
  filter: blur(4px);
  -moz-filter: blur(4px);
  -ms-filter: blur(4px);
  -o-filter: blur(4px);
  transition: filter .2s, -webkit-filter .2s, opacity .2s;
  /* Avoid strange image behaviour on filters in IOS */
  -webkit-perspective: 1000;
  -webkit-backface-visibility: hidden;
}
/* PATAGANG - Product Image Zoom blur-up effect
.product-slider-image.blur-up{
  position: absolute;
  left: 50%;
  width: auto;
  top: 0;
  -webkit-filter: blur(4px);
  filter: blur(4px);
  -moz-filter: blur(4px);
  -ms-filter: blur(4px);
  -o-filter: blur(4px);
  transition: filter .2s, -webkit-filter .2s, opacity .2s;
  /* Avoid strange image behaviour on filters in IOS */
  -webkit-perspective: 1000;
  -webkit-backface-visibility: hidden;
}
.swiper-lazy-loaded + .preloader-bg-img,
.lazyloaded + .blur-up{
  opacity: 0;
  -webkit-filter: none;
  filter: none;
  -moz-filter: none;
  -ms-filter: none;
  -o-filter: none;
}
.fade-in {
  opacity: 0;
  transition: opacity .2s;
}
.fade-in.lazyloaded,
.fade-in.swiper-lazy-loaded {
  opacity: 1;
}
.lazyloaded + .blur-up {
  opacity: 0;
  pointer-events: none;
}

.lazyloaded + .placeholder-shine,
.lazyloaded + .placeholder-fade,
.swiper-lazy-loaded + .placeholder-fade,
.lazyloaded + .item-image-secondary + .placeholder-fade{
  display: none;
}

.spinner-ellipsis {
  position: relative;
  display: inline-block;
  width: 64px;
  height: 40px;
}
.spinner-ellipsis .point {
  position: absolute;
  top: 15px;
  width: 11px;
  height: 11px;
  border-radius: 50%;
  animation-timing-function: cubic-bezier(0, 1, 1, 0);
}
.spinner-ellipsis .point:nth-child(1) {
  left: 6px;
  animation: spinner-ellipsis1 0.6s infinite;
}
.spinner-ellipsis .point:nth-child(2) {
  left: 6px;
  animation: spinner-ellipsis2 0.6s infinite;
}
.spinner-ellipsis .point:nth-child(3) {
  left: 26px;
  animation: spinner-ellipsis2 0.6s infinite;
}
.spinner-ellipsis .point:nth-child(4) {
  left: 45px;
  animation: spinner-ellipsis3 0.6s infinite;
}
@keyframes spinner-ellipsis1 {
  0% {
    transform: scale(0);
  }
  100% {
    transform: scale(1);
  }
}
@keyframes spinner-ellipsis3 {
  0% {
    transform: scale(1);
  }
  100% {
    transform: scale(0);
  }
}
@keyframes spinner-ellipsis2 {
  0% {
    transform: translate(0, 0);
  }
  100% {
    transform: translate(19px, 0);
  }
}

{# /* // Animations */ #}

.transition-up {
  opacity: 0;
}

{# /* // Buttons */ #}

.btn-whatsapp {
  position: fixed;
  bottom: 10px;
  right: 10px;
  z-index: 100;
  color: white;
  background-color:#4dc247;
  box-shadow: 2px 2px 6px rgba(0,0,0,0.4);
  border-radius: 50%;
}

.btn-whatsapp svg{
  width: 45px;
  height: 45px;
  padding: 10px;
  fill: white;
  vertical-align:middle;
}

{# /* // Links */ #}

a {
  text-decoration: none;
}

{# /* // Headings */ #}

.page-header-text {
  margin: .5rem 0 0 0;
  font-size: 12px;
  text-align: center;
}

{# /* // Titles and breadcrumbs */ #}

h1,
.h1 {
  font-size: 28px;
  font-weight: 700;
}

.pg-page__title {
  font-size: 30px;
  text-align: center;
  margin-bottom: 30px;
  font-family: 'Familjen Grotesk', sans-serif;
  font-weight: 700;
  text-transform: uppercase;
}

h2,
.h2 {
  font-size: 24px;
  font-weight: 700;
}

h3,
.h3 {
  font-size: 20px;
  font-weight: 700;
}

h4,
.h4 {
  font-size: 18px;
  font-weight: 700;
}

h5,
.h5 {
  font-size: 16px;
  font-weight: 700;
}

h6,
.h6 {
  font-size: 14px;
  font-weight: 700;
}

{# /* // Texts */ #}

p{
  margin-top: 0;
  line-height: 22px;
}

.user-content ul {
  padding-left: 20px;
}

.user-content ul li {
  margin-bottom: 10px;
  line-height: 22px;
}

.user-content table {
  width: 100%;
  max-width: 100%;
  margin-bottom: 10px;
  line-height: 22px;
}

.price-compare {
  text-decoration: line-through;
  margin-right: 5px;
  opacity: 0.5;
}
.font-small {
  font-size: 12px;
}
.font-smallest {
  font-size: 11px;
}

.font-big{
  font-size: 16px;
}

{# /* // Icons */ #}

.icon-inline {
  display: inline-block;
  font-size: inherit;
  height: 1em;
  overflow: visible;
  vertical-align: -.125em;
}

.icon-xs {
  font-size: .75em;
}
.icon-md {
  font-size: .875em;
}
.icon-lg {
  font-size: 1.33333em;
  line-height: .75em;
  vertical-align: -.0667em;
}
.icon-2x {
  font-size: 2em;
}
.icon-3x {
  font-size: 3em;
}
.icon-4x {
  font-size: 4em;
}
.icon-5x {
  font-size: 5em;
}
.icon-6x {
  font-size: 6em;
}
.icon-7x {
  font-size: 7em;
}
.icon-8x {
  font-size: 8em;
}
.icon-9x {
  font-size: 9em;
}

.icon-inline.icon-lg{
  vertical-align: -.225em
}
.icon-inline.icon-w {
  text-align: center;
  width: 1.25em
}
.icon-inline.icon-w-1{
  width:.0625em
}
.icon-inline.icon-w-2{
  width:.125em
}
.icon-inline.icon-w-3{
  width:.1875em
}
.icon-inline.icon-w-4{
  width:.25em
}
.icon-inline.icon-w-5{
  width:.3125em
}
.icon-inline.icon-w-6{
  width:.375em
}
.icon-inline.icon-w-7{
  width:.4375em
}
.icon-inline.icon-w-8{
  width:.5em
}
.icon-inline.icon-w-9{
  width:.5625em
}
.icon-inline.icon-w-10{
  width:.625em
}
.icon-inline.icon-w-11{
  width:.6875em
}
.icon-inline.icon-w-12{
  width:.75em
}
.icon-inline.icon-w-13{
  width:.8125em
}
.icon-inline.icon-w-14{
  width:.875em
}
.icon-inline.icon-w-15{
  width:.9375em
}
.icon-inline.icon-w-16{
  width:1em
}
.icon-inline.icon-w-17{
  width:1.0625em
}
.icon-inline.icon-w-18{
  width:1.125em
}
.icon-inline.icon-w-19{
  width:1.1875em
}
.icon-inline.icon-w-20{
  width:1.25em
}
.icon-spin{
  -webkit-animation:icon-spin 2s infinite linear;
  animation:icon-spin 2s infinite linear
}
@-webkit-keyframes icon-spin {
  0% {
    -webkit-transform: rotate(0);
    transform: rotate(0)
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg)
  }
}

@keyframes icon-spin {
  0% {
    -webkit-transform: rotate(0);
    transform: rotate(0)
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg)
  }
}

{# /* // Sliders */ #}

.section-slider {
  height: 100vh;
}
.nube-slider-home {
  height: 100%;
}
.swiper-wrapper.disabled {
  transform: translate3d(0px, 0, 0);
}
.slide-container{
  overflow: hidden;
}
.slider-slide {
  height: 100%;
  background-position: center;
  background-size: cover;
  overflow: hidden;
}
.slider-image {
  position: relative;
  z-index: 1;
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.swiper-pagination-fraction{
  position: absolute;
  left: 50%;
  width: auto;
  padding: 5px;
  transform: translateX(-50%);
  font-size: 18px;
  background: #00000045;
  color: #ffffff85;
}

.swiper-text {
  position: absolute;
  z-index: 1;
  top: 50%;
  bottom: auto;
  left: 50%;
  width: 92%;
  padding: 0 25px;
  text-align: center;
  transform: translate(-50%,-50%);
}
.swiper-title {
  font-size: 36px;
}

{# /* // Lists */ #}

.list {
  padding: 0;
  margin: 0;
  list-style-type: none;
}

.list-unstyled{
  padding: 0;
  margin: 0;
  list-style-type: none;
}

.list-inline li{
  display: inline-flex;
}

{# /* // Tables */ #}

.table{
  width: 100%;
  border-collapse: collapse;
  border-spacing: 0;
}
.table thead th{
  padding: 8px;
}
.table thead th:first-of-type{
  padding-left: 0;
}
.table td{
  padding: 8px;
  text-align: left;
}

{# /* // Notifications */ #}

.notification{
  padding: 10px;
  text-align: center;
}
.notification-floating {
  position: absolute;
  top: 100%;
  right: 15px;
  z-index: 2000;
  width: calc(100% - 30px);
  margin-top: -20px;
}
.notification-fixed {
  position: fixed;
  right: 0;
  left: 15px;
}
.notification-close {
  position: absolute;
  top: 20px;
  right: 20px;
  padding: 0 5px;
}
.notification-floating .notification {
  box-shadow: 0 0 5px 0 rgba(0, 0, 0, .1), 0 2px 3px 0 rgba(0, 0, 0, .06);
}
.notification-fixed-bottom {
  position: fixed;
  bottom: 0;
  left: 0;
  z-index: 999;
  width: 100%;
}

.notification-fixed-bottom-right {
  position: fixed;
  top: initial;
  bottom: 0;
  right: 0;
  z-index: 999;
  width: 100%;
}

{# /* // Images */ #}

/* Used for images that have a placeholder before it loads. The image container should have a padding-bottom inline with the result of (image height/ image width) * 100 */
.img-absolute {
  position: absolute;
  left: 0;
  width: 100%;
  height: auto;
  vertical-align: middle;
  text-indent: -9999px;
  z-index: 1;
}

.img-absolute-centered{
  left: 50%;
  transform: translateX(-50%);
  -webkit-transform: translateX(-50%);
  -ms-transform: translateX(-50%);
}

.card-img{
  margin: 0 5px 5px 0;
  border: 1px solid #00000012;
}
.card-img-small{
  height: 25px;
}
.card-img-medium{
  height: 35px;
}
.card-img-big{
  height: 50px;
}
.card-img-square-container {
  position: relative;
  width: 100%;
  padding-top: 100%;
}
.card-img-square {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.card-img-pill {
  position: absolute;
  bottom: 0;
  left: 0;
  z-index: 999;
}

{# /* // Forms */ #}

.form-group {
  position: relative;
  width: 100%;
}
.form-group .form-select-icon,
.form-select .form-select-icon{
  position: absolute;
  bottom: 12px;
  right: 0;
  pointer-events: none;
}
.form-select .form-select-icon {
  top: 50%;
  bottom: initial;
  transform: translateY(-50%);
  -webkit-transform: translateY(-50%);
  -ms-transform: translateY(-50%);
}
.form-row {
  width: auto;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-wrap: wrap;
  flex-wrap: wrap;
  margin-right: -5px;
  margin-left: -5px;
  clear: both;
}

.form-row > .col,
.form-row > [class*=col-]{
  padding-right: 5px;
  padding-left: 5px;
}

.form-label {
  display: block;
  font-size: 10px;
  text-transform: uppercase;
}

.form-toggle-eye {
  position: absolute;
  top: 20px;
  right: 2px;
  display: inline-block;
  padding: 10px;
  font-size: 16px;
  background: none;
  border: 0;
}

.radio-button {
  margin-bottom: 0;
  -webkit-tap-highlight-color: rgba(0,0,0,0);
  cursor: pointer;
}

.radio-button.disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.radio-button.disabled input[type="radio"] {
  cursor: not-allowed;
}

.radio-button-content {
  position: relative;
  width: 100%;
  float: left;
  padding: 15px;
  clear: both;
  box-sizing: border-box;
}

.radio-button-icons-container {
  position: absolute;
  top: 14px;
  left: 10px;
}

.radio-button-icons {
  position: relative;
  float: left;
}

.radio-button-icon {
  width: 16px;
  height: 16px;
  border-radius: 50%;
}

.radio-button input[type="radio"] {
  display: none;
}

.radio-button input[type="radio"] + .radio-button-content .unchecked {
  float: left;
}

.radio-button input[type="radio"] + .radio-button-content .checked {
  position: absolute;
  top: 8px;
  left: 8px;
  width: 0;
  height: 0;
  -webkit-transform: translate(-50%,-50%);
  -ms-transform: translate(-50%,-50%);
  -moz-transform: translate(-50%,-50%);
  -o-transform: translate(-50%,-50%);
  transform: translate(-50%,-50%);
  -webkit-transition: all 0.2s;
  -ms-transition: all 0.2s;
  -moz-transition: all 0.2s;
  -o-transition: all 0.2s;
  transition: all 0.2s;
}

.radio-button input[type="radio"]:checked + .radio-button-content .checked {
  width: 8px;
  height: 8px;
}

.radio-button-label {
  width: 100%;
  float: left;
  padding-left: 30px;
}

.radio-button-item:last-of-type .radio-button {
  margin-bottom: 0;
}

{# /* // Video */ #}

.embed-responsive {
  position: relative;
  display: block;
  height: 0;
  padding: 0;
  overflow: hidden;
}
.embed-responsive.embed-responsive-16by9 {
  padding-bottom: 56.25%;
}
.embed-responsive .embed-responsive-item,
.embed-responsive embed,
.embed-responsive  iframe,
.embed-responsive  object,
.embed-responsive  video {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border: 0;
}
.video-player {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 1;
  width: 100%;
  height: 100%;
  cursor: pointer;
}
.video-player-icon {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 60px;
  height: 60px;
  margin: -30px 0 0 -30px;
  padding: 0;
  font-size: 60px;
  line-height: 30px;
  text-align: center;
  pointer-events: none;
}
.video-image {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 100%;
  height: auto;
  transform: translate(-50%, -50%);
  -webkit-transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
}

/*============================================================================
  #Header and nav
==============================================================================*/

.head-main {
  position: relative;
  z-index: 1040;
  -webkit-backface-visibility: hidden;
  -webkit-transform: scale(1);
}

.head-fix {
  position: sticky;
  top:0;
  width: 100%;
}

.head-transparent-fixed {
  position: fixed;
}

.head-absolute{
  position: absolute;
  width: 100%;
}

.nav-dropdown-content {
  visibility: hidden;
  opacity: 0;
  transition: visibility 0s linear .3s, opacity .3s linear;
}

{# /* // Ad Bar */ #}

/* ============================================================================
   #Ad Bar - Static Banner com Texto Centrado (Patagang)
   ============================================================================ */

.section-advertising {
  background-color: transparent !important;
  background-image: none !important;
  padding: 10px 20px;
  width: 100%;
  max-width: 100%;
  box-sizing: border-box;
}

.section-advertising__marquee {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
}

.section-advertising__track {
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  width: 100%;
  padding: 0;
}

.section-advertising__copy {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-wrap: wrap;
  /* Phrase spacing  keep in sync: layouts/layout.tpl (ad_bar + ad_text block) */
  gap: clamp(0.75rem, 2.5vw, 1.75rem);
  row-gap: 0.35em;
  font-size: 0.7rem;
  font-weight: 600;
  letter-spacing: 0.2px;
  color: #000;
  margin: 0;
  line-height: 1.4;
  white-space: normal;
  overflow: visible;
  word-spacing: normal;
}

.section-advertising__phrase {
  display: inline;
  white-space: normal;
}

.section-advertising__link {
  display: flex;
  align-items: center;
  justify-content: center;
  text-decoration: none;
  color: inherit;
  outline: none;
  width: 100%;
  transition: opacity 0.2s ease;
}

.section-advertising__link:hover {
  opacity: 0.8;
}

/* Mobile */
@media (max-width: 576px) {
  .section-advertising {
    padding: 8px 15px;
  }

  .section-advertising__copy {
    font-size: 0.65rem;
  }

  .section-advertising__phrase {
    font-size: 0.65rem;
  }

  /* Adjust header when ad-bar is visible on mobile */
  body.has-ad-bar .pg-header--sticky {
    --ad-bar-height: 36px;
  }
}

/* Tablet */
@media (min-width: 577px) and (max-width: 991px) {
  .section-advertising {
    padding: 9px 18px;
  }

  .section-advertising__copy {
    font-size: 0.7rem;
  }

  .section-advertising__phrase {
    font-size: 0.7rem;
  }

  /* Adjust header when ad-bar is visible on tablet */
  body.has-ad-bar .pg-header--sticky {
    --ad-bar-height: 38px;
  }
}

/* Desktop */
@media (min-width: 992px) {
  .section-advertising {
    padding: 10px 20px;
  }

  .section-advertising__copy {
    font-size: 0.75rem;
  }

  .section-advertising__phrase {
    font-size: 0.75rem;
  }

  /* Adjust header when ad-bar is visible on desktop */
  body.has-ad-bar .pg-header--sticky {
    --ad-bar-height: 40px;
  }
}

{# /* // Logo */ #}

.logo-text-container {
  max-width: 450px;
  margin: auto;
  padding: 5px;
  text-align: center;
}

.logo-img-container {
  max-width: 450px;
  margin: auto;
  text-align: center;
}
.logo-img{
  width: auto;
  height: auto;
  margin: 15px 0;
  vertical-align: middle;
  max-width: 40vw;
  max-height: 80px;
}

{# /* // Cart widget and search */ #}

.utilities-item {
  display: inline-block;
  padding: 15px 4px;
  font-size: 18px;
}

.cart-widget-amount {
  display: inline-block;
  font-size: 14px;
}



/*============================================================================
  #Home Page
==============================================================================*/

{# /* // Welcome message */ #}

.section-welcome-home {
  padding: 70px 0;
  text-align: center;
}

.welcome-title {
  margin-bottom: 15px;
  text-transform: uppercase;
}
.welcome-text {
  line-height: 18px;
}

/*============================================================================
  #Banners
==============================================================================*/

{# /* // Home banners */ #}

.textbanner {
  position: relative;
  margin-bottom: 20px;
  overflow: hidden;
}
.textbanner-link {
  display: block;
  width: 100%;
  height: 100%;
}
.textbanner-image {
  position: relative;
  padding-top: 100%;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}
.textbanner-image-background {
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.textbanner-image-empty:after {
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  content: '';
}
.textbanner-text {
  position: relative;
  padding: 0 5% 45px 5%;
  text-align: center;
}
.textbanner-text.over-image {
  position: absolute;
  top: 50%;
  left: 50%;
  z-index: 9;
  width: 100%;
  color: #fff;
  transform: translate(-50%, -50%);
}
.textbanner-title {
  margin-bottom: 15px;
  line-height: 34px;
}
.textbanner-paragraph {
  display: -webkit-box;
  margin-bottom: 15px;
  line-height: 18px;
  overflow: hidden;
  text-overflow: ellipsis;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
}

{# /* // Informative banners */ #}

.section-informative-banners {
  padding: 50px 0;
}

/* PATAGANG - Service/Warning Banner (Information panels)
.pg-service-item {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1.5rem 1rem;
  min-height: 120px;
  background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
  border-radius: 8px;
  margin-bottom: 1rem;
}

.pg-service-item__content {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  width: 100%;
  gap: 1rem;
}

.pg-service-item__icon {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 50px;
  height: 50px;
}

.pg-service-item__svg {
  width: 100%;
  height: 100%;
  color: #000;
  transition: transform 0.3s ease;
}

.pg-service-item:hover .pg-service-item__svg {
  transform: scale(1.1);
}

.pg-service-item__text {
  flex: 1;
  width: 100%;
}

.pg-service-item__link {
  text-decoration: none;
  color: inherit;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}

.pg-service-item__title {
  font-size: 1.125rem;
  font-weight: 700;
  line-height: 1.3;
  margin: 0;
  color: #000;
  letter-spacing: 0.5px;
}

.pg-service-item__description {
  font-size: 0.95rem;
  line-height: 1.4;
  margin: 0;
  color: #666;
  font-weight: 500;
}

@media (min-width: 768px) {
  .pg-service-item {
    padding: 2rem 2rem;
    min-height: 140px;
  }

  .pg-service-item__icon {
    width: 60px;
    height: 60px;
  }

  .pg-service-item__title {
    font-size: 1.25rem;
  }

  .pg-service-item__description {
    font-size: 1rem;
  }
}

@media (min-width: 992px) {
  .pg-service-item {
    padding: 2.5rem 2.5rem;
    min-height: 160px;
  }

  .pg-service-item__icon {
    width: 70px;
    height: 70px;
  }

  .pg-service-item__title {
    font-size: 1.375rem;
    letter-spacing: 0.8px;
  }

  .pg-service-item__description {
    font-size: 1.0625rem;
    max-width: 320px;
    margin: 0 auto;
  }
}

/* Product Informative Banner - Main compensa header, banner sem override de margin-top */
div.product-informative-banner {
  background: transparent;
  background-color: transparent;
  padding: 0.5rem 0;
  margin: 0;  /*  REFATORAO: Main (160px padding) compensa header */
  margin-bottom: 16px;  /*  Espao abaixo do banner */
  position: relative;
  z-index: 10;  /*  Visvel acima de contedo comum, abaixo do header (9999) */
}

/* Mobile (576px): Responsive spacing */
@media (max-width: 576px) {
  div.product-informative-banner {
    margin-top: 0;
    margin-bottom: 12px;  /*  Reduzido no mobile */
  }
}

/* Tablet (577px-768px): Transio suave */
@media (min-width: 577px) and (max-width: 768px) {
  div.product-informative-banner {
    margin-top: 0;
    margin-bottom: 14px;
  }
}

/* Desktop (769px): Espao confortvel */
@media (min-width: 769px) {
  div.product-informative-banner {
    margin-top: 0;
    margin-bottom: 16px;
  }
}

div.product-informative-banner.position-relative {
  background: transparent;
  background-color: transparent;
}

.product-informative-banner .col-md {
  background: transparent;
  padding: 0.5rem 0.25rem;
  min-height: auto;
  border: none;
}

.product-informative-banner .d-md-flex {
  background: transparent;
}

.product-informative-banner .js-informative-product {
  background: transparent;
}

.product-informative-title,
.product-informative-banner .product-informative-title {
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 3px;
  line-height: 1.3;
}

.product-informative-banner div {
  font-size: 11px;
  line-height: 1.3;
  background: transparent;
}

.service-pagination {
  position: relative;
  margin-top: 5px;
}

/*============================================================================
  #Helper classes
==============================================================================*/

/*CSS properties helpers minified, to unminify it you have to copy the code and paste it here http://unminify.com/, after that paste the unminified code here */

{# /* // Margin and padding */ #}
.m-0{margin:0}.mt-0,.my-0{margin-top:0}.mr-0,.mx-0{margin-right:0}.mb-0,.my-0{margin-bottom:0}.ml-0,.mx-0{margin-left:0}.m-1{margin:.25rem}.mt-1,.my-1{margin-top:.25rem}.mr-1,.mx-1{margin-right:.25rem}.mb-1,.my-1{margin-bottom:.25rem}.ml-1,.mx-1{margin-left:.25rem}.m-2{margin:.5rem}.mt-2,.my-2{margin-top:.5rem}.mr-2,.mx-2{margin-right:.5rem}.mb-2,.my-2{margin-bottom:.5rem}.ml-2,.mx-2{margin-left:.5rem}.m-3{margin:1rem}.mt-3,.my-3{margin-top:1rem}.mr-3,.mx-3{margin-right:1rem}.mb-3,.my-3{margin-bottom:1rem}.ml-3,.mx-3{margin-left:1rem}.m-4{margin:1.5rem}.mt-4,.my-4{margin-top:1.5rem}.mr-4,.mx-4{margin-right:1.5rem}.mb-4,.my-4{margin-bottom:1.5rem}.ml-4,.mx-4{margin-left:1.5rem}.m-5{margin:3rem}.mt-5,.my-5{margin-top:3rem}.mr-5,.mx-5{margin-right:3rem}.mb-5,.my-5{margin-bottom:3rem}.ml-5,.mx-5{margin-left:3rem}.p-0{padding:0}.pt-0,.py-0{padding-top:0}.pr-0,.px-0{padding-right:0}.pb-0,.py-0{padding-bottom:0}.pl-0,.px-0{padding-left:0}.p-1{padding:.25rem}.pt-1,.py-1{padding-top:.25rem}.pr-1,.px-1{padding-right:.25rem}.pb-1,.py-1{padding-bottom:.25rem}.pl-1,.px-1{padding-left:.25rem}.p-2{padding:.5rem}.pt-2,.py-2{padding-top:.5rem}.pr-2,.px-2{padding-right:.5rem}.pb-2,.py-2{padding-bottom:.5rem}.pl-2,.px-2{padding-left:.5rem}.p-3{padding:1rem}.pt-3,.py-3{padding-top:1rem}.pr-3,.px-3{padding-right:1rem}.pb-3,.py-3{padding-bottom:1rem}.pl-3,.px-3{padding-left:1rem}.p-4{padding:1.5rem}.pt-4,.py-4{padding-top:1.5rem}.pr-4,.px-4{padding-right:1.5rem}.pb-4,.py-4{padding-bottom:1.5rem}.pl-4,.px-4{padding-left:1.5rem}.p-5{padding:3rem}.pt-5,.py-5{padding-top:3rem}.pr-5,.px-5{padding-right:3rem}.pb-5,.py-5{padding-bottom:3rem}.pl-5,.px-5{padding-left:3rem}.m-auto{margin:auto}.mt-auto,.my-auto{margin-top:auto}.mr-auto,.mx-auto{margin-right:auto}.mb-auto,.my-auto{margin-bottom:auto}.ml-auto,.mx-auto{margin-left:auto}@media (min-width:576px){.m-sm-0{margin:0}.mt-sm-0,.my-sm-0{margin-top:0}.mr-sm-0,.mx-sm-0{margin-right:0}.mb-sm-0,.my-sm-0{margin-bottom:0}.ml-sm-0,.mx-sm-0{margin-left:0}.m-sm-1{margin:.25rem}.mt-sm-1,.my-sm-1{margin-top:.25rem}.mr-sm-1,.mx-sm-1{margin-right:.25rem}.mb-sm-1,.my-sm-1{margin-bottom:.25rem}.ml-sm-1,.mx-sm-1{margin-left:.25rem}.m-sm-2{margin:.5rem}.mt-sm-2,.my-sm-2{margin-top:.5rem}.mr-sm-2,.mx-sm-2{margin-right:.5rem}.mb-sm-2,.my-sm-2{margin-bottom:.5rem}.ml-sm-2,.mx-sm-2{margin-left:.5rem}.m-sm-3{margin:1rem}.mt-sm-3,.my-sm-3{margin-top:1rem}.mr-sm-3,.mx-sm-3{margin-right:1rem}.mb-sm-3,.my-sm-3{margin-bottom:1rem}.ml-sm-3,.mx-sm-3{margin-left:1rem}.m-sm-4{margin:1.5rem}.mt-sm-4,.my-sm-4{margin-top:1.5rem}.mr-sm-4,.mx-sm-4{margin-right:1.5rem}.mb-sm-4,.my-sm-4{margin-bottom:1.5rem}.ml-sm-4,.mx-sm-4{margin-left:1.5rem}.m-sm-5{margin:3rem}.mt-sm-5,.my-sm-5{margin-top:3rem}.mr-sm-5,.mx-sm-5{margin-right:3rem}.mb-sm-5,.my-sm-5{margin-bottom:3rem}.ml-sm-5,.mx-sm-5{margin-left:3rem}.p-sm-0{padding:0}.pt-sm-0,.py-sm-0{padding-top:0}.pr-sm-0,.px-sm-0{padding-right:0}.pb-sm-0,.py-sm-0{padding-bottom:0}.pl-sm-0,.px-sm-0{padding-left:0}.p-sm-1{padding:.25rem}.pt-sm-1,.py-sm-1{padding-top:.25rem}.pr-sm-1,.px-sm-1{padding-right:.25rem}.pb-sm-1,.py-sm-1{padding-bottom:.25rem}.pl-sm-1,.px-sm-1{padding-left:.25rem}.p-sm-2{padding:.5rem}.pt-sm-2,.py-sm-2{padding-top:.5rem}.pr-sm-2,.px-sm-2{padding-right:.5rem}.pb-sm-2,.py-sm-2{padding-bottom:.5rem}.pl-sm-2,.px-sm-2{padding-left:.5rem}.p-sm-3{padding:1rem}.pt-sm-3,.py-sm-3{padding-top:1rem}.pr-sm-3,.px-sm-3{padding-right:1rem}.pb-sm-3,.py-sm-3{padding-bottom:1rem}.pl-sm-3,.px-sm-3{padding-left:1rem}.p-sm-4{padding:1.5rem}.pt-sm-4,.py-sm-4{padding-top:1.5rem}.pr-sm-4,.px-sm-4{padding-right:1.5rem}.pb-sm-4,.py-sm-4{padding-bottom:1.5rem}.pl-sm-4,.px-sm-4{padding-left:1.5rem}.p-sm-5{padding:3rem}.pt-sm-5,.py-sm-5{padding-top:3rem}.pr-sm-5,.px-sm-5{padding-right:3rem}.pb-sm-5,.py-sm-5{padding-bottom:3rem}.pl-sm-5,.px-sm-5{padding-left:3rem}.m-sm-auto{margin:auto}.mt-sm-auto,.my-sm-auto{margin-top:auto}.mr-sm-auto,.mx-sm-auto{margin-right:auto}.mb-sm-auto,.my-sm-auto{margin-bottom:auto}.ml-sm-auto,.mx-sm-auto{margin-left:auto}}@media (min-width:768px){.m-md-0{margin:0}.mt-md-0,.my-md-0{margin-top:0}.mr-md-0,.mx-md-0{margin-right:0}.mb-md-0,.my-md-0{margin-bottom:0}.ml-md-0,.mx-md-0{margin-left:0}.m-md-1{margin:.25rem}.mt-md-1,.my-md-1{margin-top:.25rem}.mr-md-1,.mx-md-1{margin-right:.25rem}.mb-md-1,.my-md-1{margin-bottom:.25rem}.ml-md-1,.mx-md-1{margin-left:.25rem}.m-md-2{margin:.5rem}.mt-md-2,.my-md-2{margin-top:.5rem}.mr-md-2,.mx-md-2{margin-right:.5rem}.mb-md-2,.my-md-2{margin-bottom:.5rem}.ml-md-2,.mx-md-2{margin-left:.5rem}.m-md-3{margin:1rem}.mt-md-3,.my-md-3{margin-top:1rem}.mr-md-3,.mx-md-3{margin-right:1rem}.mb-md-3,.my-md-3{margin-bottom:1rem}.ml-md-3,.mx-md-3{margin-left:1rem}.m-md-4{margin:1.5rem}.mt-md-4,.my-md-4{margin-top:1.5rem}.mr-md-4,.mx-md-4{margin-right:1.5rem}.mb-md-4,.my-md-4{margin-bottom:1.5rem}.ml-md-4,.mx-md-4{margin-left:1.5rem}.m-md-5{margin:3rem}.mt-md-5,.my-md-5{margin-top:3rem}.mr-md-5,.mx-md-5{margin-right:3rem}.mb-md-5,.my-md-5{margin-bottom:3rem}.ml-md-5,.mx-md-5{margin-left:3rem}.p-md-0{padding:0}.pt-md-0,.py-md-0{padding-top:0}.pr-md-0,.px-md-0{padding-right:0}.pb-md-0,.py-md-0{padding-bottom:0}.pl-md-0,.px-md-0{padding-left:0}.p-md-1{padding:.25rem}.pt-md-1,.py-md-1{padding-top:.25rem}.pr-md-1,.px-md-1{padding-right:.25rem}.pb-md-1,.py-md-1{padding-bottom:.25rem}.pl-md-1,.px-md-1{padding-left:.25rem}.p-md-2{padding:.5rem}.pt-md-2,.py-md-2{padding-top:.5rem}.pr-md-2,.px-md-2{padding-right:.5rem}.pb-md-2,.py-md-2{padding-bottom:.5rem}.pl-md-2,.px-md-2{padding-left:.5rem}.p-md-3{padding:1rem}.pt-md-3,.py-md-3{padding-top:1rem}.pr-md-3,.px-md-3{padding-right:1rem}.pb-md-3,.py-md-3{padding-bottom:1rem}.pl-md-3,.px-md-3{padding-left:1rem}.p-md-4{padding:1.5rem}.pt-md-4,.py-md-4{padding-top:1.5rem}.pr-md-4,.px-md-4{padding-right:1.5rem}.pb-md-4,.py-md-4{padding-bottom:1.5rem}.pl-md-4,.px-md-4{padding-left:1.5rem}.p-md-5{padding:3rem}.pt-md-5,.py-md-5{padding-top:3rem}.pr-md-5,.px-md-5{padding-right:3rem}.pb-md-5,.py-md-5{padding-bottom:3rem}.pl-md-5,.px-md-5{padding-left:3rem}.m-md-auto{margin:auto}.mt-md-auto,.my-md-auto{margin-top:auto}.mr-md-auto,.mx-md-auto{margin-right:auto}.mb-md-auto,.my-md-auto{margin-bottom:auto}.ml-md-auto,.mx-md-auto{margin-left:auto}}@media (min-width:992px){.m-lg-0{margin:0}.mt-lg-0,.my-lg-0{margin-top:0}.mr-lg-0,.mx-lg-0{margin-right:0}.mb-lg-0,.my-lg-0{margin-bottom:0}.ml-lg-0,.mx-lg-0{margin-left:0}.m-lg-1{margin:.25rem}.mt-lg-1,.my-lg-1{margin-top:.25rem}.mr-lg-1,.mx-lg-1{margin-right:.25rem}.mb-lg-1,.my-lg-1{margin-bottom:.25rem}.ml-lg-1,.mx-lg-1{margin-left:.25rem}.m-lg-2{margin:.5rem}.mt-lg-2,.my-lg-2{margin-top:.5rem}.mr-lg-2,.mx-lg-2{margin-right:.5rem}.mb-lg-2,.my-lg-2{margin-bottom:.5rem}.ml-lg-2,.mx-lg-2{margin-left:.5rem}.m-lg-3{margin:1rem}.mt-lg-3,.my-lg-3{margin-top:1rem}.mr-lg-3,.mx-lg-3{margin-right:1rem}.mb-lg-3,.my-lg-3{margin-bottom:1rem}.ml-lg-3,.mx-lg-3{margin-left:1rem}.m-lg-4{margin:1.5rem}.mt-lg-4,.my-lg-4{margin-top:1.5rem}.mr-lg-4,.mx-lg-4{margin-right:1.5rem}.mb-lg-4,.my-lg-4{margin-bottom:1.5rem}.ml-lg-4,.mx-lg-4{margin-left:1.5rem}.m-lg-5{margin:3rem}.mt-lg-5,.my-lg-5{margin-top:3rem}.mr-lg-5,.mx-lg-5{margin-right:3rem}.mb-lg-5,.my-lg-5{margin-bottom:3rem}.ml-lg-5,.mx-lg-5{margin-left:3rem}.p-lg-0{padding:0}.pt-lg-0,.py-lg-0{padding-top:0}.pr-lg-0,.px-lg-0{padding-right:0}.pb-lg-0,.py-lg-0{padding-bottom:0}.pl-lg-0,.px-lg-0{padding-left:0}.p-lg-1{padding:.25rem}.pt-lg-1,.py-lg-1{padding-top:.25rem}.pr-lg-1,.px-lg-1{padding-right:.25rem}.pb-lg-1,.py-lg-1{padding-bottom:.25rem}.pl-lg-1,.px-lg-1{padding-left:.25rem}.p-lg-2{padding:.5rem}.pt-lg-2,.py-lg-2{padding-top:.5rem}.pr-lg-2,.px-lg-2{padding-right:.5rem}.pb-lg-2,.py-lg-2{padding-bottom:.5rem}.pl-lg-2,.px-lg-2{padding-left:.5rem}.p-lg-3{padding:1rem}.pt-lg-3,.py-lg-3{padding-top:1rem}.pr-lg-3,.px-lg-3{padding-right:1rem}.pb-lg-3,.py-lg-3{padding-bottom:1rem}.pl-lg-3,.px-lg-3{padding-left:1rem}.p-lg-4{padding:1.5rem}.pt-lg-4,.py-lg-4{padding-top:1.5rem}.pr-lg-4,.px-lg-4{padding-right:1.5rem}.pb-lg-4,.py-lg-4{padding-bottom:1.5rem}.pl-lg-4,.px-lg-4{padding-left:1.5rem}.p-lg-5{padding:3rem}.pt-lg-5,.py-lg-5{padding-top:3rem}.pr-lg-5,.px-lg-5{padding-right:3rem}.pb-lg-5,.py-lg-5{padding-bottom:3rem}.pl-lg-5,.px-lg-5{padding-left:3rem}.m-lg-auto{margin:auto}.mt-lg-auto,.my-lg-auto{margin-top:auto}.mr-lg-auto,.mx-lg-auto{margin-right:auto}.mb-lg-auto,.my-lg-auto{margin-bottom:auto}.ml-lg-auto,.mx-lg-auto{margin-left:auto}}@media (min-width:1200px){.m-xl-0{margin:0}.mt-xl-0,.my-xl-0{margin-top:0}.mr-xl-0,.mx-xl-0{margin-right:0}.mb-xl-0,.my-xl-0{margin-bottom:0}.ml-xl-0,.mx-xl-0{margin-left:0}.m-xl-1{margin:.25rem}.mt-xl-1,.my-xl-1{margin-top:.25rem}.mr-xl-1,.mx-xl-1{margin-right:.25rem}.mb-xl-1,.my-xl-1{margin-bottom:.25rem}.ml-xl-1,.mx-xl-1{margin-left:.25rem}.m-xl-2{margin:.5rem}.mt-xl-2,.my-xl-2{margin-top:.5rem}.mr-xl-2,.mx-xl-2{margin-right:.5rem}.mb-xl-2,.my-xl-2{margin-bottom:.5rem}.ml-xl-2,.mx-xl-2{margin-left:.5rem}.m-xl-3{margin:1rem}.mt-xl-3,.my-xl-3{margin-top:1rem}.mr-xl-3,.mx-xl-3{margin-right:1rem}.mb-xl-3,.my-xl-3{margin-bottom:1rem}.ml-xl-3,.mx-xl-3{margin-left:1rem}.m-xl-4{margin:1.5rem}.mt-xl-4,.my-xl-4{margin-top:1.5rem}.mr-xl-4,.mx-xl-4{margin-right:1.5rem}.mb-xl-4,.my-xl-4{margin-bottom:1.5rem}.ml-xl-4,.mx-xl-4{margin-left:1.5rem}.m-xl-5{margin:3rem}.mt-xl-5,.my-xl-5{margin-top:3rem}.mr-xl-5,.mx-xl-5{margin-right:3rem}.mb-xl-5,.my-xl-5{margin-bottom:3rem}.ml-xl-5,.mx-xl-5{margin-left:3rem}.p-xl-0{padding:0}.pt-xl-0,.py-xl-0{padding-top:0}.pr-xl-0,.px-xl-0{padding-right:0}.pb-xl-0,.py-xl-0{padding-bottom:0}.pl-xl-0,.px-xl-0{padding-left:0}.p-xl-1{padding:.25rem}.pt-xl-1,.py-xl-1{padding-top:.25rem}.pr-xl-1,.px-xl-1{padding-right:.25rem}.pb-xl-1,.py-xl-1{padding-bottom:.25rem}.pl-xl-1,.px-xl-1{padding-left:.25rem}.p-xl-2{padding:.5rem}.pt-xl-2,.py-xl-2{padding-top:.5rem}.pr-xl-2,.px-xl-2{padding-right:.5rem}.pb-xl-2,.py-xl-2{padding-bottom:.5rem}.pl-xl-2,.px-xl-2{padding-left:.5rem}.p-xl-3{padding:1rem}.pt-xl-3,.py-xl-3{padding-top:1rem}.pr-xl-3,.px-xl-3{padding-right:1rem}.pb-xl-3,.py-xl-3{padding-bottom:1rem}.pl-xl-3,.px-xl-3{padding-left:1rem}.p-xl-4{padding:1.5rem}.pt-xl-4,.py-xl-4{padding-top:1.5rem}.pr-xl-4,.px-xl-4{padding-right:1.5rem}.pb-xl-4,.py-xl-4{padding-bottom:1.5rem}.pl-xl-4,.px-xl-4{padding-left:1.5rem}.p-xl-5{padding:3rem}.pt-xl-5,.py-xl-5{padding-top:3rem}.pr-xl-5,.px-xl-5{padding-right:3rem}.pb-xl-5,.py-xl-5{padding-bottom:3rem}.pl-xl-5,.px-xl-5{padding-left:3rem}.m-xl-auto{margin:auto}.mt-xl-auto,.my-xl-auto{margin-top:auto}.mr-xl-auto,.mx-xl-auto{margin-right:auto}.mb-xl-auto,.my-xl-auto{margin-bottom:auto}.ml-xl-auto,.mx-xl-auto{margin-left:auto}}

{# /* // Text */ #}
.text-left{text-align:left}.text-right{text-align:right}.text-center{text-align:center}@media (min-width:576px){.text-sm-left{text-align:left}.text-sm-right{text-align:right}.text-sm-center{text-align:center}}@media (min-width:768px){.text-md-left{text-align:left}.text-md-right{text-align:right}.text-md-center{text-align:center}}@media (min-width:992px){.text-lg-left{text-align:left}.text-lg-right{text-align:right}.text-lg-center{text-align:center}}@media (min-width:1200px){.text-xl-left{text-align:left}.text-xl-right{text-align:right}.text-xl-center{text-align:center}}.text-lowercase{text-transform:lowercase}.text-uppercase{text-transform:uppercase}.text-capitalize{text-transform:capitalize}.font-weight-light{font-weight:300}.font-weight-normal{font-weight:400}.font-weight-bold{font-weight:700}.font-italic{font-style:italic}

{# /* // Align */ #}
.align-baseline{vertical-align:baseline}.align-top{vertical-align:top}.align-middle{vertical-align:middle}.align-bottom{vertical-align:bottom}.align-text-bottom{vertical-align:text-bottom}.align-text-top{vertical-align:text-top}

{# /* // Position */ #}
.position-relative{position:relative}.position-absolute{position:absolute;}.position-fixed{position:fixed}

{# /* // Image */ #}
.img-fluid {max-width:100%;height:auto}

{# /* // Visibility */ #}
.hidden{display:none}.hidden-important{display:none}.overflow-none{overflow:hidden}.opacity-50{opacity: .5}.opacity-40{opacity:.4}.opacity-60{opacity:.6}.opacity-80{opacity:.8}.opacity-90{opacity:.9}

{# /* // Float */ #}
.float-left{float:left}.float-right{float:right}.float-none{float:none}.clear-both{clear:both}

{# /* // Width */ #}
.w-100{width:100%}.w-auto{width:auto}.full-width-container{width:100%;float:left;clear:both}

{# /* // Height */ #}
.h-100{height:100%}

{# /* PATAGANG Cart Styles - DESIGN LIMPO E FUNCIONAL */ #}

/* ============================================
   CART ITEM - PATAGANG BEM STRUCTURE
   ============================================ */

.pg-cart-item {
	display: flex;
	gap: 12px;
	padding: 16px 0;
	border-bottom: 1px solid #f0f0f0;
	position: relative;
}

.pg-cart-item:last-child {
	border-bottom: none;
}

/* Imagem */
.pg-cart-item__image {
	flex-shrink: 0;
	width: 100px;
}

.pg-cart-item__image a {
	display: block;
	background: #f8f8f8;
	border-radius: 8px;
	padding: 8px;
}

.pg-cart-item__image img {
	width: 100%;
	height: auto;
	display: block;
	object-fit: contain;
}

/* Contedo */
.pg-cart-item__content {
	flex: 1;
	display: flex;
	flex-direction: column;
	min-width: 0;
	padding-right: 24px;
}

/* Header - nome e variante */
.pg-cart-item__header {
	margin-bottom: 4px;
}

.pg-cart-item__name {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px;
	font-weight: 500;
	color: #000;
	line-height: 1.3;
	margin: 0 0 2px 0;
}

.pg-cart-item__name a {
	color: inherit;
	text-decoration: none;
}

.pg-cart-item__name a:hover {
	opacity: 0.7;
}

.pg-cart-item__variant {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 12px;
	color: #666;
}

/* Preo */
.pg-cart-item__price {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 15px;
	font-weight: 600;
	color: #000;
	margin-bottom: 12px;
}

/* Seletor de quantidade */
.pg-cart-item__quantity {
	margin-top: auto;
}

.pg-qty-selector {
	display: inline-flex;
	align-items: center;
	border: 1px solid #e0e0e0;
	border-radius: 6px;
	background: #fff;
	position: relative;
}

.pg-qty-selector__btn {
	width: 36px;
	height: 36px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: transparent;
	border: none;
	color: #000;
	cursor: pointer;
	transition: background 0.2s;
	padding: 0;
}

.pg-qty-selector__btn:hover:not(.is-disabled) {
	background: #f5f5f5;
}

.pg-qty-selector__btn.is-disabled {
	cursor: not-allowed;
	opacity: 0.5;
	pointer-events: none;
}

.pg-qty-selector__btn svg {
	width: 12px;
	height: 12px;
}

.pg-qty-selector__input {
	width: 40px;
	height: 36px;
	border: none;
	background: transparent;
	text-align: center;
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px;
	font-weight: 500;
	color: #000;
	-moz-appearance: textfield;
	padding: 0;
}

.pg-qty-selector__input::-webkit-outer-spin-button,
.pg-qty-selector__input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

.pg-qty-selector__input:focus {
	outline: none;
}

.pg-qty-selector__spinner {
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	background: rgba(255,255,255,0.95);
	padding: 4px;
	border-radius: 4px;
	box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	z-index: 10;
}

.pg-qty-selector__spinner svg {
	width: 16px;
	height: 16px;
	color: #666;
}

/* Estado de atualizao do item do carrinho */
.pg-cart-item.is-updating {
	opacity: 0.7;
	pointer-events: none;
}

.pg-cart-item.is-updating .pg-qty-selector {
	border-color: #EAFE67;
}

/* Boto remover */
.pg-cart-item__remove {
	position: absolute;
	top: 16px;
	right: 0;
	width: 24px;
	height: 24px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: transparent;
	border: none;
	color: #999;
	cursor: pointer;
	transition: color 0.2s;
	padding: 0;
}

.pg-cart-item__remove:hover {
	color: #e53935;
}

.pg-cart-item__remove svg {
	width: 16px;
	height: 16px;
}

/* Labels */
.pg-cart-item__labels {
	display: flex;
	flex-wrap: wrap;
	gap: 4px;
	margin-top: 8px;
}

.pg-cart-item__label {
	display: inline-block;
	font-size: 10px;
	padding: 2px 6px;
	border-radius: 4px;
	background: #f0f0f0;
	color: #666;
}

.pg-cart-item__label--promo {
	background: #EAFE67;
	color: #000;
}

/* Responsivo */
@media (max-width: 480px) {
	.pg-cart-item__image {
		width: 80px;
	}

	.pg-cart-item__name {
		font-size: 13px;
	}

	.pg-cart-item__price {
		font-size: 14px;
	}
}

/* ============================================
   CART TOTALS - NOVO DESIGN PROTTIPO
   ============================================ */

/* Container principal dos totais */
.modal-cart .js-visible-on-cart-filled {
	padding: 0;
}

/* Subtotal row */
.modal-cart .h5.row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 0;
	margin: 0;
	font-size: 14px;
	font-weight: 400;
	color: #000;
	border-bottom: 1px solid #f0f0f0;
}

.modal-cart .h5 strong,
.modal-cart .js-ajax-cart-total,
.modal-cart .js-cart-subtotal {
	font-weight: 600;
	font-size: 14px;
}

/* Total row - destaque */
.modal-cart .h2.row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 16px 0 8px;
	margin: 0;
	font-size: 16px;
	font-weight: 700;
	color: #000;
}

.modal-cart .js-cart-total {
	font-weight: 700;
	font-size: 16px;
}

/* ============================================
   CART SUMMARY - PATAGANG BEM STRUCTURE
   ============================================ */

.pg-cart-summary {
	padding: 0;
	margin-top: 16px;
	border-top: 1px solid #f0f0f0;
}

.pg-cart-summary__row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 0;
	border-bottom: 1px solid #f5f5f5;
}

.pg-cart-summary__row:last-of-type {
	border-bottom: none;
}

.pg-cart-summary__row--total {
	padding-top: 16px;
	border-bottom: none;
}

.pg-cart-summary__label {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px;
	font-weight: 400;
	color: #000;
}

.pg-cart-summary__label--bold {
	font-weight: 700;
	font-size: 16px;
}

.pg-cart-summary__value {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px;
	font-weight: 500;
	color: #000;
}

.pg-cart-summary__value--bold {
	font-weight: 700;
	font-size: 18px;
}

.pg-cart-summary__link {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px;
	font-weight: 400;
	color: #000;
	text-decoration: underline;
	transition: opacity 0.2s ease;
}

.pg-cart-summary__link:hover {
	opacity: 0.7;
}

.pg-cart-summary__installments {
	text-align: center;
	padding: 8px 0 16px;
}

.pg-cart-summary__installments-text {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 13px;
	color: #EAFE67;
	font-weight: 500;
}

/* Hide installments/parcelamento in modal - PATAGANG */
#modal-cart [data-component="installments"],
#modal-cart .js-installments,
#modal-cart [data-component="payment-discount-price"] {
	display: none;
}

/* ============================================
   CART MODAL STYLES - ADOBE XD PROTOTYPE
   ============================================ */

/* Overlay with Enhanced Blur Effect - PATAGANG */
.modal-overlay[data-modal-id="#modal-cart"],
.modal-overlay {
	background-color: rgba(0, 0, 0, 0.3);
	backdrop-filter: blur(20px) saturate(180%);
	-webkit-backdrop-filter: blur(20px) saturate(180%);
}

/* Modal cart glassmorphism effect */
.modal-cart {
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(10px);
	-webkit-backdrop-filter: blur(10px);
}

/* Modal Container Width */
.modal-cart.modal-docked-md {
	width: 400px; /* Aumentado para melhor espaamento */
	max-width: 100%;
}

/* Apply Familjen Grotesk to all cart text */
.modal-cart,
.modal-cart * {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px; /* Reduzido de 20px para 14px */
	font-weight: 400;
	color: #000000;
}

/* Modal Header - Title and Close Button */
.modal-cart .modal-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 24px 20px;
	background-color: #FFFFFF;
	border-bottom: 1px solid #E5E5E5; /* Adiciona separao visual */
}

.modal-cart .modal-header .d-inline-flex {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 16px; /* Reduzido de 20px */
	font-weight: 600; /* Bold para ttulo */
	color: #000000;
	order: 1;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

/* Close Button - Positioned to the Right */
.modal-cart .modal-close {
	order: 2;
	padding: 0;
	margin-left: auto;
}

.modal-cart .modal-close svg,
.modal-cart .modal-close .icon-inline {
	width: 20px;
	height: 20px;
	fill: #000000;
	stroke: #000000;
}

/* Product Name */
.modal-cart .pg-cart-item-name,
.modal-cart .pg-cart-item-name a {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px; /* Reduzido de 20px */
	font-weight: 500; /* Peso mdio */
	color: #000000;
	text-decoration: none;
	line-height: 1.4;
}

/* Product Price */
.modal-cart .pg-cart-item-price,
.modal-cart .pg-cart-item-price-mobile,
.modal-cart .price {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 16px; /* Destaque no preo */
	font-weight: 600; /* Bold */
	color: #000000;
}

/* Product Variant (Size) */
.modal-cart .pg-cart-item-variant,
.modal-cart .cart-item-variant {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 12px; /* Menor, mais discreto */
	font-weight: 400;
	color: #666666; /* Cinza mais suave */
	margin-top: 2px;
}

/* Quantity Controls - Updated Design */
.modal-cart .pg-cart-quantity-input .input-group,
.modal-cart .js-cart-quantity-input .input-group {
	border: 1px solid #E0E0E0; /* Borda mais suave */
	background-color: #FFFFFF; /* Fundo branco */
	border-radius: 6px; /* Menos arredondado */
	overflow: hidden;
	max-width: 100px; /* Menor */
	height: 32px; /* Mais compacto */
	display: flex;
	align-items: center;
	justify-content: center;
}

.modal-cart .pg-cart-quantity-input .form-control,
.modal-cart .js-cart-quantity-input .form-control {
	border: none;
	background-color: transparent;
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px; /* Reduzido */
	font-weight: 500;
	color: #000000;
	text-align: center;
	padding: 4px 2px;
	width: 32px; /* Mais estreito */
}

.modal-cart .pg-cart-quantity-btn,
.modal-cart .js-cart-quantity-btn {
	background-color: transparent;
	border: none;
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 16px; /* Tamanho reduzido */
	font-weight: 400;
	color: #000000;
	padding: 4px 8px; /* Padding menor */
	cursor: pointer;
	min-width: 24px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.modal-cart .pg-cart-quantity-btn:hover,
.modal-cart .js-cart-quantity-btn:hover {
	background-color: rgba(0, 0, 0, 0.08);
}

/* Summary Labels (Subtotal, Frete, Cupom, Total) */
.modal-cart .h5,
.modal-cart .cart-subtotal,
.modal-cart .shipping-label,
.modal-cart .coupon-label {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px; /* Reduzido de 20px */
	font-weight: 400;
	color: #000000;
	line-height: 1.6;
}

.modal-cart .h5 strong {
	font-weight: 600;
}

/* Total - Maior destaque */
.modal-cart .h2,
.modal-cart .cart-total {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 18px; /* Maior que subtotal */
	font-weight: 700; /* Extra bold */
	color: #000000;
}

/* Links (Calcular, Adicionar) */
.modal-cart .pg-cart-summary-link,
.modal-cart a.btn-link,
.modal-cart .js-shipping-calculator-trigger,
.modal-cart .js-add-coupon {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 13px; /* Menor, mais discreto */
	font-weight: 400;
	color: #000000;
	text-decoration: underline;
	cursor: pointer;
	transition: opacity 0.2s;
}

.modal-cart .pg-cart-summary-link:hover,
.modal-cart a.btn-link:hover {
	opacity: 0.6;
	text-decoration: underline;
}

/* FINALIZAR COMPRA Button */
.modal-cart .btn-primary[name="go_to_checkout"],
.modal-cart #go-to-checkout,
.modal-cart .js-cart-submit {
	width: 100%; /* Largura completa */
	max-width: 100%;
	height: 48px; /* Altura maior para destaque */
	background-color: #000000;
	border: none;
	border-radius: 6px; /* Bordas menos arredondadas */
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px; /* Reduzido de 20px */
	font-weight: 600; /* Semi-bold */
	color: #FFFFFF;
	text-transform: uppercase; /* Caixa alta */
	letter-spacing: 0.8px; /* Espaamento entre letras */
	padding: 0 24px;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 16px 0 0 0; /* Margem superior */
	cursor: pointer;
	transition: all 0.3s ease;
}

.modal-cart .btn-primary[name="go_to_checkout"]:hover,
.modal-cart #go-to-checkout:hover,
.modal-cart .js-cart-submit:hover {
	background-color: #1a1a1a; /* Cinza escuro no hover */
	transform: translateY(-1px); /* Elevao sutil */
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}

.modal-cart .btn-primary[name="go_to_checkout"]:active,
.modal-cart #go-to-checkout:active,
.modal-cart .js-cart-submit:active {
	transform: translateY(0);
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
}

/* Modal Body Padding */
.modal-cart .modal-body {
	padding: 20px; /* Mais espaamento */
	background-color: #FFFFFF;
}

/* Cart Items Container */
.modal-cart .js-ajax-cart-list,
.modal-cart .cart-row {
	background-color: transparent;
	margin-bottom: 16px;
}

/* Cart Item Spacing */
.modal-cart .pg-cart-item {
	padding: 16px 0;
	border-bottom: 1px solid #F0F0F0;
	margin-bottom: 0;
}

.modal-cart .pg-cart-item:last-child {
	border-bottom: none;
}

/* Remove any conflicting border radius */
.modal-cart {
	border-radius: 0;
}

/* Responsive Adjustments */
@media (max-width: 767px) {
	.modal-cart.modal-docked-md {
		width: 100%;
	}

	.modal-cart .btn-primary[name="go_to_checkout"],
	.modal-cart #go-to-checkout,
	.modal-cart .js-cart-submit {
		width: 100%;
		max-width: 100%;
	}
}

@media (min-width: 768px) {
	.modal-cart.modal-docked-md {
		width: 400px; /* Aumentado para 400px */
	}
}

/* Ensure all text elements inherit the font */
.modal-cart input,
.modal-cart select,
.modal-cart textarea,
.modal-cart button,
.modal-cart label,
.modal-cart span,
.modal-cart div,
.modal-cart p {
	font-family: 'Familjen Grotesk', sans-serif;
}

/* Alert messages in cart */
.modal-cart .alert {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 13px; /* Reduzido */
	color: #000000;
	padding: 12px;
}

/* Empty cart message */
.modal-cart .js-empty-ajax-cart {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px; /* Reduzido de 20px */
	color: #000000;
}

/* PATAGANG - Product Page Redesign - Layout Profissional Nuvemshop */
/*============================================================================
#PDP Custom Layout - Cards LADO A LADO (OBRIGATORIO EM DESKTOP)
REGRA CRITICA: Em desktop (>=992px), SEMPRE lado a lado. NUNCA empilhar!
==============================================================================*/

/* =====================================================================
   SEES DA PGINA DO PRODUTO - ESTRUTURA INDEPENDENTE
   Cada seo ocupa 100% width, est abaixo da anterior, sem sobreposio
   ===================================================================== */

/* Base para todas as sees da pgina do produto */
.pg-pdp-section {
	width: 100%;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
	align-items: stretch;
}

/* SEO 3: Container principal do produto (galeria + card) */
.pg-pdp-container {
	background-color: transparent;
	background-image: none;
	min-height: auto;
	padding: 0;  /* Sem padding no container pai */
	margin: 0;
}

/* Container principal - TRANSPARENT para banner ficar limpo */
.pg-pdp-container {
	padding-top: 0;                 /*  REMOVIDO: padding-top: 90px causava desalinhamento */
	padding-bottom: 0;              /*  REMOVIDO: padding-bottom: 60px */
	margin: 0;
	background-color: transparent;
	background-image: none;
	min-height: auto;               /* Sem height mnimo - cresce com contedo */
	display: flex;
	flex-direction: column;          /*  Banners em vertical (linhas), no colunas */
	align-items: stretch;            /* Filhos ocupam 100% width */
	justify-content: flex-start;
}

/* Row principal - Bootstrap row - AQUI est o fundo branco */
.pg-pdp-container .section-single-product {
	margin: 0;
	padding: 20px;                  /*  Reduzido: 40px  20px (mobile no precisa de espao duplo) */
	width: 100%;
	background-color: #ffffff;
	background-image: none;
	display: flex;
	flex-direction: row;
	gap: 0;
}

/* Tablet (577px-768px) - Slightly more padding */
@media (min-width: 577px) and (max-width: 768px) {
	.pg-pdp-container .section-single-product {
		padding: 30px 25px;
		margin-top: 0;
	}
}

/* Desktop (769px) - Full padding */
@media (min-width: 769px) {
	.pg-pdp-container .section-single-product {
		padding: 40px 40px;
		margin-top: 0;
	}
}

/* DESKTOP: FORAR lado a lado - sobrescreve Bootstrap */
@media (min-width: 992px) {
	.pg-pdp-container .section-single-product.row {
		display: flex;
		flex-direction: row;
		flex-wrap: nowrap;
		align-items: stretch;
		gap: 40px;
		padding: 40px 40px;
		margin-top: 0;
	}

	/* LEFT COLUMN - Product Image (full height, clean design) */
	.pg-pdp-container .pg-pdp-image-col {
		flex: 0 0 60%;
		max-width: 60%;
		width: 60%;
		padding: 0;
		height: 100%;  /* Preenche altura total */
		display: flex;
		flex-direction: column;
		position: sticky;  /*  STICKY para acompanhar scroll */
		top: 120px;  /* Offset para header fixo */
		align-self: stretch;
	}

	/* COLUNA DIREITA - Info - PREENCHE ALTURA */
	.pg-pdp-container .pg-pdp-info-col {
		flex: 0 0 40%;
		max-width: 40%;
		width: 40%;
		padding: 0;
		height: 100%;  /* Preenche altura total */
		display: flex;
		flex-direction: column;
		align-self: stretch;
	}
}

/* LEFT COLUMN - Product Image (full height, clean design) */
.pg-pdp-image-col {
	background: transparent; /* SEM fundo */
	border-radius: 0; /* SEM bordas arredondadas */
	padding: 0; /* SEM padding */
	overflow: visible;
	display: flex;
	flex-direction: column;  /* Permite filho crescer verticalmente */
	align-items: stretch;
	justify-content: flex-start;
	box-sizing: border-box;
	box-shadow: none; /* SEM sombra */
	height: 100%;  /* Preenche altura total */
}

/* Image Container - Fills parent, responsive */
.pg-pdp-image-col .product-image-container {
	width: 100%;
	flex: 1;  /* Cresce para preencher altura */
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	justify-content: flex-start;
	padding: 0;
	height: 100%;
}

/* Swiper container - altura automtica */
.pg-pdp-image-col .js-swiper-product {
	width: 100%;
	height: auto;
	min-height: auto;
}

/* Desktop (992px): Show grid 2x2, hide Swiper */
@media (min-width: 992px) {
	.pg-pdp-image-col .product-image-container {
		display: none;
	}
	.pg-pdp-image-col .js-swiper-product {
		display: none;
	}

	/* Story 11.2: desktop gallery must stay 2x2 visible */
	.pg-pdp-image-col {
		overflow: visible;
		min-height: 0;
	}

	.pg-gallery-container {
		display: flex !important;
		width: 100%;
		/* max-height = 2 linhas  clamp(200px,24vh,280px) + 1 gap 12px = clamp(412,48vh+12,572) */
		max-height: clamp(412px, calc(48vh + 12px), 572px);
		overflow-y: auto;
		overflow-x: hidden;
		overscroll-behavior: contain;
		scroll-behavior: smooth;
		min-height: 0;
		padding-right: 8px;
		box-sizing: border-box;
	}

	.pg-pdp-image-col .pg-gallery-grid {
		display: grid;
		grid-template-columns: repeat(2, minmax(0, 1fr));
		grid-auto-rows: clamp(200px, 24vh, 280px);
		gap: 12px;
		height: auto;
		align-content: flex-start;
	}

	.pg-pdp-image-col .pg-gallery-item {
		min-height: 0;
	}

	.pg-pdp-image-col .pg-gallery-link {
		display: block;
		position: relative;
		width: 100%;
		height: 100%;
		border-radius: 4px;
		overflow: hidden;
	}

	.pg-pdp-image-col .pg-gallery-img {
		width: 100%;
		height: 100%;
		object-fit: cover;
		display: block;
		border-radius: 4px;
	}
}

/* Mobile (<992px): Hide grid 2x2, show Swiper */
@media (max-width: 991px) {
	/* Gallery grid must be completely hidden on mobile */
	.pg-gallery-container {
		display: none !important;
		visibility: hidden !important;
	}
}

/* Wrapper do swiper */
.pg-pdp-image-col .swiper-wrapper {
	align-items: flex-start;
	transition-timing-function: ease-in-out;
	height: auto;
}

.pg-pdp-image-col .swiper-slide {
	display: flex;
	align-items: flex-start;
	justify-content: center;
	height: auto;
	width: 100%;
	transition: opacity 0.5s ease-in-out;
}

/* Link da imagem - ajusta  imagem */
.pg-pdp-image-col .js-product-slide-link {
	padding-bottom: 0;
	position: relative;
	display: flex;
	align-items: flex-start;
	justify-content: center;
	width: 100%;
	height: auto;
	min-height: auto;
	padding: 0;
}

/* Imagem do produto - GRANDE E SEM RESTRIES */
.pg-pdp-image-col .product-slider-image {
	position: relative;
	left: auto;
	top: auto;
	transform: none;
	width: 100%; /* Ocupa toda a largura */
	height: auto;
	max-width: 100%;
	max-height: none; /* SEM limite de altura */
	object-fit: contain;
	transition: opacity 0.4s ease;
	border-radius: 20px; /* Bordas arredondadas na prpria imagem */
	box-shadow: 0 8px 32px rgba(0,0,0,0.1); /* Sombra na imagem */
}

/* Navegao do slider - mais discreta */
.pg-pdp-image-col .swiper-button-prev,
.pg-pdp-image-col .swiper-button-next {
	color: #333;
	background: rgba(255, 255, 255, 0.9);
	width: 32px;
	height: 32px;
	border-radius: 50%;
	box-shadow: 0 2px 8px rgba(0,0,0,0.1);
	opacity: 0.7;
	transition: opacity 0.3s ease;
	background-image: url('{{ 'images/logos/logo-mark.svg' | static_url }}');
	background-repeat: no-repeat;
	background-position: center;
	background-size: 18px 18px;
}

.pg-pdp-image-col:hover .swiper-button-prev,
.pg-pdp-image-col:hover .swiper-button-next {
	opacity: 1;
}

.pg-pdp-image-col .swiper-button-prev { left: 10px; transform: scaleX(-1); }
.pg-pdp-image-col .swiper-button-next { right: 12px; }

.pg-pdp-image-col .swiper-button-prev:after,
.pg-pdp-image-col .swiper-button-next:after {
	content: '';
}

/* Paginao */
.pg-pdp-image-col .swiper-pagination {
	bottom: 12px;
	position: absolute;
}

.pg-pdp-image-col .swiper-pagination-bullet {
	background: rgba(0, 0, 0, 0.25);
	width: 7px;
	height: 7px;
}

.pg-pdp-image-col .swiper-pagination-bullet-active {
	background: #000;
}

/* Ocultar thumbnails */
.pg-pdp-image-col .product-thumb,
.pg-pdp-image-col .product-thumbs-container,
.pg-pdp-image-col [class*="thumb"] {
	display: none;
}

/* COLUNA DIREITA - Card de informaes */
.pg-pdp-info-col {
	display: flex;
	align-items: center; /* Centraliza contedo interno */
	justify-content: center;
	padding: 0;
	position: relative;
}

/* Reset alignment on mobile */
@media (max-width: 991px) {
	.pg-pdp-info-col {
		align-items: flex-start !important;
		justify-content: flex-start !important;
	}
}

/* MARCA D'GUA DO LOGO - Visvel atravs do blur do card */
.pg-pdp-watermark {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 200px;
	height: 200px;
	object-fit: contain;
	opacity: 0.25;
	pointer-events: none;
	z-index: 0;
}

@media (min-width: 992px) {
	.pg-pdp-watermark {
		width: 260px;
		height: 260px;
		opacity: 0.22;
	}
}

@media (min-width: 1200px) {
	.pg-pdp-watermark {
		width: 300px;
		height: 300px;
		opacity: 0.20;
	}
}

/* Card de informaes - COMPACTO verticalmente, LARGO horizontalmente */
.pg-pdp-info-card {
	background: rgba(255, 255, 255, 0.55);
	backdrop-filter: blur(12px);
	-webkit-backdrop-filter: blur(12px);
	border: none;
	border-radius: 20px;
	box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
	padding: 24px 28px; /* REDUZIDO verticalmente */
	width: 100%;
	max-width: 100%;
	position: relative;
	z-index: 1;
}

@media (min-width: 992px) {
	.pg-pdp-info-card {
		padding: 28px 32px; /* Mais padding horizontal que vertical */
		background: rgba(255, 255, 255, 0.50);
	}
}

@media (min-width: 1200px) {
	.pg-pdp-info-card {
		padding: 28px 36px; /* Ainda mais largo */
	}
}

/* Contedo do card */
.pg-product-card-content .page-header {
	display: none;
}

/* Header do produto - Nome + Preo na mesma linha - COMPACTO */
.pg-product-header {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	margin-bottom: 16px; /* REDUZIDO */
	gap: 16px;
	padding-bottom: 12px; /* REDUZIDO */
	border-bottom: 1px solid rgba(0, 0, 0, 0.08);
}

/* Ttulo do produto - DESTAQUE */
.pg-product-title {
	font-family: 'Familjen Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
	font-size: 13px;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.8px;
	line-height: 1.3;
	margin: 0;
	color: #000;
	flex: 1;
}

/* Seo de preo - DESTAQUE */
.pg-product-price-section {
	margin: 0;
	text-align: right;
	flex-shrink: 0;
}

.pg-product-price {
	font-family: 'Familjen Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
	font-size: 15px;
	font-weight: 700;
	color: #000;
	letter-spacing: 0.3px;
}

/* Formulrio do produto */
.pg-product-form {
	margin: 0;
}

/* Variantes customizadas - COMPACTO */
.pg-variants-container {
	margin-bottom: 14px; /* REDUZIDO */
}

.pg-variant-group {
	margin-bottom: 10px; /* REDUZIDO */
}

/* Seletores de cores - Quadrados (Prototipo Adobe XD) */
.pg-color-swatches {
	display: flex;
	gap: 8px;
	align-items: center;
	margin-bottom: 15px;
}

.pg-color-swatch {
	width: 24px; /* Menor */
	height: 24px;
	border-radius: 0;
	border: 1px solid rgba(0, 0, 0, 0.2);
	cursor: pointer;
	transition: all 0.2s ease;
	padding: 0;
	position: relative;
}

.pg-color-swatch:hover {
	transform: scale(1.1);
	border-color: #000;
}

.pg-color-swatch.active {
	border-color: #000;
	border-width: 2px;
	box-shadow: none;
}

/* Seletores de tamanho */
.pg-size-selector-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 15px;
}

.pg-size-buttons {
	display: flex;
	gap: 10px;
}

.pg-size-btn {
	min-width: 34px; /* Menor */
	height: 34px;
	border: 1px solid #d0d0d0;
	background-color: transparent;
	font-family: 'Familjen Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
	font-size: 11px; /* Fonte menor */
	font-weight: 500;
	color: #000;
	cursor: pointer;
	transition: all 0.3s ease;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0 12px;
}

.pg-size-btn:hover {
	border-color: #000;
	background-color: rgba(0, 0, 0, 0.05);
}

.pg-size-btn.active {
	border-color: #000;
	background-color: #000;
	color: #fff;
	font-weight: 600;
}

.pg-size-guide-link {
	font-family: 'Familjen Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
	font-size: 11px;
	font-weight: 400;
	text-decoration: underline;
	color: #666;
	white-space: nowrap;
	cursor: pointer;
}

.pg-size-guide-link:hover {
	color: #000;
}

/* Boto adicionar - COMPACTO */
.pg-product-add-btn {
	width: 100%;
	height: 38px; /* REDUZIDO */
	background-color: transparent;
	border: 1.5px solid #000;
	font-family: 'Familjen Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
	font-size: 12px;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.8px;
	color: #000;
	cursor: pointer;
	transition: all 0.3s ease;
	margin-bottom: 16px; /* REDUZIDO */
}

.pg-product-add-btn:hover {
	background-color: #000;
	color: #fff;
}

.pg-product-add-btn:disabled {
	opacity: 0.5;
	cursor: not-allowed;
}

/* Accordions - COMPACTO */
.pg-product-accordions {
	border-top: 1px solid #e0e0e0;
}

.pg-accordion-item {
	border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.pg-accordion-item:first-child {
	border-top: 1px solid rgba(0, 0, 0, 0.1);
}

.pg-accordion-header {
	width: 100%;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 0; /* REDUZIDO */
	background: none;
	border: none;
	font-family: 'Familjen Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
	font-size: 12px;
	font-weight: 600;
	letter-spacing: 0.5px;
	text-transform: uppercase;
	color: #000;
	cursor: pointer;
	text-align: left;
}

.pg-accordion-header:hover {
	opacity: 0.7;
}

.pg-accordion-icon {
	font-size: 18px; /* REDUZIDO */
	font-weight: 300;
	transition: transform 0.3s ease;
	color: #666;
}

.pg-accordion-item.active .pg-accordion-icon {
	transform: rotate(0deg);
}

.pg-accordion-content {
	max-height: 0;
	overflow: hidden;
	transition: max-height 0.4s ease, padding 0.3s ease;
	font-family: 'Familjen Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
	font-size: 11px;
	line-height: 1.5; /* REDUZIDO */
	color: #444;
}

.pg-accordion-item.active .pg-accordion-content {
	max-height: 500px; /* REDUZIDO */
	padding-bottom: 14px; /* REDUZIDO */
}

/* Formatao do contedo do accordion */
.pg-accordion-content .user-content {
	padding-top: 4px;
}

.pg-accordion-content .user-content p {
	margin-bottom: 8px; /* REDUZIDO */
}

.pg-accordion-content .user-content strong {
	font-weight: 600;
	color: #000;
}

/* Ocultar elementos do layout antigo */
.pg-pdp-info-card .js-product-payments-container,
.pg-pdp-info-card .product-detail-installments,
.pg-pdp-info-card .card-img-small,
.pg-pdp-info-card #btn-installments,
.pg-pdp-info-card .free-shipping-message,
.pg-pdp-info-card #product-shipping-container,
.pg-pdp-info-card .social-share,
.pg-pdp-info-card .product-description {
	display: none;
}

/* Containers extras (FB comments, Reviews) - ocultos quando vazios */
.pg-pdp-extras-container:empty,
.pg-pdp-reviews-container:empty,
#reviewsapp:empty {
	display: none;
}

.pg-pdp-extras-container,
.pg-pdp-reviews-container {
	background: transparent;
	padding: 0;
	margin: 0;
}

/* Ocultar container vazio do Bootstrap dentro do PDP */
.pg-pdp-container > .container:empty {
	display: none;
	padding: 0;
	margin: 0;
}

/* Responsivo - Tablet e Mobile */
@media (max-width: 991px) {
	.pg-pdp-container {
		padding-top: 80px;
		padding-bottom: 40px;         /* Padding inferior para separao */
		padding-left: 0;              /*  BUG #3 FIX: zero lateral para filhos full-width */
		padding-right: 0;             /*  BUG #3 FIX: zero lateral para filhos full-width */
		align-items: flex-start;
		background-color: #ffffff;    /*  LIMPO: Branco puro (padro home) */
		background-image: none;
	}

	.pg-pdp-container .section-single-product {
		display: flex !important;     /*  EXTRA: fora flex layout explicitamente */
		flex-direction: column !important;  /*  EXTRA: fora coluna com !important */
		padding: 20px 0 !important;   /*  BUG #3 FIX: zero padding lateral - filhos controlam o prprio espao */
		gap: 20px;
		width: 100% !important;       /*  EXTRA: container ocupa 100% */
		align-items: stretch !important;  /*  EXTRA: filhos ocupam full width */
	}

	/* Remove Bootstrap padding from both columns */
	.pg-pdp-image-col,
	.pg-pdp-info-col {
		padding-right: 0 !important;  /*  CRTICO: remove Bootstrap .col padding */
		padding-left: 0 !important;   /*  CRTICO: remove Bootstrap .col padding */
	}

	.pg-pdp-image-col {
		max-width: 100%;
		width: 100%;
		padding: 0 15px;              /*  Imagem mantm padding lateral para respiro */
		min-height: auto;
		border-radius: 0;
		background: transparent;
		box-shadow: none;
	}

	.pg-pdp-image-col .product-slider-image {
		max-width: 100%;
		max-height: none;
		border-radius: 16px;
	}

	.pg-pdp-info-col {
		max-width: 100% !important;   /*  BUG #3 CRITICAL FIX: sobrescreve Bootstrap .col-lg-5 max-width */
		width: 100% !important;       /*  BUG #3 FIX: garante 100% */
		padding: 0 !important;        /*  BUG #3 FIX: sem padding lateral no col */
		padding-right: 0 !important;  /*  EXTRA: remove padding direito Bootstrap */
		padding-left: 0 !important;   /*  EXTRA: remove padding esquerdo Bootstrap */
		box-sizing: border-box;
		flex: 0 0 100% !important;    /*  EXTRA: fora flex layout a 100% */
	}

	.pg-pdp-watermark {
		width: 120px;
		height: 120px;
		opacity: 0.20;
	}

	.pg-pdp-info-card {
		padding: 22px 20px;           /* Padding interno do card para contedo respirar */
		max-width: 100%;
		width: 100% !important;       /*  BUG #3 FIX: card ocupa 100% */
		border-radius: 0;             /*  BUG #3 FIX: full-bleed mobile (sem bordas laterais) */
		box-sizing: border-box;
		margin: 0;                    /*  Sem margin que quebraria full-width */
	}
}

@media (max-width: 576px) {
	.pg-product-title {
		font-size: 14px;
		letter-spacing: 0.5px;
	}

	.pg-product-price {
		font-size: 16px;
	}

	.pg-size-btn {
		min-width: 36px;
		height: 36px;
		font-size: 12px;
	}

	.pg-color-swatch {
		width: 24px;
		height: 24px;
	}

	.pg-accordion-header {
		font-size: 12px;
		padding: 15px 0;
	}

	.pg-accordion-content {
		font-size: 12px;
	}
}

/* ============================================
   IDENTITY BANNER - MINIMALISTA PATAGANG
   (Seo separada, fora do produto)
   ============================================ */

/* Identity Banner - Main compensa header padding, banner no precisa de margin-top extra */
.pg-identity-banner {
	width: 100%;
	background: #FFFFFF;
	border-top: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	padding: 12px 20px;
	margin: 0;  /*  REFATORAO: Main (160px padding) compensa header */
	margin-bottom: 16px;  /*  Espao abaixo do banner */
	box-sizing: border-box;
	position: relative;
	z-index: 10;
	clear: both;
}

.pg-identity-banner__content {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 40px;
	margin: 0;
	width: 100%;
	flex-wrap: wrap;
	padding: 0;
	box-sizing: border-box;
}

.pg-identity-banner__phrase {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 13px;
	font-weight: 500;
	color: #333;
	line-height: 1.3;
	text-align: center;
	letter-spacing: 0.3px;
	white-space: normal;
	flex: 0 1 auto;
}

/* Tablet (577px-768px) - Compact layout */
@media (min-width: 577px) and (max-width: 768px) {
	.pg-identity-banner {
		padding: 16px 15px;
		margin-top: 0;
		position: relative;
		z-index: 10;
	}

	.pg-identity-banner__content {
		gap: 20px;
	}

	.pg-identity-banner__phrase {
		font-size: 12px;
	}
}

/* Large Tablet to Desktop (769px) - Full layout */
@media (min-width: 769px) {
	.pg-identity-banner {
		padding: 16px 20px;
		margin-top: 0;
		position: relative;
		z-index: 10;
	}

	.pg-identity-banner__content {
		gap: 40px;
	}

	.pg-identity-banner__phrase {
		font-size: 13px;
	}
}

/* Mobile (576px) - Stack vertical */
@media (max-width: 576px) {
	.pg-identity-banner {
		padding: 12px 10px;
		margin: 0;  /*  REFATORAO: Main compensa header */
		margin-bottom: 12px;  /*  Espao abaixo */
		position: relative;
		z-index: 10;
	}

	.pg-identity-banner__content {
		gap: 0;
		flex-direction: column;
	}

	.pg-identity-banner__phrase {
		font-size: 11px;
		padding: 8px 0;
		border-bottom: 1px solid #f0f0f0;
	}

	.pg-identity-banner__phrase:last-child {
		border-bottom: none;
	}
}

/* ============================================
   MAIN CONTENT PADDING - Accommodate sticky header
   ============================================ */
main.patagang-section-content {
	padding-top: 160px;  /* Space for fixed header (~120px) + ad bar (~40px) = ~160px */
}

/* HOME PAGE: padding-top 0 - hero  full-bleed, header  transparente sobre o hero */
/* Bug #1 FIX: Faixa branca removida. A home no precisa de padding pois o hero ocupa o topo */
body.template-home main.patagang-section-content {
	padding-top: 0;  /*  HOME: hero comea imediatamente, sem espao branco */
}

/* PRODUCT PAGE: Restore padding to compensate for fixed header (refactor fix) */
body.template-product main.patagang-section-content {
	padding-top: 160px;  /*  REFATORAO: Main compensa header fixo, banners sem override */
}

@media (max-width: 991px) {
	main.patagang-section-content {
		padding-top: 140px;  /* Tablet: slightly less */
	}

	/* HOME PAGE Tablet: hero full-bleed em todos os breakpoints */
	body.template-home main.patagang-section-content {
		padding-top: 0;  /*  HOME Tablet: hero comea imediatamente */
	}

	/* PRODUCT PAGE: Mobile adjustments */
	body.template-product main.patagang-section-content {
		padding-top: 140px;  /*  Tablet PDP: compensa header */
	}
}

@media (max-width: 576px) {
	main.patagang-section-content {
		padding-top: 130px;  /* Mobile: header is smaller but still fixed */
	}

	/* HOME PAGE Mobile: hero full-bleed em todos os breakpoints */
	body.template-home main.patagang-section-content {
		padding-top: 0;  /*  HOME Mobile: hero comea imediatamente */
	}

	/* PRODUCT PAGE: Mobile adjustments */
	body.template-product main.patagang-section-content {
		padding-top: 130px;  /*  Mobile PDP: compensa header */
	}
}

/* ============================================
   PRODUCT PAGE SECTIONS - Banner + Product container spacing
   ============================================ */

/* Banner informativo do produto - espaamento independente */
body.template-product div.pg-pdp-section.pg-pdp-banner-informative {
	width: 100%;
	margin: 0;
	padding: 20px;
	background: #ffffff;
	z-index: 10;
	position: relative;
}

/* Seo do produto (galeria + card) - contedo principal */
body.template-product div.pg-pdp-section.pg-pdp-container {
	width: 100%;
	margin: 0;
	padding: 0;
}

/* ============================================
   SACOLA LATERAL (CART MODAL) - PATAGANG DESIGN
   ============================================ */

/* Modal do carrinho - Estilo similar ao prottipo */
#modal-cart {
	background: #fff;
	box-shadow: -4px 0 24px rgba(0, 0, 0, 0.12);
}

#modal-cart .modal-header {
	padding: 24px 28px 16px;
	border-bottom: none;
	font-size: 18px;
	font-weight: 700;
	letter-spacing: 1px;
	text-transform: uppercase;
}

#modal-cart .modal-body {
	padding: 0 28px;
}

#modal-cart .modal-footer {
	padding: 20px 28px 28px;
	border-top: none;
}

/* Boto fechar do modal */
#modal-cart .modal-close {
	position: absolute;
	right: 20px;
	top: 20px;
	width: 40px;
	height: 40px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #f5f5f5;
	border-radius: 8px;
	border: none;
	cursor: pointer;
	transition: background 0.2s;
}

#modal-cart .modal-close:hover {
	background: #e5e5e5;
}

/* Items do carrinho */
.pg-cart-item {
	padding: 20px 0;
	border-bottom: 1px solid #f0f0f0;
}

.pg-cart-item:last-child {
	border-bottom: none;
}

/* Imagem do item */
.pg-cart-item-image-container {
	padding-right: 16px;
}

.pg-cart-item-image {
	width: 100%;
	max-width: 120px;
	height: auto;
	border-radius: 12px;
	background: #f8f8f8;
	object-fit: cover;
	aspect-ratio: 1/1;
}

/* Detalhes do item */
.pg-cart-item-details {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	min-height: 100%;
}

.pg-cart-item-header {
	margin-bottom: 8px;
}

.pg-cart-item-name {
	font-size: 14px;
	font-weight: 600;
	color: #000;
	margin-bottom: 2px;
	line-height: 1.3;
}

.pg-cart-item-name a {
	color: inherit;
	text-decoration: none;
}

.pg-cart-item-variant {
	font-size: 12px;
	color: #666;
	display: block;
	margin-top: 2px;
}

.pg-cart-item-price {
	font-size: 15px;
	font-weight: 700;
	color: #000;
	margin: 0;
}

/* Controles de quantidade */
.pg-cart-quantity-input {
	display: inline-flex;
	align-items: center;
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	overflow: hidden;
	background: #fff;
}

.pg-cart-quantity-btn {
	width: 32px;
	height: 32px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: transparent;
	border: none;
	cursor: pointer;
	padding: 0;
	color: #333;
	transition: background 0.2s;
}

.pg-cart-quantity-btn:hover {
	background: #f5f5f5;
}

.pg-cart-quantity-input input {
	width: 36px;
	height: 32px;
	text-align: center;
	border: none;
	font-size: 14px;
	font-weight: 600;
	padding: 0;
	-moz-appearance: textfield;
}

.pg-cart-quantity-input input::-webkit-outer-spin-button,
.pg-cart-quantity-input input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

/* Boto de remover item */
.pg-cart-delete-btn {
	background: transparent;
	border: none;
	color: #999;
	cursor: pointer;
	padding: 8px;
	transition: color 0.2s;
}

.pg-cart-delete-btn:hover {
	color: #333;
}

/* Totais do carrinho */
.cart-row {
	padding: 16px 0;
}

.cart-totals-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 8px 0;
	font-size: 14px;
}

.cart-totals-row.total {
	font-size: 16px;
	font-weight: 700;
	padding-top: 16px;
	margin-top: 8px;
	border-top: 1px solid #e0e0e0;
}

/* Boto Finalizar Compra */
#modal-cart .btn-primary,
.js-ajax-cart-panel .btn-primary {
	width: 100%;
	padding: 16px 24px;
	background: #000;
	color: #fff;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 700;
	letter-spacing: 1px;
	text-transform: uppercase;
	cursor: pointer;
	transition: background 0.2s, transform 0.2s;
}

#modal-cart .btn-primary:hover,
.js-ajax-cart-panel .btn-primary:hover {
	background: #333;
	transform: translateY(-1px);
}

/* Links do carrinho (Calcular frete, Cupom) */
.cart-link,
.cart-totals-row a {
	color: #000;
	text-decoration: underline;
	font-size: 13px;
}

.cart-link:hover,
.cart-totals-row a:hover {
	color: #333;
}

/* Carrinho vazio */
.js-empty-ajax-cart .alert {
	background: #f8f8f8;
	border: none;
	border-radius: 12px;
	padding: 24px;
	text-align: center;
	color: #666;
}

/* Responsivo carrinho modal */
@media (min-width: 768px) {
	#modal-cart.modal-docked-md {
		width: 420px;
		max-width: 420px;
	}

	.pg-cart-item-image {
		max-width: 100px;
	}
}

@media (max-width: 767px) {
	#modal-cart .modal-header {
		padding: 20px 20px 12px;
		font-size: 16px;
	}

	#modal-cart .modal-body {
		padding: 0 20px;
	}

	#modal-cart .modal-footer {
		padding: 16px 20px 24px;
	}

	.pg-cart-item {
		padding: 16px 0;
	}

	.pg-cart-item-image {
		max-width: 80px;
		border-radius: 8px;
	}

	.pg-cart-item-name {
		font-size: 13px;
	}
}

/* ============================================
   CARD PRODUTO EM DESENVOLVIMENTO - PATAGANG
   Baseado no prottipo oficial
   ============================================ */

.pg-dev-card {
    position: relative;
    width: 100%;
    min-height: 350px;

    /* GRADIENTE RADIAL - Efeito Spotlight amarelo */
    background: radial-gradient(
        circle at center,
        rgba(244, 255, 95, 0.85) 0%,
        rgba(248, 250, 235, 1) 60%,
        rgba(255, 255, 255, 1) 100%
    );

    /* Bordas bem arredondadas */
    border-radius: 30px;

    /* Sombra suave */
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);

    /* Centralizao do contedo */
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px;
    box-sizing: border-box;
}

/* MARCADORES DE CANTO (BRACKETS em L) */
.pg-dev-card__corner {
    position: absolute;
    width: 20px;
    height: 20px;
    border-color: #000;
    border-style: solid;
    border-width: 0;
    pointer-events: none;
}

/* Canto superior esquerdo */
.pg-dev-card__corner--top-left {
    top: 30px;
    left: 30px;
    border-top-width: 3px;
    border-left-width: 3px;
}

/* Canto superior direito */
.pg-dev-card__corner--top-right {
    top: 30px;
    right: 30px;
    border-top-width: 3px;
    border-right-width: 3px;
}

/* Canto inferior esquerdo */
.pg-dev-card__corner--bottom-left {
    bottom: 30px;
    left: 30px;
    border-bottom-width: 3px;
    border-left-width: 3px;
}

/* Canto inferior direito */
.pg-dev-card__corner--bottom-right {
    bottom: 30px;
    right: 30px;
    border-bottom-width: 3px;
    border-right-width: 3px;
}

/* CONTEDO CENTRAL */
.pg-dev-card__content {
    text-align: center;
    z-index: 2;
}

/* TTULO */
.pg-dev-card__title {
    font-family: 'Familjen Grotesk', 'Helvetica', 'Arial', sans-serif;
    font-size: 14px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    color: #000;
    margin: 0 0 25px 0;
}

/* BOTO */
.pg-dev-card__button {
    display: inline-block;
    background-color: #000;
    color: #F4FF5F; /* Texto amarelo neon */
    text-decoration: none;
    padding: 15px 30px;
    font-family: 'Familjen Grotesk', 'Helvetica', 'Arial', sans-serif;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
    letter-spacing: 1px;
    border: 1px solid #000;
    cursor: pointer;
    transition: all 0.3s ease;
}

.pg-dev-card__button:hover {
    background-color: transparent;
    color: #000;
}

/* Informaes do produto abaixo do card */
.pg-dev-card__product-info {
    margin-top: 24px;
    padding: 0 8px;
}

.pg-dev-card__product-name {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 600;
    font-size: 20px;
    color: #000;
    margin: 0;
}

.pg-dev-card__accordions {
    margin-top: 24px;
}

/* Responsivo */
@media (max-width: 767px) {
    .pg-dev-card {
        min-height: 280px;
        padding: 32px 24px;
        border-radius: 24px;
    }

    .pg-dev-card__corner {
        width: 16px;
        height: 16px;
    }

    .pg-dev-card__corner--top-left,
    .pg-dev-card__corner--top-right {
        top: 24px;
    }

    .pg-dev-card__corner--bottom-left,
    .pg-dev-card__corner--bottom-right {
        bottom: 24px;
    }

    .pg-dev-card__corner--top-left,
    .pg-dev-card__corner--bottom-left {
        left: 24px;
    }

    .pg-dev-card__corner--top-right,
    .pg-dev-card__corner--bottom-right {
        right: 24px;
    }

    .pg-dev-card__title {
        font-size: 12px;
        margin-bottom: 20px;
    }

    .pg-dev-card__button {
        padding: 12px 24px;
        font-size: 11px;
    }

    .pg-dev-card__product-name {
        font-size: 18px;
    }
}

/* ============================================
   MODAL NEWSLETTER - PATAGANG
   ============================================ */

.pg-modal-newsletter {
    position: fixed;
    inset: 0;
    z-index: 9999;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.pg-modal-newsletter__overlay {
    position: absolute;
    inset: 0;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    cursor: pointer;
}

.pg-modal-newsletter__card {
    position: relative;
    background: radial-gradient(ellipse at center, rgba(234, 254, 103, 1) 0%, rgba(234, 254, 103, 0.85) 40%, rgba(234, 254, 103, 0.5) 65%, rgba(234, 254, 103, 0) 85%);
    border-radius: 24px;
    padding: 60px 50px;
    max-width: 580px;
    width: 100%;
    box-shadow: none;
    animation: modalSlideIn 0.3s ease;
}

@keyframes modalSlideIn {
    from {
        opacity: 0;
        transform: translateY(-20px) scale(0.95);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

.pg-modal-newsletter__close {
    position: absolute;
    top: 16px;
    right: 16px;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: transparent;
    border: none;
    cursor: pointer;
    color: #000;
    transition: transform 0.2s;
}

.pg-modal-newsletter__close:hover {
    transform: scale(1.1);
}

.pg-modal-newsletter__content {
    text-align: center;
}

.pg-modal-newsletter__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    font-size: 28px;
    color: #000;
    margin: 0 0 12px;
}

.pg-modal-newsletter__text {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 15px;
    color: #333;
    margin: 0 0 28px;
    line-height: 1.5;
}

.pg-modal-newsletter__form {
    margin-top: 8px;
}

.pg-modal-newsletter__input-group {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
}

.pg-modal-newsletter__input {
    flex: 1;
    min-width: 200px;
    padding: 14px 18px;
    background: #fff;
    border: 2px solid transparent;
    border-radius: 8px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 15px;
    color: #000;
    transition: border-color 0.2s;
}

.pg-modal-newsletter__input:focus {
    outline: none;
    border-color: #000;
}

.pg-modal-newsletter__input::placeholder {
    color: #999;
}

.pg-modal-newsletter__btn {
    padding: 14px 28px;
    background: #000;
    color: #fff;
    border: none;
    border-radius: 8px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 600;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 1px;
    cursor: pointer;
    transition: background 0.2s, transform 0.2s;
}

.pg-modal-newsletter__btn:hover {
    background: #333;
    transform: translateY(-1px);
}

/* Alert messages */
.pg-modal-newsletter__messages {
    margin-bottom: 20px;
}

.pg-modal-newsletter__alert {
    padding: 14px 18px;
    border-radius: 8px;
    font-size: 14px;
    text-align: center;
}

.pg-modal-newsletter__alert--success {
    background: rgba(0, 150, 0, 0.15);
    color: #006600;
}

.pg-modal-newsletter__alert--error {
    background: rgba(200, 0, 0, 0.15);
    color: #990000;
}

/* Branding/Logo */
.pg-modal-newsletter__branding {
    position: absolute;
    bottom: -20px;
    right: -20px;
    width: 120px;
    height: 120px;
    opacity: 0.15;
    pointer-events: none;
}

.pg-modal-newsletter__logo {
    width: 100%;
    height: 100%;
    object-fit: contain;
}

/* Responsivo */
@media (max-width: 480px) {
    .pg-modal-newsletter__card {
        padding: 40px 24px;
    }

    .pg-modal-newsletter__title {
        font-size: 24px;
    }

    .pg-modal-newsletter__text {
        font-size: 14px;
    }

    .pg-modal-newsletter__input-group {
        flex-direction: column;
    }

    .pg-modal-newsletter__input {
        min-width: 100%;
    }

    .pg-modal-newsletter__btn {
        width: 100%;
    }
}

/* ============================================
   PATAGANG DRAWER - Critical CSS (Anti-FOUC)
   ============================================ */

/* Garantir que drawer est oculto desde o incio */
#nav-drawer {
    visibility: hidden;
    pointer-events: none;
}

#nav-drawer .pg-drawer__panel {
    transform: translateX(-100%);
}

/* Cart Drawer Coupon Input - Apply discount codes
.pg-drawer__coupon-section {
    margin: 12px 0 8px;
    padding: 0;
}

.pg-drawer__coupon-form {
    width: 100%;
    margin: 0;
}

.pg-drawer__coupon-group {
    display: flex;
    gap: 6px;
    width: 100%;
}

.pg-drawer__coupon-input {
    flex: 1;
    padding: 8px 10px;
    font-size: 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-family: inherit;
    color: #333;
}

.pg-drawer__coupon-input::placeholder {
    color: #999;
    font-size: 12px;
}

.pg-drawer__coupon-btn {
    padding: 8px 16px;
    font-size: 12px;
    font-weight: 600;
    background-color: #000;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.2s;
    white-space: nowrap;
}

.pg-drawer__coupon-btn:hover {
    background-color: #333;
}

/* ============================================
   PATAGANG HOME - Anti-FOUC (Critical CSS)
   ============================================ */

/* Ocultar elementos da home at CSS assncrono carregar */
.hero,
.featured-product,
.coming-soon,
.yellow-gradient-wrapper {
    visibility: hidden;
}

/* Mostrar quando CSS assncrono carregar */
.visible-when-content-ready {
    visibility: visible;
}

/* ============================================
   PATAGANG - MODAL CART CRITICAL STYLES
   IMPORTANTE: Inline no critical para garantir aplicao
   ============================================ */

/* Fora TODOS os textos em PRETO - Override mximo */
#modal-cart *:not(.btn):not(.icon-inline):not(svg):not(path):not(button),
#modal-cart .text-accent,
#modal-cart .pg-cart-summary *,
#modal-cart .pg-cart-summary__installments,
#modal-cart .pg-cart-summary__installments *,
#modal-cart [class*="installment"],
#modal-cart .js-cart-total,
#modal-cart .pg-cart-summary__row,
#modal-cart .pg-cart-summary__label,
#modal-cart .pg-cart-summary__value {
    color: #000;
}

/* Remove cores inline amarelas */
#modal-cart [style*="color"] {
    color: #000;
}

/* Tamanho do produto - limpo sem fundo */
#modal-cart .pg-cart-item__variant {
    font-size: 12px;
    color: #666;
    font-weight: 400;
    background: transparent;
    padding: 0;
    margin-top: 2px;
    display: block;
}

#modal-cart .pg-cart-item__variant::before {
    content: "Tam: ";
    font-weight: 400;
}

/* ===========================================
   SEO: Classe sr-only para acessibilidade
   Esconde visualmente mas mantm para SEO/leitores de tela
   =========================================== */

.sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border: 0;
}

/* ===========================================
   SEO: Estilos para o Hero com SVG + texto oculto
   =========================================== */

.hero__text-content {
    display: flex;
    flex-direction: column;
    position: relative;
}

.hero__svg-image {
    display: block;
    max-width: 100%;
    height: auto;
}

@media (max-width: 768px) {
    .hero__svg-image {
        max-width: 280px;
        margin: 0 auto;
    }
}

{% endraw %}
/* =========================================
   TYPOGRAPHY & PAGE STYLES (REQUESTED UPDATES)
   ========================================= */

/* 1. Compact Text for Institutional Pages (Sobre, Comunidade, etc) */
.pg-page__content {
    font-family: 'Familjen Grotesk', sans-serif;
    color: #000;
}

.pg-page__content p,
.pg-page__content li,
.pg-page__content span {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px; /* Standard readable size */
    line-height: 1.4; /* More compact line height */
    margin-bottom: 12px; /* Reduced margin between paragraphs */
    letter-spacing: 0.02em;
}

.pg-page__content h2,
.pg-page__content h3 {
    font-family: 'Familjen Grotesk', sans-serif;
    text-transform: uppercase;
    font-weight: 700;
    margin-top: 30px;
    margin-bottom: 15px;
    font-size: 18px;
}

/* 2. Standardized Page Titles (Search, Category, Institutional) */
.pg-page__title,
.pg-search-page__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    text-transform: uppercase;
    font-size: 30px; /* Standardized size */
    text-align: center;
    margin-bottom: 30px;
    letter-spacing: 0.05em;
}

/* Ensure Search/Category headers match */
.pg-search-page__header {
    text-align: center;
    margin-bottom: 40px;
}

.pg-search-page__term {
    font-size: 14px;
    color: #666;
    margin-top: -20px;
}

/* [REMOVED Story 8.2 ETAPA 2] Filter & Sort CSS moved to style-async.scss.tpl */

/* PROBLEMA 1: MOBILE HEADER - LUPA NA ESQUERDA & CONES REDUZIDOS */
@media (max-width: 767px) {
    /* 1. Container Header */
    .pg-header__row,
    .pg-header__container {
        padding-left: 10px;
        padding-right: 10px;
        width: 100%;
        box-sizing: border-box;
        position: relative;
    }

    /* 2. cones Menores (20px) */
    .pg-header__icon-button svg,
    .pg-header__actions svg {
        width: 20px;
        height: 20px;
    }

    .pg-header__icon-button,
    .pg-header__actions > a,
    .pg-header__actions > div {
        padding: 0 5px;
    }

    /* 3. LUPA NA ESQUERDA (Position Absolute) */
    /* Seleciona o boto de busca dentro das aes e move para a esquerda */
    .pg-header__actions .js-search-open-mobile,
    .pg-header__actions a[href*="search"] {
        position: absolute;
        left: 40px; /* Logo aps o menu hambrguer (que tem ~30-40px) */
        top: 50%;
        transform: translateY(-50%);
        margin: 0;
        z-index: 15;
    }

    /* 4. cones da Direita (Carrinho/Conta) - Sem a lupa */
    .pg-header__actions {
        margin-right: 0;
        gap: 2px;
        display: flex;
        align-items: center;
        justify-content: flex-end;
    }

    /* 5. Logo Centralizada */
    .pg-header__logo {
        margin: 0 auto;
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        z-index: 10;
    }

    /* 6. BUSCA EXPANDINDO DA ESQUERDA AT A LOGO */
    .search-container.search-open {
        position: absolute;
        top: 0;
        left: 40px; /* Comea onde est a lupa */
        height: 100%;
        /* Calcula largura para parar antes da logo (50% - margem) */
        width: calc(50% - 50px);
        background: #fff;
        z-index: 20;
        display: flex;
        align-items: center;
        padding: 0 5px;
    }

    /* Input da Busca */
    .search-container.search-open input {
        width: 100%;
        height: 30px; /* Mais compacto */
        border: none;
        border-bottom: 1px solid #000;
        background: transparent;
        font-family: 'Familjen Grotesk', sans-serif;
        font-size: 14px;
        padding: 0;
        outline: none;
        box-shadow: none;
    }

    /* Garante que o boto de busca (lupa) continue visvel/clicvel */
    .search-container.search-open .pg-header__search-btn {
        display: none; /* Esconde cone duplicado dentro do container se houver */
    }
}

/* ============================================
   PRODUCT GALLERY MODAL - Hidden by default
   Shows only when aria-hidden="false"
   ============================================ */

/* Esconde o modal de galeria por padro */
#pg-modal-gallery[aria-hidden="true"],
#pg-modal-gallery[aria-hidden="true"] .pg-modal-container {
    display: none;
    visibility: hidden;
    opacity: 0;
}

/* Mostra o modal quando ativado via JavaScript */
#pg-modal-gallery[aria-hidden="false"] {
    display: flex;
    visibility: visible;
    opacity: 1;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.9);
    z-index: 1100;
    align-items: center;
    justify-content: center;
}

#pg-modal-gallery[aria-hidden="false"] .pg-modal-container {
    display: flex;
    visibility: visible;
    opacity: 1;
}

/* PATAGANG v1.5.151: Modal gallery improvements */
/* Hide sidebar when modal opens - prevent layout impact */
#pg-modal-gallery[aria-hidden="false"] .pg-modal-sidebar {
    display: none !important;
    visibility: hidden !important;
}

#pg-modal-gallery[aria-hidden="false"] .pg-modal-container {
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    width: 100%;
    height: 100%;
}

#pg-modal-gallery[aria-hidden="false"] .pg-modal-main {
    width: 100%;
    max-width: 100%;
    height: 100%;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    position: relative;
}

/* Responsive image sizing - fit to viewport */
#pg-modal-gallery[aria-hidden="false"] .pg-modal-main-img {
    max-width: 90vw !important;
    max-height: 90vh !important;
    width: auto !important;
    height: auto !important;
    object-fit: contain !important;
}

/* Navigation arrows - ensure full functionality */
#pg-modal-gallery[aria-hidden="false"] .pg-modal-nav {
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    position: absolute !important;
    width: 44px !important;
    height: 44px !important;
    background-color: rgba(0, 0, 0, 0.5) !important;
    border: none !important;
    border-radius: 50% !important;
    color: white !important;
    cursor: pointer !important;
    z-index: 1010 !important;
    transition: background-color 0.2s ease !important;
}

#pg-modal-gallery[aria-hidden="false"] .pg-modal-nav:hover {
    background-color: rgba(0, 0, 0, 0.8) !important;
}

#pg-modal-gallery[aria-hidden="false"] .pg-modal-nav--prev {
    left: 20px !important;
}

#pg-modal-gallery[aria-hidden="false"] .pg-modal-nav--next {
    right: 20px !important;
}

#pg-modal-gallery[aria-hidden="false"] .pg-modal-nav svg {
    width: 24px !important;
    height: 24px !important;
    stroke: white !important;
}

/* [REMOVED Story 8.2 ETAPA 1] Gallery Modal CSS moved to style-async.scss.tpl */

/* PATAGANG vX.X.X: Restore missing modal CSS (Story 10.2)
   Close button, backdrop, counter elementos que faltavam */

/* Boto Fechar (X) */
.pg-modal-gallery .pg-modal-close {
    position: absolute;
    top: 20px;
    right: 20px;
    z-index: 10;
    background: none;
    border: none;
    cursor: pointer;
    padding: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 4px;
    transition: background 0.2s ease, opacity 0.2s ease;
    opacity: 0.7;
}

.pg-modal-gallery .pg-modal-close:hover {
    opacity: 1;
    background: rgba(255, 255, 255, 0.1);
}

.pg-modal-gallery .pg-modal-close svg {
    width: 24px;
    height: 24px;
    stroke: white;
    stroke-width: 2;
}

/* Backdrop - Overlay para fechar ao clicar fora */
.pg-modal-gallery .pg-modal-backdrop {
    position: absolute;
    inset: 0;
    z-index: 0;
    cursor: pointer;
    background: rgba(0, 0, 0, 0.8);
}

/* Contador de Imagens */
.pg-modal-gallery .pg-modal-counter {
    position: absolute;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    z-index: 10;
    background: rgba(0, 0, 0, 0.6);
    color: white;
    padding: 8px 16px;
    border-radius: 4px;
    font-size: 14px;
    font-weight: 500;
    white-space: nowrap;
}


/* ============================================
   FOUC FIX  COMPLETE SOLUTION [Story 10.5]
   Grid de Produtos + Todas as Variaes Responsivas
   Movido COMPLETO de style-async.scss.tpl para evitar layout shift
   Inclui: Base + Media Queries (1200px, 992px, 768px)
   ============================================ */
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
    /* comment removed */
    flex: 0 0 calc(25% - 24px); /* 4 colunas com gap */
    max-width: calc(25% - 24px);
    min-width: 280px; /* comment removed */
    text-align: center; /* CENTRALIZA textos */
    /* comment removed */
    display: flex;
    flex-direction: column;
    overflow: hidden;
}
/* comment removed */
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
/* comment removed */
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
    margin-bottom: 10px;
    text-align: center;
}
/* comment removed */
.pg-product-grid .item-price-container {
    display: flex;
    align-items: center;
    justify-content: center; /* CENTRALIZA */
    gap: 12px;
    flex-wrap: wrap;
}
/* comment removed */
.pg-product-grid .item-price {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 18px;
    font-weight: 700;
    color: #000;
    letter-spacing: 0.3px;
}
/* comment removed */
.pg-product-grid .price-compare {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    color: #888;
    text-decoration: line-through;
}
/* Link do item - remove underline */
.pg-product-grid .item-link {
    text-decoration: none;
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
/* comment removed */
.pg-product-grid .item-actions {
    margin-top: auto;
    padding-top: 16px;
    text-align: center;
}
/* comment removed */
.pg-product-grid .item-actions .btn {
    width: 100%;
    min-height: 48px; /* comment removed */
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
   Texto SEJA O PRIMEIRO A CONHECER
   Estilo IMPACTANTE igual ao botão padr?o
   ============================================ */
/* comment removed */
.pg-product-grid .btn-development {
    width: 100%;
    min-height: 48px; /* comment removed */
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
    /* comment removed */
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
}
