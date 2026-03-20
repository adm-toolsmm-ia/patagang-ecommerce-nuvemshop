# Legacy Framework Insights for AIOX Enrichment

**Analysis Date:** 2026-03-20
**Analyst:** @analyst (Alex)
**Source:** `.aiox-core/archived/legacy-frameworks/.agent/`
**Status:** Complete — Ready for AIOX integration recommendations

---

## Executive Summary

The legacy AI framework (`.agent/`) contains a **mature, production-tested agent system** with 16+ specialized agent personas, detailed workflow definitions, and sophisticated quality gates. Analysis reveals **8 major pattern families** that significantly enhance AIOX's current agent system.

### Key Findings

| Category | High Value | Medium Value | Archive |
|----------|-----------|--------------|---------|
| **Agent Personas** | 16 agents with deep specialization | Orchestrator multi-agent model | Legacy-only agents |
| **Quality Gates** | 7-10 phase QA review cycles | CodeRabbit self-healing loops | Ad-hoc testing patterns |
| **Nuvemshop Patterns** | FTP constraint validation (8 rules) | CSS cascade management | Deprecated build systems |
| **Workflow Architecture** | Story Development Cycle (SDC) | Spec Pipeline phases | Old deployment scripts |
| **Handoff Protocol** | Context compaction strategy | Agent memory lifecycle | Session serialization |
| **Testing Pyramid** | AAA test patterns, TDD workflow | Coverage strategies (80%+ targets) | Framework-specific helpers |
| **Product Management** | Requirements elicitation, MVP definition | Story points/complexity scoring | Roadmap templates |
| **DevOps Frameworks** | 5-phase deployment checklist, rollback strategies | Monitoring principles | Legacy CI/CD (Jenkins) |

---

## 🟢 HIGH VALUE PATTERNS (Migrate to AIOX)

### Pattern 1: Multi-Specialized Agent Ecosystem

**Source:** `.agent/agents/` (16 agents)
**Current Agents Analyzed:**
- orchestrator.md (coordination)
- product-owner.md (strategy)
- qa-automation-engineer.md (E2E testing)
- devops-engineer.md (deployment)
- test-engineer.md (test architecture)
- project-planner.md (task breakdown)
- frontend-specialist.md (React/Next.js)
- backend-specialist.md (API/server)

**Relevance to AIOX:** 9/10 — Direct applicability

**Pattern Details:**
- Each agent has **strict domain boundaries** with explicit "CAN/CANNOT" matrices
- Agents include **persona profiles** (archetype, tone, vocabulary, signature)
- **Deep philosophy** sections guide decision-making within each domain
- File ownership model prevents cross-domain violations
- Each agent has **clear triggering conditions** for invocation

**AIOX Enhancement Opportunity:**
```yaml
Recommendation: Enrich current AIOX agents with legacy persona profiles

Current AIOX Agents:
  @dev (Dex)           # Has persona, needs deeper philosophy
  @qa (Quinn)          # Has persona, needs domain boundary matrix
  @architect (Aria)    # Has persona, needs decision framework
  @pm (Morgan)         # Has persona, needs requirements elicitation guide
  @po (Pax)           # Minimal definition
  @sm (River)         # Minimal definition
  @data-engineer (Dara) # New in AIOX, needs expansion

Legacy Assets to Port:
  1. Domain boundary enforcement matrices (from orchestrator.md)
  2. Persona_profile YAML structure (tone, vocabulary, archetype)
  3. Philosophy & mindset sections for each agent
  4. Triggering keyword lists for invocation
  5. Agent collaboration patterns (who asks whom)

Integration Point: agents/*/MEMORY.md files should include:
  - Core Philosophy (WHY the agent thinks this way)
  - Domain Boundaries (CAN/CANNOT tables)
  - Collaboration Matrix (which agents I work with)
```

**Estimated AIOX Improvement:** +2-3 levels of agent sophistication

---

### Pattern 2: Story Development Cycle (SDC) with Quality Gates

**Source:** `.agent/workflows/` — particularly `dev.md`, `qa.md`
**Related Files:** `qa-automation-engineer.md`, `test-engineer.md`

**Relevance to AIOX:** 10/10 — Directly implements story-driven development

**Pattern Details:**
- **4-phase workflow:** Create → Validate → Implement → QA Gate
- **QA has 7-10 quality checkpoints** covering:
  - CodeRabbit automated review (self-healing max 3 iterations)
  - Acceptance criteria traceability
  - Test coverage validation (80%+ on critical paths)
  - Non-functional requirements assessment
  - Security vulnerability scanning
  - Edge case coverage
  - Performance benchmarks

**Current AIOX Implementation:**
- Story files in `docs/stories/` ✅
- Checkbox tracking for progress ✅
- File List updates required ✅
- QA Results section support ✅

