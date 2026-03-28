#!/bin/bash

# MAPEAMENTO DE VERSÕES: Qual é a última versão de cada arquivo
# Entre v1.5.166 (bbcf569) e v1.5.200 (52482ea)

echo "📋 MAPEAMENTO: Última Versão de Cada Arquivo"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Arquivos críticos do tema para análise
ARQUIVOS=(
  "theme-deploy-corrigido/layouts/layout.tpl"
  "theme-deploy-corrigido/static/css/style-critical.tpl"
  "theme-deploy-corrigido/static/css/style-async.scss.tpl"
  "theme-deploy-corrigido/static/css/style-help-sidebar.css.tpl"
  "theme-deploy-corrigido/static/css/style-menu-patagang.css.tpl"
  "theme-deploy-corrigido/static/css/style-whatsapp-button.css.tpl"
  "theme-deploy-corrigido/snipplets/header/header-patagang.tpl"
  "theme-deploy-corrigido/snipplets/header/header-advertising.tpl"
  "theme-deploy-corrigido/snipplets/whatsapp-left.tpl"
  "theme-deploy-corrigido/static/js/product-page-custom.js"
  "theme-deploy-corrigido/VERSION.json"
)

echo "Analisando histórico de cada arquivo entre v1.5.166 e v1.5.200..."
echo ""

for FILE in "${ARQUIVOS[@]}"; do
  echo "📄 $FILE"

  # Obter último commit que alterou este arquivo
  LAST_COMMIT=$(git log --oneline --all -- "$FILE" | head -1)

  if [ -z "$LAST_COMMIT" ]; then
    echo "   ⚠️  Arquivo não encontrado no histórico"
  else
    COMMIT_HASH=$(echo "$LAST_COMMIT" | awk '{print $1}')
    COMMIT_MSG=$(echo "$LAST_COMMIT" | cut -d' ' -f2-)

    # Extrair versão da mensagem de commit
    VERSION=$(echo "$COMMIT_MSG" | grep -oE "1\.5\.[0-9]+" | head -1)

    echo "   Última alteração: $COMMIT_MSG"
    if [ -n "$VERSION" ]; then
      echo "   Versão: $VERSION"
    fi
    echo "   Hash: $COMMIT_HASH"
  fi
  echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Análise concluída!"
