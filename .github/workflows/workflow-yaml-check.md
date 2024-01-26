# Reusable Workflow for Standardization Validation

## Usage

- **Purpose:** Validate the organization's yaml standards across projects.
- **Steps**
  1. Run yaml lint-test
- **Input:** You can specify specify a custom configuration file path for the
  yaml link check. If you have specific rules or configurations for link
  validation, you can create a configuration file in the project you are
  calling this workflow from and input the path to this workflow. You can
     find the documentation for this file
     [here](https://yamllint.readthedocs.io/en/stable/configuration.html)

## YAML Linting Guidelines for Developers

- The [fnando.linter](https://marketplace.visualstudio.com/items?itemName=fnando.linter) extension for Visual Studio Code provides a flexible linter framework, which can be used for linting YAML files.
