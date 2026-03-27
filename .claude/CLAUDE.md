# Synkra AIOX Development Rules for Claude Code

You are working with Synkra AIOX, an AI-Orchestrated System for Full Stack Development.

---

## 🇧🇷 Português Brasileiro (Comunicação)

**REGRA CRÍTICA:** Toda comunicação com Gabriel Cristofolini é em português.
- ✅ Explicações, questões, relatórios, erros = PT-BR
- ✅ Código, variáveis, funções = Inglês (background)
- ❌ Mensagens visíveis = NUNCA em inglês

**Referência completa:** `.claude/rules/communication-language-portuguese.md`

---

## Constitution

O AIOX possui **Constitution formal** com princípios inegociáveis:

| Artigo | Princípio | Severidade |
|--------|-----------|------------|
| I | CLI First | NON-NEGOTIABLE |
| II | Agent Authority | NON-NEGOTIABLE |
| III | Story-Driven Development | MUST |
| IV | No Invention | MUST |
| V | Quality First | MUST |
| VI | Absolute Imports | SHOULD |

**Documento completo:** `.aiox-core/constitution.md`

---

## Core Framework Architecture

### Agent System (10 Specialized Agents)

Use `@agent-name` syntax to activate. Each has exclusive authority:

| Agent | Role | Exclusive |
|-------|------|-----------|
| @dev (Dex) | Implementation | Code changes |
| @qa (Quinn) | Quality | Testing, gates |
| @architect (Aria) | Design | Technical decisions |
| @pm (Morgan) | Epic orchestration | Epic management |
| @po (Pax) | Story validation | Story validation |
| @sm (River) | Story creation | Story drafting |
| @analyst (Alex) | Research | Analysis |
| @data-engineer (Dara) | Database | Schema design |
| @ux-design-expert (Uma) | UX/UI | Design system |
| @devops (Gage) | Git/CI/CD | **EXCLUSIVE git push** |

**Full authority matrix:** `.claude/rules/agent-authority.md`

---

## Framework Structure (L1-L4)

AIOX uses 4-layer organizational model:

```
L1: .aiox-core/core/              (Framework core — NEVER modify)
L2: .aiox-core/development/       (Templates, tasks, workflows — extend-only)
L3: .aiox-core/data/ + .claude/   (Project config, rules — mutable)
L4: docs/, src/, tests/           (Project runtime — ALWAYS modify)
```

**Standards:** `.claude/rules/file-structure-standards.md`

---

## Rules System (Auto-Load Contextual Rules)

Rules in `.claude/rules/` auto-load based on context. **Tier 1** (always loaded):

| Rule | Description |
|------|-------------|
| agent-authority.md | Agent delegation matrix |
| communication-language-portuguese.md | Portuguese language standard |
| file-structure-standards.md | AIOX L1-L4 file organization |
| agent-handoff.md | Agent switch context compaction |
| workflow-execution.md | 4 primary workflows (SDC, QA, Spec, Brownfield) |

**Tier 2** (contextual — loads on condition):

| Rule | Trigger |
|------|---------|
| nuvemshop-ftp-constraints.md | Edit `theme-deploy-corrigido/**/*.{tpl,scss,js}` |
| patagang-ftp-production-standard.md | Deploy to Nuvemshop FTP |
| css-refactoring-safety-pattern.md | CSS refactoring (10-15 rule max) |

---

## Memory Architecture (L2-L3)

Two-layer memory system:

**L2 Agent Memory:** `.aiox-core/development/agents/{agent}/MEMORY.md`
- Patterns, procedures, exclusive authorities per agent
- ~500 tokens overhead per agent

**L3 Project State:** `.aiox-core/data/`
- `patagang-project-state.yaml` — Active stories, epics, QA state
- `patagang-learned-patterns.yaml` — Feedback patterns, decisions

---

## Code Intelligence

Optional code analysis enrichment:

| Status | Behavior |
|--------|----------|
| **Configured** | Full enrichment available |
| **Fallback** | Graceful degradation (no enrichment) |
| **Disabled** | Silently ignored |

Provider: `.aiox-core/core/code-intel/`

---

## Graph Dashboard

Visualize dependencies and stats:

```bash
aiox graph --deps                    # Dependency tree
aiox graph --deps --format=html      # Interactive HTML
aiox graph --stats                   # Entity stats
```

---

## Quick Start (Development)

### Start a Story
```bash
@sm *create-next-story              # Create story from epic
@po *validate-next-story            # Validate (10-point)
@dev *develop-story                 # Implement
@qa *qa-gate                        # Quality gate (7 checks)
```

### Deploy (Patagang)
```bash
git add + git commit                # @dev commits
node ftp-deploy/deploy.js           # @devops deploys
# Gabriel validates on patagang.com.br
git push + gh pr create             # @devops after ✅
```

### Reference Documentation

