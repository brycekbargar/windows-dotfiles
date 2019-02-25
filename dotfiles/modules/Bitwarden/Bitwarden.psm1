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
    bw sync

    $bw = Resolve-Path (where.exe bw)
    $action = New-ScheduledTaskAction -Execute $bw -Argument "lock"
    $trigger = New-ScheduledTaskTrigger -At (Get-Date).AddMinutes(15) -Once
    $principal = New-ScheduledTaskPrincipal -UserID "$(Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty UserName)"
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopOnIdleEnd -DontStopIfGoingOnBatteries
    Register-ScheduledTask -TaskName "Lock Vault" -TaskPath "\dotfiles" -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force | Out-Null
}

<#
.Synopsis

Calls `ssh-add` on the named key in the ~/.ssh folder with the password copied to the clipboard.

.Description

Calls `ssh-add` on the given key in ~/.ssh with the password copied to the clipboard.
The given name must exist on disk and in Bitwarden under the SshKeys folder.
Ssh-Agent must already be started.

.Parameter Name
The name of the SshKey (both file and entry in bitwarden)

#>
function Add-Key {
    param (
        [String]$Name
    )

    $login = (bw list items --search $Name --folderid 5f327073-d3b6-4940-9783-a9db0022589e | ConvertFrom-Json) | 
        Select-Object -ExpandProperty login  -First 1
    $key = Resolve-Path "~/.ssh/$Name"
    
    Set-Clipboard $login.password
    try {
        & ssh-add $key
    }
    finally {
        Set-Clipboard $null
    }
}