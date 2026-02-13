# Proposed SOC / NOC Correlation Workflow
## Preventing Unsafe Remediation & Reducing Alert Noise

1. Problem Statement

Currently, monitoring alerts (offline devices, disk alerts, performance alerts) operate independently of EDR quarantine state.
When a device is quarantined by the SOC (e.g., SentinelOne):
The device may appear offline in RMM
NOC may attempt auto-remediation
Disk or service remediation may run during active investigation
Duplicate or conflicting tickets may be generated

This creates:

Alert noise
Operational confusion between SOC and NOC
Risk of interfering with active security investigations

2. Proposed Solution

Implement a correlation layer that evaluates:
EDR Quarantine State
RMM Online Status
Device Health Metrics (Disk, CPU, etc.)

Before determining escalation or remediation actions.

The system should:

Suppress auto-remediation if device is quarantined
Escalate critical cases directly to SOC
Prevent duplicate offline tickets during quarantine
Maintain clear ownership boundaries

3. Correlation Logic Overview
Rule A — Quarantined + Offline

Escalation: SOC – Critical
Remediation: Disabled
Rationale: Device isolation may block RMM connectivity.

Rule B — Quarantined + Online

Escalation: SOC – Review
Remediation: Disabled
Rationale: Device still accessible, but under security investigation.

Rule C — Offline (No Quarantine)

Escalation: NOC – Investigate Offline
Remediation: Allowed
Follow standard offline workflow.
Rule D — Disk Critical (No Quarantine)
Escalation: NOC – Disk Remediation
Remediation: Allowed

4. Operational Improvements

Implementing correlation would:
Reduce unnecessary offline tickets during quarantine
Prevent accidental service restarts during investigations
Improve SOC/NOC visibility alignment
Reduce mean time to correct escalation
Enable future automation via Rewst

5. Automation Integration (Future-State)

Potential Rewst Workflow:
Trigger: EDR quarantine event OR periodic status poll
Pull RMM device state
Apply correlation rules
Generate structured ConnectWise ticket
Route ticket to SOC or NOC board automatically
Add tag: Quarantine-Suppressed if remediation disabled

6. Proof of Concept

A PowerShell-based correlation engine has been developed to simulate:
Multi-device evaluation
Severity scoring
Escalation mapping
Remediation suppression logic
Structured JSON output for automation platforms
This model can be adapted to live API integrations.

7. Business Value

Reduces alert fatigue
Improves cross-team coordination
Prevents operational conflicts
Supports automation-first NOC strategy
Aligns with Rewst implementation roadmap