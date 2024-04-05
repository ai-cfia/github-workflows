# Reusable Workflow for Standardization Validation

## Purpose

 Validate the organization's standards across projects.

## Steps

  1. Check for markdown dead links
  2. Run markdown lint-test

## Input

Markdown Link Config File Path (md-link-config-file-path): Optional. Specifies
the path to a custom configuration file for the markdown link validation. If
your project has specific rules or configurations for link validation
([example](https://github.com/ai-cfia/finesse-frontend/blob/main/.mlc_config.json)),
create a configuration file and input its path when calling this workflow. You
can refer to the documentation for the config file format
[here](https://github.com/tcort/markdown-link-check?tab=readme-ov-file#config-file-format).

Markdown Lint Config File Path (md-lint-config-file-path): Optional. Allows
specifying a path to a custom lint configuration file for markdown files. If not
provided, the workflow will use the default configuration file from the [current
repository](../../.markdownlint.json). You can refer to the documentation for
the config file format
[here](https://github.com/DavidAnson/markdownlint/).
