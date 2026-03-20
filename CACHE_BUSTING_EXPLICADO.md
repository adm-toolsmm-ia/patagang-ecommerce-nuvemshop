# 🔄 Cache Busting Explicado - Forçar Atualização no Navegador

## 🎯 O Problema Real

Você vê `v1.1.1` no console porque:

```
1️⃣  FTP recebeu arquivo antigo (version-info.js v1.1.1)
2️⃣  Navegador baixou e CACHEOU esse arquivo
3️⃣  Você enviou nova versão (v1.1.3)
4️⃣  Navegador continua servindo do cache (v1.1.1)
5️⃣  Console mostra informação desatualizada
```

**Resultado:** Arquivo antigo em cache sobrescreve arquivo novo no FTP

---

## ✅ Solução: Cache Busting

### O Que É Cache Busting?

Adicionar um **parâmetro na URL** que muda a cada deploy:

```html
<!-- ❌ Antes (usa cache) -->
<script src="/js/version-info.js" defer></script>

<!-- ✅ Depois (força nova versão) -->
<script src="/js/version-info.js?v=20260320183500" defer></script>
```

Quando o `?v=` muda, o navegador baixa o arquivo novamente em vez de usar cache.

---

## 🔧 Como Implementamos

### 1. Layout.tpl (Automático)

```html
{# Cache busting: força navegador a carregar versão mais recente #}
<script src="{{ 'js/version-info.js' | static_url }}?v={{ "now" | date('YmdHis') }}" defer></script>
```

**O que faz:**
- `{{ "now" | date('YmdHis') }}` → gera timestamp: `20260320183500`
- Cada vez que a página é carregada, o timestamp muda
- Navegador sempre baixa a versão MAIS NOVA

### 2. Deploy Script (deploy-with-version.js)

Quando você executa:
```bash
node deploy-with-version.js 1.1.4
```

O script:
1. ✅ Sincroniza versão
2. ✅ Envia para FTP
3. ✅ Gera relatório com `?v=20260320183500`
4. ✅ Instruções de cache busting

---

## 📊 Como Funciona na Prática

### Exemplo de Deploy v1.1.3 vs v1.1.4

| Timing | Evento | Cache | Console |
|--------|--------|-------|---------|
| T=0 | v1.1.1 online no FTP | `version-info.js` | 📦 v1.1.1 ✅ |
| T=1 | Você envia v1.1.3 para FTP | Ainda v1.1.1 | 📦 v1.1.1 ❌ |
| T=2 | Navegador acessa: `/js/version-info.js?v=20260320180000` | **Força nova versão** | 📦 v1.1.3 ✅ |
| T=3 | Você envia v1.1.4 para FTP | v1.1.3 em cache | 📦 v1.1.3 ❌ |
| T=4 | Nova página com `?v=20260320185000` | **Força nova versão** | 📦 v1.1.4 ✅ |

**Regra:** O `?v=` SEMPRE muda → navegador SEMPRE atualiza

---

## 🚀 Processo de Deploy Completo (Agora Simplificado)

### ANTES (Manual & Problemático)
```bash
# 1. Sincronizar versão (manual)
node sync-version.js 1.1.4

# 2. Fazer deploy (manual)
npm run deploy:critical

# 3. Validar (manual & demorado)
# - Limpar cache Nuvemshop
# - Esperar 5-10 minutos
# - Limpar cache navegador
# - Testar
```

### AGORA (Automático & Confiável)
```bash
# 1. Deploy completo com tudo sincronizado
node deploy-with-version.js 1.1.4

# Pronto! O script:
# ✅ Sincroniza versão
# ✅ Envia para FTP
# ✅ Aplica cache busting automaticamente
# ✅ Gera relatório com instruções
```

---

## 📋 Validação no Console

Após fazer deploy, **no navegador** (F12 → Console):

```javascript
// Teste 1: Versão atual
window.__PATAGANG_VERSION__.version
// Deve retornar: "1.1.4"

// Teste 2: Data do deploy
window.__PATAGANG_VERSION__.date
// Deve retornar: "2026-03-20"

// Teste 3: Timestamp de atualização
window.__PATAGANG_VERSION__.timestamp
// Retorna ISO: "2026-03-20T18:35:00.000Z"
```

