# EPIC 9 — Achados da Validação (Consolidado)

**Data Validação:** 2026-03-27
**Validador:** Gabriel Cristofolini (CTO)
**Status:** Análise Profunda para Planejamento
**Impacto:** Alto (UX/UI + Estrutura)

---

## 📋 Resumo Executivo

Gabriel identificou **6 ajustes críticos** durante validação em produção da loja. Estes representam problemas que precisam ser **refatorados estruturalmente** (não apenas ajustes cosméticos) para manter qualidade AIOX 10/10.

| Item | Severidade | Tipo | Páginas Afetadas |
|------|-----------|------|-----------------|
| 1. WhatsApp Button | 🟡 Medium | Design/UX | PDP (produto) |
| 2. Banner Translúcido | 🟡 Medium | CSS/UX | Múltiplas |
| 3. Galeria de Imagens | 🔴 High | Funcionalidade | PDP |
| 4. Info Card Mobile | 🔴 High | Layout/Responsive | PDP Mobile |
| 5. Cart Design | 🟡 Medium | UX/Design | Global |
| 6. White Background Pages | 🔴 High | Layout/Estrutura | Páginas genéricas |

**Impacto na Loja:**
- ❌ Problemas de estrutura em múltiplas páginas (itens 2, 6)
- ❌ UX mobile prejudicada (item 4)
- ❌ Galeria com comportamento não-padrão (item 3)
- ⚠️ Design inconsistente (itens 1, 5)

---

## 🔍 AJUSTE 1 — WhatsApp Button Structure

### Objetivo
Estruturar botão "Compre pelo Whats" no mesmo padrão do botão "Posso ajudar?", mantendo funcionalidade WhatsApp padrão.

### Contexto Atual
```
❌ Estrutura: Possivelmente inline ou mal posicionado
❌ Design: Inconsistente com "Posso ajudar?"
❌ Posição: Lado esquerdo (correto), mas estrutura diferente
✅ Funcionalidade: WhatsApp funcionando
```

### Análise Profunda Necessária

**Questões a Investigar:**
1. Onde está o botão "Compre pelo Whats"?
   - Arquivo: Qual template? (snipplet? layout?)
   - Estrutura HTML: Como é renderizado?
   - CSS: Classes utilizadas?

2. Onde está o botão "Posso ajudar?"
   - Padrão de design e estrutura
   - Como é posicionado (fixed? absolute? flexbox?)
   - Media queries para responsividade?

3. Diferenças estruturais atuais?
   - Z-index conflicts?
   - Layout method diferente?
   - Breakpoints diferentes?

### Requisitos (AC Futuro)
- [ ] AC 1: Botão "Compre pelo Whats" estruturado idêntico a "Posso ajudar?"
- [ ] AC 2: Posição lado esquerdo mantida (oposto a "Posso ajudar?")
- [ ] AC 3: Tamanho e design visual idênticos
- [ ] AC 4: Funcionalidade WhatsApp mantida
- [ ] AC 5: Responsivo em mobile/tablet/desktop
- [ ] AC 6: Zero visual regression em outras páginas

### Possível Root Cause
```
Provável: Duas estruturas diferentes criadas em momentos diferentes
- "Posso ajudar?" → Estrutura padrão (possivelmente mais recente)
- "Compre pelo Whats" → Estrutura anterior/improvisada

Solução: Unificar estrutura, usar "Posso ajudar?" como referência
```

---

## 🔍 AJUSTE 2 — Banner Translúcido

### Objetivo
Converter fundo sólido do banner para translúcido, melhorar texto (uma linha, espaçamento), responsivo web+mobile.

### Contexto Atual
```
❌ Fundo: Cor sólida (opaco)
❌ Texto: Possivelmente múltiplas linhas, sem espaçamento
❌ Responsividade: Texto pode estar quebrado em mobile
✅ Visibilidade: Banner aparece e é legível
```

### Análise Profunda Necessária

**Questões a Investigar:**
1. Qual banner estamos falando?
   - Aviso de desconto? Aviso de segurança? Aviso geral?
   - Localização: Qual página?
   - Arquivo: Qual arquivo CSS?

2. Background color atual
   - Valor RGB/HEX?
   - Opacity necessária?
   - Como manter legibilidade com transparência?

3. Estrutura de texto
   - Quantas linhas atualmente?
   - Como quebra em mobile?
   - Tamanho de fonte em web vs mobile?

