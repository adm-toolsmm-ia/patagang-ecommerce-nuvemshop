# 📚 NUVEMSHOP - REFERÊNCIA COMPLETA PARA DESENVOLVIMENTO DE TEMAS VIA FTP

> **Versão:** 1.0.0
> **Data:** 16/11/2025
> **Objetivo:** Documentação técnica completa para desenvolvimento de layouts customizados na Nuvemshop via FTP
> **Uso:** Referência permanente para evitar erros e otimizar desenvolvimento

---

## 📑 ÍNDICE

1. [Estrutura de Arquivos Obrigatória](#1-estrutura-de-arquivos-obrigatória)
2. [Sistema de Templates (Twig)](#2-sistema-de-templates-twig)
3. [Objetos e Variáveis Disponíveis](#3-objetos-e-variáveis-disponíveis)
4. [Filtros e Funções](#4-filtros-e-funções)
5. [Configurações (settings.txt)](#5-configurações-settingstxt)
6. [Deploy via FTP](#6-deploy-via-ftp)
7. [Boas Práticas](#7-boas-práticas)
8. [Erros Comuns e Soluções](#8-erros-comuns-e-soluções)
9. [Checklist de Validação](#9-checklist-de-validação)
10. [Referências Oficiais](#10-referências-oficiais)

---

## 1. ESTRUTURA DE ARQUIVOS OBRIGATÓRIA

### 1.1 Visão Geral

```
theme/
├── config/              ⚠️ OBRIGATÓRIO
│   ├── settings.txt    ⚠️ OBRIGATÓRIO - Configurações do tema
│   ├── defaults.txt    ✓ Opcional - Valores padrão
│   └── translations.txt ✓ Opcional - Traduções
│
├── layouts/             ⚠️ OBRIGATÓRIO
│   └── layout.tpl      ⚠️ OBRIGATÓRIO - Template principal
│
├── templates/           ⚠️ OBRIGATÓRIO
│   ├── home.tpl        ⚠️ OBRIGATÓRIO
│   ├── product.tpl     ⚠️ OBRIGATÓRIO
│   ├── cart.tpl        ⚠️ OBRIGATÓRIO
│   ├── category.tpl    ⚠️ OBRIGATÓRIO
│   ├── search.tpl      ⚠️ OBRIGATÓRIO
│   ├── 404.tpl         ⚠️ OBRIGATÓRIO
│   ├── contact.tpl     ✓ Recomendado
│   ├── page.tpl        ✓ Recomendado
│   ├── password.tpl    ✓ Recomendado
│   └── account/        ✓ Recomendado
│       ├── login.tpl
│       ├── register.tpl
│       ├── orders.tpl
│       └── ...
│
├── snipplets/           ⚠️ OBRIGATÓRIO (manter estrutura completa)
│   ├── header.tpl
│   ├── footer.tpl
│   ├── navigation/
│   ├── product/
│   ├── forms/
│   └── ... (~50+ arquivos)
│
└── static/              ⚠️ OBRIGATÓRIO
    ├── css/
    │   └── style.css
    ├── js/
    │   └── main.js
    └── images/
```

### 1.2 Arquivos CRÍTICOS

**NUNCA DELETE estes arquivos:**

```
✗ config/settings.txt
✗ layouts/layout.tpl
✗ templates/home.tpl
✗ templates/product.tpl
✗ templates/cart.tpl
✗ templates/category.tpl
✗ TODA a pasta snipplets/ (pode customizar, mas não deletar)
```

---

## 2. SISTEMA DE TEMPLATES (TWIG)

### 2.1 Sintaxe Básica

```twig
{# Comentário #}

{{ variavel }}                    {# Output #}
{% comando %}                     {# Lógica #}

{# Condicionais #}
{% if condicao %}
    ...
{% elseif outra_condicao %}
    ...
{% else %}
    ...
{% endif %}

{# Loops #}
{% for item in items %}
    {{ item.nome }}
{% endfor %}
```

### 2.2 Tags OBRIGATÓRIAS no layout.tpl

```twig
<!DOCTYPE html>
<html lang="{{ language }}">
<head>
    <meta charset="utf-8">
    <title>{{ page_title }}</title>

    {# ⚠️ OBRIGATÓRIO - Scripts head da Nuvemshop #}
    {{ head_content }}
</head>
<body>

    {# ⚠️ OBRIGATÓRIO - Conteúdo dos templates #}
    {% template_content %}

    {# ⚠️ OBRIGATÓRIO - Scripts footer da Nuvemshop #}
    {{ foot_content }}
</body>
</html>
```

### 2.3 Include vs Embed

```twig
{# Include - Simples inclusão #}
{% include 'snipplets/header.tpl' %}

{# Include com variáveis #}
{% include 'snipplets/product-card.tpl' with {'product': product} %}

{# Embed - Inclusão com override de blocos #}
{% embed 'snipplets/modal.tpl' %}
    {% block content %}
        Conteúdo customizado
    {% endblock %}
{% endembed %}
```

---

## 3. OBJETOS E VARIÁVEIS DISPONÍVEIS

### 3.1 Objeto `store`

```twig
{{ store.name }}              {# Nome da loja #}
{{ store.url }}               {# URL completa #}
{{ store.logo }}              {# URL do logo #}
{{ store.description }}       {# Descrição #}
{{ store.email }}             {# Email #}
{{ store.phone }}             {# Telefone #}
{{ store.address }}           {# Endereço completo #}

{# URLs importantes #}
{{ store.cart_url }}          {# /cart #}
{{ store.search_url }}        {# /search #}
{{ store.contact_url }}       {# /contact #}
{{ store.customer_url }}      {# /account/login #}

{# Configurações #}
{{ store.currency }}          {# BRL, USD, etc #}
{{ store.country }}           {# BR, AR, MX #}
{{ store.language }}          {# pt, es, en #}
```

### 3.2 Objeto `product`

```twig
{# Informações básicas #}
{{ product.id }}
{{ product.name }}
{{ product.description }}
{{ product.price }}
{{ product.compare_at_price }}

{# Imagens #}
{{ product.featured_image }}
{{ product.images }}          {# Array de imagens #}

{# Variações #}
{{ product.variants }}        {# Array de variantes #}
{{ product.has_variants }}    {# true/false #}

{# Disponibilidade #}
{{ product.available }}       {# true/false #}
{{ product.stock }}           {# Quantidade #}

{# URLs #}
{{ product.url }}
{{ product.permalink }}

{# Categorias #}
{{ product.categories }}      {# Array #}
```

### 3.3 Objeto `cart`

```twig
{{ cart.items_count }}        {# Total de itens #}
{{ cart.total }}              {# Valor total #}
{{ cart.subtotal }}           {# Subtotal #}
{{ cart.items }}              {# Array de produtos #}

{# Loop pelos itens #}
{% for item in cart.items %}
    {{ item.product.name }}
    {{ item.quantity }}
    {{ item.price }}
    {{ item.subtotal }}
{% endfor %}
```

### 3.4 Variáveis Globais

```twig
{{ language }}                {# pt, es, en #}
{{ template }}                {# home, product, cart, etc #}
{{ page_title }}              {# Título da página #}
{{ page_description }}        {# Meta description #}

{# Settings customizadas #}
{{ settings.primary_color }}
{{ settings.nome_configuracao }}

{# Parâmetros URL #}
{{ params.q }}                {# Query de busca #}
{{ params.page }}             {# Página atual #}
```

---

## 4. FILTROS E FUNÇÕES

### 4.1 Filtro `static_url`

```twig
{# ⚠️ SEMPRE use para assets #}
{{ 'css/style.css' | static_url }}
{{ 'js/main.js' | static_url }}
{{ 'images/logo.png' | static_url }}

{# Resultado: #}
https://cdn.nuvemshop.com/themes/seu-tema/static/css/style.css
```

### 4.2 Filtro `money`

```twig
{{ product.price | money }}
{# Resultado: R$ 99,90 #}

{{ product.price | money_without_currency }}
{# Resultado: 99,90 #}
```

### 4.3 Filtro `translate`

```twig
{{ 'Adicionar ao carrinho' | translate }}
{{ 'products_viewed' | translate }}
```

### 4.4 Filtros de Imagem

```twig
{# Redimensionar #}
{{ product.featured_image | product_image_url('large') }}
{{ product.featured_image | product_image_url('medium') }}
{{ product.featured_image | product_image_url('small') }}

{# Dimensões específicas #}
{{ product.featured_image | product_image_url(width: 500) }}
{{ product.featured_image | product_image_url(width: 300, height: 400) }}
```

### 4.5 Outros Filtros Úteis

```twig
{{ texto | length }}          {# Tamanho #}
{{ texto | truncate(100) }}   {# Limitar caracteres #}
{{ texto | upper }}           {# MAIÚSCULAS #}
{{ texto | lower }}           {# minúsculas #}
{{ texto | capitalize }}      {# Primeira Maiúscula #}
{{ array | first }}           {# Primeiro item #}
{{ array | last }}            {# Último item #}
{{ number | round }}          {# Arredondar #}
```

---

## 5. CONFIGURAÇÕES (settings.txt)

### 5.1 Estrutura Básica

```ini
name = Nome do Tema
version = 1.0.0
author = Seu Nome

[colors]
primary_color = "#EAFE67"
secondary_color = "#000000"

[fonts]
primary_font = "Arial"
```

### 5.2 Tipos de Campo

```ini
[general]
# Cor
primary_color = color(default: "#000000", label: "Cor Primária")

# Checkbox
show_newsletter = checkbox(default: true, label: "Mostrar Newsletter")

# Dropdown
layout_style = dropdown(
    default: "wide",
    label: "Estilo do Layout",
    options: {
        "wide": "Largura Total",
        "boxed": "Centralizado"
    }
)

# Fonte
heading_font = font(
    default: "Arial",
    label: "Fonte dos Títulos"
)

# Imagem
banner_home = image(
    label: "Banner da Home"
)

# Galeria
product_gallery = gallery(
    label: "Galeria de Produtos"
)

# Texto internacionalizado
welcome_text = i18n_input(
    label: "Texto de Boas-vindas"
)

# Seção retrátil
collapse show_social(
    label: "Redes Sociais"
) {
    facebook_url = text(label: "Facebook URL")
    instagram_url = text(label: "Instagram URL")
}
```

### 5.3 Usando Settings nos Templates

```twig
{% if settings.show_newsletter %}
    {% include 'snipplets/newsletter.tpl' %}
{% endif %}

<div style="background-color: {{ settings.primary_color }}">
    ...
</div>

<img src="{{ settings.banner_home }}" alt="Banner">
```

---

## 6. DEPLOY VIA FTP

### 6.1 Credenciais

```
Host: ftp.nuvemshop.com.br
Porta: 21
Usuário: nome-da-loja
Senha: sua-senha
Protocolo: FTPS (TLS explícito)
```

### 6.2 Processo Seguro

```bash
1. ✅ SEMPRE fazer backup antes
2. ✅ Testar localmente se possível
3. ✅ Validar estrutura de arquivos
4. ✅ Upload via FTPS (seguro)
5. ✅ Validar loja após deploy
6. ✅ Ter plano de rollback
```

### 6.3 ⚠️ NUNCA FAÇA ISSO

```
✗ Deletar pasta config/
✗ Deletar layouts/layout.tpl
✗ Deletar TODOS os snipplets
✗ Deploy sem backup
✗ Testar direto em produção sem staging
✗ Upload via FTP inseguro (sem TLS)
```

---

## 7. BOAS PRÁTICAS

### 7.1 Organização de Código

```twig
{# ✅ BOM - Snipplets organizados #}
snipplets/
├── header/
│   ├── top-bar.tpl
│   ├── navigation.tpl
│   └── search.tpl
├── footer/
│   ├── columns.tpl
│   ├── newsletter.tpl
│   └── copyright.tpl
└── product/
    ├── gallery.tpl
    ├── form.tpl
    └── info.tpl

{# ✅ BOM - Comentários claros #}
{# ===================================
   HEADER - Navegação Principal
   =================================== #}

{# ❌ RUIM - Tudo em um arquivo gigante #}
```

### 7.2 Performance

```twig
{# ✅ Lazy loading de imagens #}
<img src="{{ product.image | product_image_url }}"
     loading="lazy"
     alt="{{ product.name }}">

{# ✅ Async/Defer para JS não-crítico #}
<script src="{{ 'js/analytics.js' | static_url }}" defer></script>

{# ✅ Preconnect para recursos externos #}
<link rel="preconnect" href="https://fonts.googleapis.com">
```

### 7.3 SEO

```twig
{# ✅ Meta tags completas #}
<title>{{ page_title }} - {{ store.name }}</title>
<meta name="description" content="{{ page_description }}">
<meta property="og:title" content="{{ product.name }}">
<meta property="og:image" content="{{ product.featured_image }}">

{# ✅ Dados estruturados #}
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "{{ product.name }}",
  "price": "{{ product.price }}"
}
</script>
```

### 7.4 Acessibilidade

```twig
{# ✅ ARIA labels #}
<button aria-label="Adicionar ao carrinho">
    <i class="icon-cart"></i>
</button>

{# ✅ Alt em imagens #}
<img src="..." alt="{{ product.name }}">

{# ✅ Landmarks HTML5 #}
<header role="banner">
<nav role="navigation">
<main role="main">
<footer role="contentinfo">
```

---

## 8. ERROS COMUNS E SOLUÇÕES

### 8.1 Erro 500 - Internal Server Error

**Causas:**
- Falta de arquivos obrigatórios (snipplets, templates)
- Sintaxe Twig incorreta
- Include de arquivo inexistente
- Tag `{% template_content %}` faltando

**Solução:**
```bash
1. Verificar logs (se disponíveis)
2. Restaurar estrutura completa do tema base
3. Re-aplicar customizações gradualmente
4. Validar sintaxe Twig
```

### 8.2 Página em Branco

**Causas:**
- layout.tpl sem `{% template_content %}`
- template específico vazio ou com erro
- PHP fatal error (raro)

**Solução:**
```twig
{# Garantir que layout.tpl tem: #}
{{ head_content }}
{% template_content %}
{{ foot_content }}
```

### 8.3 CSS Não Carrega

**Causas:**
- Caminho incorreto
- Falta de `| static_url`
- Arquivo não está em static/css/

**Solução:**
```twig
{# ❌ ERRADO #}
<link rel="stylesheet" href="/css/style.css">

{# ✅ CORRETO #}
<link rel="stylesheet" href="{{ 'css/style.css' | static_url }}">
```

### 8.4 Imagens Não Aparecem

**Causas:**
- Caminho incorreto
- Falta de filtro `| static_url` ou `| product_image_url`
- Arquivo muito grande (>5MB)

**Solução:**
```twig
{# ❌ ERRADO #}
<img src="/images/logo.png">

{# ✅ CORRETO - Asset estático #}
<img src="{{ 'images/logo.png' | static_url }}">

{# ✅ CORRETO - Imagem de produto #}
<img src="{{ product.featured_image | product_image_url('medium') }}">
```

### 8.5 Checkout Quebrado

**Causas:**
- Modificação incorreta de cart.tpl
- JavaScript conflitante
- Falta de snipplets de pagamento

**Solução:**
```bash
1. Restaurar cart.tpl original
2. Restaurar snipplets/payments/
3. Verificar JS console por erros
4. Testar sem JS customizado
```

---

## 9. CHECKLIST DE VALIDAÇÃO

### 9.1 Antes do Deploy

```
ESTRUTURA
□ config/settings.txt existe
□ layouts/layout.tpl existe
□ Todos templates obrigatórios presentes
□ Snipplets completos (não deletados)
□ static/css/ e static/js/ existem

LAYOUT.TPL
□ Tem {{ head_content }}
□ Tem {% template_content %}
□ Tem {{ foot_content }}
□ DOCTYPE e HTML válidos
□ Meta viewport para mobile

TEMPLATES
□ home.tpl funcional
□ product.tpl com formulário
□ cart.tpl com totais
□ category.tpl com grid
□ 404.tpl amigável

ASSETS
□ Todos CSS usam | static_url
□ Todos JS usam | static_url
□ Imagens otimizadas (<500KB)
□ Fontes carregando corretamente
```

### 9.2 Após Deploy

```
FUNCIONALIDADES
□ Loja abre sem erro
□ Home carrega completamente
□ Produtos abrem
□ Adicionar ao carrinho funciona
□ Checkout não quebrou
□ Busca retorna resultados
□ Menu de navegação funciona
□ Footer aparece

VISUAL
□ Logo carregando
□ Cores corretas
□ Fontes aplicadas
□ Imagens aparecendo
□ Layout responsivo
□ Sem elementos quebrados

PERFORMANCE
□ Tempo de carregamento <3s
□ Imagens com lazy load
□ CSS minificado
□ JS otimizado
□ Sem requests bloqueantes

SEO
□ Títulos únicos por página
□ Meta descriptions presentes
□ URLs amigáveis
□ Sitemap acessível
□ Robots.txt correto

ACESSIBILIDADE
□ Alt em todas imagens
□ ARIA labels em botões
□ Contraste adequado
□ Navegação por teclado
□ Landmarks HTML5
```

---

## 10. REFERÊNCIAS OFICIAIS

### 10.1 Documentação

- **Docs Nuvemshop:** https://docs.nuvemshop.com.br/
- **Base Theme GitHub:** https://github.com/TiendaNube/base-theme
- **Twig Documentation:** https://twig.symfony.com/doc/

### 10.2 Ferramentas

- **FileZilla:** Cliente FTP
- **VS Code:** Editor recomendado
- **Twig Extension:** Para syntax highlighting

### 10.3 Comunidade

- **Fórum Nuvemshop:** https://community.nuvemshop.com.br/
- **Suporte:** suporte@nuvemshop.com.br

---

## 📌 RESUMO RÁPIDO

**Estrutura Mínima:**
```
theme/
├── config/settings.txt          ⚠️
├── layouts/layout.tpl           ⚠️
├── templates/ (11 arquivos)     ⚠️
├── snipplets/ (~50 arquivos)    ⚠️
└── static/ (css, js, images)    ⚠️
```

**Tags Obrigatórias:**
```twig
{{ head_content }}
{% template_content %}
{{ foot_content }}
```

**Filtros Essenciais:**
```twig
{{ 'css/style.css' | static_url }}
{{ product.price | money }}
{{ product.image | product_image_url('medium') }}
```

**Deploy Seguro:**
```
1. Backup
2. Validar estrutura
3. Upload FTPS
4. Testar loja
5. Rollback se necessário
```

---

**🎯 Use este documento como referência SEMPRE que desenvolver temas Nuvemshop!**

**Última atualização:** 16/11/2025
**Versão:** 1.0.0
