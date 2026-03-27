# Patagang Architecture Documentation

Hub de arquitetura e engenharia de contexto da loja, alinhado ao modelo AIOX e atualizado a partir do codigo ativo.

## Fonte de verdade

Esta pasta usa como base:
- `theme-deploy-corrigido/**/*`
- `ftp-deploy/**/*`
- `.aiox-core/data/patagang-store-catalog.yaml`
- `.aiox-core/data/patagang-component-dependency-map.yaml`
- `.aiox-core/data/patagang-architecture-state.yaml`

`Docs/` e `docs/` sao destino documental, nao origem de verdade tecnica.

## Estado atual confirmado

- Versao do tema: `1.5.170` (`theme-deploy-corrigido/VERSION.json`)
- Marker runtime: `window.__PATAGANG_VERSION__ = "1.5.170"` (`theme-deploy-corrigido/static/js/version-info.js`)
- Estrutura ativa: `1 layout`, `21 templates`, `180 snipplets`, `19 assets .tpl` em `static/`
- Ponto de atencao: `layouts/layout.tpl` referencia `static/js/external-no-dependencies.js.tpl` e `static/js/external.js.tpl`, mas esses arquivos nao existem no snapshot atual.

## Ordem recomendada para montar contexto (AIOX)

1. `Docs/architecture/patagang-store/README.md`
2. `.aiox-core/data/patagang-architecture-state.yaml`
3. `.aiox-core/data/patagang-component-dependency-map.yaml`
4. `.aiox-core/data/patagang-store-catalog.yaml`
5. `.aiox-core/development/docs/FTP_DEPLOY_GUIDE.md`

## Mapa documental

- `patagang-store/01-STORE-OVERVIEW.md` — panorama estrutural atual
- `patagang-store/02-PAGE-STRUCTURE.md` — templates e includes reais
- `patagang-store/03-COMPONENT-INVENTORY.md` — inventario de componentes ativos
- `patagang-store/04-CSS-ARCHITECTURE.md` — cadeia CSS e pontos de override
- `patagang-store/05-JAVASCRIPT-MODULES.md` — modulos JS ativos e acoplamentos
- `patagang-store/06-FILE-DEPENDENCY-TREE.md` — relacoes layout/templates/snipplets/assets
- `patagang-store/07-NUVEMSHOP-CONSTRAINTS.md` — constraints e limites de plataforma
- `patagang-store/08-DEPLOYMENT-ARTIFACTS.md` — deploy/rollback/versionamento real

## Nao-objetivo explicito

Esta base nao bloqueia melhorias nem altera implementacao da loja.
Objetivo exclusivo: fornecer contexto tecnico confiavel para acelerar novas melhorias UX/UI com menos retrabalho.

## Governanca AIOX

- L3 (dados estruturados): `.aiox-core/data/*`
- L4 (documentacao humana): `Docs/architecture/*`
- Regras operacionais: `.claude/rules/*`

## Atualizacao

- Ultima revisao factual: `2026-03-26`
- Metodo: inventario + mapeamento de dependencias por leitura de codigo
