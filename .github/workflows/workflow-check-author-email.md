# GitHub Actions Workflow: Verify Committer Email for `.gc.ca` Domain

- **Purpose:** This GitHub Actions workflow ensures that commits pushed
to the repository or part of a pull request are signed with an email
address ending in `.gc.ca`. This helps verify that contributors use a
valid government email domain when committing changes.

- **Usage:** Add this workflow to your repository to enforce email validation
on all pushes and pull requests targeting the `main` branch.

- **Required Secrets:**
  - `GITHUB_TOKEN`: Token for authentication with GitHub.

## Workflow Steps

1. **Checkout the Repository:**
   The workflow uses the `actions/checkout@v3` action to clone the repository
   into the runner's workspace.

2. **Validate Committer Email:**
   The workflow leverages the `dguo/check-author-and-committer-action@v1`
   action to check that the committer's email matches the specified
   domain pattern (`@gc.ca`).

3. **Custom Error Messaging:**
   If any commit does not meet the email criteria, a custom error message
   is displayed, guiding contributors to configure their email
   address correctly.
