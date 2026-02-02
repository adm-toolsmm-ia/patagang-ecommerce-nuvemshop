# 📋 Context Engineering - Patagang E-commerce V1

> **Objetivo:** Documentação técnica completa da estrutura atual da loja para facilitar a implementação da V2.
> **Última atualização:** 2026-01-29

---

## 📁 Estrutura de Arquivos do Tema

```
📂 theme-deploy-corrigido/ (ou backups/version-01-official/)
├── 📂 config/                     # Configurações do tema
│   ├── data.json                  # Dados da loja
│   ├── defaults.txt               # Valores padrão das configurações
│   ├── settings.txt               # Definições de configurações do admin
│   ├── translations.txt           # Traduções (123KB)
│   └── variants.txt               # Variantes de tema
│
├── 📂 layouts/                    # Layout base
│   └── layout.tpl                 # Template principal (wrapper)
│
├── 📂 templates/                  # Templates de páginas
│   ├── home.tpl                   # ⭐ Home page (6.8KB)
│   ├── product.tpl                # Página de produto
│   ├── category.tpl               # Listagem de categoria
│   ├── cart.tpl                   # Carrinho
│   ├── contact.tpl                # Contato
│   ├── page.tpl                   # Páginas institucionais
│   ├── blog.tpl                   # Blog
│   └── 404.tpl                    # Erro 404
│
├── 📂 snipplets/                  # Componentes reutilizáveis (176 arquivos)
│
└── 📂 static/                     # Assets estáticos
    ├── 📂 css/                    # Estilos (8 arquivos)
    │   ├── style-critical.tpl     # ⭐ CSS crítico inline (176KB)
    │   ├── style-tokens.tpl       # ⭐ Variáveis CSS (37KB)
    │   ├── style-colors.scss.tpl  # Cores dinâmicas (25KB)
    │   ├── style-async.scss.tpl   # CSS assíncrono (181KB)
    │   ├── style-fonts.tpl        # Fontes
    │   ├── style-menu-patagang.css.tpl    # Menu customizado
    │   └── style-filters-patagang.css.tpl # Filtros customizados
    ├── 📂 js/                     # JavaScript
    └── 📂 images/                 # Imagens estáticas
```

---

## 🎨 Design Tokens - Patagang V1

### Cores Customizadas (Prefix: `--pg-`)

```css
:root {
  /* Cores Principais */
  --pg-color-primary: #EAFE67;        /* Amarelo Neon - CTA, destaques */
  --pg-color-primary-dark: #D4E856;   /* Hover do amarelo */
  --pg-color-black: #000000;          /* Preto principal */
  
  /* Tons de Cinza */
  --pg-color-gray-dark: #4A4A4A;      /* Textos secundários */
  --pg-color-gray-light: #E0E0E0;     /* Bordas */
  --pg-color-gray-lighter: #F5F5F5;   /* Fundos */
}
```

### Cores Padrão Nuvemshop (config/defaults.txt)

```css
/* Variáveis dinâmicas do admin */
$primary-color: #000000;     /* settings.primary_color */
$main-background: #FFFFFF;   /* settings.background_color */
$main-foreground: #000000;   /* settings.text_color */
$accent-color: #808E25;      /* settings.accent_color */
```

### Tipografia

```css
:root {
  /* Famílias de Fonte */
  --pg-font-display: 'Familjen Grotesk', 'Muli', sans-serif;
  --pg-font-body: 'Familjen Grotesk', 'Muli', sans-serif;
  
  /* Fontes do Admin (config/defaults.txt) */
  --heading-font: "Muli", sans-serif;  /* font_headings */
  --body-font: "Muli", sans-serif;     /* font_rest */
}
```

### Espaçamentos

```css
:root {
  --pg-spacing-1: 4px;
  --pg-spacing-2: 8px;
  --pg-spacing-3: 12px;
  --pg-spacing-4: 16px;
  --pg-spacing-5: 20px;
  --pg-spacing-6: 24px;
  --pg-spacing-7: 32px;
  --pg-spacing-8: 40px;
}
```

### Border Radius

```css
:root {
  --pg-radius-pill: 999px;   /* Botões, badges */
  --pg-radius-card: 24px;    /* Cards de produto */
}
```

---

## 🧩 Componentes UI Customizados

### 1. Header Patagang (`.pg-header`)

**Arquivo:** `static/css/style-critical.tpl` (linhas 377-625)

**Características:**
- Posição absolute/fixed sobre o hero
- Fundo transparente com blur (`backdrop-filter: blur(8px)`)
- Logo centralizada com hover animation
- Busca expansível inline
- Ícones glassmorphism

**Classes principais:**
```css
.pg-header              /* Container principal */
.pg-header--sticky      /* Estado fixo ao rolar */
.pg-header__row         /* Flex container */
.pg-header__logo        /* Logo centralizada */
.pg-header__icon-button /* Botões de ação (44x44px) */
.pg-header__search-wrapper /* Busca expansível */
.pg-header__cart-count  /* Badge do carrinho */
```

### 2. Hero Section (`.pg-hero`)

**Arquivo:** `static/css/style-critical.tpl` (linhas 252-375)

**Características:**
- Full viewport height (`min-height: 100vh`)
- Background preto com imagem em grayscale
- Overlay escuro (`rgba(0, 0, 0, 0.3)`)
- Título em amarelo neon (`--pg-color-primary`)
- Animação bounce na seta

