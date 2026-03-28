# 🎯 MAPEAMENTO CORRETO: Última Versão de Cada Arquivo

**Data:** 2026-03-27
**Período Analisado:** v1.5.166 (bbcf569) → v1.5.200 (52482ea)
**Metodologia:** `git log bbcf569..52482ea -- arquivo` (procurar TODAS as versões que tocaram cada arquivo)

---

## ✅ MAPEAMENTO FINAL: Use Esta Versão!

| # | Arquivo | **ÚLTIMA VERSÃO** | Commit | Descrição da Última Alteração |
|---|---------|-------------------|--------|------------------------------|
| 1 | **VERSION.json** | **v1.5.200** | 52482ea | rollback: restaurar style-async ao estado v1.5.197 |
| 2 | **version-info.js** | **v1.5.200** | 52482ea | rollback: restaurar style-async ao estado v1.5.197 |
| 3 | **layout.tpl** | **v1.5.192** | 8966dd4 | fix(story-11.2): corrigir 3 regressoes - bloco CSS, galeria 6 imgs |
| 4 | **style-critical.tpl** | **v1.5.192** | 8966dd4 | fix(story-11.2): corrigir 3 regressoes - bloco CSS nao fechado |
| 5 | **style-menu-patagang.css.tpl** | **v1.5.192** | 8966dd4 | fix(story-11.2): corrigir 3 regressoes (mesma fix) |
| 6 | **product-page-custom.js** | **v1.5.190** | 46f9f2d | feat: implement Story 11.2 gallery 2x2 desktop with isolated scroll |
| 7 | **whatsapp-left.tpl** | **v1.5.189** | 96cf417 | fix: rebaseline Story 11.1 docs and whatsapp icon behavior |
| 8 | **style-whatsapp-button.css.tpl** | **v1.5.189** | 96cf417 | fix: rebaseline Story 11.1 (mesma fix) |
| 9 | **style-help-sidebar.css.tpl** | **v1.5.188** | ec36aed | feat: Increase button size — Help and WhatsApp standardized |
| 10 | **header-patagang.tpl** | **v1.5.171** | c57a0f7 | fix(header): corrigir dropdown desktop — remover inline style [Story 10.1] |
| 11 | **header-advertising.tpl** | **v1.5.169** | cf72231 | docs: reorganização AIOX (minor docs change) |
| 12 | **style-async.scss.tpl** | **Sem alteração** | — | Nenhuma alteração entre v1.5.166 e v1.5.200 |

---

## 📊 RESUMO POR VERSÃO

### v1.5.200 (Última versão do período)
- ✅ **VERSION.json** — Apenas metadata de versão
- ✅ **version-info.js** — Apenas info de versão

### v1.5.192 (Última fix crítica de Story 11.2)
- 🔴 **layout.tpl** — Fix de 3 regressões (bloco CSS, galeria, botões)
- 🔴 **style-critical.tpl** — Fix de 3 regressões (CSS principal)
- 🟡 **style-menu-patagang.css.tpl** — Fix de 3 regressões (menu)

### v1.5.190 (Story 11.2 initial)
- 🟡 **product-page-custom.js** — Gallery 2x2 + scroll behavior

### v1.5.189 (Story 11.1 refinement)
- 🟡 **whatsapp-left.tpl** — Icon/rotate fix
- 🟡 **style-whatsapp-button.css.tpl** — Button styling

### v1.5.188 (Story 11.1 button size)
- 🟢 **style-help-sidebar.css.tpl** — Button size sync

### v1.5.171 (Story 10.1 dropdown)
- 🟢 **header-patagang.tpl** — Dropdown fix

### v1.5.169 (Docs reorganization)
- 🟢 **header-advertising.tpl** — Minor (docs only)

---

## 🚨 ATENÇÃO: ARQUIVOS COM RISCO ALTO

### 1. **layout.tpl** (v1.5.192)
**O que mudou em v1.5.192:**
- Fix de bloco CSS não fechado (regressão em 11.2)
- Galeria com 6 imagens (ao invés de 4)
- Botões laterais restaurados

**Histórico COMPLETO:**
```
v1.5.192 ← v1.5.190 ← v1.5.189 ← v1.5.188 ← v1.5.187 ← v1.5.186 ← ... ← v1.5.171
```
**Risco:** 🔴 MUITO ALTO — Template mestre, múltiplas alterações

---

### 2. **style-critical.tpl** (v1.5.192)
**O que mudou em v1.5.192:**
- Fix de bloco CSS não fechado
- Gallery grid fixes (grid-auto-rows, grid-template-rows)
- Product grid FOUC fixes (moved from async)
- Multiple media queries (1200px, 992px, 768px)

