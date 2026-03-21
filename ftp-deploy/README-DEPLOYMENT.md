# 🚀 PATAGANG Deployment System v1.1.5+

## Rotina Única e Final de Deployment

Após **limpeza completa de scripts legados**, existe **UMA ÚNICA ROTINA** de deployment:

### `deploy.js` — Rotina Definitiva

```bash
# Opção 1: Usar versão atual em ftp-deploy/VERSION
node deploy.js

# Opção 2: Especificar versão
node deploy.js 1.1.5

# Opção 3: Sem backup incremental
node deploy.js 1.1.5 --no-backup
```

### Fluxo Automatizado

```
1️⃣  SINCRONIZAR VERSÃO
    └─ Lê VERSION.json ou argumento
    └─ Atualiza theme-deploy-corrigido/VERSION.json
    └─ Atualiza theme-deploy-corrigido/static/js/version-info.js
    └─ Atualiza ftp-deploy/VERSION

2️⃣  BACKUP INCREMENTAL
    └─ Conecta ao FTP
    └─ Baixa versão atual de cada arquivo
    └─ Salva em: backups/deployment-{version}/{timestamp}/
    └─ Cria _METADATA.json com documentação

3️⃣  DEPLOY PARA FTP
    └─ Força máxima: reconecta FTP a cada arquivo
    └─ Envia 4 arquivos críticos:
       • templates/product.tpl
       • snipplets/product/product-form.tpl
       • snipplets/product/product-informative-banner.tpl
       • static/js/version-info.js (versionamento)

4️⃣  VALIDAÇÃO PÓS-DEPLOY
    └─ Conecta ao FTP
    └─ Baixa cada arquivo para verificar integridade
    └─ Confirma 100% dos arquivos no servidor

5️⃣  RELATÓRIO FINAL
    └─ Exibe estatísticas
    └─ Mostra caminho do backup
    └─ Instruções para validação em produção
```

## Versão Atual

**v1.1.5** — Versão está sincronizada em:
- ✅ `theme-deploy-corrigido/VERSION.json`
- ✅ `theme-deploy-corrigido/static/js/version-info.js`
- ✅ `ftp-deploy/VERSION`
- ✅ FTP Server (validado)

**Console Output (após Ctrl+F5):**
```
📦 PATAGANG v1.1.5 (2026-03-21)
ℹ️ Version Info: {version: '1.1.5', date: '2026-03-21', timestamp: '2026-03-21T...'}
```

## Scripts Mantidos

| Script | Propósito | Usar quando |
|--------|-----------|-----------|
| **deploy.js** | Rotina principal | **SEMPRE** (única rotina) |
| config.js | Credenciais FTP | Nunca modificar |
| config.example.js | Template | Referência |
| backup-full-ftp.js | Backup completo | Backup manual do site inteiro |
| rollback-incremental.js | Restaurar versão anterior | Emergência (rollback) |
| list-backups.js | Listar backups | Debug e auditoria |
| check-ftp-images.js | Validar imagens | Validação de assets |

## Scripts Deletados (Legado)

❌ Todos esses foram **deletados permanentemente**:
- deploy-critical-only.js
- deploy-optimized.js
- deploy-story-71.js
- deploy-story-71-v1.1.4.js
- deploy-with-version.js
- investigate-version.js
- sync-backup-to-local.js
- sync-version.js
- deploy-verify.js
- debug-ftp.js
- fix-critical-issues.js
- force-cache-bust.js
- deploy-incremental-aiox.js

**Motivo:** Foram substituídos por `deploy.js` que consolida toda a funcionalidade em uma única rotina.

## Validação em Produção (FASE 4)

Após executar `node deploy.js`:

1. **Limpar cache do navegador:**
   ```
   Windows: Ctrl + F5 (Hard Refresh)
   Mac: Cmd + Shift + R
   ou Menu → Limpar dados de navegação
   ```

2. **Acessar página de produto em produção** e verificar:
   - ✅ Console mostra "📦 PATAGANG v1.1.5"?
   - ✅ Banner informativo aparece no **TOPO** da página?
   - ✅ Desconto é **VISÍVEL** no card de preço?
   - ✅ Produto não invade a hero section (proporções 57/43 corretas)?

3. **Se tudo OK:**
   - Deploy foi sucesso ✅
   - Story 7.1 pronta para conclusão

4. **Se algum problema:**
   - Documentar qual elemento está errado
   - Usar `backup-full-ftp.js` ou `rollback-incremental.js` para revert
   - Investigar novamente

## Troubleshooting

### Versionamento não atualiza no console

**Causa:** Cache do navegador
**Solução:** `Ctrl+F5` (hard refresh, limpa cache)

### Deploy falha com "Connection timeout"

**Causa:** FTP indisponível ou credenciais erradas
**Verificar:** `config.js` - FTP_CONFIG.host, user, password

### Arquivo desaparece do FTP

**Causa:** Pode haver conflito FTP ou timeout
**Solução:** Reexecutar `node deploy.js` (força máxima + validação reconecta a cada arquivo)

## Commit History (v1.1.5+)

```
0761d5a devops: ROTINA DEFINITIVA — deploy.js + limpeza completa
510eed7 devops: Deploy PDP Fix v1.1.5 — validação FTP
243c9f5 chore: Bump version to 1.1.5
ca3cd37 fix: Restaurar banner informativo
dcbcabb fix: Remover d-none do desconto
```

## Próximas Deploys (Guia Rápido)

```bash
# 1. Fazer alterações no tema local
# 2. Atualizar versão
echo "1.1.6" > ftp-deploy/VERSION

# 3. Fazer deploy
node ftp-deploy/deploy.js

# 4. Validar em produção (Ctrl+F5)
```

---

**Último Deploy:** 2026-03-21 01:22 (v1.1.5)
**Próximo Target:** Story 7.1 QA Final Validation
**Status:** ✅ READY FOR PRODUCTION
