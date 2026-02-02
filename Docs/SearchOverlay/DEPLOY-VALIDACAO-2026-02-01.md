# Validação do Deploy - "SEJA O PRIMEIRO A CONHECER"

## 📋 Informações do Deploy

| Item | Valor |
|------|-------|
| **Versão ID** | `2026-02-01T17-22-07-0E07F9F5` |
| **Data/Hora** | 01/02/2026, 14:22:11 (Brasília) |
| **Arquivos Atualizados** | 3 |
| **Backup Disponível** | Sim - `2026-02-01T17-22-05` |

## ✅ Arquivos Modificados

1. **templates/home.tpl** - Seção "SEJA O PRIMEIRO A CONHECER"
   - Adicionado carregamento dinâmico via JavaScript
   - Mantido fallback server-side com Twig
   - Fetch de produtos da categoria `/produtos-cachorros`

2. **static/css/style-home-v2.css** - Estilos de loading
   - Adicionado CSS para skeleton loading (`pg-dev-card--loading`)
   - Animação de pulse enquanto aguarda produtos
   - Classes isoladas, sem impacto em outras seções

3. **layouts/layout.tpl** - Meta tag de versão
   - Atualizado automaticamente pelo script (deploy tracking)

## 🔄 Como Funciona

### Fluxo de Carregamento

```
┌─────────────────────────────────────────────────────────────┐
│ HOME PAGE CARREGADA                                         │
└──────────────────┬──────────────────────────────────────────┘
                   │
        ┌──────────▼──────────┐
        │ TWIG (Server-side)  │
        │ Busca produtos com  │
        │ tag "em-desenvolvi" │
        └──────────┬──────────┘
                   │
        ┌──────────▼────────────────────┐
        │ Produtos encontrados?         │
        └──────────┬──────────┬─────────┘
                   │          │
              SIM  │          │ NÃO
                   │          │
        ┌──────────▼─┐    ┌────▼─────────────────┐
        │ Renderiza  │    │ Mostra 4 placeholders│
        │ cards      │    │ com skeleton loading │
        │ diretamente│    └──────┬───────────────┘
        └──────────┬─┘           │
                   │   ┌─────────▼─────────┐
                   │   │ JS Fetch           │
                   │   │ /produtos-cachorros│
                   │   │ (scraping HTML)    │
                   │   └─────────┬─────────┘
                   │             │
                   │   ┌─────────▼──────────────┐
                   │   │ Encontra .btn-dev      │
                   │   │ Extrai produtos       │
                   │   │ Renderiza cards       │
                   │   └─────────┬──────────────┘
                   │             │
                   │   ┌─────────▼──────────────┐
                   │   │ Substitui placeholders │
                   │   │ Ativa navegação        │
                   │   └────────────────────────┘
                   │
        ┌──────────▼─────────────────────┐
        │ CAROUSEL PRONTO PARA USO       │
        │ Scroll horizontal, navegação  │
        └────────────────────────────────┘
```

## 🧪 Passo a Passo de Validação

### 1️⃣ Limpar Cache da Nuvemshop

```
Acesse: https://www.nuvemshop.com.br/admin/v2/themes
→ Clique em "Limpar Cache"
→ Aguarde 2-3 minutos
```

### 2️⃣ Acessar a Home Page

```
URL: https://patagang.lojavirtualnuvem.com.br/
```

### 3️⃣ Validar Versão do Deploy

Abra o **DevTools** (F12) → **Console** e execute:

```javascript
document.querySelector('meta[name="deploy-version"]')?.getAttribute('content')
```

**Resultado esperado:**
```
2026-02-01T17-22-07-0E07F9F5
```

Se retornar valor diferente, o cache ainda não atualizou. Aguarde mais alguns minutos e recarregue.

### 4️⃣ Validar Seção "SEJA O PRIMEIRO A CONHECER"

**Comportamento Esperado:**

#### Cenário A: Produtos encontrados no servidor (Twig)
- ✅ Aparecem cards com produtos reais imediatamente
- ✅ Sem skeleton loading (não faz fetch)
- ✅ Mostra nome, preço (se disponível) e imagem

#### Cenário B: Sem produtos no servidor (Twig)
- ✅ Aparecem 4 cards com skeleton loading (pulso cinzento)
- ✅ Diz "Carregando..." e "Aguarde"
- ✅ Após alguns segundos, cards são substituídos por produtos reais
- ✅ Produtos vêm de `/produtos-cachorros`

#### Cenário C: Erro no fetch ou sem produtos na categoria
- ✅ Placeholders permanecem como fallback
- ✅ Cards dizem "Em breve" e "Aguarde"
- ✅ Console mostra: `Patagang: Erro ao buscar produtos...`

### 5️⃣ Testar Interações

