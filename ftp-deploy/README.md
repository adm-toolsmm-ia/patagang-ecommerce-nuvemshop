# ftp-deploy — Patagang (AIOX v2)

**Fluxo padrão:** [`README-DEPLOYMENT.md`](./README-DEPLOYMENT.md) — usar este ficheiro como fonte de verdade para `deploy.js`, fases 0–6 e comandos `npm`.

## Comandos (resumo)

```bash
cd ftp-deploy
npm install   # primeira vez

npm run deploy:dry -- "mensagem"   # simular
npm run deploy -- "mensagem"       # deploy (patch); flags em package.json
npm run rollback
npm run list
npm run backup:full
npm run validate
node verify-sync.js   # opcional (não está no package.json; ver checklist AIOX)
```

Ou: `node deploy.js "mensagem" [--dry-run|--force|--minor]`

## Layout activo (não arquivar)

| Ficheiro / pasta | Função |
|------------------|--------|
| `deploy.js` | Pipeline AIOX v2 (versionamento + FTP + backup incremental) |
| `config.js`, `config.example.js`, `.env.example` | Config FTP (credenciais em `.env`, não commitar) |
| `rollback-incremental.js`, `list-backups.js`, `backup-full-ftp.js` | Operações de backup/rollback |
| `validate-nuvemshop-constraints.js` | Validação pré-deploy |
| `verify-sync.js` | Utilitário opcional (sincronização vs backup full — ver checklist AIOX) |

## Onde ficam os backups (v2)

- **Incremental pós-deploy:** `../backups/deployment-<versão>/<timestamp>/` (raiz do repositório), com `_METADATA.json`.
- **Não** usar a pasta `ftp-deploy/backups/` para novos snapshots — está reservada/vazia; histórico antigo foi movido para [`.archive/snapshots/`](./.archive/README.md).

**Nota de contexto:** `list-backups.js` / `rollback-incremental.js` ainda referem `../backups/incremental` (legado). Se o rollback não listar backups recentes do `deploy.js`, alinhar caminhos noutra story — ver `.archive/README.md`.

## Arquivo

Material antigo (logs soltos, relatório pontual, snapshot `001.1.1`, README da era `deploy-optimized`, scripts one-off) está em **[`.archive/`](./.archive/README.md)** para não poluir a rotina dos agentes.

## Outros guias no repositório

Ficheiros como `.aiox-core/development/docs/FTP_DEPLOY_GUIDE.md` ou checklists que citam `deploy-optimized.js` / `sync-backup-to-local.js` podem estar **desactualizados** face ao **v2** — em caso de dúvida, prevalece **`README-DEPLOYMENT.md`** + `deploy.js`.

---

*Mar/2026 — engenharia de contexto AIOX: raiz mínima + `README-DEPLOYMENT.md` como referência operacional.*
