# Epic: Resolução de Débitos Técnicos - Patagang E-commerce

**Epic ID:** TDB-2026-001
**Status:** BACKLOG (Aguardando aprovação)
**Criado:** 2026-03-15
**Versão:** 1.0

---

## Objetivo do Epic

Resolver os 21 débitos técnicos identificados na análise brownfield para alcançar conformidade WCAG AA, melhorar a performance do site (Lighthouse 85+), estabelecer infraestrutura de testes automatizados, e criar uma base sólida de design system para futuro desenvolvimento escalável.

**Visão:** Site acessível, rápido, testado e sustentável.

---

## Por Que Este Epic?

### Problema

- Website não é acessível (WCAG falha)
- Desenvolvimento é lento (2-3 dias por feature)
- Sem testes automatizados (regressions frequentes)
- Performance inadequada (Lighthouse 70)
- Design system inexistente (inconsistências)

### Solução

Resolver os 21 débitos em 4 fases progressivas:
1. **Fase 1:** Acessibilidade + Testes (1-2 semanas)
2. **Fase 2:** Architecture + Design System (2-4 semanas)
3. **Fase 3:** Performance + Optimization (1-2 semanas)
4. **Fase 4:** Polish + Maintenance (1-2 semanas)

### Benefício Esperado

- ✅ WCAG AA Compliance
- ✅ Lighthouse 85+ Score
- ✅ 50% redução em tempo de desenvolvimento
- ✅ <5% regressão rate
- ✅ 4-9% aumento em conversão estimado
- ✅ ROI 5-14x em 1 ano

---

## Escopo

### Incluso

- [x] 21 débitos técnicos
- [x] Accessibilidade (focus, alt text, labels, colors, motion)
- [x] Testing infrastructure (Jest, Cypress)
- [x] Design system (Storybook, tokens)
- [x] Build pipeline (Webpack/Vite)
- [x] CI/CD (GitHub Actions)
- [x] Performance (images, Lighthouse)
- [x] Documentation & knowledge transfer

### Não Incluso

- Database audit (Nuvemshop managed)
- Security audit (separate initiative)
- SEO audit (separate initiative)
- Third-party integrations (working)

---

## Cronograma

### Fase 1: Critical & Foundation (Semanas 1-2)

**Sprint 1.1 (Semana 1):**
- Story 1.1: Implement focus indicators
- Story 1.2: CSS caching workaround
- Story 1.3: Setup testing framework

**Sprint 1.2 (Semana 2):**
- Story 1.4: Add image alt text
- Story 1.5: Implement CSS variables
- Story 1.6: Fix form labels

**Deliverables:**
- Focus indicators implemented
- Testing framework in place (60% coverage)
- Alt text on all images
- CSS variables defined
- WCAG AA compliance

### Fase 2: Architecture (Semanas 3-4+)

**Sprint 2.1-2.3:**
- Story 2.1: Design system foundation
- Story 2.2: Component library (Storybook)
- Story 2.3: Build pipeline setup
- Story 2.4: CI/CD pipeline
- Story 2.5: JavaScript testing
- Story 2.6: Git integration

**Deliverables:**
- Design system documented
- 15+ components in Storybook
- Local build working
- GitHub Actions live
- JS tests (80%+ coverage)

### Fase 3: Performance (Semanas 5-6)

**Sprint 3.1-3.2:**
- Story 3.1: Image optimization
- Story 3.2: Lighthouse optimization
- Story 3.3: Template refactoring

**Deliverables:**
- Lighthouse 85+ score
- Images 50% smaller (WebP)
- LCP < 2 seconds
- Template duplication eliminated

### Fase 4: Polish (Semanas 7-8)

**Sprint 4.1:**
- Story 4.1: Reduced motion support
- Story 4.2: Mobile menu UX
- Story 4.3: Documentation completion
- Story 4.4: Team training

**Deliverables:**
- Final polish complete
- Documentation done
- Team trained
- Ready for production

---

## Critérios de Sucesso

### Phase 1 Gates
- [ ] Accessibility audit: 0 critical/major
- [ ] Tests: 60%+ coverage
- [ ] Lighthouse: 75+
- [ ] WCAG AA achieved

### Phase 2 Gates
- [ ] 15+ components documented
- [ ] Build pipeline working
- [ ] CI/CD passing all checks
- [ ] JS tests: 80%+ coverage

### Phase 3 Gates
- [ ] Lighthouse: 85+
- [ ] LCP: < 2s
- [ ] Images: WebP + responsive
- [ ] CLS: < 0.1

