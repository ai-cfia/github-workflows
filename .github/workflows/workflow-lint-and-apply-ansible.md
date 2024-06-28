# Reusable Workflow for Ansible Linting

- **Purpose:** Improve the quality of Ansible projects by implementing a
reusable linting workflow. If the ansible-lint command pass, the workflow will
run an `ansible-playbook` command and apply the specified
`ansible-playbook-file`.
- **Usage:** Integrate this workflow into your Ansible projects for efficient
linting processes.
- **Note:** Provide an ansible-lint configuration file using the
`ansible-lint-config` input variable. Optionally, you can specify Python version
with the `python-version` input. Additionally, you may decrypt ansible variable
and inventory file by passing the name through the `ansible-variable-file` and
`ansible-inventory-file` inputs respectively.
