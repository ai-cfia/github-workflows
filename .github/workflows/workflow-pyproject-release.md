# Reusable Workflow for Python Package Release

## Purpose

Automate the release process for Python packages, using the version from
`pyproject.toml` to create a GitHub release.

## Steps

  1. Checkout the repository code
  2. Parse the version from `pyproject.toml`
  3. Create a new version tag
  4. Push the tag to the repository
  5. Automatically generate release notes and publish a new GitHub release

## Input

This workflow automatically uses the repository name and parses the version from
the `pyproject.toml` file. No additional input is required when calling the
workflow.
