# Comunicação em Português — Regra de Idioma do Projeto
**Tipo:** Regra Contextual (L3 — Configuração do Projeto)
**Auto-Load:** Sempre ativo
**Data de Criação:** 2026-03-20
**Mantido por:** @architect

---

## PRINCÍPIO FUNDAMENTAL

**Todo agente AIOX que se comunicar com Gabriel Cristofolini DEVE usar PORTUGUÊS BRASILEIRO.**

Isso inclui:
- ✅ Explicações de tarefas
- ✅ Questões e pedidos de confirmação
- ✅ Relatórios de progresso
- ✅ Erros e avisos
- ✅ Documentação destinada ao usuário
- ✅ Comentários em stories/tickets
- ✅ Mensagens de commit (co-authored)

---

## EXCEÇÕES (Onde Inglês É Permitido)

Inglês pode ser usado **apenas em background**, nunca visível ao usuário:

| Contexto | Inglês OK? | Razão |
|----------|-----------|-------|
| Variáveis de código | ✅ SIM | Padrão de desenvolvimento |
| Nomes de funções/classes | ✅ SIM | Padrão de desenvolvimento |
| Comentários técnicos internos | ✅ SIM | Padrão AIOX |
| Chaves JSON/YAML | ✅ SIM | Padrão estruturado |
| Git log (background) | ⚪ OPCIONAL | Mas priorizar PT |
| Mensagens de saída para usuário | ❌ NÃO | **SEMPRE português** |
| Nomes de branches (git) | ✅ SIM | Padrão Git |
| Documentação técnica interna | ⚪ OPCIONAL | Mas priorizar PT |

---

## APLICAÇÃO POR AGENTE

### Todos os 10 Agentes AIOX

| Agente | Comunicação | Restrições | Exemplo |
|--------|------------|-----------|---------|
| @dev (Dex) | 🇧🇷 PORTUGUÊS | Código em inglês OK | "✅ Implementei o botão help sidebar com as cores certas" |
| @qa (Quinn) | 🇧🇷 PORTUGUÊS | Testes em inglês OK | "❌ Teste falhou: checkout não deve ter estrutura modificada" |
| @architect (Aria) | 🇧🇷 PORTUGUÊS | Arquitetura em inglês OK | "Decidi usar CSS em cascata para sobrescrever estilos" |
| @devops (Gage) | 🇧🇷 PORTUGUÊS | Scripts em inglês OK | "✅ Deploy para FTP com sucesso, versão v2026-03-20-01" |
| @pm (Morgan) | 🇧🇷 PORTUGUÊS | PRDs em inglês OK | "Criei EPIC-01 com 4 stories relacionadas ao design" |
| @po (Pax) | 🇧🇷 PORTUGUÊS | ACs em inglês OK | "Story passou em 9/10 critérios de validação" |
| @sm (River) | 🇧🇷 PORTUGUÊS | Templates em inglês OK | "Nova story criada: 1.1.1 - Implementar botão help" |
| @analyst (Alex) | 🇧🇷 PORTUGUÊS | Pesquisa em inglês OK | "Descobri que Nuvemshop limita CSS a 50KB" |
| @data-engineer (Dara) | 🇧🇷 PORTUGUÊS | SQL em inglês OK | "Schema de cache criado com política RLS" |
| @ux-design-expert (Uma) | 🇧🇷 PORTUGUÊS | Design system em inglês OK | "Design system finalizado com 5 cores principais" |

---

## FORMATO DE COMUNICAÇÃO

### ✅ CORRETO (Português)

```
✅ Fase 1 completa: frameworks legados arquivados
- 5 frameworks movidos para .aiox-core/archived/
- 319 arquivos reorganizados
- Pronto para fase 2

Próximo passo: consolidar documentação
```

### ❌ INCORRETO (Inglês)

```
✅ Phase 1 complete: legacy frameworks archived
- 5 frameworks moved to .aiox-core/archived/
- 319 files reorganized
- Ready for phase 2

Next step: consolidate documentation
```

---

## CONTEXTO DO USUÁRIO

**Gabriel Cristofolini:**
- Localização: Brasil 🇧🇷
- Idioma preferido: Português Brasileiro
- Não fala inglês fluentemente
- Requer clareza e contexto em PT

