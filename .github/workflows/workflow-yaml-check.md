# Reusable Workflow for Standardization Validation

## Overview

This workflow is designed to maintain and enforce coding standards within YAML
files across multiple projects within the organization. It ensures that any
changes made to YAML files are consistent with the predefined standards set by
the organization.

## Usage

- **Purpose:** Validate the organization's yaml standards across projects. It is
  triggered by **pull requests** to ensure that any new or altered YAML files
  comply with these standards.
- **Steps**
  - YAML Lint Test: The workflow runs a linting test on the changed YAML files
    using the given configuration if specified.
- **Input:** You can specify specify a custom configuration file path for the
  yaml link check. If you have specific rules or configurations for link
  validation, you can create a configuration file in the project you are calling
  this workflow from and input the path to this workflow. If you omit to specify
  a file path, the default config file from current repository will be used. You
     can find the documentation for this file
     [here](https://yamllint.readthedocs.io/en/stable/configuration.html)

## YAML Linting Guidelines for Developers

- The
  [fnando.linter](https://marketplace.visualstudio.com/items?itemName=fnando.linter)
  extension for Visual Studio Code provides a flexible linter framework, which
  can be used for linting YAML files.
