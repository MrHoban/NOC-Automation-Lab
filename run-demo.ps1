$scriptPath    = Join-Path $PSScriptRoot "scripts\SOC-Correlation.ps1"
$inputFilePath = Join-Path $PSScriptRoot "samples\device-status-multiple.v3.json"

if (-not (Test-Path $scriptPath)) { throw "Script not found: $scriptPath" }
if (-not (Test-Path $inputFilePath)) { throw "Sample input not found: $inputFilePath" }

& $scriptPath -InputFile $inputFilePath -OfflineThresholdMinutes 720 -WriteTicketFiles

Write-Host ""
Write-Host "Artifacts generated:"
Write-Host "- examples\correlation-output.json"
Write-Host "- examples\ticket-notes\"