**Implicação:** Toda a comunicação DEVE ser acessível em português.

---

## IMPLEMENTAÇÃO

### Para Agentes Humanos (como Gabriel)

Ao ativar qualquer agente AIOX:
1. **Sempre** communicate em português
2. **Nunca** misture idiomas (mantém claro)
3. **Use** terminologia técnica em português (ex: "função", "classe", "repositório")
4. **Explique** conceitos complexos em português simple

### Para @aiox-master

Reforçar esta regra para todos os agentes:
- Bloquear comunicação em inglês destinada ao usuário
- Avisar se agente viola (ex: "Redirecione resposta para português")

### Para Documentação Interna

- CLAUDE.md: Adicionar seção de idioma
- Agent MEMORY.md: Incluir orientação de português
- Rules: Esta regra auto-loads em todas as interações

---

## EXEMPLOS PRÁTICOS

### Comunicar Erro (CORRETO)

```
❌ Erro detectado na validação FTP

Arquivo: theme-deploy-corrigido/layouts/layout.tpl
Linha: 45
Problema: Estrutura do checkout foi modificada (violação de constraint)

Solução: Reverter alterações no layout.tpl e usar apenas estilos CSS

Próximo passo: Você quer que eu desfaça a mudança?
```

### Questionar Decisão (CORRETO)

```
🤔 Preciso de esclarecimento antes de continuar:

A story 1.1.1 menciona modificar a cor do botão help sidebar.
As cores do design system estão definidas em `agents/ux-design-expert/MEMORY.md`

Qual cor exatamente você quer usar?
- Amarelo (#EAFE67) — primário, mas saturado
- Cinza (#F0F0F0) — neutro, recomendado
- Verde (#00CC66) — sucesso
- Outra cor

Por favor confirme antes de implementar.
```

### Relatar Progresso (CORRETO)

```
✅ PROGRESS REPORT — PHASE 1 COMPLETE

Fiz:
- ✅ Arquivei 5 frameworks legados
- ✅ Criei índice de frameworks legacy
- ✅ Verifiquei que zero frameworks ativos permanecem
- ✅ Commitei alterações

Arquivos modificados: 319
Commits criados: 1
Status: Pronto para fase 2

Próximo passo: Consolidar documentação (Docs/ → docs/)
```

---

## VALIDAÇÃO CONTÍNUA

### Checklist para Cada Comunicação

Antes de enviar mensagem ao usuário, verificar:

- [ ] Mensagem principal em português?
- [ ] Explicações técnicas em português?
- [ ] Questões formuladas em português?
- [ ] Avisos/erros em português?
- [ ] Código/variáveis em inglês OK (background)?
- [ ] Clareza e acessibilidade garantidas?

Se ANY resposta for ❌, **reescrever em português antes de enviar**.

---

## ATUALIZAÇÃO DE DOCUMENTAÇÃO

Todos os seguintes arquivos DEVEM ser atualizados para refletir esta regra:

- ✅ `.claude/CLAUDE.md` — Adicionar seção "Idioma de Comunicação"
- ✅ Todos os `.aiox-core/development/agents/*/MEMORY.md` — Adicionar orientação
- ✅ `.claude/rules/agent-authority.md` — Mencionar português como padrão
- ✅ `CLAUDE.md` — Atualizar com idioma português

---

## PRECEDÊNCIA

Esta regra tem **PRECEDÊNCIA ALTA** em relação a outras guidelines:
- Sobrescreve qualquer padrão de inglês
- Mantém comunic ação clara com o usuário
- Não afeta código/variáveis (inglês OK em background)

---

## FEEDBACK & ITERAÇÃO

Se Gabriel Cristofolini observar:
- ❌ Qualquer comunicação em inglês
- ❌ Mistura de idiomas
- ❌ Terminologia não clara em português

**Por favor avisar imediatamente** — a regra será refinada.

---

**Versão:** 1.0.0
**Criado:** 2026-03-20
**Mantido por:** @architect
**Status:** ATIVO (auto-load em todas as interações)

🇧🇷 **Português é o idioma padrão de comunicação com Gabriel Cristofolini.**
