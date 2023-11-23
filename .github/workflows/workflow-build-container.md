## Reusable Docker Container Build

   - **Purpose:** Build and push a Docker image to the Google Artifact Registry (GAR).
   - **Usage:** Call this workflow and provide the `container-name` and `tag` as inputs.
   - **Required Secrets:**
     - `GCP_CLOUDRUN_REGION`: Your Google Cloud Run region.
     - `AILAB_GAR_JSON_KEY`: JSON key for authenticating with GAR.
     - `AILAB_REGISTRY`: Your GAR registry name.
     - `REACT_APP_BACKEND_URL`: Backend URL for the React app.
