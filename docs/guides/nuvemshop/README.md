# 📚 Guias Nuvemshop — Patagang

Documentação completa para desenvolvimento e deployment na plataforma Nuvemshop.

## Documentos

| Documento | Descrição | Para quem |
|-----------|-----------|-----------|
| **[deployment-workflow.md](./deployment-workflow.md)** | Guia completo de versionamento e deploy FTP automático | Developers |
| | Setup inicial, workflow diário, 6 fases do deploy, troubleshooting | Designers |

## Quick Links

### 🚀 Para Deployar

```bash
cd ftp-deploy
npm run deploy:dry "Descrição"      # Simular
npm run deploy "Descrição"            # Fazer deploy
```

→ Ver: **[deployment-workflow.md](./deployment-workflow.md)**

### 🔧 Para Setup

→ Ver: **[deployment-workflow.md § 1. Setup Inicial](./deployment-workflow.md#1-setup-inicial-uma-vez)**

### ❓ Dúvidas

→ Ver: **[deployment-workflow.md § 7. Troubleshooting](./deployment-workflow.md#7-troubleshooting)**

---

## Docs de Referência (Outros Diretórios)

- **FTP CLI:** [`ftp-deploy/README-DEPLOYMENT.md`](../../../ftp-deploy/README-DEPLOYMENT.md)
- **Constraints:** [`.claude/rules/nuvemshop-ftp-constraints.md`](../../../.claude/rules/nuvemshop-ftp-constraints.md)
- **AIOX Framework:** [`.aiox-core/constitution.md`](../../../.aiox-core/constitution.md)
- **Stories:** [`docs/stories/`](../../stories/)

---

**Status:** ✅ Production Ready
**Versão:** 2.0.0
