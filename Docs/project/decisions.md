# Decisões (ADR-lite) – Projeto Patagang

Índice leve de decisões arquiteturais com contexto e consequência. Detalhes técnicos ficam em context-home, standards e referencia-atual de cada feature.

---

## Override final no layout.tpl

**Contexto:** A plataforma Nuvemshop e o base theme podem injetar CSS que carrega depois dos nossos arquivos. Com mesma especificidade e `!important`, vence a última regra no documento.

**Decisão:** UI crítica (ad bar, listagem, PDP) usa bloco `<style>` **após** `settings.css_code` em `layout.tpl` para garantir que nossa regra vença na cascata.

**Consequência:** Não remover esses blocos sem garantir uma regra alternativa que carregue por último. Ver [standards-css-e-tema-nuvemshop.md](standards-css-e-tema-nuvemshop.md).

---

## CSS critical vs async

**Contexto:** Performance do first paint; evitar bloquear renderização com CSS não crítico.

**Decisão:** Critical inline para elementos above-the-fold; resto em `style-async.scss.tpl` (carregamento assíncrono via `media="print"` → `onload="all"`). Estilos por template (ex.: `style-home-v2.css`) carregados condicionalmente quando `template == 'home'` ou equivalente.

**Consequência:** Alterações em estilos de "below the fold" devem ir no async ou em arquivo específico; não inflar o critical desnecessariamente.

---

## Listagem (categoria e busca)

**Contexto:** Páginas de categoria e busca usam os mesmos snipplets (product_grid, item). O body recebe `template-category` ou `template-search`.

**Decisão:** Estilos principais da listagem em MÓDULO LISTAGEM no `style-async.scss.tpl`, escopados com `body.template-category, body.template-search`. Override final em `layout.tpl` para "última palavra" (padding, gap, proporção imagem, etc.).

**Consequência:** Ao alterar listagem, consultar [Docs/features/listagem-categoria-busca/](../features/listagem-categoria-busca/) para mapa completo e ordem de CSS.

---

## Features documentadas em Docs/features/

**Contexto:** Agentes de IA precisam saber onde alterar cada parte da loja sem depender apenas do código.

**Decisão:** Cada feature em `Docs/features/<nome>/` tem README (propósito, quando usar) e, quando há arquivos de tema/CSS envolvidos, `referencia-atual.md` (estado atual, onde alterar).

**Consequência:** Novas features seguem o mesmo padrão; atualizar referencia-atual ao alterar estrutura da feature.