**Enhancement Opportunity:**
```yaml
AIOX Story Lifecycle Gaps (vs. Legacy):

Current: Story → Implementation → Merge
Legacy: Story → Validation → Implementation → 7-Phase QA → Merge

Missing Pieces to Add:
  1. Story Validation Gate (@po role enforcement)
     - 10-point checklist before @dev starts
     - Prevents "built but wrong" scenarios

  2. QA Gate Authority (@qa role exclusive)
     - Can BLOCK story completion
     - Provides PASS/CONCERNS/FAIL/WAIVED verdicts
     - Owns story "QA Results" section exclusively

  3. CodeRabbit Integration (Pre-QA automated review)
     - Run before human QA review
     - Self-healing max 3 iterations for CRITICAL/HIGH
     - Document MEDIUM as tech debt

  4. Requirements Traceability
     - Map each test to AC via Given-When-Then format
     - Risk assessment matrix (probability × impact)
     - Evidence-based validation (no assumptions)

  5. Test Design Phase
     - Dedicated task: *qa-test-design
     - Pyramid (unit → integration → E2E)
     - Coverage targets: 100% critical, 80%+ business logic

Implementation in AIOX:
  → Extend story-lifecycle.md with validation gates
  → Add qa-gate.md task definition
  → Create qa-test-design.md template
  → Integrate CodeRabbit automation via coderabbit-integration.md
```

**AIOX Story Template Enrichment:**
```markdown
# Story [ID]: [Title]

## Acceptance Criteria
- AC1: ...
- AC2: ...

## Story Validation (@po gate) ← ADD THIS PHASE
- [ ] Requirements clear and unambiguous
- [ ] Acceptance criteria testable (Given-When-Then)
- [ ] Technical feasibility confirmed
- [ ] Dependencies identified
- [ ] Risk assessment completed
**@po Decision:** GO / NO-GO

## Implementation (@dev)
- [ ] Task 1
- [ ] Task 2

## QA Results (@qa gate) ← ALREADY EXISTS, expand authority
**CodeRabbit Review:** (Auto-run, report here)
**Test Coverage:** (Must include evidence)
**Gate Decision:** PASS / CONCERNS / FAIL / WAIVED
```

---

### Pattern 3: Nuvemshop FTP Constraints (8-Rule Framework)

**Source:** `.cursor/rules/padroes-css-e-tema-nuvemshop.mdc`, `.cursor/rules/deploy-apos-alteracoes-tema.mdc`
**Related Legacy Content:** Theme deployment practices

**Relevance to AIOX:** 10/10 — Already partially captured in AIOX

**Current AIOX Implementation:**
- `nuvemshop-ftp-constraints.md` exists ✅
- 8 constraint rules documented ✅
- Checkout, footer, form protections in place ✅
- CSS size limits enforced ✅

**Legacy Insights for Enhancement:**
```yaml
Legacy Patterns Not Yet in AIOX:

1. CSS Cascade Management
   Legacy Rule: Validation with DevTools (Styles tab)
   Principle: "Don't iterate code — look at what actually wins"
   Gap in AIOX: Need explicit validation checklist

   Recommendation:
     - Add DevTools validation checklist to NUVEMSHOP_FTP_STANDARDS.md
     - Create screenshot requirement for CSS changes
     - Document cascade override strategy
     - Include "if CSS change doesn't show, check:" flowchart

2. Theme Deployment Automation
   Legacy Rule: Auto-deploy after theme changes (no user confirmation)
   Command: cd ftp-deploy && node deploy-optimized.js
   Gap in AIOX: Manual deployment step

   Recommendation:
     - Auto-trigger FTP deploy on theme file commits
     - Create deployment checklist in .aiox-core/development/checklists/
     - Include pre-deploy validation steps
     - Document rollback procedure (restore from FTP)

3. CSS Consolidation Pattern
   Legacy Rule: "Prefer one source of truth + explicit override"
   Gap in AIOX: No consolidation guidance

   Recommendation:
     - Add consolidation guide to docs/guides/nuvemshop/
     - Show examples of "scattered" vs "consolidated" patterns
     - Document when overrides are justified

4. Performance Budget Enforcement
   Legacy: Style-critical.tpl < 50 KB (hard limit)
   Current AIOX: Already documented

   Recommendation:
     - Add file size check to QA gate
     - Create automated build-time validation
     - Alert at 45 KB (warning) and 50 KB (error)
```

**Recommended AIOX Addition:**
Create `.aiox-core/development/checklists/nuvemshop-theme-deployment.md`:
```markdown
# Nuvemshop Theme Deployment Checklist

## Pre-Deploy Validation
- [ ] CSS size: style-critical.tpl < 50 KB (check: wc -c)
- [ ] Checkout form: No structural changes (compare layouts/checkout.tpl)
- [ ] Footer attribution: Visible, not hidden (check DevTools)
- [ ] Custom JS: No Nuvemshop function overrides
- [ ] Template syntax: All Liquid valid (test: --dry-run deploy)

## DevTools Validation (Manual but Required)
- [ ] Open browser DevTools → Elements tab
- [ ] Check critical elements (header, hero, footer, checkout)
- [ ] Inspect Styles panel for CSS conflicts
- [ ] Verify mobile viewport (360px, 768px, 1024px)

## Post-Deploy Verification
- [ ] FTP deploy completed without errors
- [ ] Smoke test: Load store homepage
- [ ] Check: Cart, checkout, product page functional
- [ ] Mobile test on actual device or emulator
```