- **Methodology:** `.aiox-core/development/docs/AIOX_QUICKSTART.md`
- **File Structure:** `.aiox-core/development/docs/FILE_STRUCTURE_EXTENDED_GUIDE.md`
- **Nuvemshop Deployment:** `.aiox-core/development/docs/NUVEMSHOP_FTP_REFERENCE.md`
- **Safe Deployment:** `.aiox-core/development/docs/SAFE_DEPLOYMENT_STANDARD.md`
- **Lessons Learned:** `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md`

---

## Environment Setup

**Required:** Node.js 18+, GitHub CLI, Git

**Config Files:**
- `.aiox/config.yaml` — Framework configuration
- `.env` — Environment variables
- `aiox.config.js` — Project settings

**Debugging:**
```bash
export AIOX_DEBUG=true              # Enable debug mode
tail -f .aiox/logs/agent.log        # View agent logs
```

---

## Workflow Execution

### 4 Primary Workflows

**Story Development Cycle (SDC)** — Primary workflow for all stories
**QA Loop** — Iterative review-fix cycle (max 5 iterations)
**Spec Pipeline** — Pre-implementation specification (6 phases)
**Brownfield Discovery** — Legacy codebase assessment (10 phases)

**Full details:** `.claude/rules/workflow-execution.md`

---

## Best Practices (Quick Reference)

### When implementing features:
- Check existing patterns first (reuse > invent)
- Follow naming conventions
- Write self-documenting code
- Include comprehensive error handling
- Add unit tests for all new functionality

### When working with agents:
- Respect agent boundaries (use @agent for task)
- Follow agent communication patterns
- Maintain agent context during handoffs

### When handling errors:
- Provide helpful error messages (include context)
- Suggest recovery steps
- Document root cause for learning

**Full methodology:** `.aiox-core/development/docs/AIOX_QUICKSTART.md`

---

## Git & GitHub Integration

**GitHub CLI Usage:**
- `gh auth status` — Verify authentication
- `gh pr create --title 'feat: ...' --body '...'` — Create PR (via @devops)
- `gh issue list --state open` — List issues

**Commit Conventions:**
- Format: `type: description [Story X.Y.Z]`
- Examples: `feat: implement sidebar`, `fix: CSS cascade override`
- **IMPORTANT:** Only @devops pushes to remote (`git push` is exclusive)

**Full guide:** `.aiox-core/development/docs/AIOX_QUICKSTART.md` § Git Integration

---

## File Creation Protocol

**ALWAYS consult:** `.claude/rules/file-structure-standards.md`

**Quick Decision Tree:**
1. Code file? → `src/`, `tests/`
2. Framework template? → `.aiox-core/development/`
3. Configuration? → `.aiox-core/data/` or `.claude/rules/`
4. Project documentation? → `docs/[guides|reports|architecture|reviews]`

**Example:**
- Story → `docs/stories/`
- Guide → `docs/guides/[domain]/`
- Report → `docs/reports/[domain]/`
- Checklist → `.aiox-core/development/checklists/`

---

## Nuvemshop FTP Deployment

**CRITICAL:** Before any FTP deployment, verify **8/8 Nuvemshop constraints**:

1. ❌ Checkout structure (forms NOT modified)
2. ❌ Footer attribution (MUST be visible)
3. ❌ Contact/Registration/Newsletter (NO structural changes)
4. ❌ JavaScript (NO Nuvemshop function overrides)
5. ✅ CSS size (< 50 KB critical path)
6. ✅ Character encoding (use Perl, NOT sed deletion)
7. ✅ Batching (max 10-15 rules per deployment)
8. ✅ Validation (HTTP 200 + Gabriel visual check)

**Full details:** `.claude/rules/nuvemshop-ftp-constraints.md` + `.aiox-core/development/docs/NUVEMSHOP_FTP_REFERENCE.md`

---

## Common Commands

### AIOX Master
- `*help` — Show available commands
- `*kb` — Toggle KB mode
- `*status` — Current context
- `*guide` — Comprehensive usage guide

### Task Execution
- `*task {name}` — Run specific task
- `*workflow {name}` — Start workflow
- `*plan` — Create/manage plans

### Validation
- `*validate-workflow {name}` — Validate workflow YAML
- `*validate-agents` — Validate all agent definitions
- `*ids check {intent}` — Pre-check registry (IDS system)

### Documentation
- `*create-doc {template}` — Create document
- `*index-docs` — Index documentation
- `*document-project` — Generate project docs

---

## Troubleshooting

| Issue | Check |
|-------|-------|
| Agent not responding | `@agent-name *help` to activate |
| File in wrong folder | `.claude/rules/file-structure-standards.md` |
| Deployment failed | `.aiox-core/development/docs/SAFE_DEPLOYMENT_STANDARD.md` |
| CSS not applying | `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md` § Lesson 1 |
| Constraint violation | `nuvemshop-ftp-constraints.md` + escalate to @architect |

---

**Version:** 2.0 (Optimized 2026-03-28)
**Maintained by:** @architect
**Status:** ✅ ACTIVE
**Framework:** Synkra AIOX v3.0

*Reference, don't memorize. Link and learn.*
