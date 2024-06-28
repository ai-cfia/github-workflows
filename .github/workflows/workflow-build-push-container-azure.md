# Reusable workflow to build and push docker container to Azure Container Registry (ACR)

- **Purpose:** Build and push a docker container to Azure Container Registry
  (ACR).
- **Usage:** Call this workflow and provide the `container-name` and `tag` as
  inputs.
- **Required Secrets:**
  - `ACR_SERVER`: The Azure container registry link.
  - `ACR_USERNAME`: The Azure container registry username.
  > Note: The username must be all lowercase letters.
  - `ACR_PASSWORD`: The Azure container registry password.
