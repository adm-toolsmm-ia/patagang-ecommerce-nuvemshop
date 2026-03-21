# QA Gate Checklist — PDP Stabilization
**Story:** Story 6 — QA Gate — Validação Funcional Completa
**Versão:** 1.1.6
**Data:** 2026-03-20
**Responsável:** @qa (Quinn)
**Duração Estimada:** 30-45 minutos

---

## 🎯 Objetivo

Validar que a página de produto está **100% funcional** e pronta para produção após fixes de variantes, preço e botão.

**Verdictto Final:** PASS / CONCERNS / FAIL

---

## ⚠️ Pré-Requisitos

Antes de começar:
- [ ] @dev completou Stories 2-5 (todos os fixes implementados)
- [ ] Código está em branch de desenvolvimento
- [ ] Página está acessível em staging
- [ ] Browser com DevTools disponível
- [ ] Pode compilar/build se necessário: `npm run build`

---

## 📋 Checklist — 7 Pontos (All Must PASS)

### **1️⃣ SELECIONAR TAMANHO → BOTÃO HABILITA** 🔴 CRÍTICO

**Teste:**
```
1. Abrir página PDP: https://dev.patagang.com.br/produtos/{slug}
2. Inspecionar botão "Adicionar ao Carrinho":
   - DevTools → Elements
   - Procurar: class="js-addtocart"
   - Inicialmente: tem classe 'disabled'?  ✓ Esperado: SIM
3. Clicar no select de tamanho
4. Escolher tamanho (ex: M)
5. Verificar botão:
   - Classe 'disabled' removida?  ✓ Esperado: SIM
   - Botão clicável?  ✓ Esperado: SIM
```

**Validação no Console:**
```javascript
// Abrir DevTools Console (F12)
// Copiar e colar:

// Antes de selecionar tamanho:
document.querySelector('.js-addtocart').classList
// Deve conter: 'disabled'

// Selecionar tamanho no UI (clicar select)
// Depois colar:
document.querySelector('.js-addtocart').classList
// Deve NÃO conter: 'disabled'
```

**Status:**
- [ ] ✅ PASS — Botão habilita após seleção de tamanho
- [ ] ❌ FAIL — Botão nunca habilita ou sempre desabilitado
- [ ] ⚠️ CONCERNS — Funciona mas com delay/inconsistência

**Comentários:** ___________________________

---

### **2️⃣ MUDAR TAMANHO → PREÇO ATUALIZA** 🔴 CRÍTICO

**Teste:**
```
1. Na página PDP, registrar preço inicial:
   - Tamanho P: R$ 169,00 (exemplo)
   - Notar valor exato
2. Selecionar tamanho diferente:
   - Mudar para: M (ou próximo tamanho)
3. Verificar preço:
   - Preço foi para outro valor?  ✓ Esperado: SIM (ou mesmo se invariante)
   - Atualização foi imediata?  ✓ Esperado: SIM
   - Não teve delay > 2 segundos?  ✓ Esperado: SIM

Nota: Se todos tamanhos têm mesmo preço, PASS mesmo que preço não mude
```

**Validação no Console:**
```javascript
// Verificar dados de variantes carregados:
console.log(LS.variants[0].price_short);
// Deve mostrar: "R$ XXX,XX"

console.log(LS.variants.length);
// Deve mostrar: número > 0 (variantes carregadas)

// Selecionar tamanho e verificar:
const priceElement = document.querySelector('.js-price-display');
console.log(priceElement.innerText);
// Deve mostrar valor atualizado
```

**Status:**
- [ ] ✅ PASS — Preço atualiza quando muda tamanho
- [ ] ❌ FAIL — Preço não atualiza ou está errado
- [ ] ⚠️ CONCERNS — Atualiza com delay ou inconsistente

**Comentários:** ___________________________

---

### **3️⃣ MUDAR TAMANHO → PARCELAMENTO ATUALIZA** 🟠 ALTA

**Teste:**
```
1. Na página PDP, registrar parcelamento inicial:
   - Procurar: ".js-max-installments" ou "até X sem juros"
   - Notar: exemplo "até 12x sem juros"
2. Selecionar tamanho diferente
3. Verificar parcelamento:
   - Número de parcelas mudou?  ✓ Esperado: DEPENDE de preço
   - Se preço = mesmo, parcelas = mesmas
   - Se preço ≠ diferente, parcelas podem mudar
   - Renderização ficou vazia?  ✓ Esperado: NÃO
```

**Validação no Console:**
```javascript
// Verificar dados de parcelamento:
const variant = LS.variants[0];
console.log(variant.installments_data);
// Deve ser string JSON, não vazia

// Verificar parse:
const parsed = JSON.parse(variant.installments_data);
console.log(parsed);
// Deve ter estrutura válida com "Nuvem Pago"

// Verificar renderização:
console.log(document.querySelector('.js-max-installments').innerText);
// Deve conter número de parcelas e "sem juros"
```

**Status:**
- [ ] ✅ PASS — Parcelamento renderizado corretamente
- [ ] ❌ FAIL — Parcelamento vazio ou quebrado
- [ ] ⚠️ CONCERNS — Renderização lagada ou incompleta

