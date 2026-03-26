# Task — Investigar White Background Issue (Story 9.1 Blocker)

**Assigned to:** @architect (Aria)
**Type:** Investigation (Non-Blocking Discovery)
**Priority:** Critical (Blocks Stories 9.2-9.6)
**Timeline:** 2 hours
**Method:** Chrome DevTools + Code Analysis
**Owner:** @architect (investigation lead)

---

## 🎯 Objetivo

Identificar **root cause** do fundo branco indesejado que aparece em páginas como `/comunidade/` abaixo do header. Gabriel alertou que isso pode ser causado por ajuste anterior (possivelmente do banner na PDP). Esta investigação é BLOCKER porque:
- Afeta múltiplas páginas
- Pode ser sintoma de estrutura quebrada global
- Precisa ser resolvido ANTES de executar outras stories (que podem ser impactadas)

---

## 📋 Contexto

**Problema Observado:**
```
Página: https://www.patagang.com.br/comunidade
Sintoma: Fundo branco + espaçamento indesejado abaixo do header
Impacto: Múltiplas páginas genéricas (não apenas comunidade)
```

**Aviso de Gabriel:**
> "Cuidado com o impacto do banner específico na página do produto da Loja,
> para corrigir o posicionamento dele na tela provavelmente foi criado algo
> mal estruturado que impacta em outras páginas."

**Hipótese Inicial:**
Ajuste anterior para posicionar banner da PDP corretamente criou efeito colateral global (possivelmente position: absolute sem containment adequado).

---

## 🔍 Investigação Requerida

### Phase 1: Visual Analysis (30 min)

**Step 1.1: Reproduzir o problema**
```bash
1. Abrir Chrome
2. Ir para: https://www.patagang.com.br/comunidade
3. Abrir DevTools (F12)
4. Verificar em mobile/tablet/desktop
5. Screenshots para referência
```

**Step 1.2: Analisar estrutura HTML (DevTools)**
```bash
1. Inspecionar elemento "fundo branco"
2. Verificar: Qual é o elemento? <div>? <section>? <main>?
3. Verificar: Padding/margin? Background-color? Height?
4. Navegar até <body> e <html> para ver cascade
5. Documentar estrutura
```

**Step 1.3: Analisar CSS computado (Computed Styles tab)**
```bash
1. Elemento selecionado → Tab "Computed"
2. Procurar por:
   - background-color: (valores, inherit?)
   - padding-top/bottom: (valores?)
   - margin-top/bottom: (valores?)
   - height: (valores?)
3. Identificar qual CSS rule está causando
4. Seguir a cascade (qual arquivo CSS?)
```

**Step 1.4: Analisar Layout (Layout tab)**
```bash
1. DevTools → Layout tab
2. Verificar box model:
   - Content box height?
   - Padding/border/margin?
   - Position (static? absolute? relative?)?
3. Procurar por overflow hidden ou valores inesperados
```

### Phase 2: Code Analysis (60 min)

**Step 2.1: Procurar por elementos criados recentemente**
```bash
# Procurar por position: absolute em CSS global
grep -r "position.*absolute" theme-deploy-corrigido/static/css/*.tpl

# Procurar por elementos com background-color sólido
grep -r "background-color.*white\|background-color.*#fff\|background-color.*#ffffff" theme-deploy-corrigido/static/css/*.tpl

# Procurar por padding-top em elementos globais
grep -r "padding-top\|padding:\|margin-top" theme-deploy-corrigido/static/css/style-critical.tpl | head -20

# Procurar por height: values
grep -r "height.*px\|height.*vh\|height.*em" theme-deploy-corrigido/layouts/layout.tpl
```

**Step 2.2: Revisar layout.tpl estrutura**
```liquid
1. Abrir theme-deploy-corrigido/layouts/layout.tpl
2. Procurar por:
   - Header (position? z-index?)
   - Main/section abaixo do header
   - Elementos novos com position: absolute
3. Verificar se há elemento criado entre header e main
4. Documentar estrutura
```

**Step 2.3: Procurar por ajustes de banner PDP**
```bash
# Procurar commits recentes que mencionem "banner" ou "positioning"
git log --oneline --grep="banner\|position" -10

# Procurar por arquivos modificados recentemente (Stories 8.2+)
git log --oneline --name-only | grep -i "layout\|header\|style-critical" | head -20

# Comparar versão atual com versão anterior (v1.5.118)
git show v1.5.118:theme-deploy-corrigido/layouts/layout.tpl > /tmp/layout-old.tpl
diff /tmp/layout-old.tpl theme-deploy-corrigido/layouts/layout.tpl
```

