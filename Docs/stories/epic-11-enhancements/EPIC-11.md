# EPIC 11 — Melhorias & Ajustes Pós-EPIC 10

**Status:** 🟡 EM ANDAMENTO (Story 11.1 concluída)
**Criado em:** 2026-03-27
**PM:** @pm (Morgan)
**Versão base:** v1.5.184 (estável, pós-rollback EPIC 10)
**Branch de trabalho:** `feat/epic-11-enhancements`
**Tipo:** Feature Enhancement — Novas alterações validadas por Gabriel

---

## 🎯 Objetivo da EPIC

Implementar novas alterações e melhorias identificadas por Gabriel Cristofolini, com foco em segurança, validação rigorosa e zero regressão.

**Aprendizados Aplicados:**
- ✅ Cascata CSS completamente mapeada antes de implementação
- ✅ Duplicação de CSS prevenida (copiar + remover origem)
- ✅ Rollback simplificado (git-first, sem análise de timestamps)
- ✅ Validação obrigatória em produção (Gabriel final validator)

---

## 📋 Contexto do Sistema Existente

**Stack:** Nuvemshop (Twig/Liquid templates), CSS inline + SCSS compilado, Vanilla JS
**Deploy:** FTP via `node ftp-deploy/deploy.js` — auto-incrementa versão + backup
**Cascade CSS (ordem):** `style-critical.tpl` → `style-colors.scss.tpl` → `style-async.scss.tpl` → override final `layout.tpl`
**Constraint crítica:** Inline styles têm maior especificidade que classes CSS

**Referências de Arquitetura:**
- `Docs/architecture/patagang-ai-operating-context.md` — auditoria obrigatória
- `Docs/architecture/patagang-css-cascade.md` — cascade detalhada
- `.claude/rules/nuvemshop-ftp-constraints.md` — 8/8 constraints de produção
- `.claude/rules/patagang-ftp-production-standard.md` — workflow de deploy
- **NOVO:** `Docs/stories/epic-10-validation-fixes/STORY-10.5-CLOSURE-REPORT.md` — Lições aprendidas

---

## 📂 Stories da EPIC (STATUS ATUAL)

| Story | Título | Executor | QA | Risco | Status |
|-------|--------|----------|-----|-------|--------|
| 11.1 | WhatsApp esquerdo: manter rotate + restaurar ícone | @dev | @qa | Médio | ✅ Done (Aprovada por Gabriel) |
| 11.2 | Galeria PDP 2x2 desktop + scroll isolado (sem regressão mobile) | @dev | @qa | Médio | 🟡 Aguardando validação Gabriel |
| 11.3 | [AGUARDANDO ALTERAÇÃO 3] | @dev | @qa | ? | ⬜ Draft |
| ... | [OUTRAS ALTERAÇÕES] | ... | ... | ... | ⬜ Draft |

---

## 🔄 Workflow por Story (Patagang FTP Standard + EPIC 10 Learnings)

Cada story segue obrigatoriamente:

```
1. @analyst: PRÉ-ANÁLISE de cascata CSS (se modificar CSS)
   - Mapear todos os seletores
   - Verificar media queries
   - Simular ordem de carregamento
   - Checklist de duplicação

2. @dev: Implementa + commit atômico
   - git add + git commit (com referência de story)
   - Validação: grep para duplicação de CSS
   - Local testing completo

3. @devops: Deploy FTP
   - node ftp-deploy/deploy.js "descrição"
   - Auto-incrementa versão
   - Validação FTP (HTTP 200 + arquivo size)

4. Gabriel: Validação em PRODUÇÃO
   - Checar: https://patagang.com.br
   - Console F12: "📦 PATAGANG vX.X.X"
   - Visual: Desktop + Tablet + Mobile
   - Performance: Sem FOUC, sem reflow, sem console errors
   - Decisão: ✅ APPROVED ou ❌ FAILED + Rollback

5. @devops: Push to GitHub (APENAS se ✅ APPROVED)
   - git push origin {branch}
   - gh pr create (se finalizar story)
```

---

## ✅ Checklist Nuvemshop 8/8 (todas as stories)

| # | Constraint | Verificação |
|---|-----------|------------|
| 1 | Checkout structure | ☐ Não toca em checkout |
| 2 | Footer attribution | ☐ Footer visível (Nuvemshop) |
| 3 | Contact form | ☐ Sem mudança estrutural |
| 4 | Registration form | ☐ Sem mudança estrutural |
| 5 | Newsletter form | ☐ Sem mudança estrutural |
| 6 | JavaScript Nuvemshop | ☐ Sem overrides de funções |
| 7 | CSS < 50 KB | ☐ Validar tamanho final |
| 8 | Auto-generated files | ☐ Não toca sitemap/robots |

---

## 🛡️ PRÉ-IMPLEMENTAÇÃO CHECKLIST (EPIC 10 Learnings)

Antes de qualquer @dev implementar:

### CSS Modifications (Obrigatório)

- [ ] **Cascata Mapeada**
  - [ ] Todos os seletores em estudo listados
  - [ ] Todas as media queries associadas identificadas
  - [ ] Ordem de carregamento simulada (critical → colors → async)

- [ ] **Duplicação Prevenida**
  - [ ] Grep para seletor em style-critical.tpl
  - [ ] Grep para seletor em style-async.scss.tpl
  - [ ] Confirmação: não duplicado
  - [ ] Se mover: remover de origem, validar

- [ ] **Tamanho Validado**
  - [ ] style-critical.tpl tamanho ANTES
  - [ ] style-critical.tpl tamanho DEPOIS
  - [ ] Diferença aceitável (< 10 KB para single story)

