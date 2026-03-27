# FTP Deploy AIOX Integration

## Objetivo

Conectar o fluxo de deploy FTP da loja ao contexto de engenharia AIOX sem inventar requisitos e sem alterar comportamento de producao.

## Componentes reais integrados

- Execucao: `ftp-deploy/deploy.js`
- Scripts NPM: `ftp-deploy/package.json`
- Operacao e fases: `ftp-deploy/README-DEPLOYMENT.md`
- Versao do tema:
  - `theme-deploy-corrigido/VERSION.json`
  - `theme-deploy-corrigido/static/js/version-info.js`

## Camadas AIOX aplicadas

- **L3 (dados estruturados)**
  - `.aiox-core/data/patagang-store-catalog.yaml`
  - `.aiox-core/data/patagang-component-dependency-map.yaml`
  - `.aiox-core/data/patagang-architecture-state.yaml`
- **L4 (documentacao humana)**
  - `Docs/architecture/*`

## Fluxo de contexto para agentes

1. Ler L3 para snapshot atual da loja
2. Ler L4 para navegacao de arquitetura
3. Ler `ftp-deploy` para deploy/versionamento/rollback
4. Executar melhoria com validacao em runtime

## Contratos operacionais

- `@dev`: implementa no tema com base em contexto atualizado
- `@qa`: valida regressao funcional/visual
- `@devops`: executa deploy FTP e verifica marker de versao
- `@architect`/`@aiox-master`: mantem coerencia entre L3 e L4

## Alertas atuais de integracao

- `layout.tpl` referencia dois JS templated ausentes (`external-no-dependencies.js.tpl` e `external.js.tpl`).
- Este ponto deve constar em analises de impacto antes de depender desses arquivos em novas melhorias.

## Nao-objetivo

Esta integracao documental nao muda autoridade dos agentes e nao impede implementacao de melhorias.
Ela apenas reduz drift de contexto entre codigo e documentacao.
