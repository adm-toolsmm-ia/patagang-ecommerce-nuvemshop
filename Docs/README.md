# Documentação – Patagang E-commerce Nuvemshop

Documentação do projeto Patagang (tema Nuvemshop): contexto do repositório, plataforma, features e ativos de marca.

---

## Como navegar

| Pasta | Conteúdo | Quando usar |
|-------|----------|-------------|
| **[architecture/](architecture/)** | Arquitetura do projeto (stack, fluxo CSS, deploy). | Visão geral da arquitetura; diagrama de camadas. |
| **[project/](project/)** | Contexto global (estrutura, deploy, home), decisões (ADR-lite), onboarding IA. | Entender como o projeto funciona; onde está o tema e os scripts. |
| **[platform/](platform/)** | Referência da plataforma Nuvemshop (temas, checkout, base theme). | Desenvolver tema; customizar checkout; dúvidas sobre Twig/objetos. |
| **[features/](features/)** | Documentação por feature (Search Overlay, Vista o Propósito, etc.). | Implementar, validar ou dar manutenção em uma feature específica. |
| **[design-assets/](design-assets/)** | Ativos de marca (logos, ícones, fontes). | Consultar ou usar logos, ícones e fontes no tema. |
| **[archive/](archive/)** | Documentos obsoletos ou só para histórico. | Rastreabilidade; não é fonte da verdade atual. |

---

## Convenção

- Cada pasta tem um **README.md** explicando o conteúdo.
- Novas features: criar subpasta em `features/` com README e docs da feature.
- Documentos de implementação/hotfix por data podem ficar em `archive/` dentro da feature ou em `Docs/archive/`.
- Este repositório não utiliza pasta `adr/` nem `ARCHITECTURE.md` na raiz; a documentação de contexto e decisões está em `Docs/` (architecture, project, platform, features).

---

**Última atualização:** 2026-02-13 (reorganização; documentação alinhada à versão atual da loja)