- [ ] **Cascata Testada Localmente**
  - [ ] Dev tools: desabilitar style-async
  - [ ] Verificar: layout correto com critical só
  - [ ] Dev tools: abilitar style-async
  - [ ] Verificar: sem mudança visual (cascata respeitada)

### Rollback Preparado

- [ ] Último commit conhece (git log -1)
- [ ] Rollback procedure definida (git reset --hard {hash})
- [ ] Teste de rollback local (não necessário, mas recomendado)

---

## ⚠️ Riscos e Mitigações (EPIC 10 Scars)

| Risco | Probabilidade | Impacto | Mitigação |
|-------|--------------|--------|-----------|
| Duplicação de CSS (novo) | Alta | Crítico | Checklist de grep antes de commit |
| Media queries conflitantes | Média | Crítico | Mapeamento de cascata obrigatório |
| FOUC não resolvido | Média | Médio | Validação Gabriel em produção obrigatória |
| Tamanho CSS ultrapassa 50 KB | Baixa | Médio | Monitorar incrementalmente (max +5 KB/story) |
| Rollback complexo | Baixa | Alto | Padrão git-first simplificado |

**Escalation:** Qualquer CRÍTICO → @architect review antes de @devops deploy

---

## 📊 Definition of Done (EPIC 11)

- [ ] Todas as stories com status DONE
- [ ] Gabriel validou CADA story em produção
- [ ] Zero regressão visual nas páginas não-alvo
- [ ] Nenhuma duplicação de CSS
- [ ] Cascata CSS documentada para referência futura
- [ ] Aprendizados de EPIC 10 aplicados em 100% dos cases
- [ ] Branch `feat/epic-11-enhancements` mergeado em `main`
- [ ] Versão final commitada e tagueada

---

## 📥 Próximos Passos

**Aguardando Gabriel:**

1. Envie as alterações desejadas para EPIC 11
2. @analyst analisará conforme padrão AIOX
3. @dev implementará com checklists de EPIC 10
4. Gabriel validará em produção
5. @devops fará deploy + push

---

## 📌 Rebaseline Story 11.1 (2026-03-27)

Atualização aprovada para corrigir divergência de requisito identificada em produção:

- O botão WhatsApp do lado esquerdo **deve manter** `transform: rotate(180deg)` por regra de legibilidade no posicionamento lateral.
- O problema real da story 11.1 é a ausência do **ícone visível do WhatsApp** na versão atual da loja.
- A documentação da 11.1 passa a seguir o fluxo **docs-first**: corrigir instruções, implementar, validar, deploy FTP, registrar evidências.

**Fonte de verdade operacional para deploy:** `ftp-deploy/README-DEPLOYMENT.md` + `ftp-deploy/deploy.js`.

**Execução registrada (11.1):**
- Branch: `feat/epic-11`
- Commit funcional/docs: `96cf417`
- Deploy FTP concluído: `v1.5.189`
- Commit de versão (script): `6a2f4c6`
- Backup: `backups/deployment-1.5.189/2026-03-27T05-06-49`
- Push remoto: autorizado após aprovação do Gabriel (em execução por @devops)

---

## 📌 Kickoff Story 11.2 (2026-03-27)

Story 11.2 iniciada em fluxo AIOX com agentes:

- @analyst: mapeamento de requisitos e riscos da galeria PDP (2x2 + scroll isolado).
- @dev: auditoria técnica de templates/CSS/JS da galeria para ajuste mínimo sem regressão no Swiper.
- @qa: checklist de validação por breakpoint para liberação do Gabriel.

Escopo confirmado da 11.2:
- Desktop (>=992px): grid 2x2 com 4 imagens visíveis, gap e proporção consistentes.
- Scroll isolado na área da galeria (sem vazar para a página durante rolagem da galeria).
- Tablet/mobile: manter Swiper atual sem regressão.

---

## 📌 Execução Story 11.2 (2026-03-27)

- Branch: `feat/epic-11`
- Commit funcional/docs: `46f9f2d`
- Deploy FTP concluído: `v1.5.190`
- Commit de versão (script): `74e852b`
- Backup: `backups/deployment-1.5.190/2026-03-27T05-20-57`
- Push remoto: pendente (gate da validação Gabriel)

---

## 🔗 Referências Críticas

**EPIC 10 Lessons:**
- `Docs/stories/epic-10-validation-fixes/STORY-10.5-CLOSURE-REPORT.md` — Lições aprendidas
- `Docs/stories/epic-10-validation-fixes/FOUC-INVESTIGATION-FINDINGS.md` — Root cause analysis

**Arquitetura Patagang:**
- `Docs/architecture/patagang-css-cascade.md`
- `.claude/rules/nuvemshop-ftp-constraints.md`
- `.claude/rules/patagang-ftp-production-standard.md`

---

**Responsável AIOX:** @pm (Morgan)
**Handoff para stories:** @sm (River) — criar stories individuais
**Análise de Alterações:** @analyst (Atlas) — mapear cascata CSS
**Implementação:** @dev (Dex) — branch `feat/epic-11-enhancements`
**QA:** @qa (Quinn) — gate após cada implementação
**Deploy + Push:** @devops (Gage) — exclusivo FTP deploy e git push
**Validação Final:** Gabriel Cristofolini (CTO) — produção

---

**Status:** 🟡 EM ANDAMENTO — Story 11.1 concluída e aprovada
**Versão Base:** v1.5.184
**Data Criação:** 2026-03-27

