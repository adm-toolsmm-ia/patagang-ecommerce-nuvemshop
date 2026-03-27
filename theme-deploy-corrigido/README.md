# Backup Completo FTP - Patagang Nuvemshop

**Data/Hora:** 13/02/2026, 21:16:55
**Timestamp:** 2026-02-14T00-10-23

## Estatísticas

- **Total de arquivos:** 293
- **Arquivos baixados:** 293
- **Falhas:** 0
- **Tamanho total:** 18.92 MB
- **Duração:** 346.4s

## Estrutura

Este backup contém uma cópia completa de todos os arquivos que estavam no servidor FTP no momento do backup.

## Como Restaurar

Para restaurar este backup:

1. Copiar arquivos do backup para `theme-deploy-corrigido/`:
   ```powershell
   Copy-Item -Recurse -Force 2026-02-14T00-10-23/* ../theme-deploy-corrigido/
   ```

2. Fazer deploy:
   ```bash
   cd ../ftp-deploy
   node deploy-optimized.js --force-all
   ```

3. Limpar cache da Nuvemshop:
   - Acessar: https://www.nuvemshop.com.br/admin/v2/themes
   - Menu (três pontos) do tema ativo
   - "Limpar Cache"

## Observações

- Este é um backup manual completo do FTP
- Arquivos que falharam no download estão listados em `_BACKUP_METADATA.json`
- Use este backup apenas se precisar restaurar o estado anterior do tema
