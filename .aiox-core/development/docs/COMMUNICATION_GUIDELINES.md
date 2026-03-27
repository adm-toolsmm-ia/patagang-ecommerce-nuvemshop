# Communication Guidelines — Portuguese Brazilian Standard

**Type:** L2 Development Reference (NOT auto-loaded)
**Created:** 2026-03-28
**For:** Detailed communication patterns and examples

**Quick Reference:** `.claude/rules/communication-language-portuguese.md`

---

## Core Rule: PORTUGUÊS BRASILEIRO (MANDATORY)

**All communication with Gabriel Cristofolini is in PORTUGUESE.**

### What Must Be Portuguese
- ✅ Explanations of tasks and features
- ✅ Questions and requests for clarification
- ✅ Progress reports and status updates
- ✅ Error messages and warnings
- ✅ Documentation for end-users
- ✅ Comments in stories/tickets
- ✅ Commit messages (co-authored line)

### Exceptions (English OK in Background Only)
- ✅ Code: variables, function names, class names
- ✅ Internal technical comments
- ✅ JSON/YAML keys
- ✅ Git branch names
- ✅ HTML attributes
- ✅ Database schema names
- ❌ **User-facing output: NEVER English**

---

## Why Portuguese?

**Gabriel Cristofolini:**
- Location: Brazil 🇧🇷
- Preferred language: Portuguese Brazilian
- Context: Tech entrepreneur, project CTO
- **Requirement:** All communication must be accessible and clear in Portuguese

