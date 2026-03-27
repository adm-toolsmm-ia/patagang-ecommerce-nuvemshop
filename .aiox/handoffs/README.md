# AIOX Handoffs - Estado Atual

Este diretorio deve conter apenas handoffs ativos do workflow AIOX atual.

## Regras operacionais

- Nao manter handoffs legados de epics, stories ou sessoes encerradas.
- Criar handoff somente quando houver transferencia ativa entre agentes.
- Ao concluir a transferencia, remover o arquivo de handoff ativo.
- Priorizar fatos atuais validados no codigo e na versao vigente `v1.5.170`.

## Estado no momento

Nao ha handoffs ativos.

Quando um novo handoff for necessario, criar um `.yaml` curto e objetivo com:

- `from_agent`
- `to_agent`
- `timestamp`
- `status`
- `scope`
- `next_actions`
- `consumed`
