# Epic 8 — Execução em Produção Real (Sem Homologação Local)

**Status:** ✅ ACTIVE (Epic 8 Production Workflow) | ℹ️ See consolidated standard below
**Type:** Contextual Rule (L3 — Project Configuration)
**Auto-Load:** On Story 8.x activation
**Created:** 2026-03-21
**Authority:** Gabriel Cristofolini (CTO)
**Critical:** YES — Alters all Story Development Cycle phases

## 📌 Note: Consolidated FTP Production Standard

**This rule documents the Epic 8 production execution model (no local staging).**

For general FTP deployments going forward, see: `.claude/rules/patagang-ftp-production-standard.md`
This new rule consolidates the execution patterns documented here into a general standard.

**Relationship:**
- **This rule:** Epic 8-specific workflow (historical, active reference)
- **New rule:** General FTP standard (recommended for Stories 8.6+)
- **Use:** This rule while Epic 8 is active; migrate to general standard for future stories

---

## 🔴 CONSTRAINT CRÍTICO DO PROJETO

**NÃO EXISTE AMBIENTE DE HOMOLOGAÇÃO LOCAL**

A validação de TODAS as alterações de CSS/JS acontece **DIRETAMENTE EM PRODUÇÃO** via FTP da Nuvemshop.

Isso altera fundamentalmente o workflow padrão AIOX para esta Epic.

---

## 📋 Workflow Ajustado para Epic 8 (Todas as Stories 8.1-8.5)

### Fase 1: Draft & Validate (@sm + @po)
```
Padrão AIOX normal
- @sm: Draft story com AC e tasks
- @po: Validate draft (10-point checklist)
```

### Fase 2: Implement + Deploy Real (@dev + FTP)
**MUDANÇA CRÍTICA:** Sempre deploy FTP real, nunca --dry-run descartado

```
1. @dev implements code locally
2. @dev commits to feature branch
3. @dev executes: node deploy.js "Descrição" --force
   ⚠️  NOTA: Isto é DEPLOY REAL (não --dry-run)
   ⚠️  Arquivos são ENVIADOS PARA FTP
   ⚠️  Git tag v1.x.x é criado e pushed
4. @dev reports: "✅ Deployado v1.x.x — Gabriel, valida em https://patagang.com.br/"
5. @dev provides: Versão exata, what changed, expected resultado
```

### Fase 3: Validação em Produção (Gabriel)
**NOVO PASSO CRÍTICO:** Validação visual e funcional na loja REAL

```
Gabriel acessa loja em produção:
1. Abra https://patagang.com.br/
2. Console (F12): Procure "📦 PATAGANG v1.x.x"
3. Verifique visualmente:
   - [ ] Alterações CSS aparecem?
   - [ ] Layout correto em mobile/tablet/desktop?
   - [ ] Sem FOUC (flash) ou erros console?
   - [ ] Performance aceitável?

Decisão:
- ✅ "OK para prosseguir" → Prossegue para QA Gate
- ⚠️  "Precisa ajustes" → Volta para @dev com feedback
- ❌ "Quebrou algo" → Rollback via ftp-deploy/rollback-incremental.js
```

### Fase 4: QA Gate (@qa)
**BASEADO EM VALIDAÇÃO DE PRODUÇÃO**

```
@qa executa gate considerando:
- Já validado em produção por Gabriel
- Testa aceitação crítica (AC)
- Documenta em QA Results section
- Gate: PASS (if Gabriel approved) ou CONCERNS/FAIL (if Gabriel found issues)
```

### Fase 5: Merge & GitHub (@devops)
**APÓS Gabriel aprovação em produção**

```
@devops:
1. Push feature branch → GitHub
2. Create PR
3. Merge to main
4. Release notes com versão
```

---

## 🔄 Decisões de Rollback

**Se Gabriel encontra problema em produção:**

```
Option 1: Ajuste Rápido
- Gabriel: "Precisa aumentar margin-top para 50px"
- @dev: Ajusta código
- @dev: Deploy novo v1.x.x+1
- Gabriel: Valida novamente em prod
- Se OK: Continua

Option 2: Rollback Completo
- Gabriel: "Quebrou layout no mobile, rollback"
- @devops: node ftp-deploy/rollback-incremental.js --version v1.x.x-1
- Loja volta versão anterior em 30 segundos
- @dev: Investigar problema, novo deploy após fix
```

---

## 📊 Deployment Checklist (Novo Padrão)

### Antes de @dev fazer deploy:

```
☐ Código commitado na feature branch
☐ Git log mostra commits claros com mensagens
☐ CodeRabbit validado (se aplicável)
☐ Versão atual em package.json/VERSION.json conhecida
```

### Executando deploy:

```
☐ node ftp-deploy/deploy.js "Mensagem clara" --force
☐ Aguardar completion (não interromper)
☐ Verificar: "✅ SUCESSO — vX.X.X"
☐ Anotar versão exata para Gabriel
☐ Backup criado em backups/deployment-vX.X.X/
☐ Git tag vX.X.X criado e pushed
```

### Relatório para Gabriel:

```
✅ Deploy concluído: v1.5.9
📦 Versão para validar: v1.5.9
🔧 Alterações: Blog CSS - margin-top: 40px + flex-center
📍 Validar em: https://patagang.com.br/blog/
🎯 Esperado: Título com espaçamento, social buttons alinhados
💾 Backup: backups/deployment-1.5.9/
🔙 Rollback: node ftp-deploy/rollback-incremental.js --version v1.5.8

Aguardando validação de Gabriel...
```

---

## 🎯 Impacto em Each Story 8.x

