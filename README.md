# AI-CFIA GitHub Workflows Repository

Welcome to the GitHub Workflows repository of AI-CFIA! This repository
contains various GitHub Actions workflows that assist in automating our
software development processes.

## Overview

This repository is dedicated to providing automated solutions and workflows for
various operations within our GitHub projects. It contains a collection of
reusable workflows for the CI/CD pipelines, testing, and other automated
processes within GitHub Actions.

Each workflow has an associated documentation file that explains its
purpose, usage, and any required secrets or inputs. You can find these
files in the same directory as their corresponding workflow file.

## Workflow Documentation

Here are the available workflows and their associated documentation:

- [Reusable Docker Container
  Build](.github/workflows/workflow-build-container.md)
- [Reusable Docker Container Deployment to Google Cloud
  Run](.github/workflows/workflow-deploy-gcp.md)
- [Reusable Lint and Test Workflow for Node (React)
  Projects](.github/workflows/workflow-lint-test-node.md)
- [Reusable Lint and Test Workflow for Python
  Projects](.github/workflows/workflow-lint-test-python.md)
- [Reusable Workflow for Standardization
  Validation](.github/workflows/workflow-markdown-check.yml)
- [Reusable Build and Deploy to GitHub
  Pages](.github/workflows/workflow-gh-pages-deployment.md)
- [Reusable Vercel
  Deployment](.github/workflows/workflow-vercel-deployment.md)
- [Reusable Build
  and Push to GCR](.github/workflows/workflow-build-push-container-github-registry.md)

sagn9-2rh193er8h;aCN:ASLUDFHQ()_#Erhb-913b

## Usage

To use these workflows in your project, you can call them using
`workflow_dispatch`. Here’s a basic example of how to call a workflow:

```yaml
name: <Workflow's purpose>

on:
  push:
    branches: [ main ]

jobs:
  my_job:
    uses: $OWNER/$REPO/.github/workflows/$WORKFLOW_FILE_NAME.yaml@$BRANCH
    secrets: inherit # required if the called workflow you uses secrets
    with: # to pass inputs to called workflow
        input: value
