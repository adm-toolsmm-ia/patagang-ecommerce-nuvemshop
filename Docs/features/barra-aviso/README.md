# Barra de aviso (Ad Bar)

Barra fixa no topo da loja com mensagem promocional (ex.: frete grátis, descontos, política de trocas).

## Arquivos principais

| Arquivo | Função |
|---------|--------|
| `theme-deploy-corrigido/snipplets/header/header-advertising.tpl` | Template HTML da barra |
| `theme-deploy-corrigido/static/css/style-critical.tpl` | CSS da barra (~linhas 2110–2167) |
| `theme-deploy-corrigido/layouts/layout.tpl` | Override final (cor, altura, mobile) |

## Configuração (Nuvemshop)

- **ad_bar** (checkbox): Exibir ou ocultar a barra
- **ad_text** (i18n_input): Mensagem da barra
- **ad_url** (opcional): Link ao clicar na barra

## Documentos

- [plano-espacamento-bullets.md](plano-espacamento-bullets.md) — Plano para correção de espaçamento entre bullets e frases
