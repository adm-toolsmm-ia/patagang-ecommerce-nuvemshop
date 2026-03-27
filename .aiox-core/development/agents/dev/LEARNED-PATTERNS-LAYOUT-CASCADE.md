---
name: Layout Cascade and CSS Specificity Debugging (Atualizado)
description: Referencia rapida para identificar origem real de estilos no tema ativo
type: dev-memory
created_at: "2026-03-26"
updated_at: "2026-03-26"
priority: HIGH
---

# Quick Reference: CSS que nao aplica

## 1) Verificar fonte da regra no DevTools

Passo minimo:
1. Inspecionar elemento
2. Aba Computed/Styles
3. Identificar ficheiro vencedor da regra

No tema atual, o vencedor frequentemente vem de:
- `layouts/layout.tpl` (blocos `<style>` inline)
- `static/css/style-critical.tpl`
- `static/css/style-colors.scss.tpl`

## 2) Estado atual de override

- `layouts/layout.tpl`: 100 ocorrencias de `!important`
- `style-critical.tpl`: 4765 linhas
- `style-async.scss.tpl`: 6189 linhas

Implicacao:
- alteracoes simples em CSS podem falhar por ordem de carga + especificidade.

## 3) Arquivos de referencia obrigatorios antes de alterar UI

- `theme-deploy-corrigido/layouts/layout.tpl`
- `theme-deploy-corrigido/static/css/style-critical.tpl`
- `theme-deploy-corrigido/static/css/style-colors.scss.tpl`
- `theme-deploy-corrigido/static/css/style-async.scss.tpl`

## 4) Alertas de dependencia JS (impacto indireto em UI)

`layout.tpl` inclui:
- `static/js/external-no-dependencies.js.tpl`
- `static/js/external.js.tpl`

No snapshot atual, ambos estao ausentes.
Antes de criar comportamento dependente deles, validar se:
- serao restaurados
- ou a carga sera removida/substituida

## 5) Regra de decisao rapida

Se o estilo nao aplica:
1. confirmar seletor e especificidade
2. verificar se `layout.tpl` esta sobrepondo
3. validar breakpoint
4. testar no ambiente com versao atual (`window.__PATAGANG_VERSION__`)

## 6) Nao inventar

Quando houver duvida entre docs antigas e codigo, priorizar sempre o codigo ativo.
