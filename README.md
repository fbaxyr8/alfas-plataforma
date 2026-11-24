# ALFAS – Plataforma de Literacia em Saúde para Jovens

Projeto Integrador de Sistemas Multimédia I (LEI, ISTEC Porto, 2026/2027).

Aplicação web que disponibiliza workshops e webinars sobre saúde para jovens do 3.º ciclo e do secundário. Cada recurso tem um questionário de diagnóstico e um questionário final, para medir a evolução da aprendizagem, e há badges, certificados e uma biblioteca virtual.

## Equipa

| Elemento | Papel |
|---|---|
| Leonardo Cardoso | Team leader, casos de uso, gestão |
| Erico Veloso | Arquitetura, domínio, DevOps |
| Martim Ferreira | Requisitos, dados, métricas |

## Stack

- **Frontend:** React (a criar na Sprint B)
- **Backend:** Python 3.12 + Flask
- **Base de dados:** MySQL 8

## Estrutura

```
backend/     API Flask e testes (pytest)
frontend/    aplicação React (Sprint B)
database/    schema.sql e seed.sql
docs/        relatório, apresentação e diagramas (docs/modelos)
scripts/     scripts de apoio (ex.: configuração do GitHub)
.github/     pipeline de CI, modelos de issue e de pull request
```

## Executar o backend

```bash
cd backend
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt
flask --app app run              # http://127.0.0.1:5000/api/health
pytest
```

## Documentação da Sprint A

- Relatório e apresentação: [`docs/sprint-A/`](docs/sprint-A/)
- User stories: [`docs/user-stories/`](docs/user-stories/README.md)
- Diagramas: [`docs/modelos/`](docs/modelos/README.md)

## Planeamento

| Sprint | Datas | Objetivos |
|---|---|---|
| A | 31/10 – 21/11/2026 | Requisitos, modelação UML, planeamento |
| B | 21/11 – 19/12/2026 | UI/UX, estrutura cliente, base de dados |
| C | 19/12/2026 – 16/01/2027 | Funcionalidades e testes |

As user stories e o seu estado estão no GitHub Projects do repositório. As regras de colaboração estão em [CONTRIBUTING.md](CONTRIBUTING.md).
