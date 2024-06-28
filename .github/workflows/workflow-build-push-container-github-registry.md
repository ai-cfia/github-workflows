# Reusable workflow to build and push docker container to GitHub Container Registry (GHCR)

- **Purpose:** Build and push a docker container to GitHub Container Registry
  (GCR).
- **Usage:** Call this workflow and provide the container-name, tag, and
registry as inputs. The registry should always start with
`ghcr.io/<YOUR-REGISTRY-NAME>` (e.g., ghcr.io/ai-cfia). If you create, push, or
merge a pull request, the workflow will be triggered and will start 2 jobs. The
first job will build and push the new image with 2 tags. The first tag is the
pull request number, and the second tag is the commit that triggered the action.
The second job will remove the previous image based on the previous tag. If no
Dockerfile is found at the root of the repository, the workflow will be
cancelled.
- **Required Secrets:**
  - None
