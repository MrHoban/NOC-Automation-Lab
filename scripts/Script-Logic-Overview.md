# SYNOPSIS
  SOC / RMM Correlation Script (PowerShell 5.1 compatible)

# DESCRIPTION
  Correlates EDR quarantine state with RMM "online" state and basic health signals (disk).
  Supports TWO input schemas:
   1) Legacy flat schema:
        DeviceName, Client, IsOnline, IsQuarantined, DiskFreeGB, CPUPercent, (optional) QuarantineReason, QuarantineSinceUtc
   2) v2 schema:
        DeviceName, Client, Site, DeviceType, LastSeenUtc, OsVersion, IPAddress, LoggedOnUser,
        EDR { IsQuarantined, QuarantineReason, QuarantineSinceUtc },
        Metrics { DiskFreeGB, CPUPercent }

  Outputs:
    - Console summary table
    - Console ticket-ready notes for non-OK devices
    - JSON artifact to ..\examples\correlation-output.json (default)
    - Optional per-device ticket note files in ..\examples\ticket-notes\

# EXITCODES
  0 = All OK
  1 = Warnings / needs attention
  2 = Critical (SOC-critical cases)
