# Reusable workflow to generate frontend SBOM (Node/npm)

- **Purpose:** Generate a CycloneDX SBOM (`sbom.json`) for a Node/npm frontend
  project, then expose the SBOM as a base64-encoded reusable workflow output.
- **Usage:** Call this workflow with `workflow_call`. It checks out the
  repository, detects Node.js/npm versions from `package.json` engines (with
  defaults), performs a clean dependency install in Docker, generates
  `sbom.json` with `cyclonedx-npm`, and exports it as the `sbom` output.
- **Inputs:**
  - `working-directory` (optional, default `./frontend`): Frontend directory
    containing `package.json`.
  - `cyclonedx-spec-version` (optional, default `1.6`): CycloneDX specification
    version passed to `cyclonedx-npm`.
- **Outputs:**
  - `sbom`: Base64-encoded contents of the generated `sbom.json` file.
- **Permissions:**
  - `contents: read`
- **Required Secrets:**
  - None
