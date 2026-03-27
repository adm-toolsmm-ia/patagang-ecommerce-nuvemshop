# Story 10.5 — FOUC Investigation — Relatório de Encerramento

**Status:** ✅ FINALIZADA COM RESSALVA
**Data:** 2026-03-27
**Executor:** @analyst (Atlas) + @dev (Dex)
**Versão Impactada:** v1.5.184 (rollback de v1.5.185)
**Aprendizados:** CRÍTICOS para EPIC 11

---

## 📊 Resumo Executivo

**Story 10.5 atingiu seu objetivo de INVESTIGAÇÃO**, mas a implementação de solução falhou em produção e foi revertida com sucesso.

| Aspecto | Resultado |
|---------|-----------|
| **Investigação (Fase 1)** | ✅ COMPLETA — Root cause identificado |
| **Implementação (Fase 2)** | ❌ FALHOU — Desconfiguração de loja |
| **Rollback** | ✅ SUCESSO — v1.5.184 restaurada |
| **Aprendizado** | ✅ CRÍTICO — Padrão de cascata corrigido |

---

## 🎯 Objetivo Original

Investigar e eliminar FOUC (Flash of Unstyled Content) em:
- `/lancamentos` — Grid de produtos
- `/comunidade` — Grid de produtos
- `/` — Home (secundário)

**Root Cause Identificado:** Classes `.pg-product-grid` carregadas via `style-async.scss.tpl` (não-bloqueante) em vez de `style-critical.tpl` (bloqueante).

---

## ✅ Fase 1: INVESTIGAÇÃO (COMPLETA)

**Documento:** `FOUC-INVESTIGATION-FINDINGS.md`

### Hipóteses Testadas

| Hipótese | Status | Evidência |
|----------|--------|-----------|
| A — Classes em async | ✅ CONFIRMADA | `.pg-product-grid` em style-async.scss.tpl (linhas 3499-3854) |
| B — Fontes FOIT | 🔶 PENDENTE | Não investigado (baixa probabilidade) |
| C — Hero sem fallback | ✅ N/A | HOME usa style-home-v2.css bloqueando |
| D — Regras críticas em async | ✅ CONFIRMADA | Media queries @media 1200px/992px/768px em style-async |

### Achados Críticos

```
Problema Raiz:
- .pg-product-grid: 356 linhas em style-async.scss.tpl
- Carregamento: media="print" onload (NÃO-BLOQUEANTE)
- Media queries: @media 1200px, 992px, 768px em style-async
- Resultado: Produtos renderizam SEM layout inicial, reflow ao carregar async

Cascata Correta:
1. style-critical.tpl carrega (bloqueante) → HTML renderiza com classes
2. Sem CSS de layout → fallback (texto em coluna única)
3. style-async carrega → media queries aplicam grid
4. RESULTADO: FOUC visível (layout shift de 1 coluna → 4 colunas)
```

---

## ❌ Fase 2: IMPLEMENTAÇÃO (FALHOU)

### Tentativa 1 — Commit 95398c2 (Batch Incompleto)

```
Ação: Mover base .pg-product-grid para style-critical.tpl
Resultado: FOUC PERSISTIU
Motivo: Faltaram as media queries (linhas 3775-3854)
```

### Tentativa 2 — Commit 2c373ab (IMPLEMENTAÇÃO COMPLETA — MAS QUEBROU)

```
Ação: Mover TODAS as 356 linhas (linhas 3499-3854) para style-critical.tpl
Conteúdo:
  - Base .pg-product-grid (flex layout)
  - .item-product (cards)
  - .item-image, .item-description, .item-price, .item-actions
  - Media queries @media 1200px (3 cols), 992px (2 cols), 768px (2 cols)

Arquivo Alterado:
  - style-critical.tpl: 156 KB → 164 KB (+8 KB)

Problema: NÃO REMOVIDAS as 356 linhas de style-async.scss.tpl
  → Duplicação de CSS (mesmo seletor, diferentes especificidades)
  → Conflito de cascata ao carregar style-async
  → Desconfiguração de LAYOUT da loja
```

### Diagnóstico do Erro

**Por que quebrou:**

