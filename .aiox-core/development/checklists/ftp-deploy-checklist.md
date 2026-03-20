---
name: FTP Deploy Checklist - AIOX Standard
description: Validação completa antes, durante e depois do deploy FTP
type: checklist
scope: deploy-ftp-standard
executor: @devops
---

# 🚀 FTP Deploy Checklist - Patagang Nuvemshop

## ✅ Pré-Deploy (Antes de Iniciar)

### 1. Preparação Local
- [ ] Branch `main` está sincronizado localmente (`git pull`)
- [ ] Nenhum commit local pendente sem push
- [ ] Arquivo `theme-deploy-corrigido/` sincronizado
- [ ] Nenhum conflito de merge pendente
- [ ] Build/preview testado localmente
- [ ] Mudanças de CSS/JS compiladas e minificadas

### 2. Credenciais & Segurança
- [ ] Arquivo `ftp-deploy/config.js` existe e é válido
- [ ] Credenciais FTP em `config.js` são atuais ✅
- [ ] Arquivo `config.js` está em `.gitignore`
- [ ] Nenhuma senha hardcoded em arquivos tracked
- [ ] Conexão de rede é estável (ping -c 3 ftp.nuvemshop.com.br)

### 3. Estado do Projeto
- [ ] Nenhum deploy em andamento (verificar logs)
- [ ] Último deploy foi bem-sucedido (verificar `LAST_DEPLOY_VERSION.txt`)
- [ ] Espaço em disco disponível: > 500 MB
- [ ] Espaço em disco FTP disponível: > 100 MB (verificar via FTP)

### 4. Dependências
- [ ] Node.js >= 18 instalado (`node -v`)
- [ ] Pacote `basic-ftp` instalado (`npm ls basic-ftp`)
- [ ] Todos os scripts de deploy existem:
  - [ ] `deploy-optimized.js`
  - [ ] `backup-full-ftp.js`
  - [ ] `rollback-incremental.js`
  - [ ] `list-backups.js`
  - [ ] `verify-sync.js`

### 5. Validação FTP
- [ ] Testar conexão FTP:
  ```bash
  cd ftp-deploy
  node -e "const ftp = require('basic-ftp'); const c = new ftp.Client(); c.access({host: 'ftp.nuvemshop.com.br', port: 21, user: process.env.FTP_USER || 'patagang', password: process.env.FTP_PASS || 'SENHA', secure: true}).then(() => { console.log('✅ OK'); c.close(); }).catch(e => { console.log('❌', e.message); });"
  ```
- [ ] Conexão FTP bem-sucedida

### 6. Backup Anterior
- [ ] Último backup incremental acessível (`ls ../backups/incremental/`)
- [ ] Backup anterior tem metadados (`_BACKUP_METADATA.json` existe)
- [ ] Arquivo `LAST_DEPLOY_VERSION.txt` registra versão anterior

---

## 🚀 Durante Deploy

### Fase 1: Iniciar Deploy
```bash
cd ftp-deploy
npm run deploy
```

- [ ] Script inicia sem erros
- [ ] Mensagens de log aparecem no console
- [ ] Conexão FTP é estabelecida

### Fase 2: Validação Pré-Deploy
- [ ] ✓ Verificação de arquivos modificados completa
- [ ] ✓ Cache de MD5 carregado com sucesso
- [ ] ✓ Número de arquivos a fazer upload é razoável (< 100)
- [ ] Mensagem: `Modificados: {N} | Inalterados: {M}`

### Fase 3: Backup Incremental
- [ ] ✓ Diretório de backup criado: `backups/incremental/{TIMESTAMP}/`
- [ ] ✓ Download dos arquivos que serão alterados iniciado
- [ ] ✓ Progress bar avança (0% → 100%)
- [ ] ✓ Metadados salvos: `_BACKUP_METADATA.json`
- [ ] ✓ README de restauração criado
- [ ] Nenhuma falha durante backup (se houver, avaliar)

