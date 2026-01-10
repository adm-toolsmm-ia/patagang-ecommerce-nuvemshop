# Boas Práticas - Customização de Temas Nuvemshop

**Data de Criação:** 09/01/2026  
**Última Atualização:** 09/01/2026  
**Propósito:** Documentar lições aprendidas e rotinas padrão para evitar erros comuns

---

## ⚠️ REGRA DE OURO: Investigue ANTES de Implementar

### Contexto
Ao trabalhar com plataformas de e-commerce como Nuvemshop, frequentemente lidamos com:
- Apps externos que injetam HTML via JavaScript
- Widgets de terceiros
- Conteúdo dinâmico gerado no lado do cliente

**❌ ERRO COMUM:** Criar CSS para classes que não existem no HTML real

**✅ SOLUÇÃO:** Sempre verificar a estrutura DOM ANTES de implementar

---

## 📋 Checklist de Validação Pré-Implementação

### 1. Entender a Origem do HTML

**Perguntas a fazer:**
- [ ] Este HTML é gerado no template Twig?
- [ ] É injetado por um app/widget externo via JavaScript?
- [ ] Tenho controle total sobre a estrutura?
- [ ] Preciso modificar template OU apenas CSS?

**Como verificar:**
```twig
{# Verificar no template .tpl #}
<div id="elemento">
  {# Se vazio, conteúdo é injetado via JS #}
</div>
```

---

### 2. Inspecionar Estrutura Real do DOM

**Método 1: DevTools em Produção**
```
1. Abrir página em produção
2. F12 → Elements
3. Localizar elemento (#id ou .classe)
4. Copiar HTML gerado
5. Documentar classes e IDs REAIS
```

**Método 2: Análise de Template**
```
1. Buscar no código: grep -r "elemento" templates/
2. Ver se HTML está hardcoded ou é dinâmico
3. Verificar se há {% include %} ou JavaScript
```

---

### 3. Validar CSS Antes do Deploy

**SEMPRE testar no DevTools primeiro:**
```css
/* Aplicar CSS no Chrome DevTools */
#elemento {
  background: red; /* Teste simples */
}

/* Se NÃO mudar nada = classe/ID errado! */
```

**Processo correto:**
1. Abrir DevTools (F12)
2. Elements → Styles → + (novo seletor)
3. Testar CSS até funcionar
4. Copiar CSS final
5. Implementar no arquivo .scss/.tpl
6. Deploy

---

## 🎯 Casos de Uso Comuns

### Caso 1: App Externo (Reviews, Chat, etc)

**Situação:**
```twig
{# Template tem container vazio #}
<div id="reviewsapp"></div>
```

**Problema:**
- Conteúdo injetado via JavaScript
- Classes são definidas pelo app externo
- Não sabemos quais classes usar

**Solução A: Investigar classes do app**
```
1. Inspecionar #reviewsapp em produção
2. Ver HTML gerado pelo app
3. Customizar seletores reais:
   #reviewsapp h2 { ... }
   #reviewsapp .btn { ... }
```

**Solução B: Criar HTML próprio (se possível)**
```twig
{# Criar estrutura customizada #}
<div class="pg-custom-reviews">
  <h2>Avaliações</h2>
  <div id="reviewsapp"></div>
</div>
```
```css
.pg-custom-reviews { /* Funciona! */ }
```

---

### Caso 2: Conteúdo Hardcoded no Template

**Situação:**
```twig
{# HTML completamente controlado #}
<div class="product-info">
  <h1>{{ product.name }}</h1>
</div>
```

**Solução:**
- ✅ Modificar template livremente
- ✅ Adicionar classes customizadas
- ✅ CSS funcionará 100%

---

### Caso 3: Widgets Nuvemshop Nativos

**Situação:**
```twig
{% snipplet "grid/item.tpl" %}
```

**Problema:**
- Snipplet gera HTML próprio
- Classes são da Nuvemshop

**Solução:**
```
1. Abrir snipplet: snipplets/grid/item.tpl
2. Ver classes usadas
3. Customizar essas classes específicas
4. OU modificar snipplet se permitido
```

---

## 🚫 Anti-Padrões (O Que NÃO Fazer)

### ❌ Anti-padrão 1: Criar CSS sem verificar HTML
```css
/* ERRADO - assumir que classe existe */
.minha-classe-inventada {
  color: red;
}
```
**Resultado:** CSS não afeta nada

---

### ❌ Anti-padrão 2: Deploy sem testar no DevTools
```
1. Escrever CSS
2. Deploy direto
3. "Não funcionou, por quê?" ← EVITAR ISSO!
```
**Resultado:** Tempo perdido, rollback necessário

---

### ❌ Anti-padrão 3: Ignorar estrutura de apps externos
```
<!-- App externo injeta isso: -->
<div id="app">
  <div class="app-widget">...</div>
</div>

/* CSS que não funciona: */
.minha-clase { ... } ❌

/* CSS correto: */
#app .app-widget { ... } ✅
```

---

## ✅ Padrões Recomendados

### ✅ Padrão 1: Investigar → Planejar → Testar → Implementar

```
1. INVESTIGAR
   - Ver template .tpl
   - Identificar se HTML é estático ou dinâmico
   - Inspecionar DevTools em produção

2. PLANEJAR
   - Documentar seletores disponíveis
   - Decidir abordagem (modificar template vs CSS)
   - Criar plano de implementação

3. TESTAR
   - Aplicar CSS no DevTools
   - Validar que funciona
   - Ajustar até perfeito

4. IMPLEMENTAR
   - Copiar CSS testado
   - Deploy
   - Validar em produção
```

