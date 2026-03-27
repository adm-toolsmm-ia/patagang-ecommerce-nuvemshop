# DevOps - FTP Standard Workflow (MANDATORY)

**Type:** Contextual rule (L3 - project configuration)  
**Applies to:** all FTP deploy changes in this repository  
**Severity:** critical

---

## Rule

Todo ajuste de loja deve seguir a sequencia:

1. Implementacao local
2. Commit em branch de trabalho
3. Deploy FTP versionado com backup
4. Validacao em producao
5. Push/PR apos aprovacao

Nao inverter fases.

---

## Operational flow

```text
Code -> Commit -> FTP Deploy -> Validation -> Push/PR
```

---

## Deploy command

```bash
node ftp-deploy/deploy.js "v1.x.x: descricao objetiva da mudanca" --force
```

---

## Required gates before deploy

- Branch de trabalho limpa
- Commit criado com descricao clara
- Lint, typecheck e testes sem falha
- Restricoes Nuvemshop preservadas
- Backup e rollback disponiveis

Se qualquer gate falhar: parar e corrigir antes do deploy.

---

## Rollback

```bash
node ftp-deploy/rollback-incremental.js --version vX.Y.Z
```

---

## Scope and context hygiene

- Esta regra nao depende de epic ou story especifica.
- Nao usar referencias arquivadas como contexto operacional padrao.
- Basear decisao tecnica no codigo atual e na versao vigente da loja (`v1.5.170`).

---

## Related active files

- `ftp-deploy/deploy.js`
- `ftp-deploy/rollback-incremental.js`
- `.aiox-core/development/docs/FTP_DEPLOY_GUIDE.md`
- `.aiox-core/development/docs/FTP_DEPLOY_AIOX_INTEGRATION.md`
