#requires -Version 7.0
<#
.SYNOPSIS
Offline structural checks for the Phase 1A repository, not infrastructure validation.
#>
[CmdletBinding()]
param([string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot))

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $RepositoryRoot).Path
$issues = [System.Collections.Generic.List[string]]::new()
$files = [System.Collections.Generic.List[System.IO.FileInfo]]::new()
$pending = [System.Collections.Generic.Stack[string]]::new()
$pending.Push($root)
while ($pending.Count -gt 0) {
    foreach ($entry in Get-ChildItem -LiteralPath $pending.Pop() -Force) {
        if ($entry.Name -in @('.git', '.lab', '.worktrees', '.venv', '__pycache__')) { continue }
        if ($entry.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            $issues.Add("Unreviewed filesystem link: $($entry.Name)")
        }
        elseif ($entry.PSIsContainer) { $pending.Push($entry.FullName) }
        else { $files.Add($entry) }
    }
}

foreach ($file in $files) {
    $relative = [System.IO.Path]::GetRelativePath($root, $file.FullName)
    if ($file.Name -match '\.(tf|tf\.json|tftest\.hcl|tftest\.json|tfbackend)$') {
        $issues.Add("Infrastructure is deferred until the isolation milestone: $relative")
    }
    if ($file.Name -match '\.tfstate($|\.)|\.(tfplan|pem|key|pfx|p12)$' -or
        ($file.Name -match '^\.env($|\.)' -and $file.Name -ne '.env.example')) {
        $issues.Add("Local/sensitive artifact must not be in the source tree: $relative")
    }
    if ($file.Extension -eq '.ps1') {
        $tokens = $null
        $parseErrors = $null
        [void][System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$tokens, [ref]$parseErrors)
        foreach ($parseError in $parseErrors) { $issues.Add("PowerShell syntax in ${relative}: $($parseError.Message)") }
    }
    if ($file.Extension -eq '.md') {
        $content = Get-Content -LiteralPath $file.FullName -Raw
        foreach ($match in [regex]::Matches($content, '\[[^\]\r\n]+\]\(([^)\r\n]+)\)')) {
            $target = $match.Groups[1].Value
            if ($target -match '^(https?://|mailto:|#)') { continue }
            $target = ($target -split '#', 2)[0]
            if ($target -and -not (Test-Path -LiteralPath (Join-Path $file.DirectoryName $target))) {
                $issues.Add("Broken local link in ${relative}: $target")
            }
        }
    }
}

try {
    $catalog = Get-Content -LiteralPath (Join-Path $root 'config/tool-versions.json') -Raw | ConvertFrom-Json
    if ($catalog.schemaVersion -ne 1 -or $catalog.activeMilestone -ne '1A' -or $catalog.awsProfile -ne 'brewmaster') {
        $issues.Add('Tool catalog does not match the Phase 1A execution contract.')
    }
    foreach ($tool in $catalog.tools.PSObject.Properties) {
        if ($tool.Value -notmatch '^\d+\.\d+\.\d+$') { $issues.Add("Unpinned version: $($tool.Name)") }
    }
}
catch { $issues.Add("Invalid tool catalog: $($_.Exception.Message)") }

if ($issues.Count) {
    foreach ($issue in $issues) { Write-Output "FAIL: $issue" }
    throw "Foundation validation failed with $($issues.Count) issue(s)."
}
Write-Output "PASS: $($files.Count) source files checked. Links, PowerShell syntax, tool pins, and Phase 1A scope are valid."
Write-Output 'NOT RUN: Terraform, mock tests, security scanners, Docker workloads, AWS APIs, or hosted CI.'
