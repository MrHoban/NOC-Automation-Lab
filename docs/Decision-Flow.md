```md
# Correlation Decision Flow

```mermaid
flowchart TD

    A[Device Alert/Event] --> B{Quarantined?}

    B -- Yes --> C{Online?}
    C -- No --> D[SOC - Critical (P1)]
    C -- Yes --> E[SOC - Review (P2)]

    B -- No --> F{Backup Failed?}
    F -- Yes --> G{Online?}
    G -- No --> H[NOC - Critical Backup Impact (P1)]
    G -- Yes --> I[NOC - Backup Review (P2)]

    F -- No --> J{Disk < 5GB?}
    J -- Yes --> K[NOC - Disk Remediation (P2)]

    J -- No --> L{Offline?}
    L -- Yes --> M[NOC - Investigate Offline (P2)]
    L -- No --> N[Normal]