---

### Pattern 4: Testing Pyramid & AAA Pattern

**Source:** `test-engineer.md`, `qa-automation-engineer.md`

**Relevance to AIOX:** 9/10 — Foundational testing architecture

**Legacy Framework Contribution:**
```yaml
Testing Pyramid Structure:
  Unit (Many - 80%)
    ├── Business logic, pure functions
    ├── Fast < 100ms each
    └── Coverage target: 70%+ utilities, 80%+ business

  Integration (Some - 15%)
    ├── API endpoints, DB queries, services
    ├── Mock external APIs only
    └── Coverage target: API contracts

  E2E (Few - 5%)
    ├── Critical user flows only
    ├── Playwright or Cypress
    └── Coverage target: Checkout, login, main paths

Testing Tools by Language:
  TypeScript:
    - Unit: Vitest, Jest
    - Integration: Supertest
    - E2E: Playwright

  Python:
    - Unit: Pytest
    - Integration: Pytest
    - E2E: Playwright

AAA Pattern (Mandatory for all tests):
  Arrange  - Set up test data
  Act      - Execute code under test
  Assert   - Verify outcome

  Anti-Pattern: Multiple asserts per test
  Correct Pattern: One logical assertion per test

Test Design Workflow (TDD):
  🔴 RED   → Write failing test
  🟢 GREEN → Minimal code to pass
  🔵 REFACTOR → Improve code quality
```

**AIOX Enhancement Gap:**
```yaml
Current AIOX Implementation:
  - Story files reference tests ✅
  - "Add unit tests" in AC ✅
  - npm run test available ✅

Missing from AIOX:
  - Test pyramid guidance in docs
  - AAA pattern enforcement
  - Coverage targets per file type
  - TDD workflow task definition
  - Test isolation requirements
  - Flaky test handling

Recommendation: Create .aiox-core/development/tasks/tdd-workflow.md
  - Task: *develop-tdd (activates TDD mode)
  - Guides @dev through RED → GREEN → REFACTOR cycles
  - Links to test pyramid in docs/guides/testing/
  - Includes coverage checklist
  - Defines "fast" threshold (< 100ms unit tests)
```

---

### Pattern 5: QA Gate Authority & Exclusive Ownership

**Source:** `qa.md` (comprehensive agent definition with YAML config)

**Relevance to AIOX:** 10/10 — Already in AIOX as @qa (Quinn)

**Current AIOX Implementation:**
- @qa has QA Results section ownership ✅
- *review command available ✅
- *gate command for decisions ✅
- CodeRabbit integration configured ✅

**Legacy Enhancement (Rare Insight):**

The legacy QA agent includes a **story-file-permissions** section that explicitly restricts modifications:

```yaml
# From legacy qa.md (CRITICAL)
story-file-permissions:
  - CRITICAL: When reviewing stories, you are ONLY authorized to update
    the "QA Results" section of story files
  - CRITICAL: DO NOT modify any other sections including Status, Story,
    Acceptance Criteria, Tasks/Subtasks, Dev Notes, Testing, Dev Agent
    Record, Change Log, or any other sections
  - CRITICAL: Your updates must be limited to appending your review results
    in the QA Results section only
```

**AIOX Implementation Status:** ✅ Already enforced in current CLAUDE.md

**Enhancement Opportunity:** Document this explicitly in agent-authority.md:
```yaml
@qa (Quinn) - QA Authority Matrix

Exclusive Authority:
  - *review {story}      # Comprehensive story review
  - *gate {story}        # Quality gate decision (PASS/CONCERNS/FAIL/WAIVED)
  - *test-design {story} # Create test scenarios
  - Story "QA Results" section modification ONLY

BLOCKED Operations:
  - ❌ Modify Acceptance Criteria
  - ❌ Modify Task/Subtask sections
  - ❌ Change story Status (only advisory)
  - ❌ Create/modify implementation code
  - ❌ git push (delegate to @devops)

Collaboration:
  - Receives from @dev: Completed story ready for review
  - Provides to @dev: Fix requests via *create-fix-request
  - Escalates to @architect: Architectural concerns
  - Escalates to @pm: Requirements misalignment
```

---

### Pattern 6: Orchestrator Multi-Agent Coordination Model

**Source:** `orchestrator.md`

**Relevance to AIOX:** 8/10 — Enhanced coordination capability

**Legacy Insight:**
The legacy **Orchestrator** agent (distinct from AIOX master) provides sophisticated **multi-agent task decomposition**:

**Key Principles:**
1. **PRE-FLIGHT CHECKS (Mandatory before invoking any agents)**
   - Verify PLAN.md exists
   - Validate project type (WEB/MOBILE/BACKEND)
   - Confirm agent routing correctness

