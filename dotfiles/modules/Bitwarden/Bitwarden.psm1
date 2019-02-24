<#
.Synopsis

Calls `bw unlock` and sets the appropriate `$env:BW_SESSION` token for a period of time.

.Description

Calls `bw unlock` and sets the appropriate `$env:BW_SESSION` token for a period of time.
Also sets up a delayed task to lock the vault in 15 minutes.

#>
function Unlock-Vault {
    $session = bw unlock --raw
    if ($session.EndsWith("==") -eq $false) {
        Write-Host $session
        return
    }
    $env:BW_SESSION=$session

    $bw = Resolve-Path (where.exe bw)
    $action = New-ScheduledTaskAction -Execute $bw -Argument "lock"
    $trigger = New-ScheduledTaskTrigger -At (Get-Date).AddMinutes(15) -Once
    $principal = New-ScheduledTaskPrincipal -UserID "$(Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty UserName)"
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopOnIdleEnd -DontStopIfGoingOnBatteries
    Register-ScheduledTask -TaskName "Lock Vault" -TaskPath "\dotfiles" -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force | Out-Null
}