# Workflow Detect Secrets Leaks

- **Purpose:** Automate the detection of secret leaks in the code repository
by integrating tools like `git-secrets` and `Trufflehog`. This workflow scans
the repository for sensitive information and ensures compliance with security
best practices.

- **Usage:** This workflow is triggered on push events to any branch and can
also be called by other workflows using `workflow_call`. It runs secret
scanning tools to identify and report potential leaks.

- **Required Secrets:**
  - `VAULT_TOKEN`: The GitHub secret token used for authenticating with Vault
  to retrieve additional secrets.

## Workflow Details

The workflow operates in two primary stages:

1. **Authentication and Setup:**
   - The code repository is checked out using the `actions/checkout` action.
   - The workflow authenticates with HashiCorp Vault using GitHub OIDC to
   securely retrieve necessary secrets. These secrets are added to
   `git-secrets` for scanning purposes.
   - The `git-secrets` tool is installed and configured to scan the repository
   for any sensitive information that matches the retrieved secrets.

2. **Scanning and Reporting:**
   - The `git-secrets` tool scans the entire repository to detect potential
   secret leaks.
   - After the scan, any temporary patterns added to `git-secrets` are removed
   to clean up the configuration.
   - The `Trufflehog` tool performs a comprehensive scan to identify both
   verified and unknown secrets, providing detailed results. The Trufflehog
   configuration is created dynamically within the workflow to include a custom
   regex for detecting secrets with the `ailab-` prefix.