### Fase 4: Upload para FTP
- [ ] ✓ Upload iniciado após backup bem-sucedido
- [ ] ✓ Progress bar mostra: `[████░░░░] XX% (N/TOTAL) | X.X MB/s`
- [ ] ✓ Cada arquivo é confirmado: `✓ ENVIADO: {arquivo}`
- [ ] ✓ Lotes são processados sequencialmente
- [ ] ✓ Reconexão automática acontece a cada 50 arquivos (se necessário)

### Fase 5: Validação Pós-Upload
- [ ] ✓ Relatório final de sucesso aparece
- [ ] ✓ Número de arquivos enviados corresponde ao esperado
- [ ] ✓ Mensagem: `✓ Sucesso: {N}/{TOTAL} arquivos`
- [ ] ✓ Duração do deploy exibida
- [ ] ✓ Nenhum arquivo com falha crítica

### Fase 6: Atualização de Cache e Logs
- [ ] ✓ Cache de MD5 atualizado (`.deploy-cache.json`)
- [ ] ✓ Arquivo `LAST_DEPLOY_VERSION.txt` atualizado
- [ ] ✓ Histórico registrado em `DEPLOY_HISTORY.json`
- [ ] ✓ Log salvo em `deploy-log.txt`

---

## ✅ Pós-Deploy (Validação em Produção)

### Fase 1: Verificação Imediata
- [ ] ✓ Deploy script encerrou sem erro
- [ ] ✓ Nenhuma mensagem `[ERROR]` no console
- [ ] ✓ Mensagem final: `🎉 Deploy concluído com sucesso`

### Fase 2: Verificar Versão em Console
```bash
# No navegador:
# 1. Abrir: https://patagang.lojavirtualnuvem.com.br/
# 2. Abrir console: F12 ou Cmd+Option+J (Mac)
# 3. Executar: window.__PATAGANG_VERSION__
```

- [ ] ✓ Versão retorna um objeto com:
  - [ ] `version`: versão correta (ex: "1.1.1")
  - [ ] `deployment_date`: timestamp recente
  - [ ] `git_commit`: hash do commit
  - [ ] `git_branch`: "main"
  - [ ] `environment`: "production"

### Fase 3: Limpar Cache Nuvemshop
```
1. Acessar: https://www.nuvemshop.com.br/admin/v2/themes
2. Clique no menu (⋯) do tema ativo
3. Selecionar "Limpar Cache"
4. Aguardar confirmação
```

- [ ] ✓ Cache limpo com sucesso
- [ ] ⏰ Aguardar 3-5 minutos de propagação

### Fase 4: Teste Visual & Funcional
**Desktop (1920x1080):**
- [ ] Página inicial carrega sem erros
- [ ] CSS/JS carregam corretamente
- [ ] Busca funciona
- [ ] Carrinho funciona
- [ ] Checkout acessível
- [ ] Menu responsivo

**Mobile (375x667):**
- [ ] Página inicial responsiva
- [ ] Menu mobile abre/fecha
- [ ] Imagens carregam
- [ ] Busca acessível
- [ ] Carrinho mobile funciona

**Funcionalidades Críticas:**
- [ ] Nenhum erro JavaScript (F12 → Console vazio)
- [ ] Nenhum erro de rede (F12 → Network, 200/304 status)
- [ ] Imagens carregam (sem 404)
- [ ] CSS aplicado corretamente
- [ ] Animações funcionam (se houver)

### Fase 5: Validação Analytics & Monitoramento
- [ ] Google Analytics registra tráfego (sem picos anormais)
- [ ] Nuvemshop Admin mostra loja online
- [ ] Nenhum alerta de performance
- [ ] Nenhuma exceção em logs

### Fase 6: Documentação Final
- [ ] ✓ Versão registrada em `LAST_DEPLOY_VERSION.txt`
- [ ] ✓ Histórico atualizado em `DEPLOY_HISTORY.json`
- [ ] ✓ Log completo em `deploy-log.txt`
- [ ] ✓ Backup incremental acessível para rollback

---

## 🆘 Troubleshooting Durante Deploy

### Erro: "Connection lost" ou "ECONNRESET"
```
✗ Fase 3/4 falha com conexão FTP interrompida
```

