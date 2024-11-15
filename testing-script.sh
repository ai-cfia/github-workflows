declare -A PROJECT_NUMBER_ID_MAP ITEM_ID_MAP STATUS_FIELD_ID_MAP STATUS_OPTIONS_MAP
echo "1. Project associated with this issue number #$ISSUE_NUMBER"

ISSUE_NUMBER=160
OWNER=ai-cfia

PROJECT_ITEMS_JSON=$(gh issue view $ISSUE_NUMBER --json projectItems)
PROJECT_TITLES=$(echo "$PROJECT_ITEMS_JSON" | jq -r '.projectItems[].title')
echo "$PROJECT_TITLES"
echo "2. Project information"
PROJECT_LIST=$(gh project list --owner $OWNER)
while read -r TITLE; do
  PROJECT_LINE=$(echo "$PROJECT_LIST" | grep -F "$TITLE")
  if [ -z "$PROJECT_LINE" ]; then
    echo "Project '$TITLE' not found."
    continue
  fi
  PROJECT_NUMBER=$(echo "$PROJECT_LINE" | awk '{print $1}')
  PROJECT_ID=$(echo "$PROJECT_LINE" | awk '{print $NF}')
  echo "Project '$TITLE' found :"
  echo "  # : $PROJECT_NUMBER"
  echo "  ID     : $PROJECT_ID"
  PROJECT_NUMBER_ID_MAP[$PROJECT_NUMBER]=$PROJECT_ID
done <<< "$PROJECT_TITLES"
echo "3. Item id associated to each project for a specific issue"
for PROJECT_NUMBER in "${!PROJECT_NUMBER_ID_MAP[@]}"; do
  PROJECT_ID=${PROJECT_NUMBER_ID_MAP[$PROJECT_NUMBER]}
  echo "Searching #$ISSUE_NUMBER in '$PROJECT_NUMBER'"
  ITEMS_JSON=$(gh project item-list "$PROJECT_NUMBER" --limit 2000 --owner "$OWNER" --format json)
  ITEM_ENTRY=$(echo "$ITEMS_JSON" | jq -r --argjson ISSUE_NUMBER "$ISSUE_NUMBER" '.items[] | select(.content.number == $ISSUE_NUMBER)')
  ITEM_ID=$(echo "$ITEM_ENTRY" | jq -r '.id')
  if [ -z "$ITEM_ID" ]; then
    echo "Issue #$ISSUE_NUMBER not found in '$PROJECT_NUMBER'."
    continue
  fi
  echo "Item found #$ISSUE_NUMBER in '$PROJECT_NUMBER' with ID: '$ITEM_ID'"
  ITEM_ID_MAP[$PROJECT_ID]=$ITEM_ID
  echo "ITEM_ID_$PROJECT_ID=$ITEM_ID" >> $GITHUB_ENV
done
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
  OPTIONS=$(echo "$STATUS_FIELD_ENTRY" | jq -r '.options[] | [.id, .name] | @tsv')
  echo "'Status' options :"
  echo "$OPTIONS" | awk -F'\t' '{printf "  option : %s | Name : %s\n", $1, $2}'
  STATUS_FIELD_ID_MAP[$PROJECT_ID]=$STATUS_FIELD_ID
  STATUS_OPTIONS_MAP["$PROJECT_ID"]="$OPTIONS"
  echo "STATUS_FIELD_ID_$PROJECT_ID=$STATUS_FIELD_ID" >> $GITHUB_ENV
  echo "STATUS_OPTIONS_$PROJECT_ID=\"$OPTIONS\"" >> $GITHUB_ENV
done

for PROJECT_ID_KEY in $(compgen -A variable | grep '^ITEM_ID_'); do
            ITEM_ID="${!PROJECT_ID_KEY}"
            BASE_PROJECT_ID="${PROJECT_ID_KEY#ITEM_ID_}"
            eval "STATUS_FIELD_ID=\$STATUS_FIELD_ID_$BASE_PROJECT_ID"
            if [ -z "$STATUS_FIELD_ID" ]; then
              echo "STATUS_FIELD_ID for project $BASE_PROJECT_ID not found, skipping..."
              continue
            fi
            eval "OPTIONS=\"\${STATUS_OPTIONS_$BASE_PROJECT_ID}\""

            TARGET_STATUS_NAME="Todo"

            TARGET_STATUS_NAME_LOWER=$(echo "$TARGET_STATUS_NAME" | tr '[:upper:]' '[:lower:]')

            NEW_OPTION_ID=""
            while IFS=$'\t' read -r option_id option_name; do
              option_name_lower=$(echo "$option_name" | tr '[:upper:]' '[:lower:]')
              if [ "$option_name_lower" == "$TARGET_STATUS_NAME_LOWER" ]; then
                NEW_OPTION_ID="$option_id"
                break
              fi
            done <<< "$OPTIONS"

            if [ -z "$NEW_OPTION_ID" ]; then
              echo "Could not find status '$TARGET_STATUS_NAME'. Using default ID."
              NEW_OPTION_ID="47fc9ee4"
            else
              echo "Found status '$TARGET_STATUS_NAME' with ID: $NEW_OPTION_ID"
            fi

  gh project item-edit --id "$ITEM_ID" --project-id "$BASE_PROJECT_ID" --field-id "$STATUS_FIELD_ID" --single-select-option-id "$NEW_OPTION_ID"
  echo "UPDATED_OPTION_ID_$BASE_PROJECT_ID=$NEW_OPTION_ID" >> $GITHUB_ENV
done
