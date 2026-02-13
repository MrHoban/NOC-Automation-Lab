# SOC Quarantine Workflow (NOC Correlation + Escalation)

## Purpose
Provide a standardized NOC Tier 2 response when an endpoint is placed in **EDR quarantine** (e.g., SentinelOne). This workflow ensures:
- visibility across SOC + NOC
- suppression of unsafe auto-remediation actions
- consistent escalation + documentation

## Scope
Applies to endpoints/servers monitored by RMM where quarantine state may impact:
- connectivity (device appears offline)
- remote remediation capability
- service availability

## Definitions
- **Quarantined**: EDR has isolated the device or restricted network access.
- **Offline (RMM)**: device not checking in / agent unreachable.

## Correlation Rules (Decision Logic)
### Rule A — Quarantined + Offline (Critical)
**Condition**
- IsQuarantined = true
- IsOnline = false

**Action**
- Treat as **SOC Critical**
- Do **not** perform auto-remediation actions (service restarts, cleanup, reboots) unless directed by SOC.
- Create/Update ticket with correlation summary and notify SOC.

**Rationale**
Quarantine may intentionally block network access and remote tools; remediation could disrupt investigation.

---

### Rule B — Quarantined + Online (SOC Review)
**Condition**
- IsQuarantined = true
- IsOnline = true

**Action**
- Assign/escalate to **SOC Review**
- NOC may collect non-invasive context only (uptime, basic resource usage) if allowed.
- Avoid changes unless coordinated with SOC.

---

### Rule C — Offline Only (NOC Investigate)
**Condition**
- IsQuarantined = false
- IsOnline = false

**Action**
- Follow standard NOC offline-agent workflow:
  - connectivity checks (DNS/gateway)
  - agent/service checks
  - safe reboot guidance if permitted
- Escalate to NOC Engineer if unresolved.

---

### Rule D — Disk Critical (NOC Remediation)
**Condition**
- IsQuarantined = false
- DiskFreeGB < 5

**Action**
- Perform standard disk remediation SOP (safe cleanup + evidence)
- If disk remains low: escalate for disk expansion or storage redesign.

> Note: Disk remediation is suppressed when quarantined unless SOC approves.

## Required Ticket Documentation (ConnectWise-ready)
Include the following fields in every quarantine-related ticket:
- Device name / Client / Site
- Quarantine state (Yes/No)
- RMM online state (Online/Offline)
- Correlated symptoms (disk, CPU, agent status)
- Actions taken (or explicitly “No remediation performed due to quarantine”)
- Escalation target (SOC Review / SOC Critical / NOC)
- Evidence (script JSON output, logs, screenshots)

## Example Ticket Note (Template)
Alert: EDR Quarantine Correlation  
Device: <device> | Client: <client>  
Status: Quarantined | RMM: Offline/Online  
Escalation: SOC - Critical/Review  
Notes:
- <correlated finding>
Action:
- No remediation performed due to quarantine state. Notified SOC for ownership.
Evidence:
- Attached correlation-output.json (timestamped)

## Future Automation (Rewst Integration Concept)
Trigger:
- SentinelOne quarantine event OR periodic quarantine status poll

Actions:
1. Pull device metadata (client/site/user)
2. Pull RMM check-in state + last seen
3. Apply correlation rules (A–D)
4. Create/update ConnectWise ticket with structured summary
5. Notify SOC channel on Critical cases
