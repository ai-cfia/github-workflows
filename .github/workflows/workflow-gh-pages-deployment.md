# Reusable Build and Deploy to GitHub Pages

- **Purpose:** Build a Node.js project and deploy the static assets to GitHub
  Pages.
- **Usage:** Call this workflow and provide `node-version`, `publish-dir`,
  `cache-dependency-path`, `working-dir` (optional, default is root), and
  `publish-branch` (optional, default is root) as inputs.
- **Required Secrets:**
  - `GITHUB_TOKEN`: This token is automatically generated by GitHub to enable
    push access to the repository.
