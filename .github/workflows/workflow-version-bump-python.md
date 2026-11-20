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

## Compare changed projects with the pull request base

Call the monorepo workflow from a `pull_request` workflow and set
`projects-root` to the directory containing the projects.

```yaml
python-version-check:
  uses: ai-cfia/github-workflows/.github/workflows/workflow-version-bump-python-mono.yml@main
  with:
    projects-root: mlops
    shared-project-directories: |
      mlops/training
```

Every changed project with a `pyproject.toml` under `projects-root` must
increase its Semantic Version compared with the PR base. New projects need
a valid `[project].version`. A change inside a project applies to the nearest
project directory. Shared changes in a listed directory apply to every
project beneath it. List one repository-relative directory per line.

Omit `projects-root` to use the repository-tag comparison with the
`pyproject-path`, `package-name`, and `working-directory` inputs.
