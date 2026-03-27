# 05. JavaScript Modules

## Arquivos JS ativos

### JS templated
- `static/js/store.js.tpl` (core)
- `static/js/cart-drawer.js.tpl`
- `static/js/cart-utils.js.tpl`
- `static/js/google-survey.js.tpl`
- `static/js/modules/notifications.js.tpl`
- `static/js/modules/forms.js.tpl`
- `static/js/modules/footer.js.tpl`
- `static/js/modules/utilities.js.tpl`

### JS plain
- `static/js/version-info.js`
- `static/js/smooth-scroll.js`
- `static/js/product-page-custom.js`
- `static/js/cart-drawer.js`

## Cadeia de carga observada no `layout.tpl`

- include: `static/js/external-no-dependencies.js.tpl` (referencia sem ficheiro no snapshot)
- include: `static/js/external.js.tpl` (referencia sem ficheiro no snapshot)
- include: `static/js/store.js.tpl`
- script: `js/smooth-scroll.js`
- script defer: `js/version-info.js`

## Modulos de maior impacto

### `store.js.tpl`
- 2992 linhas
- usa `jQueryNuvem` e `LS.*`
- concentra logica de produto/carrinho/frete/forms/modais

### `cart-drawer.js.tpl`
- controlador de drawer com integracao `LS.getCart`, `LS.changeQuantity`, `LS.removeItem`
- integra com `snipplets/cart-modal.tpl` e cart item templates

### `cart-utils.js.tpl`
- utilitarios de quantidade/remocao com feedback visual
- opera sobre seletores `js-cart-*` e `js-pg-*`

## Observacoes de arquitetura

- O projeto possui modularizacao parcial em `static/js/modules/*`.
- O runtime depende fortemente da API JS da plataforma (LS e jQueryNuvem).
- Qualquer refactor deve preservar eventos e contratos esperados pelos templates.
