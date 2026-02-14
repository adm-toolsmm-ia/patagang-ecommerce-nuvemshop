---
description: Auditoria profunda obrigatória de CSS/HTML/JS antes de qualquer alteração no tema Nuvemshop. Previne conflitos de especificidade e cache.
---

# /theme-audit — Auditoria Profunda do Tema

$ARGUMENTS

---

## 🔴 QUANDO USAR

**SEMPRE** — esta auditoria é **OBRIGATÓRIA** antes de qualquer alteração de CSS, HTML, JavaScript ou template (.tpl) no tema Nuvemshop.

Qualquer agente que receba um pedido de alteração visual, CSS, layout, grid, tipografia, imagem, ou qualquer outro aspecto de frontend **DEVE** executar esta auditoria ANTES de fazer qualquer modificação.

---

## Steps

### 1. Ler CODEBASE.md (OBRIGATÓRIO)

// turbo
Ler o arquivo `CODEBASE.md` no root do projeto para entender a arquitetura CSS, ordem de carregamento, e mapeamento de dependências.

### 2. Identificar Propriedades CSS Impactadas

Liste TODAS as propriedades CSS que serão alteradas (ex: `object-fit`, `text-align`, `display`, `justify-content`, etc.)

### 3. Buscar Conflitos em TODOS os Arquivos

Para CADA propriedade identificada, execute grep_search em:

```
Diretório: theme-deploy-corrigido/
Includes: ["*.tpl", "*.css"]
Query: <nome-da-propriedade>
```

**Arquivos prioritários para investigar:**
- `static/css/style-critical.tpl` (inline, carrega primeiro)
- `static/css/style-async.scss.tpl` (alta especificidade, cacheado)
- `static/css/product-card-v3.css` (estilos V3)
- `static/css/style-home-v2.css` (se afeta home)
- `layouts/layout.tpl` (override final)
- `snipplets/grid/item.tpl` (HTML dos cards)

### 4. Analisar Especificidade

Para cada regra encontrada, determine:
- Especificidade do seletor (ex: `body.template-category .pg-product-grid .item-image img` = 0-3-1)
- Se usa `!important`
- Ordem de carregamento (quem carrega DEPOIS vence em caso de empate)
- Se está em arquivo `.scss.tpl` (pode ter cache server-side)

### 5. Determinar Estratégia de Correção

Baseado na análise:

| Situação                                            | Estratégia                                                     |
| --------------------------------------------------- | -------------------------------------------------------------- |
| Conflito em `.scss.tpl` cacheado                    | Usar override final no `layout.tpl`                            |
| Conflito de especificidade                          | Aumentar especificidade ou usar `!important` no override final |
| Classes Nuvemshop automáticas (.img-absolute, etc.) | Incluir essas classes nos seletores do override                |
| Estilo inline adicionado por componente             | `!important` no override final (vence inline sem !important)   |

### 6. Implementar com Override Final

Se necessário, adicionar/atualizar o bloco `<style id="pg-v3-override-final">` no final do `layout.tpl`. Este é o ÚNICO lugar 100% garantido.

### 7. Deploy e Validação

Executar deploy e validar visualmente:
```bash
cd ftp-deploy
node deploy-optimized.js
```

---

## Exemplo de Auditoria Completa

```
PEDIDO: "Mudar object-fit para contain nos cards"

AUDITORIA:
1. Propriedade: object-fit
2. grep_search → Encontradas 40+ ocorrências em 6 arquivos
3. Conflitos identificados:
   - style-critical.tpl L1774: .img-absolute { height: auto } (causa overflow)
   - style-critical.tpl L1782: .img-absolute-centered { transform: translateX(-50%) }
   - style-async.scss.tpl L5379: body.template-category .pg-product-grid .item-image img { object-fit: cover }
   - product-card-v3.css L103: .pg-card__image-container img { object-fit: contain }
4. Especificidade: style-async (0-3-1) > product-card-v3 (0-1-1) → style-async VENCE
5. Estratégia: Override final no layout.tpl com !important
6. Implementação: height: 100% !important, transform: none !important, object-fit: contain !important
```

---

## ⚠️ Erros Comuns a Evitar

1. **NÃO** alterar apenas product-card-v3.css sem verificar style-async.scss.tpl
2. **NÃO** confiar que alterações em .scss.tpl refletem imediatamente (cache server-side)
3. **NÃO** ignorar classes Nuvemshop automáticas (.img-absolute, .item-product, etc.)
4. **NÃO** esquecer de verificar o override final no layout.tpl (pode ter regras old que conflitam)
5. **NÃO** usar seletores de baixa especificidade esperando que vençam seletores de alta especificidade
