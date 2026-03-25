# 🎯 Story 8.3 — Execução Multifase Segura (AIOX 10/10)

**Data:** 2026-03-25
**Status:** 🔄 IN PROGRESS (PHASE B Complete, PHASE C Ready)
**Contexto:** AIOX 10/10 documentation + 182 snipplets mapeados
**Risk Level:** 🟢 BAIXO (com documentação enriquecida)

---

## 📊 Estado Atual

| Fase | Arquivo | Total | Removidas | Pendentes | Versão | Status |
|------|---------|-------|-----------|-----------|--------|--------|
| **PHASE B** | style-menu-patagang.css.tpl | 85 | 77 | 0 | v1.5.58 | ✅ DONE |
| **PHASE B** | style-filters-patagang.css.tpl | 28 | 0 | 28 | — | 📋 TODO |
| **PHASE C** | style-async.scss.tpl | 426 | 0 | 426 | — | 📋 TODO |
| **PHASE A** | style-critical.tpl | 525 | 2 | 523 | v1.5.65 | 🔴 STALLED |
| **PHASE A** | style-blog.scss.tpl | 3 | 0 | 3 | — | 📋 TODO |
| **TOTAL** | — | **1,067** | **79** | **980** | — | 🔄 6% COMPLETE |

---

## 🚀 Plano de Execução Segura (Multifase)

### FASE B: Continuação (28 !important)

**Arquivo:** `style-filters-patagang.css.tpl` (28 !important)

**Passo 1: Análise**
```bash
# Verificar estrutura
grep -n "!important" theme-deploy-corrigido/static/css/style-filters-patagang.css.tpl | wc -l
# Esperado: 28 ocorrências

# Ver contexto (primeiras 10)
grep -n "!important" theme-deploy-corrigido/static/css/style-filters-patagang.css.tpl | head -10
```

**Passo 2: Refatoração**
- Aplicar padrão de cascata (igual ao que funcionou em style-menu-patagang.css.tpl)
- Aumentar especificidade com seletores em cascata
- Testar após cada remoção (máximo 5 por vez)

**Passo 3: Validação**
- Deploy v1.5.97
- Gabriel valida em produção (visual + console)
- Se OK: marca como completo, prossegue para PHASE C
- Se problema: rollback, investigar, novo deploy

**Passo 4: Commit & Deploy**
```bash
git add theme-deploy-corrigido/static/css/style-filters-patagang.css.tpl
git commit -m "refactor: remove 28 !important from style-filters-patagang.css.tpl [Story 8.3 PHASE B]"
node ftp-deploy/deploy.js "v1.5.97: Story 8.3 PHASE B - Remove 28 !important from filters CSS" --force
```

---

### FASE C: Maior Arquivo Crítico (426 !important)

**Arquivo:** `style-async.scss.tpl` (426 !important) — **CRÍTICO**

**Estratégia:** Sub-dividir em 3 versões (não fazer tudo de uma vez)

**Sub-PHASE C1:** !important 1-150 → v1.5.98
**Sub-PHASE C2:** !important 151-300 → v1.5.99
**Sub-PHASE C3:** !important 301-426 → v1.6.0

**Razão:** Arquivo grande, muitas dependências — menor risco em partes menores

**Cada sub-fase:**
```
1. Grep para encontrar !important naquela faixa
2. Refatorar com cascata (aprendizado de PHASE B)
3. Deploy incremental
4. Gabriel valida
5. Se OK: commit + prossegue
6. Se problema: rollback, investigar raiz
```

---

### FASE A: Finalização (526 !important)

**Arquivos:**
1. `style-critical.tpl` (523 ainda pendentes)
2. `style-blog.scss.tpl` (3 pendentes)

**Estratégia:**
- style-blog.scss.tpl primeiro (3 = simples, build confidence)
- Depois style-critical.tpl em 2-3 versões

---

## 🛡️ Segurança Garantida

### Por que esta execução é SEGURA:

| Aspecto | Proteção | Status |
|---------|----------|--------|
| **Documentação** | AIOX 10/10 (182 snipplets) | ✅ Completa |
| **Técnica Validada** | PHASE B provou cascata funciona | ✅ Comprovada |
| **Incremental** | Cada arquivo = 1 deploy, 1 validação | ✅ Segura |
| **Rollback** | Cada versão tem backup + rollback script | ✅ Disponível |
| **Autonomia** | Executo, Gabriel valida em produção | ✅ Claro |
| **Nuvemshop Constraints** | 8 constraints validados em v1.5.58 | ✅ Passadas |

---

## 🎯 Próximos Passos Recomendados

**DEPOIS QUE GABRIEL VALIDA STORY 8.5:**

1. **Iniciar PHASE B continuação** (style-filters-patagang.css.tpl)
   - Deploy v1.5.97
   - Gabriel valida
   - Se OK: commit

2. **Depois PHASE C** (style-async.scss.tpl em 3 sub-fases)
   - Sub-PHASE C1: v1.5.98
   - Sub-PHASE C2: v1.5.99
   - Sub-PHASE C3: v1.6.0
   - Gabriel valida cada uma

3. **Finalizar PHASE A** (style-blog + style-critical)
   - v1.6.1, v1.6.2, etc.

---

## 📋 Checklist de Execução

**Quando iniciar PHASE B continuação:**

```
PRÉ-EXECUÇÃO:
[ ] Ler arquivo completo style-filters-patagang.css.tpl
[ ] Entender estrutura de seletores
[ ] Planejar estratégia de refatoração
[ ] Criar backup local (cp filename filename.backup-2026-03-25)

DURANTE EXECUÇÃO:
[ ] Remover !important em grupos pequenos (5 por vez)
[ ] Aumentar especificidade com cascata
[ ] Testar visualmente após cada grupo
[ ] Commit após cada arquivo completo

DEPLOY:
[ ] git add + commit com mensagem clara
[ ] node ftp-deploy/deploy.js "v1.5.xx: ..."
[ ] Verificar: Deploy logs OK?

VALIDAÇÃO:
[ ] Gabriel testa em produção
[ ] Console F12: Zero erros?
[ ] Visual: Idêntico vs v1.5.96?
[ ] Breakpoints: Mobile/Tablet/Desktop OK?

PÓS-VALIDAÇÃO:
[ ] Gabriel confirma → APPROVED
[ ] Documenta resultado em story
[ ] Prossegue próxima fase
```

---

## 🎓 Aprendizados de PHASE B para Aplicar

1. **Cascata funciona** — aumentar especificidade com seletores aninhados
2. **Não quebra layout** — confirmado em v1.5.58 validação
3. **Técnica padrão** — `.container .element` em vez de `.element !important`
4. **Incremental é seguro** — cada arquivo = 1 deploy completo
5. **Gabriel validação em produção** — é a confirmação final

---

## 🚀 Status Final

**Pronto para AUTONOMIA SEGURA:**
- ✅ Plano claro (5 etapas)
- ✅ Técnica comprovada (PHASE B)
- ✅ Documentação completa (AIOX 10/10)
- ✅ Rollback sempre disponível
- ✅ Gabriel validação em produção = aprovação final

**Tempo estimado:** 3-4 horas para completar (5 fases)
**Risco:** BAIXO (incrementalidade + documentação)
**Autonomia:** TOTAL (sem bloqueios)

---

**Aguardando validação de Gabriel em Story 8.5 para iniciar PHASE B continuação de Story 8.3! 🚀**

— Orion, pronto para execução segura e autônoma
