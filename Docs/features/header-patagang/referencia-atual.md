# Header Patagang – Referência atual

Estado atual do header global. Use como referência para alterações; a estrutura e as classes podem ser modificadas conforme solicitação.

**Última atualização:** 2026-02-13 (Brasília)  
**Fonte:** `theme-deploy-corrigido/` (versão atual da loja)

---

## 1. Objetivo

- Header fixo ou estático (conforme `settings.head_fix`).
- Esquerda: hambúrguer (mobile) + navegação desktop (links do menu principal com dropdown).
- Centro: logo (link para a loja); hover troca para logo-mark.
- Direita: busca (abre modal), perfil, carrinho (com contador e, se configurado, modal fullscreen).

---

## 2. Arquivos principais

| Arquivo | Conteúdo |
|---------|----------|
| `snipplets/header/header-patagang.tpl` | HTML do header, modal de busca (`#nav-search`), modal hambúrguer, blocos `<style>` e `<script>` inline (ícones, nav desktop, dropdown, layout grid). |
| `static/css/style-menu-patagang.css.tpl` | Estilos do menu mobile (hambúrguer); referenciado no final do .tpl como “delegado”. |
| `static/css/style-filters-patagang.css.tpl` | Incluído no layout; pode conter estilos que afetam header/filtros (verificar se a alteração for em filtros). |
| `snipplets/header/header-search.tpl` | Conteúdo do modal de busca (campo de busca); incluído dentro do modal `#nav-search`. |

**Busca:** o botão de busca no header abre o modal `#nav-search`; o corpo do modal é o `header-search.tpl`. O “Search Overlay” com Destaques/Lançamentos é outro componente (ver `Docs/features/search-overlay/` se for o caso).

---

## 3. Estrutura de classes (resumo)

| Classe / elemento | Uso |
|-------------------|-----|
| `.pg-header` | Container do header; `.pg-header--sticky` quando fixo. |
| `.pg-header__container` | Wrapper com `.pg-container`. |
| `.pg-header__row` | Linha principal: flex; em ≥992px vira grid (3 colunas) para centralizar a logo. |
| `.pg-header__left-group` | Agrupa hambúrguer + nav desktop. |
| `.pg-header__hamburger-btn` | Botão menu mobile; `data-toggle="#nav-hamburger"`. |
| `.pg-header__nav-desktop` | Nav com links; visível a partir de 769px. |
| `.pg-header__nav-link` | Link do menu; variante `.pg-header__nav-link--dropdown` com seta. |
| `.pg-header__nav-item--has-dropdown` | Item com subitens; dropdown com `.js-dropdown-toggle` e `.js-dropdown-content`. |
| `.pg-header__logo` | Link da logo; dentro: `.pg-header__logo-img` (logotipo.svg) e `.pg-header__logo-img--hover` (logo-mark.svg). |
| `.pg-header__actions` | Grupo: busca, perfil, carrinho. |
| `.pg-header__icon-button` | Botão de ícone (30×30px; ícones 14px); no mobile ganha fundo/blur (inline). |
| `.pg-header__cart-count` | Contador do carrinho (`.js-cart-widget-amount`). |

---

## 4. Onde alterar (referência rápida)

- **Logo:** em `header-patagang.tpl`, trocar `images/logos/logotipo.svg` e `images/logos/logo-mark.svg` (ou caminhos/arquivos desejados).
- **Ícones (busca, perfil, sacola):** SVGs inline no .tpl; tamanho controlado pelo bloco `<style>` (`.pg-header__icon-button` 30px, svg/img 14px). Para mudar tamanho ou estilo, editar esse bloco ou o CSS externo que sobrescreva.
- **Menu desktop:** links vêm de `navigation` (Twig); estrutura em `.pg-header__nav-desktop`; “A GANG” é link fixo para `/comunidade`. Dropdown: `.js-dropdown-toggle` + `.js-dropdown-content` (data-dropdown / data-dropdown-id); script inline no final do .tpl abre/fecha e fecha ao clicar fora.
- **Busca:** botão com `data-toggle="#nav-search"`; modal definido no mesmo .tpl com `{% include "snipplets/header/header-search.tpl" with {search_modal: true}`. Estilos do modal de busca podem estar em `style-async.scss.tpl` (ex.: `.modal-nav-search`).
- **Menu mobile:** conteúdo do modal `#nav-hamburger` (embed de `modal.tpl` + painel); estilos em `style-menu-patagang.css.tpl`.

---

## 5. Estilos inline no `header-patagang.tpl`

- **Primeiro bloco `<style>`:** ícones (30px botão, 14px svg); no mobile: botões com fundo/blur, altura do header, logo menor, padding do container.
- **Segundo bloco `<style>`:** `.pg-header__left-group`, `.pg-header__nav-desktop`, `.pg-header__nav-link`, breakpoints (769px para mostrar nav e esconder hambúrguer; 768px para esconder nav; 992px grid para centralizar logo; 1100px e 1400px para margens); barra de frete transparente (`.section-advertising`); layout da row (grid em ≥992px) e logo centralizada; hover da logo (troca para logo-mark). Comentário no final remete o menu mobile a `style-menu-patagang.css.tpl`.

Ao alterar apenas cores ou espaçamentos do header, verificar se a regra já existe nesses blocos ou em `style-menu-patagang.css.tpl` antes de criar arquivo novo.

---

## 6. Arquivos relacionados

| Arquivo | Observação |
|---------|------------|
| `snipplets/modal.tpl` | Base dos modais (nav-search, nav-hamburger, etc.). |
| `snipplets/header/header-search.tpl` | Conteúdo do modal de busca. |
| `static/css/style-async.scss.tpl` | Pode conter classes do modal de busca (ex.: `.modal-nav-search`). |
| `layouts/layout.tpl` | Inclui o header (qual snipplet de header é usado depende da configuração do tema). |

Documentar alterações relevantes (ex.: novo modal ou mudança de estrutura do menu) quando fizer sentido para manutenção futura.
