# Plano de Estabilização PDP — Patagang Ecommerce
**Data:** 2026-03-20
**Status:** 📋 Planejamento AIOX Formalizado
**Objetivo:** Estabilizar página de produto com rotina de deploy segura (backup + versionamento)
**Padrão:** AIOX Story Development Cycle (SDC) + Deploy Workflow

---

## 📊 Resumo Executivo

| Métrica | Valor |
|---------|-------|
| **Problemas a Resolver** | 7 (2 críticos, 3 altos, 2 médios) |
| **Estimativa** | 2-4 horas (dev) + 30 min (QA) + 15 min (deploy) |
| **Risk Level** | ALTO (página não funciona atualmente) |
| **Deploy Strategy** | FTP com backup automático + versionamento |
| **Approval Gates** | 4 (após análise, fix dev, QA, pre-deploy) |

---

## 🎯 Objetivo Final

**Página de produto completamente funcional:**
- ✅ Botão "Adicionar ao Carrinho" habilitado após seleção de tamanho
- ✅ Seletor de variantes atualiza preço, parcelamento, botão
- ✅ Reviews carregando corretamente
- ✅ Calculadora de frete funcionando
- ✅ Parcelamento renderizado corretamente
- ✅ Deploy com backup e versionamento visível no console

---

## 🔍 Root Cause Analysis (RCA)

### Problema Primário: JavaScript Binding Quebrado
**Evidência:** Botão `.js-addtocart` está com classe `disabled` e nunca é habilitado.

**Causa Raiz Provável:**
1. Event listener no `select.js-variation-option` não está funcionando
2. OU arquivo `product-form.js` tem lógica quebrada
3. OU alterações recentes no tema violaram Nuvemshop constraints (Artigo VI — File Structure)

**Hipótese:** Última alteração ao tema quebrou ou sobrescreveu handlers Nuvemshop.

---

## 📋 Plano de Ação (Story Development Cycle)

### **STORY 1: Análise Profunda & Validação de Constraints**
**Sprint:** Imediato
**Responsável:** @dev + @architect
**Duração:** 30-45 min

**Acceptance Criteria:**
- [ ] Verificar se arquivos do tema violam Nuvemshop constraints (checkout, forms)
- [ ] Listar todas as alterações no último commit vs. versão funcional
- [ ] Identificar qual mudança quebrou variantes binding
- [ ] Confirmar que `LS.variants` está populado corretamente
- [ ] Testar manualmente console: `document.querySelector('.js-variation-option')`

**Deliverables:**
- Relatório: `docs/reports/constraint-validation.md`
- Checklist: Quais arquivos foram alterados no último commit

**Exit Criteria:** ✅ Constraint violations identified (if any)

---

### **STORY 2: Fix #1 — Habilitar Botão Adicionar ao Carrinho**
**Sprint:** P0 (prioritário)
**Responsável:** @dev
**Duração:** 45-60 min

**Acceptance Criteria:**
- [ ] Botão `.js-addtocart` **NÃO MAIS** tem classe `disabled` após seleção
- [ ] JavaScript handler para `change` event existe no `.js-variation-option`
- [ ] Teste manual: selecionar tamanho → botão habilita
- [ ] Nenhuma violação de Nuvemshop constraints (não toca checkout form)

**Technical Details:**
```javascript
// Deve existir em product-form.js:
document.querySelector('.js-variation-option')?.addEventListener('change', function() {
  const variant = LS.variants.find(v => v.id == this.value);
  if (variant && variant.available) {
    btn.classList.remove('disabled');
  }
});
```

**Files to Modify:**
- `theme-deploy-corrigido/static/js/product-form.js` (ou similar)

**Exit Criteria:** ✅ Botão habilita quando tamanho selecionado

---

### **STORY 3: Fix #2 — Atualizar Preço & Parcelamento**
**Sprint:** P0
**Responsável:** @dev
**Duração:** 45-60 min

