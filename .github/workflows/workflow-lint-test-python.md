# Reusable Lint and Test Workflow for Python Projects

- **Purpose:** Lint and test Python packages.
- **Usage:** Call this workflow in your Python projects.
- **Required Secrets:**
  - `OPENAI_API_KEY`: API key for OpenAI (if utilized in tests).
  - `LOUIS_DSN` and `LOUIS_SCHEMA`: Database credentials (if utilized in tests).
  - `AZURE_OPENAI_SERVICE`: Azure OpenAI service credentials (if utilized).
