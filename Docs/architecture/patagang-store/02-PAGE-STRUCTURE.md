# 02. Page Structure

## Templates ativos (21)

- `templates/home.tpl`
- `templates/category.tpl`
- `templates/product.tpl`
- `templates/cart.tpl`
- `templates/search.tpl`
- `templates/blog.tpl`
- `templates/blog-post.tpl`
- `templates/contact.tpl`
- `templates/page.tpl`
- `templates/404.tpl`
- `templates/password.tpl`
- `templates/produtos-em-desenvolvimento.tpl`
- `templates/account/login.tpl`
- `templates/account/register.tpl`
- `templates/account/reset.tpl`
- `templates/account/newpass.tpl`
- `templates/account/orders.tpl`
- `templates/account/order.tpl`
- `templates/account/addresses.tpl`
- `templates/account/address.tpl`
- `templates/account/info.tpl`

## Includes relevantes por pagina

### `templates/category.tpl`
- `snipplets/grid/categories.tpl`
- `snipplets/grid/filters.tpl`
- `snipplets/product_grid.tpl`
- `snipplets/grid/pagination.tpl`
- `snipplets/defaults/show_help_category.tpl`

### `templates/product.tpl`
- `snipplets/product/product-identity-banner.tpl`
- `snipplets/product/product-informative-banner.tpl`
- `snipplets/product/product-image.tpl`
- `snipplets/product/product-form.tpl`
- `snipplets/product/product-related.tpl`

### `templates/cart.tpl`
- `snipplets/cart-item-ajax.tpl`
- `snipplets/cart-totals.tpl`

### `templates/search.tpl`
- `snipplets/product_grid.tpl`
- `snipplets/grid/pagination.tpl`

### `templates/blog.tpl`
- `snipplets/blog/blog-post-item.tpl`
- `snipplets/grid/pagination.tpl`

### `templates/blog-post.tpl`
- `snipplets/social-share.tpl`

### `templates/password.tpl`
- `static/css/style-critical.tpl`
- `snipplets/footer.tpl`
- `static/js/external-no-dependencies.js.tpl` (referencia sem ficheiro ativo correspondente)

### `templates/page.tpl`
- `templates/produtos-em-desenvolvimento.tpl`

## Observacoes

- Nem todos os templates possuem includes diretos; parte da composicao vem de `layout.tpl`.
- Pags de conta (`templates/account/*`) usam majoritariamente estrutura nativa da plataforma e includes pontuais.
