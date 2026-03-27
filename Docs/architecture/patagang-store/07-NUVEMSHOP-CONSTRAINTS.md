# 07. Nuvemshop Constraints

## Objetivo

Registrar constraints praticos da plataforma visiveis no codigo e no fluxo de operacao do projeto.

## Constraints observados no codigo

1. **Checkout gerenciado pela plataforma**
   - Nao existe template de checkout no tema.
   - Estilizacao dedicada em `static/checkout.scss.tpl`.

2. **Dependencia de runtime da plataforma**
   - JS custom usa `jQueryNuvem` e `LS.*`.
   - Arquivos centrais: `store.js.tpl`, `cart-drawer.js.tpl`, `cart-utils.js.tpl`.

3. **Sobrescrita CSS centralizada no layout**
   - `layout.tpl` concentra overrides e possui 100 `!important`.
   - Impacta previsibilidade de alteracoes visuais.

4. **Fluxo de deploy FTP com versionamento**
   - Versao e marker frontend atualizados em:
     - `theme-deploy-corrigido/VERSION.json`
     - `theme-deploy-corrigido/static/js/version-info.js`

## Ponto que exige validacao operacional

- `snipplets/footer.tpl` nao contem texto literal `Powered by Nuvemshop`.
- Se houver exigencia contratual de exibicao literal, validar em runtime/plataforma e adequar sem quebrar customizacao.

## Regras de seguranca para melhorias

- Nao sobrescrever APIs da plataforma (`LS.*`, `jQueryNuvem`).
- Evitar alterar estruturas sensiveis de formulario sem evidencia e teste funcional.
- Tratar referencias a arquivos ausentes (`external*.tpl`) antes de depender delas em novas features.
