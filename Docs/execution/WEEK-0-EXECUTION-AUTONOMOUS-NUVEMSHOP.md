# 📋 WEEK 0 — Execução Autônoma AIOX 10/10 (Nuvemshop FTP Real)

**Data:** 17-23 de Março de 2026
**Padrão:** AIOX 10/10 Brownfield Discovery
**Realidade:** Nuvemshop FTP theme-only (sem staging separado)
**Status:** 🔄 EXECUTANDO AGORA

---

## 📊 WEEK 0 OVERVIEW

```
WEEK 0: PREPARAÇÃO PRÉ-SPRINT (3 dias)
17 de Março (Seg) → 23 de Março (Dom) → 24 de Março (Seg Kick-off)

Objetivo: Validar ambiente FTP, confirmar time, preparar execução
Padrão: AIOX 10/10
Resultado: Sprint 1.1 pronto para 24 de Março às 10:00 AM
```

---

## 🎯 STEP 1: CONFIRMAÇÃO DE TIME (17-18 Março)

### AIOX 10/10 Task: Confirmação de Developers + Project Roles

**1. Task ID + Title:**
```
W0-NUVEMSHOP-001 — Confirmar 2 Developers + Funções do Projeto
```

**2. Owner Responsibility:**
- **Você (Project Manager)** — enviar confirmação
- **Engineering Manager** — aprovar assignment
- **Orion** — documentar e rastrear

**3. Objective:**
```
Como Project Manager,
Quero confirmar 2 developers full-time para 8 semanas,
Para garantir propriedade clara do time e começar Sprint 1.1 em 24 de Março.
```

**4. Acceptance Criteria:**
```
□ Developer A: Nome + email confirmado
□ Developer B: Nome + email confirmado
□ Ambos: Comprometidos com 40h/semana por 8 semanas
□ Ambos: Receberam acesso a todos os 20+ documentos
□ Engineering Manager: Aprovação em escrito
□ Product Manager: Aprovação da timeline (8 semanas, 21 histórias)
□ Confirmação enviada para todos (email/Slack)
```

**5. Definition of Done:**
```
✅ Ambos developers respondem com confirmação
✅ Acesso ao GitHub concedido + verificado
✅ Acesso ao Slack/canal confirmado
✅ Engineering Manager aprova por escrito
✅ Meeting de kick-off agendado para 24 Março 10:00 AM
✅ Roster do time documentado
```

**6. Dependencies:**
```
Nenhuma — primeiro passo
```

**7. Risk Assessment:**
```
🔴 RISCO: Developer indisponível
   → Mitigação: Confirmar até quinta-feira

🟡 RISCO: Decisão tardia sobre funções
   → Mitigação: Fazer solicitação hoje

🟢 BAIXO RISCO: Problemas de acesso/permissão
   → Mitigação: Verificar com IT admin
```

**8. Validation Gates:**
```
Gate 1 (Hoje 14:00): Emails de confirmação recebidos
Gate 2 (Hoje 16:00): Acesso GitHub verificado
Gate 3 (Quarta 09:00): Preparação pré-meeting completa
Gate 4 (Segunda 10:00): Meeting de kick-off começar no horário
```

**9. Staging Validation Checklist:**
```
□ Credenciais Developer A funcionam (GitHub, Slack, docs)
□ Credenciais Developer B funcionam (GitHub, Slack, docs)
□ Engineering Manager consegue ver time no projeto
□ Product Manager aprova timeline por escrito
□ Sala de reunião/Zoom booked + convite enviado
□ Agenda de kick-off preparada
□ Links de documentação compartilhados no Slack
```

**10. Rollback Plan (Se Developer Indisponível):**
```
Se Developer A indisponível:
  1. Escalar para Engineering Manager (mesmo dia)
  2. Encontrar developer substituto (24h)
  3. Atrasar Sprint 1.1 por 1 semana se necessário
  4. Atualizar timeline + reagendar kick-off

Se Developer B indisponível:
  1. Mesmo processo de escalação
  2. CRÍTICO: Dev B lidera Story 1.2 (CSS Caching — bloqueador)
  3. Atrasar preferível não > 3 dias
```

---

## 🔧 STEP 2: VALIDAÇÃO DE AMBIENTE FTP + GITHUB (18-21 Março)

### AIOX 10/10 Task: Validar Acesso FTP + GitHub Actions