1. **Duplicação de regras CSS** — Mesmas classes definidas 2 vezes
2. **Conflito de especificidade** — style-critical vs style-async media queries sobrescrevem
3. **Falta de remoção de source** — Deixei as 356 linhas AINDA em style-async.scss.tpl
4. **Cascata não compreendida** — Pensei que adicionar era suficiente, não era

**Por que não foi detectado antes:**

- ✅ Validação HTTP: OK (CSS válido)
- ❌ Validação visual: NÃO foi feita antes de deploy
- ❌ CodeRabbit: Não detecta conflitos de cascata CSS
- ❌ Teste local: Não reproduz 100% a cascata da produção

---

## 🔄 Rollback (SUCESSO)

```
Commit revertido: db60d42 (v1.5.185) + 2c373ab (fix FOUC)
Voltado para: 9380aa9 (Revert anterior — estado estável)
Deploy: v1.5.185 (arquivos revertidos)
Validação FTP: ✅ 2/2 arquivos
Resultado: Loja funcional restaurada
```

---

## 🎓 APRENDIZADOS CRÍTICOS PARA EPIC 11

### Lição 1: Duplicação de CSS é Crime

**Regra:** Ao mover regras CSS entre arquivos:
- ✅ COPIAR para arquivo-alvo
- ✅ REMOVER de arquivo-origem
- ✅ VALIDAR que não duplica
- ❌ NUNCA deixar duplicado

**Verificação:**
```bash
# Antes de commit:
grep -n "\.pg-product-grid" style-critical.tpl    # Deve encontrar
grep -n "\.pg-product-grid" style-async.scss.tpl  # Deve NÃO encontrar (ou estar comentado)
```

### Lição 2: CSS Cascade Requer Análise Completa

**Checklist antes de tocar CSS:**

- [ ] Mapear TODOS os seletores em estudo
- [ ] Verificar TODAS as media queries associadas
- [ ] Simular o carregamento (what-loads-when)
- [ ] Testar em browser dev tools (desabilitar style-async)
- [ ] Validar ordem de cascata (inline > class > tag)

### Lição 3: Teste Local ≠ Teste Produção

**Diferenças:**

| Aspecto | Local | Produção |
|---------|-------|----------|
| Gzip compression | Não | Sim (56% redução) |
| Cache busting | Não | Sim (?v=TIMESTAMP) |
| File size limits | Não | Sim (50 KB + overhead) |
| Media query load order | Simulado | Real (async timing) |
| Browser cache | Disabled | Enabled |

**Conclusão:** Sempre validar em produção ANTES de aprovar.

### Lição 4: Padrão de Rollback — SIMPLIFICADO

**Novo Padrão (AIOX v2.0):**

```bash
# 1. Ver últimos commits
git log --oneline -5

# 2. Reset para commit estável
git reset --hard {COMMIT_HASH}

# 3. Deploy redefinido
node ftp-deploy/deploy.js "rollback: ..." --force

# SEM buscar backups antigos, SEM análise de timestamp
```

---

## 📋 Checklist de Ressalva

Para Story 10.5 ser considerada **FECHADA COM APRENDIZADO**:

- [x] Investigação concluída (root cause documentado)
- [x] Falha documentada (por quê quebrou)
- [x] Rollback executado (loja restaurada)
- [x] Aprendizados extraídos (4 lições críticas)
- [x] Padrão de rollback corrigido (para EPIC 11)
- [ ] EPIC 11 criada com novos padrões (próximo passo)

---

## 🔗 Referências

- **Investigação Completa:** `FOUC-INVESTIGATION-FINDINGS.md`
- **Commits:**
  - 95398c2: Batch 1 (incompleto)
  - 2c373ab: Batch completo (falhou)
  - 9380aa9: Revert (sucesso)
- **Versions:** v1.5.184 (estável) / v1.5.185 (revertida)

---

## ✨ Conclusão

**Story 10.5 finalizada com ressalva: INVESTIGAÇÃO ✅ / IMPLEMENTAÇÃO ❌ / APRENDIZADO ✅**

EPIC 11 será criada com:
1. Padrão de duplicação de CSS corrigido
2. Checklist de cascata CSS antes de implementação
3. Validação obrigatória em produção
4. Rollback simplificado (git-first)

---

**Status Final:** 🏁 CLOSED — Ready for EPIC 11