**Step 2.4: Analisar CSS cascade para "white background"**
```bash
# Em style-critical.tpl, procurar por:
# 1. Elementos que podem ter background-color
grep -n "background\|color:" theme-deploy-corrigido/static/css/style-critical.tpl | grep -E "white|#fff|#ffffff" | head -10

# 2. Elementos com padding-top que pode estar criando gap
grep -n "padding-top\|padding:" theme-deploy-corrigido/static/css/style-critical.tpl | head -10

# 3. Position absolute ou fixed que pode estar causando
grep -n "position:" theme-deploy-corrigido/static/css/style-critical.tpl | head -10
```

### Phase 3: Hypothesis Testing (30 min)

**Step 3.1: Testar hipóteses**

Baseado na investigação acima, testar:

**Hipótese 1: Position Absolute no Banner**
```
Expected: position: absolute em elemento de banner criado
Test: Remove position: absolute e recarregar página
Result: Se white background desaparece → CAUSE FOUND
```

**Hipótese 2: Padding Global Quebrado**
```
Expected: padding-top em elemento global muito grande
Test: Diminuir padding-top e recarregar
Result: Se white background fica menor → CAUSE FOUND
```

**Hipótese 3: Elemento Novo com Background-Color**
```
Expected: <div> novo criado com background: white; entre header e main
Test: Esconder elemento com display: none
Result: Se white background desaparece → CAUSE FOUND
```

**Hipótese 4: Layout Gap ou Margin Collapse**
```
Expected: Grid/flex com gap ou margin indesejado
Test: Remover gap e recarregar
Result: Se white background desaparece → CAUSE FOUND
```

**Step 3.2: Documentar findings**
```
1. Qual é a CAUSA RAIZ identificada?
   └─ Ex: "position: absolute no banner criou gap entre header e main"

2. Em qual arquivo?
   └─ Ex: "style-critical.tpl line 142"

3. Em qual commit foi introduzido?
   └─ Usar git blame ou git log

4. Por que foi criado?
   └─ Ex: "Tentativa de posicionar banner na PDP, mas afetou global"

5. Qual é a SOLUÇÃO?
   └─ Refatorar para position: fixed?
   └─ Remover padding indesejado?
   └─ Colocar em container específico?
```

---

## 📊 Deliverables

### Investigation Report

Criar documento: `Docs/reports/epic-9/9.1-WHITE-BACKGROUND-INVESTIGATION.md`

Conteúdo obrigatório:
```markdown
# Story 9.1 — White Background Investigation Report

## Achados

### 1. Estrutura HTML Problemática
[HTML structure com screenshot]

### 2. CSS Cascade Problemático
[CSS rules com arquivo + linha]

### 3. Root Cause Identificado
[Descrição clara da causa raiz]

### 4. Correlação com Ajuste Anterior
[Como se relaciona com ajuste ao banner PDP?]

### 5. Soluções Propostas (2-3 options)
[Option A: ..., Option B: ..., Option C: ...]

### 6. Recomendação
[Qual solução é melhor? Por quê?]

### 7. Gotcha para Próximas Stories
[O que aprender para não repetir?]
```

---

## ✅ Definition of Done (Investigation)

- [x] Visual problem reproduzido e documentado
- [x] HTML structure mapeado (elementos envolvidos)
- [x] CSS rules identificados (quais arquivos)
- [x] Git blame ou git log conectado ao ajuste anterior
- [x] Root cause clara e documentada
- [x] 2-3 soluções propostas
- [x] Recomendação feita
- [x] Investigation Report criado
- [x] Pronto para Phase 2 (Decision + Implementation)

---

## 🔍 Ferramentas Disponíveis

**Chrome DevTools:**
- Inspector (Ctrl+Shift+C)
- Computed Styles tab
- Layout tab
- Console

**Bash Commands:**
```bash
grep, git log, git blame, git show
```

**Files to Investigate:**
```
theme-deploy-corrigido/layouts/layout.tpl
theme-deploy-corrigido/static/css/style-critical.tpl
theme-deploy-corrigido/static/css/style-async.scss.tpl
(possível: custom CSS files)
```

---

## ⏱️ Timeline

```
0-30min: Visual Analysis (DevTools, screenshots)
30-90min: Code Analysis (grep, git history)
90-120min: Hypothesis Testing + Report Writing
```

---

## 📝 Notes for @architect (Aria)

- Gabriel mencionou: "Cuidado com impacto do banner" → isso é pista importante
- Possivelmente ajuste anterior usou position: absolute sem considerar escopo global
- Investigação é profunda, não superficial — precisa entender PORQUE, não só ONDE
- Report será base para Story 9.1 Implementation
- Documentar GOTCHA para evitar no futuro

---

**Status:** Ready for Investigation
**Owner:** @architect (Aria)
**Reviewer:** @dev (Dex) — code analysis support
**Depends On:** Nenhum
**Blocks:** Stories 9.2-9.6

🔍 **Start Investigation Now!**

