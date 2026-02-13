# SOC / NOC Correlation POC — Architecture Overview

```mermaid
flowchart LR
    A[SentinelOne EDR] -->|Quarantine State| C[Correlation Engine (PowerShell)]
    B[NinjaOne RMM] -->|Online / Disk / Metrics| C
    D[Acronis Backup] -->|Backup Status| C

    C --> E[Escalation Logic]
    E --> F[SOC Board]
    E --> G[NOC Board]

    C --> H[JSON Artifact]
    C --> I[ConnectWise Internal Note]
