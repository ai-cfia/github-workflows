# Reusable Lint and Test Workflow for Python Projects

- **Purpose:** Lint and test Python packages.
- **Usage:** Call this workflow in your Python projects.
- **Required Secrets:** Simply call the workflow in your project and pass
  the secrets by inheritance.
  ex :

  ```yaml
  lint-test:
    uses:
      ai-cfia/github-workflows/.github/workflows/workflow-lint-test-python.yml@main
    secrets: inherit
  ```
