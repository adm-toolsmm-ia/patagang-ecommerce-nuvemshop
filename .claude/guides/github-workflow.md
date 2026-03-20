# GitHub Workflow Guide — AIOX Integration

**Objetivo:** Documentar o fluxo completo de integração entre trabalho local (@dev) e repositório remoto (@devops), garantindo padrão 100% funcional AIOX.

---

## 📋 Quick Reference

| Phase | Agent | Ações | Referência |
|-------|-------|-------|-----------|
| **Local Development** | @dev | Branch, commits, validação local | Story-Driven Development |
| **Pre-Push Check** | @dev | CodeRabbit, lint, tests | `github-local-integration-checklist.md` |
| **Push & PR** | @devops | `git push`, `gh pr create` | `agent-authority.md` |
| **Code Review** | @qa | CodeRabbit review automático | `coderabbit-integration.md` |
| **Merge** | @devops | `gh pr merge` | `agent-authority.md` |

---

## 🔄 Story Development Cycle (SDC) — GitHub Integration

### Phase 1: Create Story (@sm)
```
→ Story criada em docs/stories/{epic}.{story}.story.md
→ Acceptance Criteria definida
→ Branch strategy documentada
```

### Phase 2: Validate Story (@po)
```
→ 10-point checklist validada
→ Pronto para desenvolvimento
```

### Phase 3: Implement (@dev) ← **VOCÊ ESTÁ AQUI**

#### Step 3.1: Create Feature Branch
```bash
# Do story file, extrair informações:
# - Story ID (ex: 1.1.1)
# - Branch name padrão AIOX: feature/story-{epic}-{story}

git checkout -b feature/story-1-1-1
```

**Convenção branch:** `feature/story-{epic}-{story}` ou `fix/bug-{id}`

#### Step 3.2: Implement Changes
```bash
# Trabalho normal — commits conforme acceptance criteria
git add <files>
git commit -m "feat: implement feature X [Story 1.1.1]"
```

**Commit convention:**
- Prefix: `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`
- Message: Descrição clara do que foi feito
- Reference: `[Story X.Y.Z]` no final
- **Exemplo:** `feat: add PDP image carousel [Story 1.1.1]`

#### Step 3.3: Pre-Push Validation ← **CRÍTICO**

**Execute `github-local-integration-checklist.md` ANTES de qualquer push:**

```bash
# 1. Lint check
npm run lint

# 2. Type check
npm run typecheck

# 3. Tests
npm test

# 4. CodeRabbit self-healing (max 2 iterations)
coderabbit --prompt-only -t uncommitted

# 5. Verify branch name
git branch --show-current

# 6. Verify commits
git log origin/main..HEAD --oneline
```

**Se ALGUM falhar → FIX LOCAL → Não pushear ainda**

#### Step 3.4: Delegate to @devops
```
Mensagem para @devops:
"Story 1.1.1 ready for push. Branch: feature/story-1-1-1.
All local checks passed (lint, typecheck, tests). Ready for *push workflow."
```

---

### Phase 4: Push & PR (@devops) — EXCLUSIVE

**VOCÊ NÃO FAZ ISSO. Chama @devops:**

```bash
# @devops executa:
git push -u origin feature/story-1-1-1
gh pr create --title "feat: implement feature X [Story 1.1.1]" \
  --body "## Summary

Implementation of acceptance criteria from Story 1.1.1:
- [x] AC 1
- [x] AC 2
- [x] AC 3

## Changes
- File 1: description
- File 2: description

## Test Plan
- [x] Unit tests passing
- [x] Lint passing
- [x] TypeScript check passing"
```

**@devops também faz:**
- Verifica pre-push quality gate
- Cria PR com template correto
- Aguarda CodeRabbit automático

---

### Phase 5: QA Loop (@qa) — Iterativo

```
@qa *qa-loop {storyId}
→ CodeRabbit review automático
→ Verdict: APPROVE / REJECT / BLOCKED
→ Se REJECT: retorna para @dev com feedback específico
→ @dev *apply-qa-fixes → novo push via @devops
→ Max 5 iterações
```

---

### Phase 6: Merge (@devops) — EXCLUSIVE

```bash
# @devops faz merge quando QA APPROVES:
gh pr merge --squash  # ou --rebase, conforme política
```

---

## 🎯 Branch Strategy

### Nomenclatura Padrão AIOX

| Tipo | Padrão | Exemplo |
|------|--------|---------|
| Feature (Story) | `feature/story-{epic}-{story}` | `feature/story-1-1-1` |
| Bug Fix | `fix/bug-{id}` | `fix/bug-123` |
| Hotfix | `hotfix/critical-{description}` | `hotfix/critical-payment-issue` |
| Refactor | `refactor/{area}` | `refactor/pdp-styling` |
| Docs | `docs/{topic}` | `docs/github-workflow` |

**Regra:** Always branch from `main` (ou `develop` se existir).

---

## 🔐 Commit Conventions (Conventional Commits)

