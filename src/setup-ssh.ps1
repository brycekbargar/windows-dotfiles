Write-Host "Ensuring ssh is enabled and ssh-keys are dowloaded from bitwarden" -ForegroundColor DarkCyan

Write-Verbose "Setting up windows ssh-agent"
sudo Set-Service -Name ssh-agent -StartupType Manual
[Environment]::SetEnvironmentVariable('GIT_SSH', (Resolve-Path (where.exe ssh)), 'USER')

Write-Verbose "Creating ~/.ssh directory"
New-Item ~/.ssh -ItemType Directory -Force | Out-Null

Write-Verbose "Downloading keys from bitwarden"
(bw list items --folderid 5f327073-d3b6-4940-9783-a9db0022589e | ConvertFrom-Json) |
    Where-Object type -EQ 1 |
    Select-Object -Property @{ name='itemid'; expression={ $_.id } } -ExpandProperty attachments |
    ForEach-Object {
        Write-Debug $_.fileName
        (bw get attachment $_.id --output (Join-Path (Resolve-Path "~\.ssh\") $_.fileName) --itemid $_.itemid) | Out-Null
    }

Write-Host "Ssh is enabled and ssh-keys are dowloaded from bitwarden" -ForegroundColor DarkCyan