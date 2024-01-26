# Reusable Docker Container Deployment to Google Cloud Run

- **Purpose:** Deploy a Docker container to Google Cloud Run.
- **Usage:** Call this workflow and provide the `container-name` and `tag` as inputs.
- **Required Secrets:**
  - `AILAB_GAR_JSON_KEY`: JSON key for authenticating with GAR.
  - `GCP_CLOUDRUN_REGION`: Your Google Cloud Run region.
  - `AILAB_REGISTRY`: Your GAR registry name.