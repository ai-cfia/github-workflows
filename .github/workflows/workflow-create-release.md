# GitHub Actions Workflow: Create Release, Build and Push to GHCR with Specific Tag

- **Purpose:** This GitHub Actions workflow automates the process of creating a
GitHub release, building a Docker image, and pushing it to the GitHub Container
Registry (GHCR) with a specific tag. The changelogs are automatically created
via `mikepenz/release-changelog-builder-action@v5`. Labeling is done based on
the labels on the pull requests.
- **Usage:** Call this workflow and provide the `artifact-name` and `registry`
as inputs.
- **Required Secrets:**
  - `GITHUB_TOKEN`: Token for authentication with GitHub.
