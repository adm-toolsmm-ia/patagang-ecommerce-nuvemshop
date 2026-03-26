# CODEBASE.md — Patagang E-commerce (Nuvemshop)

> **REGRA OBRIGATÓRIA**: Qualquer LLM que trabalhe neste projeto DEVE ler este arquivo antes de executar qualquer alteração.

---

## 🔴 REGRA #1: AUDITORIA PROFUNDA ANTES DE QUALQUER ALTERAÇÃO

**ANTES de modificar QUALQUER arquivo CSS, HTML, JavaScript ou template (.tpl), o agente DEVE:**

1. **Mapear TODOS os arquivos que podem impactar** na alteração solicitada
2. **Buscar conflitos de especificidade CSS** em TODOS os arquivos de estilo
3. **Verificar a cadeia completa de carregamento** (inline > critical > async > external > overrides)
4. **Só então planejar e executar** a alteração

### Por que esta regra existe

Este projeto usa a plataforma **Nuvemshop**, que tem:
- Múltiplos arquivos CSS com regras de altíssima especificidade
- Templates `.scss.tpl` compilados e cacheados pelo servidor (alterações no fonte podem não refletir)
- Componentes internos que adicionam classes e estilos automaticamente
- Herança de classes genéricas (`.item-product`, `.item-image`, `.img-absolute`) com regras no `style-critical.tpl`

**Consequência de NÃO seguir**: alterações que parecem corretas não funcionam na prática porque outra regra com maior especificidade ou carregada depois sobrescreve silenciosamente.

---

## 📂 Arquitetura CSS — Ordem de Carregamento

| Ordem | Arquivo                           | Tipo                                  | Cache                                                                       |
| ----- | --------------------------------- | ------------------------------------- | --------------------------------------------------------------------------- |
| 1     | `style-critical.tpl`              | Inline `<style>` no `<head>`          | Template engine (sem cache SCSS)                                            |
| 2     | `style-colors.scss.tpl`           | Inline                                | SCSS compilado (cacheado server-side)                                       |
| 3     | `style-async.scss.tpl`            | `<link>` async                        | **SCSS compilado + cacheado** — alterações podem não refletir imediatamente |
| 4     | `product-card-v3.css`             | `<link>` externo                      | Sem cache SCSS (carrega direto)                                             |
| 5     | `style-blog.scss.tpl`             | `<link>` externo                      | SCSS compilado                                                              |
| 6     | **Override final** (`layout.tpl`) | Inline `<style>` no final do `<body>` | **Template engine (sem cache)** — VENCE TUDO                                |

### ⚠️ Regra de Ouro do Override

O bloco `<style id="pg-v3-override-final">` no final do `layout.tpl` é o **único lugar garantido** para aplicar estilos que vençam TODAS as outras regras. Alterações nos `.scss.tpl` podem não refletir por cache server-side.

---

## 📂 Arquivos Críticos — Mapeamento de Dependências

### Templates de Layout
| Arquivo                   | Impacto                                                                             |
| ------------------------- | ----------------------------------------------------------------------------------- |
| `layouts/layout.tpl`      | Estrutura global, carregamento de CSS/JS, override final                            |
| `snipplets/grid/item.tpl` | HTML dos cards de produto (classes `pg-card`, integração com componentes Nuvemshop) |
| `templates/category.tpl`  | Página de categoria (wrapper `.pg-product-grid`)                                    |
| `templates/search.tpl`    | Página de busca (wrapper `.pg-product-grid`)                                        |

### CSS
| Arquivo                           | Conteúdo Crítico                                                                              |
| --------------------------------- | --------------------------------------------------------------------------------------------- |
| `static/css/style-critical.tpl`   | `.img-absolute` (position, height), `.img-absolute-centered` (transform), regras base do tema; **ad bar** `.section-advertising__copy` usa `gap` responsivo (`clamp`) — deve ficar **idêntico** ao bloco `{% if settings.ad_bar and settings.ad_text %}` no `layouts/layout.tpl` |
| `static/css/style-async.scss.tpl` | Regras de alta especificidade para `.item-product`, `.item-image`, grid flex (cacheado!)      |
| `static/css/product-card-v3.css`  | Estilos dos cards V3 (`.pg-card`, `.pg-card__image`, etc.)                                    |
| `static/css/style-home-v2.css`    | Estilos da home (não afeta category/search)                                                   |

### Classes Nuvemshop (adicionadas automaticamente pelos componentes)
- `.item-product` — card wrapper (equivale a `.pg-card`)
- `.item-image` — container de imagem (equivale a `.pg-card__image`)
- `.item-description` — info do produto (equivale a `.pg-card__info`)
- `.img-absolute` — posicionamento absoluto da imagem (`height: auto` = pode causar overflow!)
- `.img-absolute-centered` — centralização com `transform: translateX(-50%)` = pode deslocar imagem!
- `.js-item-product` — classe JS para interações

---

## 🔍 Checklist de Auditoria (OBRIGATÓRIO)

Antes de qualquer alteração de frontend, execute este checklist:

```
[ ] 1. grep_search por TODAS as propriedades CSS que serão alteradas em TODOS os .tpl e .css
[ ] 2. Verificar especificidade dos seletores encontrados vs. os seletores que serão usados
[ ] 3. Verificar se arquivos .scss.tpl são cacheados (alterações podem não refletir)
[ ] 4. Verificar se há estilos inline no layout.tpl que podem sobrescrever
[ ] 5. Verificar se componentes Nuvemshop adicionam classes/estilos inline automaticamente
[ ] 6. Mapear a ordem de carregamento CSS e identificar qual regra VENCE
[ ] 7. Se necessário, usar o override final no layout.tpl (último CSS da página)
```

---

## 🚀 Deploy

**Fluxo oficial:** rodar a partir da **raiz do repositório** (o script usa `git` na raiz e evita path errado no FTP).

| Ação | Comando |
| ---- | ------- |
| Deploy (incremento patch de versão) | `node ftp-deploy/deploy.js "Descrição da mudança"` |
| Sem prompts (CI / confiança) | `node ftp-deploy/deploy.js "Descrição" --force` |
| Só simular | `node ftp-deploy/deploy.js "Descrição" --dry-run` |
| Incrementar minor em vez de patch | acrescentar `--minor` |

O script atualiza versão (`theme-deploy-corrigido/VERSION.json`, `version-info.js`), faz commit/tag/push conforme configurado e envia ao FTP os arquivos detectados no diff.

- **Conferência rápida**: no site, abrir o console (F12) e localizar a mensagem `PATAGANG v…` coerente com o deploy.
- **Documentação adicional**: `ftp-deploy/README.md` (backup full, dry-run legado, etc.).
- **Rollback**: `node ftp-deploy/rollback-incremental.js` — uso e timestamps conforme README do `ftp-deploy`.
- **Cache Nuvemshop**: após deploy, Admin → Meus Temas → três pontinhos → Limpar cache.
