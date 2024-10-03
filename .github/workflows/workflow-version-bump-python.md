# Reusable version bump check validation workflow for Python projects

- **Purpose:** Validate the version bump in a Python project.
- **Usage:** Call this workflow in your Python projects.

  ```yaml
  lint-test:
    uses:
      ai-cfia/github-workflows/.github/workflows/workflow-version-bump-python.yml@main
    secrets: inherit
    with:
      pyproject-path: 'pyproject.toml'
      package-name: 'my-package'
  ```
