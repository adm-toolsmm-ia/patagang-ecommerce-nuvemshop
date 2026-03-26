# Guia de Execução — Deploy PDP Stabilization
**Versão:** 1.1.6
**Data:** 2026-03-20
**Para:** Gabriel Cristofolini (@devops)
**Padrão:** AIOX Story Development Cycle + Deploy Workflow

---

## 🎯 Objetivo

Estabilizar a página de produto (PDP) do Patagang e fazer deploy seguro com:
- ✅ Backup automático dos arquivos incrementados
- ✅ Upload FTP para Nuvemshop
- ✅ Versionamento com Git + tags
- ✅ PR criada automaticamente
- ✅ Console output claro e rastreável

---

## 📋 Pré-Requisitos

Antes de executar a rotina, validar:

### 1. **Credenciais FTP Configuradas**
```bash
# No terminal, verificar:
echo $FTP_USER
echo $FTP_PASSWORD

# Se vazias, configurar:
export FTP_USER="seu_usuario_ftp"
export FTP_PASSWORD="sua_senha_ftp"

# Ou criar arquivo .env na raiz:
cat > .env << 'EOF'
FTP_USER=seu_usuario_ftp
FTP_PASSWORD=sua_senha_ftp
EOF
```

### 2. **GitHub CLI Instalado**
```bash
# Verificar:
gh auth status

# Se não instalado:
# macOS: brew install gh
# Linux: apt install gh (ou similar)
# Windows: scoop install gh (ou choco install gh)
```

### 3. **Arquivos de Fix Prontos**
```bash
# Verificar que estes arquivos existem:
ls -la theme-deploy-corrigido/static/js/product-form.js
ls -la theme-deploy-corrigido/static/css/product-styles.css

# Se não existem, esses são os arquivos que @dev deve modificar
```

### 4. **Git Status Limpo**
```bash
git status
# Resultado esperado: "working tree clean"

# Se houver mudanças não commitadas:
git add .
git commit -m "fix: PDP stabilization fixes [Story 2-5]"
```

---

## 🚀 Executar Rotina de Deploy

### **Opção 1: Deploy Completo (Recomendado)**

```bash
# Navegar até o projeto
cd ~/documents/solucoessistemas/patagang-ecommerce-nuvemshop

# Executar rotina completa
bash ftp-deploy/deploy-pdp-stabilization.sh
```

**Output esperado:**
```
🚀 PATAGANG ECOMMERCE — DEPLOYMENT ROUTINE

═══════════════════════════════════════════════════════════════════
PHASE 0: Pre-Flight Checks
═══════════════════════════════════════════════════════════════════

✅ Encontrado: product-form.js (8234 bytes)
✅ Encontrado: product-styles.css (12567 bytes)
✅ Todos os arquivos validados com sucesso
✅ Git status: limpo
✅ Credenciais FTP validadas

[... fases 1-4 ...]

📊 RESUMO DE DEPLOYMENT

Status: ✅ SUCESSO
Detalhes:
  📦 Deployment: PDP Stabilization
  🕐 Timestamp: 2026-03-20T18:30:00Z
  👤 Deployed by: @devops
  📌 Versão: 1.1.5 → 1.1.6
  📁 Arquivos: 2
  💾 Backup: backups/pdp-fix-1.1.5-1711001200.tar.gz
```

---

### **Opção 2: Teste Dry-Run (Sem Fazer Mudanças)**

```bash
# Simular deploy sem fazer mudanças reais:
bash ftp-deploy/deploy-pdp-stabilization.sh --dry-run

# Saída mostra exatamente o que faria, sem executar
```

**Use dry-run para:**
- Testar a rotina antes de rodar de verdade
- Validar credenciais sem riscos
- Checklist de itens antes de deployment real

---

### **Opção 3: Deploy com Modo Verbose**

```bash
# Ver todos os detalhes de execução:
bash ftp-deploy/deploy-pdp-stabilization.sh --verbose

# Mostra cada comando executado com set -x
```

---

## 🔍 Validar Deployment

Após sucesso, validar que deploy foi bem-sucedido:

### 1. **Verificar Backup Criado**
```bash
ls -lh backups/pdp-fix-*.tar.gz | tail -1

# Deve mostrar:
# -rw-r--r-- ... 45K ... pdp-fix-1.1.5-1711001200.tar.gz
```

### 2. **Verificar Git Versioning**
```bash
git log --oneline -5
# Deve mostrar novo commit com "fix: Estabilizar PDP..."

git tag -l | grep pdp-stabilization
# Deve mostrar: v1.1.6-pdp-stabilization

cat package.json | grep version
# Deve mostrar: "version": "1.1.6"
```

### 3. **Verificar PR Criada**
```bash
gh pr list --state open
# Deve mostrar PR recém-criada: "fix: Estabilizar PDP..."

# Ver detalhes da PR:
gh pr view {numero}
```

### 4. **Verificar Produção**
```
1. Ir para: https://www.patagang.com.br/produtos/patagang-jui-street-camiseta-protetores/

2. Testar:
   - Selecionar tamanho → botão habilita?
   - Mudar tamanho → preço atualiza?
   - Descer → reviews carregando?
   - Entrar CEP → frete calcula?

3. DevTools Console:
   - Algum erro JavaScript?
   - document.querySelector('.js-addtocart').classList
     → Deve NÃO ter 'disabled'
```

---

## 🔧 Solução de Problemas

### **Problema: "FTP_USER ou FTP_PASSWORD não definidos"**

