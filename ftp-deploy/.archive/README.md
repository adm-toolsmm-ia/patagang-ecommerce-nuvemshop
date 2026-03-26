# Arquivo — ftp-deploy

Conteúdo movido para **reduzir ruído** na engenharia de contexto (agentes AIOX) e evitar confusão com o workflow **v2** (`deploy.js` + `README-DEPLOYMENT.md`).

## O que há aqui

| Pasta / ficheiro | Origem | Nota |
|------------------|--------|------|
| `documentation/README-LEGACY-pre-v2-workflow.md` | `ftp-deploy/README.md` (antigo) | Referia `deploy-optimized.js`, caminhos `ftp-full`/`incremental` diferentes do v2 |
| `snapshots/001.1.1-2026-03-24-0900/` | `ftp-deploy/backups/` | Snapshot antigo sob `ftp-deploy`; o v2 grava em `../backups/deployment-*` |
| `root-artifacts/` | Raiz de `ftp-deploy/` | `deploy-output.log`, `deploy-story-7.1.log`, `DEPLOY_REPORT_*.txt`, `BACKUP-*.txt` |
| `logs-legacy/` | `ftp-deploy/logs/*.log` | Histórico de execuções; a pasta `logs/` na raiz do módulo fica para novos logs |
| `scripts-optional/` | Raiz de `ftp-deploy/` | `force-upload-css.js` (upload fixo de um CSS), `check-ftp-images.js` (listagem pontual), `normalize-accents-safe.pl` |

## Risco de gap (para correcção futura)

- **`deploy.js` (v2):** metadados em `_METADATA.json`, pastas `../backups/deployment-…`.
- **`rollback-incremental.js` / `list-backups.js`:** esperam `../backups/incremental` e `_BACKUP_METADATA.json` (legado).

Quando for prioridade de DevOps, unificar caminhos e formato de metadados para rollback e listagem refletirem o v2.

---

*Não apagar este índice sem atualizar `ftp-deploy/README.md`.*
