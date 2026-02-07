# Engenharia de Contexto – Home Patagang Nuvemshop

Documento de referência para análises robustas: contexto do projeto, alterações solicitadas, alterações aplicadas pelo plano executado e levantamentos técnicos realizados.

**Versão:** 1.0
**Data:** 2026-02-02
**Projeto:** Patagang E-commerce – Tema Nuvemshop (deploy FTP)

---

## 1. Contexto do projeto

### 1.1 Estrutura de pastas relevante

```
patagang-ecommerce-nuvemshop/
├── theme-deploy-corrigido/     # Tema Nuvemshop (origem do deploy)
│   ├── config/                 # sections.txt, settings.txt, translations.txt, etc.
│   ├── layouts/
│   │   └── layout.tpl          # Shell global; {% template_content %} injeta o template da página
│   ├── templates/
│   │   └── home.tpl             # Conteúdo da home (quando template == 'home')
│   ├── snipplets/
│   │   ├── header/
│   │   │   └── header-patagang.tpl
│   │   ├── footer/
│   │   └── grid/
│   └── static/
│       ├── css/
│       │   ├── style-critical.tpl   # CSS inline no <head>
│       │   ├── style-async.scss.tpl # CSS assíncrono (media=print → all)
│       │   ├── style-home-v2.css    # CSS da home (carregado só se template == 'home')
│       │   ├── style-menu-patagang.css.tpl
│       │   └── style-filters-patagang.css.tpl
│       ├── js/
│       └── images/
├── ftp-deploy/                 # Scripts de deploy otimizado
│   ├── deploy-optimized.js     # Deploy com cache MD5; injeta Version ID no layout.tpl
│   ├── config.js               # Credenciais FTP (não versionado)
│   ├── LAST_DEPLOY_VERSION.txt # Version ID do último deploy (gerado pelo script)
│   └── README.md
└── scripts/
    ├── git-sync.ps1            # Commit + push para GitHub (branch main)
    └── git-sync.bat
```

### 1.2 Padrões: GitHub e deploy otimizado

**GitHub (sync local → repositório)**

- Scripts: `scripts/git-sync.ps1` (PowerShell) ou `scripts/git-sync.bat`
- Uso: `.\git-sync.ps1 "mensagem do commit"`
- Fluxo: verifica mudanças → `git add .` → commit → `git push origin main`
- Mensagem padrão: `"chore: sync projeto local"`

**Deploy otimizado (local → Nuvemshop via FTP)**

- Script principal: `ftp-deploy/deploy-optimized.js`
- Cache MD5: `.deploy-cache.json`; envia apenas arquivos modificados
- Backup incremental: antes do upload, baixa do FTP os arquivos remotos que serão substituídos → `backups/incremental/[TIMESTAMP]/`
- Version ID: gerado a cada deploy (ex.: `2026-02-02T23-27-19-3D7F90B4`); injetado em `layouts/layout.tpl` (meta + script no console da loja); salvo em `ftp-deploy/LAST_DEPLOY_VERSION.txt`
- Se há arquivos modificados mas `layout.tpl` não mudou, o script adiciona `layout.tpl` à lista de envio para atualizar a versão no FTP
- Comandos: `node deploy-optimized.js` (deploy); `node deploy-optimized.js --dry-run` (simular); `node deploy-optimized.js --force-all` (reenviar tudo)
- Pós-deploy: limpar cache do tema no admin Nuvemshop (Themes → tema ativo → Limpar Cache)

### 1.3 Como a home é renderizada

- A Nuvemshop injeta o conteúdo do template da página em `{% template_content %}` no `layout.tpl`
- Para a URL da home, `template == 'home'` e o conteúdo de `templates/home.tpl` é o que aparece
- A `<body>` recebe a classe `template-{{ template | replace('.', '-') }}` → na home: `template-home`
- Ordem de carregamento de CSS no `layout.tpl` (home):
  1. Critical (inline): `style-critical.tpl`, `style-menu-patagang.css.tpl`, `style-filters-patagang.css.tpl`
  2. Cores (inline): `style-colors.scss.tpl`
  3. Async (link): `style-async.scss.tpl` (media="print" → onload="all")
  4. Home (link, só se `template == 'home'`): `style-home-v2.css?v=...`
  5. Blog, `settings.css_code`

### 1.4 Estrutura HTML da home (home.tpl)

Três seções principais:

1. **Hero V2**
   - `<section class="pg-hero-v2">`
   - `<picture>` com `home-v2-hero-desktop.png` / `home-v2-hero-mobile.png`
   - CTAs: dois links `.pg-button.pg-button--highlight` (Produtos para Cachorro, Vista o Propósito)
   - Seta de scroll, h1/p SEO com classe `sr-only`

