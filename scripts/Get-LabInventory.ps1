#requires -Version 7.0
<#
.SYNOPSIS
Read-only inventory for Phase 1A. No credentials or environment-variable dump.
.DESCRIPTION
Runs only fixed version/status commands with bounded execution. Outputs JSON.
This script does not install tools, start services, log in, or change configuration.
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Invoke-InventoryProbe {
    param([string]$Name, [string]$Executable, [string[]]$Arguments)

    $command = Get-Command $Executable -CommandType Application -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if (-not $command) {
        return [ordered]@{ name = $Name; status = 'not-found'; exitCode = $null; output = '' }
    }

    $start = [System.Diagnostics.ProcessStartInfo]::new()
    $start.FileName = $command.Source
    $start.UseShellExecute = $false
    $start.CreateNoWindow = $true
    $start.RedirectStandardOutput = $true
    $start.RedirectStandardError = $true
    $start.Environment['CHECKPOINT_DISABLE'] = '1'
    foreach ($argument in $Arguments) { $start.ArgumentList.Add($argument) }
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $start
    try {
        [void]$process.Start()
        $stdout = $process.StandardOutput.ReadToEndAsync()
        $stderr = $process.StandardError.ReadToEndAsync()
        if (-not $process.WaitForExit(15000)) {
            $process.Kill($true)
            $process.WaitForExit()
            return [ordered]@{ name = $Name; status = 'timeout'; exitCode = $null; output = 'Probe exceeded 15 seconds.' }
        }
        $combined = ($stdout.GetAwaiter().GetResult() + "`n" + $stderr.GetAwaiter().GetResult()).Replace([string][char]0, '').Trim()
        $status = if ($process.ExitCode -eq 0) { 'ok' } else { 'error' }
        return [ordered]@{ name = $Name; status = $status; exitCode = $process.ExitCode; output = $combined }
    }
    catch {
        return [ordered]@{ name = $Name; status = 'error'; exitCode = $null; output = $_.Exception.Message }
    }
    finally { $process.Dispose() }
}

$probes = @(
    Invoke-InventoryProbe -Name 'git' -Executable 'git' -Arguments @('--version')
    Invoke-InventoryProbe -Name 'terraform' -Executable 'terraform' -Arguments @('version')
    Invoke-InventoryProbe -Name 'docker-client-and-server' -Executable 'docker' -Arguments @('version')
    Invoke-InventoryProbe -Name 'docker-compose' -Executable 'docker' -Arguments @('compose', 'version')
)
if ($IsWindows) {
    $probes += Invoke-InventoryProbe -Name 'wsl-status' -Executable 'wsl' -Arguments @('--status')
    $probes += Invoke-InventoryProbe -Name 'wsl-distributions' -Executable 'wsl' -Arguments @('--list', '--verbose')
}
$workspaceDrive = (Get-Item -LiteralPath $PSScriptRoot).PSDrive
$freeGiB = if ($null -ne $workspaceDrive.Free) { [math]::Round($workspaceDrive.Free / 1GB, 1) } else { $null }

[ordered]@{
    schemaVersion = 1
    observedAtUtc = [DateTime]::UtcNow.ToString('o')
    powerShellVersion = $PSVersionTable.PSVersion.ToString()
    platform = if ($IsWindows) { 'Windows' } elseif ($IsLinux) { 'Linux' } else { 'Other' }
    workspaceDriveFreeGiB = $freeGiB
    recommendedDockerMemoryGiB = 10
    configuredDockerMemoryGiB = $null
    probes = $probes
    note = 'Read-only observations. Errors may reflect session restrictions. Review output before sharing; keep raw reports outside Git.'
} | ConvertTo-Json -Depth 5
