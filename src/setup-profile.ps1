Write-Host "Ensure posh-git is installed and profile is linked" -ForegroundColor DarkCyan

Write-Verbose "Installing posh-git"
& scoop install posh-git
& scoop update posh-git

Write-Verbose "Linking profile"
$dotfile = [System.IO.Path]::Combine($PSScriptRoot, "..", "dotfiles", "powershell", "profile.ps1")
& sudo New-Item -Path $PROFILE -ItemType SymbolicLink -Value $dotfile -Force

Write-Host "Posh-git is installed and profile is linked" -ForegroundColor DarkCyan