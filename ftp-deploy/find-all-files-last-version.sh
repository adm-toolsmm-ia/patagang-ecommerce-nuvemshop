#!/bin/bash

# ANÁLISE COMPLETA: Última versão de CADA arquivo (300+)
# Filtra apenas arquivos não-backup

cd /c/Users/Gabriel\ Cristofolini/Documents/SOLUCOESSISTEMAS/patagang-ecommerce-nuvemshop

echo "🔍 ANÁLISE COMPLETA: Última Versão de Cada Arquivo do Tema"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Encontrar TODOS os arquivos (excluindo backup, .git, VERSION/version-info)
ARQUIVOS=$(find theme-deploy-corrigido -type f \
  ! -path "*/backup/*" \
  ! -name "VERSION.json" \
  ! -name "version-info.js" \
  ! -name "*.backup*" \
  ! -name "*.backup-*" \
  ! -path "*/.git/*" \
  | grep -v "layout.tpl.backup" \
  | grep -v "\.backup" \
  | sort)

# Contadores
TOTAL=0
COM_ALTERACOES=0
SEM_ALTERACOES=0

# Arquivo temporário para consolidado
TEMP_REPORT="/tmp/report_versions.txt"
> "$TEMP_REPORT"

# Processar cada arquivo
echo "Processando $(echo "$ARQUIVOS" | wc -l) arquivos..."
echo ""

for arquivo in $ARQUIVOS; do
  TOTAL=$((TOTAL + 1))

  # Procurar última alteração entre v1.5.166 e v1.5.200
  RESULTADO=$(git log bbcf569..52482ea --oneline -- "$arquivo" 2>/dev/null | head -1)

  if [ -z "$RESULTADO" ]; then
    SEM_ALTERACOES=$((SEM_ALTERACOES + 1))
  else
    COM_ALTERACOES=$((COM_ALTERACOES + 1))

    # Extrair versão
    VERSAO=$(echo "$RESULTADO" | grep -oE "1\.5\.[0-9]+" | head -1)

    # Se não encontrar versão clara, tentar extrair do commit message
    if [ -z "$VERSAO" ]; then
      VERSAO="unknown"
    fi

    # Extrair commit hash
    HASH=$(echo "$RESULTADO" | awk '{print $1}')

    # Extrair mensagem (sem hash)
    MSG=$(echo "$RESULTADO" | cut -d' ' -f2-)

    # Salvar para relatório consolidado
    echo "$VERSAO|$arquivo|$HASH|$MSG" >> "$TEMP_REPORT"
  fi

  # Progress
  if [ $((TOTAL % 50)) -eq 0 ]; then
    echo "  ✓ Processados $TOTAL arquivos..."
  fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 ESTATÍSTICAS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Total de arquivos: $TOTAL"
echo "Com alterações: $COM_ALTERACOES"
echo "Sem alterações: $SEM_ALTERACOES"
echo ""

# Consolidar por versão
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📌 ARQUIVOS AGRUPADOS POR VERSÃO (últimas versões que os alteraram)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Ordenar por versão descrescente
sort -r -t'|' -k1 "$TEMP_REPORT" | awk -F'|' '
BEGIN { last_version = "" }
{
  if ($1 != last_version) {
    if (last_version != "") print ""
    printf "📌 v1.5.%s:\n", $1
    last_version = $1
  }
  # Extrair apenas o nome do arquivo
  split($2, parts, "/")
  filename = parts[length(parts)]
  printf "   • %s\n", $2
}'

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Análise Completa!"
echo ""
echo "Relatório detalhado salvo em: $TEMP_REPORT"
echo ""
echo "Próximo passo: Revisar qual é a ÚLTIMA versão de cada arquivo"