2. **Vista o Propósito**
   - `<section class="pg-section pg-section--vista-products">`
   - `.pg-container` → `.pg-section__header` (título + descrição) + `.pg-products-grid`
   - Cards: `.pg-product-card-v2` (imagem, link, botão "Shop"); produtos de `sections.primary.products` ou fallback por categoria "Vista"; até 5 produtos (`slice(0, 5)`)

3. **Seja o Primeiro a Conhecer**
   - `<section class="pg-section pg-section--grid-bg pg-section--coming-soon">`
   - Título + `.pg-dev-carousel` com `#dev-carousel-track`
   - Cards: `.pg-dev-card` (`.pg-dev-card__image`, `.pg-dev-card__info`, `.pg-dev-card__name`); produtos com tag "em-desenvolvimento" (Twig ou JS fetch); botões prev/next

### 1.5 Configuração do tema

- `config/sections.txt`: seção `primary` ("Destacados", até 40 produtos)
- `config/translations.txt`: inclui tradução "Mais Vendidos" (pt)
- `config/variants.txt` e `defaults.txt`: `home_order_position_0` = slider, _1 = welcome,_2 = categories, _3 = video,_4 = products, etc. (usado por instatheme.js para reordenar seções quando a home é montada por seções)
- InstaTheme (`static/js/instatheme.js`): container `.js-home-sections-container`, mapeamento `'products'` → `home-products-featured`; usado quando a home é construída por seções (slider, welcome, products, etc.), não quando se usa apenas o `home.tpl` customizado

---

## 2. Alterações solicitadas pelo usuário

Resumo das solicitações originais (melhorias e ajustes):

1. **Textos e margens (VISTA O PROPÓSITO e SEJA O PRIMEIRO A CONHECER)**
   - Reduzir tamanho dos textos para ficarem menores e menos chamativos.
   - Reduzir margens das seções (menos espaço em branco em cima, embaixo e laterais).

2. **Seção SEJA O PRIMEIRO A CONHECER**
   - **2.1** Reduzir altura dos cards e da imagem; aumentar um pouco a largura; diminuir espaço entre imagem e texto "Shop"; manter proporção e alinhamento.
   - **2.1 (imagens)** Revisar se algo deixa as imagens com qualidade baixa; remover blur se houver para exibir imagem original.
   - **2.2** Colocar a imagem de fundo quadriculada amarela atrás do conteúdo (sobre o background, atrás dos produtos e cards).
   - **2.3** Aumentar o limite de produtos visíveis de 4 para 5.

3. **Header**
   - Diminuir o tamanho dos ícones do header (exceto a logo) para um visual que ocupe menos espaço.

4. **Persona e instruções**
   - Atuar como especialista em HTML, CSS, UX/UI, SEO e design para e-commerce na Nuvemshop.
   - Usar estrutura e arquitetura mapeadas; consultar documentação Nuvemshop se necessário; auditar alterações e impacto.

---

## 3. Alterações aplicadas pelo plano executado

### 3.1 style-home-v2.css

**Textos e margens**

- `.pg-section--vista-products`: padding de `56px 0 72px` para `32px 16px 40px` (mobile); em `@media (min-width: 768px)` para `40px 24px 48px`.
- `.pg-section--grid-bg`: removido `background-image` do próprio elemento; padding reduzido para `32px 16px 40px` (mobile) e `40px 24px 48px` (≥768px); adicionado `overflow: hidden`.
- Quadriculado amarelo: criado `.pg-section--grid-bg::before` com `background-image: url('../images/home-v2-grid-bg.png')`, `position: absolute`, `inset: 0`, `z-index: 0`, `pointer-events: none`; conteúdo com `z-index: 1`.
- `.pg-section__header`: `margin-bottom` de 28px para 16px.
- `.pg-section__title`: `font-size` 23px → 16px; `margin` e `letter-spacing` ajustados.
- `.pg-section__desc`: `font-size` 25px → 14px; `line-height` → 1.45.
- Ajustes locais para Vista e Seja o Primeiro (font-size 15px, margin-bottom 8px/14px, etc.).

**Cards Seja o Primeiro (pg-dev-card)**

