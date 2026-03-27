{% raw %}@charset "UTF-8";

/*============================================================================
style-critical.tpl - Critical Path CSS (Inline in <head>)

    -WHAT IS THIS FILE?
    Above-the-fold CSS inlined in <head> = blocks render until loaded.
    Users see styles immediately = critical for LCP (Largest Contentful Paint).
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
  height: auto;                     /* Altura automtica baseada na proporo */
  max-height: 180px;                /* Limite mximo mais razovel */
  object-fit: contain;
  display: block;                   /* Remove espao extra embaixo */
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
  object-fit: contain; /* Forando contain para mostrar imagem completa */
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
  /* Espao para banner de aviso (ad bar) - ~48px para banner + padding */
  padding-top: 50px;
  /* CORRIGIDO 26/11: Altura mnima para garantir rea clicvel completa */
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
  min-height: 46px; /* Altura mnima para conter os botes */
}

.pg-header__icon-button {
  /* CORRIGIDO 26/11: Soluo definitiva para rea clicvel */
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
  padding: 0; /* REMOVIDO padding - cone centralizado apenas com flexbox */
  position: relative;
  z-index: 10;
  /* CRITICAL: Garante cliques em toda a rea */
  isolation: isolate; /* Cria novo contexto de empilhamento */
}

.pg-header__icon-button:hover {
  background: rgba(255, 255, 255, 0.5);
  border-color: rgba(0, 0, 0, 0.15);
}

.pg-header__icon-button img {
  /* CORRIGIDO 26/11: cones menores e centralizados para evitar conflito de rea clicvel */
  filter: none;
  width: 18px; /* Reduzido de 20px para 18px */
  height: 18px; /* Reduzido de 20px para 18px */
  display: block;
  pointer-events: none; /* Cliques passam para o boto pai */
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
  /* AJUSTADO: Remover filtro para logo preto conforme prottipo */
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
