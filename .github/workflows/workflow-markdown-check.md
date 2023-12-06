## Reusable Workflow for Standardization Validation

   - **Purpose:** Validate the organization's standards across projects.
   - **Steps**
     1. Check for markdown dead links
     2. Run markdown lint-test
   - **Input:** You can specify specify a custom configuration file path for the
     markdown link check. If you have specific rules or configurations for link
     validation, you can create a configuration file in the project you are
     calling this workflow from and input the path to this workflow. You can
     find the documentation for this file
     [here](https://github.com/tcort/markdown-link-check#config-file-format)