**Acceptance Criteria:**
- [ ] Seleção de tamanho atualiza preço em tempo real
- [ ] Parcelamento atualiza com dados da variante selecionada
- [ ] Imagem do produto atualiza (se multi-imagem)
- [ ] Stock/disponibilidade atualiza
- [ ] Nenhuma violação de Nuvemshop constraints

**Technical Details:**
```javascript
// No mesmo handler change:
const variant = LS.variants.find(v => v.id == this.value);
document.querySelector('.js-price-display').innerText = variant.price_short;
// Atualizar parcelamento via JSON.parse()
document.querySelector('.js-max-installments').innerText = variant.installments_text;
```

**Files to Modify:**
- `theme-deploy-corrigido/static/js/product-form.js`

**Exit Criteria:** ✅ Preço e parcelamento atualizam corretamente

---

### **STORY 4: Fix #3 — Remover CSS de Reviews & Habilitar**
**Sprint:** P1
**Responsável:** @dev
**Duração:** 15-20 min

**Acceptance Criteria:**
- [ ] CSS `.pg-pdp-extras-container:empty { display: none; }` removido
- [ ] Reviews widget carrega (ou fallback texto aparece)
- [ ] Reviews widget **NUNCA** é oculto por CSS
- [ ] Nenhuma violação de Nuvemshop constraints

**Files to Modify:**
- `theme-deploy-corrigido/static/css/product-styles.css` (ou similar)

**Exit Criteria:** ✅ Reviews container visível

---

### **STORY 5: Fix #4 — Consolidar CSS Duplicado**
**Sprint:** P2
**Responsável:** @dev
**Duração:** 20-30 min

**Acceptance Criteria:**
- [ ] CSS duplicado para `.pg-variants-container` consolidado
- [ ] `.pg-variant-group` classes fundidas
- [ ] Select de tamanho tem altura adequada (não 0px)
- [ ] Nenhum overflow: hidden cortando opções
- [ ] DevTools mostra CSS consolidado

**Files to Modify:**
- `theme-deploy-corrigido/static/css/product-styles.css`

**Exit Criteria:** ✅ CSS limpo e sem cascata confusa

---

### **STORY 6: QA Gate — Validação Funcional Completa**
**Sprint:** Após fixes
**Responsável:** @qa
**Duração:** 30-45 min

**Acceptance Criteria (7-point checklist):**
- [ ] **Tamanho:** Selecionar tamanho → botão habilita
- [ ] **Preço:** Tamanho diferente → preço atualiza
- [ ] **Parcelamento:** Tamanho diferente → parcelamento atualiza
- [ ] **Botão Carrinho:** Clicável e não quebrado
- [ ] **Reviews:** Visível e carregando
- [ ] **Frete:** AJAX testado, calcula corretamente
- [ ] **Constraints:** Nenhuma violação Nuvemshop

**Testing Procedure:**
```bash
# 1. Abrir página PDP em navegador
# 2. DevTools → Console
# 3. Testar variação:
#    - Clicar select tamanho
#    - Verificar botão habilita
#    - Verificar preço muda
# 4. Testar frete:
#    - Entrar CEP: 88015-500
#    - Network tab aberto
#    - Procurar erro CORS/404
# 5. Testar reviews:
#    - Descer página
#    - Verificar reviews widget visível
```

**Exit Criteria:** ✅ Todos 7 itens passam

---

### **STORY 7: Deploy com Backup & Versionamento**
**Sprint:** Final (após QA PASS)
**Responsável:** @devops
**Duration:** 30-45 min

