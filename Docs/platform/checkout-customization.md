# Customização do Checkout Nuvemshop

> **Versão:** 1.0.0  
> **Data:** 15/12/2025  
> **Objetivo:** Documentar as possibilidades e limitações de customização do checkout na plataforma Nuvemshop

---

## Visão Geral

O checkout da Nuvemshop é considerado uma **página crítica** que lida diretamente com transações financeiras. Por esse motivo, a plataforma impõe **restrições significativas** para alterações avançadas, priorizando segurança e estabilidade.

---

## Níveis de Customização

### ✅ Nível 1: Via Tema (checkout.scss.tpl)

Customizações visuais básicas que podem ser feitas diretamente no tema.

| Elemento | Customizável? | Como |
|----------|---------------|------|
| Cores de fundo | ✅ Sim | Variável `$background-color` |
| Cor de texto | ✅ Sim | Variável `$foreground-color` |
| Cor de destaque/botões | ✅ Sim | Variável `$accent-brand-color` |
| Fontes (headings) | ✅ Sim | Variável `$heading-font` |
| Fontes (body) | ✅ Sim | Variável `$body-font` |
| Border radius | ✅ Sim | Variável `$box-radius` |
| Sombras | ✅ Sim | Variável `$box-shadow` |
| Estilos de input | ✅ Sim | Classes `.form-control` |
| Estilos de botões | ✅ Sim | Classes `.btn-primary`, `.btn-secondary` |

**Arquivo:** `static/checkout.scss.tpl`

**Requisito:** Ativar "Cores do checkout" em Admin > Opções de Checkout

#### Exemplo de Estrutura:

```scss
// Variáveis principais
$accent-brand-color: {{ settings.primary_color }};
$foreground-color: {{ settings.text_color }};
$background-color: {{ settings.background_color }};
$heading-font: {{ settings.font_headings }};
$body-font: {{ settings.font_rest }};

// Customização de botões
.btn-primary {
  border-radius: 0;
  background: $accent-brand-color;
}
```

---

### ⚠️ Nível 2: Via SDK/API (Requer Parceria)

Customizações que requerem cadastro como Parceiro Nuvemshop e permissões especiais.

#### Requisitos:
1. Cadastro no Portal de Parceiros Nuvemshop
2. App registrado com escopo "scripts"
3. Aprovação para scripts `onload` (exceto checkout-only)

#### Funcionalidades do Checkout SDK:

| Funcionalidade | Descrição |
|----------------|-----------|
| Renderizar IDs de gateways ativos | Listar métodos de pagamento disponíveis |
| Ocultar opções de pagamento | Esconder métodos específicos por condição |
| Alterar info de descontos/parcelas | Modificar exibição por gateway |
| Adicionar info extra em métodos externos | Dados adicionais em pagamentos externos |
| Evento "Line Items Updated" | Rastrear alterações no carrinho |

#### Limitações de Scripts:

- Scripts **não devem depender** de JavaScript do tema (incluindo jQuery)
- Parceiro é **responsável** por erros gerados
- Scripts no checkout com `onload` não precisam aprovação prévia
- Timeout da API Business Rules: **800ms**

---

### 🔒 Nível 3: Não Possível (Limitações da Plataforma)

Customizações que **NÃO são permitidas** mesmo com desenvolvimento customizado.

| Restrição | Motivo |
|-----------|--------|
| Alterar estrutura HTML do checkout | Renderizado pelo sistema |
| Adicionar campos personalizados | Requer apps de terceiros |
| Modificar ordem das etapas | Fluxo fixo da plataforma |
| Remover etapas do checkout | Estrutura obrigatória |
| Injetar componentes visuais customizados | Segurança da transação |
| Modificar fluxo de validação | Controlado internamente |

---

## Alternativas para Customização Avançada

### Apps de Terceiros

| App | Funcionalidades |
|-----|-----------------|
| **Super Checkout** (Empreender) | Layout customizável, countdown, validação CPF/CNPJ |
| Apps de Upsell | Ofertas pós-checkout |
| Apps de Fidelidade | Pontos e recompensas |

### Payment Options API

Para integrações de pagamento customizadas:

- Criar opções de pagamento próprias
- Integrar SDKs de provedores
- Checkout transparente com mais controle

**Nota:** Dados em LocalStorage precisam ser enviados via `postMessage` do domínio da loja para o domínio privado do checkout.

---

## Mapeamento de Arquivos

### Tema (Customização Visual)

| Arquivo | Propósito |
|---------|-----------|
| `static/checkout.scss.tpl` | Estilos CSS/SCSS do checkout |
| `config/settings.txt` | Variáveis de cores/fontes |

### Referência

| Arquivo | Propósito |
|---------|-----------|
| [reference.md](reference.md) | Referência técnica rápida |
| [reference-full.md](reference-full.md) | Documentação completa |

---

## Diagrama de Possibilidades

```
┌─────────────────────────────────────────────────────────────────┐
│              CHECKOUT NUVEMSHOP - NÍVEIS DE ACESSO              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ ✅ VIA TEMA (checkout.scss.tpl)                         │   │
│  │    • Cores (background, texto, botões, acentos)         │   │
│  │    • Fontes (family, weight)                            │   │
│  │    • Bordas, sombras, espaçamentos                      │   │
│  │    • Sem necessidade de parceria                        │   │
│  └─────────────────────────────────────────────────────────┘   │
│                           ▼                                     │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ ⚠️ VIA SDK/API (Requer Partner + App)                   │   │
│  │    • Ocultar métodos de pagamento                       │   │
│  │    • Alterar info de parcelas/descontos                 │   │
│  │    • Scripts específicos no checkout                    │   │
│  │    • Events de atualização do carrinho                  │   │
│  └─────────────────────────────────────────────────────────┘   │
│                           ▼                                     │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ 🔒 NÃO POSSÍVEL                                         │   │
│  │    • Alterar estrutura/ordem das etapas                 │   │
│  │    • Adicionar campos customizados                      │   │
│  │    • Modificar fluxo de validação                       │   │
│  │    • Injetar componentes visuais                        │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Referências Oficiais

- **Documentação Nuvemshop:** https://docs.nuvemshop.com.br/
- **Checkout SDK:** https://tiendanube.github.io/api-documentation/checkout-sdk
- **Scripts API:** https://tiendanube.github.io/api-documentation/resources/script
- **Portal de Parceiros:** https://partners.nuvemshop.com.br/

---

## Próximos Passos (Quando Necessário)

1. **Customização Visual Básica**
   - Editar `checkout.scss.tpl`
   - Ativar cores de checkout no admin

2. **Customização Avançada**
   - Avaliar necessidade de parceria
   - Considerar apps de terceiros
   - Desenvolver via SDK se necessário

---

**Última atualização:** 2026-02-13 00:00:00 (Brasília)
**Versão:** 1.0.0
