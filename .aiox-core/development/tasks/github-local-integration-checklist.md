---
task_id: github-local-integration-checklist
task_name: GitHub Local Integration Checklist
task_type: checklist
responsible: Dex (@dev)
when_to_use: Before delegating work to @devops for push/PR creation
elicit: false
---

# GitHub Local Integration Checklist

**Purpose:** Validate all local changes meet AIOX standards BEFORE pushing to GitHub.

**When to use:**
- After implementing feature (all AC complete)
- Before telling @devops to push
- After applying QA feedback (before new push)

**Time:** ~5 minutes

---

## Execution

### Step 1: Verify Branch Name ✓

```bash
git branch --show-current
```

**Must match:** `feature/story-{epic}-{story}` or `fix/bug-{id}`

**Examples:**
- ✓ `feature/story-1-1-1`
- ✓ `fix/bug-payment-validation`
- ✗ `my-feature` (wrong)
- ✗ `feature-1-1-1` (missing slash)

**Decision:** Go/No-Go
- [ ] Branch name correct → Continue
- [ ] Wrong branch name → Rename: `git branch -m feature/story-X-X-X` → Re-check

---

### Step 2: Verify Commits Format ✓

```bash
git log origin/main..HEAD --oneline
```

**Each commit must be:** `{type}({scope}): {subject} [Story X.X.X]`

**Valid types:** feat, fix, docs, style, refactor, test, chore, perf

**Examples:**
- ✓ `feat(pdp): add image carousel [Story 1.1.1]`
- ✓ `fix(checkout): resolve validation bug [Story 1.2.3]`
- ✓ `test(pdp): add carousel tests [Story 1.1.1]`
- ✗ `my changes` (no convention)
- ✗ `feat: implement feature` (no story ID)

**Decision:** Go/No-Go
- [ ] All commits follow convention → Continue
- [ ] Bad commit messages → `git rebase -i origin/main` (fix interactively) → Re-check
- [ ] Need help? See `.claude/CLAUDE.md` — Git & GitHub Integration section

---

### Step 3: Code Quality — Linting ✓

```bash
npm run lint
```

**Expected:** No errors, 0 warnings

**Decision:** Go/No-Go
- [ ] Lint passes (0 errors) → Continue
- [ ] Lint fails → Fix: `npm run lint -- --fix` → Re-run
- [ ] Can't auto-fix → Manual fixes → Re-check

---

### Step 4: Type Safety ✓

```bash
npm run typecheck
```

**Expected:** No TypeScript errors

**Decision:** Go/No-Go
- [ ] TypeScript OK → Continue
- [ ] Errors found → Fix type issues (add types, fix any) → Re-run

---

### Step 5: Unit Tests ✓

```bash
npm test
```

**Expected:** All tests pass, >0 tests ran

**Decision:** Go/No-Go
- [ ] Tests pass → Continue
- [ ] Tests fail → Debug & fix failing tests → Re-run
- [ ] Need new tests? Add them, then re-run

---

### Step 6: Code Review (CodeRabbit) ✓

```bash
coderabbit --prompt-only -t uncommitted
```

**Expected:** APPROVED or < 2 iterations needed

**CodeRabbit Verdict:**
- ✓ **APPROVED** → Continue to Step 7
- ⚠️ **CHANGES REQUESTED (iteration < 2)** → Fix → Commit → Re-run CodeRabbit
- ✗ **CHANGES REQUESTED (iteration 2+)** → STOP, escalate to @dev directly

**Decision:** Go/No-Go
- [ ] CodeRabbit APPROVED → Continue
- [ ] CodeRabbit feedback found → Make fixes:
  ```bash
  git add <fixed-files>
  git commit -m "fix: address coderabbit feedback [Story X.X.X]"
  coderabbit --prompt-only -t uncommitted  # Re-check
  ```
- [ ] Still failing after 2 fixes → Manual review needed → Stop checklist

---

### Step 7: Story File Update ✓

**Verify:** Story markdown file is updated with changes

```bash
# Check docs/stories/{epic}.{story}.story.md
```

**Must have:**
- [ ] File List section: All modified files listed
- [ ] Acceptance Criteria: All [x] completed
- [ ] Status: Ready for QA or InProgress (not Draft)
- [ ] Comments: Documented any non-obvious changes

**Example:**
```markdown
## File List
- [x] src/components/Carousel.tsx (new)
- [x] tests/Carousel.test.tsx (new)
- [x] docs/carousel-usage.md (new)

## Acceptance Criteria
- [x] AC 1: Carousel displays images
- [x] AC 2: Swipe support on mobile
- [x] AC 3: Keyboard navigation

## Status
InProgress → Ready for QA
```

**Decision:** Go/No-Go
- [ ] Story file updated correctly → Continue
- [ ] Missing updates → Update story file → Re-check

