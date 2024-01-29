# Reusable Docker Container Deployment to Azure

- **Purpose:** Deploy a Docker container to Azure App Service.
- **Usage:** Call this workflow and provide the `container-name` and `tag` as inputs.
- **Required Secrets:**
  - `AZURE_CREDENTIALS`: JSON object containing Azure service principal credentials for authentication.
  - `ACR_SERVER`: DNS to the Azure Container Registry where the Docker image is stored ex.: 'aciacfiaacr.azurecr.io'.
  - `ACR_USERNAME`: Username for logging into Azure Container Registry.
  - `ACR_PASSWORD`: Password for logging into Azure Container Registry.
  - `AZURE_PUBLISH_PROFILE`: Publish profile for the Azure App Service. This contains deployment and configuration settings.
