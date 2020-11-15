Write-Host "Ensuring posh-git is installed and profile is linked" -ForegroundColor DarkCyan

Write-Verbose "Installing posh-git"
Install-Module posh-git -AllowPrerelease -Force

Write-Verbose "Linking profile"
$dotfile = [System.IO.Path]::Combine($PSScriptRoot, "..", "dotfiles", "powershell", "profile.ps1")
& sudo New-Item -Path $PROFILE -ItemType SymbolicLink -Value $dotfile -Force

Write-Host "Posh-git is installed and profile is linked" -ForegroundColor DarkCyan