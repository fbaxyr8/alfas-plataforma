# Regras de colaboração

## Branches

- `main`: versão entregue no fim de cada sprint. Protegida: só recebe código por pull request vindo de `develop`.
- `develop`: integração do trabalho da sprint. Protegida: só recebe código por pull request.
- `feature/US_<id>-<descricao>`: uma branch por user story, criada a partir de `develop`.
  Exemplo: `feature/US_A006-repositorio`.

## Pull requests

1. Criar a branch a partir de `develop` atualizada.
2. Fazer commits pequenos (ver convenção abaixo).
3. Abrir um pull request para `develop` e preencher o modelo.
4. O pull request precisa de **1 aprovação** de outro elemento e do **CI verde**.
5. Na descrição, escrever `Closes #<n.º da issue>` para fechar a issue da user story.

## Commits (Conventional Commits)

`tipo: descrição curta`, com os tipos:

| Tipo | Quando |
|---|---|
| `feat` | nova funcionalidade |
| `fix` | correção de erro |
| `docs` | documentação e diagramas |
| `test` | testes |
| `ci` | pipeline |
| `chore` | manutenção (dependências, configuração) |

Exemplo: `docs: adiciona diagrama de casos de uso v1.1`
