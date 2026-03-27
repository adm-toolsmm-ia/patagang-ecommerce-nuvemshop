# EPIC 10 — Correções de Validação v1.5.170

**Status:** 🔵 ATIVA
**Criado em:** 2026-03-26
**PM:** @pm (Morgan)
**Versão base:** v1.5.170 (estável, em produção)
**Branch de trabalho:** `fix/epic-10-validation-v1.5.170`
**Tipo:** Brownfield Enhancement — Bug fixes pós-validação

---

## 🎯 Objetivo da EPIC

Corrigir 5 problemas identificados na validação da loja Patagang v1.5.170, priorizando segurança de deploy, zero regressão visual e validação explícita por Gabriel em produção após cada story.

**Valor entregue:**
- Submenus desktop funcionais ("Para humanos" / "Para cachorros")
- Galeria fullscreen com botão fechar operacional no mobile e desktop
- PDP mobile sem espaçamento duplo excessivo no topo
- Botão WhatsApp com identidade visual correta (texto oposto ao "Posso ajudar?")
- Investigação e redução de FOUC nas páginas home, /lancamentos, /comunidade

---

## 📋 Contexto do Sistema Existente

**Stack:** Nuvemshop (Twig/Liquid templates), CSS inline + SCSS compilado, Vanilla JS
**Deploy:** FTP via `node ftp-deploy/deploy.js` — auto-incrementa versão + backup
**Cascade CSS (ordem):** `style-critical.tpl` → `style-colors.scss.tpl` → `style-async.scss.tpl` → override final `layout.tpl`
**Constraint crítica:** Inline styles têm maior especificidade que classes CSS — regra fundamental

**Referências de arquitetura:**
- `Docs/architecture/patagang-ai-operating-context.md` — auditoria obrigatória
- `Docs/architecture/patagang-css-cascade.md` — cascade detalhada
- `.claude/rules/nuvemshop-ftp-constraints.md` — 8/8 constraints de produção
- `.claude/rules/patagang-ftp-production-standard.md` — workflow de deploy

---

## 📂 Stories da EPIC

| Story | Título | Executor | QA | Risco | Status |
|-------|--------|----------|-----|-------|--------|
| 10.1 | Dropdown Desktop — Submenus Para Humanos/Cachorros | @dev | @qa | Baixo | ✅ Done |
| 10.2 | Modal Galeria — Restaurar CSS ausente (close/backdrop/counter) | @dev | @qa | Baixo-Médio | ✅ Done |
| 10.3 | PDP Mobile — Banner informativo não invade header | @dev | @qa | Baixo | ✅ Done |
| 10.4 | WhatsApp — Inverter direção do texto (espelhar botão Help) | @dev | @qa | Baixo | ✅ Done |
| 10.5 | FOUC — Investigar e reduzir flash visual em home/lancamentos/comunidade | @dev + @analyst | @qa | Médio | ⬜ Draft |

---

## 🔄 Workflow por Story (Patagang FTP Standard)

Cada story segue obrigatoriamente:

```
1. @dev: Implementa + commit atômico (git add + git commit)
2. @devops: Deploy FTP (node ftp-deploy/deploy.js "descrição" --force)
            Auto-incrementa versão (ex: v1.5.171, v1.5.172...)
3. Gabriel: Valida em https://patagang.com.br
            Checar: console F12 "PATAGANG vX.X.X" + visual desktop + mobile
4. ✅ APPROVED → @devops: git push + gh pr create (se story finalizada)
   ❌ FAILED    → @dev: corrige → novo deploy → re-validação
```

---

## ✅ Checklist Nuvemshop 8/8 (todas as stories)

| # | Constraint | Verificação |
|---|-----------|-------------|
| 1 | Checkout structure | ✅ Nenhuma story toca checkout |
| 2 | Footer attribution | ✅ Nenhuma story toca footer |
| 3 | Contact form | ✅ Nenhuma story toca formulários |
| 4 | Registration form | ✅ Nenhuma story toca formulários |
| 5 | Newsletter form | ✅ Nenhuma story toca formulários |
| 6 | JavaScript Nuvemshop | ✅ Sem overrides de funções da plataforma |
| 7 | CSS < 50 KB | ✅ Adições mínimas (~15 rules total) |
| 8 | Auto-generated files | ✅ Nenhuma story toca sitemap/robots |

---

## ⚠️ Riscos e Mitigações

| Risco | Probabilidade | Impacto | Mitigação |
|-------|--------------|---------|-----------|
| Dropdown z-index em conflito com modal | Baixa | Alto | Verificar z-index antes de commit |
| Modal CSS quebra overlay do carrinho | Baixa | Médio | Testar abertura do carrinho após deploy |
| FOUC piora ao mover CSS (Story 10.5) | Média | Médio | Commit separado + rollback rápido |
| Espaço mobile insuficiente após fix (Story 10.3) | Baixa | Baixo | Medir header real em mobile antes de aplicar |

**Rollback:** `node ftp-deploy/rollback-incremental.js --version vX.X.X-1`

---

## 📊 Definition of Done (EPIC)

- [ ] Todas as 5 stories com status DONE
- [ ] Gabriel validou cada story em produção
- [ ] Zero regressão visual nas páginas não-alvo
- [ ] `patagang-css-patterns.yaml` e `patagang-learned-patterns.yaml` atualizados
- [ ] Branch `fix/epic-10-validation-v1.5.170` mergeado em `main`
- [ ] Versão final commitada e tagueada

---

**Responsável AIOX:** @pm (Morgan)
**Handoff para stories:** @sm (River) — criar stories individuais
**Handoff para validação:** @po (Pax) — aprovar cada story
**Implementação:** @dev (Dex) — branch `fix/epic-10-validation-v1.5.170`
**QA:** @qa (Quinn) — gate após cada implementação
**Deploy + Push:** @devops (Gage) — exclusivo FTP deploy e git push
