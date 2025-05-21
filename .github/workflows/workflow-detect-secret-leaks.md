# Workflow Detect Secrets Leaks

- **Purpose:** Automate the detection of secret leaks in the code repository
by integrating tools like `Trufflehog`. This workflow scans
the repository for sensitive information and ensures compliance with security
best practices.

- **Usage:** This workflow is triggered on push events to any branch and can
also be called by other workflows using `workflow_call`. It runs secret
scanning tools to identify and report potential leaks.

## Workflow Details

1. **Scanning and Reporting:**
   - The `Trufflehog` tool performs a comprehensive scan to identify both
   verified and unknown secrets, providing detailed results. The Trufflehog
   configuration is created dynamically within the workflow to include a custom
   regex for detecting secrets with the prefix mentionned in the
   `trufflehog_config.yaml`.