This ensures:
- Clarity (no language ambiguity)
- Accessibility (doesn't speak English fluently)
- Professional communication (respects user language preference)
- Context preservation (Portuguese terminology more precise than English direct-translations)

---

## Communication Patterns by Context

### Pattern 1: Progress Reports

**Context:** Reporting what you completed

**✅ CORRECT:**
```
✅ Fase 1 completa: 5 frameworks legados arquivados

Realizações:
- ✅ Movido 5 frameworks para .aiox-core/archived/
- ✅ Reorganizado 319 arquivos com zero-loss
- ✅ Criado índice de referência

Status: Pronto para Fase 2

Próximo passo: Consolidar documentação em docs/
```

**❌ INCORRECT:**
```
✅ Phase 1 complete: 5 legacy frameworks archived

Accomplishments:
- ✅ Moved 5 frameworks to .aiox-core/archived/
- ✅ Reorganized 319 files
- ✅ Created reference index

Status: Ready for Phase 2

Next step: Consolidate documentation
```

**Key Elements:**
- Status indicator: ✅/❌/⚠️
- Achievement list (bulleted)
- Clear "Próximo passo" (next step)
- No English words in sentences

---

### Pattern 2: Questions/Clarifications

**Context:** Need user decision before proceeding

**✅ CORRECT:**
```
🤔 Preciso de clarificação antes de continuar:

A story 1.1.1 menciona "botão help sidebar" com cor customizada.
As cores do design system estão em `docs/design-system/colors.md`

Qual cor exatamente você quer usar?

Opções:
1. Amarelo (#EAFE67) — primário, destaque natural
2. Cinza (#F0F0F0) — neutro, discreto
3. Laranja (#FF6600) — ação/alerta
4. Outra cor (especifique hex code)

Por favor confirme antes que eu implemente.
```

**❌ INCORRECT:**
```
I need clarification before continuing:

Story 1.1.1 mentions "help sidebar button" with custom color.
Design system colors are in `docs/design-system/colors.md`

Which color exactly do you want?

Options:
1. Yellow (#EAFE67) — primary, natural highlight
2. Gray (#F0F0F0) — neutral, discrete
3. Orange (#FF6600) — action/alert
4. Other color (specify hex code)

Please confirm before I implement.
```

**Key Elements:**
- Lead with question (clarify immediately)
- Provide context (reference docs/story)
- List numbered options
- Ask for explicit confirmation
- Use Portuguese connectors: "já que", "pois", "porém"

---

### Pattern 3: Error Messages

**Context:** Something went wrong, explain problem + solution

**✅ CORRECT:**
```
❌ Erro detectado na validação de constraints

Arquivo: theme-deploy-corrigido/layouts/checkout.tpl
Linha: 45
Problema: Estrutura do checkout foi modificada

Detalhes:
- Campo de pagamento removido (violação constraint #1)
- Nuvemshop espera todos os campos mantidos
- Estrutura de formulário não pode mudar

Solução recomendada:
1. Reverter arquivo: git checkout -- theme-deploy-corrigido/layouts/checkout.tpl
2. Reaplicar mudanças usando CSS apenas (cores, spacing)
3. Testar fluxo de checkout end-to-end

Próximo passo: Você quer que eu desfaça a mudança?
```

**❌ INCORRECT:**
```
❌ Constraint validation error

File: theme-deploy-corrigido/layouts/checkout.tpl
Line: 45
Problem: Checkout form structure was modified

Details:
- Payment field removed (constraint violation #1)
- Nuvemshop expects all fields maintained
- Form structure cannot change

Recommended solution:
1. Revert file: git checkout -- theme-deploy-corrigido/layouts/checkout.tpl
2. Reapply changes using CSS only (colors, spacing)
3. Test checkout flow end-to-end

Next step: Do you want me to undo the change?
```

**Key Elements:**
- Start with emoji indicator (❌❌)
- Explain what went wrong (specific file + line)
- Context (why it matters)
- Clear solution steps (numbered)
- Ask for confirmation before fixing

---

### Pattern 4: Validation Checklist

**Context:** Asking user to verify something

**✅ CORRECT:**
```
🔍 Validação da versão vX.X.X necessária:

Alterações esperadas:
- Marquee com animação deslizante (ad bar)
- Cores: #EAFE67 (amarelo Patagang)
- Breakpoints: mobile (25s), tablet (28s), desktop (30s)

Checklist visual:
- [ ] Mudanças aparecem no site?
- [ ] Layout correto em desktop/tablet/mobile?
- [ ] Nenhum flashing ou reflow?
- [ ] Console sem erros (F12)?
- [ ] Performance aceitável?

Após validar, por favor confirme:
- ✅ OK, prosseguir para GitHub push
- ⚠️ Encontrei problemas em [local] — detalhar
- ❌ Faliou — rollback necessário imediatamente
```

**❌ INCORRECT:**
```
🔍 vX.X.X validation required:

Expected changes:
- Marquee with sliding animation (ad bar)
- Colors: #EAFE67 (Patagang yellow)
- Breakpoints: mobile (25s), tablet (28s), desktop (30s)

Visual checklist:
- [ ] Changes appear on site?
- [ ] Correct layout on desktop/tablet/mobile?
- [ ] No flashing or reflow?
- [ ] Console error-free (F12)?
- [ ] Performance acceptable?

After validating, please confirm:
- ✅ OK, proceed to GitHub push
- ⚠️ Found problems in [location] — detail
- ❌ Failed — immediate rollback needed
```

**Key Elements:**
- Emoji status indicator
- Specific changes listed
- Clear checkbox items
- Options with emojis
- Portuguese outcome descriptions

---

### Pattern 5: Technical Decision Explanation

**Context:** Explaining architectural decision

**✅ CORRECT:**
```
📐 Decisão de arquitetura — CSS Cascade

Problema identificado: Mudança de cor não estava sendo aplicada no site.

Root cause: Regra CSS de maior especificidade estava sobrescrevendo.

Solução escolhida: Mapear ordem de cascade (style-critical → style-colors → inline).

Por quê:
1. Não reescrever stylesheet (risco alto)
2. Entender dependências primeiro (investigação necessária)
3. Aplicar mudança apenas quando safe (validação obrigatória)

Impacto:
- Tempo extra: +2 horas investigação
- Benefício: Zero risco de regressão CSS
- Aprendizado: Documentado em LESSONS-LEARNED.md

Aprovado? Prosseguir com esta abordagem?
```

**❌ INCORRECT:**
```
🏗️ Architectural Decision — CSS Cascade

Problem identified: Color change not being applied on site.

Root cause: CSS rule with higher specificity was overriding.

Solution chosen: Map cascade order (style-critical → style-colors → inline).

Why:
1. Don't rewrite stylesheet (high risk)
2. Understand dependencies first (investigation needed)
3. Apply change only when safe (mandatory validation)

Impact:
- Extra time: +2 hours investigation
- Benefit: Zero CSS regression risk
- Learning: Documented in LESSONS-LEARNED.md

Approved? Proceed with this approach?
```

**Key Elements:**
- Problem-first (explain what's wrong)
- Decision (what you chose)
- Justification (why this choice)
- Impact (time, quality, learning)
- Seek confirmation (yes/no question)
- Portuguese technical terms

---

## Portuguese Technical Terminology

### When You Use Technical Terms, Use Portuguese Equivalents

| English | Portuguese | Usage |
|---------|-----------|-------|
| Function | Função | "A função valida email" |
| Class | Classe | "Nova classe Button criada" |
| Repository | Repositório | "Arquivo no repositório" |
| Variable | Variável | "Variável de ambiente" |
| Commit | Commit (no change) | "Novo commit criado" OR "Novembro submissão" |
| Branch | Branch (no change) OR Ramo | "Feature branch criado" |
| Merge | Merge (no change) OR Fusão | "Fazer merge com main" |
| Pull Request | PR/Pull Request (no change) | "PR #123 aberto" |
| Feature | Funcionalidade/Recurso | "Nova funcionalidade adicionada" |
| Bug | Bug (no change) OR Erro | "Bug no checkout corrigido" |
| Release | Release (no change) OR Lançamento | "Release v1.5.170" |
| Performance | Desempenho/Performance | "Desempenho melhorado 20%" |
| Validation | Validação | "Validação de constraints" |
| Constraint | Constraint (no change) OR Restrição | "Constraint do Nuvemshop" |

**Rule:** Use Portuguese where there's a good equivalent; OK to use English technical jargon (like "commit", "branch") but always explain in Portuguese context.

---

## Validation Checklist (Before Sending Message)

Before sending ANY message to Gabriel, verify:

```
☐ Main message in Portuguese?
☐ Explanations in Portuguese?
☐ Questions in Portuguese?
☐ Warnings/errors in Portuguese?
☐ Code/variables OK in English (background)?
☐ Clear + accessible (no ambiguous terms)?
☐ Emojis used for visual clarity?
☐ Numbered options when choices needed?
☐ Action item clear (what to do next)?
```

**If ANY is ❌, rewrite in Portuguese before sending.**

---

## Common Mistakes & Corrections

| Mistake | Why Wrong | Correction |
|---------|-----------|-----------|
| "Phase 1 complete" | English in output | "Fase 1 completa" |
| "please confirm" | English question | "por favor confirme" |
| Mixed: "Fase 1 Phase 2" | Language mixing | "Fase 1 Fase 2" (stay consistent) |
| "I found a bug" | English explanation | "Encontrei um erro" |
| "Do you want X?" | English question | "Você quer X?" |
| Long paragraphs | Hard to scan | Use bullets + emojis |
| No next step | Unclear action | "Próximo passo: ..." |
| Complex English terms | Assumes fluency | Explain in Portuguese simply |

---

## Examples by Communication Type

### Status Update

```
✅ Resumo de progresso — Sprint 9.2

Completado:
- ✅ Gallery lightbox implementado (100%)
- ✅ Info card mobile otimizado (100%)
- ✅ Testes passando (9/9)
- ✅ CodeRabbit validado

Métricas:
- Linhas de código: 145 adicionadas, 23 removidas
- Commits: 3 (atomic)
- Time: 8 horas (conforme estimado)

Status: Ready for QA gate

Próximo: @qa *qa-gate [story]
```

### Blocker/Risk

```
⚠️ Aviso — Bloqueador identificado

Situação:
- CSS file style-critical.tpl agora 51 KB (excedeu limite 50 KB)
- Constraint violation detectada
- Deploy bloqueado até resolver

Impacto:
- Cannot deploy current version
- Requer remoção ~2 KB de CSS

Ação solicitada:
1. Identificar regras orfanadas/duplicadas
2. Remover conservadoramente (max 10-15 rules)
3. Validar em ambiente local
4. Redeploy após validação

Você quer que eu investigue quais rules remover?
```

### Success Confirmation

```
✅ Sucesso — vX.X.X validado em produção

Confirmação Gabriel:
- ✅ Visual checks (desktop, tablet, mobile) = OK
- ✅ Console sem erros
- ✅ Performance aceitável
- ✅ Todas funcionalidades working

Status: APPROVED

Próximas ações (@devops):
1. git push to main
2. gh pr create
3. PR review + merge
4. Tag release

Vamos lá! 🚀
```

---

## Reference

- **Quick Reference:** `.claude/rules/communication-language-portuguese.md`
- **Quickstart:** `.aiox-core/development/docs/AIOX_QUICKSTART.md`
- **Lessons Learned:** `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md`

---

**Version:** 2.0
**Type:** L2 Development Reference (on-demand loaded)
**Authority:** @architect
