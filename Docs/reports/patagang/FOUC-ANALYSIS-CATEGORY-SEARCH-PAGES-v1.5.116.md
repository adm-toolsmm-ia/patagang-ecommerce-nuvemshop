# 🔍 FOUC & Layout Shift Analysis — Category & Search Pages

**Data:** 2026-03-25
**Versão Analisada:** v1.5.116
**Identificado por:** Gabriel Cristofolini (CTO)
**Sintoma:** "Página carrega algo, logo muda pra página normal"
**Status:** Investigação Recomendada
**Prioridade:** ALTA (Performance/UX issue)

---

## 🎯 **Resumo Executivo**

Ao validar v1.5.116, Gabriel notou **carregamento visual diferente** em páginas de categoria e pesquisa:

```
Sintoma: Página carrega → mostra layout temporário → muda para normal
URLs afetadas:
- https://www.patagang.com.br/lancamentos/
- https://www.patagang.com.br/search/?q=Passeio
```

**Possíveis causas:**
1. **FOUC (Flash of Unstyled Content)** — CSS assíncrono carregando tarde
2. **CLS (Cumulative Layout Shift)** — Elementos reposicionando durante load
3. **Layout diferente** — Template renderizando antes de JS/CSS aplicarem estilos
4. **Estrutura HTML dupla** — Múltiplas versões de grid/layout

---

## 📊 **Diagnóstico Preliminar**

### **O que pode estar acontecendo:**

```
Timeline de Carregamento:

1. HTML renderiza (estrutura base)
   └─ Browser começa a renderizar com fallback CSS (Bootstrap classes)

2. CSS Crítico carrega
   └─ Layout recebe estilos iniciais (pode ser incompleto)

3. CSS Assíncrono carrega (media="print" onload)
   └─ Styles adicionais aplicados
   └─ Layout MUDA (CLS detectado) ← AQUI Gabriel vê a mudança

4. JavaScript aplica comportamento
   └─ Filtros, sorting, eventos ligados
   └─ Página "estabiliza"

Result: Página "pisca" durante carregamento
```

---

## 🔧 **Estruturas Envolvidas**

### **Páginas Afetadas:**

| Página | Template | Arquivo |
|--------|----------|---------|
| `/lancamentos/` | Category | `category.tpl` |
| `/search/?q=X` | Search | `search.tpl` |
| `/colecoes/` | Maybe | `collection.tpl` |

### **Componentes Críticos:**

```
Galeria de Produtos (Grid)
├─ layout.tpl (CSS inline)
├─ style-critical.tpl (CSS crítico)
├─ style-async.scss.tpl (CSS assíncrono) ← STORY 8.2 modificou
└─ Bootstrap grid/flexbox fallback

Filtros & Controles
├─ Movidos para style-async (v1.5.116) ← Pode estar causando delay
├─ Requerem JS para funcionar
└─ Se CSS chegar tarde = layout muda

Paginação
├─ Pode estar em CSS assíncrono
└─ Se reposicionar = CLS
```

---

## 🎯 **Hipóteses de Investigação**

### **Hipótese 1: CSS Assíncrono Carregando Tarde**
```
Evidência:
- v1.5.116 moveu 420 linhas de Filters CSS para style-async
- style-async carrega via media="print" onload (deferred)
- Se layout dos filtros/controles mudar = CLS visível

Teste:
1. Open DevTools → Performance tab
2. Record page load
3. Look for layout shifts (CLS metric)
4. Check quando style-async carrega (timeline)
```

### **Hipótese 2: Bootstrap Classes vs Patagang CSS**
```
Possível estrutura:
<div class="row g-0">  ← Bootstrap (12-col grid)
  <div class="col-lg-3">Filters</div>
  <div class="col-lg-9">Products</div>
</div>

Problema:
- Bootstrap inicialmente aplica: col-lg-3 = 25%, col-lg-9 = 75%
- Patagang CSS depois sobrescreve com custom widths
- = Layout muda quando CSS customizado carrega
```

### **Hipótese 3: JS Renderizando Conteúdo**
```
Se há JavaScript:
- Injetar produtos dinamicamente
- Aplicar filtros/sorting
- Renderizar componentes React/Vue

Problema:
- Layout renderizado por JS pode deslocar conteúdo
- Causa CLS perceptível ao usuário
```

### **Hipótese 4: Media Queries Diferentes**
```
Possível problema:
- layout.tpl define layout desktop (flex: 60%/40%)
- style-critical tem media queries (por breakpoint)
- style-async tem media queries DIFERENTES
- Durante mobile/tablet, estilos conflitam
```

---

## 🔍 **O que Gabriel Está Vendo**

**Descrição visual:**
> "mesmo rápido ela carrega algo e logo muda pra página normal"

**Interpretação técnica:**
- Página renderiza **inicial layout** (fallback)
- Depois **muda para layout final** (CSS customizado aplica)
- Tempo entre = perceptível ao usuário = UX ruim

**Impacto:**
- ❌ FOUC (Flash of Unstyled Content)
- ❌ CLS (Cumulative Layout Shift) — pode afetar Core Web Vitals
- ❌ UX ruim — usuário vê "piscada" durante load

---

## 📋 **Investigação Profunda Recomendada**

### **PASSO 1: Verificar Timeline com DevTools**

```bash
1. Abrir https://www.patagang.com.br/lancamentos/
2. Abrir Chrome DevTools (F12)
3. Ir para aba "Performance"
4. Clicar "Record" (círculo vermelho)
5. Esperar página carregar completamente
6. Clicar "Stop"

Procurar por:
- Layout Shifts (seção "Experience")
- CLS Score (quanto maior, pior)
- Timeline: CSS load order
- Timeline: quando style-async carrega
```

