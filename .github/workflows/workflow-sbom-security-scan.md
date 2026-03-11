# Reusable workflow for SBOM security scanning

- **Purpose:** Scan an existing CycloneDX SBOM (`sbom.json`) for known
  vulnerabilities and upload SARIF results to GitHub Code Scanning.
- **Usage:** Call this workflow with `workflow_call` or run it manually with
  `workflow_dispatch`. The workflow checks out the repository, verifies that an
  SBOM file exists, runs an Anchore/Grype SBOM scan, patches SARIF artifact
  locations for GitHub compatibility, and uploads the SARIF report.
- **Inputs:**
  - `working-directory` (optional, default `.`): Directory that contains
    `sbom.json`.
- **Outputs:**
  - None
- **Permissions:**
  - `security-events: write`
- **Required Secrets:**
  - None

## Notes

- If `${working-directory}/sbom.json` is missing, the workflow logs a skip
  message and exits successfully (`exit 0`) so downstream pipelines do not fail
  because of a missing SBOM artifact.
- Grype SBOM SARIF output may not include file locations. This workflow uses
  `jq` to add `sbom.json` as the SARIF artifact location so GitHub Code
  Scanning accepts the upload.