### Requisitos (AC Futuro)
- [ ] AC 1: Fundo translúcido (especificar opacity %)
- [ ] AC 2: Texto em UMA linha (sem quebra)
- [ ] AC 3: Espaçamento entre frases ajustado
- [ ] AC 4: Legibilidade mantida (bom contraste)
- [ ] AC 5: Responsivo web (breakpoints padrão)
- [ ] AC 6: Responsivo mobile (100% funcional)

### Possível Root Cause
```
Provável: Banner com background-color fixo + padding inadequado
- Ou: Texto com width restrito, forçando quebra
- Ou: Font-size muito grande

Solução: Converter para translucidez (rgba), ajustar texto, media queries
```

---

## 🔍 AJUSTE 3 — Galeria de Imagens (Critical)

### Objetivo
Resolver comportamento não-padrão de galeria: ao clicar em foto, abre todas as imagens. Implementar padrão e-commerce (lightbox único ou galeria focada).

### Contexto Atual
```
❌ Comportamento: Clica na foto → abre TODAS as imagens
❌ Padrão: Diferente de e-commerce padrão
✅ Funcionalidade: Galeria funciona, todas imagens visíveis
```

### Análise Profunda Necessária

**Questões a Investigar:**
1. Qual é a galeria?
   - Componente Nuvemshop padrão modificado?
   - Custom JavaScript?
   - Swiper/carousel?
   - Behavior: click → lightbox ou modal?

2. Comportamento esperado vs atual
   - Esperado: Clica em foto → abre a FOTO em lightbox, pode navegar
   - Atual: Clica em foto → abre TODAS as fotos (como se fosse galeria de seleção)

3. Possível estrutura problemática
   - Evento click atrelado a modal com todas fotos?
   - Bootstrap modal? Custom modal?
   - JavaScript inline ou arquivo separado?

### Requisitos (AC Futuro)
- [ ] AC 1: Galeria implementa padrão e-commerce (lightbox/zoom)
- [ ] AC 2: Clique em foto abre APENAS essa foto em destaque
- [ ] AC 3: Navegação entre fotos funciona (prev/next)
- [ ] AC 4: Zoom de imagem disponível (se padrão e-commerce)
- [ ] AC 5: Mobile responsivo (swipe para navegar)
- [ ] AC 6: Nenhuma quebra em outras funcionalidades

### Possível Root Cause
```
Provável: Evento click em imagem ligado a modal com ALL_IMAGES
- Ou: Galeria principal (desktop) + galeria mobile criando conflito
- Ou: JavaScript tentando "corrigir" comportamento anterior criando mais problemas

Solução: Implementar lightbox padrão (ex: Fancybox, Lightbox2, ou custom moderno)
```

### Padrão E-Commerce Recomendado
```
Mobile:
- Swiper/carousel com thumbs
- Click: Abre imagem em fullscreen
- Swipe: Navega entre fotos

Desktop:
- Grid com thumbs lateral
- Click: Lightbox com zoom
- Hover: Preview
```

---

## 🔍 AJUSTE 4 — Info Card Compactado Mobile (Critical)

### Objetivo
Resolver produto info card que ocupa apenas ~50% largura em mobile (vs 100% esperado).

### Contexto Atual
```
❌ Width: ~50% (limitado como se houvesse coluna invisível)
❌ Comportamento: Tipo "existe um container no lado direito invisível"
✅ Conteúdo: Informações aparecem, apenas compactado
```

### Análise Profunda Necessária (Já feita em EPIC 8)

**Tentativas anteriores (3 hotfixes):**
```
v1.5.123: Seletor .pg-product-grid → .pg-product-grid (nenhum efeito)
v1.5.124: Reset justify-content + align-items via media query (sem resultado)
v1.5.125: Adicionar flex-direction: column (sem resultado)

Conclusão: Problema é ESTRUTURAL, não CSS simples
```

**Investigação Necessária:**
1. Estrutura HTML da página
   - Quantas colunas/containers?
   - Qual é a `.section-single-product`?
   - Bootstrap columns? Custom grid?

2. Possíveis causas
   - Container pai com width: 50%?
   - Grid-column ou flex-basis com valor fixo?
   - Propriedade max-width em elemento pai?
   - Conflito entre mobile grid e desktop grid?

