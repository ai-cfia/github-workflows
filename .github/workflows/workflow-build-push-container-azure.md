## Reusable workflow to build and push docker container to Azure

   - **Purpose:** Build and push a docker container to Azure Container Registry (ACR).
   - **Usage:** Call this workflow and provide the `container-name` and `tag` as inputs.
   - **Required Secrets:**
     - `ACR_REGISTRY_NAME`: The Azure container registry name.
     - `ACR_USERNAME`: The Azure container registry username.
     - `ACR_PASSWORD`: The Azure container registry password.