2. **STRICT AGENT BOUNDARIES**
   - Frontend specialist CANNOT write test files
   - Backend specialist CANNOT write UI components
   - Test engineer CANNOT write production code
   - File type ownership prevents cross-domain contamination

3. **CONFLICT RESOLUTION**
   - If multiple agents suggest changes to same file, merge suggestions
   - If agents disagree, explain trade-offs (security > performance > convenience)
   - User decides when conflicts arise

4. **SEQUENTIAL vs PARALLEL TASK EXECUTION**
   - Parallel: Different files/agents OK
   - Sequential: Same file, Component→Consumer, Schema→Types

**AIOX Enhancement Opportunity:**

```yaml
Current AIOX:
  - @aiox-master has override capability ✅
  - Agent boundaries partially enforced ✅
  - No formal pre-flight check system ❌

Recommendation: Enhance workflow-execution.md with orchestration checklist

Before SDC Phase 3 (Implementation):
  - [ ] PLAN.md exists and identifies project type
  - [ ] Agent routing matches project type
  - [ ] Dependencies between stories identified
  - [ ] Parallel/sequential task sequencing determined
  - [ ] Risk areas identified with mitigation

During Parallel Execution:
  - [ ] No same-file edit conflicts allowed
  - [ ] Dependencies respected (no forward references)
  - [ ] Merge strategy defined before execution

Post-Execution:
  - [ ] All changes integrated successfully
  - [ ] No file ownership violations
  - [ ] Conflicts resolved per trade-off priority
```

---

### Pattern 7: Product Owner Requirements Elicitation

**Source:** `product-owner.md`

**Relevance to AIOX:** 9/10 — @po role exists but needs enrichment

**Current AIOX @po (Pax):** Minimal definition (story validation focus)

**Legacy Enhancement — Product Owner Deep Skills:**

```yaml
Requirements Elicitation (Socratic Method):
  "As a [Persona], I want to [Action], so that [Benefit]."

  Questions to Extract Implicit Requirements:
    1. WHO is the user? (Role, context, constraints)
    2. WHAT do they want to do? (Action, workflow)
    3. WHY do they want it? (Goal, pain point, value)
    4. WHEN do they need it? (Timeline, priority)
    5. HOW will success be measured? (KPIs, acceptance)

User Story Creation Process:
  1. Extract 2-3 key requirements from vague request
  2. Write 3-5 user stories from each requirement
  3. Estimate complexity: t-shirt sizing (S/M/L/XL)
  4. Identify dependencies: What blocks this story?
  5. Break down epic: Into vertical slices (shippable value)

Scope Management (MoSCoW Framework):
  Must Have    - Deliver MVP, without = failure
  Should Have  - Important, valuable, can delay
  Could Have   - Nice-to-have, defer post-MVP
  Won't Have   - Out of scope, document for later

RICE Prioritization:
  Reach      × Impact × Confidence ÷ Effort = Priority Score
  5 users × 3 impact × 80% confidence ÷ 5 weeks = 2.4 score
```

**AIOX Enhancement:**
Create `.aiox-core/development/tasks/po-elicit-requirements.md`:
```markdown
# @po Task: Elicit User Story Requirements

## Input
Vague requirement: "Users should be able to manage their cart"

## Process
1. Ask Socratic questions (5 minutes)
   - "Who are these users?" → Shoppers, guest, returning?
   - "What specifically managing?" → Add, remove, quantity, save for later?
   - "When do they need this?" → During checkout flow or anytime?
   - "How will success be measured?" → Conversion rate? Time to checkout?

2. Create 3-5 user stories
   - Story 1: "As a shopper, I want to add items to cart"
   - Story 2: "As a shopper, I want to change quantity"
   - Story 3: "As a shopper, I want to remove items"
   - Story 4: "As a returning customer, I want to view saved carts"

3. Apply MoSCoW
   - Must: Add, remove, quantity
   - Should: Save cart, view saved carts
   - Could: Cart sharing, recommendations

4. Estimate complexity
   - Add/Remove/Quantity: S (1-2 days)
   - Save cart: M (3-5 days)
   - Cart sharing: L (1-2 weeks)

## Output
.prd/cart-management-requirements.md with:
  - Elicitation questions & answers
  - 5 detailed user stories
  - MoSCoW classification
  - Complexity estimates
  - Dependency map

## Acceptance Criteria
- [ ] Ambiguous terms clarified
- [ ] User personas identified
- [ ] Success metrics defined
- [ ] MVP scope bounded
- [ ] @pm approved before @sm drafts stories
```

---

### Pattern 8: DevOps 5-Phase Deployment Framework

**Source:** `devops-engineer.md`

**Relevance to AIOX:** 8/10 — Deployment automation exists, needs enrichment

**Current AIOX Implementation:**
- @devops has exclusive git push authority ✅
- PR creation/merge exclusive ✅
- No formal deployment phases ❌