**1. Task ID + Title:**
```
W0-NUVEMSHOP-002 — Validação de Ambiente (FTP Real + GitHub CI/CD)
```

**2. Owner Responsibility:**
- **DevOps / Engineering Manager** — coordenar
- **QA Lead** — testar acessos
- **Developer A/B** — verificar acesso GitHub
- **Orion** — executar validações técnicas

**3. Objective:**
```
Como DevOps,
Quero validar toda a infraestrutura de desenvolvimento/produção,
Para garantir que developers consigam fazer deploy sem blockers de ambiente.
```

**4. Acceptance Criteria:**

**FTP Access (Nuvemshop Real):**
```
□ Credenciais FTP testadas: ftp.nuvemshop.com.br
□ Upload testado (arquivo pequeno)
□ Download testado (arquivo pequeno)
□ Backup script automático (ou plano manual documentado)
□ Procedimento rollback testado (restaurar via FTP)
□ Cache clear strategy documentada
```

**GitHub Actions:**
```
□ Workflows CI/CD existem (.github/workflows/)
□ npm lint workflow passa
□ npm typecheck workflow passa
□ npm test workflow configurado
□ Todos os workflows disparam com sucesso
```

**Development Local (Ambas as máquinas):**
```
□ Node.js 18+ instalado (`node --version`)
□ npm dependencies: `npm install` completa
□ npm run lint — sem erros
□ npm run typecheck — sem erros
□ npm test — pronto (Story 1.3 configura Jest)
```

**5. Definition of Done:**
```
✅ Acesso FTP completamente funcional (produção)
✅ Credenciais FTP verificadas (upload + download)
✅ GitHub Actions todos verdes
✅ Setup dev testado em ambas as máquinas
✅ Procedimento rollback testado
✅ Estratégia de backup documentada
✅ Credenciais seguras (sem logging)
✅ Checklist de ambiente assinado
```

**6. Dependencies:**
```
Deve completar após: Step 1 (Team Confirmation)
```

**7. Risk Assessment:**
```
🔴 RISCO: Credenciais FTP expiradas
   → Mitigação: Verificar com Nuvemshop support
   → Timeline: Fazer HOJE (não segunda)

🟡 RISCO: Workflows CI/CD precisam config
   → Mitigação: Pré-configurar antes Sprint 1.1
   → Timeline: Sábado se necessário

🟢 BAIXO RISCO: Versão Node mismatch
   → Mitigação: Verificar .nvmrc ou package.json engines
```

**8. Validation Gates:**
```
Gate 1 (Hoje 15:00): FTP upload/download bem-sucedido
Gate 2 (Amanhã 10:00): GitHub Actions todos verdes (3 workflows)
Gate 3 (Amanhã 14:00): npm install + lint + typecheck funcionam
Gate 4 (Quarta 16:00): Procedimento rollback testado
```

**9. Staging Validation Checklist:**
```
□ Credenciais FTP funcionam na máquina de Dev A
□ Credenciais FTP funcionam na máquina de Dev B
□ GitHub Actions podem ser disparados manualmente
□ npm lint não tem erros
□ npm typecheck não tem erros
□ Backup script documentado e testado
□ Rollback strategy documentado e testado
□ Nenhum erro de console em npm start (local)
```

**10. Rollback Plan (Se Ambiente Falhar):**
```
Se credenciais FTP falharem:
  1. Solicitar novas credenciais Nuvemshop (urgente)
  2. Atrasar Sprint 1.1 por 2-3 dias se necessário
  3. Usar método deploy alternativo se disponível

Se GitHub Actions falhar:
  1. Configurar manualmente ou usar testes locais
  2. DevOps corrige CI/CD antes Story 1.3 (Unit Tests)
  3. Prioridade: Média (pode fazer deploy manual se necessário)

Se Node version mismatch:
  1. Instalar versão correta (.nvmrc)
  2. Limpar node_modules + reinstalar
  3. Re-testar todos os workflows
```

---

## 📊 STEP 3: CAPTURA DE BASELINE METRICS (21-22 Março)

### AIOX 10/10 Task: Capturar Baseline Metrics (WCAG, Lighthouse, Tests)

**1. Task ID + Title:**
```
W0-NUVEMSHOP-003 — Capturar Baseline Metrics (WCAG + Lighthouse + Testes)
```

