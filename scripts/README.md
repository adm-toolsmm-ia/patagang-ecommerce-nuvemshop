# Scripts - Patagang Ecommerce

Scripts utilitários para gerenciar o projeto. Executar apenas quando necessário.

## Sincronização Git

Scripts para fazer commit e push das alterações para o GitHub.

### PowerShell (Recomendado)

```powershell
cd scripts
.\git-sync.ps1 "mensagem do commit"
```

### Windows Batch

```cmd
cd scripts
git-sync.bat "mensagem do commit"
```

### Parâmetros

| Parâmetro | Descrição | Padrão |
|-----------|-----------|--------|
| mensagem | Mensagem do commit | `chore: sync projeto local` |

### O que o script faz

1. Navega para a raiz do projeto
2. Verifica se há mudanças pendentes
3. Adiciona todos os arquivos ao staging (`git add .`)
4. Cria o commit com a mensagem especificada
5. Faz push para o branch `main` no GitHub

---

## Deploy FTP

Para fazer deploy para a Nuvemshop, use os scripts na pasta `ftp-deploy/`:

```powershell
cd ftp-deploy
node deploy-optimized.js
```

Consulte `ftp-deploy/README.md` para mais detalhes.

---

**Última atualização:** 13/12/2025