### Story 8.1 — Design Tokens
- ✅ Workflow: Code → Deploy v1.2.x → Gabriel valida cores em prod
- ✅ Rollback ready: CSS colors voltam se problema

### Story 8.2 — Critical CSS Reduction (AGORA)
- ✅ Workflow: Blog CSS → Deploy v1.5.9 → Gabriel valida em /blog/
- ✅ Rollback ready: style-async.scss.tpl volta se FOUC

### Story 8.3 — !important Resolution
- ✅ Workflow: Remove !important → Deploy v1.6.x → Gabriel valida layout
- ✅ Rollback ready: Especificidade volta se regressão

### Story 8.4 — Template Cleanup
- ✅ Workflow: Snipplets removed → Deploy v1.7.x → Gabriel valida footers/forms
- ✅ Rollback ready: Snipplets em backup

### Story 8.5 — JavaScript Optimization
- ✅ Workflow: Consolidate JS → Deploy v1.8.x → Gabriel valida cart/checkout
- ✅ Rollback ready: JS anterior funcional

---

## ⚠️ Regras Críticas para Todos os Agentes

### @dev (Dex)
```
✅ DEVE fazer deploy real SEMPRE (não --dry-run + descartar)
✅ DEVE informar versão para Gabriel validar
✅ DEVE aguardar feedback de Gabriel antes de passar para QA
❌ NÃO apruebe QA gate sem Gabriel validar em produção primeiro
```

### @qa (Quinn)
```
✅ DEVE baseado em validação de produção de Gabriel
✅ DEVE verificar que Gabriel já validou visualmente
✅ PODE documentar AC coverage baseado em prod validation
❌ NÃO pode fazer QA gate sem produção ter sido validada
```

### @devops (Gage)
```
✅ DEVE ter rollback-incremental.js pronto
✅ DEVE responder rápido se Gabriel pedir rollback
✅ DEVE push/PR apenas APÓS Gabriel aprovar em produção
❌ NÃO pusheia antes de Gabriel validar
```

### Gabriel (CTO)
```
✅ VALIDA cada deploy em produção antes de prosseguir
✅ APROVA ou pede ajustes
✅ Pode pedir rollback se quebrou
✅ Essencial para qualidade - é o único environment real
```

---

## 📝 Validação Checklist para Gabriel

Template para usar ao validar cada deploy:

```markdown
## Validação v1.x.x

**Alterações esperadas:** [descrição]

**Validação Visual:**
- [ ] Alterações aparecem na loja?
- [ ] Layout correto desktop/tablet/mobile?
- [ ] Sem flashing ou reflow?
- [ ] Sem erros no console (F12)?
- [ ] Performance aceitável?

**Decisão:**
- [ ] ✅ OK para prosseguir (PASS)
- [ ] ⚠️  Precisa ajustes (CONCERNS + descrição)
- [ ] ❌ Rollback necessário (FAIL + rollback command)
```

---

## 🔄 Workflow Diagram (Epic 8)

```
Story 8.x Draft & Validate
           ↓
       @dev Code
           ↓
      @dev Commit
           ↓
   @dev Deploy FTP (v1.x.x)
           ↓
 Gabriel Validate in Prod
           ↓
    ✅ Approved?
    /              \
  YES              NO
   ↓               ↓
@qa Gate      @dev Adjust
   ↓               ↓
@devops PR    Redeploy v1.x.x+1
   ↓               ↓
  MERGE        Gabriel Re-Validate
   ↓               ↓
 DONE         (loop until OK)
```

---

## 💾 Deployment Versioning

**Padrão para Epic 8:**

```
v1.2.x — Story 8.1 (Design Tokens)
v1.3.x — Story 8.2 (Critical CSS Reduction)
v1.4.x — Story 8.3 (!important Resolution)
v1.5.x — Story 8.4 (Template Cleanup)
v1.6.x — Story 8.5 (JS Optimization)

Within each story:
- v1.2.0 — Initial deploy
- v1.2.1 — First revision (if Gabriel found issues)
- v1.2.2 — Second revision (if needed)
- ... up to v1.2.9
- Then next story starts at v1.3.0
```

**Incrementing:**
- Patch (v1.2.0 → v1.2.1): Bug fix or adjustment
- Minor (v1.2.9 → v1.3.0): Next story
- Major: Never during Epic 8 (breaking changes)

---

## 📢 Communication Template

When @dev deploys, format must be:

```
✅ Deploy completed: vX.X.X

📦 Version to validate: vX.X.X
🔧 Changes: [clear description]
📍 Validate at: https://patagang.com.br/[path]
🎯 Expected: [what should change]

Console check: F12 → Console → 📦 PATAGANG vX.X.X

⏳ Awaiting Gabriel validation...
```

---

## 🎓 Rationale

**Why this workflow?**

1. **No local env** → Prod IS the validation environment
2. **Safety** → Rollback available anytime
3. **Speed** → Gabriel validates immediately vs waiting for test env
4. **Transparency** → Real data, real users see changes
5. **Confidence** → Each deploy versioned, trackable, reversible

**Risks mitigated:**

- ❌ Lost changes → Git tags + backups
- ❌ Infinite loops → Rollback always available
- ❌ Deployment failures → FTP validation catches issues
- ❌ Performance regressions → Gabriel sees real performance

---

## ✅ Status: ACTIVE

This rule applies to **ALL Stories in Epic 8** starting immediately.

Applied to Story 8.2 ETAPA 2 as of v1.5.9 deployment.

---

**Created by:** Gabriel Cristofolini (CTO)
**Enforced by:** @aiox-master
**Acknowledged by:** @dev, @qa, @devops
**Last Updated:** 2026-03-21 17:55 UTC
