# 01. Store Overview

## Objetivo

Descrever a arquitetura atual da loja com base no codigo ativo em `theme-deploy-corrigido/`.

## Topologia do tema

```text
theme-deploy-corrigido/
├── layouts/
│   └── layout.tpl
├── templates/
│   └── 21 templates ativos
├── snipplets/
│   └── 180 componentes .tpl
├── static/
│   ├── css/
│   ├── js/
│   └── checkout.scss.tpl
└── config/
    └── data.json, sections.txt, settings.txt, variants.txt, defaults.txt, translations.txt
```

## Dados-chave do snapshot

- Tema em producao: `v1.5.170`
- Arquivo de versao: `theme-deploy-corrigido/VERSION.json`
- Marker frontend: `theme-deploy-corrigido/static/js/version-info.js`
- Arquivo mestre: `theme-deploy-corrigido/layouts/layout.tpl` (1076 linhas)

## Camadas principais

1. **Composicao global**
   - `layout.tpl` injeta CSS, JS e snipplets transversais.
2. **Camada de pagina**
   - `templates/*.tpl` define estrutura por rota.
3. **Camada de componente**
   - `snipplets/**/*.tpl` para blocos reutilizaveis.
4. **Camada de estilo e comportamento**
   - `static/css/*` e `static/js/*`.

## Alertas estruturais observados

- `layout.tpl` inclui `external-no-dependencies.js.tpl` e `external.js.tpl`.
- Esses dois arquivos nao existem no snapshot atual em `static/js/`.
- `layout.tpl` possui 100 ocorrencias de `!important`, sinalizando alta pressao de override.

## Referencias relacionadas

- [02-PAGE-STRUCTURE.md](./02-PAGE-STRUCTURE.md)
- [04-CSS-ARCHITECTURE.md](./04-CSS-ARCHITECTURE.md)
- [05-JAVASCRIPT-MODULES.md](./05-JAVASCRIPT-MODULES.md)
