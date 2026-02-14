# Engenharia de Contexto – Home Patagang Nuvemshop

Documento de referência para o **estado atual** da loja: estrutura do projeto, deploy, home e levantamentos técnicos. Use como base para engenharia de contexto e novas alterações.

**Uso deste documento:** Este documento descreve o estado atual do projeto e da home para contextualizar o agente. **As alterações solicitadas pelo usuário têm prioridade** e podem modificar estrutura, classes, seções e comportamentos aqui descritos. Use estas informações para implementar com consciência de impacto (deploy, cache, especificidade, duas formas de home), **não como restrições fixas**. Para análises e alterações em CSS/tema, aplicar os padrões em [standards-css-e-tema-nuvemshop.md](standards-css-e-tema-nuvemshop.md).

**Última atualização:** 2026-02-13 (Brasília)
**Projeto:** Patagang E-commerce – Tema Nuvemshop (deploy FTP)
**Versão em produção:** conferir em `ftp-deploy/LAST_DEPLOY_VERSION.txt`

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
- Backup full: `node backup-full-ftp.js` salva todo o FTP em `backups/ftp-full/[TIMESTAMP]/`. Para igualar o tema local ao backup: `cd ftp-deploy` → `node sync-backup-to-local.js` (usa o último full) ou `node sync-backup-to-local.js [TIMESTAMP]`. Verificar: `node verify-sync.js`. Ver `ftp-deploy/README.md`.
- Version ID: gerado a cada deploy; injetado em `layouts/layout.tpl` (meta + script no console da loja); salvo em `ftp-deploy/LAST_DEPLOY_VERSION.txt`
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

A estrutura e as classes abaixo descrevem o **estado atual**; podem ser alteradas, estendidas ou renomeadas conforme solicitação.

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

## 2. Levantamentos técnicos (referência atual)

### 2.1 Conflito de classes: .pg-dev-card em dois arquivos

**Problema**

- **style-critical.tpl** (inline, carrega primeiro), ~linhas 5071–5241: define `.pg-dev-card` com fundo em **gradiente radial amarelo** (spotlight), padding 40px, min-height 350px, e subelementos `__corner`, `__content`, `__title`, `__button` (estrutura diferente da home).
- **style-home-v2.css** (link, só na home): define `.pg-dev-card` com fundo #F6F6F6, `__image`, `__info`, `__name`, tamanhos reduzidos.

O HTML da home usa apenas `__image`, `__info`, `__name`. O critical não define esses blocos, mas define o container `.pg-dev-card`. Se o critical prevalecer (cache, ordem de carregamento, especificidade), o visual exibido é o do critical (gradiente amarelo). **Se for necessário que o visual da home prevaleça sobre o critical**, considere aumentar a especificidade no `style-home-v2.css`, por exemplo: `body.template-home .pg-section--coming-soon .pg-dev-card { ... }` e equivalentes para os subelementos.

### 2.2 Ordem de carregamento do CSS

- Na home: critical (inline) → async (link, carregamento assíncrono) → style-home-v2.css (link).
- O home-v2 vem depois do async; em teoria deveria ganhar quando a especificidade for igual. O critical é inline e vem primeiro; se não houver seletor mais específico no home-v2, conflitos podem ser resolvidos a favor do critical ou do async dependendo do seletor.
- Uso de `body.template-home` nos seletores do home-v2 aumenta a especificidade e reduz o risco de sobrescrita indesejada.

### 2.3 Blur nas imagens

- **style-critical.tpl** define `.blur-up`, `.blur-up-big`, `.blur-up-huge` com `filter: blur(...)`; ao carregar, `.lazyloaded` aplica `filter: none`.
- Na home, há `filter: none !important` e `image-rendering: auto` em `.pg-dev-card__image img` e `.pg-product-card-v2__image img`.
- O grid padrão de produtos (snipplets/grid/item.tpl) usa classes como `js-item-image`, `lazyload`, `fade-in` (não `blur-up`). Se a seção exibida for "MAIS VENDIDOS" com esse grid, as regras do home-v2 não se aplicam a esses itens; o blur pode vir de lazy-load ou de outras regras.
- **Se surgir blur indesejado** em imagens da home, verificar `.pg-dev-card__image img`, `.pg-product-card-v2__image img` e, se for o caso, `.item-product .js-item-image` com `body.template-home` em `style-home-v2.css`.

### 2.4 "MAIS VENDIDOS" vs home.tpl customizado

