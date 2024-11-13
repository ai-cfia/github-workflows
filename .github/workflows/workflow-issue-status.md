# Workflow issue status

- **Purpose:**: Automate the process of updating the status of issues and pull
requests within GitHub projects based on specific events such as issue
creation, pull request opening, synchronizing, and more.

- **Usage:** This workflow is triggered by issues and pull_request events.
It updates the issue's project status to "Todo", "In Progress", "In Review",
"Done", or "Won't do" based on the event type and action.

- **Required Secrets:**
  - `GH_WORKFLOW_APP_ID:` The ID of the GitHub App used for generating the
  token.
  - `GH_WORKFLOW_APP_PEM:` The private key of the GitHub App used to
  authenticate and generate the token.
