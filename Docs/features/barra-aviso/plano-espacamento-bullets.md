# Plano: Espaçamento entre bullets e frases na barra de aviso

**Data:** 2025-03-10  
**Contexto:** Barra de aviso (ad bar) com texto cadastrado fixo na Nuvemshop — bullets (•) e frases aparecem colados.  
**Objetivo:** Garantir espaçamento visual adequado entre cada círculo e cada frase, em desktop e mobile.

---

## 1. Diagnóstico

### 1.1 Arquivos envolvidos

| Arquivo | Função |
|---------|--------|
| `theme-deploy-corrigido/snipplets/header/header-advertising.tpl` | Template que renderiza o conteúdo da barra |
| `theme-deploy-corrigido/static/css/style-critical.tpl` | CSS da barra e do separador (linhas ~2110–2167) |
| `theme-deploy-corrigido/layouts/layout.tpl` | Override final da barra (linhas ~107–147) |

### 1.2 Causas identificadas

1. **Texto cadastrado “tudo junto”**  
   O campo `settings.ad_text` (Nuvemshop) pode conter algo como:
   - `Frete grátis acima de R$250•10% OFF no PIX•30 dias para trocas e devoluções`
   - Os `•` são caracteres dentro do texto, sem elemento HTML em volta → CSS não consegue espaçar.

2. **Override mobile zera margens**  
   Em `layout.tpl`, o bloco `@media (max-width: 768px)` aplica:
   ```css
   body .section-advertising * {
     margin: 0 !important;
   }
   ```
   Isso sobrescreve o `margin-left/right: 5em` do `.section-advertising__sep`, deixando tudo colado no mobile.

3. **Separadores só entre repetições do bloco**  
   O template atual repete o texto inteiro 4× e insere `__sep` apenas entre essas repetições. Os `•` que vêm *dentro* do texto não recebem a classe `__sep`.

---

## 2. Solução proposta

### 2.1 Estratégia

1. **Template:** Quebrar `settings.ad_text` por `•` e renderizar cada parte em `<span class="section-advertising__copy">`, com `<span class="section-advertising__sep"> • </span>` entre elas.
2. **Layout:** Excluir `.section-advertising__sep` do `margin: 0` no override mobile.
3. **CSS:** Ajustar o valor de margin do `__sep` (5em → ~0.6–1em) para um espaçamento proporcional e legível.

### 2.2 Compatibilidade

- **Liquid:** O filtro `split` é padrão (Shopify/Nuvemshop usam Liquid).
- **Fallback:** Se o texto não contiver `•`, o `split` retorna um único elemento → comportamento equivalente ao atual.
- **Separadores alternativos:** Se o usuário usar ` - ` ou ` | `, o plano atual não quebra; pode ser estendido depois com splits adicionais.

---

## 3. Tarefas de implementação

### Tarefa 1 — Alterar o template `header-advertising.tpl`

**Objetivo:** Quebrar o texto por `•` e envolver cada parte em elementos com classes BEM.

**Antes (trecho relevante):**
```liquid
<span class="section-advertising__copy">{% for i in 1..4 %}{{ settings.ad_text }}{% if not loop.last %}<span class="section-advertising__sep" aria-hidden="true"> • </span>{% endif %}{% endfor %}</span>
```

**Depois (lógica):**
- `{% assign parts = settings.ad_text | split: '•' %}`
- Para cada `part` em `parts`, renderizar `<span class="section-advertising__copy">{{ part | strip }}</span>`
- Entre itens (exceto o último): `<span class="section-advertising__sep" aria-hidden="true"> • </span>`
- Manter a estrutura do marquee (repetir o bloco 2× para animação contínua)

**Detalhe:** O marquee atual duplica o conteúdo para animação infinita. A nova lógica deve gerar um “bloco base” (partes + separadores) e repetir esse bloco 2× dentro do `__track`, como hoje.

---

### Tarefa 2 — Corrigir override mobile em `layout.tpl`

**Objetivo:** Preservar margem do `.section-advertising__sep` no mobile.

**Alteração:** Trocar o seletor que aplica `margin: 0` para excluir o `__sep`, ou adicionar regra específica para o `__sep` após o bloco.

**Opção A — Excluir do reset:**
```css
body .section-advertising *:not(.section-advertising__sep) {
  margin: 0 !important;
}
```
(Manter `padding: 0` em `*` se necessário; o `__sep` não precisa de padding zerado.)

**Opção B — Override explícito do __sep:**
Manter o `*` com `margin: 0` e, em seguida, adicionar:
```css
body .section-advertising .section-advertising__sep {
  margin-left: 0.6em !important;
  margin-right: 0.6em !important;
}
```

Recomendação: **Opção B** — garante valor explícito no override final e evita conflitos de especificidade.

---

### Tarefa 3 — Ajustar margin do `__sep` em `style-critical.tpl`

**Objetivo:** Usar valor proporcional (0.6em ou 1em) em vez de 5em.

**Arquivo:** `theme-deploy-corrigido/static/css/style-critical.tpl` (linhas ~2163–2166)

**Alteração:**
```css
.section-advertising__sep {
  margin-left: 0.75em;
  margin-right: 0.75em;
  flex-shrink: 0;
}
```

O override em `layout.tpl` (Tarefa 2) já define o valor para mobile; o critical serve como base para desktop.

---

## 4. Ordem de execução

| # | Tarefa | Arquivo | Dependência |
|---|--------|---------|-------------|
| 1 | Template: split + BEM | header-advertising.tpl | — |
| 2 | Override mobile: preservar margin do __sep | layout.tpl | — |
| 3 | Ajustar margin base do __sep | style-critical.tpl | — |

Tarefas 1, 2 e 3 podem ser feitas em paralelo; não há dependência entre elas.

---

## 5. Validação

1. **Desktop:** Barra com texto tipo `Frase1 • Frase2 • Frase3` — verificar espaçamento entre cada `•` e as frases.
2. **Mobile:** Mesmo texto — confirmar que o espaçamento se mantém (override não zera o `__sep`).
3. **Texto sem bullet:** Ex.: `Frete grátis em compras acima de R$250` — deve exibir normalmente, sem quebras indevidas.
4. **Texto com • sem espaços:** Ex.: `Frase1•Frase2` — o `split: '•'` deve quebrar; o `strip` nas partes remove espaços residuais.

---

## 6. Riscos e mitigação

| Risco | Mitigação |
|-------|-----------|
| Liquid da Nuvemshop sem `split` | Verificar em tema de teste; fallback: manter template atual e aplicar só Tarefas 2 e 3 (ajuda nos separadores entre repetições do bloco). |
| Usuário usa separador diferente (ex: ` \| `) | Documentar que o formato esperado é `•`; versão futura pode suportar múltiplos separadores. |
| Quebra de layout em edge cases | Testar com texto vazio, só espaços, ou muitos bullets. |

---

## 7. Deploy

Conforme regra do projeto: após alterações no tema, executar:

```powershell
Set-Location ftp-deploy; node deploy-optimized.js
```

E, no admin Nuvemshop: Themes → tema ativo → Limpar Cache.

---

## 8. Referências

- [ai-onboarding.md](../../project/ai-onboarding.md) — ponto de entrada para alterações no tema
- [standards-css-e-tema-nuvemshop.md](../../project/standards-css-e-tema-nuvemshop.md) — cascata, override final
- [Liquid split filter](https://shopify.github.io/liquid/filters/split/) — documentação do filtro