- O tema tem duas formas possíveis de home:
  1. **Template customizado:** conteúdo de `home.tpl` (Hero, Vista o Propósito, Seja o Primeiro).
  2. **Home por seções:** container `.js-home-sections-container` + seções (slider, welcome, categories, products, etc.) ordenadas por instatheme.js; a seção "products" pode usar o título traduzido "Mais Vendidos".
- Se a loja estiver usando a home por seções em vez do `home.tpl`, o que aparece é "MAIS VENDIDOS" e o layout de seções; as alterações em `home.tpl` e em `style-home-v2.css` não se aplicam a essa vista. No admin Nuvemshop é possível confirmar qual home está ativa.

### 2.5 Especificidade na home

Na home, `.pg-dev-card` existe no critical (gradiente) e no `style-home-v2.css` (visual da seção "Seja o Primeiro a Conhecer); a especificidade define qual visual prevalece. Ao alterar estilos que afetem essa seção, considerar o impacto na ordem critical → async → home-v2 (ver 2.2).

### 2.6 Arquivos e trechos relevantes para auditoria

| Arquivo | Trecho / uso |
|--------|----------------|
| theme-deploy-corrigido/static/css/style-critical.tpl | .pg-dev-card (gradiente, __corner,__content, __title,__button); .blur-up*; body.template-home .pg-section--grid-bg |
| theme-deploy-corrigido/static/css/style-async.scss.tpl | .dev-product-card__overlay, .coming-soon__overlay; .dev-product-card__bg-image (filter: blur(15px)); outline #EAFE67 em reviews/QA; .item-product |
| theme-deploy-corrigido/static/css/style-home-v2.css | .pg-section--vista-products, .pg-section--grid-bg, .pg-section__title/__desc; .pg-dev-card, .pg-dev-card__image/__info; .pg-product-card-v2; filter: none em imagens |
| theme-deploy-corrigido/templates/home.tpl | Estrutura das 3 seções; slice(0, 5); placeholders 1..5 |
| theme-deploy-corrigido/snipplets/header/header-patagang.tpl | Ícones 30px/14px (botão/ícone); bloco style inline |
| theme-deploy-corrigido/snipplets/grid/item.tpl | .js-item-product; image_classes com lazyload, fade-in |
| theme-deploy-corrigido/static/js/instatheme.js | .js-home-sections-container; home_order_position; 'products' → home-products-featured |
| theme-deploy-corrigido/config/sections.txt | primary "Destacados" |
| theme-deploy-corrigido/config/translations.txt | "Mais Vendidos" (pt) |

---

## 3. Pontos de atenção ao alterar a home ou o tema

Ao alterar a home ou o tema, considerar (quando relevante para a alteração):

- Qual home está ativa (template home.tpl vs home por seções), pois isso define se mudanças em `home.tpl` e `style-home-v2.css` serão exibidas.
- Ordem e especificidade do CSS: critical (inline) → async → style-home-v2.css; uso de `body.template-home` quando quiser garantir que o estilo da home prevaleça.
- Duplicação de classes (ex.: .pg-dev-card no critical e no home-v2) e qual contexto deve prevalecer.
- Imagens da home: se houver blur indesejado, verificar .pg-dev-card__image img, .pg-product-card-v2__image img e, se for o caso, .item-product na home.
- Após alterações: deploy (ou dry-run), limpar cache do tema no admin e validar Version ID no console da loja.
- Documentar conflitos ou padrões novos **quando relevante** (ex.: novo conflito de classes ou ordem de CSS).

---

## 4. Referências rápidas

- **Deploy:** `cd ftp-deploy` → `node deploy-optimized.js`; Version ID em `LAST_DEPLOY_VERSION.txt`.
- **Git sync:** `scripts\git-sync.ps1 "feat(home): descrição"`.
- **Limpar cache Nuvemshop:** Admin → Themes → tema ativo → Limpar Cache.
- **Validar Version ID:** F12 na loja → Console → mensagem "VERSÃO DO DEPLOY".
- **Mais detalhe por feature:** `Docs/features/` (ex.: listagem-categoria-busca, home-vista-proposito, search-overlay, home-seja-o-primeiro, header-patagang). **Referência Nuvemshop:** `Docs/platform/reference.md`.
- **Arquitetura e decisões:** [Docs/architecture/](../architecture/), [Docs/project/decisions.md](decisions.md). **Onboarding para IA:** [Docs/project/ai-onboarding.md](ai-onboarding.md).
