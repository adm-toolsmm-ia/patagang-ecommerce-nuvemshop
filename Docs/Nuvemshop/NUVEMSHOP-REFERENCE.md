# Referencia Tecnica Nuvemshop

> **Versao:** 2.0.0
> **Atualizado:** 12/12/2025
> **Uso:** Referencia rapida para desenvolvimento de temas Nuvemshop
> **Contexto:** Projeto Patagang - Layout validado e ativo em producao

---

## 1. Estrutura de Arquivos

### Arquivos OBRIGATORIOS (Nunca Deletar)

```
theme-deploy-corrigido/
├── config/
│   └── settings.txt          <- Configuracoes do tema
├── layouts/
│   └── layout.tpl            <- Template principal
├── templates/
│   ├── home.tpl              <- Pagina inicial
│   ├── product.tpl           <- Pagina produto
│   ├── cart.tpl              <- Carrinho
│   ├── category.tpl          <- Listagem categoria
│   ├── search.tpl            <- Busca
│   └── 404.tpl               <- Pagina erro
├── snipplets/                <- Componentes (manter todos)
└── static/
    ├── css/
    ├── js/
    └── images/
```

---

## 2. Sintaxe Twig

### Basico

```twig
{# Comentario #}

{{ variavel }}                    {# Output #}
{% comando %}                     {# Logica #}

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

### Tags Obrigatorias em layout.tpl

```twig
<!DOCTYPE html>
<html lang="{{ language }}">
<head>
    {{ head_content }}  {# Scripts Nuvemshop - OBRIGATORIO #}
</head>
<body>
    {% template_content %}  {# Conteudo templates - OBRIGATORIO #}
    {{ foot_content }}      {# Scripts footer - OBRIGATORIO #}
</body>
</html>
```

### Include de Snipplets

```twig
{# Include simples #}
{% include 'snipplets/header.tpl' %}

{# Include com variaveis #}
{% include 'snipplets/product-card.tpl' with {'product': product} %}

{# Embed com override de blocos #}
{% embed 'snipplets/modal.tpl' %}
    {% block content %}
        Conteudo customizado
    {% endblock %}
{% endembed %}
```

---

## 3. Filtros Essenciais

### static_url (Assets)

```twig
{# SEMPRE use para CSS, JS, imagens estaticas #}
{{ 'css/style.css' | static_url }}
{{ 'js/main.js' | static_url }}
{{ 'images/logo.png' | static_url }}

{# Resultado: #}
https://cdn.nuvemshop.com/themes/seu-tema/static/css/style.css
```

### money (Precos)

```twig
{{ product.price | money }}
{# Resultado: R$ 99,90 #}

{{ product.price | money_without_currency }}
{# Resultado: 99,90 #}
```

### product_image_url (Imagens de Produto)

```twig
{{ product.featured_image | product_image_url('large') }}
{{ product.featured_image | product_image_url('medium') }}
{{ product.featured_image | product_image_url('small') }}

{# Dimensoes especificas #}
{{ product.featured_image | product_image_url(width: 500) }}
{{ product.featured_image | product_image_url(width: 300, height: 400) }}
```

### translate

```twig
{{ 'Adicionar ao carrinho' | translate }}
```

### Outros Filtros Uteis

```twig
{{ texto | length }}          {# Tamanho #}
{{ texto | truncate(100) }}   {# Limitar caracteres #}
{{ texto | upper }}           {# MAIUSCULAS #}
{{ texto | lower }}           {# minusculas #}
{{ array | first }}           {# Primeiro item #}
{{ array | last }}            {# Ultimo item #}
```

---

## 4. Objetos Disponiveis

### store

```twig
{{ store.name }}              {# Nome da loja #}
{{ store.url }}               {# URL completa #}
{{ store.logo }}              {# URL do logo #}
{{ store.cart_url }}          {# /cart #}
{{ store.search_url }}        {# /search #}
{{ store.customer_url }}      {# /account/login #}
```

### product

```twig
{{ product.id }}
{{ product.name }}
{{ product.description }}
{{ product.price }}
{{ product.compare_at_price }}
{{ product.featured_image }}
{{ product.url }}
{{ product.available }}       {# true/false #}
{{ product.stock }}           {# Quantidade #}
{{ product.variants }}        {# Array de variantes #}
```

### cart

```twig
{{ cart.items_count }}        {# Total de itens #}
{{ cart.total }}              {# Valor total #}
{{ cart.subtotal }}           {# Subtotal #}

{% for item in cart.items %}
    {{ item.product.name }}
    {{ item.quantity }}
    {{ item.price }}
{% endfor %}
```

### Variaveis Globais

```twig
{{ language }}                {# pt, es, en #}
{{ template }}                {# home, product, cart, etc #}
{{ page_title }}
{{ page_description }}
{{ settings.primary_color }}  {# Settings customizadas #}
```

---

## 5. Variaveis por Template (CRITICO!)

### ATENCAO: Cada template tem variaveis DIFERENTES disponiveis!

**Erro Comum:** Usar `products` na home.tpl esperando produtos destacados.
**Correto:** Usar `sections.primary.products` na home.tpl.

### home.tpl - Pagina Inicial

```twig
{# PRODUTOS DESTACADOS - Configurados no Admin > Produtos > Organizar #}
{% if sections.primary.products and sections.primary.products | length > 0 %}
    {% for product in sections.primary.products %}
        {{ product.name }}
        {{ product.featured_image | product_image_url('large') }}
        {{ product.url }}
    {% endfor %}
{% endif %}

{# Primeiro produto destacado #}
{% set featured = sections.primary.products | first %}
```

| Variavel | Descricao | Tipo |
|----------|-----------|------|
| `sections.primary.products` | Produtos destacados da loja | Array |
| `store` | Dados da loja | Objeto |
| `cart` | Carrinho atual | Objeto |
| `settings` | Configuracoes do tema | Objeto |

### category.tpl / search.tpl - Listagem de Produtos

```twig
{# PRODUTOS DA CATEGORIA OU BUSCA #}
{% for product in products %}
    {{ product.name }}
{% endfor %}
```

| Variavel | Descricao | Tipo |
|----------|-----------|------|
| `products` | Produtos da categoria/busca | Array |
| `category` | Categoria atual | Objeto |
| `pages` | Paginacao | Objeto |
| `filters` | Filtros disponiveis | Array |

### product.tpl - Pagina de Produto

```twig
{# PRODUTO ATUAL #}
{{ product.name }}
{{ product.price | money }}
{{ product.featured_image | product_image_url('large') }}
```

| Variavel | Descricao | Tipo |
|----------|-----------|------|
| `product` | Produto atual | Objeto |
| `product.images` | Imagens do produto | Array |
| `product.variants` | Variantes | Array |

### 404.tpl - Pagina de Erro

```twig
{# PRODUTOS PARA SUGESTAO #}
{% set related = sections.primary.products | take(4) %}
```

### RESUMO RAPIDO

| Template | Para Produtos Use | NAO Use |
|----------|-------------------|---------|
| home.tpl | `sections.primary.products` | `products` |
| category.tpl | `products` | `sections.primary.products` |
| search.tpl | `products` | `sections.primary.products` |
| product.tpl | `product` (singular) | `products` |
| 404.tpl | `sections.primary.products` | `products` |

---

## 6. Arquivos CSS no Projeto

### Tipos e Quando Usar

| Arquivo | Tipo | Carregamento | Usar Para |
|---------|------|--------------|-----------|
| `style-critical.tpl` | Inline | Imediatamente | Header, Hero (above-the-fold) |
| `style-async.scss.tpl` | Lazy | Apos page load | Produtos, Footer, Modais |
| `style-colors.scss.tpl` | Inline | Imediatamente | Variaveis de cor |

### REGRA IMPORTANTE

```
Header/Hero → style-critical.tpl (CSS inline, carrega primeiro)
Resto       → style-async.scss.tpl (lazy load)
```

**Por que?**
- `style-critical.tpl` e renderizado inline no `<head>` via `{% include %}` no layout.tpl
- `style-async.scss.tpl` e carregado com `media="print" onload="this.media='all'"`
- Se colocar CSS de header no async, pode nao ser aplicado a tempo

---

## 7. Erros Comuns e Solucoes

### Erro 500 - Internal Server Error

**Causas:**
- Falta de arquivos obrigatorios
- Sintaxe Twig incorreta
- Tag `{% template_content %}` faltando

**Solucao:**
1. Verificar estrutura de arquivos
2. Restaurar do backup se necessario
3. Validar sintaxe Twig

### CSS Nao Carrega

**Causas:**
- Falta do filtro `| static_url`
- Caminho incorreto

**Correto:**
```twig
<link rel="stylesheet" href="{{ 'css/style.css' | static_url }}">
```

**Incorreto:**
```twig
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="../css/style.css">
```

### Alteracoes CSS Nao Aparecem

**Causas:**
- Editou arquivo CSS errado
- Editou classe CSS errada
- Cache da Nuvemshop

**Solucao:**
1. Verificar template usado em layout.tpl
2. Ver classes reais no template
3. Buscar onde classes estao definidas
4. Limpar cache da Nuvemshop apos deploy

---

## 8. Validacao Pre-Deploy

### Checklist Estrutura

```
[ ] config/settings.txt existe
[ ] layouts/layout.tpl existe
[ ] templates/home.tpl existe
[ ] templates/product.tpl existe
[ ] templates/cart.tpl existe
[ ] snipplets/ nao foi deletada
```

### Checklist layout.tpl

```
[ ] Tem {{ head_content }}
[ ] Tem {% template_content %}
[ ] Tem {{ foot_content }}
```

### Checklist Assets

```
[ ] CSS usa {{ 'path' | static_url }}
[ ] JS usa {{ 'path' | static_url }}
[ ] Imagens estaticas usam | static_url
```

---

## 9. Deploy

### Script Principal

```bash
cd ftp-deploy
node deploy-optimized.js
```

### Opcoes

```bash
# Apenas arquivos modificados (recomendado)
node deploy-optimized.js

# Ver o que seria enviado
node deploy-optimized.js --dry-run

# Forcar todos arquivos
node deploy-optimized.js --force-all

# Ver cache
node deploy-optimized.js --show-cache
```

### Pos-Deploy OBRIGATORIO

Limpar cache da Nuvemshop:
1. https://www.nuvemshop.com.br/admin/v2/themes
2. Menu (tres pontos) do tema ativo
3. "Limpar Cache" ou "Publicar novamente"

---

## 10. Rollback de Emergencia

**Backups Disponiveis:**
- Backups incrementais: `backups/incremental/[TIMESTAMP]/`
- Backups completos FTP: `backups/ftp-full/[TIMESTAMP]/`

**Opcao 1: Usar backup incremental (deploy recente)**
```powershell
# 1. Listar backups disponiveis
ls backups/incremental/

# 2. Copiar backup estavel para o tema
Copy-Item -Recurse -Force backups/incremental/[TIMESTAMP]/* theme-deploy-corrigido/

# 3. Deploy do backup
cd ftp-deploy
node deploy-optimized.js --force-all
```

**Opcao 2: Usar backup completo FTP (backup completo do servidor)**
```powershell
# 1. Listar backups completos
ls backups/ftp-full/

# 2. Copiar backup completo para o tema
Copy-Item -Recurse -Force backups/ftp-full/[TIMESTAMP]/* theme-deploy-corrigido/

# 3. Deploy do backup
cd ftp-deploy
node deploy-optimized.js --force-all
```

**Nota:** Sempre verificar o conteudo do backup antes de restaurar. Use `verify-sync.js` para comparar.

---

## 11. Referencias Oficiais

- **Docs Nuvemshop:** https://docs.nuvemshop.com.br/
- **Base Theme GitHub:** https://github.com/TiendaNube/base-theme
- **Twig Documentation:** https://twig.symfony.com/doc/

---

**Ultima atualizacao:** 12/12/2025

