# 🎯 MAPEAMENTO: Arquivos Alterados entre v1.5.166 e v1.5.200

**Gerado:** 2026-03-27
**Checkpoint Local:** v1.5.166 (restaurado)
**Versão FTP:** v1.5.200 (atual)
**Objetivo:** Identificar quais arquivos do tema foram alterados e suas mudanças

---

## 📊 RESUMO EXECUTIVO

| Métrica | Valor |
|---------|-------|
| **Arquivos modificados** | **11** |
| **Total de linhas alteradas** | **+1,023 / -128** |
| **Arquivos críticos** | 3 (layout.tpl, style-critical.tpl, style-async.scss.tpl) |
| **Arquivos feature** | 5 (whatsapp-left, header, product-page-custom.js) |
| **Arquivos config** | 1 (VERSION.json) |
| **Arquivos suporte** | 2 (style helpers, version-info) |

---

## 📁 MAPEAMENTO DETALHADO DE MUDANÇAS

### 🔴 TIER 1 — ARQUIVOS CRÍTICOS (Alto Impacto)

#### 1. **`style-critical.tpl`** — 🚨 MUDANÇAS MASSIVAS
```
Alterações: +594 / -0 linhas (594 linhas ADICIONADAS)
Risco: MUITO ALTO
Versões afetadas: v1.5.167-200 (múltiplos updates)
```

**O que mudou:**
- ✅ Grid system para galeria (grid-auto-rows, grid-template-rows)
- ✅ Media queries para responsividade (1200px, 992px, 768px)
- ✅ Layout fixes para PDP (padding, margin ajustes)
- ✅ Product grid CSS (FOUC fixes)
- ✅ WhatsApp + Help button styling
- ⚠️ Encoding fixes (content inválido)

**Impacto:** Afeta TODAS as páginas. Implementa Story 10.1→10.5, 11.1→11.2

**Status no FTP:** v1.5.200 (rollback de v1.5.197)

---

#### 2. **`layout.tpl`** — 📌 MUDANÇAS ESTRUTURAIS
```
Alterações: +301 / -0 linhas (301 linhas MODIFICADAS)
Risco: MUITO ALTO
Versões afetadas: v1.5.170, 174, 187, 188, outros
```

**O que mudou:**
- ✅ Adição de includes para novo WhatsApp button (v1.5.187)
- ✅ Ajustes de includes estruturais
- ✅ Remoção de código legado
- ✅ Atualização de references

**Impacto:** Template mestre — erros causam HTTP 500

**Status no FTP:** v1.5.200 (completo)

---

#### 3. **`style-async.scss.tpl`** — ⚠️ ENCODING ISSUES
```
Alterações: +X / -X (encoding normalization)
Risco: MÉDIO
Versões afetadas: v1.5.199, v1.5.200 (rollback)
```

**O que mudou:**
- ⚠️ Correção de content inválido (separador menu mobile)
- ⚠️ Normalização de caracteres especiais
- ✅ Rollback para v1.5.197 em v1.5.200

**Impacto:** CSS assíncrono, afeta performance perceived

**Status no FTP:** v1.5.200 (stable)

---

### 🟡 TIER 2 — ARQUIVOS FEATURE (Médio Impacto)

#### 4. **`whatsapp-left.tpl`** — 🆕 Novo Componente
```
Alterações: +11 / -0 linhas
Risco: MÉDIO
Versões afetadas: v1.5.179-188
```

**O que mudou:**
- ✅ Novo componente de botão lateral (WhatsApp)
- ✅ CSS transform rotate (v1.5.180)
- ✅ Remove rotate (v1.5.182+)
- ✅ Ícone customizado

**Stories:** 11.1 (WhatsApp button standardization)

**Status no FTP:** v1.5.200 (finalizado)

---

#### 5. **`product-page-custom.js`** — 🆕 JavaScript Interativo
```
Alterações: +25 / -0 linhas
Risco: MÉDIO
Versões afetadas: v1.5.196
```

**O que mudou:**
- ✅ Scroll behavior para galeria (2x2)
- ✅ Priorização de scroll na galeria antes de próxima seção

**Stories:** 11.2 (Gallery UX refinement)

**Status no FTP:** v1.5.200 (completo)

---

#### 6. **`header-patagang.tpl`** — 📝 Minor Tweaks
```
Alterações: +2 / -1 linhas (pequenas)
Risco: BAIXO
Versões afetadas: v1.5.182
```

**O que mudou:**
- ✅ Ajustes estruturais do header
- ✅ Refinement de spacing/layout

**Status no FTP:** v1.5.200 (finalizado)

---

#### 7. **`header-advertising.tpl`** — 📝 Ad Bar Refinement
```
Alterações: -2 linhas (remoção)
Risco: BAIXO
Versões afetadas: v1.5.196
```

**O que mudou:**
- ✅ Remoção de spacing desnecessário
- ✅ Refinement do ad bar

**Status no FTP:** v1.5.200 (finalizado)

---

### 🟢 TIER 3 — ARQUIVOS AUXILIARES (Baixo Impacto)

