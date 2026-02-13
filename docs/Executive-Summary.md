# Executive Summary — SOC/NOC Correlation POC

## Problem
When endpoints are quarantined by EDR, they often appear offline in RMM and generate redundant alerts. This creates duplicate tickets, confusion over ownership, and risk of unsafe remediation during investigation.

## Solution
A correlation engine that:
- Detects quarantine state
- Evaluates RMM health (online/disk)
- Checks backup status
- Routes escalation properly
- Suppresses remediation when quarantined

## Result
Clear ownership, reduced noise, safer operations, automation-ready outputs.