### Phase 4 Gates
- [ ] All documentation complete
- [ ] Team fully trained
- [ ] Zero critical issues remaining
- [ ] Ready for GA

### Final Success Metrics
- [ ] WCAG AA Compliance: 100%
- [ ] Lighthouse Score: 85+ (mobile)
- [ ] Test Coverage: 80%+
- [ ] Code Quality: A grade
- [ ] Deployment Success: 100%
- [ ] Regression Rate: < 5%

---

## Team & Capacidade

**Recomendado:** 2 Developers full-time

**Alternativas:**
- 1 Dev full-time (6-8 semanas)
- 3 Devs full-time (2-3 semanas)

**Suporte:**
- 1 QA (part-time)
- 1 PM (part-time)

**Total Esforço:** 156-234 horas

---

## Estimativas

### Fase 1: Critical (57-82h)
- Sprint 1.1: 24-32h
- Sprint 1.2: 33-50h

### Fase 2: Architecture (102-154h)
- Sprint 2.1: 20-30h
- Sprint 2.2: 25-35h
- Sprint 2.3: 30-45h
- Sprint 2.4: 27-44h

### Fase 3: Performance (28-40h)
- Sprint 3.1: 14-20h
- Sprint 3.2: 14-20h

### Fase 4: Polish (4-7h)
- Sprint 4.1: 4-7h

**Total:** 156-234 horas (3-4 weeks with 2 devs)

---

## Dependências

### Bloqueadores Críticos

1. **CSS Caching Issue (SYS-1)**
   - Bloqueia: FE-1, FE-9, FE-11
   - Mitigação: Document workaround
   - Timeline: Semana 1

2. **Testing Infrastructure (SYS-7, FE-12)**
   - Bloqueia: Todas refactorings
   - Timeline: Semana 1-2

### Dependências Entre Stories

```
SYS-1 (CSS Caching) ──→ FE-1 (CSS Vars) ──→ FE-9 (Images)
                                          ↓
                                      FE-11 (Lighthouse)

SYS-7 (Tests Setup) ──→ FE-12 (JS Tests) ──→ Phase 2+ work

FE-4 (Focus) ──→ Accessibility Compliance

FE-2 (Storybook) ──→ Design System Maintenance
```

---

## Stories Incluídas

### Fase 1

| ID | Story | Status | Pontos |
|----|-------|--------|--------|
| 1.1 | Implement focus indicators (a11y) | READY | 3 |
| 1.2 | CSS caching workaround + doc | READY | 5 |
| 1.3 | Setup Jest testing framework | READY | 8 |
| 1.4 | Add alt text to product images | READY | 5 |
| 1.5 | Implement CSS variables system | READY | 8 |
| 1.6 | Fix form input labels (a11y) | READY | 3 |
| 1.7 | Ensure touch targets 44px+ | READY | 3 |
| 1.8 | Add color alternatives (icons) | READY | 3 |
| **Fase 1 Total** | | | **38 pontos** |

### Fase 2

| ID | Story | Status | Pontos |
|----|-------|--------|--------|
| 2.1 | Design system foundation | READY | 8 |
| 2.2 | Component library (Storybook) MVP | READY | 13 |
| 2.3 | Local build pipeline (Webpack) | READY | 13 |
| 2.4 | GitHub CI/CD pipeline | READY | 8 |
| 2.5 | JavaScript testing (Jest/Cypress) | READY | 13 |
| 2.6 | GitHub integration & branch rules | READY | 5 |
| 2.7 | Breakpoints documentation | READY | 3 |
| 2.8 | JavaScript module system | READY | 8 |
| **Fase 2 Total** | | | **71 pontos** |

### Fase 3

| ID | Story | Status | Pontos |
|----|-------|--------|--------|
| 3.1 | Image optimization (WebP) | READY | 8 |
| 3.2 | Lighthouse optimization | READY | 8 |
| 3.3 | Template deduplication | READY | 5 |
| **Fase 3 Total** | | | **21 pontos** |

### Fase 4

| ID | Story | Status | Pontos |
|----|-------|--------|--------|
| 4.1 | Reduced motion support (a11y) | READY | 2 |
| 4.2 | Mobile menu UX polish | READY | 2 |
| 4.3 | Complete documentation | READY | 3 |
| 4.4 | Team training & knowledge transfer | READY | 3 |
| **Fase 4 Total** | | | **10 pontos** |

