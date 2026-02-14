# Padrões de CSS e tema Nuvemshop

Padrões obrigatórios para análises e alterações em CSS e tema. Evitam situações em que alterações não tenham efeito por ordem na cascata, CSS injetado pela plataforma ou base theme.

**Regra Cursor:** `.cursor/rules/padroes-css-e-tema-nuvemshop.mdc` (sempre aplicada)
**Estrutura do tema:** [context-home.md](context-home.md)

---

## 1. Contexto (motivação)

No caso da barra de aviso (`.section-advertising`), alterações no `style-critical.tpl` e `style-home-v2.css` não faziam o fundo amarelo aparecer na home. A regra que vencia era `.section-advertising { background: transparent !important; position: relative; z-index: 1; }` vinda de CSS da plataforma/base theme, carregado **depois** dos nossos arquivos. Com mesma especificidade e `!important`, vence a última regra no documento. A solução foi um override final em `layout.tpl` (bloco `<style>` após `settings.css_code`) que carrega por último e garante o resultado.

---

## 2. Ordem de carregamento de CSS (referência)

No `layout.tpl`, a ordem é (ver [context-home.md](context-home.md)):

1. Critical (inline): `style-critical.tpl`, `style-menu-patagang.css.tpl`, `style-filters-patagang.css.tpl`
2. Cores (inline): `style-colors.scss.tpl` (compilado pela Nuvemshop)
3. Async (link): `style-async.scss.tpl` (media="print" → onload="all")
4. Home (link, só se `template == 'home'`): `style-home-v2.css`
5. Blog (link), `settings.css_code` (inline), e qualquer bloco que venha em seguida

Qualquer regra em um item posterior sobrescreve uma regra anterior (mesma especificidade e `!important`).

---

## 3. Padrões (detalhados)

### 3.1 Cascade e ordem

**Regra:** Com mesma especificidade e `!important`, vence a última regra no documento. Não basta adicionar mais uma regra no critical ou em arquivos que carregam antes; é preciso garantir que nossa regra apareça **depois** do que está sobrescrevendo.

**O que fazer:** Antes de acrescentar regras em critical ou home-v2, verificar onde nosso CSS aparece na ordem. Se outra folha (colors compilado, plataforma) carrega depois e define o mesmo seletor com `!important`, nossa regra será sobrescrita.

### 3.2 Validar com a cascata real

**Regra:** Se uma alteração "não tiver efeito", não iterar cegamente no código. Obter evidência da cascata real no navegador.

**O que fazer:** Pedir ou consultar DevTools (Elemento > Styles) para o elemento: qual regra está aplicada (não riscada), de qual arquivo/folha vem, quais regras estão riscadas e por quê. Usar essa evidência para decidir onde colocar o override ou o que remover.

### 3.3 Plataforma e base theme

**Regra:** O CSS final pode vir do base theme da Nuvemshop, do `style-colors` compilado (possivelmente mesclado com o base) e de CSS injetado pela plataforma. Não assumir que só os arquivos do tema controlam um elemento.

**O que fazer:** Considerar que regras em `style-colors.scss.tpl` ou no base theme podem afetar elementos como `.section-advertising`. Quando necessário, definir regras explícitas no nosso `style-colors` ou usar um override final em `layout.tpl` que carregue por último.

### 3.4 Override final para UI crítica

**Regra:** Para elementos que precisam ter aparência garantida (ex.: barra de aviso, header fixo), definir uma regra "última palavra" em arquivo que controlamos e que carrega por último.

**O que fazer:** Incluir um bloco `<style>` condicional em `layouts/layout.tpl` **após** `settings.css_code` (e qualquer outro CSS). Usar seletor com especificidade suficiente (ex.: `body .section-advertising`) e `!important` para garantir vitória. Manter esse bloco curto e documentado.

### 3.5 Consolidação

**Regra:** Evitar espalhar a mesma definição em vários arquivos; isso aumenta o risco de uma ser sobrescrita sem percebermos e cria inconsistências.

**O que fazer:** Preferir uma fonte principal (ex.: critical ou colors) + um override final explícito quando necessário. Remover definições redundantes (ex.: regra em style-home-v2 que duplica a do critical sem necessidade).

---

## 4. Checklist para análise/alteração

Ao analisar ou alterar CSS/tema, verificar:

- [ ] A ordem de carregamento de CSS foi considerada? Onde nossa regra aparece em relação às outras folhas?
- [ ] Se a alteração não tiver efeito, foi pedido ou consultado os estilos ativos no DevTools para identificar a regra vencedora e a origem?
- [ ] Foi considerado que a plataforma/base theme pode injetar ou mesclar CSS?
- [ ] Para UI crítica (aparência que deve ser garantida), foi considerado um override final em `layout.tpl` após todos os CSS?
- [ ] As definições estão consolidadas? Não há duplicação desnecessária em vários arquivos?
- [ ] Para regras que afetam mais de um contexto (listagem, home, PDP), consultar [css-impact-map.md](css-impact-map.md) e considerar escopo `body.template-*`.
- [ ] Para localizar seções em arquivos grandes: usar o TOC no topo de `style-critical.tpl` e `style-async.scss.tpl`.

---

## 5. Referências cruzadas

- **Regra Cursor:** `.cursor/rules/padroes-css-e-tema-nuvemshop.mdc`
- **Contexto do projeto e ordem de CSS:** [context-home.md](context-home.md)
- **Mapa de impacto (seletores genéricos):** [css-impact-map.md](css-impact-map.md)
- **README do project:** [README.md](README.md)