### **PASSO 2: Verificar CSS Loading Order**

```bash
1. DevTools → Network tab
2. Filter por CSS (type:stylesheet)
3. Verificar:
   - Qual CSS carrega primeiro? (critical vs async)
   - Qual demora mais? (async pode estar lento)
   - Há delay entre carregamento? (mostra FOUC)

Expected:
✓ style-critical: carrega RÁPIDO (inline no <head>)
✓ style-async: carrega depois (media="print" onload)

If CSS order está invertido ou muito lento = causa FOUC
```

### **PASSO 3: Analizar Estrutura HTML**

```bash
1. DevTools → Elements tab
2. Procurar por:
   - Quantos divs com class="row" na página?
   - Existe duplicação de grid?
   - Filtros têm estrutura diferente entre inicial/final?

Verificar:
<div class="category-controls">   ← Filters layout
  <button class="filter-link">Filtrar</button>
  <select class="form-select">Ordenar</select>
</div>

Se a posição/tamanho muda entre load inicial/final = CLS
```

### **PASSO 4: Checar Media Queries**

```bash
Verificar em style-critical.tpl:
- Qual breakpoint para layout dos filtros?
- Qual breakpoint em layout.tpl?
- Qual breakpoint em style-async (recém movido)?

Se não aligned = conflito em certos tamanhos de tela
```

---

## 🛠️ **Possíveis Soluções (Não Implementar Ainda)**

### **Solução 1: Mover CSS Crítico de Filtros de Volta**
```
Reverter v1.5.116 parcialmente:
- Deixar Gallery Modal em async (Story 8.2 ETAPA 1 OK)
- TRAZER Filters CSS de volta para critical

Por quê:
- Filtros/sort são visíveis above-the-fold
- CSS deles aplicando tarde = FOUC visível
- Melhor ter no critical path
```

### **Solução 2: Pré-carregar style-async.scss.tpl**
```
Adicionar na <head>:
<link rel="preload" as="style" href="style-async.scss.tpl">

Por quê:
- Browser carrega CSS mais cedo
- Reduz delay entre inline + async
- Diminui FOUC
```

### **Solução 3: Otimizar CSS Loading Order**
```
Atual:
1. HTML
2. Inline critical CSS (bloqueia render)
3. JS (assíncrono)
4. Async CSS via media="print" (muito tarde)

Melhor:
1. HTML + Inline critical CSS
2. Preload async CSS
3. JS + Async CSS em paralelo
```

### **Solução 4: Escopar CSS de Filtros**
```
Se CSS de filtros está causando conflitos:
- Envolverem em namespace: `.category-page .filters { ... }`
- Evita sobrescrever estilos não-intencionais
- Reduz CLS
```

---

## 📊 **Core Web Vitals Impact**

```
FOUC/CLS afeta:
❌ LCP (Largest Contentful Paint)
   └─ Se principal conteúdo muda = LCP aumenta

❌ CLS (Cumulative Layout Shift)
   └─ Layout mudando durante load = score ruim
   └─ Pode afetar ranking Google

✓ FID (First Input Delay)
   └─ Não afetado por CSS loading order
```

---

## 📋 **Recomendações**

### **Curto Prazo:**
1. ✅ **Confirmar** que v1.5.116 é a causa (DevTools analysis)
2. ✅ **Medir** CLS score antes/depois
3. ✅ **Documentar** exatamente o que muda

### **Médio Prazo:**
4. ⏳ **Decidir**: Trazer Filters de volta para critical?
5. ⏳ **Otimizar**: CSS loading order se possível
6. ⏳ **Testar**: Layout stability em todos breakpoints

### **Longo Prazo:**
7. 🎯 **Criar story** de "CSS Loading Performance" se impacto relevante
8. 🎯 **Refatorar** estrutura de CSS para melhor organized

---

## 🎯 **Próxima Story (Proposta)**

```yaml
Story: "Investigate & Fix FOUC/CLS on Category & Search Pages"
Epic: "Performance Optimization"
Priority: "High"
Severity: "Medium" (affects UX + Core Web Vitals)

Tasks:
  - [ ] DevTools analysis (CLS measurement)
  - [ ] Identify root cause (CSS loading order)
  - [ ] Decide: Revert filters CSS ou optimize?
  - [ ] Implement fix
  - [ ] Measure improvement (CLS before/after)
  - [ ] Validate on all breakpoints
```

---

## 📚 **Referências Técnicas**

- **FOUC:** Flash of Unstyled Content (CSS carrega depois do HTML)
- **CLS:** Cumulative Layout Shift (elementos se movem durante load)
- **Core Web Vitals:** Google's performance metrics (LCP, FID, CLS)
- **Critical Path:** CSS inline + needed for initial render
- **Non-Critical CSS:** Async loaded (media="print" trick)

---

## 👤 **Autor & Status**

| Campo | Valor |
|-------|-------|
| **Identificado** | Gabriel Cristofolini (v1.5.116 validation) |
| **Documentado** | 2026-03-25 |
| **Status** | Pending Investigation |
| **Ação** | Próxima story quando priorizado |

---

**Conclusão:** FOUC/CLS detectado em páginas de categoria/pesquisa. **Recomendado investigação profunda com DevTools** antes de qualquer ação. Story 8.2 ETAPA 2 pode ter contribuído, mas precisa análise detalhada.

