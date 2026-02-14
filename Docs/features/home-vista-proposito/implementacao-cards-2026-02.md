# Seção Vista o Propósito – Referência atual

Documentação da implementação **atual** da seção "Vista o Propósito" na home. Use como referência para engenharia de contexto e novas alterações.

**Última atualização:** 2026-02-13 (Brasília)  
**Fonte:** `theme-deploy-corrigido/` (versão oficial da loja)

---

## 1. Objetivo da seção

- Exibir até 5 produtos (seção primária ou categoria "Vista") em grid responsivo.
- Cards com imagem quadrada (aspect-ratio 1/1), link para o produto e botão "Shop".
- Efeito hover: elevação do card e troca de imagem quando há segunda imagem.

---

## 2. Estrutura no tema

### 2.1 Template (`templates/home.tpl`)

- Seção: `<section class="pg-section pg-section--vista-products">`
- Container: `.pg-container` → `.pg-section__header` (título + descrição) + `.pg-products-grid`
- Produtos: `sections.primary.products` ou fallback; limitado a **5** com `slice(0, 5)` (linha ~91).
- Cada item: `.pg-product-card-v2` com link (`.pg-product-card-v2__link`), área de imagem (`.pg-product-card-v2__image`) e botão (`.pg-product-card-v2__shop`).

### 2.2 CSS (`static/css/style-home-v2.css`)

**Grid (linhas ~346–367)**

- Mobile: 1 coluna, `gap: 16px`, `align-items: start`, `justify-content: center`
- ≥ 600px: 2 colunas, `gap: 20px`
- ≥ 900px: 3 colunas, `gap: 20px`, `max-width: 1100px`

**Card (linhas ~375–456)**

- `.pg-product-card-v2`: fundo `#F6F6F6`, `border-radius: 30px`, `padding: 12px`, sombra e hover com `translateY(-8px)`
- `.pg-product-card-v2__link`: block, sem sublinhado
- `.pg-product-card-v2__image`: `aspect-ratio: 1 / 1`, `border-radius: 20px`, fundo `#F9F9F9`; suporta segunda imagem para hover (`.pg-product-card-v2__img-hover`)
- `.pg-product-card-v2__image img`: `object-fit: cover`, `filter: none !important`, transição de opacidade no hover
- `.pg-product-card-v2__shop`: `padding: 10px 8px 4px`, `font-size: 13px`, `font-weight: 600`, `background: transparent`, sublinhado, uppercase

---

## 3. Classes principais

| Classe | Uso |
|--------|-----|
| `.pg-section--vista-products` | Seção Vista o Propósito |
| `.pg-products-grid` | Grid de cards (1/2/3 colunas conforme breakpoint) |
| `.pg-product-card-v2` | Card do produto |
| `.pg-product-card-v2__link` | Link para a página do produto |
| `.pg-product-card-v2__image` | Container da imagem (quadrado) |
| `.pg-product-card-v2__shop` | Botão "Shop" |

---

## 4. Validação e deploy

- **Versão em produção:** conferir em `ftp-deploy/LAST_DEPLOY_VERSION.txt` (campo `VERSION_ID`).
- **Validar na loja:** F12 → Console → mensagem "VERSÃO DO DEPLOY".
- **Rollback:** usar backup em `backups/incremental/[TIMESTAMP]/` conforme `ftp-deploy/README.md`; comando `node rollback-incremental.js [TIMESTAMP]`.

---

## 5. Arquivos relacionados

| Arquivo | Conteúdo relevante |
|---------|--------------------|
| `theme-deploy-corrigido/templates/home.tpl` | Estrutura da seção; `slice(0, 5)`; classes do grid e dos cards |
| `theme-deploy-corrigido/static/css/style-home-v2.css` | Grid (~346–367); card e variantes (~375–456) |

---

**Nota:** Esta documentação descreve o estado atual da loja. Para alterações futuras, use este doc como base de contexto e atualize-o após mudanças no tema.
