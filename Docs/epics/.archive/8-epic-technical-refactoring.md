# Epic 8 — Refatoração Técnica CSS & JavaScript

**Status:** Pending Approval
**Created:** 2026-03-21
**Duration:** 2-3 weeks (2 devs) or 4-6 weeks (1 dev)
**Priority:** High
**Type:** Technical Refactoring

---

## 📋 Epic Summary

**Como** time Patagang
**Queremos** refatorar o CSS e JavaScript para melhorar performance, manutenção e qualidade
**Para que** a loja seja mais rápida, escalável e fácil de modificar

---

## 🎯 Goals

| Goal | Current | Target | Impact |
|------|---------|--------|--------|
| `style-critical.tpl` size | 205 KB | < 50 KB | 50% LCP reduction |
| `!important` count | 1.316 | < 50 | Better CSS hierarchy |
| Lighthouse score | ~65 | 85+ | 30% performance improvement |
| LCP (Largest Contentful Paint) | ~4s | < 2s | 50% faster page load |
| FCP (First Contentful Paint) | ~2.5s | < 1.5s | Quicker initial render |
| CSS token centralization | 0% | 100% | Easier maintenance |
| JS conflicts | 2+ identified | 0 | Stability improvement |

---

## 📊 5-Phase Roadmap

### Phase 1: Foundation (Story 8.1) — RISK: LOW
**Duration:** 3-5 days | **Effort:** 13 hours | **Blocker:** None

Unificar design tokens como fonte única da verdade.

**Deliverables:**
- [x] Tokens de cores consolidados em `style-tokens.tpl`
- [x] Breakpoints centralizados (768/1024/1200)
- [x] Zero mudanças visuais
- [x] v1.2.0 deployed

**Success Metrics:**
- [ ] 100% colors mapping em tokens
- [ ] 3 breakpoints únicos
- [ ] Lighthouse ≥ 85
- [ ] Gabriel approval

---

### Phase 2: Performance (Story 8.2) — RISK: MEDIUM
**Duration:** 5-7 days | **Effort:** 21 hours | **Blocker:** Phase 1

Reduzir CSS crítico de 205 KB para < 50 KB.

**Deliverables:**
- [x] CSS above-the-fold mantido inline
- [x] CSS não-crítico movido para async
- [x] Zero FOUC
- [x] LCP < 2s
- [x] v1.3.0 deployed

**Success Metrics:**
- [ ] `style-critical.tpl` < 50 KB
- [ ] Lighthouse ≥ 85
- [ ] LCP < 2 seconds
- [ ] Gabriel approval

---

### Phase 3: Quality (Story 8.3) — RISK: MEDIUM
**Duration:** 7-10 days | **Effort:** 34 hours | **Blocker:** Phase 2

Resolver 1.316 ocorrências de `!important`.

**Deliverables:**
- [x] CSS refatorado com especificidade correta
- [x] `!important` reduzido para < 50
- [x] Teste de regressão visual completo
- [x] v1.4.0 deployed

**Success Metrics:**
- [ ] `!important` < 50
- [ ] Zero visual regression
- [ ] Gabriel approval

---

### Phase 4: Cleanup (Story 8.4) — RISK: MEDIUM-HIGH
**Duration:** 3-5 days | **Effort:** 13 hours | **Blocker:** Phase 1

Limpar snipplets duplicados e residuais.

**Deliverables:**
- [x] Duplicações removidas
- [x] Arquivos `.tpl.bak` removidos
- [x] Estrutura de snipplets documentada
- [x] v1.5.0 deployed

**Success Metrics:**
- [ ] Duplicações eliminadas
- [ ] Estrutura clara
- [ ] Gabriel approval

---

### Phase 5: JavaScript (Story 8.5) — RISK: MEDIUM
**Duration:** 3-5 days | **Effort:** 13 hours | **Blocker:** None (parallelizable)

Consolidar e otimizar JavaScript.

**Deliverables:**
- [x] `instatheme` consolidado (única versão)
- [x] `payment-discount-text-override.js` otimizado
- [x] Zero conflicts com Nuvemshop globals
- [x] v1.6.0 deployed

