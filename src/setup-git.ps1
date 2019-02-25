Write-Host "Ensure gitconfig is linked and user is set" -ForegroundColor DarkCyan

Write-Verbose "Linking gitconfig"
$dotfile = [System.IO.Path]::Combine($PSScriptRoot, "..", "dotfiles", "git", ".gitconfig")
$config = [System.IO.Path]::Combine($HOME, ".gitconfig")
& sudo New-Item -Path $config -ItemType SymbolicLink -Value $dotfile -Force

Write-Verbose "Setting username"
& git config --system user.name "bryce"
& git config --system user.email "brycekbargar@gmail.com"

Write-Host "Gitconfig is linked and user is set" -ForegroundColor DarkCyan
