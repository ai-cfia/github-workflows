# Reusable Lint and Test Workflow for Python Projects

## Overview

This GitHub Actions workflow is designed to automate linting and testing for
Python projects. It ensures code quality by using the `ruff` linter and runs
unit tests to verify functionality. Secrets and environment variables needed for
the tests are securely fetched from our Vault server.

## usage

- **Purpose:** Lint and test Python packages.
- **Usage:** Call this workflow in your Python projects.
- **Required Secrets/environment variables for testing:**   This workflow
  requires certain secrets/environment variables that are dynamically fetched
  from our Vault server during the workflow execution. Ensure that these secrets
  are correctly configured in Vault. For updates or modifications to these
  secrets, refer to the Vault server at
  <https://vault.inspection.alpha.canada.ca> by following the instructions in
  our
  [documentation](https://github.com/ai-cfia/howard/blob/main/docs/secrets-management.md).