- Base: `width` 340px → 280px; `min-height` 320px → 260px.
- Breakpoints: 768px → width 300px; 1024px → 320px / min-height 280px; 1400px → 340px / min-height 300px.
- `.pg-dev-card__image`: `margin-bottom` 6px → 2px.
- `.pg-dev-card__info`: `padding` 2px 4px 0 → 2px 2px 0.
- Em `.pg-dev-card__image img` e `.pg-product-card-v2__image img`: adicionado `filter: none !important;` e `image-rendering: auto;`.

### 3.2 home.tpl

- Seção Vista o Propósito: `slice(0, 4)` → `slice(0, 5)`; comentário "máximo 4" → "máximo 5".
- Placeholders de loading do carousel: `{% for i in 1..4 %}` → `{% for i in 1..5 %}`.
- `product_image_url('large')` mantido (não foi usado 'huge' por não estar garantido na documentação Nuvemshop).

### 3.3 header-patagang.tpl

- Botões de ícone: `.pg-header__icon-button` de 44px para 36px (global e mobile).
- SVG/img dos ícones: de 20px para 16px (ícone sacola com height 18px).
- Atributos `width`/`height` dos SVGs e da img do menu ajustados no HTML.
- Bloco `<style>` atualizado com as novas dimensões e regras globais + mobile.

### 3.4 Comentários (alteração simples pós-plano)

- `style-home-v2.css`: cabeçalho "AJUSTES V2.1" → "AJUSTES V2.2 (plano executado)".
- `home.tpl`: linha "Plano executado: textos, margens, cards, 5 produtos." no comentário de cabeçalho.
- `header-patagang.tpl`: "v2.1 - Navegação Desktop + Ícones Refinados" → "v2.2 - Navegação Desktop + Ícones menores (plano executado)".

### 3.5 Deploy e Version ID

- Ajustes em `ftp-deploy/deploy-optimized.js`: geração e exibição do Version ID antes do upload; gravação do Version ID em `ftp-deploy/LAST_DEPLOY_VERSION.txt` após deploy bem-sucedido; mensagem no dry-run explicando Version ID e envio do layout.tpl.
- README do ftp-deploy atualizado com a explicação do Version ID e do arquivo LAST_DEPLOY_VERSION.txt.

---

## 4. Levantamentos técnicos realizados

### 4.1 Conflito de classes: .pg-dev-card em dois arquivos

**Problema**

- **style-critical.tpl** (inline, carrega primeiro), ~linhas 4792–4880: define `.pg-dev-card` com fundo em **gradiente radial amarelo** (spotlight), padding 40px, min-height 350px, e subelementos `__corner`, `__content`, `__title`, `__button` (estrutura diferente da home).
- **style-home-v2.css** (link, só na home): define `.pg-dev-card` com fundo #F6F6F6, `__image`, `__info`, `__name`, tamanhos reduzidos.

O HTML da home usa apenas `__image`, `__info`, `__name`. O critical não define esses blocos, mas define o container `.pg-dev-card`. Se o critical prevalecer (cache, ordem de carregamento, especificidade), o visual exibido é o do critical (gradiente amarelo), que pode ser interpretado como "overlays amarelos" nos cards.

**Recomendação**

- Aumentar a especificidade no `style-home-v2.css` para garantir que o visual da home prevaleça, por exemplo: `body.template-home .pg-section--coming-soon .pg-dev-card { ... }` e equivalentes para os subelementos.

### 4.2 Ordem de carregamento do CSS

- Na home: critical (inline) → async (link, carregamento assíncrono) → style-home-v2.css (link).
- O home-v2 vem depois do async; em teoria deveria ganhar quando a especificidade for igual. O critical é inline e vem primeiro; se não houver seletor mais específico no home-v2, conflitos podem ser resolvidos a favor do critical ou do async dependendo do seletor.
- Uso de `body.template-home` nos seletores do home-v2 aumenta a especificidade e reduz o risco de sobrescrita indesejada.

### 4.3 Blur nas imagens

- **style-critical.tpl** define `.blur-up`, `.blur-up-big`, `.blur-up-huge` com `filter: blur(...)`; ao carregar, `.lazyloaded` aplica `filter: none`.
- Na home, foi adicionado `filter: none !important` e `image-rendering: auto` em `.pg-dev-card__image img` e `.pg-product-card-v2__image img`.
- O grid padrão de produtos (snipplets/grid/item.tpl) usa classes como `js-item-image`, `lazyload`, `fade-in` (não `blur-up`). Se a seção exibida for "MAIS VENDIDOS" com esse grid, as regras do home-v2 não se aplicam a esses itens; o blur pode vir de lazy-load ou de outras regras.
- Recomendação: na home, forçar `filter: none !important` também para imagens dentro de `.pg-section--vista-products` e, se aplicável, para `.item-product .js-item-image` quando `body.template-home`.

