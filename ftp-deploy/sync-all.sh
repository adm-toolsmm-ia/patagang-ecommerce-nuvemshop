#!/bin/bash

# Sync completo: envia TODOS os arquivos do theme-deploy-corrigido para o FTP

echo "🔗 Preparando sincronização de TODOS os arquivos..."
echo ""

# Contar arquivos
TOTAL=$(find theme-deploy-corrigido -type f | wc -l)
echo "📊 Total de arquivos a sincronizar: $TOTAL"
echo ""

# Forçar modificação de timestamp em TODOS os arquivos
find theme-deploy-corrigido -type f -exec touch {} \;

echo "✅ Timestamps atualizados - todos os arquivos serão detectados como modificados"
echo ""
echo "🚀 Executando deploy com flag --force para sincronizar tudo..."
echo ""

node ftp-deploy/deploy.js "SYNC COMPLETO: Sincronizando TODOS os $TOTAL arquivos do tema para o FTP" --force

