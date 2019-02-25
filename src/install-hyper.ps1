Write-Host "Ensuring hyper is installed and configured" -ForegroundColor DarkCyan

Write-Verbose "Installing hyper"
& scoop install hyper
& scoop update hyper

Write-Verbose "Linking hyper.js"
$dotfile = [System.IO.Path]::Combine($PSScriptRoot, "..", "dotfiles", "hyper", ".hyper.js")
$config = [System.IO.Path]::Combine($HOME, ".hyper.js")
& sudo New-Item -Path $config -ItemType SymbolicLink -Value $dotfile -Force

Write-Host "Hyper is installed and configured" -ForegroundColor DarkCyan