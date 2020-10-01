param(
    [Parameter(mandatory=$true)]
    [ValidateSet('home', 'milyli')]
    [String]$InstallEnv,

    [Parameter(mandatory=$true)]
    [ValidateSet('host', 'guest')]
    [String]$InstallType
)

Write-Host "Starting Setup!" -ForegroundColor DarkGreen

$env:InstallEnv = $InstallEnv
$env:InstallType = $InstallType

$src = $PSScriptRoot

Import-Module (Resolve-Path (Join-Path $src "setup-scoop.ps1")) -Force
& sudo Import-Module (Resolve-Path (Join-Path $src "install-autohotkey.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "install-colemak.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "install-bitwarden.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "install-hyper.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "install-vscode.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "setup-profile.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "setup-ssh.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "setup-modules.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "setup-git.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "setup-hyper-v.ps1")) -Force
Import-Module (Resolve-Path (Join-Path $src "install-programs.ps1")) -Force