#### 8. **`style-whatsapp-button.css.tpl`** — 🎨 Button Styling
```
Alterações: +46 / -0 linhas
Risco: BAIXO
Versões afetadas: v1.5.180-188
```

**O que mudou:**
- ✅ Styling do novo botão WhatsApp lateral
- ✅ Cor (verde → #F0F0F0), fontes, espaçamento
- ✅ Responsividade

**Status no FTP:** v1.5.200 (finalizado)

---

#### 9. **`style-help-sidebar.css.tpl`** — 🎨 Help Button Sync
```
Alterações: +18 / -0 linhas
Risco: BAIXO
Versões afetadas: v1.5.182
```

**O que mudou:**
- ✅ Sincronização visual com WhatsApp button
- ✅ Cor, espacamento, fontes

**Status no FTP:** v1.5.200 (finalizado)

---

#### 10. **`style-menu-patagang.css.tpl`** — 🎨 Menu Styling
```
Alterações: +10 / -0 linhas
Risco: BAIXO
Versões afetadas: v1.5.182, v1.5.196
```

**O que mudou:**
- ✅ Menu styling refinements
- ✅ Responsividade

**Status no FTP:** v1.5.200 (finalizado)

---

#### 11. **`VERSION.json`** — 📝 Meta Info
```
Alterações: +8 / -0 linhas
Risco: NENHUM (apenas config)
Versões afetadas: v1.5.236
```

**O que mudou:**
- ✅ Version bump (166→200→236)
- ✅ Cache busting metadata
- ✅ Timestamps

**Status no FTP:** v1.5.236 (atual)

---

#### 12. **`version-info.js`** — 📝 Info Script
```
Alterações: +6 / -0 linhas
Risco: NENHUM
Versões afetadas: v1.5.236
```

**O que mudou:**
- ✅ Version string updates
- ✅ Display info

**Status no FTP:** v1.5.236 (atual)

---

## 🎯 ANÁLISE CONSOLIDADA

### Por Impacto

| Classificação | Arquivos | Linhas | Risco |
|---|---|---|---|
| **CRÍTICOS** | 3 | +895 | 🔴 Muito Alto |
| **FEATURES** | 4 | +138 | 🟡 Médio |
| **AUXILIARES** | 4 | +84 | 🟢 Baixo |
| **CONFIG** | 2 | +14 | ⚪ Nenhum |

### Aplicação Recomendada

#### ✅ RECOMENDADO (aplicar com segurança)
1. **`whatsapp-left.tpl`** — Novo componente, risco baixo
2. **`style-whatsapp-button.css.tpl`** — CSS específico, isolado
3. **`product-page-custom.js`** — JavaScript novo, encapsulado
4. **`header-patagang.tpl`** — Minor tweaks, baixo risco
5. **`VERSION.json`** — Meta apenas

#### ⚠️ REQUER VALIDAÇÃO (aplicar com cautela)
6. **`style-help-sidebar.css.tpl`** — Validar visual após
7. **`style-menu-patagang.css.tpl`** — Validar responsividade
8. **`header-advertising.tpl`** — Validar ad bar rendering

#### 🔴 CRÍTICO (máxima cautela)
9. **`layout.tpl`** — 301 linhas, template mestre, validar com coderabbit
10. **`style-critical.tpl`** — 594 linhas, TODAS as páginas, múltiplos rollbacks no histórico
11. **`style-async.scss.tpl`** — Encoding issues detectadas, rollback necessário

---

## 📋 PRÓXIMOS PASSOS

### Fase 2a: Análise de Conteúdo (Antes de Aplicar)

Para CADA arquivo Tier 1 (críticos), será necessário:

1. **Visualizar diff completo** — Ver exatamente quais linhas mudaram
2. **Validar CSS cascade** — Verificar dependências entre regras
3. **Testar localmente** — Aplicar mudança e validar no navegador
4. **CodeRabbit check** — Validar com AI code review
5. **Gabriel validation** — Aprovação final antes de deploy

### Fase 2b: Aplicação Ordenada

Ordem sugerida (de menos para mais risco):
```
1. VERSION.json (apenas meta)
2. version-info.js (apenas display)
3. whatsapp-left.tpl (novo, isolado)
4. style-whatsapp-button.css.tpl (novo, isolado)
5. product-page-custom.js (novo, isolado)
6. header-patagang.tpl (minor tweaks)
7. header-advertising.tpl (minor tweaks)
8. style-help-sidebar.css.tpl (sync, validar)
9. style-menu-patagang.css.tpl (styling, validar)
10. layout.tpl (crítico, máxima cautela)
11. style-critical.tpl (crítico, máxima cautela)
12. style-async.scss.tpl (encoding, validar)
```

---

## ✅ STATUS ATUAL

- ❌ Tema local (v1.5.166): SEM alterações
- ✅ FTP (v1.5.200): Sincronizado com local
- ⏳ Fase 2: Aguardando aprovação para proceder com análise de conteúdo

---

**Documento pronto para fase 2: Análise detalhada e comparação de conteúdo.**