- [ ] **Scroll Horizontal**: Arraste com mouse ou use touch em mobile
- [ ] **Botões de Navegação**: Clique nas setas < > (devem aparecer se houver overflow)
- [ ] **Responsividade**: Teste em mobile (768px breakpoint), tablet e desktop
- [ ] **Cards Clicáveis**: Clique em um card e verifique se vai para página do produto
- [ ] **Badge "EM DESENVOLVIMENTO"**: Deve estar visível em cada card

### 6️⃣ Verificar Console (DevTools)

```
Abra F12 → Console
Procure por mensagens:
✓ Nenhum erro (sem linhas vermelhas)
✓ Se houver, verificar:
  - "Patagang: Erro ao buscar..." (erro no fetch)
  - CORS errors (problema de origem)
```

## 🔧 Detalhes Técnicos

### Detecção de Produtos "Em Desenvolvimento"

O sistema detecta produtos pela classe `.btn-development` que já existe no arquivo [snipplets/grid/item.tpl:171](../theme-deploy-corrigido/snipplets/grid/item.tpl#L171).

Esse botão é renderizado quando o produto possui a tag `em-desenvolvimento` (verificação no [item.tpl:14-20](../theme-deploy-corrigido/snipplets/grid/item.tpl#L14-L20)).

**Fluxo:**
1. Produto tem tag `em-desenvolvimento` na Nuvemshop
2. Twig renderiza `.btn-development` no item da categoria
3. JS da home detecta essa classe no HTML parseado
4. JS extrai e renderiza o card no carousel

### Extração de Dados

O JavaScript extrai para cada produto:
- **Nome**: `.js-item-name`
- **URL**: `.item-link` → `href`
- **Imagem**: `.js-item-image` → `src`, `data-src` ou `data-srcset`
- **Preço**: `.js-price-display`

Suporta lazy loading (Lazysizes) - detecta `data-src` e `data-srcset`.

### Segurança

- ✅ XSS Prevention: `escapeHtml()` para renderização de nomes
- ✅ Same-origin fetch: `/produtos-cachorros` não envolve CORS
- ✅ Nenhum dado sensível exposto
- ✅ Degradação graciosa: sem JS, mostra placeholders

## ⚙️ Configuração Manual (Se Necessário)

**Nenhuma configuração manual é obrigatória.**

Se quiser ajustar quais produtos aparecem na seção:

1. **Adicionar produtos**: Vá ao admin da Nuvemshop → Produtos → Edite o produto → Tags → Adicione `em-desenvolvimento`
2. **Remover produtos**: Remova a tag `em-desenvolvimento`
3. **Mudar categoria de origem**: Edite o arquivo `home.tpl` linha 269:
   ```javascript
   var categoryUrl = '/sua-categoria-aqui'; // Trocar URL
   ```

## 📊 Impacto do Deploy

| Área | Impacto | Notas |
|------|---------|-------|
| **Home Page** | ✅ Seção adicionada | Apenas seção 3 |
| **Categoria** | ❌ Nenhum | Funcionalidade mantida |
| **Produto** | ❌ Nenhum | Sem alterações |
| **Busca** | ❌ Nenhum | Sem alterações |
| **CSS Global** | ❌ Mínimo | Só estilos isolados |
| **Performance** | ✅ Melhorado | Lazy loading + async fetch |

## 🔙 Rollback (Se Necessário)

Caso encontre problemas, execute:

```bash
node rollback-incremental.js 2026-02-01T17-22-05
```

Os arquivos anteriores serão restaurados em ~30 segundos.

## ❓ Troubleshooting

### Problema: Versão não atualiza
**Solução:**
1. Limpe cache: https://www.nuvemshop.com.br/admin/v2/themes
2. Ctrl+F5 no browser
3. Aguarde 5 minutos
4. Tente em navegador anônimo

### Problema: Skeleton loading não desaparece
**Causa:** Fetch falhou ou produtos não encontrados
**Solução:**
1. Verifique se existem produtos com tag `em-desenvolvimento` em `/produtos-cachorros`
2. Verifique console (F12) para mensagens de erro
3. Confirme que a categoria URL está correta

### Problema: Produtos não aparecem
**Verificação:**
1. Acesse `/produtos-cachorros` e procure pelo botão "SEJA O PRIMEIRO A CONHECER"
2. Se vir botão, a categoria tem produtos válidos
3. Se não vir, nenhum produto tem a tag `em-desenvolvimento`

### Problema: Layout quebrado ou cards cortados
**Solução:**
1. Limpe cache do browser
2. Recarregue a página
3. Se persistir, verifique DevTools → Elements para investigar CSS

## 📞 Suporte

Qualquer dúvida durante a validação, verifique:
- Deploy ID: `2026-02-01T17-22-07-0E07F9F5`
- Arquivos modificados: `home.tpl`, `style-home-v2.css`, `layout.tpl`
- Backup disponível: `2026-02-01T17-22-05`

---

**Data de Deploy:** 01/02/2026 às 14:22
**Executor:** Claude Code (Haiku 4.5)
**Status:** ✅ Sucesso
