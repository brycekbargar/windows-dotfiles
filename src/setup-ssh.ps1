Write-Host "Ensuring ssh is enabled and ssh-keys are dowloaded from bitwarden" -ForegroundColor DarkCyan

Write-Verbose "Installing latest ssh-agent"
& scoop install win32-openssh
& scoop update win32-openssh
sudo "$(scoop prefix win32-openssh)\install-sshd.ps1"

Write-Verbose "Setting up windows ssh-agent"
sudo Set-Service -Name ssh-agent -StartupType Manual
[Environment]::SetEnvironmentVariable('GIT_SSH', "$(scoop prefix win32-openssh)\ssh.exe", 'USER')

Write-Verbose "Creating ~/.ssh directory"
New-Item ~/.ssh -ItemType Directory -Force | Out-Null

Write-Verbose "Downloading keys from bitwarden"
$session = bw unlock --raw
(bw list items --folderid 5f327073-d3b6-4940-9783-a9db0022589e --session $session | ConvertFrom-Json) |
    Where-Object type -EQ 1 |
    Select-Object -Property @{ name='itemid'; expression={ $_.id } } -ExpandProperty attachments |
    ForEach-Object {
        Write-Debug $_.fileName
        (bw get attachment --session $session $_.id --output (Join-Path (Resolve-Path "~\.ssh\") $_.fileName) --itemid $_.itemid)
    }
bw lock

Write-Host "Ssh is enabled and ssh-keys are dowloaded from bitwarden" -ForegroundColor DarkCyan