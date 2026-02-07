# FTP Deploy - Patagang Nuvemshop

Sistema de deploy otimizado para Nuvemshop via FTP com cache MD5.

## Funcionalidades

- **Cache MD5** - Envia apenas arquivos modificados
- Upload em lotes com retry automatico
- Progress bar em tempo real
- Reconexao automatica para evitar timeouts
- Modo dry-run para testar antes de enviar

## Instalacao

```bash
cd ftp-deploy
npm install
```

## Uso

### Backup Completo do FTP (Antes de Alteracoes Importantes)

**⚠️ IMPORTANTE:** Execute este backup antes de fazer alteracoes significativas no tema.

```bash
npm run backup:full
# ou
node backup-full-ftp.js
```

Este comando:

- Faz download de **TODOS** os arquivos do servidor FTP
- Salva em `backups/ftp-full/[TIMESTAMP]/`
- Cria metadados completos do backup
- Gera README com instrucoes de restauracao

**Quando usar:**

- Antes de implementar alteracoes grandes no tema
- Antes de fazer ajustes visuais importantes
- Periodicamente como backup de seguranca
- Quando solicitado manualmente

**Observacao:** Este backup e independente do backup incremental automatico do deploy. Use quando precisar de um snapshot completo do estado atual do FTP.

### Deploy Otimizado (Recomendado)

```bash
node deploy-optimized.js
```

Envia **apenas** os arquivos modificados desde o ultimo deploy.

**Version ID (console da loja):** A cada deploy é gerado um Version ID (ex.: `2026-02-02T20-30-00-ABC12DEF`). Esse ID é injetado automaticamente no `layouts/layout.tpl` (meta e script no console) e exibido ao final do script. Ele também é salvo em `ftp-deploy/LAST_DEPLOY_VERSION.txt` para você conferir ou colar na validação. Se houver arquivos modificados mas o `layout.tpl` não tiver mudado, o script **inclui o layout na lista de envio** para atualizar a versão no FTP.

### Opcoes Disponiveis

#### Ver o que seria enviado (sem enviar)

```bash
node deploy-optimized.js --dry-run
```

#### Forcar envio de todos os arquivos

```bash
node deploy-optimized.js --force-all
```

#### Visualizar cache

```bash
node deploy-optimized.js --show-cache
```

#### Listar backups disponiveis

```bash
# Listar backups incrementais mais recentes (padrão: 10)
node list-backups.js

# Listar todos os backups incrementais
node list-backups.js --all

# Incluir backups completos também
node list-backups.js --full

# Limitar a N backups
node list-backups.js --limit 5

# Ou usando npm
npm run list
npm run list:all
npm run list:full
```

## Estrutura

```
ftp-deploy/
+-- deploy-optimized.js    <- Script PRINCIPAL de deploy (usar este)
+-- backup-full-ftp.js     <- Script de backup completo do FTP
+-- config.js              <- Configuracoes e credenciais FTP
+-- package.json           <- Dependencias Node.js
+-- .deploy-cache.json     <- Cache de arquivos (gerado automaticamente)
+-- README.md              <- Esta documentacao

backups/
+-- ftp-full/              <- Backups completos do FTP
    +-- [TIMESTAMP]/       <- Backup com data/hora
        +-- [todos os arquivos do FTP]
        +-- _BACKUP_METADATA.json
        +-- README.md
+-- incremental/           <- Backups incrementais (deploy automatico)
```

## Seguranca

- Credenciais armazenadas em `config.js`
- Cache local `.deploy-cache.json` (adicione ao .gitignore)
- Conexao FTPS (TLS)

## Como Funciona o Cache MD5

### Primeiro Deploy

```bash
node deploy-optimized.js
# -> Envia todos os 258 arquivos
# -> Cria .deploy-cache.json com hash MD5 de cada arquivo
```

### Voce edita 3 arquivos

- `templates/product.tpl`
- `static/css/style-async.scss.tpl`
- `snipplets/header/header-patagang.tpl`

### Segundo Deploy

```bash
node deploy-optimized.js
# -> Calcula hash de 258 arquivos localmente
# -> Compara com .deploy-cache.json
# -> Detecta 3 modificados
# -> Envia APENAS 3 arquivos
# -> Atualiza cache
```

**Resultado:** Deploy ~50x mais rapido!

## Fluxo de Trabalho Recomendado

1. **Teste local antes:**

   ```bash
   node deploy-optimized.js --dry-run
   ```

2. **Deploy apenas modificados:**

   ```bash
   node deploy-optimized.js
   ```

