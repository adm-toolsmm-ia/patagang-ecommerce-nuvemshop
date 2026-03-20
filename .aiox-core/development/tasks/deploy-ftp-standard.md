---
id: deploy-ftp-standard
name: FTP Deploy Standard - Patagang Nuvemshop
type: task
executor: @devops
priority: high
elicit: false

description: |
  Executa o deploy padronizado via FTP para Nuvemshop com:
  - Detecção automática de arquivos modificados (diff)
  - Backup incremental pré-deploy
  - Upload otimizado em lotes com retry automático
  - Injeção de versionamento em arquivo raiz
  - Validação pós-deploy com checklist

  ✅ Envia apenas arquivos alterados
  ✅ Versão visível no console do navegador
  ✅ Backup incremental para rollback rápido
  ✅ Reconexão automática FTP a cada 50 arquivos
  ✅ Metadados de rastreabilidade

dependencies:
  - Node.js >= 18
  - basic-ftp package (npm install)
  - Credenciais FTP em config.js
  - theme-deploy-corrigido/ sincronizado localmente

tags:
  - deploy
  - ftp
  - nuvemshop
  - infrastructure
  - automation

elicit: false
---

## 🚀 Fluxo de Execução

### Fase 1: Validação Pré-Deploy
```
1. Verificar conexão FTP
2. Validar estrutura local (theme-deploy-corrigido)
3. Confirmar credenciais
4. Listar arquivos para deploy
```

### Fase 2: Backup Incremental
```
1. Criar diretório backup: backups/incremental/{ISO_TIMESTAMP}/
2. Download dos arquivos que serão alterados do FTP
3. Gerar _BACKUP_METADATA.json (lista de arquivos + hashes)
4. Gerar README.md (instruções de restauração)
5. Log de sucesso em deploy-log.txt
```

### Fase 3: Deploy com Otimização
```
1. Carregar cache de MD5 (.deploy-cache.json)
2. Filtrar apenas arquivos modificados
3. Injetar versão em arquivo configurado (ex: layout.tpl)
4. Upload em lotes (10 arquivos/lote com reconexão a cada 50)
5. Retry automático (3 tentativas) em caso de erro
6. Atualizar cache MD5 de arquivos enviados
```

### Fase 4: Validação Pós-Deploy
```
1. Verificar last-modified remoto vs local
2. Gerar relatório de upload
3. Atualizar LAST_DEPLOY_VERSION.txt
4. Log de conclusão com timestamp
```

### Fase 5: Documentação
```
1. Salvar versão em version-info.js (console do navegador)
2. Registrar metadados em DEPLOY_HISTORY.json
3. Criar resumo de alterações
```

---

## 📋 Linha de Comando

### Deploy Padrão (Apenas Alterados)
```bash
cd ftp-deploy
npm run deploy
```

**Output esperado:**
```
✅ Deploy Otimizado - Patagang Nuvemshop
ℹ️ Verificando arquivos modificados...
ℹ️ Modificados: 5 | Inalterados: 120
▶ Iniciando backup incremental...
✓ Backup salvo em: backups/incremental/2026-03-20T10-30-45/
▶ Iniciando upload...
[████████████░░░░░░░░░░░░░░░░] 42% (12/28) | 1.2 MB/s
✓ Deploy concluído em 45s
✓ Sucesso: 28/28 arquivos
```

### Deploy Completo (Force All)
```bash
npm run deploy -- --force-all
```
Envia todos os arquivos, ignorando cache.

### Backup Completo
```bash
npm run backup
```
Faz download de TODOS os arquivos do FTP para local.

### Rollback Incremental
```bash
npm run rollback
# Ou especificando timestamp:
npm run rollback -- 2026-03-20T10-30-45
```

---

## 🔄 Arquivos Afetados

### Configuração
- `config.js` - Credenciais e caminhos (não commitar)
- `.deploy-cache.json` - Cache MD5 de últimas alterações

### Saídas
- `LAST_DEPLOY_VERSION.txt` - Versão atual em produção
- `deploy-log.txt` - Log de execução
- `DEPLOY_HISTORY.json` - Histórico de deploys

### Backups
- `../backups/incremental/{TIMESTAMP}/` - Incrementais
- `../backups/ftp-full/{TIMESTAMP}/` - Completos

### Logs Remotos (FTP)
- Não salva logs no FTP, apenas valida

---