**2. Owner Responsibility:**
- **QA Lead** — responsável principal
- **Developer A/B** — assistir com métricas técnicas
- **Product Manager** — validar itens críticos
- **Orion** — executar auditorias automatizadas

**3. Objective:**
```
Como QA,
Quero capturar baseline de métricas antes de qualquer mudança,
Para medir melhoria após Phase 1 e validar progresso.
```

**4. Acceptance Criteria:**

**WCAG Compliance Baseline (Loja ATIVA via FTP):**
```
□ Auditoria axe na homepage
□ Auditoria axe na página de produto
□ Auditoria axe na página de checkout
□ Documentar violações por página
□ Target Phase 1: 0 violações (WCAG AA)
```

**Lighthouse Baseline (Mobile - Loja ATIVA):**
```
□ Lighthouse na homepage
□ Lighthouse na página de produto
□ Lighthouse na página de checkout
□ Capturar: Performance, Accessibility, SEO, Best Practices
□ Capturar: LCP, FCP, CLS metrics
□ Target Phase 3: Performance 85+, Accessibility 90+, SEO 90+
```

**Test Coverage Baseline:**
```
□ Contagem de testes atual: _____
□ Cobertura atual: _____ %
□ Frameworks de teste identificados
□ Target Phase 1: 60% coverage (após Story 1.3)
```

**Performance Baseline:**
```
□ LCP (Largest Contentful Paint): _____ s
□ FCP (First Contentful Paint): _____ s
□ CLS (Cumulative Layout Shift): _____
□ Tamanho total de página: _____ MB
□ Target Phase 3: <2.5s, <1.5s, <0.1
```

**Bundle Size Baseline:**
```
□ CSS total: _____ KB
□ JS total: _____ KB
□ Images total: _____ MB
□ Target Phase 3: -50% image size (WebP)
```

**5. Definition of Done:**
```
✅ Todas as 3 páginas auditadas com axe
✅ Relatórios Lighthouse para 3 páginas capturados
✅ Baseline de testes documentado (count + coverage)
✅ Métricas de performance documentadas (LCP, FCP, CLS)
✅ Análise de bundle size completa
✅ Relatório baseline criado: `Docs/execution/BASELINE-METRICS-2026-03-22.md`
✅ Relatório assinado por QA Lead + PM
```

**6. Dependencies:**
```
Deve completar após: Step 2 (Environment Validation)
```

**7. Risk Assessment:**
```
🟡 RISCO: Muitas violações WCAG para corrigir
   → Não é bloqueador — Story 1.1 adiciona focus indicators
   → Validação: Confirmar Phase 1 pode alcançar WCAG AA

🟡 RISCO: Scores Lighthouse muito baixos
   → Não é bloqueador — Phase 3 foca em otimização
   → Validação: Confirmar Phase 3 pode atingir 85+

🟢 BAIXO RISCO: Cobertura de testes 0%
   → Esperado — Story 1.3 adiciona Jest setup
   → Sem ação necessária
```

**8. Validation Gates:**
```
Gate 1 (Sábado 12:00): Auditorias axe completas (3 páginas)
Gate 2 (Sábado 13:00): Relatórios Lighthouse capturados + downloaded
Gate 3 (Sábado 14:00): Baseline de testes documentado
Gate 4 (Sábado 15:00): Métricas de performance registradas
Gate 5 (Sábado 16:00): Relatório baseline assinado
```

**9. Staging Validation Checklist:**
```
□ Executar axe na loja ATIVA (produção)
□ Exportar resultados axe como JSON
□ Screenshot Lighthouse
□ Download relatórios Lighthouse JSON
□ Documentar warnings temporários (se houver)
□ Comparar métricas loja ativa vs documentação anterior
□ Verificar métricas reproduzíveis (rodar 2x, comparar)
```

**10. Rollback Plan (Se Não Conseguir Capturar):**
```
Se ferramenta axe falhar:
  1. Usar checklist manual de acessibilidade
  2. Documentar achados em spreadsheet
  3. Continuar sem baseline

Se Lighthouse falha:
  1. Rodar lighthouse CLI localmente
  2. Capturar múltiplas execuções (média)
  3. Documentar em arquivo markdown

Se não conseguir medir testes atuais:
  1. Assumir cobertura 0%
  2. Estimar contagem de linhas de código
  3. Continuar (Story 1.3 adiciona métricas)

Resultado: Continuar com ou sem baseline
Ação: Prosseguir para Step 4 (Preparação do Kick-off)
```

