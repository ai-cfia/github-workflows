# K6 load test

- **Purpose:**: Run load tests using k6 as part of a reusable GitHub Actions
workflow. Supports Prometheus Remote Write output for performance monitoring
with Grafana Mimir.

- **Usage:** This workflow is triggered via `workflow_call`. It accepts a
`paths` input which specifies the path(s) to the k6 script(s) to execute.
The test runs locally and sends metrics to a Prometheus endpoint.

- **Required Secrets:**
  - None by default, but the following environment variable must be available:
    - `K6_PROMETHEUS_RW_SERVER_URL:` The endpoint URL of the Prometheus
    remote_write-compatible server.
