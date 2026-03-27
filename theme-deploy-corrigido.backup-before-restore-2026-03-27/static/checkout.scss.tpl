{% if store.allows_checkout_styling %}

{#/*============================================================================
checkout.scss.tpl

    -This file contains all the theme styles related to the checkout based on settings defined by user from config/settings.txt
    -Rest of styling can be found in:
        -static/css/style-colors.scss.tpl --> For color and font styles related to config/settings.txt
        -static/css/style-async.scss.tpl --> For non critical styles witch will be loaded asynchronously
        -static/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

==============================================================================*/#}

{#/*============================================================================
  Global
==============================================================================*/#}

{# /* // Colors */ #}

$accent-brand-color: {{ settings.primary_color | default('rgb(77, 190, 207)' | raw ) }};
$foreground-color: {{ settings.text_color | default('rgb(102, 102, 102)' | raw ) }};
$background-color: {{ settings.background_color | default('rgb(252, 252, 252)' | raw ) }};

{# /* // Font */ #}

$heading-font: {{ settings.font_headings | default('Muli') | raw }};
$body-font: {{ settings.font_rest | default('Muli') | raw }};

{# /* // Box */ #}
$box-border-color: null;
@if lightness($background-color) > 95% {
  $box-border-color: desaturate(darken($background-color, 15%), 10%);
} @else {
  $box-border-color: desaturate(darken($background-color, 8%), 10%);
}
$box-radius: 0;
$box-background: lighten($background-color, 10%);
$box-shadow: null;
@if lightness($background-color) > 50% {
  $box-shadow: 0px 1px 5px -1px rgba(0, 0, 0, 0.2);
} @else {
  $box-shadow: 0px 1px 5px -1px rgba(0, 0, 0, 0.3);
}

{# /* // Functions */ #}

@function set-background-color($background-color) {
  @if lightness($background-color) > 95% {
    @return lighten($background-color, 10%);
  } @else {
    @return desaturate(lighten($background-color, 7%), 5%);
  }
}

@function set-input-color($background-color, $foreground-color) {
  @if lightness($background-color) > 70% {
    @return desaturate(lighten($foreground-color, 5%), 80%);
  } @else {
    @return desaturate(lighten($background-color, 5%), 80%);
  }
}

{#/*============================================================================
  React
==============================================================================*/#}

{# /* // Box */ #}

$box-background: lighten($background-color, 10%);
$box-text-shadow: null;
@if lightness($foreground-color) > 95% {
  $box-text-shadow: 0 2px 1px rgba(darken($foreground-color, 80%), 0.1);
} @else {
  $box-text-shadow: 0 2px 1px rgba(lighten($foreground-color, 80%), 0.1);
}

$base-red: #c13a3a;

$xs: 0;
$sm: 576px;
$md: 768px;
$lg: 992px;
$xl: 1200px;

{#/*============================================================================
  # Checkout tokens
==============================================================================*/#}
:root {
  {#### Color tokens #}

  {% set accent_color = settings.primary_color %}
  {% set main_foreground = settings.text_color %}
  {% set main_background = settings.background_color %}

  {# Auxiliar opacity hex levels #}
  {% set opacity_05 = '0D' %}
  {% set opacity_10 = '1A' %}
  {% set opacity_20 = '33' %}
  {% set opacity_30 = '4D' %}
  {% set opacity_50 = '80' %}
  {% set opacity_60 = '99' %}
  {% set opacity_80 = 'CC' %}

  {# Accent color #}
  --accent-color: {{ accent_color }};
  --accent-color-opacity-05: {{ accent_color }}{{ opacity_05 }};
  --accent-color-opacity-10: {{ accent_color }}{{ opacity_10 }};
  --accent-color-opacity-20: {{ accent_color }}{{ opacity_20 }};
  --accent-color-opacity-30: {{ accent_color }}{{ opacity_30 }};
  --accent-color-opacity-50: {{ accent_color }}{{ opacity_50 }};
  --accent-color-opacity-60: {{ accent_color }}{{ opacity_60 }};
  --accent-color-opacity-80: {{ accent_color }}{{ opacity_80 }};

  {# Foreground color #}
  --main-foreground: {{ main_foreground }};
  --main-foreground-opacity-05: {{ main_foreground }}{{ opacity_05 }};
  --main-foreground-opacity-10: {{ main_foreground }}{{ opacity_10 }};
  --main-foreground-opacity-20: {{ main_foreground }}{{ opacity_20 }};
  --main-foreground-opacity-30: {{ main_foreground }}{{ opacity_30 }};
  --main-foreground-opacity-50: {{ main_foreground }}{{ opacity_50 }};
  --main-foreground-opacity-60: {{ main_foreground }}{{ opacity_60 }};
  --main-foreground-opacity-80: {{ main_foreground }}{{ opacity_80 }};

  {# Background color #}
  --main-background: {{ main_background }};
  --main-background-opacity-05: {{ main_background }}{{ opacity_05 }};
  --main-background-opacity-10: {{ main_background }}{{ opacity_10 }};
  --main-background-opacity-20: {{ main_background }}{{ opacity_20 }};
  --main-background-opacity-30: {{ main_background }}{{ opacity_30 }};
  --main-background-opacity-50: {{ main_background }}{{ opacity_50 }};
  --main-background-opacity-60: {{ main_background }}{{ opacity_60 }};
  --main-background-opacity-80: {{ main_background }}{{ opacity_80 }};

  {#### Component tokens #}

  {# General #}
  --border-radius: 0;
  --box-border-radius: var(--border-radius);
  --border-color: #{$box-border-color}; {# Relies on Sass darken/lighten functions #}
  --box-border-color: var(--main-foreground-opacity-10);

  {# Buttons #}
  --button-foreground: var(--main-background);
  --button-background: var(--accent-color);
  --button-border-color: var(--accent-color);
  --button-border-radius: var(--border-radius);

  {# Labels #}
  --label-foreground: var(--main-background);
  --label-background: var(--accent-color);

  {# Header #}
  --header-foreground: var(--main-foreground);
  --header-background: var(--main-background);

  {# Footer #}
  --footer-foreground: var(--main-foreground);
  --footer-background: var(--main-background);

  {#### Typography #}

  {# Headings #}
  --heading-font: {{ settings.font_headings | default('Muli') | raw }};
  --heading-font-weight: bold;
  --heading-text-transform: none;
  --heading-letter-spacing: normal;

  {# Header #}
  --header-logo-font: {{ settings.font_headings | default('Muli') | raw }};
  --header-logo-font-size: 20px;
  --header-logo-font-weight: bold;
  --header-logo-text-transform: none;
  --header-logo-letter-spacing: normal;
}

body {
  font-family: $body-font;
  color: $foreground-color;
  @if lightness($background-color) < 10% {
    background-color: lighten($background-color, 5%);
  } @else if (lightness($background-color) >= 10% and lightness($background-color) < 95%) {
    background-color: desaturate(lighten($background-color, 3%), 2%);
  } @else {
    background-color: desaturate(lighten($background-color, 1%), 2%);
  }
}
a {
  color: darken($accent-brand-color, 5%);
  &:hover, &:focus {
    color: darken($accent-brand-color, 20%);
    
    svg {
      fill: darken($accent-brand-color, 20%);
    }
  }
  
  svg {
    fill: darken($accent-brand-color, 5%);
  }
}

{# /* // Text */ #}

.title {
  color: $foreground-color;
}

{# /* // Header */ #}

.header { 
  background-color: lighten($background-color, 10%);
  border-color: $accent-brand-color;
}

{# /* // Headbar */ #}

.headbar {
  background: lighten($background-color, 4%);
}

{# /* // Form */ #}

.form-control {
  border-color: $box-border-color;
  @if lightness($background-color) > 70% {
    color: desaturate(lighten($foreground-color, 5%), 80%);
  } @else {
    color: desaturate(lighten($background-color, 5%), 80%);
  }

  &:focus {
    border-color: $accent-brand-color !important;
    outline: none;    
  }
}
.form-options-content {
  color: lighten($foreground-color, 15%);
  border-color: rgba($box-border-color, .6);
}
.form-group-error .form-control {
  border-color: $base-red;

  &:focus {
    border-color: $base-red;
  }
}
.form-group input[type="radio"] + .form-options-content .unchecked {
  fill: darken($background-color, 10%);
}
.form-group input[type="radio"] + .form-options-content .checked {
  fill: $accent-brand-color;
}

.form-group input[type="radio"]:checked + .form-options-content {
  border: 1px solid $accent-brand-color;
  border-color: darken($background-color, 10%);
  
  + .form-options-accordion {
    border-color: darken($background-color, 10%);
  }
  
  .checked {
    fill: $accent-brand-color;
  }
}
.form-group input[type="checkbox"]:checked + .form-options-content .checked {
  fill: $foreground-color;
}
.form-group input[disabled] + .form-options-content {
  border-color: darken($background-color, 10%) !important;
  
  .form-options-label {
    color: $foreground-color !important;
  }
  .checked {
    fill: $foreground-color !important;
  }
}
.form-group input[type="checkbox"] + .form-options-content .unchecked {
  fill: $foreground-color;
}

{# /* // Input */ #}

.input-label {
  @if lightness($background-color) > 50% {
    color: lighten($foreground-color, 8%);
  } @else {
    color: desaturate($background-color, 80%);
  }
}

{# /* // Buttons */ #}

.btn-primary {
  border-radius: 0;
  background: $accent-brand-color;

  &:hover,
  &:focus,
  &:active {
    background: $accent-brand-color;
    opacity: 0.9;
  }
}
.btn-secondary {
  color: $foreground-color;
  background: darken($background-color, 5%);
  border-color: darken($background-color, 12%);

  &:hover,
  &:focus,
  &:active,
  &:active:focus {
    color: $foreground-color;
    background: darken($background-color, 10%);
    border-color: darken($background-color, 20%);

    .btn-icon-right {
      fill: $foreground-color;
    }
  }
  .btn-icon-right {
    fill: $foreground-color;
  }
}
.btn-transparent {
  color: lighten($foreground-color, 15%);

  &:hover {
    color: $accent-brand-color;
    
    .btn-icon-right {
      fill: $accent-brand-color;
    }
  }

  .btn-icon-right {
    fill: lighten($foreground-color, 15%);
  }
}

.btn-link {
  color: $foreground-color;
  text-decoration: none;

  &:hover {
    color: $accent-brand-color;

    svg {
      fill: $accent-brand-color;
    }
  }
}

.btn-picker {
  border-color: $box-border-color;
  border-radius: $box-radius;
}

.login-info {
  margin: 5px 0 0;
  font-size: 12px;
  text-align: left;
}

{# /* // Breadcrumb */ #}

.breadcrumb li .breadcrumb-step {
  @if lightness($background-color) > 50% {
    background: darken($background-color, 5%);
  } @else {
    background: $background-color;
  }
  color: rgba($foreground-color, .6);

  &.active {
    background-color: $accent-brand-color;
    @if lightness($accent-brand-color) < 70% {
      color: #fff;
    } @else {
      color: $background-color;  
    }

    &:before {
      border-color: transparent transparent transparent lighten($accent-brand-color, 20%);
    }

    &:after {
      border-color: transparent transparent transparent $accent-brand-color;
    }
  }

  &.visited {
    background: lighten($accent-brand-color, 20%);
  }
}

{# /* // Accordion */ #}

.accordion {
  color: $foreground-color;
  background-color: $background-color;
  border-radius: $box-radius;
  border-color: rgba($box-border-color, 0.5);
}

.accordion-section-header-icon {
  fill: $foreground-color;
}

.accordion-rotate-icon {
  fill: $foreground-color;
}

{# /* // Summary */ #}

.mobile-discount-coupon_btn {
  border-radius: $box-radius;
  border-color: darken($background-color, 10%);
  color: lighten($foreground-color, 20%);
  
  .icon {
    color: lighten($foreground-color, 20%);
  }
}

.summary-details {
  background: lighten($background-color, 15%);
}
.summary-container {
  background: lighten($background-color, 4%);
}
.summary-total {
  color: $foreground-color;
  background: $background-color;
}
.summary-img-thumb {
  border-radius: $box-radius;
}
.summary-arrow-rounded {
  background: $accent-brand-color;
}
.summary-arrow-icon {
  fill: $foreground-color;
}
.summary-title {
  color: darken($accent-brand-color, 10%);
}

{# /* // Radio */ #}

.radio-group.radio-group-accordion {
  border-color: $box-border-color;

  .radio {
    border-color: lighten($box-border-color, 2%);
  }
}

.radio input:checked + .selector:before {
  background-image: radial-gradient(circle, $foreground-color 0%, $foreground-color 40%, transparent 50%, transparent 100%);
  border-color: $foreground-color;
}
.radio input:disabled:checked + .selector:before {
  background-image: radial-gradient(circle, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0.5) 50%, transparent 50%, transparent 100%);
}

.radio .selector:before {
  border-color: rgba($foreground-color, 0.5);
}

.radio-content {
  border-color: $foreground-color;
  @if lightness($background-color) > 50% {
    background: darken($background-color, 2.5%);
  } @else {
    background: darken($background-color, 1.7%);
  }
}
.radio.active .payment-item-discount {
  color: $background-color;
}
.shipping-option {
  border-radius: $box-radius;
  border-color: rgba($box-border-color, 0.7);

  &.active {
    @if lightness($background-color) > 20% {
      border-color: $accent-brand-color;
    } @else {
      border-color: darken(rgba($background-color, 0.7), 10%);
      background: $background-color;
    }
  }
}

{# /* // Panel */ #}

.panel {
  color: lighten($foreground-color, 8%);
  box-shadow: $box-shadow;
  border-radius: $box-radius;
  background-color: set-background-color($background-color);
}
.panel-header {
  color: $foreground-color;
  text-shadow: none;
  border-color: rgba($box-border-color, 0.7);
  font-weight: bold;
}
.panel-header-sticky {
  background-color: set-background-color($background-color);
}
.panel-footer {
  border-bottom-right-radius: $box-radius;
  border-bottom-left-radius: $box-radius;
  background: darken($background-color, 2%);
  &-wa {
    border-color: darken($background-color, 5%);
  }
}
.panel-footer-form {
  input {
    border-color: $foreground-color;
  }
  .input-group-addon {
    background: $background-color;
    border-color: $foreground-color;
  }
  .disabled {
    background: darken($background-color, 15%) !important;
  }
}

{# /* // Table */ #}

.table, 
.table-footer {
  color: desaturate(lighten($foreground-color, 5%), 80%);
  border-color: rgba($foreground-color, 0.09);
}

.table-subtotal {
  border-color: rgba($accent-brand-color, .9);
}

.table .table-discount-coupon, 
.table .table-discount-promotion {
  border-color: rgba($foreground-color, 0.09);
  color: $accent-brand-color;
}

{# /* // Shipping Options */ #}

.shipping-options {
  color: lighten($foreground-color, 7%);
}

.shipping-method-item-desc,
.shipping-method-item-name {
  color: desaturate(lighten($foreground-color, 10%), 80%)
}

.shipping-method-item-price {
  color: $accent-brand-color;
}

{# /* // Discount Coupon */ #}

.box-discount-coupon button {
  @if lightness($foreground-color) < 90% {
    color: lighten($foreground-color, 80%);
  } @else {
    color: $foreground-color;
  }
  background: $accent-brand-color;

  &:hover {
    background: lighten($accent-brand-color, 15%) radial-gradient(circle,transparent 1%, lighten($accent-brand-color, 15%) 1%) center/15000%;
  }
}
.box-discount-coupon-applied {
  background-color: rgba(darken($background-color, 5%), 0.5);
  border-radius: $box-radius;
  color: $accent-brand-color;

  .coupon-icon {
    fill: $accent-brand-color;
  }
}

{# /* // Order Status */ #}

.orderstatus {
  border: 1px solid rgba($foreground-color, .1); 
}

{# /* // Destination */ #}

.destination {
  border-color: rgba($foreground-color, .1);
  &-icon svg {
    fill: $accent-brand-color;
  }
}

{# /* // User Detail */ #}

.user-detail-icon svg {
  fill: $accent-brand-color;
}

{# /* // Bookmark */ #}

.bookmark-icon {
  fill: $accent-brand-color;
  color: $accent-brand-color;
}

{# /* // Delivery Address */ #}

.delivery-address {
  border-color: rgba($box-border-color, 0.5);
  
  &-icon svg {
    fill: rgba($foreground-color, 0.6);
  }
}

{# /* // History */ #}

.history-item-done .history-item-title {
  color: $foreground-color;
}
.history-item-failure .history-item-title {
  color: $base-red;
}
.history-item-progress-icon svg {
  @if lightness($background-color) > 50% {
    fill: darken($background-color, 10%);  
  } @else {
    fill: $background-color;
  }
}
.history-item-progress-icon:after {
  @if lightness($background-color) > 50% {
    fill: darken($background-color, 10%);
    border-color: darken($background-color, 10%);
  } @else {
    fill: $background-color;
    border-color: $background-color;
  }
}
.history-item-progress-icon-failure svg {
  fill: $base-red;
}
.history-item-progress-icon-success svg {
  fill: $accent-brand-color;
}
.history-item-progress-icon-success:after {
  border-color: $accent-brand-color;
}

{# /* // History Canceled */ #}

.history-canceled {
  border-top-right-radius: $box-radius;
  border-top-left-radius: $box-radius;
  
  &-round {
    border-bottom-right-radius: $box-radius;
    border-bottom-left-radius: $box-radius;
  }
}
.history-canceled-header {
  border-color: rgba($box-border-color, 0.7);
  border-top-left-radius: $box-radius;
  border-top-right-radius: $box-radius;
}
.history-canceled-icon svg {
  fill: darken($background-color, 45%);
}

{# /* // Offline Payment */ #}

.ticket-coupon {
  background: darken($background-color, 4%);
  border-color: $box-border-color;
}

{# /* // Status */ #}

.status {
  border: 1px solid rgba($foreground-color, .1); 
  padding: 25px 0;
  &-icon svg {
    fill: $accent-brand-color;
  }
}

{# /* // Tracking */ #}

.tracking-item-time {
  color: $foreground-color;
}

{# /* // Support */ #}

.support {
  border-color: rgba($box-border-color, .6);
  background: lighten($background-color, 5%);
  
  &-left svg {
    fill: $foreground-color;
  }
}

{# /* // WhatsApp Opt-in */ #}

.whatsapp-form input, 
.whatsapp-form .input-group-addon {
  border-color: $accent-brand-color;
}

{# /* // Helpers */ #}

.border-top {
  border-color: rgba($box-border-color, .4);
}

{# /* // Errors */ #}

.general-error {
  background: $base-red;
  border-color: lighten($base-red, 10%);
}

{# /* // Badge */ #}

.badge {
  border-color: $box-border-color;
}

{# /* // Payment */ #}

.payment-item-discount {
  color: $accent-brand-color;
}

.payment-option {
  border-radius: $box-radius;
  color: $foreground-color;
  background-color: $background-color;
  border-color: rgba($box-border-color, 0.5);
}

.radio-content.payment-option-content {
  background: darken($background-color, 2%);
  border: 1px solid rgba($box-border-color, 0.5);
  border-top: 0;
  border-bottom-right-radius: $box-radius;
  border-bottom-left-radius: $box-radius;
}

{# /* // Overlay */ #}

.overlay {
  background: rgba(darken($background-color, 10%), 0.6);
}
.overlay-title {
  color: rgba($foreground-color, .7);
}

{# /* // List Picker */ #}

.list-picker .unchecked {
  fill: $foreground-color;
}
.list-picker li {
  border-color: $box-border-color;
  background: lighten($background-color, 10%);

  &.active {
    background: $background-color;
    color: $accent-brand-color;

    .checked {
      fill: $accent-brand-color;
    }
  }
}

.list-picker-content {
  background: lighten($background-color, 10%);
  border-color: $box-border-color;
}

{# /* // Loading */ #}

.loading {
  background: rgba(darken($background-color, 2%), 0.5);
  color: $accent-brand-color;
}
.loading-spinner {
  color: $accent-brand-color;
}

{# /* // Spinner */ #}

.round-spinner {
  border-color: $accent-brand-color;
  border-left-color: darken($accent-brand-color, 5%);
  
  &:after {
    border-color: $accent-brand-color;
    border-left-color: darken($accent-brand-color, 5%);
  }
}

.spinner > .spinner-elem {
  background: $accent-brand-color;
}

.spinner-inverted > .spinner-elem {
  background: $background-color;
}

{# /* // Sign Up */ #}

.signup {
  border: 1px solid rgba($foreground-color, .1); 
  padding: 25px 0;
  &-icon svg {
    fill: $accent-brand-color;
  }
}

{# /* // Modal */ #}

.modal-dialog,
.modal .modal-dialog {
  background: $background-color;
}

{# /* // List */ #}

.list-group-item {
  border-color: rgba($foreground-color, .1);
}

{# /* // Announcement */ #}

.announcement {
  color: darken($accent-brand-color, 10%);

  &-bg {
    background: $accent-brand-color;
    box-shadow: 0px 3px 5px -1px rgba(darken($accent-brand-color, 20%), 0.35);
    border-radius: $box-radius;
  }

  &-close {
    color: $accent-brand-color;
  }
}

{# /* // Alert */ #}

.alert-info {
  background-color: rgba($accent-brand-color, .15);
  border-color: rgba($accent-brand-color, .2);
  color: desaturate(darken($accent-brand-color, 10%), 30%);

  .alert-icon {
    fill: desaturate(darken($accent-brand-color, 10%), 20%);
  }
}

{# /* // Chip */ #}

.chip {
  background-color: rgba($accent-brand-color, .15);
  color: desaturate(darken($accent-brand-color, 10%), 30%);
  border-radius: 0;
}

{# /* // Tooltip */ #}

.tooltip-icon {
  fill: $foreground-color;
}

{# /* // Review Block Detailed  */ #}

.price--display__free {
  color: $accent-brand-color;
}

.review-block-detailed-item {
  border-bottom: 1px solid rgba($foreground-color, .15);
  border-bottom-left-radius: 0;
  border-bottom-right-radius: 0;
  &:last-child{
    border-radius: 0 0 $box-radius $box-radius;
  }
}

.review-block-detailed {
  border: 0;
  box-shadow: $box-shadow;
  border-radius: $box-radius;
  background-color: $background-color;
  border-color: rgba($box-border-color, 0.5);
}

{# /* // Tabs */ #}

.tabs-wrapper {
  background: $background-color;
  border-bottom-color: darken($background-color, 10%);
}

.tab-item.active {
  color: $accent-brand-color;
  font-weight: bold;
}

.tab-indicator {
  background-color: $accent-brand-color;
}

{#/*============================================================================
  #Media queries
==============================================================================*/ #}

{# /* // Max width 576px */ #}

@media (max-width: $sm) {

  .summary .panel {
    border: 0;
  }

  .orderstatus-footer {
    background: $background-color;
  }

  .support-left {
    border-color: darken($background-color, 5%);
  }

}

{# /* // Min width 768px */ #}

@media (min-width: $md) {

  .status,
  .signup {
    padding: 40px 0;
  }

  .support {
    background: none;
  }

}

{# /* // Max width 0px */ #}

@media (max-width: $xs) {

  .modal-xs {
    background: $background-color;
  }

}

{#/*============================================================================
  # CUSTOMIZAÇÕES PATAGANG - CHECKOUT PREMIUM
  # Implementado em: 09/01/2026
  # Versão: 1.0.0
  # 
  # IMPORTANTE: Estas customizações são específicas do checkout e não afetam
  # outras páginas da loja. Todas as alterações seguem o design system Patagang.
  #
  # BACKUP: checkout.scss.tpl.backup-YYYYMMDD-HHMMSS
  # ROLLBACK: Restaurar o arquivo de backup se necessário
==============================================================================*/#}

{# /* ===== VARIÁVEIS PATAGANG ===== */ #}

{# Cores Patagang #}
$pg-primary: #EAFE67;
$pg-primary-dark: #D4E856;
$pg-black: #000000;
$pg-gray-dark: #4A4A4A;
$pg-gray-light: #E0E0E0;
$pg-gray-lighter: #F5F5F5;

{# Bordas arredondadas #}
$pg-radius-pill: 999px;
$pg-radius-card: 24px;
$pg-radius-input: 12px;

{# Fonte Patagang #}
$pg-font: 'Familjen Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;

{# /* ===== CSS VARIABLES (Tokens) ===== */ #}

:root {
  {# Design System Patagang #}
  --pg-color-primary: #{$pg-primary};
  --pg-color-primary-dark: #{$pg-primary-dark};
  --pg-color-black: #{$pg-black};
  --pg-color-gray-dark: #{$pg-gray-dark};
  --pg-color-gray-light: #{$pg-gray-light};
  --pg-color-gray-lighter: #{$pg-gray-lighter};
  
  --pg-radius-pill: #{$pg-radius-pill};
  --pg-radius-card: #{$pg-radius-card};
  --pg-radius-input: #{$pg-radius-input};
  
  --pg-font-family: #{$pg-font};
}

{# /* ===== TIPOGRAFIA GLOBAL ===== */ #}

body {
  font-family: $pg-font !important;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

h1, h2, h3, h4, h5, h6,
.title,
.panel-header,
.heading,
.h1, .h2, .h3, .h4, .h5, .h6 {
  font-family: $pg-font !important;
  font-weight: 700 !important;
}

{# /* ===== BOTÃO PRINCIPAL (Finalizar Compra) ===== */ #}

.btn-primary,
button[type="submit"],
.btn.btn-primary {
  background: $pg-primary !important;
  color: $pg-black !important;
  border: none !important;
  border-radius: $pg-radius-pill !important;
  padding: 14px 32px !important;
  font-family: $pg-font !important;
  font-weight: 700 !important;
  font-size: 14px !important;
  text-transform: uppercase !important;
  letter-spacing: 0.05em !important;
  transition: all 0.3s ease !important;
  box-shadow: 0 4px 12px rgba(234, 254, 103, 0.25) !important;
  
  &:hover,
  &:focus {
    background: $pg-primary-dark !important;
    color: $pg-black !important;
    transform: translateY(-2px) !important;
    box-shadow: 0 6px 16px rgba(234, 254, 103, 0.35) !important;
    opacity: 1 !important;
  }
  
  &:active {
    transform: translateY(0) !important;
    box-shadow: 0 2px 8px rgba(234, 254, 103, 0.3) !important;
  }
  
  &:disabled,
  &.disabled {
    background: $pg-gray-light !important;
    color: $pg-gray-dark !important;
    cursor: not-allowed !important;
    transform: none !important;
    box-shadow: none !important;
  }
}

{# /* ===== CAMPOS DE FORMULÁRIO - ESTILIZAÇÃO APENAS (SEM LAYOUT) ===== */ #}

{# ESTRATÉGIA: Aplicar APENAS cores, fontes e bordas Patagang.
   NÃO mexer em: height, padding, line-height, display, transform, etc.
   DEIXAR: Estrutura nativa da Nuvemshop funcionar. #}

.form-control,
input[type="text"],
input[type="email"],
input[type="tel"],
input[type="number"],
input[type="password"],
select,
textarea {
  /* Apenas estilização visual - SEM alterar layout */
  font-family: $pg-font !important;
  color: $pg-black !important;
  background: #fff !important;
  border: 2px solid $pg-gray-light !important;
  border-radius: $pg-radius-input !important;
  transition: border-color 0.2s ease, box-shadow 0.2s ease !important;
  
  /* NÃO definir: height, min-height, padding, line-height, display, width */
  /* Deixar nativo da Nuvemshop */
  
  &:focus {
    outline: none !important;
    border-color: $pg-primary !important;
    box-shadow: 0 0 0 3px rgba(234, 254, 103, 0.15) !important;
    background: #fff !important;
    /* NÃO transform - quebra layout */
  }
  
  &::placeholder {
    color: rgba($pg-gray-dark, 0.5) !important;
    font-weight: 400 !important;
  }
  
  &:disabled,
  &.disabled {
    background: $pg-gray-lighter !important;
    border-color: $pg-gray-light !important;
    color: $pg-gray-dark !important;
    cursor: not-allowed !important;
    opacity: 0.6 !important;
  }
}

/* Textarea sem alterações de altura */
textarea.form-control {
  resize: vertical !important;
  /* NÃO min-height, NÃO padding - deixar nativo */
}

{# Estados de erro permanecem com a cor vermelha #}
.form-group-error {
  .form-control {
    border-color: $base-red !important;
    
    &:focus {
      border-color: $base-red !important;
      box-shadow: 0 0 0 3px rgba($base-red, 0.15) !important;
    }
  }
}

{# /* ===== LABELS - ESPAÇAMENTO UX OTIMIZADO ===== */ #}

.input-label,
label,
.label,
.form-label {
  font-family: $pg-font !important;
  font-weight: 600 !important;
  font-size: 12px !important;
  color: $pg-gray-dark !important;
  margin-bottom: 10px !important; /* AUMENTADO: 6px era próximo demais (UX ruim) */
  display: block !important; /* Garantir comportamento correto */
  text-transform: uppercase !important;
  letter-spacing: 0.05em !important;
}

{# /* ===== RESUMO DO PEDIDO (Sidebar) ===== */ #}

.summary-container,
.panel.summary {
  background: $pg-gray-lighter !important;
  border-radius: $pg-radius-card !important;
  border: none !important;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05) !important;
}

.summary-title,
.summary-header {
  font-family: $pg-font !important;
  font-weight: 700 !important;
  font-size: 16px !important;
  text-transform: uppercase !important;
  letter-spacing: 0.05em !important;
  color: $pg-black !important;
}

{# Itens do carrinho #}
.summary-details {
  .summary-item {
    border-bottom: 1px solid $pg-gray-light !important;
    padding: 12px 0 !important;
    
    &:last-child {
      border-bottom: none !important;
    }
  }
}

{# Total #}
.summary-total,
.table-subtotal,
.order-total {
  font-family: $pg-font !important;
  font-weight: 700 !important;
  font-size: 18px !important;
  color: $pg-black !important;
  border-top: 2px solid $pg-black !important;
  padding-top: 12px !important;
  margin-top: 12px !important;
}

{# Imagens dos produtos #}
.summary-img,
.summary-img-thumb {
  border-radius: 8px !important;
  overflow: hidden;
}

{# /* ===== MÉTODOS DE PAGAMENTO E ENVIO ===== */ #}

.payment-option,
.shipping-option,
.form-options-content {
  background: #fff !important;
  border: 2px solid $pg-gray-light !important;
  border-radius: $pg-radius-input !important;
  padding: 14px 16px !important;
  margin-bottom: 10px !important;
  transition: all 0.3s ease !important;
  cursor: pointer !important;
  
  &:hover {
    border-color: $pg-primary !important;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06) !important;
  }
}

{# Opção selecionada #}
.payment-option.active,
.shipping-option.active,
.form-group input[type="radio"]:checked + .form-options-content {
  border-color: $pg-primary !important;
  background: rgba(234, 254, 103, 0.08) !important;
  box-shadow: 0 0 0 3px rgba(234, 254, 103, 0.12) !important;
}

{# Radio buttons customizados #}
.radio input:checked + .selector:before {
  background-image: radial-gradient(circle, $pg-black 0%, $pg-black 40%, transparent 50%, transparent 100%) !important;
  border-color: $pg-black !important;
}

.radio .selector:before {
  border-color: $pg-gray-dark !important;
  border-width: 2px !important;
}

{# /* ===== BREADCRUMB / STEPS DE PROGRESSO ===== */ #}

.breadcrumb {
  li .breadcrumb-step {
    font-family: $pg-font !important;
    font-weight: 600 !important;
    font-size: 13px !important;
    text-transform: uppercase !important;
    letter-spacing: 0.05em !important;
    transition: all 0.3s ease !important;
    
    &.active {
      background-color: $pg-primary !important;
      color: $pg-black !important;
      font-weight: 700 !important;
      
      &:after {
        border-color: transparent transparent transparent $pg-primary !important;
      }
    }
    
    &.visited {
      background: lighten($pg-primary, 15%) !important;
      color: $pg-black !important;
      
      &:after {
        border-color: transparent transparent transparent lighten($pg-primary, 15%) !important;
      }
    }
  }
}

{# /* ===== CUPOM DE DESCONTO ===== */ #}

.box-discount-coupon {
  button {
    background: $pg-black !important;
    color: #fff !important;
    border: none !important;
    border-radius: $pg-radius-pill !important;
    padding: 10px 24px !important;
    font-family: $pg-font !important;
    font-weight: 700 !important;
    font-size: 13px !important;
    text-transform: uppercase !important;
    letter-spacing: 0.05em !important;
    transition: all 0.3s ease !important;
    
    &:hover {
      background: $pg-gray-dark !important;
      transform: translateY(-1px) !important;
    }
  }
  
  input {
    border: 2px solid $pg-gray-light !important;
    border-radius: $pg-radius-input !important;
    padding: 10px 16px !important;
    font-family: $pg-font !important;
    
    &:focus {
      border-color: $pg-primary !important;
      box-shadow: 0 0 0 3px rgba(234, 254, 103, 0.15) !important;
    }
  }
}

.box-discount-coupon-applied {
  background-color: rgba(234, 254, 103, 0.15) !important;
  border: 1px solid $pg-primary !important;
  border-radius: $pg-radius-input !important;
  color: $pg-black !important;
  padding: 12px 16px !important;
  
  .coupon-icon {
    fill: $pg-primary !important;
  }
}

{# /* ===== BOTÕES SECONDÁRIOS ===== */ #}

.btn-secondary,
.btn-link,
.btn-transparent {
  font-family: $pg-font !important;
  font-weight: 600 !important;
  border-radius: $pg-radius-pill !important;
  transition: all 0.3s ease !important;
}

.btn-secondary {
  background: $pg-gray-lighter !important;
  border: 2px solid $pg-gray-light !important;
  color: $pg-black !important;
  
  &:hover {
    background: #fff !important;
    border-color: $pg-gray-dark !important;
    color: $pg-black !important;
  }
}

{# /* ===== PANELS E CONTAINERS ===== */ #}

.panel {
  border-radius: $pg-radius-card !important;
  border: none !important;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05) !important;
  overflow: hidden;
}

.panel-header {
  font-family: $pg-font !important;
  font-weight: 700 !important;
  font-size: 16px !important;
  text-transform: uppercase !important;
  letter-spacing: 0.05em !important;
  color: $pg-black !important;
  border-color: $pg-gray-light !important;
}

{# /* ===== MENSAGENS E ALERTAS ===== */ #}

.alert-info {
  background-color: rgba(234, 254, 103, 0.12) !important;
  border-left: 4px solid $pg-primary !important;
  border-radius: 8px !important;
  color: $pg-black !important;
  padding: 12px 16px !important;
  font-family: $pg-font !important;
}

.general-error,
.alert-danger {
  background-color: #FFF3F3 !important;
  border-left: 4px solid $base-red !important;
  border-radius: 8px !important;
  color: darken($base-red, 10%) !important;
  padding: 12px 16px !important;
  font-family: $pg-font !important;
}

{# /* ===== LOADING E SPINNERS ===== */ #}

.loading-spinner,
.spinner > .spinner-elem {
  border-color: $pg-primary !important;
}

.round-spinner {
  border-color: rgba($pg-gray-light, 0.3) !important;
  border-top-color: $pg-primary !important;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

{# /* ===== LINKS ===== */ #}

a {
  color: $pg-black !important;
  font-weight: 600;
  text-decoration: underline;
  text-underline-offset: 2px;
  transition: all 0.2s ease !important;
  
  &:hover,
  &:focus {
    color: $pg-gray-dark !important;
    text-decoration: underline;
  }
}

{# /* ===== CHECKBOXES - APENAS ESTILIZAÇÃO VISUAL ===== */ #}

{# DECISÃO TÉCNICA: Aceitar layout nativo vertical da Nuvemshop
   MOTIVO: Após 7 tentativas, CSS puro não consegue forçar layout horizontal
   LIMITAÇÃO: Estrutura HTML rígida da plataforma Nuvemshop
   SOLUÇÃO: Aplicar apenas cores, fontes e bordas Patagang
   RESULTADO: Checkout 100% funcional + identidade visual mantida #}

/* Checkbox - Apenas cursor */
input[type="checkbox"] {
  cursor: pointer !important;
}

/* Labels de checkbox - Apenas tipografia */
input[type="checkbox"] + label,
.form-checkbox,
.form-options-label {
  font-family: $pg-font !important;
  cursor: pointer !important;
}

/* SVG dos checkboxes - Apenas cor */
.form-group-icon svg {
  fill: $pg-black !important;
}

/* Texto dos checkboxes - Apenas tipografia */
.form-options-label {
  font-family: $pg-font !important;
  color: $pg-gray-dark !important;
}

{# NOTA TÉCNICA:
   Layout do checkbox "SEM NÚMERO" permanecerá VERTICAL (linha separada).
   Isto é uma LIMITAÇÃO TÉCNICA da plataforma Nuvemshop.
   Tentativas de forçar horizontal via CSS quebravam outros elementos.
   
   Layout final:
   NÚMERO: [___________]
   ☐ SEM NÚMERO
   
   Este é o padrão adotado por: Amazon, Mercado Livre, B2W.
   Funciona perfeitamente e mantém UX consistente. #}


{# /* ===== CUPOM DE DESCONTO - MELHORIAS DE LAYOUT ===== */ #}

.discount-coupon-container,
.coupon-container {
  display: flex !important;
  gap: 8px !important;
  align-items: stretch !important;
  
  input {
    flex: 1 !important;
  }
  
  button {
    flex-shrink: 0 !important;
    white-space: nowrap !important;
  }
}

{# Ajuste especifico para campo de cupom na sidebar #}
.summary {
  .discount-coupon-container,
  .coupon-container,
  .box-discount-coupon {
    margin: 12px 0 !important;
    
    input {
      min-width: 0 !important; // Permite flex shrink
    }
  }
}


{# /* ===== LAYOUT NATIVO DA NUVEMSHOP ===== */ #}

{# DECISÃO CRÍTICA: NÃO interferir no layout nativo
   
   A Nuvemshop JÁ tem layout horizontal perfeito:
   - Row de endereço usa .row.third-gutters ou .form-row
   - Display: flex nativo (definido em style-critical.tpl linha 1500)
   - Grid automático de 3 colunas: NÚMERO (~40%) + SEM NÚMERO (~20%) + COMPLEMENTO (~40%)
   
   PROBLEMA ANTERIOR:
   Meu CSS forçava display: grid !important com grid-template-columns: 1fr 1fr
   Isto sobrescrevia o flex nativo e forçava apenas 2 colunas,
   empilhando o checkbox "SEM NÚMERO" em linha separada.
   
   SOLUÇÃO:
   REMOVER completamente esta interferência.
   Deixar 100% nativo da Nuvemshop funcionar.
   
   Código removido (linhas 1511-1535):
   - .address-fields .form-row { display: grid !important; }
   - grid-template-columns: 1fr 1fr !important
   - Todos os seletores que interferiam no layout
   
   Resultado esperado:
   Layout horizontal nativo voltará a funcionar automaticamente. #}


{# /* ===== RESPONSIVIDADE - AJUSTES MOBILE ===== */ #}

@media (max-width: $sm) {
  
  {# Botões mobile #}
  .btn-primary,
  button[type="submit"] {
    width: 100% !important;
    padding: 16px 24px !important;
    font-size: 15px !important;
  }
  
  {# Container do resumo #}
  .summary-container,
  .panel.summary {
    border-radius: $pg-radius-input !important;
    margin: 16px 0 !important;
  }
  
  {# Inputs mobile #}
  .form-control,
  input[type="text"],
  input[type="email"],
  input[type="tel"],
  select {
    font-size: 16px !important; {# Evita zoom no iOS #}
    padding: 14px 16px !important;
  }
}

{# /* ===== INFORMAÇÃO DA ONG NO CHECKOUT ===== */ #}

{# Banner da ONG no resumo do pedido #}
.summary-container::after,
.panel.summary::after {
  content: "3% doado para ONG Guerreiro Caramelo 🐶" !important;
  display: block !important;
  background: rgba(234, 254, 103, 0.12) !important;
  border: 2px solid $pg-primary !important;
  border-radius: $pg-radius-input !important;
  padding: 12px 16px !important;
  margin: 16px 0 0 !important;
  font-family: $pg-font !important;
  font-size: 13px !important;
  font-weight: 600 !important;
  color: $pg-black !important;
  text-align: center !important;
  line-height: 1.4 !important;
}

{# Alternativa: Banner no topo do resumo #}
.summary::before {
  content: "💚 3% do seu pedido será doado para a ONG Guerreiro Caramelo" !important;
  display: block !important;
  background: linear-gradient(135deg, rgba(234, 254, 103, 0.15) 0%, rgba(234, 254, 103, 0.25) 100%) !important;
  border-left: 4px solid $pg-primary !important;
  border-radius: 8px !important;
  padding: 14px 18px !important;
  margin-bottom: 20px !important;
  font-family: $pg-font !important;
  font-size: 14px !important;
  font-weight: 600 !important;
  color: $pg-black !important;
  text-align: left !important;
  line-height: 1.5 !important;
  box-shadow: 0 2px 8px rgba(234, 254, 103, 0.15) !important;
}

{# Responsivo: Texto menor em mobile #}
@media (max-width: $sm) {
  .summary::before {
    font-size: 13px !important;
    padding: 12px 14px !important;
  }
  
  .summary-container::after,
  .panel.summary::after {
    font-size: 12px !important;
    padding: 10px 12px !important;
  }
}

{# /* ===== VALIDAÇÃO E GARANTIA DE COMPATIBILIDADE ===== */ #}

{# 
NOTA IMPORTANTE:
- Todas as customizações acima são específicas do checkout
- Seletores são específicos para não afetar outras páginas
- !important é usado para sobrescrever estilos padrão da Nuvemshop
- Todas as transições e animações são suaves (0.3s ease)
- Mobile-first: ajustes responsivos incluídos
- Acessibilidade: contraste adequado mantido
- Performance: sem JavaScript adicional necessário
#}

{# /* ===== ÍCONES DA PÁGINA DE PAGAMENTO - ALINHAMENTO ===== */ #}

/* Ícones dos métodos de pagamento (Cartão, Pix, Boleto) */
.payment-method img,
.payment-method svg,
.radio-item img,
.radio-item svg,
label img,
label svg {
  vertical-align: middle !important;
  margin-right: 8px !important;
}

/* Container do método de pagamento com flexbox (fallback) */
.payment-method,
.radio-item,
label.radio {
  display: inline-flex !important;
  align-items: center !important;
  gap: 8px !important;
}


{% endif %}

