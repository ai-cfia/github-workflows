# Reusable Workflow for SH Script Conformance

## Overview

This workflow ensures that Shell scripts adhere to AI Lab's coding standards.
It's designed to automatically check the conformance of SH scripts to maintain
consistency and quality in the codebase.

## Usage

- **Purpose:** Automatically validate SH scripts against AI Lab's standards. It
  triggers on workflow calls or push events, reviewing the scripts for
  compliance.
- **Steps**
  - Checkout Code: Fetches the latest code from the repository to be checked.
  - Run ShellCheck: Executes ShellCheck, a tool for linting and static analysis
    of SH scripts, to ensure they meet the predefined standards.

## SH Scripting Guidelines for Developers

- It's recommended to integrate
  [ShellCheck](https://github.com/koalaman/shellcheck) in your local development
  environment to catch issues early. ShellCheck provides detailed feedback for
  improving your SH scripts, adhering to best practices and coding standards.
