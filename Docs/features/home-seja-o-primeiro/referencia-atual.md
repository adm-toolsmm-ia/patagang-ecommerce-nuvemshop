# Seja o Primeiro a Conhecer – Referência atual

Estado atual da seção "Seja o Primeiro a Conhecer" na home. Use como referência para alterações; a estrutura e as classes podem ser modificadas conforme solicitação.

**Última atualização:** 2026-02-13 (Brasília)  
**Fonte:** `theme-deploy-corrigido/` (versão atual da loja)

---

## 1. Objetivo da seção

- Exibir produtos com tag **"em-desenvolvimento"** (ou "em desenvolvimento") em carrossel horizontal com scroll nativo.
- Até **8** produtos (Twig); se Twig não encontrar, placeholders são exibidos e um script busca produtos via fetch na página de categoria como fallback.

---

## 2. Onde está no tema

### 2.1 Template (`templates/home.tpl`)

- **Seção:** `<section class="pg-section pg-section--grid-bg pg-section--coming-soon">`
- **Título:** "SEJA O PRIMEIRO A CONHECER" (`.pg-section__title`)
- **Carrossel:** `#dev-carousel` → `.pg-dev-carousel__track` (`#dev-carousel-track`)
- **Cards:** cada item é um `<a href="{{ product.url }}" class="pg-dev-card">` com `.pg-dev-card__image` (img) e `.pg-dev-card__info` (`.pg-dev-card__name`)
- **Navegação:** botões `.pg-dev-carousel__nav--prev` e `.pg-dev-carousel__nav--next`
- **Placeholders:** quando `dev_products` está vazio, 5 cards com classe `.pg-dev-card--loading` e skeleton; o JS pode substituir por produtos reais ou por placeholders "Em breve"

### 2.2 Origem dos dados (Twig)

- Variável `dev_products`: montada a partir de `sections.primary.products` ou, se vazio, de `products` (categoria/busca).
- Filtro: produtos que tenham tag `em-desenvolvimento` ou `em desenvolvimento`; máximo 8 (`dev_max = 8`).

### 2.3 Fallback JavaScript (inline em `home.tpl`)

- Se não houver cards renderizados pelo Twig, o script chama `fetchDevProducts()`.
- Faz fetch da página de categoria (ex.: `/produtos-cachorros`), parseia o HTML e injeta cards no `.pg-dev-carousel__track`.
- Placeholder de imagem: `images/placeholder-coming-soon.png`.

---

## 3. CSS – onde está e relação com o critical

### 3.1 Estilos da home (`static/css/style-home-v2.css`)

- **Seção e carrossel:** aprox. linhas 464–709 (`.pg-section--coming-soon`, `.pg-dev-carousel`, `.pg-dev-carousel__track`, `.pg-dev-carousel__nav`, `.pg-dev-card` na home).
- Os seletores da **home** usam **`body.template-home .pg-dev-card`** (e variantes) para garantir que o visual desta seção prevaleça sobre o critical. Ao alterar estilos desta seção, manter o uso de `body.template-home` quando for necessário que o visual da home prevaleça sobre outros arquivos.

### 3.2 Critical (`static/css/style-critical.tpl`)

- O critical define `.pg-dev-card` com outra **estrutura** (gradiente, `__corner`, `__content`, `__title`, `__button`), usada na **página de produto** (formulário de produto em desenvolvimento), não na home.
- Na home, o HTML usa apenas `__image`, `__info`, `__name`; o `style-home-v2.css` sobrescreve com `body.template-home .pg-dev-card` (reset e dimensões). Não é necessário alterar o critical para mudar apenas a seção da home.

---

## 4. Classes principais

| Classe | Uso |
|--------|-----|
| `.pg-section--grid-bg.pg-section--coming-soon` | Container da seção |
| `.pg-dev-carousel` | Carrossel (contêiner) |
| `.pg-dev-carousel__track` | Área de scroll (flex, overflow-x) |
| `.pg-dev-card` | Card do produto (link) |
| `.pg-dev-card__image` | Container da imagem |
| `.pg-dev-card__info` | Nome do produto (na home atual está `display: none`) |
| `.pg-dev-carousel__nav--prev` / `--next` | Botões anterior/próximo |

---

## 5. Arquivos relacionados

| Arquivo | Conteúdo relevante |
|---------|--------------------|
| `theme-deploy-corrigido/templates/home.tpl` | HTML da seção, Twig (dev_products), JS inline (carrossel + fetch) |
| `theme-deploy-corrigido/static/css/style-home-v2.css` | Estilos da seção e dos cards na home (aprox. 464–709) |
| `theme-deploy-corrigido/static/css/style-critical.tpl` | `.pg-dev-card` para PDP (outro contexto); não alterar para mudar só a home |

---

## 6. Validação e deploy

- **Versão em produção:** `ftp-deploy/LAST_DEPLOY_VERSION.txt`
- **Rollback:** conforme `ftp-deploy/README.md` (backups em `backups/incremental/`).

Documentar alterações relevantes (ex.: nova origem de dados ou mudança de especificidade) quando fizer sentido para manutenção futura.
