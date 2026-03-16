{% raw %}@charset "UTF-8":

/*============================================================================
style-critical.tpl - PATAGANG

    -Este arquivo contém CSS crítico carregado inline no head (first paint)
    -Resto dos estilos:
      --static/css/style-colors.scss.tpl --> Cores e fontes (config/settings.txt)
      --static/css/style-async.scss.tpl --> Estilos não críticos (async)
      --static/css/style-menu-patagang.css.tpl --> Menu/header (inline após critical)
      --static/css/style-filters-patagang.css.tpl --> Filtros (inline após critical)
      --static/css/style-home-v2.css --> Home (link condicional template==home)
      --layouts/layout.tpl --> Override final listagem, ad bar, PDP

==============================================================================*/

/*============================================================================
  Table of Contents

  #External CSS libraries and plugins
    // Bootstrap Grid v4.1.3
    // Swiper 4.4.2
  #Critical path helpers
  #Components
    // Wrappers
    // Placeholders and preloaders
    // Buttons
    // Links
    // Headings
    // Titles and breadcrumbs
    // Texts
    // Icons
    // Sliders
    // Lists
    // Tables
    // Notifications
    // Images
    // Forms
    // Video
  #Header and nav
    // Ad Bar
    // Logo
    // Cart widget and search
  #Home page
    // Welcome message
  #Banners
    // Home banners
    // Informative banners
  #Product grid
    // Category header
    // Grid item
    // Labels
  #Product detail
  	// Image
  #Cart detail
    // Shipping Calculator
  #Contact page
    // Data contact
  #Blog
  #Media queries
    // Min width 768px
      //// Components
      //// Banners
      //// Home
      //// Product detail
      //// Helper classes

  #Helper classes
    // Margin and padding
    // Text
    // Align
    // Position
    // Image
    // Visibility
    // Float
    // Width

==============================================================================*/

/* ============================================================================
   PATAGANG - Background Global Padronizado
   Cor #E2E2E2 conforme protótipo Adobe XD
   Transição suave para rodapé branco #FFFFFF
============================================================================ */

body {
    background-color: #E2E2E2 !important;
    min-height: 100vh;
}

/* Barra de aviso - altura responsiva (clamp sem breakpoints fixos) */
:root {
  --ad-bar-height: clamp(14px, 2dvh, 28px);
}

/* Seções que devem ter background global #E2E2E2 forçado */
.section-products-related,
#reviewsapp,
.pg-pdp-extras-container,
.js-related-products,
.js-complementary-products,
.content-container,
main#content,
/* Componentes PDP */
.section-fb-comments,
.pg-section,
.pg-products-grid,
#single-product,
#product-related,
/* Containers de páginas internas */
.page-content,
.category-header,
.search-results,
.account-page-content,
.login-container,
.blog-container,
.blog-wrapper,
.institutional-page,
.contact-page,
.form-container,
.cart-container,
.checkout-container,
/* Containers estruturais */
.container-fluid,
.row-fluid,
.section,
.main,
.wrapper {
    background-color: #E2E2E2 !important;
    background: #E2E2E2 !important;
}

/* Exceção: barra de aviso sempre amarela em todas as páginas (incl. home) */
.section-advertising {
  background: transparent !important;
  background-color: transparent !important;
}

/* ============================================================================
   PATAGANG - Footer com Transição Suave (Páginas Internas)
   Cinza #E2E2E2 → Branco #FFFFFF
============================================================================ */

/* Footer base - sem divisoria, sem linha branca */
.main-footer {
    background-color: #E2E2E2 !important;
    margin-top: 0 !important;
    padding-top: 0 !important;
    border-top: none !important;
    position: relative;
}

/* Pseudo-elemento removido - a custom .footer cuida do gradiente */
.main-footer::before {
    display: none !important;
    content: none !important;
}

/* ============================================
   CORREÇÃO 1: SECTION ADVERTISING (cor/filtro; fundo amarelo no bloco Ad Bar mais abaixo)
   ============================================ */
.section-advertising {
    color: #000000 !important;
    opacity: 1 !important;
    z-index: 10001 !important; /* Acima de tudo e overlays */
    -webkit-filter: none !important;
    filter: none !important;
}

/* Remover qualquer cor/filtro/cinza herdado em links/texto */
.section-advertising *,
.section-advertising a,
.section-advertising p,
.section-advertising span,
.section-advertising div,
.section-advertising .col,
.section-advertising .row-fluid,
.section-advertising .container,
.section-advertising .text-center,
.section-advertising .link-contrast {
    color: #000000 !important;
    opacity: 1 !important;
    text-shadow: none !important;
    -webkit-filter: none !important;
    filter: none !important;
    background-color: transparent !important;
    background: transparent !important;
}

/* ============================================
   CORREÇÃO 2: PÁGINAS DE CONTA - PADRÃO PATAGANG
   Background #E2E2E2, card branco centralizado
   ============================================ */
.pg-account-page {
    min-height: calc(100vh - 100px);
    background-color: #E2E2E2;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    padding: 120px 20px 80px;
}

.pg-account-page__container {
    width: 100%;
    max-width: 960px;
    margin: 0 auto;
}

.pg-account-card {
    background: #FFFFFF;
    border: 2px solid #000000;
    border-radius: 12px;
    padding: 32px 28px;
}

.pg-account-card__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 28px;
    font-weight: 700;
    color: #000;
    margin: 0 0 24px 0;
    text-align: center;
    text-transform: uppercase;
}

@media (min-width: 768px) {
    .pg-account-page {
        padding: 140px 20px 100px;
    }
    .pg-account-card {
        padding: 40px 36px;
    }
}

/* Fallback: old .account-page class (caso algum template antigo permaneça) */
.account-page,
#account-orders,
#account-addresses,
#account-info,
.page-account {
    padding-top: 200px !important;
    padding-bottom: 80px;
    min-height: 80vh;
}

.account-page .container,
.page-account .container {
    background: #FFFFFF;
    padding: 40px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    position: relative;
    z-index: 10;
}

.account-page .page-header h1,
.account-page .page-header,
.page-account .page-header {
    margin-top: 0;
    padding-top: 0;
    margin-bottom: 30px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    text-transform: uppercase;
    text-align: center;
}

.account-page .breadcrumb,
.page-account .breadcrumb {
    display: none;
}

/* ============================================
   CORREÇÃO 3: REMOVER MARGEM RODAPÉ
   ============================================ */
main > .container-fluid:last-child,
.account-page,
.pg-page,
.pg-login-page {
    margin-bottom: 0 !important;
    padding-bottom: 0 !important;
}

.pg-account-page {
    margin-bottom: 0 !important;
}

.section-products-related {
    margin-bottom: 0 !important;
    padding-bottom: 0 !important;
    background-color: #E2E2E2 !important;
}

/* Garantir que nenhum gap branco apareca entre conteudo e footer */
.main-footer,
.footer {
    background-color: #E2E2E2 !important;
}

/* Remover my-3 margin-bottom em related products (ultimo elemento antes do footer) */
.section-products-related.my-3 {
    margin-bottom: 0 !important;
}

/* Home mantém sua transição amarela específica (exceção) */
.footer-home.main-footer::before {
    background: linear-gradient(to bottom,
        rgba(234, 254, 103, 0.15) 0%,
        rgba(234, 254, 103, 0.05) 50%,
        transparent 100%);
    top: 0;
    height: 300px;
}

/* ============================================================================ */


/*============================================================================
  #External CSS libraries and plugins
==============================================================================*/

