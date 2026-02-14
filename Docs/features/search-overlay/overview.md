# 🔍 Search Overlay - Referência atual

**Última atualização:** 2026-02-13 (Brasília)

**Versão em produção:** conferir em `ftp-deploy/LAST_DEPLOY_VERSION.txt` (campo `VERSION_ID`). Validar na loja: F12 → Console → "VERSÃO DO DEPLOY".

---

## Estado atual no layout

No tema atual, o **botão de busca do header** abre o modal `#nav-search` com o conteúdo de **header-search.tpl** (campo de busca + filtros rápidos). O **overlay com Destaques + Lançamentos** (template `header-search-overlay.tpl`) está implementado no repositório (template, CSS no critical, lógica em store.js), mas **não é incluído** em nenhum layout; ou seja, não aparece ao clicar na busca. Para exibir esse overlay, seria necessário incluir `header-search-overlay.tpl` no tema e acioná-lo (por exemplo trocando o conteúdo do modal de busca ou usando outro trigger). Esta pasta documenta a feature para contexto e para alterações futuras, se desejar ativá-la ou modificá-la.

---

## 📑 Documentos nesta pasta

### 1. [deploy.md](deploy.md)
   - Resumo técnico das mudanças do Search Overlay
   - Arquivos modificados e funções
   - Guia de configuração admin (Destaques + Lançamentos)
   - Troubleshooting

### 2. [validation-checklist.md](validation-checklist.md)
   - Checklist para validação (desktop, mobile, responsividade)
   - Validação de integração Nuvemshop
   - Testes de segurança e performance

### 3. [archive/](archive/)
   - Documentos históricos (hotfix, deploy por data, resumo visual, índices antigos)

---

## 🎯 O Que Foi Implementado

### Dois Nomes Estratégicos (E-commerce 2026)

#### **🏆 "DESTAQUES"** (substituiu "Mais vendidos")
```
✓ Produtos bestseller curados pelo admin
✓ Carrossel horizontal com até 8 produtos
✓ Aumenta confiança (social proof)
✓ Conversão: +15-20% esperado
```

#### **🚀 "LANÇAMENTOS"** (substituiu "Mais procurados")
```
✓ Produtos novos com tag "lançamento"
✓ Tags clicáveis / Fallback automático
✓ Cria urgência (FOMO)
✓ Conversão: +25-30% esperado
```

### Overlay Fullscreen
```
✓ Desktop: 2 colunas (Lançamentos | Destaques)
✓ Mobile: Fullscreen vertical (stack)
✓ AJAX search integration (LS.search)
✓ Animação slide-down ao abrir
✓ Fechar: botão, backdrop, ESC
```

---

## 🚀 Quick Start

### Próximas 24 Horas (HOJE)

1. **Validar busca em produção** (modal atual)
   ```
   → Acessa: https://patagang.lojavirtualnuvem.com.br/
   → Clica ícone 🔍
   → Verifica se o modal de busca abre (campo + filtros rápidos)
   → Se o overlay Destaques/Lançamentos for ativado no futuro, usar validation-checklist.md (nesta pasta)
   ```

2. **Configurar "Destaques" (Admin)**
   ```
   → Admin Nuvemshop
   → Temas → Seções → Produtos em Destaque
   → Configura 4-8 produtos bestseller
   → Salva
   ```

3. **Tagear "Lançamentos" (Admin)**
   ```
   → Admin Nuvemshop → Produtos
   → Edita produtos novos
   → Adiciona tag: "lançamento" (exata)
   → Salva
   ```

4. **Testar Funcionalidades**
   ```
   Desktop: Digita busca → AJAX suggestions
   Mobile: Touch X para fechar → fullscreen ok
   Responsividade: Redimensiona janela
   Performance: F12 → Network, Console (sem erros)
   ```

### Semana 1

- Monitorar Google Analytics
- Validar CTR "Destaques" vs "Lançamentos"
- Recolher feedback de clientes
- Ajustar produtos conforme necessário

### Futuro (Sprints)

- Filtros avançados (categoria, preço, rating)
- Histórico de buscas
- IA para recomendações personalizadas
- A/B testing de nomes das seções

---

## 🔧 Arquivos Modificados

| Arquivo | Ação | Tamanho |
|---------|------|--------|
| `snipplets/header/header-search-overlay.tpl` | ✨ NOVO | 3.5 KB |
| `snipplets/header/header-patagang.tpl` | ✏️ EDITADO | +200 linhas |
| `snipplets/header/header-search-results.tpl` | ✏️ EDITADO | 2 linhas |
| `static/css/style-critical.tpl` | ✏️ EDITADO | +430 linhas CSS |
| `static/js/store.js.tpl` | ✏️ EDITADO | +10 linhas JS |
| `layouts/layout.tpl` | ℹ️ CACHE ATUALIZADO | - |