**Acceptance Criteria:**
- [ ] Backup automático criado: `backups/pdp-fix-20260320-v1.1.5-{timestamp}.tar.gz`
- [ ] Arquivos incrementados listados no backup
- [ ] Versão incrementada: v1.1.6 (minor bump)
- [ ] Git commit com mensagem: `fix: Estabilizar PDP — habilitar variantes, preço, botão [Story 7]`
- [ ] Console mostra:
  ```
  ✅ BACKUP CRIADO: backups/pdp-fix-20260320-v1.1.5-1711001200.tar.gz
  📦 Arquivos incrementados: 3
     - product-form.js
     - product-styles.css
     - …
  🚀 Deploy: v1.1.5 → v1.1.6
  ✅ FTP Upload: 3 arquivos (X KB total)
  ✅ Deployment completo com sucesso
  ```
- [ ] PR criada com todos os arquivos modificados
- [ ] Version tag criada no git: `v1.1.6-pdp-stabilization`

**Exit Criteria:** ✅ Deployed e visível em produção

---

## 🚀 Rotina de Deploy Detalhada (AIOX-Compliant)

### Pre-Deploy Checklist (@dev):
```bash
✅ Lint: npm run lint
✅ Tests: npm test (if applicable)
✅ TypeCheck: npm run typecheck
✅ Manual testing: Todos os cenários PDP
✅ CodeRabbit: Self-healing max 2 iterations
✅ Git status: Todos os arquivos staged
```

### Deploy Workflow (@devops — EXCLUSIVE):

#### **Phase 1: Análise de Incrementos**
```bash
git diff HEAD~1 HEAD --name-only
# Output esperado:
#   theme-deploy-corrigido/static/js/product-form.js
#   theme-deploy-corrigido/static/css/product-styles.css
#   [outros 1-2 arquivos]
```

#### **Phase 2: Backup Automático**
```bash
# Timestamp: 2026-03-20T18:30:00Z (substitua com NOW)
TIMESTAMP=$(date +%s)
BACKUP_FILE="backups/pdp-fix-20260320-v1.1.5-${TIMESTAMP}.tar.gz"

# Arquivos a fazer backup (somente incrementos):
tar -czf "${BACKUP_FILE}" \
  theme-deploy-corrigido/static/js/product-form.js \
  theme-deploy-corrigido/static/css/product-styles.css \
  [outros incrementos]

echo "✅ BACKUP CRIADO: ${BACKUP_FILE}"
ls -lh "${BACKUP_FILE}"
```

#### **Phase 3: FTP Upload**
```bash
# Usar FTP client com credenciais Nuvemshop
ftp -v -n < <<EOF
open ftp.nuvemshop.com.br
quote USER {ftp_user}
quote PASS {ftp_password}
binary
cd /templates/006/603/800/twig/
put theme-deploy-corrigido/static/js/product-form.js
put theme-deploy-corrigido/static/css/product-styles.css
[outros arquivos]
bye
EOF

echo "✅ FTP Upload: 3 arquivos"
```

#### **Phase 4: Versionamento & Tagging**
```bash
# Incrementar versão
# De: 1.1.5 → Para: 1.1.6
npm version minor -m "fix: Estabilizar PDP [Story 7]"
# Output:
# v1.1.6

git tag -a v1.1.6-pdp-stabilization -m "PDP Stabilization: variantes, preço, botão"

# Criar PR com todos os arquivos
gh pr create \
  --title "fix: Estabilizar página de produto — variantes e preço [Story 7]" \
  --body "## Summary
Correção crítica da página de produto (PDP):
- ✅ Botão Adicionar ao Carrinho habilitado após seleção
- ✅ Preço e parcelamento atualizam com variante
- ✅ Reviews carregando corretamente
- ✅ CSS duplicado consolidado

## Acceptance Criteria
- [x] AC 1: Botão habilita
- [x] AC 2: Preço atualiza
- [x] AC 3: Reviews visível
- [x] AC 4: QA Gate PASSED

## Changes
- product-form.js (variantes binding)
- product-styles.css (CSS cleanup)

## Backup
- backups/pdp-fix-20260320-v1.1.5-${TIMESTAMP}.tar.gz

## Test Plan
- [x] All QA checks passing
- [x] Lint passing
- [x] Manual testing: variantes, preço, frete"

# Output esperado:
# ✅ Pull request created: https://github.com/.../pull/XXX

git push origin main
git push origin v1.1.6-pdp-stabilization
```