---

### ✅ Padrão 2: Documentar Seletores Disponíveis

Criar arquivo de referência:
```markdown
## Seletores Disponíveis - Produto

### Reviews (#reviewsapp)
- Container: #reviewsapp
- Título: #reviewsapp h2
- Botão: #reviewsapp .btn-primary
- Estrelas: #reviewsapp .star

### Perguntas
- Container: #qa-section
- Pergunta: .qa-item
- Resposta: .qa-answer
```

---

### ✅ Padrão 3: Usar Scoping CSS

Sempre fazer scope para evitar efeitos colaterais:
```css
/* BOM - específico */
#reviewsapp h2 { ... }
.pg-pdp-container .reviews { ... }

/* RUIM - genérico demais */
h2 { ... }
.reviews { ... }
```

---

## 📝 Template de Investigação

Use este template ao trabalhar com elemento desconhecido:

```markdown
## Investigação: [Nome do Elemento]

### 1. Localização
- Template: templates/product.tpl (linha X)
- Código: `<div id="elemento"></div>`

### 2. Origem do Conteúdo
- [ ] HTML hardcoded no template
- [ ] Injetado via JavaScript (app externo)
- [ ] Gerado por snipplet Nuvemshop
- [ ] Outro: ___________

### 3. Seletores Identificados
- ID principal: #elemento
- Classes filhas:
  - .classe-1
  - .classe-2
- Estrutura:
  ```html
  <div id="elemento">
    <div class="classe-1">...</div>
  </div>
  ```

### 4. Estratégia de Customização
- [ ] Modificar template
- [ ] CSS com seletores existentes
- [ ] Wrapper customizado
- [ ] Outro: ___________

### 5. CSS Testado (DevTools)
```css
/* Cole CSS que funcionou no teste */
```

### 6. Validação
- [ ] Testado no DevTools
- [ ] Funciona em desktop
- [ ] Funciona em mobile
- [ ] Sem efeitos colaterais
```

---

## 🎓 Casos Reais - Lições Aprendidas

### Caso Real 1: Reviews Nuvemshop (09/01/2026)

**Situação:**
- Requisito: Redesign de seção de avaliações
- Template tinha: `<div id="reviewsapp"></div>` (vazio)

**Erro cometido:**
```css
/* Criamos classes que não existem */
.pg-reviews-section { ... } ❌
.pg-reviews-header { ... } ❌
```

**Por que falhou:**
- HTML é injetado via JavaScript (app Nuvemshop)
- Classes `.pg-reviews-*` não existem no DOM real
- CSS não selecionou nada = zero impacto

**Solução correta:**
```twig
{# Modificar template para criar HTML próprio #}
<div class="pg-reviews-wrapper">
  <div class="pg-reviews-section">
    <h2>Avaliações</h2>
    <!-- Conteúdo customizado -->
  </div>
  <div id="reviewsapp"></div>
</div>
```

**Lição:**
> "Nunca criar CSS para classes que você não controla. Sempre verificar estrutura DOM real."

---

## 🔧 Ferramentas e Comandos Úteis

### Grep para encontrar elementos
```bash
# Buscar ID ou classe no projeto
grep -r "reviewsapp" templates/
grep -r "pg-reviews" static/css/
```

### Chrome DevTools
```
1. F12 → Elements
2. Ctrl+F → buscar classe/ID
3. Styles → testar CSS ao vivo
4. Network → ver se JavaScript carrega conteúdo
```

### Validar CSS aplicado
```javascript
// Console do Chrome
getComputedStyle(document.querySelector('#elemento')).color
// Se retornar valor diferente = CSS funcionou
```

---

## 📚 Referências

### Documentação Nuvemshop
- Estrutura de templates: /Docs/Nuvemshop/NUVEMSHOP-REFERENCE.md
- Apps e widgets: /Docs/Nuvemshop/APPS-EXTERNOS.md

### Arquivos-chave do Projeto
- Templates de produto: templates/product.tpl
- Snipplets: snipplets/product/
- CSS crítico: static/css/style-critical.tpl
- CSS assíncrono: static/css/style-async.scss.tpl

---

## 🔄 Processo de Review de Código

Antes de fazer deploy, verificar:

- [ ] Testei CSS no DevTools?
- [ ] CSS realmente afeta os elementos?
- [ ] Seletores correspondem ao HTML real?
- [ ] Não usei classes/IDs inventados?
- [ ] Funciona em desktop E mobile?
- [ ] Documentei seletores usados?
- [ ] Sem efeitos colaterais em outras páginas?

---

## 💡 Dicas Finais

1. **Sempre desconfie de containers vazios**
   - `<div id="algo"></div>` sem filhos = conteúdo via JS
   
2. **!important só quando necessário**
   - Apps externos têm CSS inline
   - Pode ser necessário !important para sobrescrever
   
3. **Prefira modificar template quando possível**
   - Controle total sobre HTML
   - CSS sempre funcionará
   
4. **Documente suas descobertas**
   - Próximo desenvolvedor agradecerá
   - Você mesmo agradecerá daqui 6 meses

---

**Criado após incidente de reviews não funcionarem (09/01/2026)**  
**Objetivo:** Evitar tempo perdido com CSS que não funciona  
**Regra de ouro:** **Investigue ANTES de implementar**
