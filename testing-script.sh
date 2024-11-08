#!/bin/bash
# Vérifier si un numéro de problème a été fourni en argument
if [ -z "$1" ]; then
  echo "Usage: $0 <issue_number>"
  exit 1
fi
ISSUE_NUMBER=$1
ORG="ai-cfia"
# Étape 1: Extraire les titres des projets associés à cet issue
titles=$(gh issue view "$ISSUE_NUMBER" --json projectItems | jq -r '.projectItems[].title' | paste -sd "," -)
if [ -z "$titles" ]; then
  echo "Aucun projet trouvé associé à l'issue $ISSUE_NUMBER."
  exit 1
fi
# Convertir les titres en une expression régulière
titles_regex=$(echo "$titles" | sed 's/,/|/g')
# Étape 2: Requête pour obtenir les IDs de projets et les champs "Status"
read -r -d '' QUERY <<- EOM
query(\$org: String!) {
  organization(login: \$org) {
    projectsV2(first: 20) {
      nodes {
        id
        title
        fields(first: 20) {
          nodes {
            ... on ProjectV2FieldCommon {
              id
              name
            }
          }
        }
      }
    }
  }
}
EOM
project_info=$(gh api graphql -f query="$QUERY" -f org="$ORG" | jq -r --arg titles_regex "$titles_regex" '
.data.organization.projectsV2.nodes[] |
select(.title | test($titles_regex)) |
{
  project_title: .title,
  project_id: .id,
  status_field_id: (.fields.nodes[] | select(.name == "Status") | .id)
} | @base64')
if [ -z "$project_info" ]; then
  echo "Aucun ID de projet correspondant trouvé pour les titres : $titles."
  exit 1
fi
echo "Informations sur les projets associés :"
echo "$project_info" | while read -r base64_project; do
  project_json=$(echo "$base64_project" | base64 --decode)
  echo "$project_json" | jq -r '. | "Title: \(.project_title), Project ID: \(.project_id), Status Field ID: \((.status_field_id // "Not Found"))"'
done
# Étape 3: Pour chaque projet, obtenir l'ID de l'item lié à l'issue
echo ""
echo "Recherche des items associés pour l'issue $ISSUE_NUMBER :"
while read -r base64_project; do
  project_json=$(echo "$base64_project" | base64 --decode)
  project_id=$(echo "$project_json" | jq -r '.project_id')
  project_title=$(echo "$project_json" | jq -r '.project_title')
  echo "Projet: $project_title (ID: $project_id)"
  # Pagination pour récupérer tous les items
  has_next_page=true
  end_cursor=null
  while [ "$has_next_page" == "true" ]; do
    read -r -d '' QUERY_ITEMS << EOM
    query(\$project_id: ID!, \$end_cursor: String) {
      node(id: \$project_id) {
        ... on ProjectV2 {
          items(first: 100, after: \$end_cursor) {
            nodes {
              id
              content {
                ... on Issue {
                  number
                }
              }
            }
            pageInfo {
              hasNextPage
              endCursor
            }
          }
        }
      }
    }
EOM

    result=$(gh api graphql -f query="$QUERY_ITEMS" -f project_id="$project_id" -f end_cursor="$end_cursor")
    # Vérifier la présence d'items
    item_ids=$(echo "$result" |
      jq -r --argjson issue_number "$ISSUE_NUMBER" '
      .data.node.items.nodes[] |
      select(.content.number == $issue_number) |
      .id')
    if [ -n "$item_ids" ]; then
      echo "Items liés à l'issue $ISSUE_NUMBER dans le projet $project_title (ID: $project_id) : $item_ids"
    fi
    # Mise à jour de la pagination
    has_next_page=$(echo "$result" | jq -r '.data.node.items.pageInfo.hasNextPage')
    end_cursor=$(echo "$result" | jq -r '.data.node.items.pageInfo.endCursor')
  done
done <<< "$project_info"