#### **Phase 5: Console Output (Visible to User)**
```
═══════════════════════════════════════════════════════════════════
  🚀 PATAGANG ECOMMERCE — DEPLOYMENT ROUTINE
═══════════════════════════════════════════════════════════════════

📋 DEPLOYMENT: PDP Stabilization v1.1.6
🕐 Timestamp: 2026-03-20T18:30:00Z
👤 Deployed by: @devops (Gabriel)

═══════════════════════════════════════════════════════════════════
PHASE 1: Verificando Incrementos
═══════════════════════════════════════════════════════════════════
✅ Git analysis complete
   Modified files (3):
     • theme-deploy-corrigido/static/js/product-form.js
     • theme-deploy-corrigido/static/css/product-styles.css
     • [arquivo 3]

═══════════════════════════════════════════════════════════════════
PHASE 2: Backup Automático
═══════════════════════════════════════════════════════════════════
✅ BACKUP CRIADO com sucesso:
   📦 backups/pdp-fix-20260320-v1.1.5-1711001200.tar.gz
   📊 Size: 45 KB
   📝 Contents:
      • product-form.js (8.2 KB)
      • product-styles.css (12.5 KB)
      • [arquivo 3] (XX KB)

═══════════════════════════════════════════════════════════════════
PHASE 3: FTP Upload para Nuvemshop
═══════════════════════════════════════════════════════════════════
🔗 Conectando a: ftp.nuvemshop.com.br
✅ Autenticado
📤 Upload iniciado...
   ✅ product-form.js (8.2 KB)
   ✅ product-styles.css (12.5 KB)
   ✅ [arquivo 3]
✅ FTP Upload: COMPLETO
   Total: 3 arquivos | 45 KB

═══════════════════════════════════════════════════════════════════
PHASE 4: Versionamento & Git
═══════════════════════════════════════════════════════════════════
📌 Version Bump:
   v1.1.5 → v1.1.6
✅ Git commit: abc123def456...
   Message: "fix: Estabilizar PDP — variantes, preço, botão [Story 7]"
✅ Git tag: v1.1.6-pdp-stabilization
✅ Pull Request criada:
   https://github.com/seu-org/seu-repo/pull/42
✅ Push para origin/main: COMPLETO

═══════════════════════════════════════════════════════════════════
PHASE 5: Post-Deploy Validation
═══════════════════════════════════════════════════════════════════
✅ FTP files verified (3/3 uploaded)
✅ Version tag confirmed: v1.1.6
✅ Git history updated
✅ Backup accessible: backups/pdp-fix-20260320-v1.1.5-1711001200.tar.gz

═══════════════════════════════════════════════════════════════════
🎉 DEPLOYMENT COMPLETO COM SUCESSO
═══════════════════════════════════════════════════════════════════
Status: ✅ DEPLOYED
Version: v1.1.6-pdp-stabilization
Time: 2026-03-20 18:30:00 UTC

Verificar produção em: https://www.patagang.com.br/produtos/...

🔙 Rollback disponível em caso de emergência:
   tar -xzf backups/pdp-fix-20260320-v1.1.5-1711001200.tar.gz
   FTP upload dos arquivos originais

═══════════════════════════════════════════════════════════════════
```

---

## 📁 Arquivos para Modificar

### Critical (Fix bugs):
1. **theme-deploy-corrigido/static/js/product-form.js**
   - Adicionar event listener para `.js-variation-option`
   - Implementar lógica de atualização de preço/parcelamento
   - Habilitar botão após seleção

2. **theme-deploy-corrigido/static/css/product-styles.css**
   - Remover CSS `.pg-pdp-extras-container:empty { display: none; }`
   - Consolidar CSS duplicado para variantes
   - Garantir select tem altura adequada