---

### Step 8: No Debug Code ✓

```bash
# Search for debug patterns
git diff origin/main..HEAD | grep -E "console\.(log|debug|warn)" | grep -v test
git diff origin/main..HEAD | grep -E "debugger"
git diff origin/main..HEAD | grep -E "TODO:|FIXME:" | grep -v test
```

**Decision:** Go/No-Go
- [ ] No debug code found → Continue
- [ ] Found debug code → Remove → Commit:
  ```bash
  git add <files>
  git commit -m "chore: remove debug code [Story X.X.X]"
  ```
- [ ] Re-run lint & CodeRabbit after changes

---

### Step 9: No Secrets ✓

```bash
# Check for common patterns
git diff origin/main..HEAD | grep -E "(password|secret|api_key|token)" -i
```

**Decision:** Go/No-Go
- [ ] No secrets found → Continue
- [ ] Secrets detected → Remove immediately:
  ```bash
  git reset HEAD <file>  # Unstage
  git checkout -- <file>  # Revert
  # OR edit .gitignore for .env files
  ```

---

### Step 10: Final Verification ✓

```bash
# One more time:
git log origin/main..HEAD --oneline
git diff origin/main..HEAD --stat
```

**Decision:** Ready?
- [ ] Yes → Proceed to Delegation
- [ ] No → Go back to failing step → Fix → Retry

---

## ✅ Delegation to @devops

**When all 10 checkboxes are complete:**

Send message to @devops:

```
Ready for push workflow.

Story: {story-id}
Branch: {branch-name}
Commits: {number of commits}

Validation Summary:
✓ Branch name correct: feature/story-X-X-X
✓ Commits follow convention
✓ Lint: PASS
✓ TypeCheck: PASS
✓ Tests: PASS (X tests)
✓ CodeRabbit: APPROVED
✓ Story file: Updated
✓ No debug code
✓ No secrets

Ready for `*push workflow`.
```

---

## ❌ If You Find Issues

### Common Fixes

| Issue | Command |
|-------|---------|
| Wrong branch name | `git branch -m feature/story-X-X-X` |
| Bad commit message | `git rebase -i origin/main` (interactive) |
| Lint errors | `npm run lint -- --fix` |
| Type errors | Edit files, add types, re-run |
| Test failures | Debug test file, re-run `npm test` |
| CodeRabbit feedback | Fix code, commit, re-check |
| Story file outdated | Edit .md file, add to git, commit |

### When to Ask for Help

- ❓ Not sure how to fix linting error → Ask @architect
- ❓ TypeScript too complex → Ask @architect
- ❓ Test keeps failing → Ask @qa
- ❓ Unsure about commit convention → Ask @sm
- ❓ Multiple issues overwhelming → Ask @dev directly

---

## 📋 Quick Checklist (Paste into your terminal)

```bash
# Copy & run this for fastest validation:

echo "=== GitHub Local Integration Checklist ===" && \
echo "1. Branch name:" && git branch --show-current && \
echo "" && \
echo "2. Commits:" && git log origin/main..HEAD --oneline && \
echo "" && \
echo "3. Lint:" && npm run lint && \
echo "" && \
echo "4. TypeCheck:" && npm run typecheck && \
echo "" && \
echo "5. Tests:" && npm test && \
echo "" && \
echo "6. CodeRabbit:" && coderabbit --prompt-only -t uncommitted && \
echo "" && \
echo "✅ All steps complete!"
```

---

## 📊 Validation Matrix

| Step | Pass Condition | Action if Fail |
|------|----------------|----------------|
| Branch Name | Matches pattern | Rename branch |
| Commits | Conventional format | Rebase & reword |
| Lint | 0 errors | Fix auto or manual |
| TypeCheck | 0 errors | Fix types |
| Tests | All pass | Debug & fix |
| CodeRabbit | Approved (<2 iter) | Fix & re-check |
| Story File | Updated | Update file |
| Debug Code | None found | Remove |
| Secrets | None found | Remove & .gitignore |
| Final Check | Everything OK | → Delegate |

---

## ✅ Success Criteria

Você sabe que está 100% pronto quando:

1. ✓ Branch name segue padrão
2. ✓ Todos commits têm conventional format + story ID
3. ✓ Lint: PASS
4. ✓ TypeCheck: PASS
5. ✓ Tests: PASS
6. ✓ CodeRabbit: APPROVED
7. ✓ Story file: Atualizado com File List + AC completas
8. ✓ Sem console.log, debugger, ou TODO
9. ✓ Sem secrets (.env, keys)
10. ✓ Pronto para @devops executar `*push workflow`

---

**Status:** ✅ AIOX 10/10 Compliant
**Last Updated:** 2026-03-20
**Maintained By:** Dex (@dev) guided by Orion
