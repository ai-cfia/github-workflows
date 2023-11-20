## Reusable Build and Deploy to GitHub Pages

   - **Purpose:** Build a Node.js project and deploy the static assets to GitHub Pages.
   - **Usage:** Call this workflow and provide `node-version`, `publish-dir`, `cache-dependency-path`, `working-dir` (optional, default is root), and `publish-branch` (optional, default is root) as inputs.
   - **Required Secrets:**
     - `GITHUB_TOKEN`: This token is automatically generated by GitHub to enable push access to the repository.
   - **Workflow Steps:**
     - **Checkout Repository**: Retrieves the latest code from the specified branch.
     - **Setup Node.js Environment**: Configures the Node.js version and sets up caching for npm dependencies.
     - **Install Dependencies**: Installs the required npm packages.
     - **Build**: Compiles the project into static assets.
     - **Deploy to GitHub Pages**: Publishes the static assets to the specified `publish-branch` on GitHub Pages.