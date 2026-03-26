# Contexto operacional — Patagang (Nuvemshop) para agentes e IA

**Função (AIOX):** inventário operacional L2 — regras imediatas, mapa de ficheiros e checklist antes de mexer no tema.  
**Caminho canónico:** este ficheiro é a fonte única para o conteúdo que estava duplicado na raiz (`CODEBASE.md` serve só de ponte).  
**Profundidade de cascade:** depois de ler isto, use [patagang-css-cascade.md](./patagang-css-cascade.md) para ordem detalhada, `!important` e casos de falha.

**Relacionado:** [Hub de arquitetura](./README.md) · [Série patagang-store](./patagang-store/README.md)

---

## Regra obrigatória: auditoria antes de alterar

**Antes de modificar qualquer CSS, HTML, JavaScript ou template (`.tpl`) em `theme-deploy-corrigido/`:**

1. Mapear **todos** os ficheiros que podem impactar a alteração.
2. Procurar conflitos de **especificidade** em **todos** os estilos relevantes.
3. Verificar a **cadeia completa de carregamento** (inline → critical → async → externo → overrides).
4. Só então planear e executar.

### Por que existe

A loja corre em **Nuvemshop**:

- Vários CSS com especificidade alta.
- `.scss.tpl` compilados e **cacheados** no servidor (mudanças podem não aparecer já).
- Componentes injetam classes e estilos.
- Classes genéricas (`.item-product`, `.item-image`, `.img-absolute`) têm regras fortes em `style-critical.tpl`.

**Se ignorar:** mudanças “certas” no papel são sobrescritas em silêncio por regra posterior ou mais específica.

---

## Arquitetura CSS — ordem de carregamento (resumo agente)

| Ordem | Ficheiro | Tipo | Cache |
| ----- | -------- | ---- | ----- |
| 1 | `style-critical.tpl` | Inline `<style>` no `<head>` | Template (sem cache SCSS) |
| 2 | `style-colors.scss.tpl` | Inline | SCSS compilado (server-side) |
| 3 | `style-async.scss.tpl` | `<link>` async | SCSS compilado + **cache** — pode atrasar reflexo |
| 4 | `product-card-v3.css` | `<link>` externo | Sem cache SCSS |
| 5 | `style-blog.scss.tpl` | `<link>` externo | SCSS compilado |
| 6 | **Override final** (`layout.tpl`) | Inline `<style>` no fim do `<body>` | Template — **vence o resto** |

### Regra de ouro do override

O bloco `<style id="pg-v3-override-final">` no fim de `layout.tpl` é o **único sítio garantido** para vencer todas as regras. Alterações só em `.scss.tpl` podem não bastar (cache) ou perder na cascade.

*Detalhe e linhas de exemplo:* [patagang-css-cascade.md](./patagang-css-cascade.md).

---

## Ficheiros críticos — dependências

### Templates de layout

| Ficheiro | Impacto |
| -------- | ------- |
| `layouts/layout.tpl` | Global, CSS/JS, override final |
| `snipplets/grid/item.tpl` | Cards de produto (`pg-card`, Nuvemshop) |
| `templates/category.tpl` | Categoria (`.pg-product-grid`) |
| `templates/search.tpl` | Busca (`.pg-product-grid`) |

### CSS

| Ficheiro | Conteúdo crítico |
| -------- | ---------------- |
| `static/css/style-critical.tpl` | `.img-absolute`, `.img-absolute-centered`, base; **ad bar** `.section-advertising__copy` (`gap` / `clamp`) — manter **alinhado** ao bloco `{% if settings.ad_bar and settings.ad_text %}` em `layouts/layout.tpl` |
| `static/css/style-async.scss.tpl` | Alta especificidade `.item-product`, `.item-image`, grid (**cacheado**) |
| `static/css/product-card-v3.css` | Cards V3 (`.pg-card`, …) |
| `static/css/style-home-v2.css` | Home (não cobre category/search) |

### Classes Nuvemshop (automáticas)

- `.item-product` — wrapper do card (≈ `.pg-card`)
- `.item-image` — container da imagem (≈ `.pg-card__image`)
- `.item-description` — info (≈ `.pg-card__info`)
- `.img-absolute` — posicionamento; `height: auto` pode causar overflow
- `.img-absolute-centered` — `transform` pode deslocar imagem
- `.js-item-product` — hook JS

---

## Checklist de auditoria (obrigatório)

Antes de alteração de frontend no tema:

```
[ ] 1. Pesquisar TODAS as propriedades CSS afetadas em .tpl e .css
[ ] 2. Comparar especificidade dos seletores encontrados vs. os novos
[ ] 3. Confirmar impacto de .scss.tpl cacheados
[ ] 4. Ver estilos inline em layout.tpl que possam sobrepor
[ ] 5. Ver se Nuvemshop injeta classes / inline
[ ] 6. Mapear ordem de carga e qual regra vence
[ ] 7. Se necessário, usar override final em layout.tpl
```

Checklist pós-mudança e deploy: ver secção em [patagang-css-cascade.md](./patagang-css-cascade.md).

---

## Deploy (referência rápida)

**Executar a partir da raiz do repositório.**

| Ação | Comando |
| ---- | ------- |
| Deploy (patch) | `node ftp-deploy/deploy.js "Descrição da mudança"` |
| Sem prompts | `node ftp-deploy/deploy.js "Descrição" --force` |
| Dry-run | `node ftp-deploy/deploy.js "Descrição" --dry-run` |
| Minor em vez de patch | acrescentar `--minor` |

O script atualiza versão, commit/tag/push conforme config e envia diff ao FTP.  
Validação: consola (F12) — mensagem `PATAGANG v…`.  
**Docs:** [ftp-deploy/README.md](../../ftp-deploy/README.md). **Rollback:** `node ftp-deploy/rollback-incremental.js` (detalhes no README).  
**Cache Nuvemshop:** Admin → Meus Temas → menu → Limpar cache.

---

## Dados estruturados (AIOX)

Atualizar padrões e snapshot quando descobrir algo novo (evitar só “conversa solta”):

| Ficheiro | Uso |
| -------- | --- |
| `.aiox-core/data/patagang-css-patterns.yaml` | Bons / maus padrões, lições |
| `.aiox-core/data/patagang-learned-patterns.yaml` | Padrões operacionais (ex.: FTP, JS) |
| `.aiox-core/data/patagang-architecture-state.yaml` | Estado do sistema, métricas, constraints |

**Constraints:** `.claude/rules/nuvemshop-ftp-constraints.md`, `.claude/rules/patagang-ftp-production-standard.md` (referenciados no [README de arquitetura](./README.md)).

---

**Última revisão documental:** alinhamento AIOX — contexto canónico em `Docs/architecture/`.