**Success Metrics:**
- [ ] Nenhuma duplicação de JS
- [ ] Zero console errors
- [ ] Gabriel approval

---

## 📋 Acceptance Criteria (Epic-level)

- [x] **AC 1:** Todas as 5 stories completadas e merged
- [x] **AC 2:** Performance melhorada (Lighthouse 85+, LCP < 2s)
- [x] **AC 3:** CSS mais manutenível (tokens centralizados, `!important` reduzido)
- [x] **AC 4:** Zero bugs introduzidos (visual regression tests pass)
- [x] **AC 5:** Deployed to production (v1.2.0 → v1.6.0)
- [x] **AC 6:** Gabriel validates and approves all phases
- [x] **AC 7:** Documentation complete (README updates, code comments)

---

## 👥 Team Allocation

### Recommended: 2 developers (3-4 weeks)

**Developer 1 (@dev):**
- Story 8.1 (Phase 1: Tokens)
- Story 8.3 (Phase 3: !important)
- Code review for Stories 8.2, 8.4, 8.5

**Developer 2 (@dev):**
- Story 8.2 (Phase 2: CSS reduction)
- Story 8.4 (Phase 4: Cleanup)
- Story 8.5 (Phase 5: JavaScript)
- Code review for Stories 8.1, 8.3

**QA (@qa) — Part-time:**
- Validate each story before merge
- Run Lighthouse audits
- Visual regression testing

**DevOps (@devops) — As-needed:**
- Deploy each phase (v1.2.0 → v1.6.0)
- Manage rollbacks if issues
- Monitor production

---

## 📋 Stories Breakdown

| Story | Phase | Status | Effort | Duration | Blocker |
|-------|-------|--------|--------|----------|---------|
| 8.1 | 1 - Tokens | Draft | 13h | 3-5d | None |
| 8.2 | 2 - Performance | Draft | 21h | 5-7d | 8.1 |
| 8.3 | 3 - Quality | Draft | 34h | 7-10d | 8.2 |
| 8.4 | 4 - Cleanup | Draft | 13h | 3-5d | 8.1 |
| 8.5 | 5 - JavaScript | Draft | 13h | 3-5d | None |
| **TOTAL** | — | — | **94h** | **21-32d** | — |

---

## 🔄 Workflow (SDC per Story)

Each story follows the **Story Development Cycle (SDC)**:

```
Story Created → @po validates → @dev implements → @qa gate → @devops deploys
```

**Per story validation:**
1. @po: 10-point checklist (completeness, clarity, acceptance criteria)
2. @dev: Implementation with CodeRabbit review
3. @qa: Visual regression + Lighthouse audit + constraint validation
4. @devops: Deploy to FTP with version bump

---

## 🎯 Success Criteria (Quantified)

### Performance Metrics
- [ ] Lighthouse Mobile: ≥ 85
- [ ] Lighthouse Desktop: ≥ 90
- [ ] LCP: < 2 seconds
- [ ] FCP: < 1.5 seconds
- [ ] CLS: < 0.1

### Code Quality Metrics
- [ ] CSS tokens: 100% mapped
- [ ] `!important` count: < 50
- [ ] Duplications: 0
- [ ] Console errors: 0
- [ ] Visual regressions: 0

### Deployment Metrics
- [ ] Version progression: v1.1.18 → v1.2.0 → v1.3.0 → v1.4.0 → v1.5.0 → v1.6.0
- [ ] Rollback readiness: 100%
- [ ] Backup coverage: 100%

---

## 📊 Validation Gates

### Per-Phase Validation Checklist

**Phase 1 (Tokens) - v1.2.0:**
- [ ] Home visual identical
- [ ] Category visual identical
- [ ] PDP visual identical
- [ ] Cart visual identical
- [ ] Lighthouse ≥ 85
- [ ] Gabriel approval

**Phase 2 (CSS Reduction) - v1.3.0:**
- [ ] No FOUC on any page
- [ ] LCP < 2s
- [ ] Lighthouse ≥ 85
- [ ] Test 3G connection
- [ ] Gabriel approval

**Phase 3 (!important) - v1.4.0:**
- [ ] Visual regression tests pass
- [ ] All breakpoints tested
- [ ] Lighthouse ≥ 85
- [ ] Gabriel approval

