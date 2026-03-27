# 08. Deployment Artifacts

## Estado atual de deploy (code-based)

- Pasta operacional: `ftp-deploy/`
- `package.json` de deploy: versao `2.0.0`
- Script principal: `ftp-deploy/deploy.js`
- Versionamento do tema:
  - `theme-deploy-corrigido/VERSION.json`
  - `theme-deploy-corrigido/static/js/version-info.js`

## Scripts disponiveis

- `npm run deploy`
- `npm run deploy:dry`
- `npm run deploy:minor`
- `npm run deploy:force`
- `npm run backup`
- `npm run rollback`
- `npm run list`
- `npm run validate`

## Artefatos e estrutura

- Backups incrementais documentados no fluxo de `deploy.js`.
- Material legado e snapshots antigos em `ftp-deploy/.archive/`.
- Referencia operacional atual: `ftp-deploy/README-DEPLOYMENT.md`.

## Marker de validacao em producao

- Console frontend deve expor:
  - `window.__PATAGANG_VERSION__`
  - log com `PATAGANG v<versao>`

## Observacoes importantes

- `ftp-deploy/README.md` ja indica coexistencia de conteudo legado e v2.
- Sempre considerar `README-DEPLOYMENT.md` e `deploy.js` como referencia operacional atual antes de atualizar procedimentos.