3. Layout esperado vs atual
   - Mobile esperado: Card 100% width
   - Atual: Card ~50% width
   - Sensação: Como se houvesse outra coluna invisível

### Requisitos (AC Futuro)
- [ ] AC 1: Info card 100% width em mobile (375px+)
- [ ] AC 2: Layout responsivo correto (mobile → tablet → desktop)
- [ ] AC 3: Sem regressão em outros breakpoints
- [ ] AC 4: Conteúdo legível e bem espaçado
- [ ] AC 5: Lighthouse performance mantida
- [ ] AC 6: Gabriel approval visual

### Possível Root Cause (Estrutural)
```
HIPÓTESE 1: Container pai com width limitado
- .section-single-product { width: 50%; }  ← problema raiz
- Solução: width: 100% em mobile

HIPÓTESE 2: Grid conflitante
- Desktop: 2 colunas (imagem + info)
- Mobile: Deveria ser 1 coluna (stack)
- Mas: Media query está resetando só margens/padding, não coluna
- Solução: Refatorar grid para responsive corretamente

HIPÓTESE 3: Bootstrap grid classes conflitantes
- .col-6 ou .col-md-6 em mobile mantendo 50%?
- Solução: Adicionar .col-12 ou .col-xs-12

SOLUÇÃO: Deep investigation com Chrome DevTools → refactoring estrutural
```

---

## 🔍 AJUSTE 5 — Cart Design Simplificado

### Objetivo
Refatorar design do carrinho/sacola para padrão mais simples, alinhado à identidade Patagang. Manter lógica funcional.

### Contexto Atual
```
✅ Funcionalidade: Adicionar/remover itens, cálcular total, checkout
❌ Design: Complexo, não alinhado à identidade visual
❌ UX: Possivelmente confuso em mobile
```

### Análise Profunda Necessária

**Questões a Investigar:**
1. Qual é a estrutura atual do cart?
   - Componente Nuvemshop padrão customizado?
   - Custom HTML/CSS?
   - Arquivo: Qual template?

