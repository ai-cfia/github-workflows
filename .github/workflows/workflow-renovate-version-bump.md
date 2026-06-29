# Reusable Workflow: Renovate Version Bump

- **Purpose:** Automatically bump the version of a frontend (npm) or backend (Python/uv) package when Renovate bot opens a dependency update PR.
- **Usage:** Call this workflow via `workflow_call` on pull requests. It checks whether the PR was opened by `renovate[bot]`, delegates to a version-check sub-workflow, and commits a patch bump if the version is stale.
- **Inputs:**
  - `working-directory` (required, default `.`): Path to the package root. Must contain `frontend` or `backend` to route to the correct job.
  - `package-name` (required): Name of the package being updated, forwarded to the version-check sub-workflows.
- **Outputs:**
  - None
- **Permissions:**
  - `actions: write`, `contents: write`, `pull-requests: read`
- **Required Secrets:**
  - None (backend job inherits caller secrets via `secrets: inherit`)

## Notes

- Frontend bumps are idempotent: the workflow scans git tags matching `<working-directory> -v*` to find the latest released version and skips the bump if `package.json` is already ahead.
- Backend bumps use `uv version --bump patch` against `pyproject.toml` and regenerate `uv.lock`.
- Concurrency is scoped per PR number, cancelling in-progress runs on rapid Renovate updates.
