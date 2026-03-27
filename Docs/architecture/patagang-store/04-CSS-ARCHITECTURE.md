# 04. CSS Architecture

## Arquivos CSS ativos no tema

### CSS/SCSS templated
- `static/css/style-critical.tpl`
- `static/css/style-colors.scss.tpl`
- `static/css/style-async.scss.tpl`
- `static/css/style-menu-patagang.css.tpl`
- `static/css/style-filters-patagang.css.tpl`
- `static/css/style-help-sidebar.css.tpl`
- `static/css/style-whatsapp-button.css.tpl`
- `static/css/style-blog.scss.tpl`
- `static/css/style-fonts.tpl`
- `static/css/style-tokens.tpl`
- `static/checkout.scss.tpl`

### CSS plain
- `static/css/style-home-v2.css`
- `static/css/product-card-v3.css`

## Ordem de carga real (a partir de `layout.tpl`)

1. includes inline:
   - `style-critical.tpl`
   - `style-menu-patagang.css.tpl`
   - `style-filters-patagang.css.tpl`
   - `style-help-sidebar.css.tpl`
2. inline de `style-colors.scss.tpl`
3. link async de `style-async.scss.tpl`
4. links complementares: `style-home-v2.css`, `product-card-v3.css`, `style-blog.scss.tpl`
5. blocos `<style>` inline adicionais em `layout.tpl` e em alguns snipplets (ex.: `footer.tpl`, `header/header-patagang.tpl`)

## Indicadores atuais

- `style-critical.tpl`: 4765 linhas
- `style-async.scss.tpl`: 6189 linhas
- `layout.tpl`: 100 ocorrencias de `!important`

## Implicacoes para melhorias UX/UI

- Mudancas visuais podem ser sobrescritas por CSS inline de `layout.tpl`.
- Ajustes em componentes globais devem considerar:
  - `layout.tpl`
  - `style-critical.tpl`
  - blocos inline do proprio snipplet

## Regra pratica

Antes de alterar estilo:
1. localizar o seletor na pagina
2. verificar origem da regra no DevTools (computed)
3. confirmar se o override vem de `layout.tpl` ou do ficheiro CSS esperado