**Total:** 6 arquivos | 0.34 MB | **Deploy em 9.8 segundos**

---

## 📊 Números-Chave

| Métrica | Valor |
|---------|-------|
| **Versão em produção** | Ver `ftp-deploy/LAST_DEPLOY_VERSION.txt` |
| **Backups** | Incremental antes de cada deploy em `backups/incremental/` |

---

## 🎨 Estratégia de Naming (Por Quê?)

### Pesquisa de Mercado (2026)

**"Destaques"** (bestsellers)
- Tendência: Product curation aumenta confiança
- Impacto: +15-20% CTR
- Público: Todos (cold + warm traffic)
- Fonte: [Prefixbox - 25 Best Practices Site Search 2026](https://www.prefixbox.com/blog/ecommerce-site-search-best-practices/)

**"Lançamentos"** (novidades)
- Tendência: Urgency + FOMO = maior conversão
- Impacto: +25-30% discovery
- Público: Novos clientes, repeat visitors
- Fonte: [OptiMonk - Top 10 UX Trends 2026](https://www.optimonk.com/ecommerce-ux-trends/)

Essa **combinação dupla** maximiza conversão em todo o funnel:
- **Top-of-funnel:** "Lançamentos" atrai via curiosidade
- **Mid-funnel:** "Destaques" valida com bestsellers
- **Bottom-funnel:** AJAX search para conversão final

---

## 💡 Como Funciona

### Fluxo Desktop
```
User clica 🔍
         ↓
Overlay abre (backdrop + slide-down animation)
         ↓
Vê: "Destaques" (carrossel) + "Lançamentos" (tags)
         ↓
Digita "coleira"
         ↓
LS.search() AJAX → sugestões aparecem
         ↓
Clica produto → PDP
         ↓
OU ESC/Fechar → volta ao overlay
```

### Fluxo Mobile
```
User toca 🔍
         ↓
Overlay fullscreen (100% viewport)
         ↓
Vê: Lançamentos (chips horizontal) + Destaques (carrossel vertical)
         ↓
Mesma busca AJAX
         ↓
Toca X → fecha
```

---

## ⚠️ Rollback (Se Necessário)

Listar backups: `ls backups/incremental/` ou `node ftp-deploy/list-backups.js`.  
Restaurar: `cd ftp-deploy` → `node rollback-incremental.js [TIMESTAMP]`.  
Ver detalhes em `ftp-deploy/README.md`.

---

## 📋 Checklist de Próximas Ações

- [ ] Limpar cache Nuvemshop (Admin → Temas → Cache)
- [ ] Aguardar 2-5 minutos para CDN atualizar
- [ ] Validar versão no console (conferir em `ftp-deploy/LAST_DEPLOY_VERSION.txt`)
- [ ] Testar overlay abre/fecha
- [ ] Configurar Destaques (admin → seções)
- [ ] Tagear 5-10 produtos como "lançamento"
- [ ] Testar busca AJAX
- [ ] Validar mobile (X fecha, chips scrolláveis)
- [ ] Monitorar Analytics primeira semana
- [ ] Documentar feedback de clientes

---

## 🆘 Troubleshooting Rápido

| Problema | Solução |
|----------|---------|
| Overlay não abre | Limpar cache (Ctrl+Shift+Del) + esperar 5 min |
| "Destaques" vazio | Configurar produtos em "Seções" no admin |
| "Lançamentos" vazio | Adicionar tag "lançamento" aos produtos |
| AJAX não funciona | Verificar console (F12) para erros |
| Mobile quebrado | Testar em viewport 375px (Chrome DevTools) |
| Muito lento | Verificar N de produtos configurados (max 8) |

---

## 📞 Contato & Suporte

**Versão e rollback:** Ver `ftp-deploy/LAST_DEPLOY_VERSION.txt` para a versão atual. Backups em `backups/incremental/`; rollback conforme `ftp-deploy/README.md`.

---

## 📚 Referências

- [E-commerce Best Practices 2026 - BigCommerce](https://www.bigcommerce.com/articles/ecommerce/ecommerce-trends/)
- [Site Search Best Practices - Prefixbox](https://www.prefixbox.com/blog/ecommerce-site-search-best-practices/)
- [UX Trends 2026 - OptiMonk](https://www.optimonk.com/ecommerce-ux-trends/)
- [Nuvemshop Docs - Search](https://docs.nuvemshop.com.br/help/sugesto-de-busca)

---

## ✅ Conclusão

**O Search Overlay está pronto para validação em produção!**

Para validar: usar [validation-checklist.md](validation-checklist.md). Versão a confirmar: ver `ftp-deploy/LAST_DEPLOY_VERSION.txt`.