### Format
```
{type}({scope}): {subject} [{story-id}]

{body}

{footer}
```

### Types
- **feat:** Nova funcionalidade
- **fix:** Bug fix
- **docs:** Documentação
- **style:** Formatação (não altera lógica)
- **refactor:** Refatoração (não é feature nem fix)
- **test:** Adiciona/modifica testes
- **chore:** Mudanças em build, deps, config
- **perf:** Otimização de performance

### Examples

**Feature:**
```
feat(pdp): add image carousel component [Story 1.1.1]

Implemented image carousel with swipe support for mobile.
Uses shadcn/ui Image component for consistency.

Closes #123
```

**Bug Fix:**
```
fix(checkout): resolve payment form validation error [Story 1.2.3]

Payment form was not displaying error messages correctly.
Fixed by updating error state handling in PaymentForm.

Closes #456
```

**Docs:**
```
docs(github): add github workflow guide [Internal]

Consolidated GitHub integration documentation for AIOX compliance.
```

---

## ⚠️ Before You Push — Mandatory Checklist

**NÃO skip qualquer item:**

- [ ] Branch name segue padrão: `feature/story-X-X-X`
- [ ] Todos os commits têm conventional format: `feat(...): ... [Story X.X.X]`
- [ ] `npm run lint` — PASS
- [ ] `npm run typecheck` — PASS
- [ ] `npm test` — PASS
- [ ] `coderabbit --prompt-only -t uncommitted` — APPROVED
- [ ] Story file atualizado (File List seção)
- [ ] Acceptance criteria completa (todos checkboxes)
- [ ] Sem console.log() ou debug code
- [ ] Sem secrets (.env, credentials) em commits
- [ ] Pronto para entregar ao @devops

---

## 🚀 Typical Workflow (Day-to-Day)

### Morning: Start Work on Story 1.1.1
```bash
git checkout main
git pull origin main
git checkout -b feature/story-1-1-1
```

### During Day: Implement & Commit
```bash
git add src/components/Carousel.tsx
git commit -m "feat(pdp): implement carousel component [Story 1.1.1]"

git add tests/Carousel.test.tsx
git commit -m "test(pdp): add carousel unit tests [Story 1.1.1]"
```

### Before End of Day: Pre-Push Check
```bash
npm run lint    # ✓
npm run typecheck  # ✓
npm test        # ✓
coderabbit --prompt-only -t uncommitted  # ✓ APPROVED
```

### Handoff: Tell @devops
```
"Story 1.1.1 complete and validated locally.
Branch: feature/story-1-1-1
Ready for *push workflow."
```

### Next Day: QA Feedback
```
@qa feedback: "Add loading state to carousel"
→ @dev fixes locally
→ New commit: `feat(pdp): add carousel loading state [Story 1.1.1]`
→ Pre-push check again
→ Tell @devops about new changes
→ @devops does new push
```

---

## 📞 Troubleshooting

### "I pushed directly without @devops!"
```bash
# If already on GitHub, create PR manually:
gh pr create --title "..." --body "..."

# Then tell @devops to take over merging
```

### "My branch diverged from main"
```bash
git fetch origin main
git rebase origin/main feature/story-1-1-1
# OR
git merge origin/main
# (depends on your workflow preference)
```

### "CodeRabbit failed — can't push"
```bash
# Review the feedback and fix:
git add <fixed-files>
git commit -m "fix: address coderabbit feedback [Story X.X.X]"
npm run lint && npm run typecheck && npm test
coderabbit --prompt-only -t uncommitted  # Re-check
```

### "Merge conflict"
```bash
# Resolve conflicts, then:
git add <resolved-files>
git commit -m "chore: resolve merge conflicts"
# Let @devops handle final push
```

---

## 🔗 References

| Documento | Propósito |
|-----------|-----------|
| `.claude/rules/agent-authority.md` | Responsabilidades @devops (exclusive) |
| `.claude/rules/coderabbit-integration.md` | CodeRabbit workflow |
| `.aiox-core/development/tasks/github-local-integration-checklist.md` | Pre-push validation task |
| `CLAUDE.md` — Git & GitHub Integration section | Commit conventions detalhadas |
| `.claude/rules/tool-examples.md` | GitHub CLI examples |

---

## ✅ Success Criteria

Você saberá que está 100% AIOX quando:

1. ✓ Branches seguem padrão: `feature/story-X-X-X`
2. ✓ Commits têm conventional format + story ID
3. ✓ Pre-push checklist passa 100%
4. ✓ @devops faz todos os pushes (você nunca executa `git push`)
5. ✓ `gh pr create/merge` APENAS via @devops
6. ✓ QA loop funciona iterativamente (1-5 tentativas)
7. ✓ Todas as PRs têm código review automático (CodeRabbit)
8. ✓ Zero merges sem @devops

---

**Status:** ✅ AIOX 10/10 Compliant
**Last Updated:** 2026-03-20
**Maintained By:** Orion (aiox-master)