2. Identidade visual Patagang
   - Cores primárias? (ex: #EAFE67 amarelo)
   - Tipografia padrão?
   - Estilo de botões/inputs?
   - Spacing/grid system?

3. Problemas de UX atuais
   - Carrinho muito grande? Muitos elementos?
   - Mobile: Scrolling excessivo?
   - Checkoutflow confuso?

### Requisitos (AC Futuro)
- [ ] AC 1: Design simplificado, alinhado identidade Patagang
- [ ] AC 2: Mantém funcionalidade (add/remove/total/checkout)
- [ ] AC 3: Responsivo mobile (sem scroll excessivo)
- [ ] AC 4: Responsivo web/tablet
- [ ] AC 5: Performance mantida (sem mais requisições)
- [ ] AC 6: Testes de conversão (não impacta compra)

### Design Simplificado Recomendado
```
Estrutura mínima:
- Título "Seu Carrinho"
- Lista simples: Produto | Qtd | Preço | Remover
- Resumo: Subtotal | Frete | Total
- Botão: "Finalizar Compra" (destaque)

Mobile:
- Fullscreen ou drawer
- Toque para expandir item
- Botão flutuante (sticky bottom)
```

---

## 🔍 AJUSTE 6 — White Background Pages (Critical - Estrutural)

### Objetivo
Remover fundo branco indesejado que aparece em páginas como /comunidade/ abaixo do header. Identificar e corrigir estrutura que impacta múltiplas páginas.

### Contexto Atual
```
❌ Problema: Fundo branco + espaçamento no início de algumas páginas
❌ Localização: /comunidade/ (e possívelmente outras)
❌ Causa Provável: Ajuste mal estruturado do banner da PDP afetando globalmente
✅ Visibilidade: Página é visível, apenas com fundo indesejado
```

### Análise Profunda Necessária (CRÍTICA)

**Questões a Investigar:**
1. Em quais páginas aparece?
   - /comunidade/ (confirmado)
   - /lancamentos/? /search/? Todas?
   - Apenas páginas específicas ou global?

2. Qual é a causa?
   - Padding/margin em elemento global?
   - Background-color em elemento que não deveria ter?
   - Gap no grid/flex que não deveria existir?

3. Conexão com banner PDP
   - Gabriel mencionou: "Cuidado com impacto do banner específico na PDP"
   - Possível: Ajuste para posicionar banner corretamente pode ter criado estrutura quebrada
   - Investigar: Elemento criado com position: absolute ou similiar?

### Requisitos (AC Futuro)
- [ ] AC 1: Sem fundo branco indesejado em /comunidade/
- [ ] AC 2: Sem espaçamento excessivo no topo
- [ ] AC 3: Todas páginas verificadas (sem regressão)
- [ ] AC 4: Banner PDP continua funcionando corretamente
- [ ] AC 5: Nenhum overflow ou margin collapse
- [ ] AC 6: Gabriel approval visual (múltiplas páginas)

### Possível Root Cause (ESTRUTURAL)

```
INVESTIGAÇÃO NECESSÁRIA:
Cenário 1: Padding/margin global quebrado
  └─ Solução: Remover padding desnecessário de elemento global

Cenário 2: Banner PDP criou elemento com position absoluto
  └─ Problema: position: absolute tira elemento do fluxo
  └─ Symptom: Página abaixo fica com gap
  └─ Solução: Usar position: fixed ou refatorar estrutura

Cenário 3: Z-index context ou stacking context problemático
  └─ Solução: Reorganizar stacking ordem, usar z-index correto

AÇÃO: Deep investigation com Chrome DevTools → Refatoração Estrutural
```

**Aviso Gabriel:** "Cuidado com o impacto do banner específico na página do produto da Loja"
- Isso sugere que ajuste anterior criou efeito colateral
- Precisamos investigar qual foi a "solução" anterior que gerou este problema

---

## 📊 Matriz de Interdependências

```
AJUSTE 6 (White BG) ← Possivelmente causado por → AJUSTE 1 ou 2
                                                    (banner/posicionamento)

AJUSTE 4 (Info Card Mobile) ← Independente, mas → AJUSTE 3 (Galeria)
                               pode impactar layout   (mesmo container?)

AJUSTE 5 (Cart Design) ← Independente
                        (global, não específico PDP)

AJUSTE 3 (Galeria) ← Independente
                     (PDP específico)

AJUSTE 1 (WhatsApp) ← Pode impactar → AJUSTE 2 (Banner)
                      (posicionamento)  (z-index?)

AJUSTE 2 (Banner) ← Pode impactar → AJUSTE 6 (White BG)
                     (estrutura)      (confirmado por Gabriel)
```

**Ordem de Execução Recomendada:**
1. Investigar AJUSTE 6 (White BG) → identificar raiz
2. Corrigir causa raiz (pode ser ajuste ao banner)
3. Executar AJUSTE 1 & 2 em paralelo (estruturalmente relacionados)
4. Executar AJUSTE 3 (galeria, independente)
5. Executar AJUSTE 4 (info card, pode já estar resolvido após 3)
6. Executar AJUSTE 5 (cart, totalmente independente)

---

## 🎯 Padrões de Qualidade AIOX 10/10 a Manter

Estes ajustes devem ser executados com:

✅ **Análise Estrutural Profunda**
- Não apenas ajustar CSS
- Investigar HTML structure
- Entender lógica JavaScript (se aplicável)

✅ **Refatoração vs Correção**
- Se estrutura ruim → REFATORAR
- Se código errado → CORRIGIR
- Não deixar "gambiarras"

✅ **Teste de Regressão**
- Cada ajuste: testar impacto em outras páginas
- Validar em mobile/tablet/desktop
- Lighthouse score mantido

✅ **Documentação de Aprendizados**
- Por que o problema surgiu?
- Como foi identificado?
- Como foi resolvido?
- O que evitar no futuro?

✅ **Segurança**
- Deploy com versão clara (v1.6.x)
- Backup antes de cada alteração
- Rollback plan definido
- Gabriel validation após cada ajuste

---

## 📝 Próximas Etapas

1. **Investigação Detalhada** (hoje)
   - Chrome DevTools em cada page
   - Verificar estrutura HTML
   - Mapear CSS relacionado

2. **Documentação de Root Causes** (amanhã)
   - Confirmar diagnóstico
   - Criar stories com AC claros

3. **Planejamento AIOX** (amanhã)
   - Workflow de implementação
   - Rollback plans
   - Validação steps

4. **Execução Segura** (semana próxima)
   - Story por story
   - Gabriel approval cada deploy

---

**Status:** ✅ Análise Consolidada Completa
**Próximo:** Planejamento AIOX com Workflow de Implementação