### Verify (não modificar):
- **theme-deploy-corrigido/layouts/product.tpl** — Estrutura OK, não toque
- **theme-deploy-corrigido/snipplets/*** — Validar constraints

---

## ✅ Quality Gates

### Gate 1: Análise Concluída
- [ ] RCA documentada
- [ ] Constraint violations identificadas
- [ ] Arquivos a modificar listados

### Gate 2: Desenvolvimento Concluído
- [ ] Todos os fixes implementados
- [ ] Lint passing
- [ ] Nuvemshop constraints respeitadas

### Gate 3: QA Approval
- [ ] 7-point checklist all PASSED
- [ ] Manual testing successful
- [ ] No regressions detected

### Gate 4: Pre-Deploy Checklist
- [ ] Backup criado e validado
- [ ] Versão pronta para bump
- [ ] Git commits estruturados
- [ ] Pronto para @devops push

---

## 🎯 Timeline Estimado

| Fase | Duração | Responsável |
|------|---------|-------------|
| Story 1: Análise | 30-45 min | @dev |
| Story 2-5: Fixes | 2.5-3 horas | @dev |
| Story 6: QA Gate | 30-45 min | @qa |
| Story 7: Deploy | 30-45 min | @devops |
| **TOTAL** | **4-5 horas** | **Todo o time** |

**Início Recomendado:** Imediato (é crítico — page não funciona)
**Deadline:** Hoje (2026-03-20) EOD

---

## 📚 Arquivos de Referência

- **Análise Estrutural:** `docs/reports/pdp-structural-analysis-report.md`
- **Nuvemshop Constraints:** `docs/guides/nuvemshop/NUVEMSHOP_FTP_STANDARDS.md`
- **Deploy Checklist:** `.aiox-core/development/tasks/github-local-integration-checklist.md`
- **FTP Standards:** `.aiox-core/data/nuvemshop-patterns.yaml`

---

## 🔐 Nuvemshop Constraint Validation

**CRITICAL:** Nenhuma das alterações deve violar Nuvemshop constraints (Article VI — File Structure).

**Archivos permitidos para modificar:**
- ✅ JavaScript customizado: `static/js/`
- ✅ CSS customizado: `static/css/`
- ✅ Imagens/assets: `static/images/`

**Arquivos PROIBIDOS (não toque):**
- ❌ `layouts/checkout.tpl` — NUNCA modify
- ❌ `layouts/product.tpl` — Estrutura não, apenas CSS/JS
- ❌ Formulários do Nuvemshop — Validação no backend

---

## 🚨 Rollback Plan (Emergency Only)

Se algo der errado em produção:

```bash
# 1. Stop — Compar desenvolvimento
# 2. Extrair backup:
tar -xzf backups/pdp-fix-20260320-v1.1.5-1711001200.tar.gz

# 3. Re-upload via FTP:
ftp ftp.nuvemshop.com.br
# Upload dos arquivos extraídos

# 4. Git revert:
git revert {commit-hash}

# 5. Version downgrade:
git tag v1.1.5-rollback

echo "✅ Rollback complete — reverting to v1.1.5"
```

---

## 📞 Next Steps

1. **@dev:** Comece com **Story 1 — Análise Profunda**
   - Investigar quais arquivos foram alterados no último commit
   - Validar contra Nuvemshop constraints

2. **@dev:** Proceda com **Stories 2-5 — Fixes**
   - Implementar event listeners
   - Consolidar CSS
   - Test localmente

3. **@qa:** **Story 6 — QA Gate**
   - Validar todos os 7 critérios
   - Manual testing em staging

4. **@devops:** **Story 7 — Deploy**
   - Criar backup automático
   - Fazer upload via FTP
   - Incrementar versão e criar PR

---

**Plano finalizado e pronto para execução AIOX-compliant.**

---

*AIOX Story Development Cycle — Versão 2.0*
*Compliance: Article I (CLI First) ✅ | Article III (Story-Driven) ✅ | Article V (Quality First) ✅*