**Comentários:** ___________________________

---

### **4️⃣ BOTÃO "ADICIONAR AO CARRINHO" FUNCIONA** 🔴 CRÍTICO

**Teste:**
```
1. Selecionar tamanho (de novo)
2. Clicar no botão "Adicionar ao Carrinho"
3. Verificar comportamento:
   - Carrinho foi atualizado?  ✓ Esperado: SIM (notificação?)
   - Página mudou para checkout?  ✓ Depende de UX
   - Erro apareceu?  ✓ Esperado: NÃO
   - Quantidade aumentou no carrinho?  ✓ Esperado: SIM
```

**Validação no Console:**
```javascript
// Verificar se formulário é valido:
const form = document.querySelector('.js-product-form');
console.log(form.elements['variante'].value);
// Deve ter valor (não vazio)

// Simular clique no botão:
document.querySelector('.js-addtocart').click();
// Observar console para erros
console.log('Click executado');
```

**Status:**
- [ ] ✅ PASS — Botão funciona e carrinho atualiza
- [ ] ❌ FAIL — Botão não faz nada ou erro
- [ ] ⚠️ CONCERNS — Funciona mas lentamente/com erro

**Comentários:** ___________________________

---

### **5️⃣ REVIEWS WIDGET CARREGANDO** 🟠 ALTA

**Teste:**
```
1. Descer a página até seção de Reviews
2. Verificar:
   - Container ".pg-pdp-extras-container" é visível?  ✓ Esperado: SIM
   - Tem reviews de clientes?  ✓ Esperado: SIM (ou widget placeholder)
   - Não está com "display: none"?  ✓ Esperado: NÃO
   - Elementos vistos em DevTools?  ✓ Esperado: SIM
3. Se não há reviews:
   - Widget de reviews está presente?  ✓ Esperado: SIM
   - Message "Sem reviews ainda" aparece?  ✓ Aceitável
```

**Validação no Console:**
```javascript
// Verificar se container tem conteúdo:
const container = document.querySelector('.pg-pdp-extras-container');
console.log(container.innerHTML.length);
// Deve ser > 0 (não vazio)

// Verificar se está oculto por CSS:
const styles = window.getComputedStyle(container);
console.log(styles.display);
// Deve ser: 'block' (não 'none')

// Verificar se widget de reviews carregou:
console.log(document.querySelector('#reviewsapp'));
// Se null = não carregou, mas pode ser OK se estrutura presente
```

**Status:**
- [ ] ✅ PASS — Reviews visível e carregando
- [ ] ❌ FAIL — Reviews ocultos ou nunca carregam
- [ ] ⚠️ CONCERNS — Widget presente mas sem dados (aceitável)

**Comentários:** ___________________________

---

### **6️⃣ CALCULADORA DE FRETE FUNCIONA** 🟠 ALTA

**Teste:**
```
1. Na página PDP, procurar seção de Frete/Shipping
2. Entrar CEP válido:
   - CEP: 88015-500 (San Catarina - teste)
3. Clicar "Calcular Frete"
4. Verificar:
   - Opções de frete aparecem?  ✓ Esperado: SIM
   - Network request foi feito?  ✓ Esperado: SIM (ver em Network tab)
   - Erro de CORS ou 404?  ✓ Esperado: NÃO
   - Resultado é válido?  ✓ Esperado: SIM

Nota: Se houver mensagem "Frete calculado no checkout", é OK
```

**Validação no Console + Network:**
```
1. Abrir DevTools
2. Aba: Network
3. Filtro: "shipping" ou "/fretes"
4. Entrar CEP: 88015-500
5. Clicar "Calcular"
6. Procurar em Network:
   - Request com 200 OK?  ✓ Esperado: SIM
   - Status 404/CORS error?  ✓ Esperado: NÃO
   - Response tem array de opções?  ✓ Esperado: SIM

// No console:
console.log(LS.shippingOptions);
// Deve ter opções de frete, não null
```

**Status:**
- [ ] ✅ PASS — Frete calcula e mostra opções
- [ ] ❌ FAIL — Frete não funciona ou erro AJAX
- [ ] ⚠️ CONCERNS — Funciona com delay ou sem validação CEP

**Comentários:** ___________________________

---

### **7️⃣ NENHUMA VIOLAÇÃO NUVEMSHOP CONSTRAINTS** 🔴 CRÍTICO

**Teste:**
```
1. Inspecionar HTML da página
2. Verificar que NENHUM arquivo violou constraints:

Arquivo: product.tpl (estrutura checkout)
- [ ] Não foi modificado (estrutura = original)
- [ ] Formulário checkout não foi alterado
- [ ] Campos de pagamento intactos

Arquivo: product-form.js (JavaScript)
- [ ] Não sobrescreve funções Nuvemshop (Nuvemshop.checkout)
- [ ] Usa namespace próprio se customizado
- [ ] Event listeners não conflitam

Arquivo: product-styles.css (CSS)
- [ ] Não oculta elementos checkout com display:none
- [ ] Não oculta footer attribution
- [ ] Não quebra responsive layout

Arquivo: Nenhuma injeção de JavaScript malicioso
- [ ] Console não mostra erros de segurança
- [ ] Sem eval() ou code injection
```