**Legacy DevOps Framework — 5 Phases:**

```yaml
PREPARE Phase:
  - [ ] All tests passing (npm test)
  - [ ] Build successful (npm run build)
  - [ ] Environment variables verified
  - [ ] Database migrations ready
  - [ ] Rollback plan documented

BACKUP Phase:
  - [ ] Current version tagged (git tag v1.2.3)
  - [ ] Database backup taken (if applicable)
  - [ ] Content snapshot saved
  - [ ] Configuration backup created

DEPLOY Phase:
  - [ ] Execute deployment with monitoring active
  - [ ] Follow platform-specific procedures
  - [ ] Environment: staging first, then production
  - [ ] Keep team notified

VERIFY Phase:
  - [ ] Health check endpoints responding (200 OK)
  - [ ] No errors in application logs
  - [ ] Key user flows verified (smoke test)
  - [ ] Performance acceptable (Lighthouse, response times)

CONFIRM or ROLLBACK Phase:
  - [ ] All good? CONFIRM (mission success)
  - [ ] Issues found? ROLLBACK (restore from backup)
  - [ ] Partial rollback strategy if needed
  - [ ] Document what went wrong
```

**Deployment Platform Decision Tree (Legacy):**

```
Static site / JAMstack     → Vercel, Netlify, Cloudflare Pages
Simple Node.js / Python    → Railway, Render, Fly.io (managed) OR VPS + PM2 (control)
Complex app / Microservices → Docker Compose, Kubernetes
Serverless functions       → Vercel Functions, Lambda, Workers
Full control / Legacy      → VPS with PM2 or systemd
```

**AIOX Enhancement:**
Create `.aiox-core/development/checklists/deployment-checklist.md`:
```markdown
# Deployment Checklist (5-Phase Framework)

## Phase 1: PREPARE
- [ ] npm test — All tests passing
- [ ] npm run build — Build successful
- [ ] npm run typecheck — No type errors
- [ ] Environment variables — Verified for deployment environment
- [ ] Migrations — Applied and tested in staging
- [ ] Rollback plan — Documented in commit message

## Phase 2: BACKUP
- [ ] Current version — Tagged as release (git tag)
- [ ] Database — Full backup (if applicable)
- [ ] Config — Snapshot of environment secrets
- [ ] User data — Verified safe (if any destructive changes)

## Phase 3: DEPLOY
- [ ] Staging deployment — Run and verify first
- [ ] Monitoring — Alerts configured and active
- [ ] Notification — Team aware of deployment window
- [ ] Deployment command — Executed with full log capture

## Phase 4: VERIFY
- [ ] Health check — GET /health returns 200 OK
- [ ] Application logs — No ERROR level messages
- [ ] Smoke test — Key flows work (login, checkout, etc.)
- [ ] Performance — Lighthouse > 80, response times < 2s

## Phase 5: CONFIRM or ROLLBACK
- [ ] All checks passed? CONFIRM (document success)
- [ ] Any failure? ROLLBACK immediately (restore version tag)
- [ ] Partial issues? Document for post-incident review
```

---

## 🟡 MEDIUM VALUE PATTERNS (Document References)

### Pattern 9: Spec Pipeline — Pre-Implementation Requirements Refinement

**Source:** `.agent/workflows/` discussions, `project-planner.md`

**Relevance to AIOX:** 7/10 — AIOX has story-driven development, lacks formal spec phase

**Legacy Pattern:** 6-phase Spec Pipeline for complex features

```yaml
Phase 1: Gather (PM Responsibility)
  Output: requirements.json
  - What are the raw requirements?
  - Who are the users? (personas)
  - What's the problem being solved?

Phase 2: Assess (Architect Responsibility)
  Output: complexity.json
  - Complexity class: SIMPLE (≤8) / STANDARD (9-15) / COMPLEX (≥16)
  - 5 dimensions scored 1-5:
    1. Scope: Files affected
    2. Integration: External APIs
    3. Infrastructure: System changes
    4. Knowledge: Team familiarity
    5. Risk: Criticality level

Phase 3: Research (Analyst Responsibility)
  Output: research.json
  - Skip if SIMPLE class
  - Research required technologies
  - Identify unknown unknowns

Phase 4: Write Spec (PM Responsibility)
  Output: spec.md
  - Detailed requirements
  - Acceptance criteria (Given-When-Then)
  - Non-functional requirements
  - Out-of-scope items

Phase 5: Critique (QA Responsibility)
  Output: critique.json
  Verdicts:
    APPROVED (score ≥ 4.0)     → Proceed to Phase 6
    NEEDS_REVISION (3.0-3.9)   → Revise and re-critique
    BLOCKED (< 3.0)            → Escalate to @architect

Phase 6: Plan (Architect Responsibility)
  Output: implementation.yaml
  - Technology selection
  - File structure
  - Task breakdown
  - Risk mitigation
```