**Solução:**
```bash
# Verificar credenciais FTP Nuvemshop:
# 1. Ir para Admin Nuvemshop
# 2. Configurações → Acesso FTP
# 3. Copiar User e Password

# Configurar no terminal:
export FTP_USER="seu_usuario_obtido_acima"
export FTP_PASSWORD="sua_senha_obtida_acima"

# Reexecutar:
bash ftp-deploy/deploy-pdp-stabilization.sh
```

---

### **Problema: "Git status não está limpo"**

**Solução:**
```bash
# Ver mudanças:
git status

# Opção A: Commit mudanças não desejadas
git add .
git commit -m "chore: cleanup before deployment"

# Opção B: Descartar mudanças (CUIDADO)
git checkout .
```

---

### **Problema: "Arquivo não encontrado"**

**Solução:**
```bash
# Verificar que @dev modificou os arquivos:
ls -la theme-deploy-corrigido/static/js/product-form.js
ls -la theme-deploy-corrigido/static/css/product-styles.css

# Se não existem, os fixes ainda não foram implementados
# Aguarde @dev completar Stories 2-5
```

---

### **Problema: "FTP Upload falhou"**

**Solução:**
```bash
# Ver log detalhado:
# A rotina salva log em /tmp/ftp-log-{timestamp}.log

cat /tmp/ftp-log-* | tail -50

# Possíveis causas:
# 1. Credenciais incorretas
# 2. Conectividade FTP bloqueada
# 3. Arquivo removido/movido no servidor

# Tentar novamente com verbose:
bash ftp-deploy/deploy-pdp-stabilization.sh --verbose
```

---

### **Problema: "Quero reverter deployment"**

**Solução (Rollback):**
```bash
# Restaurar versão anterior do backup:
bash ftp-deploy/deploy-pdp-stabilization.sh --rollback

# Isso extrai os arquivos originais em /tmp/rollback-{timestamp}
# Você deve re-fazer upload via FTP manualmente

# OU reverter commit Git:
git revert {commit-hash}
git push origin main

# OU downgrade de versão:
npm version patch -m "revert: Rollback PDP stabilization"
```

---

## 📝 Checklist Pré-Deploy

Antes de executar, validar:

- [ ] **@dev:** Stories 2-5 completadas (fixes implementados)
- [ ] **@qa:** Story 6 PASSED (7-point checklist tudo OK)
- [ ] **@devops:** Git status limpo
- [ ] **@devops:** Credenciais FTP funcionando
- [ ] **@devops:** GitHub CLI autenticado
- [ ] **@devops:** Backup directory existe: `backups/`
- [ ] **@devops:** Nenhuma outra deployment em progress
- [ ] **@devops:** Canais de comunicação abertos (em caso de problema)

---

## 📞 Contato & Escalação

Se algo der errado durante deployment:

1. **Stop imediatamente** — Não continue
2. **Verificar log:** `/tmp/ftp-log-*.log`
3. **Ligar rollback:** `bash deploy-pdp-stabilization.sh --rollback`
4. **Comunicar:**
   - @architect (problemas técnicos)
   - @qa (precisa re-validar)
   - Gabriel (responsável final)

---

## 🎯 Resultado Esperado Após Deployment

✅ **Página de Produto Funcionando:**
- Botão "Adicionar ao Carrinho" **habilitado** após seleção
- Preço **atualiza** quando muda tamanho
- Parcelamento **atualiza** dinamicamente
- Reviews **carregam** corretamente
- Frete **calcula** com CEP
- **Nenhum erro** no console JavaScript

✅ **Histórico Git:**
```
- Commit: fix: Estabilizar PDP [Story 7]
- Tag: v1.1.6-pdp-stabilization
- Version: 1.1.6 em package.json
- PR: Pull request #XX mergeada
```

✅ **Backup Criado:**
```
- Arquivo: backups/pdp-fix-1.1.5-{timestamp}.tar.gz
- Conteúdo: product-form.js, product-styles.css
- Accessible: Sim, para rollback se necessário
```

---

## 🚨 SLA & Timeline

| Fase | Tempo Estimado | Responsável |
|------|-----------------|-------------|
| Pre-flight checks | 2-3 min | Você |
| Backup création | 1-2 min | Script |
| FTP Upload | 2-3 min | Script |
| Git tagging | 1-2 min | Script |
| PR creation | 1 min | Script |
| **TOTAL** | **7-11 min** | **Você** |

**Tempo total de execução:** ~10 minutos

---

## 📚 Referência Rápida

| Comando | O que faz |
|---------|-----------|
| `bash deploy-pdp-stabilization.sh` | Deploy completo (normal) |
| `bash deploy-pdp-stabilization.sh --dry-run` | Teste sem mudanças |
| `bash deploy-pdp-stabilization.sh --verbose` | Debug detalhado |
| `bash deploy-pdp-stabilization.sh --rollback` | Reverter para backup |
| `bash deploy-pdp-stabilization.sh --help` | Ver ajuda |

---

## ✅ Sign-Off

Quando deployment estiver completo:

1. ✅ Validar em produção
2. ✅ Comunicar ao time em Slack/email
3. ✅ Documentar qualquer issue em `docs/reports/`
4. ✅ Arquivar backup por 30 dias
5. ✅ Fechar Story 7 como DONE

---

**Pronto para deploy? 🚀**

Qualquer dúvida, contacte o @architect ou Gabriel Cristofolini.

---

*AIOX Deployment Workflow — Versão 1.1.6*
*Compliance: Article II (Agent Authority) ✅ | @devops EXCLUSIVE for push*