{# /* // Bootstrap Grid v4.1.3 */ #}

@-ms-viewport{width:device-width}html{box-sizing:border-box;-ms-overflow-style:scrollbar}*,::after,::before{box-sizing:inherit}.container{width:100%;padding-right:15px;padding-left:15px;margin-right:auto;margin-left:auto}@media (min-width:576px){.container{max-width:540px}}@media (min-width:768px){.container{max-width:720px}}@media (min-width:992px){.container{max-width:960px}}@media (min-width:1200px){.container{max-width:1140px}}.container-fluid{width:100%;padding-right:15px;padding-left:15px;margin-right:auto;margin-left:auto}.row{display:-ms-flexbox;display:flex;-ms-flex-wrap:wrap;flex-wrap:wrap;margin-right:-15px;margin-left:-15px}.no-gutters{margin-right:0;margin-left:0}.no-gutters>.col,.no-gutters>[class*=col-]{padding-right:0;padding-left:0}.col,.col-1,.col-10,.col-11,.col-12,.col-2,.col-3,.col-4,.col-5,.col-6,.col-7,.col-8,.col-9,.col-auto,.col-lg,.col-lg-1,.col-lg-10,.col-lg-11,.col-lg-12,.col-lg-2,.col-lg-3,.col-lg-4,.col-lg-5,.col-lg-6,.col-lg-7,.col-lg-8,.col-lg-9,.col-lg-auto,.col-md,.col-md-1,.col-md-10,.col-md-11,.col-md-12,.col-md-2,.col-md-3,.col-md-4,.col-md-5,.col-md-6,.col-md-7,.col-md-8,.col-md-9,.col-md-auto,.col-sm,.col-sm-1,.col-sm-10,.col-sm-11,.col-sm-12,.col-sm-2,.col-sm-3,.col-sm-4,.col-sm-5,.col-sm-6,.col-sm-7,.col-sm-8,.col-sm-9,.col-sm-auto,.col-xl,.col-xl-1,.col-xl-10,.col-xl-11,.col-xl-12,.col-xl-2,.col-xl-3,.col-xl-4,.col-xl-5,.col-xl-6,.col-xl-7,.col-xl-8,.col-xl-9,.col-xl-auto{position:relative;width:100%;min-height:1px;padding-right:15px;padding-left:15px}.col{-ms-flex-preferred-size:0;flex-basis:0;-ms-flex-positive:1;flex-grow:1;max-width:100%}.col-auto{-ms-flex:0 0 auto;flex:0 0 auto;width:auto;max-width:none}.col-1{-ms-flex:0 0 8.333333%;flex:0 0 8.333333%;max-width:8.333333%}.col-2{-ms-flex:0 0 16.666667%;flex:0 0 16.666667%;max-width:16.666667%}.col-3{-ms-flex:0 0 25%;flex:0 0 25%;max-width:25%}.col-4{-ms-flex:0 0 33.333333%;flex:0 0 33.333333%;max-width:33.333333%}.col-5{-ms-flex:0 0 41.666667%;flex:0 0 41.666667%;max-width:41.666667%}.col-6{-ms-flex:0 0 50%;flex:0 0 50%;max-width:50%}.col-7{-ms-flex:0 0 58.333333%;flex:0 0 58.333333%;max-width:58.333333%}.col-8{-ms-flex:0 0 66.666667%;flex:0 0 66.666667%;max-width:66.666667%}.col-9{-ms-flex:0 0 75%;flex:0 0 75%;max-width:75%}.col-10{-ms-flex:0 0 83.333333%;flex:0 0 83.333333%;max-width:83.333333%}.col-11{-ms-flex:0 0 91.666667%;flex:0 0 91.666667%;max-width:91.666667%}.col-12{-ms-flex:0 0 100%;flex:0 0 100%;max-width:100%}.order-first{-ms-flex-order:-1;order:-1}.order-last{-ms-flex-order:13;order:13}.order-0{-ms-flex-order:0;order:0}.order-1{-ms-flex-order:1;order:1}.order-2{-ms-flex-order:2;order:2}.order-3{-ms-flex-order:3;order:3}.order-4{-ms-flex-order:4;order:4}.order-5{-ms-flex-order:5;order:5}.order-6{-ms-flex-order:6;order:6}.order-7{-ms-flex-order:7;order:7}.order-8{-ms-flex-order:8;order:8}.order-9{-ms-flex-order:9;order:9}.order-10{-ms-flex-order:10;order:10}.order-11{-ms-flex-order:11;order:11}.order-12{-ms-flex-order:12;order:12}.offset-1{margin-left:8.333333%}.offset-2{margin-left:16.666667%}.offset-3{margin-left:25%}.offset-4{margin-left:33.333333%}.offset-5{margin-left:41.666667%}.offset-6{margin-left:50%}.offset-7{margin-left:58.333333%}.offset-8{margin-left:66.666667%}.offset-9{margin-left:75%}.offset-10{margin-left:83.333333%}.offset-11{margin-left:91.666667%}@media (min-width:576px){.col-sm{-ms-flex-preferred-size:0;flex-basis:0;-ms-flex-positive:1;flex-grow:1;max-width:100%}.col-sm-auto{-ms-flex:0 0 auto;flex:0 0 auto;width:auto;max-width:none}.col-sm-1{-ms-flex:0 0 8.333333%;flex:0 0 8.333333%;max-width:8.333333%}.col-sm-2{-ms-flex:0 0 16.666667%;flex:0 0 16.666667%;max-width:16.666667%}.col-sm-3{-ms-flex:0 0 25%;flex:0 0 25%;max-width:25%}.col-sm-4{-ms-flex:0 0 33.333333%;flex:0 0 33.333333%;max-width:33.333333%}.col-sm-5{-ms-flex:0 0 41.666667%;flex:0 0 41.666667%;max-width:41.666667%}.col-sm-6{-ms-flex:0 0 50%;flex:0 0 50%;max-width:50%}.col-sm-7{-ms-flex:0 0 58.333333%;flex:0 0 58.333333%;max-width:58.333333%}.col-sm-8{-ms-flex:0 0 66.666667%;flex:0 0 66.666667%;max-width:66.666667%}.col-sm-9{-ms-flex:0 0 75%;flex:0 0 75%;max-width:75%}.col-sm-10{-ms-flex:0 0 83.333333%;flex:0 0 83.333333%;max-width:83.333333%}.col-sm-11{-ms-flex:0 0 91.666667%;flex:0 0 91.666667%;max-width:91.666667%}.col-sm-12{-ms-flex:0 0 100%;flex:0 0 100%;max-width:100%}.order-sm-first{-ms-flex-order:-1;order:-1}.order-sm-last{-ms-flex-order:13;order:13}.order-sm-0{-ms-flex-order:0;order:0}.order-sm-1{-ms-flex-order:1;order:1}.order-sm-2{-ms-flex-order:2;order:2}.order-sm-3{-ms-flex-order:3;order:3}.order-sm-4{-ms-flex-order:4;order:4}.order-sm-5{-ms-flex-order:5;order:5}.order-sm-6{-ms-flex-order:6;order:6}.order-sm-7{-ms-flex-order:7;order:7}.order-sm-8{-ms-flex-order:8;order:8}.order-sm-9{-ms-flex-order:9;order:9}.order-sm-10{-ms-flex-order:10;order:10}.order-sm-11{-ms-flex-order:11;order:11}.order-sm-12{-ms-flex-order:12;order:12}.offset-sm-0{margin-left:0}.offset-sm-1{margin-left:8.333333%}.offset-sm-2{margin-left:16.666667%}.offset-sm-3{margin-left:25%}.offset-sm-4{margin-left:33.333333%}.offset-sm-5{margin-left:41.666667%}.offset-sm-6{margin-left:50%}.offset-sm-7{margin-left:58.333333%}.offset-sm-8{margin-left:66.666667%}.offset-sm-9{margin-left:75%}.offset-sm-10{margin-left:83.333333%}.offset-sm-11{margin-left:91.666667%}}@media (min-width:768px){.col-md{-ms-flex-preferred-size:0;flex-basis:0;-ms-flex-positive:1;flex-grow:1;max-width:100%}.col-md-auto{-ms-flex:0 0 auto;flex:0 0 auto;width:auto;max-width:none}.col-md-1{-ms-flex:0 0 8.333333%;flex:0 0 8.333333%;max-width:8.333333%}.col-md-2{-ms-flex:0 0 16.666667%;flex:0 0 16.666667%;max-width:16.666667%}.col-md-3{-ms-flex:0 0 25%;flex:0 0 25%;max-width:25%}.col-md-4{-ms-flex:0 0 33.333333%;flex:0 0 33.333333%;max-width:33.333333%}.col-md-5{-ms-flex:0 0 41.666667%;flex:0 0 41.666667%;max-width:41.666667%}.col-md-6{-ms-flex:0 0 50%;flex:0 0 50%;max-width:50%}.col-md-7{-ms-flex:0 0 58.333333%;flex:0 0 58.333333%;max-width:58.333333%}.col-md-8{-ms-flex:0 0 66.666667%;flex:0 0 66.666667%;max-width:66.666667%}.col-md-9{-ms-flex:0 0 75%;flex:0 0 75%;max-width:75%}.col-md-10{-ms-flex:0 0 83.333333%;flex:0 0 83.333333%;max-width:83.333333%}.col-md-11{-ms-flex:0 0 91.666667%;flex:0 0 91.666667%;max-width:91.666667%}.col-md-12{-ms-flex:0 0 100%;flex:0 0 100%;max-width:100%}.order-md-first{-ms-flex-order:-1;order:-1}.order-md-last{-ms-flex-order:13;order:13}.order-md-0{-ms-flex-order:0;order:0}.order-md-1{-ms-flex-order:1;order:1}.order-md-2{-ms-flex-order:2;order:2}.order-md-3{-ms-flex-order:3;order:3}.order-md-4{-ms-flex-order:4;order:4}.order-md-5{-ms-flex-order:5;order:5}.order-md-6{-ms-flex-order:6;order:6}.order-md-7{-ms-flex-order:7;order:7}.order-md-8{-ms-flex-order:8;order:8}.order-md-9{-ms-flex-order:9;order:9}.order-md-10{-ms-flex-order:10;order:10}.order-md-11{-ms-flex-order:11;order:11}.order-md-12{-ms-flex-order:12;order:12}.offset-md-0{margin-left:0}.offset-md-1{margin-left:8.333333%}.offset-md-2{margin-left:16.666667%}.offset-md-3{margin-left:25%}.offset-md-4{margin-left:33.333333%}.offset-md-5{margin-left:41.666667%}.offset-md-6{margin-left:50%}.offset-md-7{margin-left:58.333333%}.offset-md-8{margin-left:66.666667%}.offset-md-9{margin-left:75%}.offset-md-10{margin-left:83.333333%}.offset-md-11{margin-left:91.666667%}}@media (min-width:992px){.col-lg{-ms-flex-preferred-size:0;flex-basis:0;-ms-flex-positive:1;flex-grow:1;max-width:100%}.col-lg-auto{-ms-flex:0 0 auto;flex:0 0 auto;width:auto;max-width:none}.col-lg-1{-ms-flex:0 0 8.333333%;flex:0 0 8.333333%;max-width:8.333333%}.col-lg-2{-ms-flex:0 0 16.666667%;flex:0 0 16.666667%;max-width:16.666667%}.col-lg-3{-ms-flex:0 0 25%;flex:0 0 25%;max-width:25%}.col-lg-4{-ms-flex:0 0 33.333333%;flex:0 0 33.333333%;max-width:33.333333%}.col-lg-5{-ms-flex:0 0 41.666667%;flex:0 0 41.666667%;max-width:41.666667%}.col-lg-6{-ms-flex:0 0 50%;flex:0 0 50%;max-width:50%}.col-lg-7{-ms-flex:0 0 58.333333%;flex:0 0 58.333333%;max-width:58.333333%}.col-lg-8{-ms-flex:0 0 66.666667%;flex:0 0 66.666667%;max-width:66.666667%}.col-lg-9{-ms-flex:0 0 75%;flex:0 0 75%;max-width:75%}.col-lg-10{-ms-flex:0 0 83.333333%;flex:0 0 83.333333%;max-width:83.333333%}.col-lg-11{-ms-flex:0 0 91.666667%;flex:0 0 91.666667%;max-width:91.666667%}.col-lg-12{-ms-flex:0 0 100%;flex:0 0 100%;max-width:100%}.order-lg-first{-ms-flex-order:-1;order:-1}.order-lg-last{-ms-flex-order:13;order:13}.order-lg-0{-ms-flex-order:0;order:0}.order-lg-1{-ms-flex-order:1;order:1}.order-lg-2{-ms-flex-order:2;order:2}.order-lg-3{-ms-flex-order:3;order:3}.order-lg-4{-ms-flex-order:4;order:4}.order-lg-5{-ms-flex-order:5;order:5}.order-lg-6{-ms-flex-order:6;order:6}.order-lg-7{-ms-flex-order:7;order:7}.order-lg-8{-ms-flex-order:8;order:8}.order-lg-9{-ms-flex-order:9;order:9}.order-lg-10{-ms-flex-order:10;order:10}.order-lg-11{-ms-flex-order:11;order:11}.order-lg-12{-ms-flex-order:12;order:12}.offset-lg-0{margin-left:0}.offset-lg-1{margin-left:8.333333%}.offset-lg-2{margin-left:16.666667%}.offset-lg-3{margin-left:25%}.offset-lg-4{margin-left:33.333333%}.offset-lg-5{margin-left:41.666667%}.offset-lg-6{margin-left:50%}.offset-lg-7{margin-left:58.333333%}.offset-lg-8{margin-left:66.666667%}.offset-lg-9{margin-left:75%}.offset-lg-10{margin-left:83.333333%}.offset-lg-11{margin-left:91.666667%}}@media (min-width:1200px){.col-xl{-ms-flex-preferred-size:0;flex-basis:0;-ms-flex-positive:1;flex-grow:1;max-width:100%}.col-xl-auto{-ms-flex:0 0 auto;flex:0 0 auto;width:auto;max-width:none}.col-xl-1{-ms-flex:0 0 8.333333%;flex:0 0 8.333333%;max-width:8.333333%}.col-xl-2{-ms-flex:0 0 16.666667%;flex:0 0 16.666667%;max-width:16.666667%}.col-xl-3{-ms-flex:0 0 25%;flex:0 0 25%;max-width:25%}.col-xl-4{-ms-flex:0 0 33.333333%;flex:0 0 33.333333%;max-width:33.333333%}.col-xl-5{-ms-flex:0 0 41.666667%;flex:0 0 41.666667%;max-width:41.666667%}.col-xl-6{-ms-flex:0 0 50%;flex:0 0 50%;max-width:50%}.col-xl-7{-ms-flex:0 0 58.333333%;flex:0 0 58.333333%;max-width:58.333333%}.col-xl-8{-ms-flex:0 0 66.666667%;flex:0 0 66.666667%;max-width:66.666667%}.col-xl-9{-ms-flex:0 0 75%;flex:0 0 75%;max-width:75%}.col-xl-10{-ms-flex:0 0 83.333333%;flex:0 0 83.333333%;max-width:83.333333%}.col-xl-11{-ms-flex:0 0 91.666667%;flex:0 0 91.666667%;max-width:91.666667%}.col-xl-12{-ms-flex:0 0 100%;flex:0 0 100%;max-width:100%}.order-xl-first{-ms-flex-order:-1;order:-1}.order-xl-last{-ms-flex-order:13;order:13}.order-xl-0{-ms-flex-order:0;order:0}.order-xl-1{-ms-flex-order:1;order:1}.order-xl-2{-ms-flex-order:2;order:2}.order-xl-3{-ms-flex-order:3;order:3}.order-xl-4{-ms-flex-order:4;order:4}.order-xl-5{-ms-flex-order:5;order:5}.order-xl-6{-ms-flex-order:6;order:6}.order-xl-7{-ms-flex-order:7;order:7}.order-xl-8{-ms-flex-order:8;order:8}.order-xl-9{-ms-flex-order:9;order:9}.order-xl-10{-ms-flex-order:10;order:10}.order-xl-11{-ms-flex-order:11;order:11}.order-xl-12{-ms-flex-order:12;order:12}.offset-xl-0{margin-left:0}.offset-xl-1{margin-left:8.333333%}.offset-xl-2{margin-left:16.666667%}.offset-xl-3{margin-left:25%}.offset-xl-4{margin-left:33.333333%}.offset-xl-5{margin-left:41.666667%}.offset-xl-6{margin-left:50%}.offset-xl-7{margin-left:58.333333%}.offset-xl-8{margin-left:66.666667%}.offset-xl-9{margin-left:75%}.offset-xl-10{margin-left:83.333333%}.offset-xl-11{margin-left:91.666667%}}.d-none{display:none!important}.d-inline{display:inline!important}.d-inline-block{display:inline-block!important}.d-block{display:block!important}.d-table{display:table!important}.d-table-row{display:table-row!important}.d-table-cell{display:table-cell!important}.d-flex{display:-ms-flexbox!important;display:flex!important}.d-inline-flex{display:-ms-inline-flexbox!important;display:inline-flex!important}@media (min-width:576px){.d-sm-none{display:none!important}.d-sm-inline{display:inline!important}.d-sm-inline-block{display:inline-block!important}.d-sm-block{display:block!important}.d-sm-table{display:table!important}.d-sm-table-row{display:table-row!important}.d-sm-table-cell{display:table-cell!important}.d-sm-flex{display:-ms-flexbox!important;display:flex!important}.d-sm-inline-flex{display:-ms-inline-flexbox!important;display:inline-flex!important}}@media (min-width:768px){.d-md-none{display:none!important}.d-md-inline{display:inline!important}.d-md-inline-block{display:inline-block!important}.d-md-block{display:block!important}.d-md-table{display:table!important}.d-md-table-row{display:table-row!important}.d-md-table-cell{display:table-cell!important}.d-md-flex{display:-ms-flexbox!important;display:flex!important}.d-md-inline-flex{display:-ms-inline-flexbox!important;display:inline-flex!important}}@media (min-width:992px){.d-lg-none{display:none!important}.d-lg-inline{display:inline!important}.d-lg-inline-block{display:inline-block!important}.d-lg-block{display:block!important}.d-lg-table{display:table!important}.d-lg-table-row{display:table-row!important}.d-lg-table-cell{display:table-cell!important}.d-lg-flex{display:-ms-flexbox!important;display:flex!important}.d-lg-inline-flex{display:-ms-inline-flexbox!important;display:inline-flex!important}}@media (min-width:1200px){.d-xl-none{display:none!important}.d-xl-inline{display:inline!important}.d-xl-inline-block{display:inline-block!important}.d-xl-block{display:block!important}.d-xl-table{display:table!important}.d-xl-table-row{display:table-row!important}.d-xl-table-cell{display:table-cell!important}.d-xl-flex{display:-ms-flexbox!important;display:flex!important}.d-xl-inline-flex{display:-ms-inline-flexbox!important;display:inline-flex!important}}@media print{.d-print-none{display:none!important}.d-print-inline{display:inline!important}.d-print-inline-block{display:inline-block!important}.d-print-block{display:block!important}.d-print-table{display:table!important}.d-print-table-row{display:table-row!important}.d-print-table-cell{display:table-cell!important}.d-print-flex{display:-ms-flexbox!important;display:flex!important}.d-print-inline-flex{display:-ms-inline-flexbox!important;display:inline-flex!important}}.flex-row{-ms-flex-direction:row!important;flex-direction:row!important}.flex-column{-ms-flex-direction:column!important;flex-direction:column!important}.flex-row-reverse{-ms-flex-direction:row-reverse!important;flex-direction:row-reverse!important}.flex-column-reverse{-ms-flex-direction:column-reverse!important;flex-direction:column-reverse!important}.flex-wrap{-ms-flex-wrap:wrap!important;flex-wrap:wrap!important}.flex-nowrap{-ms-flex-wrap:nowrap!important;flex-wrap:nowrap!important}.flex-wrap-reverse{-ms-flex-wrap:wrap-reverse!important;flex-wrap:wrap-reverse!important}.flex-fill{-ms-flex:1 1 auto!important;flex:1 1 auto!important}.flex-grow-0{-ms-flex-positive:0!important;flex-grow:0!important}.flex-grow-1{-ms-flex-positive:1!important;flex-grow:1!important}.flex-shrink-0{-ms-flex-negative:0!important;flex-shrink:0!important}.flex-shrink-1{-ms-flex-negative:1!important;flex-shrink:1!important}.justify-content-start{-ms-flex-pack:start!important;justify-content:flex-start!important}.justify-content-end{-ms-flex-pack:end!important;justify-content:flex-end!important}.justify-content-center{-ms-flex-pack:center!important;justify-content:center!important}.justify-content-between{-ms-flex-pack:justify!important;justify-content:space-between!important}.justify-content-around{-ms-flex-pack:distribute!important;justify-content:space-around!important}.align-items-start{-ms-flex-align:start!important;align-items:flex-start!important}.align-items-end{-ms-flex-align:end!important;align-items:flex-end!important}.align-items-center{-ms-flex-align:center!important;align-items:center!important}.align-items-baseline{-ms-flex-align:baseline!important;align-items:baseline!important}.align-items-stretch{-ms-flex-align:stretch!important;align-items:stretch!important}.align-content-start{-ms-flex-line-pack:start!important;align-content:flex-start!important}.align-content-end{-ms-flex-line-pack:end!important;align-content:flex-end!important}.align-content-center{-ms-flex-line-pack:center!important;align-content:center!important}.align-content-between{-ms-flex-line-pack:justify!important;align-content:space-between!important}.align-content-around{-ms-flex-line-pack:distribute!important;align-content:space-around!important}.align-content-stretch{-ms-flex-line-pack:stretch!important;align-content:stretch!important}.align-self-auto{-ms-flex-item-align:auto!important;align-self:auto!important}.align-self-start{-ms-flex-item-align:start!important;align-self:flex-start!important}.align-self-end{-ms-flex-item-align:end!important;align-self:flex-end!important}.align-self-center{-ms-flex-item-align:center!important;align-self:center!important}.align-self-baseline{-ms-flex-item-align:baseline!important;align-self:baseline!important}.align-self-stretch{-ms-flex-item-align:stretch!important;align-self:stretch!important}@media (min-width:576px){.flex-sm-row{-ms-flex-direction:row!important;flex-direction:row!important}.flex-sm-column{-ms-flex-direction:column!important;flex-direction:column!important}.flex-sm-row-reverse{-ms-flex-direction:row-reverse!important;flex-direction:row-reverse!important}.flex-sm-column-reverse{-ms-flex-direction:column-reverse!important;flex-direction:column-reverse!important}.flex-sm-wrap{-ms-flex-wrap:wrap!important;flex-wrap:wrap!important}.flex-sm-nowrap{-ms-flex-wrap:nowrap!important;flex-wrap:nowrap!important}.flex-sm-wrap-reverse{-ms-flex-wrap:wrap-reverse!important;flex-wrap:wrap-reverse!important}.flex-sm-fill{-ms-flex:1 1 auto!important;flex:1 1 auto!important}.flex-sm-grow-0{-ms-flex-positive:0!important;flex-grow:0!important}.flex-sm-grow-1{-ms-flex-positive:1!important;flex-grow:1!important}.flex-sm-shrink-0{-ms-flex-negative:0!important;flex-shrink:0!important}.flex-sm-shrink-1{-ms-flex-negative:1!important;flex-shrink:1!important}.justify-content-sm-start{-ms-flex-pack:start!important;justify-content:flex-start!important}.justify-content-sm-end{-ms-flex-pack:end!important;justify-content:flex-end!important}.justify-content-sm-center{-ms-flex-pack:center!important;justify-content:center!important}.justify-content-sm-between{-ms-flex-pack:justify!important;justify-content:space-between!important}.justify-content-sm-around{-ms-flex-pack:distribute!important;justify-content:space-around!important}.align-items-sm-start{-ms-flex-align:start!important;align-items:flex-start!important}.align-items-sm-end{-ms-flex-align:end!important;align-items:flex-end!important}.align-items-sm-center{-ms-flex-align:center!important;align-items:center!important}.align-items-sm-baseline{-ms-flex-align:baseline!important;align-items:baseline!important}.align-items-sm-stretch{-ms-flex-align:stretch!important;align-items:stretch!important}.align-content-sm-start{-ms-flex-line-pack:start!important;align-content:flex-start!important}.align-content-sm-end{-ms-flex-line-pack:end!important;align-content:flex-end!important}.align-content-sm-center{-ms-flex-line-pack:center!important;align-content:center!important}.align-content-sm-between{-ms-flex-line-pack:justify!important;align-content:space-between!important}.align-content-sm-around{-ms-flex-line-pack:distribute!important;align-content:space-around!important}.align-content-sm-stretch{-ms-flex-line-pack:stretch!important;align-content:stretch!important}.align-self-sm-auto{-ms-flex-item-align:auto!important;align-self:auto!important}.align-self-sm-start{-ms-flex-item-align:start!important;align-self:flex-start!important}.align-self-sm-end{-ms-flex-item-align:end!important;align-self:flex-end!important}.align-self-sm-center{-ms-flex-item-align:center!important;align-self:center!important}.align-self-sm-baseline{-ms-flex-item-align:baseline!important;align-self:baseline!important}.align-self-sm-stretch{-ms-flex-item-align:stretch!important;align-self:stretch!important}}@media (min-width:768px){.flex-md-row{-ms-flex-direction:row!important;flex-direction:row!important}.flex-md-column{-ms-flex-direction:column!important;flex-direction:column!important}.flex-md-row-reverse{-ms-flex-direction:row-reverse!important;flex-direction:row-reverse!important}.flex-md-column-reverse{-ms-flex-direction:column-reverse!important;flex-direction:column-reverse!important}.flex-md-wrap{-ms-flex-wrap:wrap!important;flex-wrap:wrap!important}.flex-md-nowrap{-ms-flex-wrap:nowrap!important;flex-wrap:nowrap!important}.flex-md-wrap-reverse{-ms-flex-wrap:wrap-reverse!important;flex-wrap:wrap-reverse!important}.flex-md-fill{-ms-flex:1 1 auto!important;flex:1 1 auto!important}.flex-md-grow-0{-ms-flex-positive:0!important;flex-grow:0!important}.flex-md-grow-1{-ms-flex-positive:1!important;flex-grow:1!important}.flex-md-shrink-0{-ms-flex-negative:0!important;flex-shrink:0!important}.flex-md-shrink-1{-ms-flex-negative:1!important;flex-shrink:1!important}.justify-content-md-start{-ms-flex-pack:start!important;justify-content:flex-start!important}.justify-content-md-end{-ms-flex-pack:end!important;justify-content:flex-end!important}.justify-content-md-center{-ms-flex-pack:center!important;justify-content:center!important}.justify-content-md-between{-ms-flex-pack:justify!important;justify-content:space-between!important}.justify-content-md-around{-ms-flex-pack:distribute!important;justify-content:space-around!important}.align-items-md-start{-ms-flex-align:start!important;align-items:flex-start!important}.align-items-md-end{-ms-flex-align:end!important;align-items:flex-end!important}.align-items-md-center{-ms-flex-align:center!important;align-items:center!important}.align-items-md-baseline{-ms-flex-align:baseline!important;align-items:baseline!important}.align-items-md-stretch{-ms-flex-align:stretch!important;align-items:stretch!important}.align-content-md-start{-ms-flex-line-pack:start!important;align-content:flex-start!important}.align-content-md-end{-ms-flex-line-pack:end!important;align-content:flex-end!important}.align-content-md-center{-ms-flex-line-pack:center!important;align-content:center!important}.align-content-md-between{-ms-flex-line-pack:justify!important;align-content:space-between!important}.align-content-md-around{-ms-flex-line-pack:distribute!important;align-content:space-around!important}.align-content-md-stretch{-ms-flex-line-pack:stretch!important;align-content:stretch!important}.align-self-md-auto{-ms-flex-item-align:auto!important;align-self:auto!important}.align-self-md-start{-ms-flex-item-align:start!important;align-self:flex-start!important}.align-self-md-end{-ms-flex-item-align:end!important;align-self:flex-end!important}.align-self-md-center{-ms-flex-item-align:center!important;align-self:center!important}.align-self-md-baseline{-ms-flex-item-align:baseline!important;align-self:baseline!important}.align-self-md-stretch{-ms-flex-item-align:stretch!important;align-self:stretch!important}}@media (min-width:992px){.flex-lg-row{-ms-flex-direction:row!important;flex-direction:row!important}.flex-lg-column{-ms-flex-direction:column!important;flex-direction:column!important}.flex-lg-row-reverse{-ms-flex-direction:row-reverse!important;flex-direction:row-reverse!important}.flex-lg-column-reverse{-ms-flex-direction:column-reverse!important;flex-direction:column-reverse!important}.flex-lg-wrap{-ms-flex-wrap:wrap!important;flex-wrap:wrap!important}.flex-lg-nowrap{-ms-flex-wrap:nowrap!important;flex-wrap:nowrap!important}.flex-lg-wrap-reverse{-ms-flex-wrap:wrap-reverse!important;flex-wrap:wrap-reverse!important}.flex-lg-fill{-ms-flex:1 1 auto!important;flex:1 1 auto!important}.flex-lg-grow-0{-ms-flex-positive:0!important;flex-grow:0!important}.flex-lg-grow-1{-ms-flex-positive:1!important;flex-grow:1!important}.flex-lg-shrink-0{-ms-flex-negative:0!important;flex-shrink:0!important}.flex-lg-shrink-1{-ms-flex-negative:1!important;flex-shrink:1!important}.justify-content-lg-start{-ms-flex-pack:start!important;justify-content:flex-start!important}.justify-content-lg-end{-ms-flex-pack:end!important;justify-content:flex-end!important}.justify-content-lg-center{-ms-flex-pack:center!important;justify-content:center!important}.justify-content-lg-between{-ms-flex-pack:justify!important;justify-content:space-between!important}.justify-content-lg-around{-ms-flex-pack:distribute!important;justify-content:space-around!important}.align-items-lg-start{-ms-flex-align:start!important;align-items:flex-start!important}.align-items-lg-end{-ms-flex-align:end!important;align-items:flex-end!important}.align-items-lg-center{-ms-flex-align:center!important;align-items:center!important}.align-items-lg-baseline{-ms-flex-align:baseline!important;align-items:baseline!important}.align-items-lg-stretch{-ms-flex-align:stretch!important;align-items:stretch!important}.align-content-lg-start{-ms-flex-line-pack:start!important;align-content:flex-start!important}.align-content-lg-end{-ms-flex-line-pack:end!important;align-content:flex-end!important}.align-content-lg-center{-ms-flex-line-pack:center!important;align-content:center!important}.align-content-lg-between{-ms-flex-line-pack:justify!important;align-content:space-between!important}.align-content-lg-around{-ms-flex-line-pack:distribute!important;align-content:space-around!important}.align-content-lg-stretch{-ms-flex-line-pack:stretch!important;align-content:stretch!important}.align-self-lg-auto{-ms-flex-item-align:auto!important;align-self:auto!important}.align-self-lg-start{-ms-flex-item-align:start!important;align-self:flex-start!important}.align-self-lg-end{-ms-flex-item-align:end!important;align-self:flex-end!important}.align-self-lg-center{-ms-flex-item-align:center!important;align-self:center!important}.align-self-lg-baseline{-ms-flex-item-align:baseline!important;align-self:baseline!important}.align-self-lg-stretch{-ms-flex-item-align:stretch!important;align-self:stretch!important}}@media (min-width:1200px){.flex-xl-row{-ms-flex-direction:row!important;flex-direction:row!important}.flex-xl-column{-ms-flex-direction:column!important;flex-direction:column!important}.flex-xl-row-reverse{-ms-flex-direction:row-reverse!important;flex-direction:row-reverse!important}.flex-xl-column-reverse{-ms-flex-direction:column-reverse!important;flex-direction:column-reverse!important}.flex-xl-wrap{-ms-flex-wrap:wrap!important;flex-wrap:wrap!important}.flex-xl-nowrap{-ms-flex-wrap:nowrap!important;flex-wrap:nowrap!important}.flex-xl-wrap-reverse{-ms-flex-wrap:wrap-reverse!important;flex-wrap:wrap-reverse!important}.flex-xl-fill{-ms-flex:1 1 auto!important;flex:1 1 auto!important}.flex-xl-grow-0{-ms-flex-positive:0!important;flex-grow:0!important}.flex-xl-grow-1{-ms-flex-positive:1!important;flex-grow:1!important}.flex-xl-shrink-0{-ms-flex-negative:0!important;flex-shrink:0!important}.flex-xl-shrink-1{-ms-flex-negative:1!important;flex-shrink:1!important}.justify-content-xl-start{-ms-flex-pack:start!important;justify-content:flex-start!important}.justify-content-xl-end{-ms-flex-pack:end!important;justify-content:flex-end!important}.justify-content-xl-center{-ms-flex-pack:center!important;justify-content:center!important}.justify-content-xl-between{-ms-flex-pack:justify!important;justify-content:space-between!important}.justify-content-xl-around{-ms-flex-pack:distribute!important;justify-content:space-around!important}.align-items-xl-start{-ms-flex-align:start!important;align-items:flex-start!important}.align-items-xl-end{-ms-flex-align:end!important;align-items:flex-end!important}.align-items-xl-center{-ms-flex-align:center!important;align-items:center!important}.align-items-xl-baseline{-ms-flex-align:baseline!important;align-items:baseline!important}.align-items-xl-stretch{-ms-flex-align:stretch!important;align-items:stretch!important}.align-content-xl-start{-ms-flex-line-pack:start!important;align-content:flex-start!important}.align-content-xl-end{-ms-flex-line-pack:end!important;align-content:flex-end!important}.align-content-xl-center{-ms-flex-line-pack:center!important;align-content:center!important}.align-content-xl-between{-ms-flex-line-pack:justify!important;align-content:space-between!important}.align-content-xl-around{-ms-flex-line-pack:distribute!important;align-content:space-around!important}.align-content-xl-stretch{-ms-flex-line-pack:stretch!important;align-content:stretch!important}.align-self-xl-auto{-ms-flex-item-align:auto!important;align-self:auto!important}.align-self-xl-start{-ms-flex-item-align:start!important;align-self:flex-start!important}.align-self-xl-end{-ms-flex-item-align:end!important;align-self:flex-end!important}.align-self-xl-center{-ms-flex-item-align:center!important;align-self:center!important}.align-self-xl-baseline{-ms-flex-item-align:baseline!important;align-self:baseline!important}.align-self-xl-stretch{-ms-flex-item-align:stretch!important;align-self:stretch!important}}

{# /* // Swiper 4.4.2 */ #}

.swiper-container{width:100%;margin:0 auto;position:relative;overflow:hidden;list-style:none;padding:0;z-index:1}.swiper-container-no-flexbox .swiper-slide{float:left}.swiper-container-vertical>.swiper-wrapper{-webkit-box-orient:vertical;-webkit-box-direction:normal;-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column}.swiper-wrapper{position:relative;width:100%;height:100%;z-index:1;display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;-webkit-transition-property:-webkit-transform;transition-property:-webkit-transform;-o-transition-property:transform;transition-property:transform;transition-property:transform,-webkit-transform;-webkit-box-sizing:content-box;box-sizing:content-box}.swiper-container-android .swiper-slide,.swiper-wrapper{-webkit-transform:translate3d(0,0,0);transform:translate3d(0,0,0)}.swiper-container-multirow>.swiper-wrapper{-webkit-flex-wrap:wrap;-ms-flex-wrap:wrap;flex-wrap:wrap}.swiper-container-free-mode>.swiper-wrapper{-webkit-transition-timing-function:ease-out;-o-transition-timing-function:ease-out;transition-timing-function:ease-out;margin:0 auto}.swiper-slide{-webkit-flex-shrink:0;-ms-flex-negative:0;flex-shrink:0;width:100%;height:100%;position:relative;-webkit-transition-property:-webkit-transform;transition-property:-webkit-transform;-o-transition-property:transform;transition-property:transform;transition-property:transform,-webkit-transform}.swiper-slide-invisible-blank{visibility:hidden}.swiper-container-autoheight,.swiper-container-autoheight .swiper-slide{height:auto}.swiper-container-autoheight .swiper-wrapper{-webkit-box-align:start;-webkit-align-items:flex-start;-ms-flex-align:start;align-items:flex-start;-webkit-transition-property:height,-webkit-transform;transition-property:height,-webkit-transform;-o-transition-property:transform,height;transition-property:transform,height;transition-property:transform,height,-webkit-transform}.swiper-container-3d{-webkit-perspective:1200px;perspective:1200px}.swiper-container-3d .swiper-cube-shadow,.swiper-container-3d .swiper-slide,.swiper-container-3d .swiper-slide-shadow-bottom,.swiper-container-3d .swiper-slide-shadow-left,.swiper-container-3d .swiper-slide-shadow-right,.swiper-container-3d .swiper-slide-shadow-top,.swiper-container-3d .swiper-wrapper{-webkit-transform-style:preserve-3d;transform-style:preserve-3d}.swiper-container-3d .swiper-slide-shadow-bottom,.swiper-container-3d .swiper-slide-shadow-left,.swiper-container-3d .swiper-slide-shadow-right,.swiper-container-3d .swiper-slide-shadow-top{position:absolute;left:0;top:0;width:100%;height:100%;pointer-events:none;z-index:10}.swiper-container-3d .swiper-slide-shadow-left{background-image:-webkit-gradient(linear,right top,left top,from(rgba(0,0,0,.5)),to(rgba(0,0,0,0)));background-image:-webkit-linear-gradient(right,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:-o-linear-gradient(right,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:linear-gradient(to left,rgba(0,0,0,.5),rgba(0,0,0,0))}.swiper-container-3d .swiper-slide-shadow-right{background-image:-webkit-gradient(linear,left top,right top,from(rgba(0,0,0,.5)),to(rgba(0,0,0,0)));background-image:-webkit-linear-gradient(left,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:-o-linear-gradient(left,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:linear-gradient(to right,rgba(0,0,0,.5),rgba(0,0,0,0))}.swiper-container-3d .swiper-slide-shadow-top{background-image:-webkit-gradient(linear,left bottom,left top,from(rgba(0,0,0,.5)),to(rgba(0,0,0,0)));background-image:-webkit-linear-gradient(bottom,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:-o-linear-gradient(bottom,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:linear-gradient(to top,rgba(0,0,0,.5),rgba(0,0,0,0))}.swiper-container-3d .swiper-slide-shadow-bottom{background-image:-webkit-gradient(linear,left top,left bottom,from(rgba(0,0,0,.5)),to(rgba(0,0,0,0)));background-image:-webkit-linear-gradient(top,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:-o-linear-gradient(top,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:linear-gradient(to bottom,rgba(0,0,0,.5),rgba(0,0,0,0))}.swiper-container-wp8-horizontal,.swiper-container-wp8-horizontal>.swiper-wrapper{-ms-touch-action:pan-y;touch-action:pan-y}.swiper-container-wp8-vertical,.swiper-container-wp8-vertical>.swiper-wrapper{-ms-touch-action:pan-x;touch-action:pan-x}.swiper-button-next,.swiper-button-prev{position:absolute;top:50%;z-index:10;width:30px;height:40px;margin-top:-20px;line-height:40px;color:#fff;text-align:center;cursor:pointer}.swiper-button-next.swiper-button-disabled,.swiper-button-prev.swiper-button-disabled{opacity:.35;cursor:auto;pointer-events:none}.swiper-button-prev,.swiper-container-rtl .swiper-button-next{left:10px;right:auto}.swiper-button-next,.swiper-container-rtl .swiper-button-prev{right:10px;left:auto}.swiper-button-lock{display:none}.swiper-pagination{position:absolute;text-align:center;-webkit-transition:.3s opacity;-o-transition:.3s opacity;transition:.3s opacity;-webkit-transform:translate3d(0,0,0);transform:translate3d(0,0,0);z-index:10}.swiper-pagination.swiper-pagination-hidden{opacity:0}.swiper-container-horizontal>.swiper-pagination-bullets,.swiper-pagination-custom,.swiper-pagination-fraction{bottom:20px;left:0;width:100%}.swiper-pagination-bullets-dynamic{overflow:hidden;font-size:0}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet{-webkit-transform:scale(.33);-ms-transform:scale(.33);transform:scale(.33);position:relative}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active{-webkit-transform:scale(1);-ms-transform:scale(1);transform:scale(1)}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-main{-webkit-transform:scale(1);-ms-transform:scale(1);transform:scale(1)}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-prev{-webkit-transform:scale(.66);-ms-transform:scale(.66);transform:scale(.66)}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-prev-prev{-webkit-transform:scale(.33);-ms-transform:scale(.33);transform:scale(.33)}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-next{-webkit-transform:scale(.66);-ms-transform:scale(.66);transform:scale(.66)}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-next-next{-webkit-transform:scale(.33);-ms-transform:scale(.33);transform:scale(.33)}.swiper-pagination-bullet{width:8px;height:8px;display:inline-block;border-radius:100%;background:#000;opacity:.2}button.swiper-pagination-bullet{border:none;margin:0;padding:0;-webkit-box-shadow:none;box-shadow:none;-webkit-appearance:none;-moz-appearance:none;appearance:none}.swiper-pagination-clickable .swiper-pagination-bullet{cursor:pointer}.swiper-pagination-bullet-active{opacity:1;background:#007aff}.swiper-container-vertical>.swiper-pagination-bullets{right:10px;top:50%;-webkit-transform:translate3d(0,-50%,0);transform:translate3d(0,-50%,0)}.swiper-container-vertical>.swiper-pagination-bullets .swiper-pagination-bullet{margin:6px 0;display:block}.swiper-container-vertical>.swiper-pagination-bullets.swiper-pagination-bullets-dynamic{top:50%;-webkit-transform:translateY(-50%);-ms-transform:translateY(-50%);transform:translateY(-50%);width:8px}.swiper-container-vertical>.swiper-pagination-bullets.swiper-pagination-bullets-dynamic .swiper-pagination-bullet{display:inline-block;-webkit-transition:.2s top,.2s -webkit-transform;transition:.2s top,.2s -webkit-transform;-o-transition:.2s transform,.2s top;transition:.2s transform,.2s top;transition:.2s transform,.2s top,.2s -webkit-transform}.swiper-container-horizontal>.swiper-pagination-bullets .swiper-pagination-bullet{margin:0 4px}.swiper-container-horizontal>.swiper-pagination-bullets.swiper-pagination-bullets-dynamic{left:50%;-webkit-transform:translateX(-50%);-ms-transform:translateX(-50%);transform:translateX(-50%);white-space:nowrap}.swiper-container-horizontal>.swiper-pagination-bullets.swiper-pagination-bullets-dynamic .swiper-pagination-bullet{-webkit-transition:.2s left,.2s -webkit-transform;transition:.2s left,.2s -webkit-transform;-o-transition:.2s transform,.2s left;transition:.2s transform,.2s left;transition:.2s transform,.2s left,.2s -webkit-transform}.swiper-container-horizontal.swiper-container-rtl>.swiper-pagination-bullets-dynamic .swiper-pagination-bullet{-webkit-transition:.2s right,.2s -webkit-transform;transition:.2s right,.2s -webkit-transform;-o-transition:.2s transform,.2s right;transition:.2s transform,.2s right;transition:.2s transform,.2s right,.2s -webkit-transform}.swiper-pagination-progressbar{background:rgba(0,0,0,.25);position:absolute}.swiper-pagination-progressbar .swiper-pagination-progressbar-fill{background:#007aff;position:absolute;left:0;top:0;width:100%;height:100%;-webkit-transform:scale(0);-ms-transform:scale(0);transform:scale(0);-webkit-transform-origin:left top;-ms-transform-origin:left top;transform-origin:left top}.swiper-container-rtl .swiper-pagination-progressbar .swiper-pagination-progressbar-fill{-webkit-transform-origin:right top;-ms-transform-origin:right top;transform-origin:right top}.swiper-container-horizontal>.swiper-pagination-progressbar,.swiper-container-vertical>.swiper-pagination-progressbar.swiper-pagination-progressbar-opposite{width:100%;height:4px;left:0;top:0}.swiper-container-horizontal>.swiper-pagination-progressbar.swiper-pagination-progressbar-opposite,.swiper-container-vertical>.swiper-pagination-progressbar{width:4px;height:100%;left:0;top:0}.swiper-pagination-white .swiper-pagination-bullet-active{background:#fff}.swiper-pagination-progressbar.swiper-pagination-white{background:rgba(255,255,255,.25)}.swiper-pagination-progressbar.swiper-pagination-white .swiper-pagination-progressbar-fill{background:#fff}.swiper-pagination-black .swiper-pagination-bullet-active{background:#000}.swiper-pagination-progressbar.swiper-pagination-black{background:rgba(0,0,0,.25)}.swiper-pagination-progressbar.swiper-pagination-black .swiper-pagination-progressbar-fill{background:#000}.swiper-pagination-lock{display:none}.swiper-lazy-preloader{width:42px;height:42px;position:absolute;left:50%;top:50%;margin-left:-21px;margin-top:-21px;z-index:10;-webkit-transform-origin:50%;-ms-transform-origin:50%;transform-origin:50%;-webkit-animation:swiper-preloader-spin 1s steps(12,end) infinite;animation:swiper-preloader-spin 1s steps(12,end) infinite}.swiper-lazy-preloader:after{display:block;content:'';width:100%;height:100%;background-image:url("data:image/svg+xml;charset=utf-8,%3Csvg%20viewBox%3D'0%200%20120%20120'%20xmlns%3D'http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg'%20xmlns%3Axlink%3D'http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink'%3E%3Cdefs%3E%3Cline%20id%3D'l'%20x1%3D'60'%20x2%3D'60'%20y1%3D'7'%20y2%3D'27'%20stroke%3D'%236c6c6c'%20stroke-width%3D'11'%20stroke-linecap%3D'round'%2F%3E%3C%2Fdefs%3E%3Cg%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(30%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(60%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(90%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(120%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(150%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.37'%20transform%3D'rotate(180%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.46'%20transform%3D'rotate(210%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.56'%20transform%3D'rotate(240%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.66'%20transform%3D'rotate(270%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.75'%20transform%3D'rotate(300%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.85'%20transform%3D'rotate(330%2060%2C60)'%2F%3E%3C%2Fg%3E%3C%2Fsvg%3E");background-position:50%;background-size:100%;background-repeat:no-repeat}.swiper-lazy-preloader-white:after{background-image:url("data:image/svg+xml;charset=utf-8,%3Csvg%20viewBox%3D'0%200%20120%20120'%20xmlns%3D'http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg'%20xmlns%3Axlink%3D'http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink'%3E%3Cdefs%3E%3Cline%20id%3D'l'%20x1%3D'60'%20x2%3D'60'%20y1%3D'7'%20y2%3D'27'%20stroke%3D'%23fff'%20stroke-width%3D'11'%20stroke-linecap%3D'round'%2F%3E%3C%2Fdefs%3E%3Cg%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(30%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(60%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(90%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(120%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(150%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.37'%20transform%3D'rotate(180%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.46'%20transform%3D'rotate(210%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.56'%20transform%3D'rotate(240%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.66'%20transform%3D'rotate(270%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.75'%20transform%3D'rotate(300%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.85'%20transform%3D'rotate(330%2060%2C60)'%2F%3E%3C%2Fg%3E%3C%2Fsvg%3E")}@-webkit-keyframes swiper-preloader-spin{100%{-webkit-transform:rotate(360deg);transform:rotate(360deg)}}@keyframes swiper-preloader-spin{100%{-webkit-transform:rotate(360deg);transform:rotate(360deg)}}.swiper-container-fade.swiper-container-free-mode .swiper-slide{-webkit-transition-timing-function:ease-out;-o-transition-timing-function:ease-out;transition-timing-function:ease-out}.swiper-container-fade .swiper-slide{pointer-events:none;-webkit-transition-property:opacity;-o-transition-property:opacity;transition-property:opacity}.swiper-container-fade .swiper-slide .swiper-slide{pointer-events:none}.swiper-container-fade .swiper-slide-active,.swiper-container-fade .swiper-slide-active .swiper-slide-active{pointer-events:auto}

/*============================================================================
  #Critical path helpers
==============================================================================*/

/* Hidden general content until rest of styling loads */
.visible-when-content-ready{
	visibility: hidden!important;
}
.display-when-content-ready{
	display: none!important;
}

/* Home V2: garante visibilidade mesmo se CSS async falhar */
body.template-home .visible-when-content-ready{
	visibility: visible!important;
}
body.template-home .pg-hero-v2,
body.template-home .pg-section--grid-bg{
	visibility: visible!important;
}

/*============================================================================
  #Components
==============================================================================*/

{# /* // Wrappers */ #}

:root {
  --pg-color-primary: #EAFE67;
  --pg-color-primary-dark: #D4E856;
  --pg-color-black: #000000;
  --pg-color-gray-dark: #4A4A4A;
  --pg-color-gray-light: #E0E0E0;
  --pg-color-gray-lighter: #F5F5F5;
  --pg-radius-pill: 999px;
  --pg-radius-card: 24px;
  --pg-spacing-1: 4px;
  --pg-spacing-2: 8px;
  --pg-spacing-3: 12px;
  --pg-spacing-4: 16px;
  --pg-spacing-5: 20px;
  --pg-spacing-6: 24px;
  --pg-spacing-7: 32px;
  --pg-spacing-8: 40px;
  --pg-font-display: 'Familjen Grotesk', {{ settings.font_headings | default("'Muli', sans-serif") | raw }};
  --pg-font-body: 'Familjen Grotesk', {{ settings.font_rest | raw }};
}

body{
  margin: 0;
  font-size: 12px;
  font-family: var(--pg-font-body);
  color: var(--pg-color-black);
}

.pg-container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 var(--pg-spacing-4);
}

.pg-section {
  padding: var(--pg-spacing-7) 0;
}

.pg-tagline {
  display: inline-flex;
  align-items: center;
  gap: var(--pg-spacing-2);
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--pg-color-black);
}

.pg-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-height: 48px;
  padding: 0 var(--pg-spacing-7);
  border-radius: var(--pg-radius-pill);
  font-weight: 700;
  font-size: 1rem;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  transition: all 0.3s ease;
  cursor: pointer;
  border: none;
}

.pg-button--primary {
  background: var(--pg-color-black);
  color: #fff;
}

.pg-button--primary:hover {
  background: var(--pg-color-gray-dark);
  transform: translateY(-2px);
}

.pg-grid {
  display: grid;
  gap: var(--pg-spacing-5);
}

.pg-grid--products {
  grid-template-columns: repeat(1, 1fr);
}

@media (min-width: 600px) {
  .pg-grid--products {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1024px) {
  .pg-grid--products {
    grid-template-columns: repeat(3, 1fr);
  }
}

.pg-hero {
  position: relative;
  background: #000;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  overflow: hidden;
}

.pg-hero__media {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 1;
}

.pg-hero__media::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.3);
  z-index: 2;
}

.pg-hero__media img {
  width: 100%;
  height: 100%;
  object-fit: contain !important; /* Forçando contain para mostrar imagem completa */
  object-position: center center !important; /* Centralizando imagem */
  display: block;
  filter: grayscale(100%);
  opacity: 0.7;
}

.pg-hero__content {
  position: relative;
  z-index: 3;
  text-align: center;
  padding: var(--pg-spacing-7) var(--pg-spacing-4);
  color: #fff;
}

.pg-hero__tagline {
  font-size: 0.75rem;
  font-weight: 400;
  letter-spacing: 0.05em;
  margin: 0 0 var(--pg-spacing-2);
  text-transform: uppercase;
}

.pg-hero__title {
  font-family: var(--pg-font-display);
  font-size: 4.5rem;
  font-weight: 900;
  line-height: 0.85;
  margin: 0;
  text-transform: uppercase;
  font-style: italic;
  color: var(--pg-color-primary);
  letter-spacing: -0.02em;
}

.pg-hero__subtitle {
  font-size: 1rem;
  font-weight: 300;
  letter-spacing: 0.05em;
  margin: 0 0 var(--pg-spacing-4);
  text-transform: uppercase;
}

.pg-hero__description {
  font-size: 0.7rem;
  line-height: 1.5;
  max-width: 280px;
  margin: 0 auto var(--pg-spacing-6);
  letter-spacing: 0.03em;
}

.pg-hero__description strong {
  font-weight: 700;
}

.pg-hero__cta {
  margin-bottom: var(--pg-spacing-6);
}

.pg-hero__cta .pg-button--primary {
  background: var(--pg-color-primary);
  color: var(--pg-color-black);
  padding: var(--pg-spacing-4) var(--pg-spacing-6);
  font-size: 0.875rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  border-radius: 8px;
}

.pg-hero__arrow {
  display: flex;
  justify-content: center;
  animation: bounce 2s infinite;
}

.pg-hero__arrow img {
  filter: brightness(0) invert(1);
}

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

{# /* // Header Patagang */ #}

.pg-header {
  background: transparent;
  border-bottom: none;
  position: absolute;
  top: 30px; /* AJUSTADO: Espaço para banner fixo no topo */
  left: 0;
  right: 0;
  z-index: 9999;
  /* CORRIGIDO 26/11: Altura mínima para garantir área clicável completa */
  min-height: 70px;
  padding-top: 12px; /* Espaçamento superior para afastar do topo */
}

.pg-header--sticky {
  position: fixed;
  top: 30px !important; /* SOLUÇÃO DEFINITIVA: Espaço para banner fixo (28-30px) */
}

.pg-header__container {
  padding: 0;
  height: 100%;
}

.pg-header__row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  position: relative;
  gap: var(--pg-spacing-3);
  height: 100%;
  min-height: 46px; /* Altura mínima para conter os botões */
}

.pg-header__icon-button {
  /* CORRIGIDO 26/11: Solução definitiva para área clicável */
  box-sizing: border-box;
  width: 44px; /* Aumentado para 44px */
  height: 44px; /* Aumentado para 44px */
  min-width: 44px;
  min-height: 44px;
  border-radius: 6px;
  border: 1px solid rgba(0, 0, 0, 0.08);
  background: rgba(255, 255, 255, 0.35);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  padding: 0; /* REMOVIDO padding - ícone centralizado apenas com flexbox */
  position: relative;
  z-index: 10;
  /* CRITICAL: Garante cliques em toda a área */
  isolation: isolate; /* Cria novo contexto de empilhamento */
}

.pg-header__icon-button:hover {
  background: rgba(255, 255, 255, 0.5);
  border-color: rgba(0, 0, 0, 0.15);
}

.pg-header__icon-button img {
  /* CORRIGIDO 26/11: Ícones menores e centralizados para evitar conflito de área clicável */
  filter: none;
  width: 18px; /* Reduzido de 20px para 18px */
  height: 18px; /* Reduzido de 20px para 18px */
  display: block;
  pointer-events: none; /* Cliques passam para o botão pai */
  flex-shrink: 0;
}

.pg-header__logo {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 34px;
  overflow: hidden;
  z-index: 1;
}

.pg-header__logo-img {
  max-height: 34px;
  height: auto;
  width: auto;
  /* AJUSTADO: Remover filtro para logo preto conforme protótipo */
  filter: none;
  transition: transform 0.4s ease, opacity 0.4s ease;
  transform: translateY(0);
}

.pg-header__logo-img--hover {
  position: absolute;
  top: 0;
  left: 0;
  transform: translateY(-100%);
  max-height: 34px;
  height: auto;
  width: auto;
  transition: transform 0.4s ease, opacity 0.4s ease;
  filter: none;
}

.pg-header__logo:hover .pg-header__logo-img {
  transform: translateY(100%);
  opacity: 0;
}

.pg-header__logo:hover .pg-header__logo-img--hover {
  transform: translateY(0);
}

.pg-header__actions {
  display: flex;
  align-items: center;
  gap: var(--pg-spacing-2);
  height: 100%;
}

.pg-header__cart-count {
  position: absolute;
  top: -4px;
  right: -4px;
  background: var(--pg-color-black); /* AJUSTADO: Preto discreto (opção 2) */
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

/* ===========================================
   MOBILE HEADER FIX
   =========================================== */
@media (max-width: 767px) {

  /* Logo centralizada */
  .pg-header__logo {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    z-index: 5;
  }

  /* Remover highlight azul ao tocar (Safari/iOS/Android) */
  .pg-header__icon-button {
    -webkit-tap-highlight-color: transparent !important;
    -webkit-tap-highlight-color: rgba(0,0,0,0) !important;
  }

  /* Forçar apenas STROKE nos SVGs dos botões */
  .pg-header__icon-button svg {
    fill: none !important;
    stroke: currentColor !important;
    color: var(--pg-color-black) !important;
  }

  .pg-header__icon-button:active,
  .pg-header__icon-button:focus,
  .pg-header__icon-button:visited {
    color: var(--pg-color-black) !important;
    background-color: transparent !important;
    outline: none !important;
    border: none !important;
  }

  .pg-header__icon-button:active svg,
  .pg-header__icon-button:focus svg {
    fill: none !important;
    stroke: currentColor !important;
    color: var(--pg-color-black) !important;
  }
}

/* ============================================
   PataGang Search Overlay
   ============================================ */

.pg-search-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 9999;
  display: none;
  flex-direction: column;
}

.pg-search-overlay.is-active {
  display: flex;
}

/* Body lock quando overlay aberto */
body.pg-search-overlay-open {
  overflow: hidden;
}

/* Backdrop semi-transparente */
.pg-search-overlay__backdrop {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.4);
  z-index: 1;
}

/* Painel principal - desliza do topo */
.pg-search-overlay__panel {
  position: relative;
  z-index: 2;
  background: #E2E2E2;
  max-height: 85vh;
  overflow-y: auto;
  animation: pgSearchSlideDown 0.25s ease-out;
}

@keyframes pgSearchSlideDown {
  from { transform: translateY(-20px); opacity: 0; }
  to { transform: translateY(0); opacity: 1; }
}

/* Barra superior com fechar */
.pg-search-overlay__topbar {
  display: flex;
  justify-content: flex-end;
  padding: 12px 24px;
}

.pg-search-overlay__close {
  background: none;
  border: none;
  cursor: pointer;
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 14px;
  font-weight: 600;
  color: var(--pg-color-black);
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px;
}

.pg-search-overlay__close:hover {
  opacity: 0.7;
}

/* Desktop: "Fechar" texto. Mobile: X ícone */
.pg-search-overlay__close-icon { display: none; }

/* Wrapper do form */
.pg-search-overlay__form-wrapper {
  max-width: 720px;
  margin: 0 auto;
  padding: 0 24px 32px;
  width: 100%;
  position: relative;
}

.pg-search-overlay__form {
  margin: 0;
}

.pg-search-overlay__input-group {
  display: flex;
  align-items: center;
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  border: 1px solid rgba(0, 0, 0, 0.1);
  border-radius: 28px;
  overflow: hidden;
  height: 52px;
}

.pg-search-overlay__input {
  flex: 1;
  height: 100%;
  padding: 0 20px;
  border: none;
  background: transparent;
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 16px;
  color: var(--pg-color-black);
  outline: none;
}

.pg-search-overlay__input::placeholder {
  color: #888;
  font-weight: 400;
}

.pg-search-overlay__submit {
  width: 52px;
  height: 52px;
  flex-shrink: 0;
  background: transparent;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--pg-color-black);
}

.pg-search-overlay__submit:hover {
  opacity: 0.7;
}

/* Sugestões AJAX */
.pg-search-overlay__suggestions {
  margin-top: 16px;
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(8px);
  border-radius: 12px;
  overflow: hidden;
}

.pg-search-overlay__suggestions .search-suggest-list {
  margin: 0;
  padding: 12px 0;
  list-style: none;
}

.pg-search-overlay__suggestions .search-suggest-item {
  padding: 10px 20px;
}

.pg-search-overlay__suggestions .search-suggest-link {
  display: flex;
  align-items: center;
  gap: 12px;
  text-decoration: none;
  color: var(--pg-color-black);
}

.pg-search-overlay__suggestions .search-suggest-image {
  width: 48px;
  height: 48px;
  object-fit: cover;
  border-radius: 8px;
}

.pg-search-overlay__suggestions .js-search-suggest-all-link {
  display: block;
  text-align: center;
  padding: 14px;
  font-weight: 600;
  font-size: 14px;
  background: var(--pg-color-black);
  color: #fff;
  text-decoration: none;
  border-radius: 0 0 12px 12px;
  margin-top: 4px;
}

/* Conteúdo default: colunas */
.pg-search-overlay__default-content {
  max-width: 1000px;
  margin: 0 auto;
  padding: 16px 24px 40px;
}

.pg-search-overlay__columns {
  display: flex;
  gap: 48px;
}

.pg-search-overlay__col--tags {
  flex: 0 0 200px;
}

.pg-search-overlay__col--products {
  flex: 1;
  min-width: 0;
}

.pg-search-overlay__section-title {
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 14px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.04em;
  margin: 0 0 16px 0;
  color: var(--pg-color-black);
}

/* Tags / chips de busca rápida */
.pg-search-overlay__tags {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.pg-search-overlay__tag {
  display: block;
  padding: 8px 0;
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 14px;
  font-weight: 400;
  color: var(--pg-color-black);
  text-decoration: none;
  transition: color 0.2s;
}

.pg-search-overlay__tag:hover {
  color: #666;
}

/* Carrossel de produtos */
.pg-search-overlay__products-carousel {
  display: flex;
  gap: 16px;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  -webkit-overflow-scrolling: touch;
  padding-bottom: 8px;
  scrollbar-width: none;
}

.pg-search-overlay__products-carousel::-webkit-scrollbar {
  display: none;
}

.pg-search-overlay__product-card {
  flex: 0 0 160px;
  scroll-snap-align: start;
  text-decoration: none;
  color: var(--pg-color-black);
  transition: transform 0.2s;
}

.pg-search-overlay__product-card:hover {
  transform: translateY(-2px);
}

.pg-search-overlay__product-img {
  width: 160px;
  height: 160px;
  border-radius: 12px;
  overflow: hidden;
  background: rgba(255, 255, 255, 0.5);
  margin-bottom: 8px;
}

.pg-search-overlay__product-img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.pg-search-overlay__product-name {
  font-size: 12px;
  font-weight: 500;
  margin: 0 0 2px;
  line-height: 1.3;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.pg-search-overlay__product-price {
  font-size: 13px;
  font-weight: 700;
  margin: 0;
}

.pg-search-overlay__product-price--compare {
  font-weight: 400;
  font-size: 12px;
}

.pg-search-overlay__product-price--compare strong {
  font-weight: 700;
  font-size: 13px;
}

.pg-search-overlay__empty {
  font-size: 13px;
  color: #888;
  margin: 0;
}

/* ============================================
   SEARCH OVERLAY - Mobile (< 768px)
   ============================================ */
@media (max-width: 767px) {
  .pg-search-overlay__panel {
    max-height: 100vh;
    min-height: 100vh;
  }

  .pg-search-overlay__close-text { display: none; }
  .pg-search-overlay__close-icon {
    display: block;
    font-size: 28px;
    line-height: 1;
  }

  .pg-search-overlay__topbar {
    padding: 12px 16px;
  }

  .pg-search-overlay__form-wrapper {
    padding: 0 16px 24px;
  }

  .pg-search-overlay__default-content {
    padding: 12px 16px 32px;
  }

  .pg-search-overlay__columns {
    flex-direction: column;
    gap: 24px;
  }

  .pg-search-overlay__col--tags {
    flex: none;
  }

  /* Tags scrollam horizontal no mobile */
  .pg-search-overlay__tags {
    flex-direction: row;
    flex-wrap: nowrap;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
    scrollbar-width: none;
    gap: 8px;
    padding-bottom: 4px;
  }

  .pg-search-overlay__tags::-webkit-scrollbar { display: none; }

  .pg-search-overlay__tag {
    display: inline-block;
    padding: 8px 16px;
    border-radius: 20px;
    background: rgba(255, 255, 255, 0.5);
    border: 1px solid rgba(0, 0, 0, 0.08);
    white-space: nowrap;
    font-size: 13px;
  }

  .pg-search-overlay__product-card {
    flex: 0 0 130px;
  }

  .pg-search-overlay__product-img {
    width: 130px;
    height: 130px;
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
.preloader-bg-img,
.product-slider-image.blur-up{
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
.product-slider-image.blur-up{
  left: 50%;
  width: auto;
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

/* WhatsApp Left - Vertical Centered (Side Tab) - Design alinhado ao botão AJUDA? */
.btn-whatsapp-left {
    position: fixed;
    top: 50%;
    left: 0;
    transform: translateY(-50%);
    z-index: 9990;
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #EAFE67; /* Store Yellow - mesmo do AJUDA? */
    border: none;
    border-radius: 0 4px 4px 0; /* Arredondado apenas na direita */
    padding: 12px 8px;
    box-shadow: 2px 0 8px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
    text-decoration: none !important;
    gap: 8px;
}

.btn-whatsapp-left:hover {
    transform: translateY(-50%) translateX(2px);
    box-shadow: 4px 0 12px rgba(0,0,0,0.15);
    background-color: #d4e65d; /* Mesmo hover do AJUDA? */
}

.btn-whatsapp-left svg {
    width: 20px;
    height: 20px;
    fill: #25D366; /* Verde oficial WhatsApp - reconhecimento de marca */
    padding: 0;
}

.btn-whatsapp-left span {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 12px;
    font-weight: 500;
    color: #1A1A1A;
    letter-spacing: 0.03em;
    text-transform: uppercase;
    writing-mode: vertical-rl;
    text-orientation: mixed;
    transform: rotate(180deg);
    white-space: nowrap;
}

/* Mobile: Ajustes para não ocupar muito espaço vertical */
@media (max-width: 480px) {
    .btn-whatsapp-left {
        padding: 10px 6px;
    }
    .btn-whatsapp-left svg {
        width: 18px;
        height: 18px;
    }
    .btn-whatsapp-left span {
        font-size: 11px;
    }
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

/* Títulos de páginas de texto - Estilo suave e menos chamativo */
.pg-page__title,
.pg-movimento__title,
h1.pg-page__title,
h1.pg-movimento__title {
  font-size: 30px !important;
  text-align: center;
  margin-bottom: 30px;
  font-family: 'Familjen Grotesk', sans-serif !important;
  font-weight: 400 !important; /* Removido negrito - estava muito chamativo */
  color: #333 !important; /* Cinza escuro ao invés de preto puro */
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
  font-size: 12px!important;
}
.font-smallest {
  font-size: 11px!important;
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
  transform: translate3d(0px, 0, 0) !important;
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
  transform: translateX(-50%)!important;
  -webkit-transform: translateX(-50%)!important;
  -ms-transform: translateX(-50%)!important;
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

.section-advertising {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  width: 100%;
  z-index: 10000; /* Acima do header (9999) */
  padding: calc(var(--ad-bar-height) / 2) 8px; /* Responsivo: usa variável clamp */

  /* Design Patagang - mesmo amarelo dos botões da home (Vista o Propósito / Produtos para Cachorro) */
  background: #EAFE67 !important;
  color: #000000;
  font-size: clamp(9px, 1.2vw + 7px, 12px); /* Proporcional no mobile; teto 12px */
  font-weight: 600;
  letter-spacing: 0.5px;
  text-align: center;
}

/* Header: offset igual à altura da barra quando aviso está ativo */
body.has-ad-bar .pg-header {
  padding-top: var(--ad-bar-height) !important;
}

.section-advertising a {
  color: #000000 !important;
  font-weight: 700;
  text-decoration: none;
  transition: opacity 0.3s ease;
}

.section-advertising a:hover {
  opacity: 0.85;
}

/* Banner fixo - estrutura original, sem animação de rolagem */
.section-advertising__marquee {
  overflow: visible;
  width: 100%;
  padding: 0 12px; /* Evita texto cortado nas bordas no mobile */
}

.section-advertising__track {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}

.section-advertising__copy {
  flex-shrink: 0;
  white-space: pre;
}

.section-advertising__sep {
  margin-left: 5em;
  margin-right: 5em;
  flex-shrink: 0;
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
  text-align: center;
}

.service-icon {
  margin: 10px 0;
}

.service-item .service-icon-big {
  font-size: 30px;
}

.service-title {
  margin: 0 0 5px 0;
}

.service-pagination {
  position: relative;
  margin-top: 5px;
}

/*============================================================================
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

/* ============================================================================
   PATAGANG - Seção de Produtos Similares (V3 - Alinhado com grid categoria)
   Usa classes pg-card V3 geradas por item.tpl
============================================================================ */

.section-products-related {
  padding: 40px 0 60px;
  background-color: #E2E2E2 !important;
}

.section-products-related .h3,
.section-products-related .title {
  margin-bottom: 28px;
  font-size: 1.4rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: #000;
}

/* Card pg-card V3 — mesmo visual do grid de categoria/busca */
.section-products-related .pg-card {
  background: #FFFFFF;
  border-radius: 16px;
  padding: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
  border: 1px solid rgba(0, 0, 0, 0.06);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  text-align: center;
  height: auto !important;
  min-height: auto !important;
  margin-bottom: 0 !important;
}

.section-products-related .pg-card:hover {
  transform: translateY(-6px);
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.12);
}

/* Imagem — 1:1, contain */
.section-products-related .pg-card__image {
  background: #F9F9F9;
  border-radius: 12px;
  overflow: hidden;
  aspect-ratio: 1 / 1;
  margin-bottom: 6px;
}

.section-products-related .pg-card__image-container {
  border-radius: 12px;
  overflow: hidden;
}

.section-products-related .pg-card__image-container > div {
  padding-bottom: 100% !important;
}

.section-products-related .pg-card__image-container img {
  width: 100% !important;
  height: 100% !important;
  object-fit: contain;
  object-position: center;
  transition: transform 0.3s ease;
}

.section-products-related .pg-card:hover .pg-card__image-container img {
  transform: scale(1.05);
}

/* Info */
.section-products-related .pg-card__info {
  padding: 4px 4px 0;
  text-align: center;
}

.section-products-related .pg-card__name {
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 12px;
  font-weight: 600;
  line-height: 1.3;
  color: #000;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin: 0 0 4px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  min-height: 31px;
}

.section-products-related .pg-card__price {
  display: flex;
  align-items: baseline;
  justify-content: center;
  gap: 6px;
  flex-wrap: wrap;
  margin-bottom: 2px;
}

.section-products-related .pg-card__price-old {
  font-size: 11px;
  color: #888;
  text-decoration: line-through;
}

.section-products-related .pg-card__price-main {
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 16px;
  font-weight: 700;
  color: #000;
}

/* Desconto PIX/Boleto */
.section-products-related .pg-card__discount {
  font-size: 11px;
  color: #2d3a00 !important;
  font-weight: 600;
  margin-bottom: 2px;
  text-align: center;
}

.section-products-related .pg-card__discount .text-accent {
  color: #2d3a00 !important;
  font-weight: 600 !important;
  font-size: 11px !important;
}

/* Parcelas */
.section-products-related .pg-card__installments {
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 10px;
  color: #666;
  margin-bottom: 4px;
  text-align: center;
}

/* Botão "Comprar" — mesmo estilo do grid de categoria */
.section-products-related .pg-card__btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  width: 100%;
  min-height: 36px;
  padding: 8px 12px;
  margin-top: auto;
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  text-decoration: none !important;
  background: #EAFE67;
  color: #000 !important;
  border: none;
  border-radius: 8px;
  transition: all 0.2s ease;
}

.section-products-related .pg-card__btn:hover {
  background: #D4E600;
  transform: translateY(-2px);
  color: #000 !important;
  text-decoration: none !important;
}

/* Swiper slide — garante que o card preenche o slide */
.section-products-related .swiper-slide {
  height: auto !important;
  display: flex;
}

.section-products-related .swiper-slide .pg-card {
  width: 100%;
  flex: 1;
}

/* Swiper pagination */
.section-products-related .swiper-pagination {
  margin-top: 20px;
}

.section-products-related .swiper-pagination-bullet {
  width: 10px;
  height: 10px;
  background: #CCC;
  opacity: 1;
}

.section-products-related .swiper-pagination-bullet-active {
  background: #000;
}

/* Navegação do slider */
.section-products-related .swiper-button-prev,
.section-products-related .swiper-button-next {
  color: #000;
  opacity: 0.7;
}

.section-products-related .swiper-button-prev:hover,
.section-products-related .swiper-button-next:hover {
  opacity: 1;
}

/* Hover de imagem secundária */
.section-products-related .pg-card__img-hover,
.section-products-related .pg-card__img-hover.lazyloaded {
  opacity: 0 !important;
}

.section-products-related .pg-card:hover .pg-card__img-featured {
  opacity: 0 !important;
}

.section-products-related .pg-card:hover .pg-card__img-hover,
.section-products-related .pg-card:hover .pg-card__img-hover.lazyloaded {
  opacity: 1 !important;
}

/* Responsivo — mobile */
@media (max-width: 768px) {
  .section-products-related .pg-card__name {
    font-size: 11px;
    min-height: 28px;
  }

  .section-products-related .pg-card__price-main {
    font-size: 14px;
  }

  .section-products-related .pg-card__btn {
    min-height: 32px;
    font-size: 10px;
    padding: 6px 10px;
  }
}

/* ============================================================================
   FIM - Produtos Similares
============================================================================ */

/* Listagem (categoria/busca): item-image e filhos - escopo explícito */
body.template-category .pg-product-grid .item-image,
body.template-search .pg-product-grid .item-image {
  position: relative;
  overflow: hidden;
  background: #FFFFFF;
  border-radius: 16px;
  padding: 20px;
  margin-bottom: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  aspect-ratio: 1 / 1;
}
body.template-category .pg-product-grid .item-image img,
body.template-search .pg-product-grid .item-image img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  object-position: center;
  display: block;
}
body.template-category .pg-product-grid .item-image-slide img,
body.template-search .pg-product-grid .item-image-slide img {
  max-width: 100%;
  object-fit: contain;
  object-position: top;
}
body.template-category .pg-product-grid .item-thumbnail,
body.template-search .pg-product-grid .item-thumbnail {
  display: block;
  width: 100%;
}
body.template-category .pg-product-grid .item-image:not(.product-item-image-secondary).lazyloaded,
body.template-search .pg-product-grid .item-image:not(.product-item-image-secondary).lazyloaded {
  z-index: 9;
  opacity: 1;
}
body.template-category .pg-product-grid .item-image-secondary,
body.template-category .pg-product-grid .item-image-secondary.fade-in.lazyloaded,
body.template-search .pg-product-grid .item-image-secondary,
body.template-search .pg-product-grid .item-image-secondary.fade-in.lazyloaded {
  display: none;
  opacity: 0;
}
body.template-category .pg-product-grid .product-item-secondary-images-loaded:not(.product-item-secondary-images-disabled):hover .item-image-featured,
body.template-search .pg-product-grid .product-item-secondary-images-loaded:not(.product-item-secondary-images-disabled):hover .item-image-featured {
  opacity: 0;
  transition-delay: .05s;
}
body.template-category .pg-product-grid .product-item-secondary-images-loaded:not(.product-item-secondary-images-disabled):hover .item-image-featured ~ .item-image-secondary,
body.template-search .pg-product-grid .product-item-secondary-images-loaded:not(.product-item-secondary-images-disabled):hover .item-image-featured ~ .item-image-secondary {
  opacity: 1;
}
body.template-category .pg-product-grid .item-colors,
body.template-search .pg-product-grid .item-colors {
  position: absolute;
  bottom: 0;
  z-index: 9;
  width: 100%;
  padding: 5px 0;
}
body.template-category .pg-product-grid .item-colors-bullet,
body.template-search .pg-product-grid .item-colors-bullet {
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
body.template-category .pg-product-grid .item-colors-bullet:hover,
body.template-category .pg-product-grid .item-colors-bullet.selected,
body.template-search .pg-product-grid .item-colors-bullet:hover,
body.template-search .pg-product-grid .item-colors-bullet.selected {
  opacity: 1;
}
body.template-category .pg-product-grid .item-name,
body.template-search .pg-product-grid .item-name {
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
body.template-category .pg-product-grid .item-price-container,
body.template-search .pg-product-grid .item-price-container {
  margin-bottom: 10px;
  font-size: 12px;
}
body.template-category .pg-product-grid .item-installments,
body.template-search .pg-product-grid .item-installments {
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
}

.pg-blog-header h1 {
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 40px;
  font-weight: 700;
  color: #000;
  margin-bottom: 16px;
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
  gap: 12px;
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
  gap: 8px;
  padding: 10px 16px;
  border-radius: 4px;
  font-family: 'Familjen Grotesk', sans-serif;
  font-size: 14px;
  font-weight: 600;
  text-decoration: none;
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
  #Helper classes
==============================================================================*/

/*CSS properties helpers minified, to unminify it you have to copy the code and paste it here http://unminify.com/, after that paste the unminified code here */

{# /* // Margin and padding */ #}
.m-0{margin:0!important}.mt-0,.my-0{margin-top:0!important}.mr-0,.mx-0{margin-right:0!important}.mb-0,.my-0{margin-bottom:0!important}.ml-0,.mx-0{margin-left:0!important}.m-1{margin:.25rem!important}.mt-1,.my-1{margin-top:.25rem!important}.mr-1,.mx-1{margin-right:.25rem!important}.mb-1,.my-1{margin-bottom:.25rem!important}.ml-1,.mx-1{margin-left:.25rem!important}.m-2{margin:.5rem!important}.mt-2,.my-2{margin-top:.5rem!important}.mr-2,.mx-2{margin-right:.5rem!important}.mb-2,.my-2{margin-bottom:.5rem!important}.ml-2,.mx-2{margin-left:.5rem!important}.m-3{margin:1rem!important}.mt-3,.my-3{margin-top:1rem!important}.mr-3,.mx-3{margin-right:1rem!important}.mb-3,.my-3{margin-bottom:1rem!important}.ml-3,.mx-3{margin-left:1rem!important}.m-4{margin:1.5rem!important}.mt-4,.my-4{margin-top:1.5rem!important}.mr-4,.mx-4{margin-right:1.5rem!important}.mb-4,.my-4{margin-bottom:1.5rem!important}.ml-4,.mx-4{margin-left:1.5rem!important}.m-5{margin:3rem!important}.mt-5,.my-5{margin-top:3rem!important}.mr-5,.mx-5{margin-right:3rem!important}.mb-5,.my-5{margin-bottom:3rem!important}.ml-5,.mx-5{margin-left:3rem!important}.p-0{padding:0!important}.pt-0,.py-0{padding-top:0!important}.pr-0,.px-0{padding-right:0!important}.pb-0,.py-0{padding-bottom:0!important}.pl-0,.px-0{padding-left:0!important}.p-1{padding:.25rem!important}.pt-1,.py-1{padding-top:.25rem!important}.pr-1,.px-1{padding-right:.25rem!important}.pb-1,.py-1{padding-bottom:.25rem!important}.pl-1,.px-1{padding-left:.25rem!important}.p-2{padding:.5rem!important}.pt-2,.py-2{padding-top:.5rem!important}.pr-2,.px-2{padding-right:.5rem!important}.pb-2,.py-2{padding-bottom:.5rem!important}.pl-2,.px-2{padding-left:.5rem!important}.p-3{padding:1rem!important}.pt-3,.py-3{padding-top:1rem!important}.pr-3,.px-3{padding-right:1rem!important}.pb-3,.py-3{padding-bottom:1rem!important}.pl-3,.px-3{padding-left:1rem!important}.p-4{padding:1.5rem!important}.pt-4,.py-4{padding-top:1.5rem!important}.pr-4,.px-4{padding-right:1.5rem!important}.pb-4,.py-4{padding-bottom:1.5rem!important}.pl-4,.px-4{padding-left:1.5rem!important}.p-5{padding:3rem!important}.pt-5,.py-5{padding-top:3rem!important}.pr-5,.px-5{padding-right:3rem!important}.pb-5,.py-5{padding-bottom:3rem!important}.pl-5,.px-5{padding-left:3rem!important}.m-auto{margin:auto!important}.mt-auto,.my-auto{margin-top:auto!important}.mr-auto,.mx-auto{margin-right:auto!important}.mb-auto,.my-auto{margin-bottom:auto!important}.ml-auto,.mx-auto{margin-left:auto!important}@media (min-width:576px){.m-sm-0{margin:0!important}.mt-sm-0,.my-sm-0{margin-top:0!important}.mr-sm-0,.mx-sm-0{margin-right:0!important}.mb-sm-0,.my-sm-0{margin-bottom:0!important}.ml-sm-0,.mx-sm-0{margin-left:0!important}.m-sm-1{margin:.25rem!important}.mt-sm-1,.my-sm-1{margin-top:.25rem!important}.mr-sm-1,.mx-sm-1{margin-right:.25rem!important}.mb-sm-1,.my-sm-1{margin-bottom:.25rem!important}.ml-sm-1,.mx-sm-1{margin-left:.25rem!important}.m-sm-2{margin:.5rem!important}.mt-sm-2,.my-sm-2{margin-top:.5rem!important}.mr-sm-2,.mx-sm-2{margin-right:.5rem!important}.mb-sm-2,.my-sm-2{margin-bottom:.5rem!important}.ml-sm-2,.mx-sm-2{margin-left:.5rem!important}.m-sm-3{margin:1rem!important}.mt-sm-3,.my-sm-3{margin-top:1rem!important}.mr-sm-3,.mx-sm-3{margin-right:1rem!important}.mb-sm-3,.my-sm-3{margin-bottom:1rem!important}.ml-sm-3,.mx-sm-3{margin-left:1rem!important}.m-sm-4{margin:1.5rem!important}.mt-sm-4,.my-sm-4{margin-top:1.5rem!important}.mr-sm-4,.mx-sm-4{margin-right:1.5rem!important}.mb-sm-4,.my-sm-4{margin-bottom:1.5rem!important}.ml-sm-4,.mx-sm-4{margin-left:1.5rem!important}.m-sm-5{margin:3rem!important}.mt-sm-5,.my-sm-5{margin-top:3rem!important}.mr-sm-5,.mx-sm-5{margin-right:3rem!important}.mb-sm-5,.my-sm-5{margin-bottom:3rem!important}.ml-sm-5,.mx-sm-5{margin-left:3rem!important}.p-sm-0{padding:0!important}.pt-sm-0,.py-sm-0{padding-top:0!important}.pr-sm-0,.px-sm-0{padding-right:0!important}.pb-sm-0,.py-sm-0{padding-bottom:0!important}.pl-sm-0,.px-sm-0{padding-left:0!important}.p-sm-1{padding:.25rem!important}.pt-sm-1,.py-sm-1{padding-top:.25rem!important}.pr-sm-1,.px-sm-1{padding-right:.25rem!important}.pb-sm-1,.py-sm-1{padding-bottom:.25rem!important}.pl-sm-1,.px-sm-1{padding-left:.25rem!important}.p-sm-2{padding:.5rem!important}.pt-sm-2,.py-sm-2{padding-top:.5rem!important}.pr-sm-2,.px-sm-2{padding-right:.5rem!important}.pb-sm-2,.py-sm-2{padding-bottom:.5rem!important}.pl-sm-2,.px-sm-2{padding-left:.5rem!important}.p-sm-3{padding:1rem!important}.pt-sm-3,.py-sm-3{padding-top:1rem!important}.pr-sm-3,.px-sm-3{padding-right:1rem!important}.pb-sm-3,.py-sm-3{padding-bottom:1rem!important}.pl-sm-3,.px-sm-3{padding-left:1rem!important}.p-sm-4{padding:1.5rem!important}.pt-sm-4,.py-sm-4{padding-top:1.5rem!important}.pr-sm-4,.px-sm-4{padding-right:1.5rem!important}.pb-sm-4,.py-sm-4{padding-bottom:1.5rem!important}.pl-sm-4,.px-sm-4{padding-left:1.5rem!important}.p-sm-5{padding:3rem!important}.pt-sm-5,.py-sm-5{padding-top:3rem!important}.pr-sm-5,.px-sm-5{padding-right:3rem!important}.pb-sm-5,.py-sm-5{padding-bottom:3rem!important}.pl-sm-5,.px-sm-5{padding-left:3rem!important}.m-sm-auto{margin:auto!important}.mt-sm-auto,.my-sm-auto{margin-top:auto!important}.mr-sm-auto,.mx-sm-auto{margin-right:auto!important}.mb-sm-auto,.my-sm-auto{margin-bottom:auto!important}.ml-sm-auto,.mx-sm-auto{margin-left:auto!important}}@media (min-width:768px){.m-md-0{margin:0!important}.mt-md-0,.my-md-0{margin-top:0!important}.mr-md-0,.mx-md-0{margin-right:0!important}.mb-md-0,.my-md-0{margin-bottom:0!important}.ml-md-0,.mx-md-0{margin-left:0!important}.m-md-1{margin:.25rem!important}.mt-md-1,.my-md-1{margin-top:.25rem!important}.mr-md-1,.mx-md-1{margin-right:.25rem!important}.mb-md-1,.my-md-1{margin-bottom:.25rem!important}.ml-md-1,.mx-md-1{margin-left:.25rem!important}.m-md-2{margin:.5rem!important}.mt-md-2,.my-md-2{margin-top:.5rem!important}.mr-md-2,.mx-md-2{margin-right:.5rem!important}.mb-md-2,.my-md-2{margin-bottom:.5rem!important}.ml-md-2,.mx-md-2{margin-left:.5rem!important}.m-md-3{margin:1rem!important}.mt-md-3,.my-md-3{margin-top:1rem!important}.mr-md-3,.mx-md-3{margin-right:1rem!important}.mb-md-3,.my-md-3{margin-bottom:1rem!important}.ml-md-3,.mx-md-3{margin-left:1rem!important}.m-md-4{margin:1.5rem!important}.mt-md-4,.my-md-4{margin-top:1.5rem!important}.mr-md-4,.mx-md-4{margin-right:1.5rem!important}.mb-md-4,.my-md-4{margin-bottom:1.5rem!important}.ml-md-4,.mx-md-4{margin-left:1.5rem!important}.m-md-5{margin:3rem!important}.mt-md-5,.my-md-5{margin-top:3rem!important}.mr-md-5,.mx-md-5{margin-right:3rem!important}.mb-md-5,.my-md-5{margin-bottom:3rem!important}.ml-md-5,.mx-md-5{margin-left:3rem!important}.p-md-0{padding:0!important}.pt-md-0,.py-md-0{padding-top:0!important}.pr-md-0,.px-md-0{padding-right:0!important}.pb-md-0,.py-md-0{padding-bottom:0!important}.pl-md-0,.px-md-0{padding-left:0!important}.p-md-1{padding:.25rem!important}.pt-md-1,.py-md-1{padding-top:.25rem!important}.pr-md-1,.px-md-1{padding-right:.25rem!important}.pb-md-1,.py-md-1{padding-bottom:.25rem!important}.pl-md-1,.px-md-1{padding-left:.25rem!important}.p-md-2{padding:.5rem!important}.pt-md-2,.py-md-2{padding-top:.5rem!important}.pr-md-2,.px-md-2{padding-right:.5rem!important}.pb-md-2,.py-md-2{padding-bottom:.5rem!important}.pl-md-2,.px-md-2{padding-left:.5rem!important}.p-md-3{padding:1rem!important}.pt-md-3,.py-md-3{padding-top:1rem!important}.pr-md-3,.px-md-3{padding-right:1rem!important}.pb-md-3,.py-md-3{padding-bottom:1rem!important}.pl-md-3,.px-md-3{padding-left:1rem!important}.p-md-4{padding:1.5rem!important}.pt-md-4,.py-md-4{padding-top:1.5rem!important}.pr-md-4,.px-md-4{padding-right:1.5rem!important}.pb-md-4,.py-md-4{padding-bottom:1.5rem!important}.pl-md-4,.px-md-4{padding-left:1.5rem!important}.p-md-5{padding:3rem!important}.pt-md-5,.py-md-5{padding-top:3rem!important}.pr-md-5,.px-md-5{padding-right:3rem!important}.pb-md-5,.py-md-5{padding-bottom:3rem!important}.pl-md-5,.px-md-5{padding-left:3rem!important}.m-md-auto{margin:auto!important}.mt-md-auto,.my-md-auto{margin-top:auto!important}.mr-md-auto,.mx-md-auto{margin-right:auto!important}.mb-md-auto,.my-md-auto{margin-bottom:auto!important}.ml-md-auto,.mx-md-auto{margin-left:auto!important}}@media (min-width:992px){.m-lg-0{margin:0!important}.mt-lg-0,.my-lg-0{margin-top:0!important}.mr-lg-0,.mx-lg-0{margin-right:0!important}.mb-lg-0,.my-lg-0{margin-bottom:0!important}.ml-lg-0,.mx-lg-0{margin-left:0!important}.m-lg-1{margin:.25rem!important}.mt-lg-1,.my-lg-1{margin-top:.25rem!important}.mr-lg-1,.mx-lg-1{margin-right:.25rem!important}.mb-lg-1,.my-lg-1{margin-bottom:.25rem!important}.ml-lg-1,.mx-lg-1{margin-left:.25rem!important}.m-lg-2{margin:.5rem!important}.mt-lg-2,.my-lg-2{margin-top:.5rem!important}.mr-lg-2,.mx-lg-2{margin-right:.5rem!important}.mb-lg-2,.my-lg-2{margin-bottom:.5rem!important}.ml-lg-2,.mx-lg-2{margin-left:.5rem!important}.m-lg-3{margin:1rem!important}.mt-lg-3,.my-lg-3{margin-top:1rem!important}.mr-lg-3,.mx-lg-3{margin-right:1rem!important}.mb-lg-3,.my-lg-3{margin-bottom:1rem!important}.ml-lg-3,.mx-lg-3{margin-left:1rem!important}.m-lg-4{margin:1.5rem!important}.mt-lg-4,.my-lg-4{margin-top:1.5rem!important}.mr-lg-4,.mx-lg-4{margin-right:1.5rem!important}.mb-lg-4,.my-lg-4{margin-bottom:1.5rem!important}.ml-lg-4,.mx-lg-4{margin-left:1.5rem!important}.m-lg-5{margin:3rem!important}.mt-lg-5,.my-lg-5{margin-top:3rem!important}.mr-lg-5,.mx-lg-5{margin-right:3rem!important}.mb-lg-5,.my-lg-5{margin-bottom:3rem!important}.ml-lg-5,.mx-lg-5{margin-left:3rem!important}.p-lg-0{padding:0!important}.pt-lg-0,.py-lg-0{padding-top:0!important}.pr-lg-0,.px-lg-0{padding-right:0!important}.pb-lg-0,.py-lg-0{padding-bottom:0!important}.pl-lg-0,.px-lg-0{padding-left:0!important}.p-lg-1{padding:.25rem!important}.pt-lg-1,.py-lg-1{padding-top:.25rem!important}.pr-lg-1,.px-lg-1{padding-right:.25rem!important}.pb-lg-1,.py-lg-1{padding-bottom:.25rem!important}.pl-lg-1,.px-lg-1{padding-left:.25rem!important}.p-lg-2{padding:.5rem!important}.pt-lg-2,.py-lg-2{padding-top:.5rem!important}.pr-lg-2,.px-lg-2{padding-right:.5rem!important}.pb-lg-2,.py-lg-2{padding-bottom:.5rem!important}.pl-lg-2,.px-lg-2{padding-left:.5rem!important}.p-lg-3{padding:1rem!important}.pt-lg-3,.py-lg-3{padding-top:1rem!important}.pr-lg-3,.px-lg-3{padding-right:1rem!important}.pb-lg-3,.py-lg-3{padding-bottom:1rem!important}.pl-lg-3,.px-lg-3{padding-left:1rem!important}.p-lg-4{padding:1.5rem!important}.pt-lg-4,.py-lg-4{padding-top:1.5rem!important}.pr-lg-4,.px-lg-4{padding-right:1.5rem!important}.pb-lg-4,.py-lg-4{padding-bottom:1.5rem!important}.pl-lg-4,.px-lg-4{padding-left:1.5rem!important}.p-lg-5{padding:3rem!important}.pt-lg-5,.py-lg-5{padding-top:3rem!important}.pr-lg-5,.px-lg-5{padding-right:3rem!important}.pb-lg-5,.py-lg-5{padding-bottom:3rem!important}.pl-lg-5,.px-lg-5{padding-left:3rem!important}.m-lg-auto{margin:auto!important}.mt-lg-auto,.my-lg-auto{margin-top:auto!important}.mr-lg-auto,.mx-lg-auto{margin-right:auto!important}.mb-lg-auto,.my-lg-auto{margin-bottom:auto!important}.ml-lg-auto,.mx-lg-auto{margin-left:auto!important}}@media (min-width:1200px){.m-xl-0{margin:0!important}.mt-xl-0,.my-xl-0{margin-top:0!important}.mr-xl-0,.mx-xl-0{margin-right:0!important}.mb-xl-0,.my-xl-0{margin-bottom:0!important}.ml-xl-0,.mx-xl-0{margin-left:0!important}.m-xl-1{margin:.25rem!important}.mt-xl-1,.my-xl-1{margin-top:.25rem!important}.mr-xl-1,.mx-xl-1{margin-right:.25rem!important}.mb-xl-1,.my-xl-1{margin-bottom:.25rem!important}.ml-xl-1,.mx-xl-1{margin-left:.25rem!important}.m-xl-2{margin:.5rem!important}.mt-xl-2,.my-xl-2{margin-top:.5rem!important}.mr-xl-2,.mx-xl-2{margin-right:.5rem!important}.mb-xl-2,.my-xl-2{margin-bottom:.5rem!important}.ml-xl-2,.mx-xl-2{margin-left:.5rem!important}.m-xl-3{margin:1rem!important}.mt-xl-3,.my-xl-3{margin-top:1rem!important}.mr-xl-3,.mx-xl-3{margin-right:1rem!important}.mb-xl-3,.my-xl-3{margin-bottom:1rem!important}.ml-xl-3,.mx-xl-3{margin-left:1rem!important}.m-xl-4{margin:1.5rem!important}.mt-xl-4,.my-xl-4{margin-top:1.5rem!important}.mr-xl-4,.mx-xl-4{margin-right:1.5rem!important}.mb-xl-4,.my-xl-4{margin-bottom:1.5rem!important}.ml-xl-4,.mx-xl-4{margin-left:1.5rem!important}.m-xl-5{margin:3rem!important}.mt-xl-5,.my-xl-5{margin-top:3rem!important}.mr-xl-5,.mx-xl-5{margin-right:3rem!important}.mb-xl-5,.my-xl-5{margin-bottom:3rem!important}.ml-xl-5,.mx-xl-5{margin-left:3rem!important}.p-xl-0{padding:0!important}.pt-xl-0,.py-xl-0{padding-top:0!important}.pr-xl-0,.px-xl-0{padding-right:0!important}.pb-xl-0,.py-xl-0{padding-bottom:0!important}.pl-xl-0,.px-xl-0{padding-left:0!important}.p-xl-1{padding:.25rem!important}.pt-xl-1,.py-xl-1{padding-top:.25rem!important}.pr-xl-1,.px-xl-1{padding-right:.25rem!important}.pb-xl-1,.py-xl-1{padding-bottom:.25rem!important}.pl-xl-1,.px-xl-1{padding-left:.25rem!important}.p-xl-2{padding:.5rem!important}.pt-xl-2,.py-xl-2{padding-top:.5rem!important}.pr-xl-2,.px-xl-2{padding-right:.5rem!important}.pb-xl-2,.py-xl-2{padding-bottom:.5rem!important}.pl-xl-2,.px-xl-2{padding-left:.5rem!important}.p-xl-3{padding:1rem!important}.pt-xl-3,.py-xl-3{padding-top:1rem!important}.pr-xl-3,.px-xl-3{padding-right:1rem!important}.pb-xl-3,.py-xl-3{padding-bottom:1rem!important}.pl-xl-3,.px-xl-3{padding-left:1rem!important}.p-xl-4{padding:1.5rem!important}.pt-xl-4,.py-xl-4{padding-top:1.5rem!important}.pr-xl-4,.px-xl-4{padding-right:1.5rem!important}.pb-xl-4,.py-xl-4{padding-bottom:1.5rem!important}.pl-xl-4,.px-xl-4{padding-left:1.5rem!important}.p-xl-5{padding:3rem!important}.pt-xl-5,.py-xl-5{padding-top:3rem!important}.pr-xl-5,.px-xl-5{padding-right:3rem!important}.pb-xl-5,.py-xl-5{padding-bottom:3rem!important}.pl-xl-5,.px-xl-5{padding-left:3rem!important}.m-xl-auto{margin:auto!important}.mt-xl-auto,.my-xl-auto{margin-top:auto!important}.mr-xl-auto,.mx-xl-auto{margin-right:auto!important}.mb-xl-auto,.my-xl-auto{margin-bottom:auto!important}.ml-xl-auto,.mx-xl-auto{margin-left:auto!important}}

{# /* // Text */ #}
.text-left{text-align:left!important}.text-right{text-align:right!important}.text-center{text-align:center!important}@media (min-width:576px){.text-sm-left{text-align:left!important}.text-sm-right{text-align:right!important}.text-sm-center{text-align:center!important}}@media (min-width:768px){.text-md-left{text-align:left!important}.text-md-right{text-align:right!important}.text-md-center{text-align:center!important}}@media (min-width:992px){.text-lg-left{text-align:left!important}.text-lg-right{text-align:right!important}.text-lg-center{text-align:center!important}}@media (min-width:1200px){.text-xl-left{text-align:left!important}.text-xl-right{text-align:right!important}.text-xl-center{text-align:center!important}}.text-lowercase{text-transform:lowercase!important}.text-uppercase{text-transform:uppercase!important}.text-capitalize{text-transform:capitalize!important}.font-weight-light{font-weight:300!important}.font-weight-normal{font-weight:400!important}.font-weight-bold{font-weight:700!important}.font-italic{font-style:italic!important}

{# /* // Align */ #}
.align-baseline{vertical-align:baseline!important}.align-top{vertical-align:top!important}.align-middle{vertical-align:middle!important}.align-bottom{vertical-align:bottom!important}.align-text-bottom{vertical-align:text-bottom!important}.align-text-top{vertical-align:text-top!important}

{# /* // Position */ #}
.position-relative{position:relative!important}.position-absolute{position:absolute!important;}.position-fixed{position:fixed!important}

{# /* // Image */ #}
.img-fluid {max-width:100%;height:auto}

{# /* // Visibility */ #}
.hidden{display:none}.hidden-important{display:none!important}.overflow-none{overflow:hidden}.opacity-50{opacity: .5}.opacity-40{opacity:.4}.opacity-60{opacity:.6}.opacity-80{opacity:.8}.opacity-90{opacity:.9}

{# /* // Float */ #}
.float-left{float:left!important}.float-right{float:right!important}.float-none{float:none!important}.clear-both{clear:both!important}

{# /* // Width */ #}
.w-100{width:100%!important}.w-auto{width:auto!important}.full-width-container{width:100%;float:left;clear:both}

{# /* // Height */ #}
.h-100{height:100%!important}

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

/* Conteúdo */
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
	font-size: 12px;
	font-weight: 500;
	color: #000;
	line-height: 1.2;
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

/* Preço */
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

/* Estado de atualização do item do carrinho */
.pg-cart-item.is-updating {
	opacity: 0.7;
	pointer-events: none;
}

.pg-cart-item.is-updating .pg-qty-selector {
	border-color: #EAFE67;
}

/* Botão remover */
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
		width: 110px;
	}

	.pg-cart-item__name {
		font-size: 11px;
	}

	.pg-cart-item__price {
		font-size: 14px;
	}
}

/* ============================================
   CART TOTALS - NOVO DESIGN PROTÓTIPO
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
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 13px !important;
	color: #EAFE67 !important;
	font-weight: 500 !important;
}

/* Hide installments/parcelamento in modal - PATAGANG */
#modal-cart [data-component="installments"],
#modal-cart .js-installments,
#modal-cart [data-component="payment-discount-price"] {
	display: none !important;
}

/* ============================================
   ONG SELECTOR - PATAGANG DOAÇÃO (Compacto)
   ============================================ */

.pg-ong-selector {
	margin: 20px 0 16px 0;
	padding: 10px 12px;
	background: transparent; /* Removido background para não sobrepor info do CEP */
	border-radius: 8px;
	border: 1px solid #e5e5e5;
	overflow: hidden; /* Garante que nada extrapole */
}

.pg-ong-selector__label {
	display: block;
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 11px;
	color: #666;
	font-weight: 500;
	margin-bottom: 6px;
}

.pg-ong-selector__select {
	width: 100%;
	padding: 8px 32px 8px 10px;
	border: 1px solid #ddd;
	border-radius: 6px;
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 13px;
	font-weight: 500;
	background: #fff;
	color: #000;
	cursor: pointer;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 12 12'%3E%3Cpath fill='%23666' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: right 10px center;
}

.pg-ong-selector__select:focus {
	outline: none;
	border-color: #EAFE67;
}

/* Responsivo */
@media (max-width: 480px) {
	.pg-ong-selector {
		padding: 8px 10px;
		margin: 10px 0 14px 0;
	}

	.pg-ong-selector__label {
		font-size: 10px;
		margin-bottom: 4px;
	}

	.pg-ong-selector__select {
		font-size: 12px;
		padding: 6px 28px 6px 8px;
	}
}

/* ============================================
   CART MODAL STYLES - ADOBE XD PROTOTYPE
   ============================================ */

/* Overlay with Enhanced Blur Effect - PATAGANG */
.modal-overlay[data-modal-id="#modal-cart"],
.modal-overlay {
	background-color: rgba(0, 0, 0, 0.2) !important;
	backdrop-filter: blur(30px) saturate(180%);
	-webkit-backdrop-filter: blur(30px) saturate(180%);
}

/* Modal cart glassmorphism effect */
.modal-cart {
	background: rgba(255, 255, 255, 0.95) !important;
	backdrop-filter: blur(10px);
	-webkit-backdrop-filter: blur(10px);
}

/* Modal Container Width */
.modal-cart.modal-docked-md {
	width: 400px !important; /* Aumentado para melhor espaçamento */
	max-width: 100%;
}

/* Apply Familjen Grotesk to all cart text */
.modal-cart,
.modal-cart * {
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 14px !important; /* Reduzido de 20px para 14px */
	font-weight: 400 !important;
	color: #000000 !important;
}

/* Modal Header - Title and Close Button */
.modal-cart .modal-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 24px 20px;
	background-color: #FFFFFF !important;
	border-bottom: 1px solid #E5E5E5; /* Adiciona separação visual */
}

.modal-cart .modal-header .d-inline-flex {
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 16px !important; /* Reduzido de 20px */
	font-weight: 600 !important; /* Bold para título */
	color: #000000 !important;
	order: 1;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

/* Close Button - Positioned to the Right */
.modal-cart .modal-close {
	order: 2;
	padding: 0 !important;
	margin-left: auto;
}

.modal-cart .modal-close svg,
.modal-cart .modal-close .icon-inline {
	width: 20px !important;
	height: 20px !important;
	fill: #000000 !important;
	stroke: #000000 !important;
}

/* Product Name */
.modal-cart .pg-cart-item-name,
.modal-cart .pg-cart-item-name a {
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 12px !important; /* Compactado para dar mais destaque à imagem */
	font-weight: 500 !important; /* Peso médio */
	color: #000000 !important;
	text-decoration: none !important;
	line-height: 1.2;
}

/* Product Price */
.modal-cart .pg-cart-item-price,
.modal-cart .pg-cart-item-price-mobile,
.modal-cart .price {
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 16px !important; /* Destaque no preço */
	font-weight: 600 !important; /* Bold */
	color: #000000 !important;
}

/* Product Variant (Size) */
.modal-cart .pg-cart-item-variant,
.modal-cart .cart-item-variant {
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 12px !important; /* Menor, mais discreto */
	font-weight: 400 !important;
	color: #666666 !important; /* Cinza mais suave */
	margin-top: 2px;
}

/* Quantity Controls - Updated Design */
.modal-cart .pg-cart-quantity-input .input-group,
.modal-cart .js-cart-quantity-input .input-group {
	border: 1px solid #E0E0E0 !important; /* Borda mais suave */
	background-color: #FFFFFF !important; /* Fundo branco */
	border-radius: 6px !important; /* Menos arredondado */
	overflow: hidden;
	max-width: 100px; /* Menor */
	height: 32px; /* Mais compacto */
	display: flex;
	align-items: center;
	justify-content: center;
}

.modal-cart .pg-cart-quantity-input .form-control,
.modal-cart .js-cart-quantity-input .form-control {
	border: none !important;
	background-color: transparent !important;
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 14px !important; /* Reduzido */
	font-weight: 500 !important;
	color: #000000 !important;
	text-align: center;
	padding: 4px 2px;
	width: 32px; /* Mais estreito */
}

.modal-cart .pg-cart-quantity-btn,
.modal-cart .js-cart-quantity-btn {
	background-color: transparent !important;
	border: none !important;
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 16px !important; /* Tamanho reduzido */
	font-weight: 400 !important;
	color: #000000 !important;
	padding: 4px 8px; /* Padding menor */
	cursor: pointer;
	min-width: 24px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.modal-cart .pg-cart-quantity-btn:hover,
.modal-cart .js-cart-quantity-btn:hover {
	background-color: rgba(0, 0, 0, 0.08) !important;
}

/* Summary Labels (Subtotal, Frete, Cupom, Total) */
.modal-cart .h5,
.modal-cart .cart-subtotal,
.modal-cart .shipping-label,
.modal-cart .coupon-label {
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 14px !important; /* Reduzido de 20px */
	font-weight: 400 !important;
	color: #000000 !important;
	line-height: 1.6;
}

.modal-cart .h5 strong {
	font-weight: 600 !important;
}

/* Total - Maior destaque */
.modal-cart .h2,
.modal-cart .cart-total {
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 18px !important; /* Maior que subtotal */
	font-weight: 700 !important; /* Extra bold */
	color: #000000 !important;
}

/* Links (Calcular, Adicionar) */
.modal-cart .pg-cart-summary-link,
.modal-cart a.btn-link,
.modal-cart .js-shipping-calculator-trigger,
.modal-cart .js-add-coupon {
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 13px !important; /* Menor, mais discreto */
	font-weight: 400 !important;
	color: #000000 !important;
	text-decoration: underline !important;
	cursor: pointer;
	transition: opacity 0.2s;
}

.modal-cart .pg-cart-summary-link:hover,
.modal-cart a.btn-link:hover {
	opacity: 0.6;
	text-decoration: underline !important;
}

/* FINALIZAR COMPRA Button */
.modal-cart .btn-primary[name="go_to_checkout"],
.modal-cart #go-to-checkout,
.modal-cart .js-cart-submit {
	width: 100% !important; /* Largura completa */
	max-width: 100%;
	height: 48px !important; /* Altura maior para destaque */
	background-color: #000000 !important;
	border: none !important;
	border-radius: 6px !important; /* Bordas menos arredondadas */
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 14px !important; /* Reduzido de 20px */
	font-weight: 600 !important; /* Semi-bold */
	color: #FFFFFF !important;
	text-transform: uppercase !important; /* Caixa alta */
	letter-spacing: 0.8px !important; /* Espaçamento entre letras */
	padding: 0 24px !important;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 16px 0 0 0 !important; /* Margem superior */
	cursor: pointer;
	transition: all 0.3s ease;
}

.modal-cart .btn-primary[name="go_to_checkout"]:hover,
.modal-cart #go-to-checkout:hover,
.modal-cart .js-cart-submit:hover {
	background-color: #1a1a1a !important; /* Cinza escuro no hover */
	transform: translateY(-1px); /* Elevação sutil */
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
	padding: 20px !important; /* Mais espaçamento */
	background-color: #FFFFFF !important;
}

/* Cart Items Container */
.modal-cart .js-ajax-cart-list,
.modal-cart .cart-row {
	background-color: transparent !important;
	margin-bottom: 16px;
}

/* Cart Item Spacing */
.modal-cart .pg-cart-item {
	padding: 16px 0;
	border-bottom: 1px solid #F0F0F0;
	margin-bottom: 0 !important;
}

.modal-cart .pg-cart-item:last-child {
	border-bottom: none;
}

/* Remove any conflicting border radius */
.modal-cart {
	border-radius: 0 !important;
}

/* Shipping Calculator Compacto no Modal */
.modal-cart .shipping-calculator-head {
	height: auto !important;
	min-height: 45px;
}

.modal-cart .shipping-calculator-head.with-zip {
	height: auto !important;
	min-height: 55px;
}

.modal-cart .shipping-calculator-head.with-form {
	height: auto !important;
}

.modal-cart .radio-button-item,
.modal-cart .list-item {
	padding: 8px 0 !important;
	margin: 0 !important;
}

.modal-cart .radio-button {
	padding: 8px 10px !important;
	margin-bottom: 6px !important;
}

.modal-cart .radio-button-content {
	padding: 6px 8px !important;
	font-size: 13px !important;
}

.modal-cart .radio-button-content .unchecked,
.modal-cart .radio-button-content .checked {
	width: 16px !important;
	height: 16px !important;
	top: 50% !important;
	transform: translateY(-50%);
}

.modal-cart .shipping-option,
.modal-cart .branch-option {
	padding: 8px 10px !important;
	margin: 4px 0 !important;
	font-size: 13px !important;
}

.modal-cart .shipping-option-name,
.modal-cart .branch-name {
	font-size: 13px !important;
	line-height: 1.3 !important;
}

.modal-cart .shipping-option-price,
.modal-cart .shipping-price {
	font-size: 13px !important;
	font-weight: 600 !important;
}

.modal-cart .shipping-option-extra,
.modal-cart .shipping-time {
	font-size: 11px !important;
	color: #666 !important;
	margin-top: 2px !important;
}

/* Container de frete mais compacto */
.modal-cart #cart-shipping-container,
.modal-cart .js-shipping-calculator-container {
	padding: 0 !important;
}

.modal-cart .js-shipping-list-container,
.modal-cart .shipping-list {
	margin-top: 8px !important;
}

/* Título "ENVÍO A DOMICILIO" e "RETIRAR EM" mais compacto */
.modal-cart .js-branch-label,
.modal-cart .shipping-extra-options-title,
.modal-cart h6 {
	font-size: 11px !important;
	font-weight: 600 !important;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	margin: 12px 0 6px 0 !important;
	color: #666 !important;
}

/* Link "VER MAIS OPÇÕES" mais compacto */
.modal-cart .js-shipping-see-more,
.modal-cart .shipping-see-more {
	font-size: 11px !important;
	padding: 6px 0 !important;
}

/* Responsive Adjustments */
@media (max-width: 767px) {
	.modal-cart.modal-docked-md {
		width: 100% !important;
	}

	.modal-cart .btn-primary[name="go_to_checkout"],
	.modal-cart #go-to-checkout,
	.modal-cart .js-cart-submit {
		width: 100% !important;
		max-width: 100%;
	}
}

@media (min-width: 768px) {
	.modal-cart.modal-docked-md {
		width: 400px !important; /* Aumentado para 400px */
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
	font-family: 'Familjen Grotesk', sans-serif !important;
}

/* Alert messages in cart */
.modal-cart .alert {
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 13px !important; /* Reduzido */
	color: #000000 !important;
	padding: 12px;
}

/* Empty cart message */
.modal-cart .js-empty-ajax-cart {
	font-family: 'Familjen Grotesk', sans-serif !important;
	font-size: 14px !important; /* Reduzido de 20px */
	color: #000000 !important;
}

/* PATAGANG - Product Page Redesign - Layout Profissional Nuvemshop */
/*============================================================================
#PDP Custom Layout - Cards LADO A LADO (OBRIGATORIO EM DESKTOP)
REGRA CRITICA: Em desktop (>=992px), SEMPRE lado a lado. NUNCA empilhar!
==============================================================================*/

/* Container principal - BACKGROUND PADRÃO #E2E2E2 */
.pg-pdp-container {
	padding-top: 90px;
	padding-bottom: 0; /* Sem padding - footer sucede direto */
	margin: 0 !important;
	/* BACKGROUND PADRONIZADO #E2E2E2 - Consistente em todo o site */
	background-color: #E2E2E2;
	min-height: calc(100vh - 60px);
	display: flex;
	flex-direction: column; /* Produto acima, reviews abaixo (Konfidency precisa estar dentro) */
	align-items: stretch;
	justify-content: flex-start;
}

/* Row principal - Bootstrap row */
.pg-pdp-container .section-single-product {
	margin: 0 !important;
	padding: 30px 20px;
	width: 100%;
	max-width: 1400px; /* Mais largo */
}

/* DESKTOP: FORÇAR lado a lado - sobrescreve Bootstrap */
@media (min-width: 992px) {
	.pg-pdp-container .section-single-product.row {
		display: flex !important;
		flex-direction: row !important;
		flex-wrap: nowrap !important;
		align-items: flex-start !important; /* FLEX-START para sticky funcionar */
		justify-content: center !important;
		gap: 40px;
		padding: 30px 40px;
	}

	/* COLUNA ESQUERDA - Imagem - MAIOR */
	.pg-pdp-container .pg-pdp-image-col.col-lg-7 {
		flex: 0 0 58% !important;
		max-width: 58% !important;
		width: 58% !important;
		padding: 0 !important;
		align-self: flex-start !important; /* Imagem alinha no topo */
	}

	/* COLUNA DIREITA - Info - STICKY SCROLL */
	.pg-pdp-container .pg-pdp-info-col.col-lg-5 {
		flex: 0 0 40% !important;
		max-width: 40% !important;
		width: 40% !important;
		padding: 0 !important;
		padding-top: 16px !important; /* Alinha com grid de imagens */
		align-self: flex-start !important; /* Alinha ao topo */
		/* STICKY: Card fica fixo enquanto imagens rolam */
		position: sticky !important;
		top: 16px !important; /* Mínimo - logo abaixo do topo visível */
		/* REMOVIDO overflow daqui - vai para o card interno */
	}

	/* Card interno com scroll e altura máxima */
	.pg-pdp-info-card {
		max-height: calc(100vh - 120px) !important; /* Cabe na viewport */
		overflow-y: auto !important; /* Scroll interno */
		display: flex !important;
		flex-direction: column !important;
		/* Esconde scrollbar */
		scrollbar-width: none;
		-ms-overflow-style: none;
	}

	.pg-pdp-info-card::-webkit-scrollbar {
		display: none;
		width: 0;
		height: 0;
	}
}

/* TELAS GRANDES (1200px+): Ajuste fino do sticky */
@media (min-width: 1200px) {
	.pg-pdp-container .pg-pdp-info-col.col-lg-5 {
		top: 20px !important; /* Ligeiramente mais espaço em telas grandes */
		max-height: calc(100vh - 100px);
	}
}

/* =============================================================================
   NOTEBOOKS MENORES (992-1199px): Card COMPACTO
   Reduz padding, fontes e espaçamentos para caber em viewports menores
   ============================================================================= */
@media (min-width: 992px) and (max-width: 1199px) {
	/* Card com padding reduzido */
	.pg-pdp-info-card {
		padding: 16px 20px !important;
	}

	/* Header mais compacto */
	.pg-product-header {
		margin-bottom: 8px !important;
	}

	.pg-product-title {
		font-size: 13px !important;
		letter-spacing: 0.5px !important;
	}

	/* Bloco de preços compacto */
	.pg-price-block {
		margin-bottom: 14px !important;
		padding-bottom: 12px !important;
	}

	.pg-price-pix-highlight {
		font-size: 18px !important;
	}

	.pg-price-original {
		font-size: 12px !important;
	}

	.pg-price-installments {
		font-size: 10px !important;
		margin-top: 4px !important;
	}

	/* Botões de tamanho menores */
	.pg-size-btn {
		min-width: 28px !important;
		height: 28px !important;
		font-size: 10px !important;
		padding: 0 8px !important;
	}

	/* Link tabela de medidas menor */
	.pg-size-guide-link {
		font-size: 9px !important;
	}

	/* Container de variantes mais compacto */
	.pg-variants-container {
		margin-bottom: 10px !important;
	}

	.pg-variant-group {
		margin-bottom: 6px !important;
	}

	/* Botão ADICIONAR compacto (mantém amarelo) */
	.pg-product-add-btn {
		height: 40px !important;
		font-size: 11px !important;
		margin-bottom: 10px !important;
	}

	/* Banner cupom compacto */
	.pg-coupon-banner {
		padding: 10px 14px !important;
		margin-bottom: 12px !important;
	}

	.pg-coupon-banner__highlight {
		font-size: 12px !important;
	}

	.pg-coupon-banner__highlight strong {
		font-size: 14px !important;
	}

	.pg-coupon-banner__code {
		font-size: 10px !important;
	}

	/* Accordions mais compactos */
	.pg-accordion-header {
		padding: 8px 0 !important;
		font-size: 10px !important;
	}

	.pg-accordion-icon {
		font-size: 14px !important;
	}

	.pg-accordion-content {
		font-size: 9px !important;
		line-height: 1.4 !important;
	}

	.pg-accordion-item.active .pg-accordion-content {
		max-height: 300px !important;
		padding-bottom: 10px !important;
	}

	/* Watermark menor */
	.pg-pdp-watermark {
		width: 180px !important;
		height: 180px !important;
	}
}

/* Background agora é global no body - manter transparente aqui */
#single-product {
	background: transparent;
}

/* COLUNA ESQUERDA - Imagem SEM BORDAS, SEM CARD */
.pg-pdp-image-col {
	background: transparent; /* SEM fundo */
	border-radius: 0; /* SEM bordas arredondadas */
	padding: 0 !important; /* SEM padding */
	overflow: visible;
	display: flex;
	align-items: flex-start; /* Alinha no topo */
	justify-content: center;
	box-shadow: none; /* SEM sombra */
	min-height: auto; /* Altura automática baseada na imagem */
}

/* Container da imagem - preenche tudo */
.pg-pdp-image-col .product-image-container {
	width: 100%;
	height: auto;
	display: flex;
	align-items: flex-start;
	justify-content: center;
	padding: 0 !important;
}

/* Swiper container - altura automática */
.pg-pdp-image-col .js-swiper-product {
	width: 100%;
	height: auto !important;
	min-height: auto !important;
}

/* Wrapper do swiper */
.pg-pdp-image-col .swiper-wrapper {
	align-items: flex-start;
	transition-timing-function: ease-in-out !important;
	height: auto !important;
}

.pg-pdp-image-col .swiper-slide {
	display: flex;
	align-items: flex-start;
	justify-content: center;
	height: auto !important;
	width: 100% !important;
	transition: opacity 0.5s ease-in-out;
}

/* Link da imagem - ajusta à imagem */
.pg-pdp-image-col .js-product-slide-link {
	padding-bottom: 0 !important;
	position: relative !important;
	display: flex;
	align-items: flex-start;
	justify-content: center;
	width: 100%;
	height: auto !important;
	min-height: auto !important;
	padding: 0;
}

/* Imagem do produto - GRANDE E SEM RESTRIÇÕES */
.pg-pdp-image-col .product-slider-image {
	position: relative !important;
	left: auto !important;
	top: auto !important;
	transform: none !important;
	width: 100%; /* Ocupa toda a largura */
	height: auto;
	max-width: 100%;
	max-height: none; /* SEM limite de altura */
	object-fit: contain;
	transition: opacity 0.4s ease;
	border-radius: 20px; /* Bordas arredondadas na própria imagem */
	box-shadow: 0 8px 32px rgba(0,0,0,0.1); /* Sombra na imagem */
}

/* ============================================
   BOTÕES DE NAVEGAÇÃO DO CARROSSEL - LOGO DO CACHORRO
   ============================================ */

/* Container dos botões - Apenas logo visível */
.pg-nav-btn {
	display: flex !important;
	align-items: center !important;
	justify-content: center !important;
	width: 48px !important;
	height: 48px !important;
	background: transparent !important;
	border: none !important;
	border-radius: 0 !important;
	box-shadow: none !important;
	cursor: pointer !important;
	transition: all 0.3s ease !important;
	z-index: 20 !important;
}

/* Logo dentro do botão - Sutil e discreta */
.pg-nav-btn__logo {
	width: 28px !important;
	height: 28px !important;
	object-fit: contain !important;
	opacity: 0.35 !important; /* Logo mais sutil */
	filter: blur(0.5px) !important; /* Leve blur para suavizar */
	transition: all 0.3s ease !important;
}

/* Botão anterior - logo virada para esquerda */
.pg-nav-btn--prev {
	left: 12px !important;
}

.pg-nav-btn--prev .pg-nav-btn__logo {
	transform: scaleX(-1) !important; /* Espelha a logo para esquerda */
}

/* Botão próximo - logo normal */
.pg-nav-btn--next {
	right: 12px !important;
}

/* Hover nos botões */
.pg-nav-btn:hover {
	background: transparent !important;
	transform: scale(1.15) !important;
}

/* Hover - Logo fica mais visível */
.pg-nav-btn--prev:hover .pg-nav-btn__logo {
	transform: scaleX(-1) scale(1.05) !important;
	opacity: 0.6 !important;
	filter: blur(0) !important;
}

.pg-nav-btn--next:hover .pg-nav-btn__logo {
	transform: scale(1.05) !important;
	opacity: 0.6 !important;
	filter: blur(0) !important;
}

/* Remover seta padrão do Swiper */
.pg-nav-btn::after {
	display: none !important;
	content: '' !important;
}

/* Estado disabled */
.pg-nav-btn.swiper-button-disabled {
	opacity: 0.4 !important;
	pointer-events: none !important;
	cursor: default !important;
}

/* Paginação */
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
	display: none !important;
}

/* COLUNA DIREITA - Card de informações */
.pg-pdp-info-col {
	display: flex;
	align-items: center; /* Centraliza conteúdo interno */
	justify-content: center;
	padding: 0;
	position: relative;
}

/* MARCA D'ÁGUA DO LOGO - Visível através do blur do card */
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

/* Card de informações - COMPACTO verticalmente, LARGO horizontalmente */
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

/* Conteúdo do card */
.pg-product-card-content .page-header {
	display: none;
}

/* Header do produto — Título com destaque */
.pg-product-header {
	margin-bottom: 12px;
	padding-bottom: 0;
	border-bottom: none;
}

/* Título do produto — DESTAQUE PRINCIPAL */
.pg-product-title {
	font-family: 'Familjen Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
	font-size: 16px;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 1px;
	line-height: 1.3;
	margin: 0;
	color: #000;
}

/* ============================================
   BLOCO DE PREÇOS — Hierarquia visual
   ============================================ */
.pg-price-block {
	margin-bottom: 20px;
	padding-bottom: 16px;
	border-bottom: 1px solid rgba(0, 0, 0, 0.08);
}

/* Preço PIX/Boleto — DESTAQUE PRINCIPAL */
.pg-price-pix-highlight {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 22px;
	font-weight: 700;
	color: #000;
	letter-spacing: 0.3px;
	line-height: 1.2;
	display: block;
	margin-bottom: 6px;
}

/* Preço original tachado (menor, abaixo do PIX) */
.pg-price-original {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 14px;
	font-weight: 400;
	color: #888;
	text-decoration: line-through;
	display: block;
	margin-bottom: 8px;
	letter-spacing: 0.3px;
}

/* Preço atual (escondido, só para JS) */
.pg-price-current {
	display: none;
}

/* Parcelamento */
.pg-price-installments {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 12px;
	font-weight: 400;
	color: #666;
	margin-top: 6px;
	line-height: 1.4;
}

/* Formulário do produto */
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

/* Botão ADICIONAR — Amarelo Patagang */
.pg-product-add-btn {
	width: 100%;
	height: 48px;
	background-color: #EAFE67;
	border: none;
	border-radius: 8px;
	font-family: 'Familjen Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
	font-size: 14px;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 1.5px;
	color: #000;
	cursor: pointer;
	transition: all 0.2s ease;
	margin-bottom: 16px;
}

.pg-product-add-btn:hover {
	background-color: #D4E856;
	color: #000;
	transform: translateY(-2px);
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.15);
}

.pg-product-add-btn:active {
	transform: translateY(0);
}

.pg-product-add-btn:disabled {
	opacity: 0.4;
	cursor: not-allowed;
	background-color: #ccc;
	transform: none;
	box-shadow: none;
}

/* ============================================
   PATAGANG: TRUST STRIP (Faixa de Texto PDP)
   ============================================ */
.pg-trust-strip {
    display: block;
    width: 100%;
    margin-top: 140px; /* Compensação Header Desktop */
    margin-bottom: 0px; /* ZERADO para colar no produto */
    padding: 8px 40px; /* Espaço interno */
    background: transparent;
    z-index: 900;
    border-top: 1px solid #000;
    border-bottom: 1px solid #000;
}

/* Ajuste específico para remover gap do produto quando a barra existe */
#single-product.pg-pdp-container {
    padding-top: 0 !important; /* Remove padding padrão de 30px */
    margin-top: 15px; /* Pequeno respiro controlado apenas se necessário, ou 0 */
}

.pg-trust-strip__content {
    display: flex;
    justify-content: space-between; /* Extremos da tela */
    align-items: center;
    width: 100%;
    max-width: 1400px; /* Trava largura máxima para não esticar demais em telas gigantes */
    margin: 0 auto;
    flex-wrap: nowrap; /* Não quebrar linha */
}

.pg-trust-strip__item {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    color: #000;
    letter-spacing: 1px;
    white-space: nowrap;
    text-align: center;
}

@media (max-width: 992px) {
    .pg-trust-strip {
        margin-top: 120px; /* Ajuste Tablet */
        padding: 0 20px;
    }
    .pg-trust-strip__item {
        font-size: 10px;
    }
}

@media (max-width: 768px) {
    .pg-trust-strip {
        margin-top: 100px; /* Ajuste Mobile */
        padding: 6px 12px;
        height: auto;
    }
    .pg-trust-strip__content {
        display: grid !important;
        grid-template-columns: 1fr auto;
        grid-template-rows: auto auto;
        gap: 4px 12px;
        align-items: center;
    }
    /* Coluna esquerda: textos maiores (1 e 2) */
    .pg-trust-strip__item:nth-child(1),
    .pg-trust-strip__item:nth-child(2) {
        grid-column: 1;
        text-align: left;
        font-size: 9px;
        white-space: normal;
    }
    .pg-trust-strip__item:nth-child(1) { grid-row: 1; }
    .pg-trust-strip__item:nth-child(2) { grid-row: 2; }
    /* Coluna direita: textos menores (3 e 4) */
    .pg-trust-strip__item:nth-child(3),
    .pg-trust-strip__item:nth-child(4) {
        grid-column: 2;
        text-align: right;
        font-size: 9px;
        white-space: nowrap;
    }
    .pg-trust-strip__item:nth-child(3) { grid-row: 1; }
    .pg-trust-strip__item:nth-child(4) { grid-row: 2; }
}

.pg-trust-bar__text {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 11px;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 1px;
	color: #000;
}

.pg-trust-bar__separator {
	color: #ccc;
	font-size: 10px;
}

/* Mobile: Scroll horizontal (Snap) */
@media (max-width: 768px) {
	.pg-trust-bar {
		padding: 10px 0;
		overflow: hidden;
		margin-top: 0; /* No mobile o header é menor/diferente */
		border-left: 0;
		border-right: 0;
	}
	
	.pg-trust-bar__container {
		justify-content: flex-start;
		flex-wrap: nowrap;
		overflow-x: auto;
		gap: 16px;
		padding: 0 16px;
		scroll-snap-type: x mandatory;
		-webkit-overflow-scrolling: touch;
		scrollbar-width: none; /* Firefox */
	}
	
	.pg-trust-bar__container::-webkit-scrollbar {
		display: none; /* Chrome/Safari */
	}
	
	.pg-trust-bar__item {
		flex: 0 0 auto;
		scroll-snap-align: center;
		white-space: nowrap;
	}
	
	.pg-trust-bar__separator {
		display: none; /* Oculta separadores no mobile para limpar visual */
	}
}

/* ============================================
   BANNER CUPOM — Destaque promocional
   ============================================ */
.pg-coupon-banner {
	background: transparent;
	border: 1px solid #e5e5e5;
	border-radius: 8px;
	padding: 12px 16px;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 12px;
	text-align: left;
}

.pg-coupon-banner__highlight {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 13px;
	font-weight: 600;
	color: #000;
	line-height: 1.3;
	margin-bottom: 0;
	flex: 1;
}

.pg-coupon-banner__highlight strong {
	font-size: 14px;
	font-weight: 800;
	display: block; /* Quebra linha pra destacar */
}

/* Logo SVG no lugar do emoji */
.pg-coupon-banner__icon {
	width: 24px;
	height: 24px;
	object-fit: contain;
	flex-shrink: 0;
}

.pg-coupon-banner__code {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 11px;
	color: #666;
	line-height: 1.4;
	margin-top: 2px;
}

.pg-coupon-banner__coupon {
	background: #000;
	color: #fff;
	padding: 2px 6px;
	border-radius: 4px;
	font-size: 11px;
	font-weight: 700;
	letter-spacing: 0.5px;
	margin-left: 2px;
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

/* Formatação do conteúdo do accordion */
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
	display: none !important;
}

/* Containers extras (FB comments) - ocultos quando vazios */
.pg-pdp-extras-container:empty {
	display: none !important;
}
/* NOTA: #reviewsapp NÃO usa :empty - o Konfidency injeta async e precisa do container visível */

.pg-pdp-extras-container,
#reviewsapp {
	background: transparent;
	padding: 0;
	margin: 0;
}

/* Seção Avaliações e Perguntas (Konfidency) - entre produto e similares */
.pg-pdp-reviews-section {
	width: 100%;
	align-self: stretch;
	padding: 24px 0;
}
.pg-pdp-reviews-section .container {
	max-width: 1200px;
	margin: 0 auto;
}

/* Reviews dentro do PDP - ocupa largura para o Konfidency renderizar */
.pg-pdp-container #reviewsapp {
	width: 100%;
	align-self: stretch;
}

/* Ocultar container vazio (FB comments) - NÃO afeta .pg-pdp-reviews-section .container */
.pg-pdp-extras-container:empty {
	display: none !important;
}

/* Responsivo - Tablet e Mobile */
@media (max-width: 991px) {
	.pg-pdp-container {
		padding-top: 80px;
		padding-bottom: 0;
		align-items: flex-start;
		/* BACKGROUND PADRONIZADO #E2E2E2 - Consistente em todo o site */
		background-color: #E2E2E2;
	}

	.pg-pdp-container .section-single-product {
		flex-direction: column !important;
		padding: 20px 15px;
		gap: 20px;
	}

	.pg-pdp-image-col {
		max-width: 100%;
		width: 100% !important;
		padding: 0 !important;
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
		max-width: 100%;
		width: 100% !important;
	}

	.pg-pdp-watermark {
		width: 120px;
		height: 120px;
		opacity: 0.20;
	}

	.pg-pdp-info-card {
		padding: 22px 20px;
		max-width: 100%;
		border-radius: 16px;
	}
}

@media (max-width: 576px) {
	.pg-product-title {
		font-size: 16px;
		letter-spacing: 0.5px;
	}

	.pg-price-pix-highlight {
		font-size: 20px;
	}

	.pg-price-original {
		font-size: 13px;
	}

	.pg-price-installments {
		font-size: 11px;
	}

	.pg-product-add-btn {
		height: 48px;
		font-size: 13px;
	}

	.pg-coupon-banner {
		padding: 14px 16px;
		border-radius: 8px;
	}

	.pg-coupon-banner__highlight {
		font-size: 14px;
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
   SACOLA LATERAL (CART MODAL) - PATAGANG DESIGN
   ============================================ */

/* Modal do carrinho - Estilo similar ao protótipo */
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

/* Botão fechar do modal */
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

/* Botão de remover item */
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

/* Botão Finalizar Compra */
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
   Baseado no protótipo oficial
   ESCOPO: Apenas página de produto (.pg-product-form)
   ============================================ */

.pg-product-form .pg-dev-card {
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

    /* Centralização do conteúdo */
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

/* CONTEÚDO CENTRAL */
.pg-dev-card__content {
    text-align: center;
    z-index: 2;
}

/* TÍTULO */
.pg-dev-card__title {
    font-family: 'Familjen Grotesk', 'Helvetica', 'Arial', sans-serif;
    font-size: 14px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    color: #000;
    margin: 0 0 25px 0;
}

/* BOTÃO */
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

/* Informações do produto abaixo do card */
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
    .pg-product-form .pg-dev-card {
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

/* Garantir que drawer está oculto desde o início */
#nav-drawer {
    visibility: hidden !important;
    pointer-events: none !important;
}

#nav-drawer .pg-drawer__panel {
    transform: translateX(-100%) !important;
}

/* ============================================
   PATAGANG HOME - Anti-FOUC (Critical CSS)
   ============================================ */

/* Ocultar elementos da home até CSS assíncrono carregar */
.hero,
.featured-product,
.coming-soon,
.yellow-gradient-wrapper {
    visibility: hidden !important;
}

/* Mostrar quando CSS assíncrono carregar */
.visible-when-content-ready {
    visibility: visible !important;
}

/* ============================================
   PATAGANG - MODAL CART CRITICAL STYLES
   IMPORTANTE: Inline no critical para garantir aplicação
   ============================================ */

/* Força TODOS os textos em PRETO - Override máximo */
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
    color: #000 !important;
}

/* Remove cores inline amarelas */
#modal-cart [style*="color"] {
    color: #000 !important;
}

/* Tamanho do produto - limpo sem fundo */
#modal-cart .pg-cart-item__variant {
    font-size: 12px !important;
    color: #666 !important;
    font-weight: 400 !important;
    background: transparent !important;
    padding: 0 !important;
    margin-top: 2px;
    display: block;
}

#modal-cart .pg-cart-item__variant::before {
    content: "Tam: ";
    font-weight: 400;
}

/* ===========================================
   SEO: Classe sr-only para acessibilidade
   Esconde visualmente mas mantém para SEO/leitores de tela
   =========================================== */

.sr-only {
    position: absolute !important;
    width: 1px !important;
    height: 1px !important;
    padding: 0 !important;
    margin: -1px !important;
    overflow: hidden !important;
    clip: rect(0, 0, 0, 0) !important;
    white-space: nowrap !important;
    border: 0 !important;
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
/* Listagem (category/search): MÓDULO LISTAGEM em style-async sobrescreve com 56px, #000 */
.pg-page__title,
.pg-search-page__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 400 !important;
    color: #333 !important;
    text-transform: uppercase;
    font-size: 30px !important;
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

/* =========================================
   IMPROVED FILTERS DESIGN (UX/UI 10/10)
   ========================================= */

/* Filter Container */
.filters-container {
    border: none;
    padding: 0;
    margin-bottom: 30px;
}

.filters-container h6 {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 700;
    text-transform: uppercase;
    font-size: 14px;
    letter-spacing: 0.05em;
    margin-bottom: 15px;
    border-bottom: 2px solid #EAFE67; /* Patagang Yellow underline */
    padding-bottom: 8px;
    display: inline-block;
}

/* Filter Items */
.checkbox-container {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.checkbox-container:hover .checkbox-text {
    opacity: 0.7;
}

/* Custom Checkbox */
.checkbox-icon {
    width: 18px;
    height: 18px;
    border: 1px solid #000;
    background: #fff;
    margin-right: 10px;
    position: relative;
    transition: all 0.2s ease;
    border-radius: 4px; /* Soft rounded corners */
}

/* Checked State */
.checkbox input:checked + .checkbox-icon {
    background: #EAFE67; /* Patagang Yellow */
    border-color: #000;
}

.checkbox-icon:after {
    content: '';
    position: absolute;
    left: 5px;
    top: 2px;
    width: 6px;
    height: 10px;
    border: solid #000;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
    opacity: 0;
    transition: opacity 0.2s ease;
}

.checkbox input:checked + .checkbox-icon:after {
    opacity: 1;
}

/* Filter Text */
.checkbox-text {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 500;
    color: #000;
}

/* Color Filters */
.checkbox-color {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    margin-left: auto;
    border: 1px solid rgba(0,0,0,0.1);
}

/* Price Filter */
.price-filter input {
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 8px;
    font-family: 'Familjen Grotesk', sans-serif;
}

.price-filter button {
    background: #000;
    color: #fff;
    border-radius: 4px;
    text-transform: uppercase;
    font-weight: 700;
    font-size: 12px;
    padding: 8px 16px;
    transition: background 0.3s ease;
}

.price-filter button:hover {
    background: #333;
}

/* Chips (Applied Filters) */
.chip {
    background: #EAFE67;
    color: #000;
    font-weight: 600;
    border-radius: 20px;
    padding: 6px 12px;
    font-size: 12px;
    border: 1px solid #000;
    margin-right: 8px;
    margin-bottom: 8px;
    display: inline-flex;
    align-items: center;
    transition: all 0.2s ease;
}

.chip:hover {
    background: #D4E856;
    transform: translateY(-1px);
}

.chip-remove-icon {
    fill: #000;
    margin-left: 6px;
    width: 10px;
    height: 10px;
}

/* Remove all filters link */
.js-remove-all-filters {
    font-size: 12px;
    text-decoration: underline;
    color: #666;
}

/* =========================================
   FILTER BUTTON & SORT DROPDOWN IMPROVEMENTS
   ========================================= */

/* Filter button - clean minimal design */
.filter-link {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 10px 20px;
    background: #fff;
    border: 1px solid #000;
    border-radius: 6px;
    color: #000;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    transition: all 0.2s ease;
    text-decoration: none;
}

.filter-link:hover {
    background: #000;
    color: #EAFE67;
    text-decoration: none;
}

.filter-link .icon-inline {
    width: 14px;
    height: 14px;
    fill: currentColor;
}

/* Sort dropdown - cleaner icon and layout */
.sort-by select,
.form-select {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 12px;
    font-weight: 500;
    padding-right: 30px !important;
}

/* Hide default select arrow and use custom */
select {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>');
    background-repeat: no-repeat;
    background-position: right 8px center;
    background-size: 16px;
}

/* Uppercase for size filter values (Pp -> PP, Gg -> GG, etc) */
.checkbox-text {
    text-transform: uppercase !important;
}

/* Price filter - Add R$ prefix */
.price-filter label {
    position: relative;
}

.price-filter input[type="number"]::before,
.price-filter input[type="text"]::before {
    content: 'R$ ';
    position: absolute;
    left: 12px;
    color: #666;
    font-weight: 500;
}

/* Alternative: Add R$ via pseudo-element on label */
.price-filter label::after {
    content: 'R$';
    position: absolute;
    left: 12px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 12px;
    color: #666;
    pointer-events: none;
    font-family: 'Familjen Grotesk', sans-serif;
}

.price-filter input {
    padding-left: 38px !important; /* Space for R$ */
}

/* PROBLEMA 3: Filter Modal - Match Main Menu Design + Compact */
.modal.filters {
    background: rgba(255, 255, 255, 0.3);
    backdrop-filter: blur(30px);
    -webkit-backdrop-filter: blur(30px);
}

.modal.filters .modal-header {
    background: transparent;
    border-bottom: 2px solid #EAFE67;
    padding: 15px 20px; /* More compact */
}

.modal.filters .modal-header h2,
.modal.filters .modal-header .h2 {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 18px; /* Smaller */
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #000;
    margin: 0;
}

.modal.filters .modal-body {
    padding: 15px 20px; /* More compact */
}

.modal.filters .modal-close {
    color: #000;
    font-size: 24px;
    font-weight: 300;
}

.modal.filters .modal-close:hover {
    color: #666;
}

/* Ensure filter text is visible on glassmorphism background */
.filters-container {
    background: rgba(255, 255, 255, 0.8);
    border-radius: 8px;
    padding: 12px; /* More compact */
    margin-bottom: 15px; /* Reduced spacing */
}

.filters-container h6 {
    color: #000 !important;
    font-size: 13px !important; /* Smaller */
    margin-bottom: 10px !important; /* Compact */
}

.checkbox-container {
    background: rgba(255, 255, 255, 0.5);
    border-radius: 6px;
    padding: 6px 10px; /* More compact */
    margin-bottom: 6px; /* Reduced spacing */
}

.checkbox-text {
    color: #000 !important;
    font-weight: 500;
    font-size: 12px !important; /* Smaller */
}

/* PROBLEMA 3: Centralize filter and sort controls side by side */
.category-controls,
.js-category-controls {
    display: flex !important;
    justify-content: center !important;
    align-items: center !important;
    gap: 20px !important;
    max-width: 600px;
    margin: 0 auto 30px auto !important;
}

.category-controls > div,
.js-category-controls > div {
    flex: 0 0 auto !important;
    width: auto !important;
}

/* Filter button - smaller and cleaner */
.filter-link {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 8px 16px !important; /* Smaller */
    background: #fff;
    border: 1px solid #000;
    border-radius: 6px;
    color: #000;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 11px !important; /* Smaller */
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    transition: all 0.2s ease;
    text-decoration: none;
    white-space: nowrap;
}

.filter-link:hover {
    background: #000;
    color: #EAFE67;
    text-decoration: none;
}

.filter-link .icon-inline {
    width: 12px;
    height: 12px;
    fill: currentColor;
}

/* PROBLEMA 3: ORDENAÇÃO PADRONIZADA (Igual ao botão Filtrar) */
.sort-by {
    margin: 0 !important;
    display: inline-block;
}

.sort-by select,
.form-select {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;

    /* Layout Box igual ao botão Filtrar */
    background-color: #fff !important;
    border: 1px solid #000 !important;
    border-radius: 6px !important;
    padding: 8px 35px 8px 16px !important; /* Espaço extra na direita para a seta */
    height: auto !important;

    /* Tipografia igual ao botão Filtrar */
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 11px !important;
    font-weight: 600 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.05em !important;
    color: #000 !important;

    /* Ícone de Seta (Chevron Down) customizado */
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23000000' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E") !important;
    background-repeat: no-repeat !important;
    background-position: right 10px center !important;
    background-size: 12px !important;

    cursor: pointer;
    min-width: 160px;
    max-width: 220px;
    box-shadow: none !important;
    outline: none !important;
}

.sort-by select:hover {
    background-color: #000 !important;
    color: #EAFE67 !important;
    border-color: #000 !important;
    /* Inverte a cor da seta no hover */
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23EAFE67' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E") !important;
}

/* Centralizar controles */
.category-controls {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 15px;
    margin-bottom: 30px;
}

/* PROBLEMA 2: REMOVER ÍCONE ANTIGO DA ORDENAÇÃO (Seletor mais específico e agressivo) */
.sort-by .form-select-icon,
.js-sort-by .form-select-icon,
.search-controls .form-select-icon,
.category-controls .form-select-icon,
.form-group .form-select-icon {
    display: none !important;
    visibility: hidden !important;
    opacity: 0 !important;
    width: 0 !important;
}

/* CSS LEGADO REMOVIDO - Sistema de busca unificado no bloco MOBILE SEARCH FIX acima */

/* ============================================================================
   PATAGANG - Grid de 2 Colunas de Imagens (Desktop)
   Layout similar ZêDog - fotos lado a lado com card à direita
============================================================================ */

/* Container principal do grid */
.pg-gallery-container {
    position: relative;
    width: 100%;
    padding: 16px;
}

/* Grid de 2 colunas */
.pg-gallery-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 8px;
    width: 100%;
}

/* Cada item do grid */
.pg-gallery-item {
    position: relative;
    width: 100%;
    overflow: hidden;
    background: #f5f5f5;
    border-radius: 4px;
    aspect-ratio: 1 / 1; /* Quadrado como na referência */
}

/* Link clicável */
.pg-gallery-link {
    display: block;
    position: absolute;
    inset: 0;
    cursor: zoom-in;
}

/* Imagem - preenche o quadrado */
.pg-gallery-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
    transition: transform 0.3s ease;
}

/* Hover effect - sutil */
.pg-gallery-link:hover .pg-gallery-img {
    transform: scale(1.03);
}

/* Ícone de zoom */
.pg-gallery-zoom-icon {
    position: absolute;
    bottom: 10px;
    right: 10px;
    width: 32px;
    height: 32px;
    background: rgba(255, 255, 255, 0.9);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.2s ease;
    color: #333;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.pg-gallery-link:hover .pg-gallery-zoom-icon {
    opacity: 1;
}

/* ============================================================================
   PATAGANG - Modal Customizado com Thumbnails Laterais
============================================================================ */

/* Modal Overlay */
.pg-modal-gallery {
    position: fixed;
    inset: 0;
    z-index: 99999;
    display: none;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.pg-modal-gallery.is-open {
    display: flex;
    opacity: 1;
}

/* Backdrop */
.pg-modal-backdrop {
    position: absolute;
    inset: 0;
    background: rgba(255, 255, 255, 0.98);
    cursor: pointer;
}

/* Container principal */
.pg-modal-container {
    position: relative;
    display: flex;
    width: 100%;
    height: 100%;
    padding: 20px;
    z-index: 1;
}

/* Sidebar com Thumbnails */
.pg-modal-sidebar {
    width: 90px;
    flex-shrink: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding-right: 20px;
}

/* Container dos thumbnails com scroll */
.pg-modal-thumbs {
    display: flex;
    flex-direction: column;
    gap: 10px;
    max-height: 100%;
    overflow-y: auto;
    padding: 10px 0;
    scrollbar-width: thin;
    scrollbar-color: rgba(0, 0, 0, 0.2) transparent;
}

.pg-modal-thumbs::-webkit-scrollbar {
    width: 4px;
}

.pg-modal-thumbs::-webkit-scrollbar-track {
    background: transparent;
}

.pg-modal-thumbs::-webkit-scrollbar-thumb {
    background: rgba(0, 0, 0, 0.2);
    border-radius: 4px;
}

/* Cada thumbnail */
.pg-modal-thumb {
    width: 64px;
    height: 64px;
    border: 2px solid transparent;
    border-radius: 8px;
    overflow: hidden;
    cursor: pointer;
    background: #f5f5f5;
    padding: 0;
    transition: all 0.2s ease;
    opacity: 0.6;
    flex-shrink: 0;
}

.pg-modal-thumb:hover {
    opacity: 0.85;
    border-color: rgba(0, 0, 0, 0.2);
}

.pg-modal-thumb.is-active {
    opacity: 1;
    border-color: #000;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.pg-modal-thumb img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}

/* Área da imagem principal */
.pg-modal-main {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
}

/* Imagem principal */
.pg-modal-main-img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    transition: opacity 0.2s ease;
}

/* Navegação com setas */
.pg-modal-nav {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 50px;
    height: 50px;
    background: rgba(255, 255, 255, 0.9);
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #333;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    transition: all 0.2s ease;
    z-index: 10;
}

.pg-modal-nav:hover {
    background: #fff;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
}

.pg-modal-nav--prev {
    left: 10px;
}

.pg-modal-nav--next {
    right: 10px;
}

/* Botão fechar */
.pg-modal-close {
    position: absolute;
    top: 20px;
    right: 20px;
    width: 44px;
    height: 44px;
    background: rgba(255, 255, 255, 0.9);
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #333;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    transition: all 0.2s ease;
    z-index: 10;
}

.pg-modal-close:hover {
    background: #fff;
    transform: scale(1.05);
}

/* Contador */
.pg-modal-counter {
    position: absolute;
    top: 20px;
    left: 50%;
    transform: translateX(-50%);
    font-size: 14px;
    font-weight: 500;
    color: #666;
    background: rgba(255, 255, 255, 0.9);
    padding: 6px 16px;
    border-radius: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* ============================================================================
   Responsivo - Mobile
============================================================================ */

@media (max-width: 991px) {
    /* Modal em fullscreen no mobile */
    .pg-modal-container {
        flex-direction: column;
        padding: 10px;
    }

    /* Thumbnails na parte inferior */
    .pg-modal-sidebar {
        width: 100%;
        order: 2;
        padding: 10px 0 0;
        flex-direction: row;
        justify-content: center;
    }

    .pg-modal-thumbs {
        flex-direction: row;
        overflow-x: auto;
        overflow-y: hidden;
        max-width: 100%;
        gap: 8px;
        padding: 0;
    }

    .pg-modal-thumb {
        width: 52px;
        height: 52px;
    }

    .pg-modal-main {
        order: 1;
        flex: 1;
    }

    /* Setas menores */
    .pg-modal-nav {
        width: 40px;
        height: 40px;
    }

    .pg-modal-close {
        top: 10px;
        right: 10px;
        width: 40px;
        height: 40px;
    }

    .pg-modal-counter {
        top: 10px;
    }
}



/* FIM DOS ESTILOS PATAGANG */










/* Forçar o carousel a NÃO usar transformações horizontais */
.pg-fancybox-gallery .fancybox__thumbs .carousel,
.pg-fancybox-gallery .fancybox__thumbs .f-carousel {
    width: 100% !important;
    height: auto !important;
    max-height: 60vh !important;
    overflow-y: auto !important;
    overflow-x: hidden !important;
}

/* Viewport - contém os slides */
.pg-fancybox-gallery .fancybox__thumbs .carousel__viewport,
.pg-fancybox-gallery .fancybox__thumbs .f-carousel__viewport {
    width: 100% !important;
    height: auto !important;
    max-height: 60vh !important;
    overflow-y: auto !important;
    overflow-x: hidden !important;
}

/* Track - CRÍTICO: forçar display flex em coluna e remover transforms */
.pg-fancybox-gallery .fancybox__thumbs .carousel__track,
.pg-fancybox-gallery .fancybox__thumbs .f-carousel__track {
    display: flex !important;
    flex-direction: column !important;
    flex-wrap: nowrap !important;
    gap: 8px !important;
    width: 100% !important;
    height: auto !important;
    transform: none !important;
    transition: none !important;
    position: relative !important;
}

/* Cada slide - CRÍTICO: posição relativa, não absoluta */
.pg-fancybox-gallery .fancybox__thumbs .carousel__slide,
.pg-fancybox-gallery .fancybox__thumbs .f-carousel__slide {
    position: relative !important;
    width: 56px !important;
    height: 56px !important;
    min-height: 56px !important;
    max-height: 56px !important;
    flex: 0 0 56px !important;
    padding: 0 !important;
    margin: 0 auto !important;
    transform: none !important;
    left: auto !important;
    top: auto !important;
}

/* Scrollbar sutil */
.pg-fancybox-gallery .fancybox__thumbs::-webkit-scrollbar {
    width: 4px;
}

.pg-fancybox-gallery .fancybox__thumbs::-webkit-scrollbar-track {
    background: transparent;
}

.pg-fancybox-gallery .fancybox__thumbs::-webkit-scrollbar-thumb {
    background: rgba(0, 0, 0, 0.15);
    border-radius: 4px;
}

/* Container de cada thumbnail */
.pg-fancybox-gallery .fancybox__thumb {
    width: 56px !important;
    height: 56px !important;
    min-width: 56px !important;
    min-height: 56px !important;
    border-radius: 6px !important;
    overflow: hidden !important;
    opacity: 0.5 !important;
    cursor: pointer !important;
    transition: opacity 0.2s ease, border-color 0.2s ease !important;
    border: 2px solid transparent !important;
    display: block !important;
    background: #f5f5f5 !important;
}

.pg-fancybox-gallery .fancybox__thumb:hover {
    opacity: 0.85 !important;
    border-color: rgba(0, 0, 0, 0.25) !important;
}

/* Thumbnail ativo */
.pg-fancybox-gallery .fancybox__thumb.is-nav-selected,
.pg-fancybox-gallery .fancybox__thumb.is-selected,
.pg-fancybox-gallery .fancybox__thumb[aria-current="true"] {
    opacity: 1 !important;
    border-color: #000 !important;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2) !important;
}

/* Imagem dentro do thumbnail */
.pg-fancybox-gallery .fancybox__thumb img {
    width: 100% !important;
    height: 100% !important;
    object-fit: cover !important;
    display: block !important;
}

/* ============================================================================
   Toolbar - Estilo minimalista
============================================================================ */

.pg-fancybox-gallery .fancybox__toolbar {
    background: transparent !important;
    padding: 16px 20px !important;
}

/* Botões da toolbar */
.pg-fancybox-gallery .fancybox__button {
    background: rgba(255, 255, 255, 0.9) !important;
    border-radius: 50% !important;
    width: 40px !important;
    height: 40px !important;
    color: #333 !important;
    transition: all 0.2s ease !important;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1) !important;
}

.pg-fancybox-gallery .fancybox__button:hover {
    background: #fff !important;
    color: #000 !important;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15) !important;
}

/* Contador de slides */
.pg-fancybox-gallery .fancybox__counter {
    color: #333 !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 14px !important;
    font-weight: 500 !important;
    background: rgba(255, 255, 255, 0.9) !important;
    padding: 6px 14px !important;
    border-radius: 20px !important;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1) !important;
}

/* ============================================================================
   Navegação - setas laterais
============================================================================ */

.pg-fancybox-gallery .fancybox__nav {
    padding: 0 !important;
}

.pg-fancybox-gallery .fancybox__button--prev,
.pg-fancybox-gallery .fancybox__button--next {
    width: 50px !important;
    height: 50px !important;
    background: rgba(255, 255, 255, 0.95) !important;
    border-radius: 50% !important;
    color: #333 !important;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12) !important;
    transition: all 0.2s ease !important;
}

.pg-fancybox-gallery .fancybox__button--prev:hover,
.pg-fancybox-gallery .fancybox__button--next:hover {
    background: #fff !important;
    color: #000 !important;
    transform: scale(1.05) !important;
}

/* Posição das setas - ajustada para não sobrepor thumbnails */
.pg-fancybox-gallery .fancybox__button--prev {
    left: 120px !important;
}

.pg-fancybox-gallery .fancybox__button--next {
    right: 20px !important;
}

/* ============================================================================
   Responsivo - Mobile
============================================================================ */

@media (max-width: 767px) {
    /* Em mobile, thumbnails ficam na parte inferior */
    .pg-fancybox-gallery .fancybox__carousel {
        padding-left: 0 !important;
        padding-bottom: 90px !important;
    }

    .pg-fancybox-gallery .fancybox__thumbs {
        position: fixed !important;
        left: 50% !important;
        top: auto !important;
        bottom: 20px !important;
        transform: translateX(-50%) !important;
        width: auto !important;
        max-width: 90vw !important;
        height: 60px !important;
        max-height: none !important;
        flex-direction: row !important;
        overflow-x: auto !important;
        overflow-y: hidden !important;
        padding: 8px 12px !important;
    }

    .pg-fancybox-gallery .fancybox__thumb {
        width: 44px !important;
        height: 44px !important;
        min-width: 44px !important;
    }

    /* Setas em mobile */
    .pg-fancybox-gallery .fancybox__button--prev {
        left: 10px !important;
    }

    .pg-fancybox-gallery .fancybox__button--next {
        right: 10px !important;
    }

    .pg-fancybox-gallery .fancybox__button--prev,
    .pg-fancybox-gallery .fancybox__button--next {
        width: 40px !important;
        height: 40px !important;
    }
}

/* Tablet - ajustes */
@media (min-width: 768px) and (max-width: 991px) {
    .pg-fancybox-gallery .fancybox__thumbs {
        width: 60px !important;
        left: 15px !important;
    }

    .pg-fancybox-gallery .fancybox__thumb {
        width: 46px !important;
        height: 46px !important;
        min-width: 46px !important;
    }

    .pg-fancybox-gallery .fancybox__carousel {
        padding-left: 85px !important;
    }

    .pg-fancybox-gallery .fancybox__button--prev {
        left: 95px !important;
    }
}

/* REMOVIDO: .page-header não existe no DOM atual.
   category.tpl e search.tpl usam .pg-search-page__header.
   Listagem controlada pelo MÓDULO LISTAGEM em style-async. */