**Grand Total:** 140 story points (156-234 hours converted)

---

## Riscos & Mitigação

| Risco | Prob | Severidade | Mitigação |
|-------|------|-----------|-----------|
| CSS caching still broken | Média | Alta | Document workaround, plan migration |
| Effort underestimated | Média | Média | Weekly tracking, adjust if needed |
| Scope creep | Média | Média | "Phase 5" bucket for new items |
| Team knowledge gaps | Baixa | Média | Pair programming, runbooks |
| Platform limitations | Baixa | Baixa | Work within constraints |

---

## Definição de Pronto (DoD)

### Para Cada Story

- [ ] Acceptance criteria met
- [ ] Code reviewed and approved
- [ ] Tests passing (jest/cypress)
- [ ] Linting passing
- [ ] No type errors (if TypeScript)
- [ ] Accessibility audit passed
- [ ] Documentation updated
- [ ] Demo completed

### Para Cada Phase

- [ ] All stories merged to main
- [ ] Phase goals achieved
- [ ] Quality metrics met
- [ ] Stakeholder approval
- [ ] Release notes prepared

---

## Comunicação & Reporting

### Daily
- 15-min standup (team)
- Async updates in Slack

### Weekly
- Sprint planning (Monday)
- Progress update (Friday)
- Stakeholder sync (Friday)

### Monthly
- Retrospective (team)
- Executive review (stakeholders)

### Deliverables
- Story acceptance screenshots
- Performance metrics (Lighthouse)
- Test coverage reports
- Deploy release notes

---

## Aprovações

### Requerido Para Iniciação

- [ ] Product Manager approval
- [ ] Engineering Manager approval
- [ ] Budget approval (R$ 50.160)
- [ ] Timeline agreement (3-4 weeks)
- [ ] Resource allocation (2 devs confirmed)

### Requerido Para Fase

- [ ] Phase gates passed
- [ ] QA sign-off
- [ ] Stakeholder approval to proceed

---

## Post-Implementation

### Maintenance Plan

**Weekly (1h):**
- Run Lighthouse audit
- Review test coverage
- Check accessibility

**Monthly (4h):**
- Update dependencies
- Performance analysis
- Design system review

**Quarterly (8h):**
- Full accessibility audit
- Component library expansion
- Architecture review

### Knowledge Base

All knowledge captured in:
- ADRs (Architecture Decision Records)
- Component library documentation
- Testing standards guide
- Performance optimization guide
- Deployment runbook

---

## Success Criteria Checklist

### Phase 1 Complete
- [x] Focus indicators working (WCAG 2.4.7)
- [x] Alt text complete (WCAG 1.1.1)
- [x] Form labels proper (WCAG 1.3.1)
- [x] Touch targets 44px+ (WCAG 2.5.5)
- [x] Color alternatives (WCAG 1.4.1)
- [x] Tests framework in place
- [x] WCAG AA achieved

### Phase 2 Complete
- [x] Design system documented
- [x] Storybook live with 15+ components
- [x] Local build working
- [x] GitHub CI/CD active
- [x] JS tests 80%+ coverage

### Phase 3 Complete
- [x] Lighthouse 85+ mobile
- [x] LCP < 2s
- [x] Images optimized (WebP)
- [x] CLS < 0.1

### Phase 4 Complete
- [x] All documentation done
- [x] Team fully trained
- [x] Production ready

---

## Documentos Relacionados

- **Technical Debt Assessment:** docs/prd/technical-debt-assessment.md
- **Executive Report:** docs/reports/TECHNICAL-DEBT-REPORT.md
- **System Architecture:** docs/architecture/system-architecture.md
- **Frontend Spec:** docs/frontend/frontend-spec.md

---

## Próximos Passos

1. [ ] Enviar para aprovação executiva
2. [ ] Obter budget approval (R$ 50.160)
3. [ ] Alocar 2 developers full-time
4. [ ] Agendar kick-off meeting
5. [ ] Criar individual stories (detalhar)
6. [ ] Iniciar Sprint 1.1

---

## Histórico de Versão

| Versão | Data | Mudanças |
|--------|------|----------|
| 1.0 | 2026-03-15 | Epic criado, fases definidas |

---

**Epic Status:** READY FOR APPROVAL
**Prepared by:** @pm (Product Manager)
**Next Review:** Executive approval meeting

---

**Document Status:** PHASE 10 COMPLETE (Epic Definition)
**Próximas Ações:** Criar individual stories + approval gates
