# 06. File Dependency Tree

## Arvore de composicao principal

```text
layouts/layout.tpl
├── CSS includes/links
│   ├── static/css/style-critical.tpl
│   ├── static/css/style-menu-patagang.css.tpl
│   ├── static/css/style-filters-patagang.css.tpl
│   ├── static/css/style-help-sidebar.css.tpl
│   ├── css/style-colors.scss.tpl
│   ├── css/style-async.scss.tpl
│   ├── css/style-home-v2.css
│   ├── css/product-card-v3.css
│   └── css/style-blog.scss.tpl
├── Snipplets globais
│   ├── header/header-advertising.tpl
│   ├── header/header-patagang.tpl
│   ├── cart-modal.tpl
│   ├── grid/quick-shop.tpl
│   ├── whatsapp-chat.tpl
│   ├── whatsapp-left.tpl
│   ├── help-sidebar.tpl
│   ├── footer.tpl
│   └── modal-newsletter.tpl
└── JS includes/scripts
    ├── static/js/external-no-dependencies.js.tpl (missing)
    ├── static/js/external.js.tpl (missing)
    ├── static/js/store.js.tpl
    ├── js/smooth-scroll.js
    └── js/version-info.js
```

## Dependencias por template (amostra operacional)

```text
templates/product.tpl
└── snipplets/product/*
    ├── product-identity-banner.tpl
    ├── product-informative-banner.tpl
    ├── product-image.tpl
    ├── product-form.tpl
    └── product-related.tpl

templates/category.tpl
└── snipplets/grid + product_grid
    ├── grid/categories.tpl
    ├── grid/filters.tpl
    ├── product_grid.tpl
    ├── grid/pagination.tpl
    └── defaults/show_help_category.tpl
```

## Dependencias de alto risco

- `layout.tpl` (composicao global + overrides CSS)
- `static/js/store.js.tpl` (comportamento transversal)
- `static/css/style-critical.tpl` (base visual global)
- referencias para `external*.tpl` ausentes no snapshot
