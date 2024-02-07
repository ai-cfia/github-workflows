# Reusable Workflow for Terraform Conformance to AI Lab Standards

## Overview

This workflow ensures that Terraform configurations align with the AI Lab's
standards for infrastructure as code. It is designed to automate the enforcement
of code quality and organizational best practices for Terraform files across
various projects.

## Usage

- **Purpose:** Automatically validate and enforce coding standards for Terraform
  configurations within the organization. It triggers on **workflow calls** to
  repositories and **pushes** to this repository, performing checks to ensure
  Terraform files comply with predefined standards.
- **Steps:**
  - **Terraform Format Check:** Verifies that Terraform files are formatted
    according to Terraform's conventions using `terraform fmt`.
  - **TFLint Check:** Runs TFLint to lint Terraform files, identifying potential
    issues and deviations from best practices.
- **Input:** Optionally specify a custom configuration file path for TFLint to
  use a specific set of rules. 

## Terraform Linting Guidelines for Developers

- Developers are encouraged to use the [Terraform
  linters/TFLint](https://github.com/terraform-linters/tflint) tool for locally
  linting their Terraform files.

## Custom Configuration

If your project requires specific linting rules beyond the AI Lab's standard
set, you can create a `.tflint.hcl` file in your project's root directory.
Specify the path to this file when triggering the workflow to apply your custom
rules. The format and options for this configuration file are documented in the
[TFLint Configuration File Format]
(https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/config.md).
