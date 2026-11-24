#!/usr/bin/env bash
# Configura o GitHub do projeto: etiquetas, milestones, uma issue por user story e o GitHub Projects.
# Requisitos: GitHub CLI (https://cli.github.com) com sessão iniciada:  gh auth login
#             e permissão de projetos:                                  gh auth refresh -s project
# Uso (na pasta do repositório):  bash scripts/setup_github.sh
set -euo pipefail

# ---- EDITAR: utilizadores GitHub de cada elemento -------------------------
LEONARDO="leonardocardoso2022192-dotcom"
ERICO="TRAFULHA8"
MARTIM="fbaxyr8"
# ---------------------------------------------------------------------------

REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
OWNER=${REPO%%/*}
echo "Repositório: $REPO"

label() { gh label create "$1" --color "$2" --description "$3" --force >/dev/null; }
label "user story"        "1A7F74" "User story do backlog"
label "sprint A"          "0E8A16" "Sprint A"
label "sprint B"          "FBCA04" "Sprint B"
label "sprint C"          "D93F0B" "Sprint C"
label "prioridade 1"      "B60205" "Obrigatório"
label "prioridade 2"      "D93F0B" "Necessário"
label "prioridade 3"      "FBCA04" "Favorável"
label "prioridade 4"      "C2E0C6" "Facultativo (valorização)"
label "extra"             "5319E7" "User story proposta pela equipa"
label "análise"           "1D76DB" "Requisitos e modelação"
label "dados"             "0052CC" "Modelo de dados"
label "gestão"            "5319E7" "Gestão do projeto"
label "devops"            "006B75" "Repositório e CI"
for sp in 1 2 3 5 8; do label "SP $sp" "EDEDED" "Estimativa: $sp story points"; done

milestone() {
  gh api "repos/$REPO/milestones" -f title="$1" -f due_on="$2" -f description="$3" >/dev/null 2>&1 \
    || echo "  (milestone '$1' já existe)"
}
milestone "Sprint A" "2026-11-21T23:59:00Z" "Requisitos, modelação UML e planeamento"
milestone "Sprint B" "2026-12-19T23:59:00Z" "UI/UX, estrutura cliente e base de dados"
milestone "Sprint C" "2027-01-16T23:59:00Z" "Funcionalidades gerais, validação e testes"

# id | prioridade | SP | responsável | área | título | descrição
US=$(cat << 'LIST'
US_A001|1|5|MARTIM|análise|Requisitos FURPS+|Como Analista de Software, eu pretendo que a equipa faça o levantamento de requisitos funcionais e não funcionais, pelo método FURPS+.
US_A002|1|5|LEONARDO|análise|Diagramas de Use Cases|Como Analista de Software, eu pretendo perceber as funcionalidades do sistema através do diagrama de Use Cases, claro e completo, tanto para o backoffice como para o frontoffice.
US_A003|1|5|MARTIM|dados|Modelo Relacional de Dados|Como Gestor de Bases de Dados, eu pretendo perceber a estrutura e a relação da informação necessária ao sistema através do Modelo Relacional de Dados.
US_A004|1|5|ERICO|análise|Modelo de Domínio|Como Analista de Software, eu pretendo perceber o domínio do sistema, especificando os agregados, as entidades e os seus atributos, através do Modelo de Domínio.
US_A005|4|2|ERICO|análise|Descrição do UC Responder a Questionário Final|Como Analista de Software, eu pretendo detalhar o cenário de sucesso principal do UC "Responder a Questionário Final" através da descrição estruturada de UC.
US_A006|2|3|ERICO|devops|Repositório GitHub|Como Programador, pretendo preparar, configurar e partilhar um repositório GitHub com a equipa de desenvolvimento e orientação, com estrutura inicial do projeto, README, .gitignore e regras de branch/PR, para facilitar colaboração e controlo de versões.
US_A007|3|3|MARTIM|dados|Dicionário de Dados|Como Analista de Software, eu pretendo detalhar informação específica do Modelo Relacional de Dados, num Dicionário de Dados (DD).
US_A008|4|2|MARTIM|análise|Fluxograma do UC Registar Utilizador|Como Analista de Software, eu pretendo estruturar num fluxograma o processo detalhado do UC "Registar Utilizador", incluindo o pedido de consentimento parental no caso de menores.
US_A009|3|3|MARTIM|dados|Métricas de progresso de aprendizagem|Como Analista de Dados, eu pretendo definir as métricas de avaliação do progresso de aprendizagem e as variáveis necessárias ao seu cálculo, identificando onde ficam registadas no modelo de dados.
US_A010|2|3|LEONARDO|gestão|Apresentação da sprint review|Como Gestor de Projeto, eu pretendo preparar a sprint review para apresentação no dia de avaliação (deadline da sprint).
US_A011|1|3|LEONARDO|gestão|GitHub Projects e issues|Como Gestor de Projeto, eu pretendo estruturar o GitHub Projects, user stories e issues (com responsável, etiquetas, prioridade e estimativa), para dar visibilidade ao progresso e facilitar a gestão do trabalho.
US_A012|3|3|ERICO|devops|GitHub Actions|Como Programador, eu pretendo configurar GitHub Actions com um pipeline mínimo (build, testes e verificação de qualidade básica, quando aplicável), para automatizar validações e reduzir erros nas entregas.
US_A013|3|5|LEONARDO|gestão|Relatório da sprint|Como Gestor de Projeto, eu pretendo compilar num relatório, todo o trabalho produzido.
US_A014|3|2|LEONARDO|extra|Diagrama de Estados da conta|Como Analista de Software, eu pretendo um diagrama de estados do ciclo de vida da conta de utilizador, para garantir que a verificação de email, o consentimento parental, a suspensão e a eliminação (RGPD) seguem regras claras e verificáveis.
US_A015|3|2|ERICO|extra|Diagrama de Componentes e Implantação|Como Arquiteto de Software, eu pretendo um diagrama de componentes e implantação da arquitetura React–Flask–MySQL, para que a equipa conheça as fronteiras entre camadas e os protocolos antes de iniciar a Sprint B.
US_A016|4|2|ERICO|extra|Diagrama de Atividades do percurso de aprendizagem|Como Analista de Software, eu pretendo um diagrama de atividades do percurso de aprendizagem (diagnóstico → conteúdo → questionário final → badge/certificado), para validar com o cliente as regras de progressão antes da implementação.
LIST
)

echo "A criar o GitHub Projects..."
PROJECT_NUM=$(gh project create --owner "$OWNER" --title "ALFAS – Backlog" --format json -q .number)
gh project link "$PROJECT_NUM" --owner "$OWNER" --repo "$REPO" >/dev/null 2>&1 || true
gh project field-create "$PROJECT_NUM" --owner "$OWNER" --name "Prioridade" --data-type SINGLE_SELECT \
  --single-select-options "1 Obrigatório,2 Necessário,3 Favorável,4 Facultativo" >/dev/null
gh project field-create "$PROJECT_NUM" --owner "$OWNER" --name "Estimativa (SP)" --data-type NUMBER >/dev/null

echo "A criar as issues..."
while IFS='|' read -r id prio sp who area title desc; do
  [ -z "$id" ] && continue
  user=${!who}
  body=$(printf '%s\n\n## Critérios de aceitação\n\n- [ ] Artefacto versionado no repositório\n- [ ] Revisto por outro elemento (pull request)\n- [ ] Integrado no relatório\n' "$desc")
  labels="user story,sprint A,prioridade $prio,SP $sp,$area"
  url=$(gh issue create --title "$id – $title" --body "$body" --label "$labels" \
        --milestone "Sprint A" --assignee "$user" 2>/dev/null \
     || gh issue create --title "$id – $title" --body "$body" --label "$labels" --milestone "Sprint A")
  gh project item-add "$PROJECT_NUM" --owner "$OWNER" --url "$url" >/dev/null
  echo "  $id → $url"
done <<< "$US"

echo
echo "Feito. Falta, na página do projeto (https://github.com/users/$OWNER/projects/$PROJECT_NUM ou da organização):"
echo " - mudar para a vista Board e criar as colunas Backlog, To Do, In Progress, In Review, Done no campo Status;"
echo " - preencher os campos Prioridade e Estimativa (SP) de cada item, se quiserem além das etiquetas."
