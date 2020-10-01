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