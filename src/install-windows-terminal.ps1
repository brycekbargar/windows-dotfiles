Write-Host "Ensuring windows terminal is installed and configured" -ForegroundColor DarkCyan

Write-Verbose "Installing terminal and vcredist2019"
& scoop install windows-terminal
& scoop update windows-terminal
& scoop install extras/vcredist2019
& scoop update extras/vcredist2019

Write-Verbose "Linking configuration"
$dotfile = [System.IO.Path]::Combine($PSScriptRoot, "..", "dotfiles", "windows-terminal", "settings.json")
$config = [System.IO.Path]::Combine("$env:LOCALAPPDATA", "Microsoft", "Windows Terminal", "settings.json")
& sudo New-Item -Path "$config" -ItemType SymbolicLink -Value "$dotfile" -Force

Write-Host "Windows terminal is installed and configured" -ForegroundColor DarkCyan
