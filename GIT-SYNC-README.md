# 🔄 Git Sync - Rotina Padronizada

Scripts automatizados para commit e sincronização com GitHub.

## 🚀 Uso Rápido

### Windows PowerShell
```powershell
.\git-sync.ps1
```

### Windows CMD (Batch)
```cmd
git-sync.bat
```

### Com mensagem personalizada
```powershell
.\git-sync.ps1 "feat: adiciona nova funcionalidade"
```

```cmd
git-sync.bat "feat: adiciona nova funcionalidade"
```

## 📋 O que o script faz

1. ✅ Verifica se há mudanças
2. ✅ Adiciona todos os arquivos modificados
3. ✅ Cria commit com mensagem
4. ✅ Envia para GitHub (branch main)

## ⚙️ Configuração

As credenciais Git já estão configuradas:
- **Email:** toolsmm.ia@gmail.com
- **Usuário:** adm-toolsmm-ia
- **Repositório:** https://github.com/adm-toolsmm-ia/patagang-ecommerce-nuvemshop.git

## 🔒 Arquivos Protegidos

O arquivo `.gitignore` protege automaticamente:
- `ftp-deploy/config.js` (credenciais FTP)
- `backups/` (backups locais)
- `node_modules/`
- Arquivos temporários e cache

## 📝 Mensagens de Commit Padrão

Se não informar mensagem, será usado: `"chore: sync projeto local"`

### Exemplos de mensagens:
- `feat: adiciona nova seção na home`
- `fix: corrige layout mobile do header`
- `style: ajusta cores do tema`
- `chore: atualiza dependências`

## ⚠️ Nota

O script faz push direto para `main`. Certifique-se de que as alterações estão validadas antes de executar.