**Complexity Scoring Formula:**
```
score = (scope + integration + infrastructure + knowledge + risk) ÷ 5
Example: (3 + 2 + 2 + 1 + 2) ÷ 5 = 2.0 = SIMPLE
```

**AIOX Integration Recommendation:**
- Current AIOX uses **Story Development Cycle** directly
- Spec Pipeline adds **formal validation phase before implementation**
- Best for: Complex features, integrations, architectural changes
- Optional: Can skip for simple CRUD stories

**Recommended Addition:**
```yaml
.aiox-core/development/workflows/spec-pipeline.yaml:
  - When: Feature complexity assessment shows COMPLEX or STANDARD
  - Who: @pm (gather), @architect (assess/plan), @analyst (research), @qa (critique)
  - Duration: 2-5 days (vs. immediate implementation)
  - Output: spec.md + implementation.yaml → Feeds into SDC Phase 3

This becomes: Spec Pipeline → Story Development Cycle → Done
```

---

### Pattern 10: CodeRabbit Self-Healing Integration

**Source:** `qa.md` with full YAML configuration

**Relevance to AIOX:** 8/10 — Already configured, needs detailed workflow

**Current AIOX Implementation:**
- CodeRabbit integration referenced ✅
- WSL path handling documented ✅
- Self-healing loop not detailed ❌

**Legacy Enhancement — Full Self-Healing Workflow:**

```yaml
CodeRabbit Self-Healing Loop (Max 3 Iterations):

Input: Committed code (git diff main...HEAD)

Iteration 1:
  1. Run CodeRabbit scan (--prompt-only -t committed)
  2. Parse output for severity levels
  3. Extract CRITICAL and HIGH issues

  IF no CRITICAL/HIGH issues:
    → Create tech debt items for MEDIUM issues
    → Approve (PASS)
    → END

  IF CRITICAL/HIGH issues found:
    → @dev fixes issues (auto-healing attempt)
    → iteration++
    → CONTINUE to next iteration

Iteration 2:
  1. Re-run CodeRabbit (changes staged)
  2. If CRITICAL/HIGH still present:
    → @dev fixes again
    → iteration++
    → CONTINUE

Iteration 3:
  1. Final CodeRabbit run
  2. IF still have CRITICAL/HIGH:
    → Generate detailed QA report
    → Set gate: FAIL
    → HALT (require human intervention)

  IF clean:
    → Set gate: PASS
    → Approve for merge

Severity Handling:
  CRITICAL → Auto-fix (3 attempts)
  HIGH     → Auto-fix (3 attempts)
  MEDIUM   → Document as tech debt
  LOW      → Note in review, no action
```

**Command Reference (WSL):**
```bash
# Pre-commit (uncommitted changes)
wsl bash -c 'cd /mnt/c/...project && ~/.local/bin/coderabbit --prompt-only -t uncommitted'

# Pre-merge (compare to main)
wsl bash -c 'cd /mnt/c/...project && ~/.local/bin/coderabbit --prompt-only -t committed --base main'

# Timeout: 30 minutes (allow full review time)
# Exit code: 0 = pass, 1+ = issues found
```

**AIOX Enhancement:**
Document the full self-healing loop in `.claude/rules/coderabbit-integration.md`:
- Current file is minimal
- Add iteration logic
- Document severity mapping
- Include WSL command templates
- Link to .aiox-core/development/tasks/qa-run-coderabbit.md

---

### Pattern 11: Risk-Based Testing & Requirements Traceability

**Source:** `qa.md` core principles, `test-engineer.md`

**Relevance to AIOX:** 7/10 — Not currently systematic

**Legacy Pattern:**
```yaml
Risk-Based Testing Framework:

1. Requirements Traceability Matrix (RTM)
   AC1: "User can add item to cart"
     ↓
   Test Case: "Given cart is empty, When user adds item, Then cart count = 1"
     ↓
   Test Type: Unit (service logic) + E2E (full flow)
   Coverage: 100% (critical path)

2. Risk Assessment (Probability × Impact)
   High Risk: (High Prob + High Impact) → More tests
   Medium Risk: (Medium Prob + Medium Impact) → Standard tests
   Low Risk: (Low Prob + Low Impact) → Minimal tests

   Example:
   - Risk: User loses cart on page refresh (HIGH PROB, HIGH IMPACT)
     → Multiple E2E tests, different browsers
   - Risk: Footer color slightly off (LOW PROB, LOW IMPACT)
     → Visual regression test only

3. Evidence-Based Requirements
   ❌ "Should be performant"
   ✅ "Lighthouse score must be > 80 on mobile"

   ✅ Measurable, testable, verifiable

4. Quality Attributes (NFRs)
   Security: OWASP Top 10, no hardcoded secrets
   Performance: First Contentful Paint < 2s
   Reliability: 99.9% uptime, graceful degradation
   Accessibility: WCAG AA compliance
```

