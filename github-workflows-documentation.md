### General Documentation for Reusable GitHub Workflows

The provided GitHub workflows are designed to be reusable across the CFIA's open source products, particularly beneficial for open-source applications. These workflows cater to various CI/CD needs, such as building Docker containers, deploying to Google Cloud Run, and linting & testing Node.js and Python products.

#### How to Use These Workflows

1. **Integrate Workflows into Your Repository:**
   - Copy the provided workflow YAML files into the `.github/workflows` directory of your GitHub repository.

2. **Setting Up Secrets:**
   - Navigate to your GitHub repository.
   - Go to "Settings" > "Secrets" > "New repository secret".
   - Add the necessary secrets which are utilized in the workflows. The secrets are sensitive data like API keys and credentials that are used to access various services securely.

#### Workflow Descriptions

1. **Reusable Docker Container Build:**
   - **Purpose:** Build and push a Docker image to the Google Artifact Registry (GAR).
   - **Usage:** Call this workflow and provide the `container-name` and `tag` as inputs.
   - **Required Secrets:**
     - `GCP_CLOUDRUN_REGION`: Your Google Cloud Run region.
     - `AILAB_GAR_JSON_KEY`: JSON key for authenticating with GAR.
     - `AILAB_REGISTRY`: Your GAR registry name.
     - `REACT_APP_BACKEND_URL`: Backend URL for the React app.

2. **Reusable Docker Container Deployment to Google Cloud Run:**
   - **Purpose:** Deploy a Docker container to Google Cloud Run.
   - **Usage:** Call this workflow and provide the `container-name` and `tag` as inputs.
   - **Required Secrets:**
     - `AILAB_GAR_JSON_KEY`: JSON key for authenticating with GAR.
     - `GCP_CLOUDRUN_REGION`: Your Google Cloud Run region.
     - `AILAB_REGISTRY`: Your GAR registry name.

3. **Reusable Lint and Test Workflow for Node (React) Projects:**
   - **Purpose:** Lint and test Node.js (React) projects.
   - **Usage:** Call this workflow in your Node.js projects.
   - **Note:** Ensure that your project has the necessary scripts for linting and testing in the `package.json` file.

4. **Reusable Lint and Test Workflow for Python Projects::**
   - **Purpose:** Lint and test Python packages.
   - **Usage:** Call this workflow in your Python projects.
   - **Required Secrets:**
     - `OPENAI_API_KEY`: API key for OpenAI (if utilized in tests).
     - `LOUIS_DSN` and `LOUIS_SCHEMA`: Database credentials (if utilized in tests).
     - `AZURE_OPENAI_SERVICE`: Azure OpenAI service credentials (if utilized).

5. **Reusable Workflow for Standardization Validation**
   - **Purpose:** Validate the organization's standards across projects.
   - **Usage:** Call this workflow while making sure the necessary secrets are inherited for successful execution.


#### Example of Calling a Workflow

To use these workflows in your project, you can call them using `workflow_dispatch`. Here’s a basic example of how to call a workflow:

```yaml
name: My Workflow

on:
  push:
    branches: [ main ]

jobs:
  my_job:
    uses: [Owner/Repo/.github/workflows/WORKFLOW_FILE_NAME.yaml@branch]
    secrets: inherit
```

You can find a working example on a deployment to GCP [here](https://github.com/ai-cfia/fastapi-example/blob/main/.github/workflows/gcp-deployment.yml).