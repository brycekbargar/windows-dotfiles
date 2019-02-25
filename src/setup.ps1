Write-Host "Starting Setup!" -ForegroundColor DarkGreen

& scoop bucket add extras
& scoop install sudo
& scoop update sudo

$src = $PSScriptRoot

& sudo Import-Module (Resolve-Path (Join-Path $src "install-autohotkey.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "install-colemak.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "install-bitwarden.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "setup-profile.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "setup-ssh.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "setup-modules.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "setup-git.ps1")) -Force