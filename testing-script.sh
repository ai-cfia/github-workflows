#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 ISSUE_NUMBER"
  exit 1
fi

ISSUE_NUMBER=$1
OWNER="ai-cfia"

echo "1. Project associated with this issue number #$ISSUE_NUMBER"
PROJECT_ITEMS_JSON=$(gh issue view $ISSUE_NUMBER --json projectItems)

PROJECT_TITLES=$(echo "$PROJECT_ITEMS_JSON" | jq -r '.projectItems[].title')

echo "$PROJECT_TITLES"

echo "2. Project information"

PROJECT_LIST=$(gh project list --owner $OWNER)

declare -A PROJECT_NUMBER_ID_MAP

while read -r TITLE; do
  PROJECT_LINE=$(echo "$PROJECT_LIST" | grep -F "$TITLE")

  if [ -z "$PROJECT_LINE" ]; then
    echo "Project '$TITLE' not found."
    continue
  fi

  # Format : NUMBER  TITLE  STATE  ID
  PROJECT_NUMBER=$(echo "$PROJECT_LINE" | awk '{print $1}')
  PROJECT_ID=$(echo "$PROJECT_LINE" | awk '{print $NF}')

  echo "Project '$TITLE' trouvé :"
  echo "  # : $PROJECT_NUMBER"
  echo "  ID     : $PROJECT_ID"

  PROJECT_NUMBER_ID_MAP[$PROJECT_NUMBER]=$PROJECT_ID
done <<< "$PROJECT_TITLES"

declare -A ITEM_ID_MAP

echo "3. Item id associated to each project for a specifi issue"

for PROJECT_NUMBER in "${!PROJECT_NUMBER_ID_MAP[@]}"; do
  PROJECT_ID=${PROJECT_NUMBER_ID_MAP[$PROJECT_NUMBER]}
  echo "Searching #$ISSUE_NUMBER in '$PROJECT_NUMBER'"

  ITEMS_JSON=$(gh project item-list "$PROJECT_NUMBER" --limit 2000 --owner "$OWNER" --format json)

  ITEM_ENTRY=$(echo "$ITEMS_JSON" | jq -r --argjson ISSUE_NUMBER "$ISSUE_NUMBER" 'items.[] | select(.content.number == $ISSUE_NUMBER)')
  ITEM_ID=$(echo "$ITEM_ENTRY" | jq -r '.id')

  if [ -z "$ITEM_ID" ]; then
    echo "Issue #$ISSUE_NUMBER not found in '$PROJECT_NUMBER'."
    continue
  fi

  echo "Item found #$ISSUE_NUMBER in '$PROJECT_NUMBER' with ID: '$ITEM_ID'"
  ITEM_ID_MAP[$PROJECT_ID]=$ITEM_ID
done

declare -A STATUS_FIELD_ID_MAP
declare -A STATUS_OPTIONS_MAP

echo "4. Find 'Status' field"

for PROJECT_ID in "${!ITEM_ID_MAP[@]}"; do
  FIELDS_JSON=$(gh api graphql -f query='
    query {
      node(id: "'"$PROJECT_ID"'") {
        ... on ProjectV2 {
          fields(first: 20) {
            nodes {
              ... on ProjectV2SingleSelectField {
                id
                name
                options {
                  id
                  name
                }
              }
            }
          }
        }
      }
    }
  ')

  STATUS_FIELD_ENTRY=$(echo "$FIELDS_JSON" | jq '.data.node.fields.nodes[] | select(.name=="Status")')
  STATUS_FIELD_ID=$(echo "$STATUS_FIELD_ENTRY" | jq -r '.id')

  if [ -z "$STATUS_FIELD_ID" ] || [ "$STATUS_FIELD_ID" == "null" ]; then
    echo "Status not found in '$PROJECT_ID'."
    continue
  fi

  echo "'Status' found : ID '$STATUS_FIELD_ID'"

  # Récupérer les options du champ 'Status'
  OPTIONS=$(echo "$STATUS_FIELD_ENTRY" | jq -r '.options[] | [.id, .name] | @tsv')
  echo "'Status' options :"
  echo "$OPTIONS" | awk -F'\t' '{printf "  option : %s | Name : %s\n", $1, $2}'

  STATUS_FIELD_ID_MAP[$PROJECT_ID]=$STATUS_FIELD_ID
  STATUS_OPTIONS_MAP["$PROJECT_ID"]="$OPTIONS"
done

echo "5. Update item"

for PROJECT_ID in "${!ITEM_ID_MAP[@]}"; do
  ITEM_ID=${ITEM_ID_MAP[$PROJECT_ID]}
  STATUS_FIELD_ID=${STATUS_FIELD_ID_MAP[$PROJECT_ID]}

  if [ -z "$STATUS_FIELD_ID" ]; then
    continue
  fi

  OPTIONS="${STATUS_OPTIONS_MAP[$PROJECT_ID]}"
  echo "Select you option (testing) '$PROJECT_ID' :"
  echo "$OPTIONS" | awk -F'\t' '{printf "  option : %s | Nom : %s\n", $1, $2}'

  read -p "Select your option (test) : " NEW_OPTION_ID

  VALID_OPTION=$(echo "$OPTIONS" | awk -F'\t' -v id="$NEW_OPTION_ID" '$1 == id {print $2}')
  if [ -z "$VALID_OPTION" ]; then
    continue
  fi

  echo "Updating ID '$ITEM_ID' with '$STATUS_FIELD_ID' and '$NEW_OPTION_ID' ('$VALID_OPTION')"
  gh project item-edit "$ITEM_ID" --field-id "$STATUS_FIELD_ID" --value "$NEW_OPTION_ID" --project-id "$PROJECT_ID"

  echo "OK UPDATE FOR '$ITEM_ID'"
done