### 4.4 "MAIS VENDIDOS" vs home.tpl customizado

- O tema tem duas formas possíveis de home:
  1. **Template customizado:** conteúdo de `home.tpl` (Hero, Vista o Propósito, Seja o Primeiro).
  2. **Home por seções:** container `.js-home-sections-container` + seções (slider, welcome, categories, products, etc.) ordenadas por instatheme.js; a seção "products" pode usar o título traduzido "Mais Vendidos".
- Se a loja estiver usando a home por seções em vez do `home.tpl`, o que aparece é "MAIS VENDIDOS" e o layout de seções; as alterações em `home.tpl` e em `style-home-v2.css` não se aplicam a essa vista.
- Recomendação: no admin Nuvemshop, confirmar se a página inicial usa o template customizado (home.tpl) ou a home por seções.

### 4.5 Possível origem dos "overlays amarelos" (screenshot)

- **Cards:** o design do critical para `.pg-dev-card` (gradiente radial amarelo) pode ser interpretado como retângulos/overlays amarelos se esse CSS prevalecer sobre o home-v2.
- **Hero:** os dois botões `.pg-button--highlight` (fundo #EAFE67) são intencionalmente amarelos; se estiverem grandes ou mal posicionados, podem parecer overlays.
- **Focus:** em style-async há `outline: 3px solid #EAFE67` em elementos de reviews/QA (ex.: `#reviewsapp a:focus`); não é global para todos os cards.
- **Outros:** `.coming-soon__overlay` e `.dev-product-card__overlay` em style-async são para outros contextos (ex.: produtos-em-desenvolvimento.tpl); só afetam a home se esse HTML existir nela.

### 4.6 Arquivos e trechos relevantes para auditoria

| Arquivo | Trecho / uso |
|--------|----------------|
| theme-deploy-corrigido/static/css/style-critical.tpl | .pg-dev-card (gradiente, __corner,__content, __title,__button); .blur-up*; body.template-home .pg-section--grid-bg |
| theme-deploy-corrigido/static/css/style-async.scss.tpl | .dev-product-card__overlay, .coming-soon__overlay; .dev-product-card__bg-image (filter: blur(15px)); outline #EAFE67 em reviews/QA; .item-product |
| theme-deploy-corrigido/static/css/style-home-v2.css | .pg-section--vista-products, .pg-section--grid-bg, .pg-section__title/__desc; .pg-dev-card, .pg-dev-card__image/__info; .pg-product-card-v2; filter: none em imagens |
| theme-deploy-corrigido/templates/home.tpl | Estrutura das 3 seções; slice(0, 5); placeholders 1..5 |
| theme-deploy-corrigido/snipplets/header/header-patagang.tpl | Ícones 36px/16px; bloco style inline |
| theme-deploy-corrigido/snipplets/grid/item.tpl | .js-item-product; image_classes com lazyload, fade-in |
| theme-deploy-corrigido/static/js/instatheme.js | .js-home-sections-container; home_order_position; 'products' → home-products-featured |
| theme-deploy-corrigido/config/sections.txt | primary "Destacados" |
| theme-deploy-corrigido/config/translations.txt | "Mais Vendidos" (pt) |

---

## 5. Checklist para análises futuras

- [ ] Confirmar qual home está ativa (template home.tpl vs home por seções).
- [ ] Verificar ordem e especificidade do CSS: critical (inline) vs async vs style-home-v2.css; usar `body.template-home` quando necessário.
- [ ] Verificar duplicação de classes (ex.: .pg-dev-card no critical e no home-v2) e garantir que o contexto da home ganhe (especificidade ou seletor único).
- [ ] Garantir que imagens da home não tenham blur indesejado: regras para .pg-dev-card__image img, .pg-product-card-v2__image img e, se for o caso, .item-product na home.
- [ ] Após alterações, rodar deploy (ou dry-run), limpar cache do tema no admin e validar Version ID no console da loja.
- [ ] Documentar qualquer novo conflito ou padrão descoberto neste documento ou em anexos.

---

## 6. Referências rápidas

- **Deploy:** `cd ftp-deploy` → `node deploy-optimized.js`; Version ID em `LAST_DEPLOY_VERSION.txt`.
- **Git sync:** `scripts\git-sync.ps1 "feat(home): descrição"`.
- **Limpar cache Nuvemshop:** Admin → Themes → tema ativo → Limpar Cache.
- **Validar Version ID:** F12 na loja → Console → mensagem "VERSÃO DO DEPLOY".