---

## 🎤 STEP 4: PREPARAÇÃO DE KICK-OFF MEETING (22-23 Março)

### AIOX 10/10 Task: Preparar Meeting de Kick-off

**1. Task ID + Title:**
```
W0-NUVEMSHOP-004 — Preparar Meeting de Kick-off (Agenda + Materiais)
```

**2. Owner Responsibility:**
- **Project Manager** — organizar meeting
- **Engineering Manager** — facilitar discussão
- **Developer A/B** — participar + fazer perguntas
- **Orion** — preparar materiais

**3. Objective:**
```
Como time,
Quero preparar e alinhar no kick-off Sprint 1.1,
Para garantir que todos entendem expectativas e começamos com clareza.
```

**4. Acceptance Criteria:**

**Meeting Logistics:**
```
□ Sala booked (presencial ou Zoom)
□ Data: Segunda 24 de Março de 2026
□ Hora: 10:00 AM até 11:00 AM (1 hora)
□ Todos 5 membros do time convidados (Dev A, Dev B, QA, PM, EM)
□ Agenda compartilhada 24h antes
```

**Meeting Materials:**
```
□ Cópias impressas ou links compartilhados:
  □ README de Sprint Plan (5 min read)
  □ SPRINT-PLAN-AIOX-10-10.md (Stories 1.1, 1.2, 1.3)
  □ NUVEMSHOP-IMPLEMENTATION-DECISIONS.md
  □ SPRINT-PLAN-DEPENDENCIES.md
  □ SPRINT-PLAN-ROLLBACK-PROCEDURES.md
```

**Meeting Agenda (60 min):**
```
□ 0-5 min: Welcome + intro TDB-2026-001 (PM)
□ 5-10 min: Workflow overview (EM)
  □ 10-phase brownfield discovery
  □ 4-phase implementation (8 semanas)
  □ AIOX 10/10 standard
□ 10-20 min: Sprint 1.1 Stories (PM + Dev A/B)
  □ Story 1.1: Indicadores de Foco (Dev A owner)
  □ Story 1.2: CSS Caching (Dev B owner — bloqueia 1.3)
  □ Story 1.3: Unit Tests (Ambos devs)
□ 20-30 min: AC + FTP Deploy Process (QA + Devs)
  □ O que significa "done"
  □ Processo de deploy FTP
  □ Backup incremental obrigatório
  □ Validação em produção
□ 30-40 min: Nuvemshop Safety + Rollback (EM + DevOps)
  □ Zero breaking changes garantido
  □ Procedimentos rollback (< 2 min)
  □ Cenários de emergência
□ 40-50 min: Daily Workflow (Dev + EM)
  □ Daily standup 09:00 AM
  □ Branch naming: feature/TDB-2026-001.X.X
  □ Processo de code review (2+ eyes)
  □ Processo deploy FTP
□ 50-60 min: Q&A + Próximos Passos (All)
  □ Perguntas?
  □ Começar Story 1.1 imediatamente depois (Dev A)
  □ Primeiro standup: Terça 09:00 AM
```

**5. Definition of Done:**
```
✅ Sala de reunião booked + confirmada
✅ Todos 5 membros confirmam presença
✅ Agenda compartilhada com time
✅ Materiais impressos ou links preparados
✅ Funções de apresentador atribuídas (PM, EM, QA)
✅ Equipamento testado (video, slides, screen sharing)
✅ Plano B se alguém não conseguir ir
✅ Template de meeting notes preparado
✅ Template de action items pós-meeting pronto
```

**6. Dependencies:**
```
Deve completar após: Step 3 (Baseline Metrics)
```

**7. Risk Assessment:**
```
🟡 RISCO: Membro indisponível segunda
   → Mitigação: Gravar meeting, compartilhar gravação

🟡 RISCO: Time desprepa (não leu docs)
   → Mitigação: Fornecer resumo 5-min no meeting

🟢 BAIXO RISCO: Problemas técnicos (Zoom, etc.)
   → Mitigação: Testar equipamento domingo à noite
   → Backup: Telefonema se vídeo falhar
```

**8. Validation Gates:**
```
Gate 1 (Domingo 10:00): Agenda de meeting finalizada
Gate 2 (Domingo 12:00): Materiais preparados + testados
Gate 3 (Domingo 16:00): 5 membros confirmam presença
Gate 4 (Domingo 18:00): Equipamento testado (se virtual)
Gate 5 (Segunda 09:00): Confirmação final de presença
```