**Ação:**
1. [ ] Aguardar 2 minutos
2. [ ] Retry: `npm run deploy`
3. [ ] Script tenta reconectar automaticamente
4. [ ] Se falhar novamente, verificar rede

### Erro: "File not found" ou "Cannot read file"
```
✗ Arquivo local não existe ou caminho errado
```

**Ação:**
1. [ ] Verificar se `theme-deploy-corrigido/` existe
2. [ ] Sincronizar com: `node sync-backup-to-local.js {TIMESTAMP}`
3. [ ] Retry deploy

### Erro: "Authentication failed"
```
✗ Credenciais FTP inválidas
```

**Ação:**
1. [ ] Verificar credenciais em `config.js`
2. [ ] Contatar suporte Nuvemshop se continuar falhando
3. [ ] Usar credenciais de backup (se disponível)

### Deploy lento (> 30 minutos)
```
⚠️ Upload muito lento, pode timeout
```

**Ação:**
1. [ ] Verificar velocidade de internet
2. [ ] Reduzir `BATCH_SIZE` em `deploy-optimized.js` (10 → 5)
3. [ ] Aumentar `TIMEOUT_MS` (300000 → 600000)
4. [ ] Tentar deploy novamente

---

## ⚠️ Rollback - Se Deploy Falhou

### Passo 1: Parar o Deploy (se ainda executando)
```bash
# Ctrl+C para parar o script
```
- [ ] Script parou

### Passo 2: Listar Backups Disponíveis
```bash
npm run list
# Ou
ls ../backups/incremental/
```
- [ ] Identifique o timestamp do backup anterior
- [ ] Anote: `2026-03-20T10-30-45` (exemplo)

### Passo 3: Restaurar Backup
```bash
npm run rollback -- 2026-03-20T10-30-45
# Ou node rollback-incremental.js 2026-03-20T10-30-45
```
- [ ] ✓ Backup restaurado com sucesso
- [ ] ✓ Arquivos sincronizados localmente

### Passo 4: Deploy a Partir do Backup
```bash
npm run deploy
```
- [ ] ✓ Deploy executado com sucesso
- [ ] ✓ Versão restaurada em produção

### Passo 5: Validar em Produção
```javascript
// Console do navegador
window.__PATAGANG_VERSION__
// Deve mostrar versão anterior
```
- [ ] ✓ Versão anterior restaurada
- [ ] ✓ Teste funcionalidades críticas novamente

---

## 📊 Relatório Final

### Status de Deploy
- [ ] **Status:** ✅ SUCESSO | ⚠️ PARCIAL | ❌ FALHA
- [ ] **Duração Total:** ______ minutos
- [ ] **Arquivos Modificados:** ______ arquivos
- [ ] **Arquivos Enviados:** ______ arquivos
- [ ] **Backup Criado:** ✅ Sim | ❌ Não
- [ ] **Timestamp de Backup:** ________________________
- [ ] **Versão Deployada:** ________________________
- [ ] **Git Commit:** ________________________

### Versão em Produção
- [ ] **Versão:** v_._._
- [ ] **Data Deploy:** AAAA-MM-DD HH:MM:SS
- [ ] **Ambiente:** production
- [ ] **Verificado no Console:** ✅ Sim | ❌ Não

### Ações Tomadas
- [ ] Deploy normal: `npm run deploy`
- [ ] Deploy forçado: `npm run deploy -- --force-all`
- [ ] Rollback executado: timestamp: _______________
- [ ] Cache Nuvemshop limpo manualmente

### Próximos Passos (se houver)
```
[ ] Monitorar por 1 hora para possíveis erros
[ ] Verificar Google Analytics
[ ] Testar checkout completo
[ ] Validar emails transacionais
[ ] Comunicar time sobre alterações
```

---

## 🔐 Sign-Off

**Executor:** _________________________ (Nome)
**Data/Hora:** _________________________
**Versão Deployada:** _________________________
**Status Final:** ✅ **OK PARA PRODUÇÃO**

---

**Checklist AIOX Deploy Standard v1.0**
**Criado:** 2026-03-20
**Próxima Review:** 2026-06-20