**AIOX Enhancement Opportunity:**
Create `.aiox-core/development/templates/risk-assessment-matrix.md`:
```markdown
# Risk Assessment & Test Strategy

## Requirement Traceability Matrix (RTM)

| AC# | Requirement | User Story Path | Test Type | Risk Level | Evidence |
|-----|-------------|-----------------|-----------|-----------|----------|
| 1 | User can add to cart | Browse→Click Add→Verify | E2E | High | Cart count increases |
| 2 | Cart persists on refresh | Cart→F5→Verify | E2E | High | LocalStorage verified |
| 3 | Header displays correctly | Load page→Check render | Visual | Low | Screenshot comparison |

## Risk Analysis

| Risk | Probability | Impact | Score | Mitigation | Tests |
|------|-----------|--------|-------|-----------|-------|
| User loses cart | HIGH | HIGH | 9 | Persist to DB + localStorage | E2E×3 + unit |
| Checkout fails for intl users | MEDIUM | HIGH | 6 | Support int'l payment APIs | E2E×2 + integration |
| Slow page load | HIGH | MEDIUM | 6 | Optimize images, lazy load | Lighthouse + perf |

## Non-Functional Requirements (NFRs)

Security:
  - [ ] No hardcoded secrets
  - [ ] OWASP Top 10 compliance
  - [ ] Input validation on all forms
  - Test: CodeRabbit security scan

Performance:
  - [ ] FCP < 1.5s on mobile
  - [ ] LCP < 2.5s on mobile
  - [ ] Lighthouse > 80 overall
  - Test: Lighthouse CI

Accessibility:
  - [ ] WCAG AA compliance
  - [ ] Keyboard navigation throughout
  - [ ] Screen reader support
  - Test: axe-core automated + manual
```

---

## 🔴 LOW VALUE PATTERNS (Archive Historical Only)

### Pattern 12: Legacy-Only Agents (Game Dev, Mobile)

**Source:** `.agent/agents/` — game-developer.md, mobile-developer.md

**Relevance to AIOX:** 2/10 — Not applicable to Nuvemshop ecommerce

**Decision:** Archive reference, do not port
**Rationale:** Patagang project is ecommerce web application (Next.js + React), not gaming or mobile native

---

### Pattern 13: Antigravity/Gemini/Codex Framework Compatibility

**Source:** `.agent/workflows/`, `.antigravity/rules.md`

**Relevance to AIOX:** 1/10 — AIOX is complete replacement

**Decision:** Archive for historical reference only

**Rationale:** AIOX is the new unified framework, replacing multiple IDE-specific agent systems (Cursor, Codex, Antigravity, Gemini)

---

### Pattern 14: Deprecated Build/Deploy Scripts

**Source:** `ftp-deploy/deploy-optimized.js` references

**Relevance to AIOX:** 2/10 — Specific to legacy setup

**Decision:** Keep only for rollback reference

**Rationale:** Modern AIOX uses CI/CD via GitHub Actions, not custom Node.js deployment scripts

---

## Integration Recommendations by AIOX Component

### 1. Agent Memory Files (agents/*/MEMORY.md)

**Current State:** Minimal persona definitions
**Enhancement Level:** HIGH (3-4 days work)

**Enrich:** `agents/dev/MEMORY.md`, `agents/qa/MEMORY.md`, `agents/architect/MEMORY.md`

```yaml
Add to each agent MEMORY.md:
  - Core Philosophy (WHY this agent thinks this way)
  - Domain Boundaries (CAN/CANNOT do matrix)
  - Decision Framework (how to approach problems)
  - Collaboration Patterns (which agents work with me)
  - Anti-Patterns (what to avoid)
  - Escalation Triggers (when to ask for help)

Source: Legacy agent definitions (e.g., orchestrator.md, devops-engineer.md)
Impact: +2 levels of sophistication per agent
```

---

### 2. Story Lifecycle Rules (story-lifecycle.md)

**Current State:** Basic status transitions
**Enhancement Level:** HIGH (3-4 days work)

**Add:** Story Validation Gate + QA Gate Details

```yaml
Phases:
  1. Draft           (Story created by @sm)
  2. Validation Gate (NEW: @po validates against 10-point checklist)
  3. Approved        (Green light for @dev)
  4. InProgress      (@dev implementing)
  5. InReview        (@dev marks ready)
  6. QA Gate         (@qa runs CodeRabbit + manual review)
  7. Done            (Merged, deployed)

New Sections Needed:
  - 10-point story validation checklist (from legacy @po.md)
  - CodeRabbit integration points (severity mapping, self-healing)
  - QA gate verdicts (PASS/CONCERNS/FAIL/WAIVED)
  - Requirements traceability template
  - Test design task reference
```

---

### 3. Quality Gates (qa-gate.md task)

**Current State:** Basic gate decision
**Enhancement Level:** HIGH (4-5 days work)

**Create:** `.aiox-core/development/tasks/qa-gate-comprehensive.md`

