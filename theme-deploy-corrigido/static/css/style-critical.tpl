{% raw %}@charset "UTF-8":

/*============================================================================
critical-css.tpl

    -This file contains all the theme critical styles wich will be loaded inline before the rest of the site
    -Rest of styling can be found in:
    	--static/css/style-async.css.tpl --> For non critical styles witch will be loaded asynchronously
      --static/css/style-colors.scss.tpl --> For color and font styles related to config/settings.txt

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

/*============================================================================
  #External CSS libraries and plugins
==============================================================================*/

{# /* // Bootstrap Grid v4.1.3 */ #}

@-ms-viewport{width:device-width}html{box-sizing:border-box;-ms-overflow-style:scrollbar}*,::after,::before{box-sizing:inherit}.container{width:100%;padding-right:15px;padding-left:15px;margin-right:auto;margin-left:auto}@media (min-width:576px){.container{max-width:540px}}@media (min-width:768px){.container{max-width:720px}}@media (min-width:992px){.container{max-width:960px}}@media (min-width:1200px){.container{max-width:1140px}}.container-fluid{width:100%;padding-right:15px;padding-left:15px;margin-right:auto;margin-left:auto}.row{display:-ms-flexbox;display:flex;-ms-flex-wrap:wrap;flex-wrap:wrap;margin-right:-15px;margin-left:-15px}.no-gutters{margin-right:0;margin-left:0}.no-gutters>.col,.no-gutters>[class*=col-]{padding-right:0;padding-left:0}.col,.col-1,.col-10,.col-11,.col-12,.col-2,.col-3,.col-4,.col-5,.col-6,.col-7,.col-8,.col-9,.col-auto,.col-lg,.col-lg-1,.col-lg-10,.col-lg-11,.col-lg-12,.col-lg-2,.col-lg-3,.col-lg-4,.col-lg-5,.col-lg-6,.col-lg-7,.col-lg-8,.col-lg-9,.col-lg-auto,.col-md,.col-md-1,.col-md-10,.col-md-11,.col-md-12,.col-md-2,.col-md-3,.col-md-4,.col-md-5,.col-md-6,.col-md-7,.col-md-8,.col-md-9,.col-md-auto,.col-sm,.col-sm-1,.col-sm-10,.col-sm-11,.col-sm-12,.col-sm-2,.col-sm-3,.col-sm-4,.col-sm-5,.col-sm-6,.col-sm-7,.col-sm-8,.col-sm-9,.col-sm-auto,.col-xl,.col-xl-1,.col-xl-10,.col-xl-11,.col-xl-12,.col-xl-2,.col-xl-3,.col-xl-4,.col-xl-5,.col-xl-6,.col-xl-7,.col-xl-8,.col-xl-9,.col-xl-auto{position:relative;width:100%;min-height:1px;padding-right:15px;padding-left:15px}.col{-ms-flex-preferred-size:0;flex-basis:0;-ms-flex-positive:1;flex-grow:1;max-width:100%}.col-auto{-ms-flex:0 0 auto;flex:0 0 auto;width:auto;max-width:none}.col-1{-ms-flex:0 0 8.333333%;flex:0 0 8.333333%;max-width:8.333333%}.col-2{-ms-flex:0 0 16.666667%;flex:0 0 16.666667%;max-width:16.666667%}.col-3{-ms-flex:0 0 25%;flex:0 0 25%;max-width:25%}.col-4{-ms-flex:0 0 33.333333%;flex:0 0 33.333333%;max-width:33.333333%}.col-5{-ms-flex:0 0 41.666667%;flex:0 0 41.666667%;max-width:41.666667%}.col-6{-ms-flex:0 0 50%;flex:0 0 50%;max-width:50%}.col-7{-ms-flex:0 0 58.333333%;flex:0 0 58.333333%;max-width:58.333333%}.col-8{-ms-flex:0 0 66.666667%;flex:0 0 66.666667%;max-width:66.666667%}.col-9{-ms-flex:0 0 75%;flex:0 0 75%;max-width:75%}.col-10{-ms-flex:0 0 83.333333%;flex:0 0 83.333333%;max-width:83.333333%}.col-11{-ms-flex:0 0 91.666667%;flex:0 0 91.666667%;max-width:91.666667%}.col-12{-ms-flex:0 0 100%;flex:0 0 100%;max-width:100%}.order-first{-ms-flex-order:-1;order:-1}.order-last{-ms-flex-order:13;order:13}.order-0{-ms-flex-order:0;order:0}.order-1{-ms-flex-order:1;order:1}.order-2{-ms-flex-order:2;order:2}.order-3{-ms-flex-order:3;order:3}.order-4{-ms-flex-order:4;order:4}.order-5{-ms-flex-order:5;order:5}.order-6{-ms-flex-order:6;order:6}.order-7{-ms-flex-order:7;order:7}.order-8{-ms-flex-order:8;order:8}.order-9{-ms-flex-order:9;order:9}.order-10{-ms-flex-order:10;order:10}.order-11{-ms-flex-order:11;order:11}.order-12{-ms-flex-order:12;order:12}.offset-1{margin-left:8.333333%}.offset-2{margin-left:16.666667%}.offset-3{margin-left:25%}.offset-4{margin-left:33.333333%}.offset-5{margin-left:41.666667%}.offset-6{margin-left:50%}.offset-7{margin-left:58.333333%}.offset-8{margin-left:66.666667%}.offset-9{margin-left:75%}.offset-10{margin-left:83.333333%}.offset-11{margin-left:91.666667%}@media (min-width:576px){.col-sm{-ms-flex-preferred-size:0;flex-basis:0;-ms-flex-positive:1;flex-grow:1;max-width:100%}.col-sm-auto{-ms-flex:0 0 auto;flex:0 0 auto;width:auto;max-width:none}.col-sm-1{-ms-flex:0 0 8.333333%;flex:0 0 8.333333%;max-width:8.333333%}.col-sm-2{-ms-flex:0 0 16.666667%;flex:0 0 16.666667%;max-width:16.666667%}.col-sm-3{-ms-flex:0 0 25%;flex:0 0 25%;max-width:25%}.col-sm-4{-ms-flex:0 0 33.333333%;flex:0 0 33.333333%;max-width:33.333333%}.col-sm-5{-ms-flex:0 0 41.666667%;flex:0 0 41.666667%;max-width:41.666667%}.col-sm-6{-ms-flex:0 0 50%;flex:0 0 50%;max-width:50%}.col-sm-7{-ms-flex:0 0 58.333333%;flex:0 0 58.333333%;max-width:58.333333%}.col-sm-8{-ms-flex:0 0 66.666667%;flex:0 0 66.666667%;max-width:66.666667%}.col-sm-9{-ms-flex:0 0 75%;flex:0 0 75%;max-width:75%}.col-sm-10{-ms-flex:0 0 83.333333%;flex:0 0 83.333333%;max-width:83.333333%}.col-sm-11{-ms-flex:0 0 91.666667%;flex:0 0 91.666667%;max-width:91.666667%}.col-sm-12{-ms-flex:0 0 100%;flex:0 0 100%;max-width:100%}.order-sm-first{-ms-flex-order:-1;order:-1}.order-sm-last{-ms-flex-order:13;order:13}.order-sm-0{-ms-flex-order:0;order:0}.order-sm-1{-ms-flex-order:1;order:1}.order-sm-2{-ms-flex-order:2;order:2}.order-sm-3{-ms-flex-order:3;order:3}.order-sm-4{-ms-flex-order:4;order:4}.order-sm-5{-ms-flex-order:5;order:5}.order-sm-6{-ms-flex-order:6;order:6}.order-sm-7{-ms-flex-order:7;order:7}.order-sm-8{-ms-flex-order:8;order:8}.order-sm-9{-ms-flex-order:9;order:9}.order-sm-10{-ms-flex-order:10;order:10}.order-sm-11{-ms-flex-order:11;order:11}.order-sm-12{-ms-flex-order:12;order:12}.offset-sm-0{margin-left:0}.offset-sm-1{margin-left:8.333333%}.offset-sm-2{margin-left:16.666667%}.offset-sm-3{margin-left:25%}.offset-sm-4{margin-left:33.333333%}.offset-sm-5{margin-left:41.666667%}.offset-sm-6{margin-left:50%}.offset-sm-7{margin-left:58.333333%}.offset-sm-8{margin-left:66.666667%}.offset-sm-9{margin-left:75%}.offset-sm-10{margin-left:83.333333%}.offset-sm-11{margin-left:91.666667%}}@media (min-width:768px){.col-md{-ms-flex-preferred-size:0;flex-basis:0;-ms-flex-positive:1;flex-grow:1;max-width:100%}.col-md-auto{-ms-flex:0 0 auto;flex:0 0 auto;width:auto;max-width:none}.col-md-1{-ms-flex:0 0 8.333333%;flex:0 0 8.333333%;max-width:8.333333%}.col-md-2{-ms-flex:0 0 16.666667%;flex:0 0 16.666667%;max-width:16.666667%}.col-md-3{-ms-flex:0 0 25%;flex:0 0 25%;max-width:25%}.col-md-4{-ms-flex:0 0 33.333333%;flex:0 0 33.333333%;max-width:33.333333%}.col-md-5{-ms-flex:0 0 41.666667%;flex:0 0 41.666667%;max-width:41.666667%}.col-md-6{-ms-flex:0 0 50%;flex:0 0 50%;max-width:50%}.col-md-7{-ms-flex:0 0 58.333333%;flex:0 0 58.333333%;max-width:58.333333%}.col-md-8{-ms-flex:0 0 66.666667%;flex:0 0 66.666667%;max-width:66.666667%}.col-md-9{-ms-flex:0 0 75%;flex:0 0 75%;max-width:75%}.col-md-10{-ms-flex:0 0 83.333333%;flex:0 0 83.333333%;max-width:83.333333%}.col-md-11{-ms-flex:0 0 91.666667%;flex:0 0 91.666667%;max-width:91.666667%}.col-md-12{-ms-flex:0 0 100%;flex:0 0 100%;max-width:100%}.order-md-first{-ms-flex-order:-1;order:-1}.order-md-last{-ms-flex-order:13;order:13}.order-md-0{-ms-flex-order:0;order:0}.order-md-1{-ms-flex-order:1;order:1}.order-md-2{-ms-flex-order:2;order:2}.order-md-3{-ms-flex-order:3;order:3}.order-md-4{-ms-flex-order:4;order:4}.order-md-5{-ms-flex-order:5;order:5}.order-md-6{-ms-flex-order:6;order:6}.order-md-7{-ms-flex-order:7;order:7}.order-md-8{-ms-flex-order:8;order:8}.order-md-9{-ms-flex-order:9;order:9}.order-md-10{-ms-flex-order:10;order:10}.order-md-11{-ms-flex-order:11;order:11}.order-md-12{-ms-flex-order:12;order:12}.offset-md-0{margin-left:0}.offset-md-1{margin-left:8.333333%}.offset-md-2{margin-left:16.666667%}.offset-md-3{margin-left:25%}.offset-md-4{margin-left:33.333333%}.offset-md-5{margin-left:41.666667%}.offset-md-6{margin-left:50%}.offset-md-7{margin-left:58.333333%}.offset-md-8{margin-left:66.666667%}.offset-md-9{margin-left:75%}.offset-md-10{margin-left:83.333333%}.offset-md-11{margin-left:91.666667%}}@media (min-width:992px){.col-lg{-ms-flex-preferred-size:0;flex-basis:0;-ms-flex-positive:1;flex-grow:1;max-width:100%}.col-lg-auto{-ms-flex:0 0 auto;flex:0 0 auto;width:auto;max-width:none}.col-lg-1{-ms-flex:0 0 8.333333%;flex:0 0 8.333333%;max-width:8.333333%}.col-lg-2{-ms-flex:0 0 16.666667%;flex:0 0 16.666667%;max-width:16.666667%}.col-lg-3{-ms-flex:0 0 25%;flex:0 0 25%;max-width:25%}.col-lg-4{-ms-flex:0 0 33.333333%;flex:0 0 33.333333%;max-width:33.333333%}.col-lg-5{-ms-flex:0 0 41.666667%;flex:0 0 41.666667%;max-width:41.666667%}.col-lg-6{-ms-flex:0 0 50%;flex:0 0 50%;max-width:50%}.col-lg-7{-ms-flex:0 0 58.333333%;flex:0 0 58.333333%;max-width:58.333333%}.col-lg-8{-ms-flex:0 0 66.666667%;flex:0 0 66.666667%;max-width:66.666667%}.col-lg-9{-ms-flex:0 0 75%;flex:0 0 75%;max-width:75%}.col-lg-10{-ms-flex:0 0 83.333333%;flex:0 0 83.333333%;max-width:83.333333%}.col-lg-11{-ms-flex:0 0 91.666667%;flex:0 0 91.666667%;max-width:91.666667%}.col-lg-12{-ms-flex:0 0 100%;flex:0 0 100%;max-width:100%}.order-lg-first{-ms-flex-order:-1;order:-1}.order-lg-last{-ms-flex-order:13;order:13}.order-lg-0{-ms-flex-order:0;order:0}.order-lg-1{-ms-flex-order:1;order:1}.order-lg-2{-ms-flex-order:2;order:2}.order-lg-3{-ms-flex-order:3;order:3}.order-lg-4{-ms-flex-order:4;order:4}.order-lg-5{-ms-flex-order:5;order:5}.order-lg-6{-ms-flex-order:6;order:6}.order-lg-7{-ms-flex-order:7;order:7}.order-lg-8{-ms-flex-order:8;order:8}.order-lg-9{-ms-flex-order:9;order:9}.order-lg-10{-ms-flex-order:10;order:10}.order-lg-11{-ms-flex-order:11;order:11}.order-lg-12{-ms-flex-order:12;order:12}.offset-lg-0{margin-left:0}.offset-lg-1{margin-left:8.333333%}.offset-lg-2{margin-left:16.666667%}.offset-lg-3{margin-left:25%}.offset-lg-4{margin-left:33.333333%}.offset-lg-5{margin-left:41.666667%}.offset-lg-6{margin-left:50%}.offset-lg-7{margin-left:58.333333%}.offset-lg-8{margin-left:66.666667%}.offset-lg-9{margin-left:75%}.offset-lg-10{margin-left:83.333333%}.offset-lg-11{margin-left:91.666667%}}@media (min-width:1200px){.col-xl{-ms-flex-preferred-size:0;flex-basis:0;-ms-flex-positive:1;flex-grow:1;max-width:100%}.col-xl-auto{-ms-flex:0 0 auto;flex:0 0 auto;width:auto;max-width:none}.col-xl-1{-ms-flex:0 0 8.333333%;flex:0 0 8.333333%;max-width:8.333333%}.col-xl-2{-ms-flex:0 0 16.666667%;flex:0 0 16.666667%;max-width:16.666667%}.col-xl-3{-ms-flex:0 0 25%;flex:0 0 25%;max-width:25%}.col-xl-4{-ms-flex:0 0 33.333333%;flex:0 0 33.333333%;max-width:33.333333%}.col-xl-5{-ms-flex:0 0 41.666667%;flex:0 0 41.666667%;max-width:41.666667%}.col-xl-6{-ms-flex:0 0 50%;flex:0 0 50%;max-width:50%}.col-xl-7{-ms-flex:0 0 58.333333%;flex:0 0 58.333333%;max-width:58.333333%}.col-xl-8{-ms-flex:0 0 66.666667%;flex:0 0 66.666667%;max-width:66.666667%}.col-xl-9{-ms-flex:0 0 75%;flex:0 0 75%;max-width:75%}.col-xl-10{-ms-flex:0 0 83.333333%;flex:0 0 83.333333%;max-width:83.333333%}.col-xl-11{-ms-flex:0 0 91.666667%;flex:0 0 91.666667%;max-width:91.666667%}.col-xl-12{-ms-flex:0 0 100%;flex:0 0 100%;max-width:100%}.order-xl-first{-ms-flex-order:-1;order:-1}.order-xl-last{-ms-flex-order:13;order:13}.order-xl-0{-ms-flex-order:0;order:0}.order-xl-1{-ms-flex-order:1;order:1}.order-xl-2{-ms-flex-order:2;order:2}.order-xl-3{-ms-flex-order:3;order:3}.order-xl-4{-ms-flex-order:4;order:4}.order-xl-5{-ms-flex-order:5;order:5}.order-xl-6{-ms-flex-order:6;order:6}.order-xl-7{-ms-flex-order:7;order:7}.order-xl-8{-ms-flex-order:8;order:8}.order-xl-9{-ms-flex-order:9;order:9}.order-xl-10{-ms-flex-order:10;order:10}.order-xl-11{-ms-flex-order:11;order:11}.order-xl-12{-ms-flex-order:12;order:12}.offset-xl-0{margin-left:0}.offset-xl-1{margin-left:8.333333%}.offset-xl-2{margin-left:16.666667%}.offset-xl-3{margin-left:25%}.offset-xl-4{margin-left:33.333333%}.offset-xl-5{margin-left:41.666667%}.offset-xl-6{margin-left:50%}.offset-xl-7{margin-left:58.333333%}.offset-xl-8{margin-left:66.666667%}.offset-xl-9{margin-left:75%}.offset-xl-10{margin-left:83.333333%}.offset-xl-11{margin-left:91.666667%}}.d-none{display:none}.d-inline{display:inline}.d-inline-block{display:inline-block}.d-block{display:block}.d-table{display:table}.d-table-row{display:table-row}.d-table-cell{display:table-cell}.d-flex{display:-ms-flexbox;display:flex}.d-inline-flex{display:-ms-inline-flexbox;display:inline-flex}@media (min-width:576px){.d-sm-none{display:none}.d-sm-inline{display:inline}.d-sm-inline-block{display:inline-block}.d-sm-block{display:block}.d-sm-table{display:table}.d-sm-table-row{display:table-row}.d-sm-table-cell{display:table-cell}.d-sm-flex{display:-ms-flexbox;display:flex}.d-sm-inline-flex{display:-ms-inline-flexbox;display:inline-flex}}@media (min-width:768px){.d-md-none{display:none}.d-md-inline{display:inline}.d-md-inline-block{display:inline-block}.d-md-block{display:block}.d-md-table{display:table}.d-md-table-row{display:table-row}.d-md-table-cell{display:table-cell}.d-md-flex{display:-ms-flexbox;display:flex}.d-md-inline-flex{display:-ms-inline-flexbox;display:inline-flex}}@media (min-width:992px){.d-lg-none{display:none}.d-lg-inline{display:inline}.d-lg-inline-block{display:inline-block}.d-lg-block{display:block}.d-lg-table{display:table}.d-lg-table-row{display:table-row}.d-lg-table-cell{display:table-cell}.d-lg-flex{display:-ms-flexbox;display:flex}.d-lg-inline-flex{display:-ms-inline-flexbox;display:inline-flex}}@media (min-width:1200px){.d-xl-none{display:none}.d-xl-inline{display:inline}.d-xl-inline-block{display:inline-block}.d-xl-block{display:block}.d-xl-table{display:table}.d-xl-table-row{display:table-row}.d-xl-table-cell{display:table-cell}.d-xl-flex{display:-ms-flexbox;display:flex}.d-xl-inline-flex{display:-ms-inline-flexbox;display:inline-flex}}@media print{.d-print-none{display:none}.d-print-inline{display:inline}.d-print-inline-block{display:inline-block}.d-print-block{display:block}.d-print-table{display:table}.d-print-table-row{display:table-row}.d-print-table-cell{display:table-cell}.d-print-flex{display:-ms-flexbox;display:flex}.d-print-inline-flex{display:-ms-inline-flexbox;display:inline-flex}}.flex-row{-ms-flex-direction:row;flex-direction:row}.flex-column{-ms-flex-direction:column;flex-direction:column}.flex-row-reverse{-ms-flex-direction:row-reverse;flex-direction:row-reverse}.flex-column-reverse{-ms-flex-direction:column-reverse;flex-direction:column-reverse}.flex-wrap{-ms-flex-wrap:wrap;flex-wrap:wrap}.flex-nowrap{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.flex-wrap-reverse{-ms-flex-wrap:wrap-reverse;flex-wrap:wrap-reverse}.flex-fill{-ms-flex:1 1 auto;flex:1 1 auto}.flex-grow-0{-ms-flex-positive:0;flex-grow:0}.flex-grow-1{-ms-flex-positive:1;flex-grow:1}.flex-shrink-0{-ms-flex-negative:0;flex-shrink:0}.flex-shrink-1{-ms-flex-negative:1;flex-shrink:1}.justify-content-start{-ms-flex-pack:start;justify-content:flex-start}.justify-content-end{-ms-flex-pack:end;justify-content:flex-end}.justify-content-center{-ms-flex-pack:center;justify-content:center}.justify-content-between{-ms-flex-pack:justify;justify-content:space-between}.justify-content-around{-ms-flex-pack:distribute;justify-content:space-around}.align-items-start{-ms-flex-align:start;align-items:flex-start}.align-items-end{-ms-flex-align:end;align-items:flex-end}.align-items-center{-ms-flex-align:center;align-items:center}.align-items-baseline{-ms-flex-align:baseline;align-items:baseline}.align-items-stretch{-ms-flex-align:stretch;align-items:stretch}.align-content-start{-ms-flex-line-pack:start;align-content:flex-start}.align-content-end{-ms-flex-line-pack:end;align-content:flex-end}.align-content-center{-ms-flex-line-pack:center;align-content:center}.align-content-between{-ms-flex-line-pack:justify;align-content:space-between}.align-content-around{-ms-flex-line-pack:distribute;align-content:space-around}.align-content-stretch{-ms-flex-line-pack:stretch;align-content:stretch}.align-self-auto{-ms-flex-item-align:auto;align-self:auto}.align-self-start{-ms-flex-item-align:start;align-self:flex-start}.align-self-end{-ms-flex-item-align:end;align-self:flex-end}.align-self-center{-ms-flex-item-align:center;align-self:center}.align-self-baseline{-ms-flex-item-align:baseline;align-self:baseline}.align-self-stretch{-ms-flex-item-align:stretch;align-self:stretch}@media (min-width:576px){.flex-sm-row{-ms-flex-direction:row;flex-direction:row}.flex-sm-column{-ms-flex-direction:column;flex-direction:column}.flex-sm-row-reverse{-ms-flex-direction:row-reverse;flex-direction:row-reverse}.flex-sm-column-reverse{-ms-flex-direction:column-reverse;flex-direction:column-reverse}.flex-sm-wrap{-ms-flex-wrap:wrap;flex-wrap:wrap}.flex-sm-nowrap{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.flex-sm-wrap-reverse{-ms-flex-wrap:wrap-reverse;flex-wrap:wrap-reverse}.flex-sm-fill{-ms-flex:1 1 auto;flex:1 1 auto}.flex-sm-grow-0{-ms-flex-positive:0;flex-grow:0}.flex-sm-grow-1{-ms-flex-positive:1;flex-grow:1}.flex-sm-shrink-0{-ms-flex-negative:0;flex-shrink:0}.flex-sm-shrink-1{-ms-flex-negative:1;flex-shrink:1}.justify-content-sm-start{-ms-flex-pack:start;justify-content:flex-start}.justify-content-sm-end{-ms-flex-pack:end;justify-content:flex-end}.justify-content-sm-center{-ms-flex-pack:center;justify-content:center}.justify-content-sm-between{-ms-flex-pack:justify;justify-content:space-between}.justify-content-sm-around{-ms-flex-pack:distribute;justify-content:space-around}.align-items-sm-start{-ms-flex-align:start;align-items:flex-start}.align-items-sm-end{-ms-flex-align:end;align-items:flex-end}.align-items-sm-center{-ms-flex-align:center;align-items:center}.align-items-sm-baseline{-ms-flex-align:baseline;align-items:baseline}.align-items-sm-stretch{-ms-flex-align:stretch;align-items:stretch}.align-content-sm-start{-ms-flex-line-pack:start;align-content:flex-start}.align-content-sm-end{-ms-flex-line-pack:end;align-content:flex-end}.align-content-sm-center{-ms-flex-line-pack:center;align-content:center}.align-content-sm-between{-ms-flex-line-pack:justify;align-content:space-between}.align-content-sm-around{-ms-flex-line-pack:distribute;align-content:space-around}.align-content-sm-stretch{-ms-flex-line-pack:stretch;align-content:stretch}.align-self-sm-auto{-ms-flex-item-align:auto;align-self:auto}.align-self-sm-start{-ms-flex-item-align:start;align-self:flex-start}.align-self-sm-end{-ms-flex-item-align:end;align-self:flex-end}.align-self-sm-center{-ms-flex-item-align:center;align-self:center}.align-self-sm-baseline{-ms-flex-item-align:baseline;align-self:baseline}.align-self-sm-stretch{-ms-flex-item-align:stretch;align-self:stretch}}@media (min-width:768px){.flex-md-row{-ms-flex-direction:row;flex-direction:row}.flex-md-column{-ms-flex-direction:column;flex-direction:column}.flex-md-row-reverse{-ms-flex-direction:row-reverse;flex-direction:row-reverse}.flex-md-column-reverse{-ms-flex-direction:column-reverse;flex-direction:column-reverse}.flex-md-wrap{-ms-flex-wrap:wrap;flex-wrap:wrap}.flex-md-nowrap{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.flex-md-wrap-reverse{-ms-flex-wrap:wrap-reverse;flex-wrap:wrap-reverse}.flex-md-fill{-ms-flex:1 1 auto;flex:1 1 auto}.flex-md-grow-0{-ms-flex-positive:0;flex-grow:0}.flex-md-grow-1{-ms-flex-positive:1;flex-grow:1}.flex-md-shrink-0{-ms-flex-negative:0;flex-shrink:0}.flex-md-shrink-1{-ms-flex-negative:1;flex-shrink:1}.justify-content-md-start{-ms-flex-pack:start;justify-content:flex-start}.justify-content-md-end{-ms-flex-pack:end;justify-content:flex-end}.justify-content-md-center{-ms-flex-pack:center;justify-content:center}.justify-content-md-between{-ms-flex-pack:justify;justify-content:space-between}.justify-content-md-around{-ms-flex-pack:distribute;justify-content:space-around}.align-items-md-start{-ms-flex-align:start;align-items:flex-start}.align-items-md-end{-ms-flex-align:end;align-items:flex-end}.align-items-md-center{-ms-flex-align:center;align-items:center}.align-items-md-baseline{-ms-flex-align:baseline;align-items:baseline}.align-items-md-stretch{-ms-flex-align:stretch;align-items:stretch}.align-content-md-start{-ms-flex-line-pack:start;align-content:flex-start}.align-content-md-end{-ms-flex-line-pack:end;align-content:flex-end}.align-content-md-center{-ms-flex-line-pack:center;align-content:center}.align-content-md-between{-ms-flex-line-pack:justify;align-content:space-between}.align-content-md-around{-ms-flex-line-pack:distribute;align-content:space-around}.align-content-md-stretch{-ms-flex-line-pack:stretch;align-content:stretch}.align-self-md-auto{-ms-flex-item-align:auto;align-self:auto}.align-self-md-start{-ms-flex-item-align:start;align-self:flex-start}.align-self-md-end{-ms-flex-item-align:end;align-self:flex-end}.align-self-md-center{-ms-flex-item-align:center;align-self:center}.align-self-md-baseline{-ms-flex-item-align:baseline;align-self:baseline}.align-self-md-stretch{-ms-flex-item-align:stretch;align-self:stretch}}@media (min-width:992px){.flex-lg-row{-ms-flex-direction:row;flex-direction:row}.flex-lg-column{-ms-flex-direction:column;flex-direction:column}.flex-lg-row-reverse{-ms-flex-direction:row-reverse;flex-direction:row-reverse}.flex-lg-column-reverse{-ms-flex-direction:column-reverse;flex-direction:column-reverse}.flex-lg-wrap{-ms-flex-wrap:wrap;flex-wrap:wrap}.flex-lg-nowrap{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.flex-lg-wrap-reverse{-ms-flex-wrap:wrap-reverse;flex-wrap:wrap-reverse}.flex-lg-fill{-ms-flex:1 1 auto;flex:1 1 auto}.flex-lg-grow-0{-ms-flex-positive:0;flex-grow:0}.flex-lg-grow-1{-ms-flex-positive:1;flex-grow:1}.flex-lg-shrink-0{-ms-flex-negative:0;flex-shrink:0}.flex-lg-shrink-1{-ms-flex-negative:1;flex-shrink:1}.justify-content-lg-start{-ms-flex-pack:start;justify-content:flex-start}.justify-content-lg-end{-ms-flex-pack:end;justify-content:flex-end}.justify-content-lg-center{-ms-flex-pack:center;justify-content:center}.justify-content-lg-between{-ms-flex-pack:justify;justify-content:space-between}.justify-content-lg-around{-ms-flex-pack:distribute;justify-content:space-around}.align-items-lg-start{-ms-flex-align:start;align-items:flex-start}.align-items-lg-end{-ms-flex-align:end;align-items:flex-end}.align-items-lg-center{-ms-flex-align:center;align-items:center}.align-items-lg-baseline{-ms-flex-align:baseline;align-items:baseline}.align-items-lg-stretch{-ms-flex-align:stretch;align-items:stretch}.align-content-lg-start{-ms-flex-line-pack:start;align-content:flex-start}.align-content-lg-end{-ms-flex-line-pack:end;align-content:flex-end}.align-content-lg-center{-ms-flex-line-pack:center;align-content:center}.align-content-lg-between{-ms-flex-line-pack:justify;align-content:space-between}.align-content-lg-around{-ms-flex-line-pack:distribute;align-content:space-around}.align-content-lg-stretch{-ms-flex-line-pack:stretch;align-content:stretch}.align-self-lg-auto{-ms-flex-item-align:auto;align-self:auto}.align-self-lg-start{-ms-flex-item-align:start;align-self:flex-start}.align-self-lg-end{-ms-flex-item-align:end;align-self:flex-end}.align-self-lg-center{-ms-flex-item-align:center;align-self:center}.align-self-lg-baseline{-ms-flex-item-align:baseline;align-self:baseline}.align-self-lg-stretch{-ms-flex-item-align:stretch;align-self:stretch}}@media (min-width:1200px){.flex-xl-row{-ms-flex-direction:row;flex-direction:row}.flex-xl-column{-ms-flex-direction:column;flex-direction:column}.flex-xl-row-reverse{-ms-flex-direction:row-reverse;flex-direction:row-reverse}.flex-xl-column-reverse{-ms-flex-direction:column-reverse;flex-direction:column-reverse}.flex-xl-wrap{-ms-flex-wrap:wrap;flex-wrap:wrap}.flex-xl-nowrap{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.flex-xl-wrap-reverse{-ms-flex-wrap:wrap-reverse;flex-wrap:wrap-reverse}.flex-xl-fill{-ms-flex:1 1 auto;flex:1 1 auto}.flex-xl-grow-0{-ms-flex-positive:0;flex-grow:0}.flex-xl-grow-1{-ms-flex-positive:1;flex-grow:1}.flex-xl-shrink-0{-ms-flex-negative:0;flex-shrink:0}.flex-xl-shrink-1{-ms-flex-negative:1;flex-shrink:1}.justify-content-xl-start{-ms-flex-pack:start;justify-content:flex-start}.justify-content-xl-end{-ms-flex-pack:end;justify-content:flex-end}.justify-content-xl-center{-ms-flex-pack:center;justify-content:center}.justify-content-xl-between{-ms-flex-pack:justify;justify-content:space-between}.justify-content-xl-around{-ms-flex-pack:distribute;justify-content:space-around}.align-items-xl-start{-ms-flex-align:start;align-items:flex-start}.align-items-xl-end{-ms-flex-align:end;align-items:flex-end}.align-items-xl-center{-ms-flex-align:center;align-items:center}.align-items-xl-baseline{-ms-flex-align:baseline;align-items:baseline}.align-items-xl-stretch{-ms-flex-align:stretch;align-items:stretch}.align-content-xl-start{-ms-flex-line-pack:start;align-content:flex-start}.align-content-xl-end{-ms-flex-line-pack:end;align-content:flex-end}.align-content-xl-center{-ms-flex-line-pack:center;align-content:center}.align-content-xl-between{-ms-flex-line-pack:justify;align-content:space-between}.align-content-xl-around{-ms-flex-line-pack:distribute;align-content:space-around}.align-content-xl-stretch{-ms-flex-line-pack:stretch;align-content:stretch}.align-self-xl-auto{-ms-flex-item-align:auto;align-self:auto}.align-self-xl-start{-ms-flex-item-align:start;align-self:flex-start}.align-self-xl-end{-ms-flex-item-align:end;align-self:flex-end}.align-self-xl-center{-ms-flex-item-align:center;align-self:center}.align-self-xl-baseline{-ms-flex-item-align:baseline;align-self:baseline}.align-self-xl-stretch{-ms-flex-item-align:stretch;align-self:stretch}}

{# /* // Swiper 4.4.2 */ #}

.swiper-container{width:100%;margin:0 auto;position:relative;overflow:hidden;list-style:none;padding:0;z-index:1}.swiper-container-no-flexbox .swiper-slide{float:left}.swiper-container-vertical>.swiper-wrapper{-webkit-box-orient:vertical;-webkit-box-direction:normal;-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column}.swiper-wrapper{position:relative;width:100%;height:100%;z-index:1;display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;-webkit-transition-property:-webkit-transform;transition-property:-webkit-transform;-o-transition-property:transform;transition-property:transform;transition-property:transform,-webkit-transform;-webkit-box-sizing:content-box;box-sizing:content-box}.swiper-container-android .swiper-slide,.swiper-wrapper{-webkit-transform:translate3d(0,0,0);transform:translate3d(0,0,0)}.swiper-container-multirow>.swiper-wrapper{-webkit-flex-wrap:wrap;-ms-flex-wrap:wrap;flex-wrap:wrap}.swiper-container-free-mode>.swiper-wrapper{-webkit-transition-timing-function:ease-out;-o-transition-timing-function:ease-out;transition-timing-function:ease-out;margin:0 auto}.swiper-slide{-webkit-flex-shrink:0;-ms-flex-negative:0;flex-shrink:0;width:100%;height:100%;position:relative;-webkit-transition-property:-webkit-transform;transition-property:-webkit-transform;-o-transition-property:transform;transition-property:transform;transition-property:transform,-webkit-transform}.swiper-slide-invisible-blank{visibility:hidden}.swiper-container-autoheight,.swiper-container-autoheight .swiper-slide{height:auto}.swiper-container-autoheight .swiper-wrapper{-webkit-box-align:start;-webkit-align-items:flex-start;-ms-flex-align:start;align-items:flex-start;-webkit-transition-property:height,-webkit-transform;transition-property:height,-webkit-transform;-o-transition-property:transform,height;transition-property:transform,height;transition-property:transform,height,-webkit-transform}.swiper-container-3d{-webkit-perspective:1200px;perspective:1200px}.swiper-container-3d .swiper-cube-shadow,.swiper-container-3d .swiper-slide,.swiper-container-3d .swiper-slide-shadow-bottom,.swiper-container-3d .swiper-slide-shadow-left,.swiper-container-3d .swiper-slide-shadow-right,.swiper-container-3d .swiper-slide-shadow-top,.swiper-container-3d .swiper-wrapper{-webkit-transform-style:preserve-3d;transform-style:preserve-3d}.swiper-container-3d .swiper-slide-shadow-bottom,.swiper-container-3d .swiper-slide-shadow-left,.swiper-container-3d .swiper-slide-shadow-right,.swiper-container-3d .swiper-slide-shadow-top{position:absolute;left:0;top:0;width:100%;height:100%;pointer-events:none;z-index:10}.swiper-container-3d .swiper-slide-shadow-left{background-image:-webkit-gradient(linear,right top,left top,from(rgba(0,0,0,.5)),to(rgba(0,0,0,0)));background-image:-webkit-linear-gradient(right,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:-o-linear-gradient(right,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:linear-gradient(to left,rgba(0,0,0,.5),rgba(0,0,0,0))}.swiper-container-3d .swiper-slide-shadow-right{background-image:-webkit-gradient(linear,left top,right top,from(rgba(0,0,0,.5)),to(rgba(0,0,0,0)));background-image:-webkit-linear-gradient(left,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:-o-linear-gradient(left,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:linear-gradient(to right,rgba(0,0,0,.5),rgba(0,0,0,0))}.swiper-container-3d .swiper-slide-shadow-top{background-image:-webkit-gradient(linear,left bottom,left top,from(rgba(0,0,0,.5)),to(rgba(0,0,0,0)));background-image:-webkit-linear-gradient(bottom,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:-o-linear-gradient(bottom,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:linear-gradient(to top,rgba(0,0,0,.5),rgba(0,0,0,0))}.swiper-container-3d .swiper-slide-shadow-bottom{background-image:-webkit-gradient(linear,left top,left bottom,from(rgba(0,0,0,.5)),to(rgba(0,0,0,0)));background-image:-webkit-linear-gradient(top,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:-o-linear-gradient(top,rgba(0,0,0,.5),rgba(0,0,0,0));background-image:linear-gradient(to bottom,rgba(0,0,0,.5),rgba(0,0,0,0))}.swiper-container-wp8-horizontal,.swiper-container-wp8-horizontal>.swiper-wrapper{-ms-touch-action:pan-y;touch-action:pan-y}.swiper-container-wp8-vertical,.swiper-container-wp8-vertical>.swiper-wrapper{-ms-touch-action:pan-x;touch-action:pan-x}.swiper-button-next,.swiper-button-prev{position:absolute;top:50%;z-index:10;width:30px;height:40px;margin-top:-20px;line-height:40px;color:#fff;text-align:center;cursor:pointer}.swiper-button-next.swiper-button-disabled,.swiper-button-prev.swiper-button-disabled{opacity:.35;cursor:auto;pointer-events:none}.swiper-button-prev,.swiper-container-rtl .swiper-button-next{left:10px;right:auto}.swiper-button-next,.swiper-container-rtl .swiper-button-prev{right:10px;left:auto}.swiper-button-lock{display:none}.swiper-pagination{position:absolute;text-align:center;-webkit-transition:.3s opacity;-o-transition:.3s opacity;transition:.3s opacity;-webkit-transform:translate3d(0,0,0);transform:translate3d(0,0,0);z-index:10}.swiper-pagination.swiper-pagination-hidden{opacity:0}.swiper-container-horizontal>.swiper-pagination-bullets,.swiper-pagination-custom,.swiper-pagination-fraction{bottom:20px;left:0;width:100%}.swiper-pagination-bullets-dynamic{overflow:hidden;font-size:0}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet{-webkit-transform:scale(.33);-ms-transform:scale(.33);transform:scale(.33);position:relative}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active{-webkit-transform:scale(1);-ms-transform:scale(1);transform:scale(1)}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-main{-webkit-transform:scale(1);-ms-transform:scale(1);transform:scale(1)}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-prev{-webkit-transform:scale(.66);-ms-transform:scale(.66);transform:scale(.66)}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-prev-prev{-webkit-transform:scale(.33);-ms-transform:scale(.33);transform:scale(.33)}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-next{-webkit-transform:scale(.66);-ms-transform:scale(.66);transform:scale(.66)}.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-next-next{-webkit-transform:scale(.33);-ms-transform:scale(.33);transform:scale(.33)}.swiper-pagination-bullet{width:8px;height:8px;display:inline-block;border-radius:100%;background:#000;opacity:.2}button.swiper-pagination-bullet{border:none;margin:0;padding:0;-webkit-box-shadow:none;box-shadow:none;-webkit-appearance:none;-moz-appearance:none;appearance:none}.swiper-pagination-clickable .swiper-pagination-bullet{cursor:pointer}.swiper-pagination-bullet-active{opacity:1;background:#007aff}.swiper-container-vertical>.swiper-pagination-bullets{right:10px;top:50%;-webkit-transform:translate3d(0,-50%,0);transform:translate3d(0,-50%,0)}.swiper-container-vertical>.swiper-pagination-bullets .swiper-pagination-bullet{margin:6px 0;display:block}.swiper-container-vertical>.swiper-pagination-bullets.swiper-pagination-bullets-dynamic{top:50%;-webkit-transform:translateY(-50%);-ms-transform:translateY(-50%);transform:translateY(-50%);width:8px}.swiper-container-vertical>.swiper-pagination-bullets.swiper-pagination-bullets-dynamic .swiper-pagination-bullet{display:inline-block;-webkit-transition:.2s top,.2s -webkit-transform;transition:.2s top,.2s -webkit-transform;-o-transition:.2s transform,.2s top;transition:.2s transform,.2s top;transition:.2s transform,.2s top,.2s -webkit-transform}.swiper-container-horizontal>.swiper-pagination-bullets .swiper-pagination-bullet{margin:0 4px}.swiper-container-horizontal>.swiper-pagination-bullets.swiper-pagination-bullets-dynamic{left:50%;-webkit-transform:translateX(-50%);-ms-transform:translateX(-50%);transform:translateX(-50%);white-space:nowrap}.swiper-container-horizontal>.swiper-pagination-bullets.swiper-pagination-bullets-dynamic .swiper-pagination-bullet{-webkit-transition:.2s left,.2s -webkit-transform;transition:.2s left,.2s -webkit-transform;-o-transition:.2s transform,.2s left;transition:.2s transform,.2s left;transition:.2s transform,.2s left,.2s -webkit-transform}.swiper-container-horizontal.swiper-container-rtl>.swiper-pagination-bullets-dynamic .swiper-pagination-bullet{-webkit-transition:.2s right,.2s -webkit-transform;transition:.2s right,.2s -webkit-transform;-o-transition:.2s transform,.2s right;transition:.2s transform,.2s right;transition:.2s transform,.2s right,.2s -webkit-transform}.swiper-pagination-progressbar{background:rgba(0,0,0,.25);position:absolute}.swiper-pagination-progressbar .swiper-pagination-progressbar-fill{background:#007aff;position:absolute;left:0;top:0;width:100%;height:100%;-webkit-transform:scale(0);-ms-transform:scale(0);transform:scale(0);-webkit-transform-origin:left top;-ms-transform-origin:left top;transform-origin:left top}.swiper-container-rtl .swiper-pagination-progressbar .swiper-pagination-progressbar-fill{-webkit-transform-origin:right top;-ms-transform-origin:right top;transform-origin:right top}.swiper-container-horizontal>.swiper-pagination-progressbar,.swiper-container-vertical>.swiper-pagination-progressbar.swiper-pagination-progressbar-opposite{width:100%;height:4px;left:0;top:0}.swiper-container-horizontal>.swiper-pagination-progressbar.swiper-pagination-progressbar-opposite,.swiper-container-vertical>.swiper-pagination-progressbar{width:4px;height:100%;left:0;top:0}.swiper-pagination-white .swiper-pagination-bullet-active{background:#fff}.swiper-pagination-progressbar.swiper-pagination-white{background:rgba(255,255,255,.25)}.swiper-pagination-progressbar.swiper-pagination-white .swiper-pagination-progressbar-fill{background:#fff}.swiper-pagination-black .swiper-pagination-bullet-active{background:#000}.swiper-pagination-progressbar.swiper-pagination-black{background:rgba(0,0,0,.25)}.swiper-pagination-progressbar.swiper-pagination-black .swiper-pagination-progressbar-fill{background:#000}.swiper-pagination-lock{display:none}.swiper-lazy-preloader{width:42px;height:42px;position:absolute;left:50%;top:50%;margin-left:-21px;margin-top:-21px;z-index:10;-webkit-transform-origin:50%;-ms-transform-origin:50%;transform-origin:50%;-webkit-animation:swiper-preloader-spin 1s steps(12,end) infinite;animation:swiper-preloader-spin 1s steps(12,end) infinite}.swiper-lazy-preloader:after{display:block;content:'';width:100%;height:100%;background-image:url("data:image/svg+xml;charset=utf-8,%3Csvg%20viewBox%3D'0%200%20120%20120'%20xmlns%3D'http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg'%20xmlns%3Axlink%3D'http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink'%3E%3Cdefs%3E%3Cline%20id%3D'l'%20x1%3D'60'%20x2%3D'60'%20y1%3D'7'%20y2%3D'27'%20stroke%3D'%236c6c6c'%20stroke-width%3D'11'%20stroke-linecap%3D'round'%2F%3E%3C%2Fdefs%3E%3Cg%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(30%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(60%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(90%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(120%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(150%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.37'%20transform%3D'rotate(180%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.46'%20transform%3D'rotate(210%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.56'%20transform%3D'rotate(240%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.66'%20transform%3D'rotate(270%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.75'%20transform%3D'rotate(300%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.85'%20transform%3D'rotate(330%2060%2C60)'%2F%3E%3C%2Fg%3E%3C%2Fsvg%3E");background-position:50%;background-size:100%;background-repeat:no-repeat}.swiper-lazy-preloader-white:after{background-image:url("data:image/svg+xml;charset=utf-8,%3Csvg%20viewBox%3D'0%200%20120%20120'%20xmlns%3D'http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg'%20xmlns%3Axlink%3D'http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink'%3E%3Cdefs%3E%3Cline%20id%3D'l'%20x1%3D'60'%20x2%3D'60'%20y1%3D'7'%20y2%3D'27'%20stroke%3D'%23fff'%20stroke-width%3D'11'%20stroke-linecap%3D'round'%2F%3E%3C%2Fdefs%3E%3Cg%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(30%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(60%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(90%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(120%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.27'%20transform%3D'rotate(150%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.37'%20transform%3D'rotate(180%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.46'%20transform%3D'rotate(210%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.56'%20transform%3D'rotate(240%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.66'%20transform%3D'rotate(270%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.75'%20transform%3D'rotate(300%2060%2C60)'%2F%3E%3Cuse%20xlink%3Ahref%3D'%23l'%20opacity%3D'.85'%20transform%3D'rotate(330%2060%2C60)'%2F%3E%3C%2Fg%3E%3C%2Fsvg%3E")}@-webkit-keyframes swiper-preloader-spin{100%{-webkit-transform:rotate(360deg);transform:rotate(360deg)}}@keyframes swiper-preloader-spin{100%{-webkit-transform:rotate(360deg);transform:rotate(360deg)}}.swiper-container-fade.swiper-container-free-mode .swiper-slide{-webkit-transition-timing-function:ease-out;-o-transition-timing-function:ease-out;transition-timing-function:ease-out}.swiper-container-fade .swiper-slide{pointer-events:none;-webkit-transition-property:opacity;-o-transition-property:opacity;transition-property:opacity}.swiper-container-fade .swiper-slide .swiper-slide{pointer-events:none}.swiper-container-fade .swiper-slide-active,.swiper-container-fade .swiper-slide-active .swiper-slide-active{pointer-events:auto}

/*============================================================================
  #Critical path helpers
==============================================================================*/

/* Hidden general content until rest of styling loads */
.visible-when-content-ready{
	visibility: hidden;
}
.display-when-content-ready{
	display: none;
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

.pg-card {
  background: var(--pg-color-primary);
  border-radius: var(--pg-radius-card);
  padding: var(--pg-spacing-5);
  box-shadow: 0 16px 40px rgba(0,0,0,0.08);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.pg-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 20px 45px rgba(0,0,0,0.12);
}

.pg-product-card__media {
  display: block;
  background: transparent;          /* Remove fundo branco */
  border-radius: var(--pg-radius-card);
  padding: 0;                       /* Remove padding */
  margin-bottom: var(--pg-spacing-4);
  overflow: hidden;                 /* Garante que bordas arredondadas funcionem */
}

.pg-product-card__media img {
  width: 100%;
  height: auto;                     /* Altura automática baseada na proporção */
  max-height: 180px;                /* Limite máximo mais razoável */
  object-fit: contain;
  display: block;                   /* Remove espaço extra embaixo */
}

.pg-product-card__body h3 {
  font-family: var(--pg-font-display);
  font-size: 1.2rem;
  margin: var(--pg-spacing-3) 0 var(--pg-spacing-2);
}

.pg-product-card__price {
  font-weight: 700;
  font-size: 1rem;
  margin-bottom: var(--pg-spacing-4);
}

.pg-product-card__price-compare {
  font-size: 0.85rem;
  color: var(--pg-color-gray-dark);
  text-decoration: line-through;
  margin-left: var(--pg-spacing-2);
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
  object-fit: contain; /* Forçando contain para mostrar imagem completa */
  object-position: center center; /* Centralizando imagem */
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

.pg-header {
  background: transparent;
  border-bottom: none;
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 9999;
  /* Espaço para banner de aviso (ad bar) - ~48px para banner + padding */
  padding-top: 50px;
  /* CORRIGIDO 26/11: Altura mínima para garantir área clicável completa */
  min-height: 70px;
}

.pg-header--sticky {
  position: fixed;
  top: var(--ad-bar-height, 0);
  padding-top: 50px;
  z-index: 999;
  width: 100%;
  left: 0;
  right: 0;
  transition: top 0.3s ease;
}

/* When ad-bar is present, adjust header top position */
body.has-ad-bar .pg-header--sticky {
  --ad-bar-height: 40px;
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

/* Busca inline expansível - hover */
.pg-header__search-wrapper {
  display: flex;
  align-items: center;
  position: relative;
  height: 44px; /* Mesma altura dos botões */
}

.pg-header__search-form {
  position: absolute;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  align-items: center;
  overflow: hidden;
  width: 44px; /* Mesma largura dos botões */
  height: 44px; /* Mesma altura dos botões */
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
  pointer-events: none; /* Desabilitar apenas quando invisível */
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

/* MOBILE SEARCH FIX - Opção 1: Logo oculta ao expandir busca */
@media (max-width: 767px) {
  /* Logo: aplicar z-index menor para ficar atrás da busca */
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

  /* Logo oculta quando busca está expandida */
  .pg-header__search-wrapper.is-open ~ .pg-header__logo {
    opacity: 0;
    visibility: hidden;
    pointer-events: none;
  }

  /* Busca expande ocupando espaço disponível */
  .pg-header__search-wrapper.is-open .pg-header__search-form {
    width: calc(100vw - 180px); /* Mais espaço - apenas menu (44px) + perfil (44px) + carrinho (44px) + gaps (48px) */
    background: rgba(255, 255, 255, 0.98); /* Mais opaco para cobrir logo */
    border: 1px solid rgba(234, 254, 103, 0.3);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    z-index: 110; /* Sobre tudo */
  }

  /* Ocultar botão toggle (lupa externa) quando busca aberta */
  .pg-header__search-wrapper.is-open .pg-header__search-toggle {
    opacity: 0;
    pointer-events: none;
  }

  /* Botão de fechar (X) - oculto por padrão */
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
    z-index: 120; /* Acima de tudo para ser clicável */
    position: relative;
    pointer-events: auto; /* Garantir que seja clicável */
    -webkit-tap-highlight-color: transparent;
    user-select: none;
    -webkit-user-select: none;
  }

  /* Mostra botão X quando busca expandida */
  .pg-header__search-wrapper.is-open .pg-header__search-close {
    display: flex;
    pointer-events: auto; /* Forçar clicável quando visível */
  }

  /* Botão submit dentro do form: sempre visível mas muda comportamento via JS */
  .pg-header__search-submit {
    /* Mantém visível, JS controla o comportamento */
  }

  /* ========================================= */
  /* FIX: Remover cor azul padrão do mobile   */
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

  /* Forçar apenas STROKE (contorno) nos SVGs - SEM FILL (preenchimento) */
  .pg-header__search-toggle svg,
  .pg-header__search-submit svg,
  .pg-header__icon-button svg {
    fill: none; /* Remove preenchimento */
    stroke: currentColor; /* Mantém apenas contorno */
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

  /* Garantir que SVGs dentro dos botões também fiquem apenas com contorno */
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
/* PATAGANG v1.5.33: FIXED - Keep only SECOND blur-up declaration with left: 50% */
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
  background-color: transparent;
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
  display: block;
  font-size: 0.875rem;
  font-weight: 600;
  letter-spacing: 0.3px;
  color: #000;
  margin: 0;
  line-height: 1.4;
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
    font-size: 0.75rem;
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
    font-size: 0.8rem;
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
    font-size: 0.875rem;
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

/* PATAGANG - Banner de Serviço/Aviso (Refatorado - v1.5.12+) */
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
	width: 400px; /* Aumentado para melhor espaçamento */
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
	border-bottom: 1px solid #E5E5E5; /* Adiciona separação visual */
}

.modal-cart .modal-header .d-inline-flex {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 16px; /* Reduzido de 20px */
	font-weight: 600; /* Bold para título */
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
	font-weight: 500; /* Peso médio */
	color: #000000;
	text-decoration: none;
	line-height: 1.4;
}

/* Product Price */
.modal-cart .pg-cart-item-price,
.modal-cart .pg-cart-item-price-mobile,
.modal-cart .price {
	font-family: 'Familjen Grotesk', sans-serif;
	font-size: 16px; /* Destaque no preço */
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
	letter-spacing: 0.8px; /* Espaçamento entre letras */
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
	padding: 20px; /* Mais espaçamento */
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

/* Container principal - FUNDO CLARO COM DEGRADÊ PARA O FOOTER AMARELO */
.pg-pdp-container {
	padding-top: 90px;
	padding-bottom: 60px;           /* Padding inferior para separação */
	margin: 0;
	background-color: #ffffff;      /* ✅ LIMPO: Branco puro (padrão home) */
	background-image: none;
	min-height: auto;               /* Sem height mínimo - cresce com conteúdo */
	display: flex;
	align-items: flex-start;
	justify-content: center;
}

/* Row principal - Bootstrap row */
.pg-pdp-container .section-single-product {
	margin: 0;
	padding: 30px 20px;
	width: 100%;
	max-width: 1400px; /* Mais largo */
}

/* DESKTOP: FORÇAR lado a lado - sobrescreve Bootstrap */
@media (min-width: 992px) {
	.pg-pdp-container .section-single-product.row {
		display: flex;
		flex-direction: row;
		flex-wrap: nowrap;
		align-items: center; /* CENTRALIZADO em relação à imagem */
		justify-content: center;
		gap: 40px;
		padding: 30px 40px;
	}

	/* COLUNA ESQUERDA - Imagem - MAIOR */
	.pg-pdp-container .pg-pdp-image-col.col-lg-7 {
		flex: 0 0 58%;
		max-width: 58%;
		width: 58%;
		padding: 0;
		align-self: flex-start; /* Imagem alinha no topo */
	}

	/* COLUNA DIREITA - Info - ALINHADA NO TOPO (v1.5.33 FIX) */
	.pg-pdp-container .pg-pdp-info-col.col-lg-5 {
		flex: 0 0 40%;
		max-width: 40%;
		width: 40%;
		padding: 0;
		align-self: flex-start; /* Card alinhado no topo com a imagem (v1.5.33) */
	}
}

/* COLUNA ESQUERDA - Imagem SEM BORDAS, SEM CARD (v1.5.35: DYNAMIC HEIGHT) */
.pg-pdp-image-col {
	background: transparent; /* SEM fundo */
	border-radius: 0; /* SEM bordas arredondadas */
	padding: 0; /* SEM padding */
	overflow: visible;
	display: flex;
	flex-direction: column;  /* Permite filho crescer verticalmente */
	align-items: flex-start; /* Alinha no topo */
	justify-content: flex-start;
	box-sizing: border-box;
	box-shadow: none; /* SEM sombra */
	/* v1.5.35: Removido min-height: auto para permitir crescimento dinâmico */
}

/* Container da imagem - preenche parent (v1.5.35: DYNAMIC HEIGHT) */
.pg-pdp-image-col .product-image-container {
	width: 100%;
	flex: 1;  /* Cresce com parent */
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	justify-content: flex-start;
	padding: 0;
}

/* Swiper container - altura automática */
.pg-pdp-image-col .js-swiper-product {
	width: 100%;
	height: auto;
	min-height: auto;
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

/* Link da imagem - ajusta à imagem */
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

/* Imagem do produto - GRANDE E SEM RESTRIÇÕES */
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
	border-radius: 20px; /* Bordas arredondadas na própria imagem */
	box-shadow: 0 8px 32px rgba(0,0,0,0.1); /* Sombra na imagem */
}

/* Navegação do slider - mais discreta */
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
	display: none;
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

/* Header do produto - Nome + Preço na mesma linha - COMPACTO */
.pg-product-header {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	margin-bottom: 16px; /* REDUZIDO */
	gap: 16px;
	padding-bottom: 12px; /* REDUZIDO */
	border-bottom: 1px solid rgba(0, 0, 0, 0.08);
}

/* Título do produto - DESTAQUE */
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

/* Seção de preço - DESTAQUE */
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

/* Botão adicionar - COMPACTO */
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
		padding-bottom: 40px;         /* Padding inferior para separação */
		align-items: flex-start;
		background-color: #ffffff;    /* ✅ LIMPO: Branco puro (padrão home) */
		background-image: none;
	}

	.pg-pdp-container .section-single-product {
		flex-direction: column;
		padding: 20px 15px;
		gap: 20px;
	}

	.pg-pdp-image-col {
		max-width: 100%;
		width: 100%;
		padding: 0;
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
		width: 100%;
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
   (Seção separada, fora do produto)
   ============================================ */

.pg-identity-banner {
	width: 100%;
	background: #FFFFFF;
	border-top: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	padding: 20px 20px;
	margin: 0;
	margin-top: 150px;
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
	max-width: 1200px;
	margin: 0 auto;
	width: 100%;
	flex-wrap: wrap;
	padding: 0;
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

/* Tablet - Reduce gap */
@media (max-width: 991px) {
	.pg-identity-banner {
		padding: 16px 15px;
		margin-top: 130px;
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

/* Mobile - Stack vertical */
@media (max-width: 576px) {
	.pg-identity-banner {
		padding: 12px 10px;
		margin-top: 110px;
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

/* Garantir que drawer está oculto desde o início */
#nav-drawer {
    visibility: hidden;
    pointer-events: none;
}

#nav-drawer .pg-drawer__panel {
    transform: translateX(-100%);
}

/* ============================================
   PATAGANG HOME - Anti-FOUC (Critical CSS)
   ============================================ */

/* Ocultar elementos da home até CSS assíncrono carregar */
.hero,
.featured-product,
.coming-soon,
.yellow-gradient-wrapper {
    visibility: hidden;
}

/* Mostrar quando CSS assíncrono carregar */
.visible-when-content-ready {
    visibility: visible;
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
   Esconde visualmente mas mantém para SEO/leitores de tela
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
    padding-right: 30px;
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
    text-transform: uppercase;
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
    padding-left: 38px; /* Space for R$ */
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
    color: #000;
    font-size: 13px; /* Smaller */
    margin-bottom: 10px; /* Compact */
}

.checkbox-container {
    background: rgba(255, 255, 255, 0.5);
    border-radius: 6px;
    padding: 6px 10px; /* More compact */
    margin-bottom: 6px; /* Reduced spacing */
}

.checkbox-text {
    color: #000;
    font-weight: 500;
    font-size: 12px; /* Smaller */
}

/* PROBLEMA 3: Centralize filter and sort controls side by side */
.category-controls,
.js-category-controls {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 20px;
    max-width: 600px;
    margin: 0 auto 30px auto;
}

.category-controls > div,
.js-category-controls > div {
    flex: 0 0 auto;
    width: auto;
}

/* Filter button - smaller and cleaner */
.filter-link {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 8px 16px; /* Smaller */
    background: #fff;
    border: 1px solid #000;
    border-radius: 6px;
    color: #000;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 11px; /* Smaller */
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
    margin: 0;
    display: inline-block;
}

.sort-by select,
.form-select {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;

    /* Layout Box igual ao botão Filtrar */
    background-color: #fff;
    border: 1px solid #000;
    border-radius: 6px;
    padding: 8px 35px 8px 16px; /* Espaço extra na direita para a seta */
    height: auto;

    /* Tipografia igual ao botão Filtrar */
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #000;

    /* Ícone de Seta (Chevron Down) customizado */
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23000000' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 10px center;
    background-size: 12px;

    cursor: pointer;
    min-width: 160px;
    max-width: 220px;
    box-shadow: none;
    outline: none;
}

.sort-by select:hover {
    background-color: #000;
    color: #EAFE67;
    border-color: #000;
    /* Inverte a cor da seta no hover */
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23EAFE67' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
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
    display: none;
    visibility: hidden;
    opacity: 0;
    width: 0;
}

/* PROBLEMA 1: MOBILE HEADER - LUPA NA ESQUERDA & ÍCONES REDUZIDOS */
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

    /* 2. Ícones Menores (20px) */
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
    /* Seleciona o botão de busca dentro das ações e move para a esquerda */
    .pg-header__actions .js-search-open-mobile,
    .pg-header__actions a[href*="search"] {
        position: absolute;
        left: 40px; /* Logo após o menu hambúrguer (que tem ~30-40px) */
        top: 50%;
        transform: translateY(-50%);
        margin: 0;
        z-index: 15;
    }

    /* 4. Ícones da Direita (Carrinho/Conta) - Sem a lupa */
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

    /* 6. BUSCA EXPANDINDO DA ESQUERDA ATÉ A LOGO */
    .search-container.search-open {
        position: absolute;
        top: 0;
        left: 40px; /* Começa onde está a lupa */
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

    /* Garante que o botão de busca (lupa) continue visível/clicável */
    .search-container.search-open .pg-header__search-btn {
        display: none; /* Esconde ícone duplicado dentro do container se houver */
    }
}

/* =====================================================================
   PATAGANG v1.5.33: PRODUCT GALLERY MODAL & NAV BUTTONS
   Complete CSS for gallery lightbox and carousel navigation
   ===================================================================== */

/* MODAL GALLERY - Fullscreen overlay */
#pg-modal-gallery {
  display: none;
  position: fixed;
  inset: 0;
  z-index: 9999;
  background: rgba(0,0,0,0.92);
}

#pg-modal-gallery.is-open {
  display: flex;
}

/* Modal backdrop - Close on click */
.pg-modal-backdrop {
  position: fixed;
  inset: 0;
  cursor: zoom-out;
  z-index: 1;
}

/* Modal container - Main layout */
.pg-modal-container {
  display: flex;
  width: 100%;
  height: 100%;
  max-width: 1200px;
  margin: 0 auto;
  position: relative;
  z-index: 2;
}

/* Modal sidebar - Thumbnail gallery */
.pg-modal-sidebar {
  width: 80px;
  min-width: 80px;
  overflow-y: auto;
  overflow-x: hidden;
  padding: 16px 8px;
  display: flex;
  flex-direction: column;
  gap: 8px;
  background: rgba(0,0,0,0.3);
}

/* Modal thumbnail item */
.pg-modal-thumb {
  width: 64px;
  height: 64px;
  border-radius: 8px;
  border: 2px solid transparent;
  overflow: hidden;
  cursor: pointer;
  padding: 0;
  background: none;
  transition: border-color 0.2s ease;
}

.pg-modal-thumb:hover {
  border-color: rgba(255,255,255,0.5);
}

.pg-modal-thumb.is-active {
  border-color: #ffffff;
}

.pg-modal-thumb img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* Modal main image area */
.pg-modal-main {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 16px;
  position: relative;
}

/* Modal main image */
#pg-modal-main-image {
  max-width: 100%;
  max-height: 90vh;
  object-fit: contain;
  border-radius: 12px;
}

/* Modal close button */
.pg-modal-close {
  position: absolute;
  top: 16px;
  right: 16px;
  background: rgba(255,255,255,0.15);
  border: none;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  color: #ffffff;
  font-size: 24px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.2s ease;
  z-index: 10;
}

.pg-modal-close:hover {
  background: rgba(255,255,255,0.25);
}

/* Modal navigation buttons */
.pg-modal-nav {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(255,255,255,0.15);
  border: none;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  color: #ffffff;
  font-size: 18px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.2s ease;
  z-index: 10;
}

.pg-modal-nav:hover {
  background: rgba(255,255,255,0.25);
}

.pg-modal-nav[data-direction="prev"] {
  left: 12px;
}

.pg-modal-nav[data-direction="next"] {
  right: 12px;
}

/* Modal counter - Image position indicator */
.pg-modal-counter {
  position: absolute;
  bottom: 12px;
  left: 50%;
  transform: translateX(-50%);
  color: rgba(255,255,255,0.7);
  font-size: 12px;
  font-family: 'Familjen Grotesk', sans-serif;
  z-index: 10;
}

/* Modal responsive - Hide sidebar on mobile */
@media (max-width: 768px) {
  .pg-modal-sidebar {
    display: none;
  }

  .pg-modal-main {
    padding: 8px;
  }

  .pg-modal-nav {
    width: 36px;
    height: 36px;
    font-size: 16px;
  }

  .pg-modal-nav[data-direction="prev"] {
    left: 8px;
  }

  .pg-modal-nav[data-direction="next"] {
    right: 8px;
  }
}

/* =====================================================================
   CAROUSEL NAVIGATION BUTTONS - Prev/Next arrows
   ===================================================================== */

/* Navigation button base */
.pg-nav-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  z-index: 10;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: rgba(255,255,255,0.9);
  border: 1px solid rgba(0,0,0,0.08);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  transition: opacity 0.2s ease, background 0.2s ease;
  padding: 0;
}

.pg-nav-btn:hover {
  background: rgba(255,255,255,0.95);
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.pg-nav-btn:active {
  opacity: 0.7;
}

/* Previous button */
.pg-nav-btn--prev {
  left: 8px;
}

/* Next button */
.pg-nav-btn--next {
  right: 8px;
}

/* Button logo/icon */
.pg-nav-btn__logo {
  width: 16px;
  height: 16px;
  object-fit: contain;
}

/* Flip previous button icon */
.pg-nav-btn--prev .pg-nav-btn__logo {
  transform: scaleX(-1);
}

/* Mobile responsive navigation */
@media (max-width: 768px) {
  .pg-nav-btn {
    width: 32px;
    height: 32px;
  }

  .pg-nav-btn--prev {
    left: 4px;
  }

  .pg-nav-btn--next {
    right: 4px;
  }

  .pg-nav-btn__logo {
    width: 14px;
    height: 14px;
  }
}

/* =====================================================================
   PATAGANG v1.5.36: MODERN & MINIMALIST UX/UI — Gallery Images
   Efeitos suaves, minimalistas, foco na experiência do usuário
   ===================================================================== */

/* Gallery item wrapper - Modern styling */
.pg-gallery-item {
  position: relative;
  overflow: hidden;
  border-radius: 14px;  /* Moderno: não quadrado rígido */
  background: #f9f9f9;
  aspect-ratio: 1;
  transition: transform 0.25s ease, box-shadow 0.25s ease;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);  /* Sombra discreta */
  cursor: pointer;
}

/* Gallery item image - Smooth transitions */
.pg-gallery-item img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Gallery item hover - Modern zoom effect */
.pg-gallery-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(0,0,0,0.12);  /* Sombra elevada ao hover */
}

.pg-gallery-item:hover img {
  transform: scale(1.04);  /* Zoom suave ao hover */
}

/* Overlay on hover - Minimal zoom indicator */
.pg-gallery-item::before {
  content: '🔍';
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0,0,0,0);
  font-size: 28px;
  opacity: 0;
  transition: opacity 0.25s ease, background 0.25s ease;
  pointer-events: none;
}

.pg-gallery-item:hover::before {
  opacity: 1;
  background: rgba(0,0,0,0.15);  /* Overlay sutil ao hover */
}

/* Active/Selected image indicator - Modern glow */
.pg-gallery-item.is-active,
.pg-gallery-item[data-active="true"] {
  box-shadow: 0 0 0 2px rgba(0,0,0,0.2), 0 2px 8px rgba(0,0,0,0.06);
  transform: scale(1.01);
}

/* Scroll container - Custom scrollbar styling (webkit browsers) */
.pg-gallery-container::-webkit-scrollbar {
  width: 6px;
}

.pg-gallery-container::-webkit-scrollbar-track {
  background: transparent;
}

.pg-gallery-container::-webkit-scrollbar-thumb {
  background: rgba(0,0,0,0.12);
  border-radius: 3px;
  transition: background 0.2s ease;
}

.pg-gallery-container::-webkit-scrollbar-thumb:hover {
  background: rgba(0,0,0,0.25);
}

/* Firefox scrollbar styling */
.pg-gallery-container {
  scrollbar-color: rgba(0,0,0,0.12) transparent;
  scrollbar-width: thin;
}

/* Tablet adjustments - Modern responsive */
@media (min-width: 769px) and (max-width: 991px) {
  .pg-gallery-item {
    border-radius: 12px;
  }
}

/* Mobile adjustments - Modern touch-friendly */
@media (max-width: 768px) {
  .pg-gallery-item {
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,0.08);
  }

  /* Remove hover effects on touch devices */
  .pg-gallery-item:hover {
    transform: none;
    box-shadow: 0 1px 4px rgba(0,0,0,0.08);
  }

  .pg-gallery-item:hover img {
    transform: scale(1);  /* Sem zoom em mobile */
  }

  .pg-gallery-item:hover::before {
    opacity: 0;  /* Sem overlay em mobile */
    background: transparent;
  }
}

/* ============================================================================
   PATAGANG v1.6.0 — FASE 2 MODERNIZATION CSS
   Aspect-ratio container + SVG size-lock (minimal additions)
============================================================================ */

/* Aspect-ratio container for mobile carousel (replaces padding-bottom hack) */
.pg-aspect-ratio-container {
  position: relative;
  width: 100%;
  display: block;
  /* JavaScript sets height based on data-aspect-ratio if needed */
}

.pg-aspect-ratio-container img,
.pg-aspect-ratio-container svg {
  width: 100%;
  height: auto;
  display: block;
}

/* SVG size-lock for modal images */
.pg-modal-main-img {
  width: 100%;
  height: auto;
  max-width: 90vw;
  max-height: 90vh;
  object-fit: contain;
  display: block;
  margin: 0 auto;
}

/* Responsive aspect-ratio fallback */
@supports (aspect-ratio: 1) {
  .pg-aspect-ratio-container {
    height: auto;
  }
}

/* Ensure images respect container constraints */
@media (max-width: 768px) {
  .pg-modal-main-img {
    max-width: 100%;
    max-height: 70vh;
  }
}