**9. Staging Validation Checklist:**
```
□ Agenda é clara e realista (1 hora)
□ Todos docs necessários linkados ou impressos
□ Apresentador consegue falar 5-10 min por seção
□ Detalhes de Story revisados pelos owners
□ Procedimentos rollback revisados por EM/DevOps
□ Sala é quieta + privada
□ Equipamento video/audio funcionando (se remoto)
□ Link chat compartilhado no Slack
□ Alguém atribuído para tomar notas
```

**10. Rollback Plan (Se Meeting Falhar):**
```
Se meeting cancelada:
  1. Reagendar imediatamente para terça
  2. Enviar agenda + docs-chave via Slack
  3. Sync one-on-one com cada dev
  4. Quick standup terça 09:00 AM antes de começar

Se time desprepa:
  1. Gastar mais tempo em Story 1.1 AC + DoD
  2. Demo Story 1.1 do SPRINT-PLAN
  3. Pair program Story 1.2 (Dev B + Dev A)
  4. Comprimir training na primeira semana

Se equipamento falha:
  1. Discar em bridge de telefone
  2. Compartilhar tela via Slack screenshare
  3. Continuar como planejado
```

---

## ✅ WEEK 0 COMPLETION CHECKLIST

**17-18 Março (HOJE):**
- [ ] Step 1: Confirmação de Time (Devs confirmados + PM aprovado)
- [ ] Step 2: Environment Validation iniciada (FTP testado)

**18-21 Março:**
- [ ] Step 2: Environment Validation completa (FTP + GitHub CI/CD OK)
- [ ] Step 3: Baseline Metrics capturada (WCAG + Lighthouse done)

**22-23 Março:**
- [ ] Step 4: Meeting de Kick-off preparada (Agenda + materiais prontos)
- [ ] Final check: Todos os steps Week 0 documentados

**24 Março:**
- [ ] 10:00 AM: Meeting de Kick-off
- [ ] 14:00 PM: Sprint 1.1 oficialmente começa
  - [ ] Dev A começa Story 1.1 (Indicadores de Foco)
  - [ ] Dev B começa Story 1.2 (CSS Caching)
  - [ ] Ambos devs prontos para Story 1.3 (Unit Tests)

---

## 📊 WEEK 0 SIGN-OFF

```
WEEK 0: PRE-SPRINT SETUP (Nuvemshop FTP Real)
Date Range: 17-24 de Março de 2026

Status: 🔄 EXECUTANDO AGORA

□ Confirmação de Time: (aguardando sua confirmação)
□ Validação de Ambiente: (em andamento - Orion)
□ Captura de Baseline Metrics: (aguardando validação FTP)
□ Preparação de Kick-off: (em andamento - Orion)

Próxima Fase: SPRINT 1.1 (24 de Março 14:00)
```

---

## 🎯 PRÓXIMAS AÇÕES

**Você (Agora):**
1. [ ] Confirmar 2 developers (email ou Slack)
2. [ ] Aprovar timeline + assignment de time
3. [ ] Designar Engineering Manager + QA Lead

**Engineering Manager (Hoje-Amanhã):**
1. [ ] Coordenar validação de ambiente
2. [ ] Testar credenciais FTP
3. [ ] Verificar GitHub Actions configurado

**QA Lead (Amanhã-Sábado):**
1. [ ] Rodar auditorias axe (homepage, product, checkout)
2. [ ] Rodar relatórios Lighthouse (mobile)
3. [ ] Documentar baseline metrics

**Project Manager (Sábado-Domingo):**
1. [ ] Preparar agenda de kick-off
2. [ ] Compartilhar materiais com time
3. [ ] Testar equipamento de meeting

**Developers (Segunda 24 de Março):**
1. [ ] Participar de kick-off (10:00 AM)
2. [ ] Fazer perguntas
3. [ ] Começar implementação (14:00 PM)

---

**Status:** 🟢 WEEK 0 PRONTA PARA INICIAR

— Orion, executando workflow brownfield discovery AIOX 10/10 🎯

*AIOX 10/10 Execution Phase — Week 0 Pre-Sprint Setup*
*Nuvemshop FTP Real — Zero Staging Separado*
*Deploy + Backup Incremental + Sua Validação em Produção*
