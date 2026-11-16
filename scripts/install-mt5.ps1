param(
    [Parameter(Mandatory = $true)]
    [string]$TerminalDataPath
)

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$sourceMql5 = Join-Path $root "MQL5"
$targetMql5 = Join-Path $TerminalDataPath "MQL5"
$targetFiles = Join-Path $targetMql5 "Files"

if (!(Test-Path -LiteralPath $sourceMql5)) {
    throw "Source MQL5 folder not found: $sourceMql5"
}

if (!(Test-Path -LiteralPath $targetMql5)) {
    throw "Target terminal MQL5 folder not found: $targetMql5"
}

New-Item -ItemType Directory -Force -Path (Join-Path $targetMql5 "Experts\MEMO") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $targetMql5 "Include\MEMO") | Out-Null
New-Item -ItemType Directory -Force -Path $targetFiles | Out-Null

Copy-Item -LiteralPath (Join-Path $sourceMql5 "Experts\MEMO\MEMO_XAU_XAG_SMT_EA.mq5") -Destination (Join-Path $targetMql5 "Experts\MEMO") -Force
Copy-Item -Path (Join-Path $sourceMql5 "Include\MEMO\*") -Destination (Join-Path $targetMql5 "Include\MEMO") -Recurse -Force

$blackoutExample = Join-Path $root "config\MEMO_NewsBlackouts.example.csv"
$blackoutTarget = Join-Path $targetFiles "MEMO_NewsBlackouts.csv"
if (!(Test-Path -LiteralPath $blackoutTarget)) {
    Copy-Item -LiteralPath $blackoutExample -Destination $blackoutTarget -Force
}

Write-Host "Installed MEMO XAU/XAG SMT EA into $TerminalDataPath"