**Histórico COMPLETO:**
```
v1.5.192 ← v1.5.191 ← v1.5.190 ← v1.5.189 ← v1.5.188 ← v1.5.187 ← ... ← v1.5.170
```
**Risco:** 🔴 MUITO ALTO — CSS crítico, 13+ alterações

---

### 3. **style-menu-patagang.css.tpl** (v1.5.192)
**O que mudou em v1.5.192:**
- Menu fixes (parte da fix de 3 regressões)

**Histórico:**
```
v1.5.192 ← v1.5.171 ← v1.5.170 ← ...
```
**Risco:** 🟡 MÉDIO — Menu CSS, isolado

---

## 🟡 ARQUIVOS COM RISCO MÉDIO

### 4. **product-page-custom.js** (v1.5.190)
**O que mudou em v1.5.190:**
- Gallery 2x2 layout
- Scroll behavior (prioriza galeria antes de próxima seção)

**Risco:** 🟡 MÉDIO — JavaScript novo, mas encapsulado

---

### 5. **whatsapp-left.tpl** (v1.5.189)
**O que mudou em v1.5.189:**
- Icon rebaseline
- Rotate/transform adjustments

**Risco:** 🟡 MÉDIO — Template novo, isolado

---

### 6. **style-whatsapp-button.css.tpl** (v1.5.189)
**O que mudou em v1.5.189:**
- Button styling fixes
- Size standardization with Help button

**Risco:** 🟡 MÉDIO — CSS novo, isolado

---

## 🟢 ARQUIVOS COM RISCO BAIXO

### 7. **style-help-sidebar.css.tpl** (v1.5.188)
**O que mudou em v1.5.188:**
- Button size increase
- Sync com WhatsApp button

**Risco:** 🟢 BAIXO — CSS específico, minor

---

### 8. **header-patagang.tpl** (v1.5.171)
**O que mudou em v1.5.171:**
- Dropdown desktop fix
- Remover inline style que bloqueava `.is-open`

**Risco:** 🟢 BAIXO — Specific fix, isolated

---

### 9. **header-advertising.tpl** (v1.5.169)
**O que mudou em v1.5.169:**
- Apenas documentação/reorganização (muito minor)

**Risco:** 🟢 BAIXO — Mostly docs

---

### 10. **VERSION.json** (v1.5.200)
**O que mudou em v1.5.200:**
- Version string metadata
- Cache busting

**Risco:** ⚪ NENHUM — Apenas config

---

### 11. **version-info.js** (v1.5.200)
**O que mudou em v1.5.200:**
- Version display string

**Risco:** ⚪ NENHUM — Apenas info

---

## ⚠️ ARQUIVO SEM ALTERAÇÃO

### 12. **style-async.scss.tpl**
**Status:** 🟢 **SEM ALTERAÇÃO ENTRE v1.5.166 E v1.5.200**

Nenhuma versão entre 166 e 200 tocou este arquivo!

---

## 🎯 SÍNTESE CRÍTICA

### Para você, Gabriel:

**Versões QUE VOCÊ DEVE USAR como referência:**

| Arquivo | Usar v1.5.X | Motivo |
|---------|-------------|--------|
| layout.tpl | **v1.5.192** | Última fix crítica (Story 11.2) |
| style-critical.tpl | **v1.5.192** | Última fix crítica (Story 11.2) |
| style-menu-patagang.css.tpl | **v1.5.192** | Última fix crítica (Story 11.2) |
| product-page-custom.js | **v1.5.190** | Story 11.2 feature completo |
| whatsapp-left.tpl | **v1.5.189** | Story 11.1 refinement |
| style-whatsapp-button.css.tpl | **v1.5.189** | Story 11.1 refinement |
| style-help-sidebar.css.tpl | **v1.5.188** | Button size sync |
| header-patagang.tpl | **v1.5.171** | Story 10.1 dropdown fix |
| header-advertising.tpl | **v1.5.169** | Minor docs |
| VERSION.json | **v1.5.200** | Latest metadata |
| version-info.js | **v1.5.200** | Latest metadata |
| style-async.scss.tpl | **v1.5.166** | SEM ALTERAÇÃO — Keep current |

---

## ✅ Próximo Passo

**Aguardando sua aprovação para:**

1. ✅ Confirmar que estas são REALMENTE as versões corretas
2. ✅ Proceder com comparação conteúdo de cada arquivo
3. ✅ Aplicar mudanças nesta ordem:
   - Tier 1: v1.5.200 (VERSION.json, version-info.js)
   - Tier 2: v1.5.189-192 (features)
   - Tier 3: v1.5.171-188 (refinements)

**Você autoriza que eu prossiga?** 🔒

---

**Relatório criado com metodologia correta: ÚLTIMA VERSÃO EXATA de cada arquivo, não apenas versões que mudaram entre 166 e 200.**