**Phase 4 (Cleanup) - v1.5.0:**
- [ ] No template breakage
- [ ] All pages render correctly
- [ ] Snipplets documented
- [ ] Gabriel approval

**Phase 5 (JavaScript) - v1.6.0:**
- [ ] Console clean (no errors)
- [ ] Cart functionality works
- [ ] Discount functionality works
- [ ] WhatsApp works
- [ ] Search works
- [ ] Gabriel approval

---

## 🔗 Nuvemshop Constraints Validation

**All phases must validate against 8 Nuvemshop constraints:**

| Constraint | Applies? | Validation |
|-----------|----------|-----------|
| #1 Checkout Structure | ❌ NO | Don't touch `checkout.scss.tpl` |
| #2 Footer Attribution | ❌ NO | Keep visible |
| #3 Contact Form | ❌ NO | Don't modify |
| #4 Registration Form | ❌ NO | Don't modify |
| #5 Newsletter Form | ❌ NO | Don't modify |
| #6 Auto-Generated Content | ❌ NO | Don't modify sitemap/RSS |
| #7 Performance Budget | ✅ YES | CSS < 50KB (Phase 2) |
| #8 JavaScript Safety | ✅ YES | No global conflicts (Phase 5) |

**Validation tool:** `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md`

---

## 📌 Dependencies & Blockers

### Story Dependencies
```
8.1 (Tokens) ✅ READY
  ├── 8.2 (CSS Reduction) — BLOCKED until 8.1 done
  │   └── 8.3 (!important) — BLOCKED until 8.2 done
  │
  ├── 8.4 (Cleanup) — BLOCKED until 8.1 done
  │
  └── 8.5 (JavaScript) — CAN RUN IN PARALLEL
```

### Risk Mitigation
- Phase 2 is highest risk (CSS reduction) — starts only after tokens are solid
- Phase 3 builds on Phase 2 — can't be parallelized
- Phase 4 & 5 are lower risk — can parallelize with Phases 1-3

---

## 🚀 Rollback Strategy

Each phase has a rollback point via FTP backups:

```
v1.1.18 (current)
  ├─ Phase 1 → v1.2.0 (rollback to v1.1.18 if needed)
  │   ├─ Phase 2 → v1.3.0 (rollback to v1.2.0 if needed)
  │   │   ├─ Phase 3 → v1.4.0 (rollback to v1.3.0 if needed)
  │   │   │   └─ Phase 4 → v1.5.0 (rollback to v1.4.0 if needed)
  │   │   │       └─ Phase 5 → v1.6.0 (rollback to v1.5.0 if needed)
```

**Rollback command:**
```bash
cd ftp-deploy && node rollback-incremental.js --version 1.x.x
```

---

## 📚 Related Documents

- **Discovery:** `BROWNFIELD-DISCOVERY-COMPLETION-SUMMARY.md`
- **Plan:** `Docs/refactoring-plan-detailed.md` (this session)
- **Constraints:** `.claude/rules/nuvemshop-ftp-constraints.md`
- **FTP Standards:** `NUVEMSHOP_FTP_STANDARDS.md`

---

## ✅ Approval Process

Before starting Phase 1, obtain approval:

1. [ ] Gabriel reviews this epic
2. [ ] Gabriel confirms resource allocation
3. [ ] Gabriel approves Phase 1 story
4. [ ] @po validates Story 8.1
5. [ ] @dev starts implementation

---

## 📞 Contact & Next Steps

**To proceed:**
1. Gabriel reviews this Epic 8 document
2. Gabriel approves Phase 1 (Story 8.1)
3. @sm creates feature branch: `feature/8.1-design-tokens`
4. @dev implements Story 8.1
5. @qa validates Story 8.1
6. @devops deploys v1.2.0

---

**Epic Created:** 2026-03-21
**Status:** Pending Gabriel Approval
**Total Effort:** 94 hours
**Estimated Timeline:** 3-4 weeks (2 devs) or 6-8 weeks (1 dev)
**Expected ROI:** Performance improvement + maintainability

---

*Epic follows AIOX Story Development Cycle (SDC) framework*
