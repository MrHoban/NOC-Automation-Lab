![PowerShell](https://img.shields.io/badge/PowerShell-5.1-blue)
![Automation](https://img.shields.io/badge/Automation-NOC%20POC-green)
![Status](https://img.shields.io/badge/Status-Demo%20Ready-success)

# NOC Automation Lab — SOC/NOC Correlation Engine (POC)

This PowerShell-based proof of concept correlates:

- SentinelOne quarantine state
- NinjaOne RMM health signals
- Acronis backup status

It routes escalation correctly (SOC vs NOC), suppresses unsafe remediation during quarantine, and generates ConnectWise-ready ticket notes.

---

## Business Value

- Reduces alert noise
- Prevents unsafe remediation during active security isolation
- Improves SOC/NOC ownership clarity
- Prepares automation workflows for Rewst integration

---

## Quick Demo (30 seconds)

```powershell
.\run-demo.ps1