**Validação no Console:**
```javascript
// Procurar por violações comuns:
console.log(window.Nuvemshop);
// Deve estar intacto, não sobrescrito

console.log(document.querySelector('footer').innerText);
// Deve ter "Nuvemshop" ou "store name"

// Procurar por CSS violations:
const footer = document.querySelector('footer');
const styles = window.getComputedStyle(footer);
console.log(styles.display);
// Deve ser 'block', não 'none'

// Ver se há erros no console:
// Network tab:
// - Arquivos com 404?  ✓ Esperado: NÃO
// - CORS errors?  ✓ Esperado: NÃO
```

**Status:**
- [ ] ✅ PASS — Nenhuma violação detectada
- [ ] ❌ FAIL — Violações críticas (checkout quebrado, footer hidden)
- [ ] ⚠️ CONCERNS — Violações menores (não impactam funcionalidade)

**Comentários:** ___________________________

---

## 📊 Summary Table

| # | Teste | Status | Comentário |
|---|-------|--------|-----------|
| 1 | Botão Habilita | ⬜ | |
| 2 | Preço Atualiza | ⬜ | |
| 3 | Parcelamento | ⬜ | |
| 4 | Botão Funciona | ⬜ | |
| 5 | Reviews | ⬜ | |
| 6 | Frete | ⬜ | |
| 7 | Constraints | ⬜ | |
| **TOTAL** | **7 PASS?** | ⬜ | |

---

## 🎯 Verdictto Final

**Selecionar UMA opção:**

### ✅ **PASS** — Aprovar para Deployment
Condições:
- [ ] Todos 7 testes = PASS
- [ ] Nenhum FAIL detectado
- [ ] CONCERNS podem aparecer se são menores (não críticos)
- [ ] Está pronto para Story 7 (Deploy)

**Próximo passo:** Chamar @devops para executar deploy

---

### ⚠️ **CONCERNS** — Rejeitar, Mas com Caminhos de Ação
Condições:
- [ ] 5-6 testes = PASS
- [ ] 1-2 testes = CONCERNS (não FAIL)
- [ ] Problemas são corrigíveis rapidamente
- [ ] Caminho de correção claro

**Ação:**
1. Documentar qual teste tem CONCERNS
2. Comunicar para @dev quais fixes faltam
3. @dev faz correção rápida (< 30 min)
4. Re-testar com este checklist
5. Se tudo OK, voltar para PASS

---

### ❌ **FAIL** — Rejeitar, Voltar para Desenvolvimento
Condições:
- [ ] 2+ testes = FAIL
- [ ] Problemas são críticos (não podem ir para prod)
- [ ] Impactam experiência do usuário
- [ ] Violam Nuvemshop constraints

**Ação:**
1. Documentar qual teste falhou e por quê
2. Criar bug report: `docs/reports/pdp-qa-fail-{date}.md`
3. Comunicar para @dev para retrabalho
4. Descrever o erro específico
5. @dev volta a Stories 2-5 para corrigir raiz
6. Após fix, re-submeter para QA

---

## 📝 Documentação de Resultados

### Se PASS:
```
✅ QA GATE PASSED
Data: 2026-03-20
Hora: 18:00 UTC
Aprovado por: @qa (Quinn)
Todos 7 critérios: PASS
Status para Deploy: READY
```

### Se CONCERNS:
```
⚠️ QA GATE: CONCERNS
Data: 2026-03-20
Problemas identificados:
- Teste 3 (Parcelamento): delay de 2 segundos
- Teste 6 (Frete): validação CEP rejeitando alguns formatos

Próximos passos:
1. @dev ajusta {descrição}
2. Re-submeter checklist

Não é bloqueador, mas melhor antes de deploy
```

### Se FAIL:
```
❌ QA GATE FAILED
Data: 2026-03-20
Problemas críticos:
- Teste 1 (CRÍTICO): Botão nunca habilita
  → Causa: Event listener não está funcionando
- Teste 2 (CRÍTICO): Preço não atualiza
  → Causa: JavaScript binding quebrado

Status para Deploy: NÃO PRONTO
Ação: @dev retrabalho de Stories 2-5
```

---

## 📞 Escalação

**Se tiver dúvidas durante teste:**
- Contate @architect (problemas técnicos)
- Contate @dev (se teste quebrar durante execução)
- Contate Gabriel (decisões finais)

---

## ✨ Notas Finais

- **Tempo esperado:** 30-45 minutos
- **Nenhum teste demanda > 5 minutos**
- **Se algum teste prender > 10 min, escalpe para @architect**
- **Documentar TUDO em comentários (será útil para @devops)**

---

**Pronto para QA Gate?**

Assine:
- Data: ______________
- @qa (Quinn): ______________
- Verdict: ______________

---

*AIOX QA Gate Checklist — Story 6*
*Compliance: Article V (Quality First) ✅*
