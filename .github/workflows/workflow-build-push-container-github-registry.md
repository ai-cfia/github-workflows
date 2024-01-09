## Reusable workflow to build and push docker container to GitHub Container Registry (GCR)

   - **Purpose:** Build and push a docker container to GitHub Container Registry (GCR).
   - **Usage:** Call this workflow and provide the `container-name`, `tag` and `registry` as inputs. The `registry` should always start with `ghcr.io/<YOUR-REGISTRY-NAME>`
   - **Required Secrets:**
     - None