```yaml
Replaces: Current qa-gate.md (kept as simple version)
New File: qa-gate-comprehensive.md (10-phase detailed)

Phases:
  1. CodeRabbit scan (auto-run, self-healing max 3 iterations)
  2. Acceptance criteria traceability (RTM)
  3. Test coverage validation (80%+ critical)
  4. Non-functional requirements check
  5. Security vulnerability assessment
  6. Risk profile analysis (probability × impact)
  7. Performance benchmarking
  8. Edge case coverage verification
  9. Technical debt quantification
  10. Final gate decision (PASS/CONCERNS/FAIL/WAIVED)

Output: qa_report.md + decision artifact
Authority: @qa exclusive
Blocking: YES (can prevent merge)
```

---

### 4. Testing Guidance (docs/guides/testing/)

**Current State:** Minimal testing docs
**Enhancement Level:** MEDIUM (2-3 days work)

**Create:**
- `docs/guides/testing/testing-pyramid.md` (unit/integration/E2E)
- `docs/guides/testing/tdd-workflow.md` (RED-GREEN-REFACTOR)
- `docs/guides/testing/aaa-pattern.md` (Arrange-Act-Assert)
- `docs/guides/testing/coverage-targets.md` (per file type)

---

### 5. DevOps Deployment Checklist

**Current State:** No formal phases
**Enhancement Level:** MEDIUM (2 days work)

**Create:** `.aiox-core/development/checklists/deployment-5-phase.md`

```yaml
5 Phases:
  1. PREPARE (tests, build, env vars, rollback plan)
  2. BACKUP (tag version, DB backup, config snapshot)
  3. DEPLOY (run deployment, monitor)
  4. VERIFY (health check, logs, smoke test, performance)
  5. CONFIRM or ROLLBACK (mission success or restore)

Deliverable: Checklist template + decision tree
Authority: @devops
```

---

### 6. Product Owner Tasks

**Current State:** @po has *validate-story-draft only
**Enhancement Level:** MEDIUM (2-3 days work)

**Create:**
- `.aiox-core/development/tasks/po-elicit-requirements.md`
- `.aiox-core/development/tasks/po-scope-management.md` (MoSCoW/RICE)
- `.aiox-core/development/tasks/po-epic-breakdown.md`

---

### 7. Nuvemshop-Specific Enhancements

**Current State:** Constraints documented well
**Enhancement Level:** MEDIUM (2 days work)

**Add:**
- Automated CSS size validation (< 50 KB)
- FTP deployment automation checklist
- CSS cascade validation guide (DevTools screenshots)
- Theme consolidation patterns

---

## Risk Assessment

### Risks of NOT Implementing These Patterns

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|-----------|
| Story validation skipped → "built but wrong" | HIGH | MEDIUM | Implement @po gate in story-lifecycle.md |
| QA becomes bottleneck → slow merge process | MEDIUM | HIGH | Automate CodeRabbit, document severity mapping |
| Test coverage insufficient → production bugs | HIGH | HIGH | Implement testing pyramid + coverage targets |
| DevOps uncertain on deployment → risky deploys | HIGH | MEDIUM | Create 5-phase checklist + platform decision tree |
| Nuvemshop constraint violations → broken store | CRITICAL | LOW | Already well-documented in AIOX |

---

## Implementation Timeline

### Week 1: High Priority (Agent Enhancement)
- [ ] Enrich agent MEMORY.md files (2-3 days)
- [ ] Update story-lifecycle.md with validation gate (1-2 days)

### Week 2: Quality & Testing
- [ ] Create comprehensive QA gate task (2 days)
- [ ] Create testing guidance docs (2 days)

### Week 3: DevOps & Product
- [ ] Create 5-phase deployment checklist (1 day)
- [ ] Create @po elicitation tasks (1-2 days)

### Week 4: Polish & Review
- [ ] Create risk assessment templates (1 day)
- [ ] Documentation review & cross-linking (1 day)
- [ ] Archive decision for legacy patterns (1 day)

**Total Effort:** 11-15 days (2-3 weeks)
**AIOX Sophistication Improvement:** +3-4 levels (out of 10)

---

## Conclusion

The legacy framework contains **production-proven patterns** across 8 major dimensions:
1. ✅ Agent personas (READY FOR PORT)
2. ✅ Story Development Cycle (ALREADY IN AIOX)
3. ✅ Quality gates (NEEDS ENRICHMENT)
4. ✅ Testing architecture (NEEDS FORMALIZATION)
5. ✅ DevOps practices (NEEDS DOCUMENTED PHASES)
6. ✅ Product management (NEEDS @po EXPANSION)
7. ✅ Nuvemshop constraints (EXCELLENT IN AIOX)
8. ✅ Multi-agent orchestration (NEEDS DETAIL)

**Recommended Action:** Implement Pattern Family 1 (Agent Enrichment) + Pattern Family 2 (Quality Gates) as highest priority. These two alone would elevate AIOX from Level 6 → Level 8 (out of 10) operational maturity.

---

**Analysis Completed By:** @analyst (Alex)
**Date:** 2026-03-20
**Status:** Ready for @architect review and integration planning