---

## ⚠️ Por Que Você Continua Vendo v1.1.1

**Cenário atual:**
1. FTP tem v1.1.1 (arquivo antigo)
2. Seu projeto tem v1.1.3 (arquivo novo, NÃO ENVIADO ainda)
3. Console mostra v1.1.1 (porque é o que está no FTP)

**Solução:**
```bash
# ENVIE a versão nova para FTP
node deploy-with-version.js 1.1.3

# Isso:
# 1. Confirma versão = 1.1.3
# 2. Envia version-info.js NOVA para FTP
# 3. Layout.tpl com cache busting (?v=timestamp)
# 4. Navegador baixa arquivo NOVO (não usa cache)
# 5. Console mostra v1.1.3 ✅
```

---

## 🔍 Diagnóstico: É Cache ou Arquivo Antigo?

### Como Saber Se É Cache

**No DevTools (F12):**

1. Abra a aba **Network**
2. Recarregue a página (F5)
3. Procure por `version-info.js`
4. Olhe a coluna **Status**

```
✅ 200 OK        → Arquivo foi baixado do servidor (não é cache)
⚠️  304 Not Mod. → Arquivo está em cache local (desatualizado)
⚠️  (disk cache) → Arquivo é do cache do navegador
```

### Como Saber Se É Arquivo Antigo no FTP

```bash
# Via SSH/FTP, verifique tamanho e data do arquivo
# Se mostrar data antiga (2026-03-20 03:46) → arquivo não foi atualizado
# Se mostrar data nova (2026-03-20 18:35) → arquivo foi atualizado
```

---

## 🛠️ Limpeza de Cache (Quando Necessário)

### Cache Nuvemshop (Automático)
- Nuvemshop limpa automaticamente em **3-5 minutos**
- Você NÃO pode forçar manualmente (customização via FTP)
- Paciência! 😊

### Cache Navegador (Manual)

**Chrome/Edge:**
- `Ctrl+Shift+Delete` → Abre limpeza de cache
- Selecione: "Todos os tempos" + "Cookies e dados armazenados"
- Marque o site da loja
- Clique em "Limpar dados"

**Firefox:**
- `Ctrl+Shift+Delete` → Abre Histórico
- Clique em "Limpar histórico recente"
- Selecione: "Tudo" + "Cookies, cache, histórico"

**Safari:**
- Menu → "Desenvolver" → "Esvaziar Caches"
- Ou: Preferences → Privacidade → "Gerenciar dados do site"

### Aba Incógnita (Mais Fácil)
```
Ctrl+Shift+N (Nova aba incógnita)
→ Abre sem cache nenhum
→ Perfecto para testar!
```

---

## 📊 Fluxo de Cache Busting

```
DEPLOY COM CACHE BUSTING
│
├─ Sincronizar Versão
│  └─ layout.tpl gera novo ?v=timestamp
│
├─ Enviar para FTP
│  └─ Novo version-info.js vai para produção
│
├─ Navegador Baixa
│  ├─ Vê: /js/version-info.js?v=20260320183500
│  ├─ Compara com cache: DIFERENTE!
│  └─ Baixa arquivo NOVO (ignora cache antigo)
│
└─ Console Mostra
   └─ 📦 PATAGANG v1.1.3 ✅
```

---

## 🚀 Próximos Passos

### Agora
```bash
# 1. Sincronize e envie a versão NOVA
node ftp-deploy/deploy-with-version.js 1.1.3

# 2. Siga as instruções do relatório que será gerado
```

### Depois
```bash
# 1. Limpe cache Nuvemshop (automático em 3-5 min)
# 2. Limpe cache navegador (Ctrl+Shift+Delete)
# 3. Abra em aba incógnita (Ctrl+Shift+N)
# 4. Force reload (Ctrl+Shift+R)
# 5. F12 → Console → procure "📦 PATAGANG v1.1.3"
```

---

**Sistema de cache busting implementado e pronto! 🎉**