**Classes principais:**
```css
.pg-hero                /* Container full-screen */
.pg-hero__media         /* Background image */
.pg-hero__content       /* Conteúdo centralizado */
.pg-hero__title         /* Título (4.5rem, italic, uppercase) */
.pg-hero__cta           /* Call-to-action */
.pg-hero__arrow         /* Seta animada */
```

### 3. Product Cards (`.pg-card`, `.pg-product-card`)

**Arquivo:** `static/css/style-critical.tpl` (linhas 203-250)

**Características:**
- Background amarelo (`--pg-color-primary`)
- Border radius 24px
- Shadow sutil com hover elevation
- Imagem com `object-fit: contain`

**Classes principais:**
```css
.pg-card                     /* Base card */
.pg-product-card__media      /* Container da imagem */
.pg-product-card__body       /* Conteúdo do card */
.pg-product-card__price      /* Preço */
```

### 4. Botões Patagang (`.pg-button`)

**Arquivo:** `static/css/style-critical.tpl` (linhas 156-180)

**Características:**
- Altura mínima 48px
- Border radius pill (999px)
- Uppercase com letter-spacing

**Variantes:**
```css
.pg-button--primary     /* bg: preto, hover: translateY(-2px) */
```

---

## 📄 Templates Principais

### home.tpl - Estrutura

```html
<!-- 1. HERO SECTION -->
<section class="hero visible-when-content-ready">
  <div class="hero__container">
    <div class="hero__content">
      <div class="hero__text-column">
        <!-- SVG: banner-dk-1.svg -->
        <!-- Título: "MUITO ALÉM DO BÁSICO" (sr-only) -->
      </div>
      <div class="hero__cta-column">
        <a href="{{ store.products_url }}" class="hero__cta">
          VER OS PRIMEIROS PRODUTOS
        </a>
      </div>
    </div>
    <div class="hero__scroll-indicator">
      <!-- Seta animada (amarelo #EAFE67) -->
    </div>
  </div>
</section>

<!-- 2. YELLOW GRADIENT WRAPPER -->
<div class="yellow-gradient-wrapper visible-when-content-ready">

  <!-- 2.1 PRODUTOS DESTAQUE -->
  <section class="featured-product visible-when-content-ready">
    <div class="featured-product__grid">
      <!-- 2 colunas: featured_product_1 e featured_product_2 -->
    </div>
  </section>

  <!-- 2.2 COMING SOON CARDS -->
  <section class="coming-soon visible-when-content-ready">
    <div class="coming-soon__grid">
      <!-- Cards com blur overlay: "EM DESENVOLVIMENTO" -->
    </div>
  </section>

</div>
```

---

## ⚙️ Configurações do Admin (settings.txt)

### Cores Primárias
| Setting | Descrição | Default |
|---------|-----------|---------|
| `primary_color` | Cor principal (botões) | `#000000` |
| `background_color` | Fundo | `#FFFFFF` |
| `text_color` | Textos | `#000000` |
| `accent_color` | Destaques, promoções | `#808E25` |

### Tipografia
| Setting | Descrição | Default |
|---------|-----------|---------|
| `font_headings` | Títulos | `"Muli", sans-serif` |
| `font_rest` | Corpo do texto | `"Muli", sans-serif` |

### Header
| Setting | Descrição | Default |
|---------|-----------|---------|
| `head_background` | Cor do fundo | `dark` |
| `head_transparent` | Transparente sobre carousel | `1` |
| `head_fix` | Sticky ao rolar | `1` |

### Home Page (Ordem das Seções)
```
0: slider
1: welcome
2: categories
3: video
4: products
5: instafeed
6: modules
7: informatives
```

---

## 🔧 Classes CSS Importantes

### Helpers de Visibilidade
```css
.visible-when-content-ready  /* visibility: hidden até CSS carregar */
.display-when-content-ready  /* display: none até CSS carregar */
```

### Grid System
```css
.pg-grid                  /* display: grid */
.pg-grid--products        /* 1col mobile → 2col tablet → 3col desktop */
```

### Container
```css
.pg-container             /* max-width: 1200px, padding: 16px */
.pg-section               /* padding vertical: 32px */
```

---

## 📱 Breakpoints

| Nome | Width | Uso |
|------|-------|-----|
| Mobile | < 600px | 1 coluna |
| Tablet | 600px+ | 2 colunas |
| Desktop | 768px+ | Header expandido |
| Large | 1024px+ | 3 colunas |

---

## 🚀 Dicas para Implementação V2

### ✅ Manter
- Prefix `--pg-` para variáveis customizadas
- Componentes glassmorphism do header
- Animações suaves (bounce, translateY)
- Sistema de cores amarelo/preto

### 🔄 Considerar Atualizar
- Tipografia (verificar se Adobe XD V2 tem fonte diferente)
- Espaçamentos (comparar com protótipo)
- Cards de produto (layout pode mudar)

### ⚠️ Cuidados
- Não quebrar compatibilidade com variáveis do admin (`settings.*`)
- Manter classes `.visible-when-content-ready` para CLS
- Testar em mobile (busca expansível é complexa)

---

## 📎 Arquivos de Referência

| Arquivo | Propósito | Relevância para V2 |
|---------|-----------|-------------------|
| `style-critical.tpl` | CSS crítico, componentes Patagang | ⭐⭐⭐ Alta |
| `style-tokens.tpl` | Variáveis CSS dinâmicas | ⭐⭐⭐ Alta |
| `home.tpl` | Estrutura da home | ⭐⭐⭐ Alta |
| `config/defaults.txt` | Valores padrão | ⭐⭐ Média |
| `style-colors.scss.tpl` | Cores SCSS | ⭐⭐ Média |