## ✅ Checklist Pré-Deploy

- [ ] Branch `main` atualizado localmente
- [ ] Commits locais sincronizados com remote
- [ ] Arquivo `theme-deploy-corrigido/` sincronizado
- [ ] Testou mudanças localmente (build/preview)
- [ ] Credenciais FTP em `config.js` ✅ (validas)
- [ ] Conexão de rede estável
- [ ] Sem conflitos de merge pendentes
- [ ] Nenhum processo de deploy em andamento

---

## 📊 Output Esperado

### Sucesso
```json
{
  "status": "success",
  "files_deployed": 28,
  "duration_seconds": 45,
  "total_size_mb": 3.2,
  "version": "v1.1.1",
  "git_commit": "9502c44",
  "timestamp": "2026-03-20T10:30:45Z",
  "backup_path": "backups/incremental/2026-03-20T10-30-45"
}
```

### Erro
```json
{
  "status": "failed",
  "phase": "upload",
  "error": "Connection lost after attempt 3",
  "files_deployed": 12,
  "files_failed": 2,
  "backup_available": "backups/incremental/2026-03-20T10-30-45",
  "action": "Retry deploy ou restaurar backup anterior"
}
```

---

## 🔐 Segurança & Dados Sensíveis

**Credenciais FTP:**
- Armazenadas em `config.js` (git-ignored)
- Nunca commitar `config.js` com senhas reais
- Usar `config.example.js` como template

**Backups:**
- Contém cópia exata de produção
- Armazenar seguramente (não expor publicamente)
- Rotação automática (manter últimos 10)

**Logs:**
- Não contêm senhas
- Contêm versão e timestamps
- Manter para auditoria

---

## 🔄 Rollback Rápido

Se deploy falhou ou precisa reverter:

```bash
# Listar backups disponíveis
npm run list

# Restaurar para timestamp específico
npm run rollback -- 2026-03-20T10-30-45

# Verificar sincronização
node verify-sync.js

# Deploy do backup restaurado
npm run deploy
```

**Tempo de rollback:** ~2-5 minutos (depende da quantidade de arquivos)

---

## 📈 Monitoramento

### Verificar Versão em Produção
```javascript
// No console do navegador:
window.__PATAGANG_VERSION__
```

**Output:**
```javascript
{
  version: "1.1.1",
  environment: "production",
  deployment_date: "2026-03-20T03:46:27Z",
  git_commit: "9502c44"
}
```

### Limpar Cache Nuvemshop
```
1. Acessar: https://www.nuvemshop.com.br/admin/v2/themes
2. Clicar no menu (⋯) do tema ativo
3. Selecionar "Limpar Cache"
4. Aguardar 3-5 minutos
```

---

## 🐛 Troubleshooting

### Erro: "Connection lost"
```
→ Reconectar FTP (automático a cada 50 arquivos)
→ Aguardar 2 minutos
→ Retry: npm run deploy
```

### Erro: "File not found"
```
→ Verificar se theme-deploy-corrigido/ existe e está sincronizado
→ npm run list (verificar estrutura FTP)
→ Sincronizar backup: node sync-backup-to-local.js {TIMESTAMP}
```

### Deploy lento
```
→ Reduzir BATCH_SIZE em deploy-optimized.js (de 10 para 5)
→ Aumentar RECONNECT_EVERY (reconectar menos frequente)
→ Verificar conexão de rede
```

### Cache desatualizado
```
→ Deletar .deploy-cache.json
→ Executar: npm run deploy -- --force-all
```

---

## 📞 Suporte & Escalação

| Situação | Ação |
|----------|------|
| Deploy falhou após 3 tentativas | Contatar @devops, verificar logs |
| Rollback necessário | `npm run rollback -- {TIMESTAMP}` |
| Dúvida sobre versão | Ver `LAST_DEPLOY_VERSION.txt` |
| Problema de credenciais | Verificar `config.js` (não commitar) |

---

## 🎯 Success Criteria

✅ Deploy executado com sucesso
✅ Versão atualizada em produção
✅ Console do navegador mostra versão correta
✅ Backup incremental criado
✅ Log de execução registrado
✅ Nenhum arquivo perdido no processo
✅ Rollback possível em < 5 minutos

---

**Última atualização:** 2026-03-20
**Criado em:** AIOX Standard Deploy Framework v1.0
**Executor:** @devops (exclusive)