3. **Limpar cache Nuvemshop (OBRIGATORIO):**
   - Acessar: <https://www.nuvemshop.com.br/admin/v2/themes>
   - Clicar no menu (tres pontos) do tema ativo
   - Selecionar "Limpar Cache"

4. **Validar na loja:**
   - Acesse: <https://patagang.lojavirtualnuvem.com.br/>

5. **Se algo der errado, force re-deploy:**

   ```bash
   node deploy-optimized.js --force-all
   ```

## Exemplo de Saida

```
======================================================================
         DEPLOY OTIMIZADO - NUVEMSHOP PATAGANG
======================================================================
18:49:22 | i Coletando arquivos...
18:49:22 | ok Encontrados 258 arquivos no total
18:49:22 | i Verificando arquivos modificados...
18:49:22 | i Modificados: 3 | Inalterados: 255
18:49:22 | i Serao enviados 3 arquivos
18:49:23 | i Conectando ao FTP...
18:49:24 | ok Conectado
18:49:24 | > Lote 1/1 (3 arquivos)
[==============================] 100% (3/3)
18:49:26 | ok Cache atualizado com sucesso
======================================================================
```

## Resetar Cache

Se quiser reenviar tudo do zero:

```bash
# Opcao 1: Deletar cache
Remove-Item .deploy-cache.json
node deploy-optimized.js

# Opcao 2: Forcar todos (mantem cache)
node deploy-optimized.js --force-all
```

---

## Backup Automatico (Incremental)

O deploy cria **automaticamente** um backup incremental dos arquivos **REMOTOS** (versão anterior) antes de fazer upload.

**Como funciona:**

1. Conecta ao FTP
2. Faz **download** dos arquivos remotos que serão substituídos
3. Salva no backup incremental
4. Faz upload dos arquivos novos
5. Permite rollback fácil se necessário

### Opcoes de Backup

```bash
# Deploy normal (com backup automatico dos arquivos REMOTOS)
node deploy-optimized.js

# Deploy sem backup (ex: apos rollback ou quando nao precisa)
node deploy-optimized.js --no-backup
```

### Listar Backups Disponiveis

**Antes de fazer rollback, liste os backups para identificar o mais recente:**

```bash
# Listar backups incrementais mais recentes (padrão: 10 mais recentes)
node list-backups.js

# Listar todos os backups incrementais
node list-backups.js --all

# Listar backups incrementais + backups completos
node list-backups.js --full

# Ou usando npm
npm run list
npm run list:all
npm run list:full
```

O script mostra:

- ✅ Timestamp de cada backup
- 📅 Data e hora legível
- ⏱️ Tempo relativo (há X minutos/horas/dias)
- 📊 Quantidade de arquivos alterados
- 📁 Lista dos arquivos alterados
- 💾 Tamanho do backup
- 🟢 Indicação do backup mais recente
- 💡 Instruções de rollback

### Rollback Incremental (Recomendado)

**Script automatizado:**

```bash
# Rollback do backup mais recente (recomendado)
cd ftp-deploy
node rollback-incremental.js

# Rollback de backup especifico
node rollback-incremental.js 2025-12-12T21-57-28

# Ou usando npm
npm run rollback
npm run rollback -- 2025-12-12T21-57-28
```

O script:

- Lista backups disponiveis automaticamente
- Identifica o backup mais recente se não especificado
- Restaura arquivos do backup para o FTP
- Mantém estrutura de diretorios
- Mostra progresso em tempo real

### Restaurar Backup Incremental (Manual)

```powershell
# Listar backups incrementais
ls ../backups/incremental/

# Restaurar backup incremental especifico (MANUAL)
Copy-Item -Recurse -Force ../backups/incremental/[TIMESTAMP]/* ../theme-deploy-corrigido/

# Deploy do backup (sem criar novo backup)
node deploy-optimized.js --force-all --no-backup
```

**Nota:** Use o script `rollback-incremental.js` ao inves de fazer manualmente.

### Restaurar Backup Completo

```powershell
# Listar backups completos
ls ../backups/ftp-full/

# Restaurar backup completo especifico
Copy-Item -Recurse -Force ../backups/ftp-full/[TIMESTAMP]/* ../theme-deploy-corrigido/

# Deploy do backup completo
node deploy-optimized.js --force-all --no-backup
```

---

## Avisos

- Cache `.deploy-cache.json` deve estar no `.gitignore`
- Use `--dry-run` antes de deploys importantes
- **SEMPRE** limpe o cache da Nuvemshop apos deploy
- Backups incrementais sao criados automaticamente
- Em caso de duvida, use `--force-all`

---

**Ultima atualizacao:** 12/12/2025
