# Reusable Lint and Test Workflow for Python Projects

- **Purpose:** Lint, test and run a coverage sequence on a Python packages.
- **Usage:** Call this workflow in your Python projects.
- **Required Secrets:** Simply call the workflow in your project and pass
  the secrets by inheritance. To add, remove or update secrets, please do so
  in your repository's secrets settings.
  ex :

  ```yaml
  lint-test:
    uses:
      ai-cfia/github-workflows/.github/workflows/workflow-lint-test-python.yml@main
    secrets: inherit
  ```
