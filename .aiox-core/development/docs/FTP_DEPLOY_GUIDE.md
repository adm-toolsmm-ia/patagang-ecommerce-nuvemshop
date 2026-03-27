# FTP Deploy Guide (Patagang)

Guia operacional baseado no estado atual do codigo em `ftp-deploy/` e no marker de versao do tema.

## Escopo

- Deploy de alteracoes em `theme-deploy-corrigido/`
- Versionamento do tema em `VERSION.json` + `version-info.js`
- Backup e rollback via scripts da pasta `ftp-deploy/`

## Fonte de verdade operacional

1. `ftp-deploy/deploy.js`
2. `ftp-deploy/package.json`
3. `ftp-deploy/README-DEPLOYMENT.md`

## Scripts atuais

```bash
cd ftp-deploy
npm run deploy
npm run deploy:dry
npm run deploy:minor
npm run deploy:force
npm run backup
npm run rollback
npm run list
npm run validate
```

## Sequencia recomendada

1. Alterar codigo no tema (`theme-deploy-corrigido/`)
2. Commit Git
3. `npm run deploy:dry "mensagem"` para simulacao
4. `npm run deploy "mensagem"` para deploy real
5. Validar versao no frontend:
   - `window.__PATAGANG_VERSION__`
   - log `PATAGANG vX.Y.Z`

## Artefatos de versao

- `theme-deploy-corrigido/VERSION.json`
- `theme-deploy-corrigido/static/js/version-info.js`

No snapshot atual:
- versao: `1.5.170`
- marker JS sincronizado com `1.5.170`

## Observacoes de seguranca e contexto

- Credenciais devem ficar fora do versionamento (`.env`/config seguro).
- `ftp-deploy/.archive/` contem materiais legados; nao usar como fluxo principal.
- Se houver divergencia entre docs antigas e codigo, prevalece `deploy.js` + `README-DEPLOYMENT.md`.
