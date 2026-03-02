# Reusable workflow to generate backend SBOM (Python/uv)

- **Purpose:** Generate a CycloneDX SBOM (`sbom.json`) for a Python backend
  project using `uv`, then expose the SBOM as a base64-encoded reusable
  workflow output.
- **Usage:** Call this workflow with `workflow_call`. It checks out the
  repository, runs SBOM generation in an Ubuntu 24.04 Docker container, and
  exports the generated `sbom.json` as the `sbom` output.
- **Inputs:**
  - `working-directory` (optional, default `./backend`): Backend directory
    containing `pyproject.toml`.
  - `cyclonedx-spec-version` (optional, default `1.6`): CycloneDX specification
    version passed to `cyclonedx-py`.
- **Outputs:**
  - `sbom`: Base64-encoded contents of the generated `sbom.json` file.
- **Permissions:**
  - `contents: read`
- **Required Secrets:**
  - None
