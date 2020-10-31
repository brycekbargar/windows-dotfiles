Write-Host "Ensuring vscode is installed and configured" -ForegroundColor DarkCyan

Write-Verbose "Installing vscode"
& scoop install vscode
& scoop update vscode

Write-Verbose "Creating context menu entry"
& "$HOME\scoop\apps\vscode\current\vscode-install-context.reg"

Write-Verbose "Installing extensions"
& code --install-extension vscodevim.vim
& code --install-extension dracula-theme.theme-dracula
& code --install-extension CoenraadS.bracket-pair-colorizer
& code --install-extension ms-mssql.mssql

Write-Verbose "Linking configuration"
$dotfile = [System.IO.Path]::Combine($PSScriptRoot, "..", "dotfiles", "vscode", "settings.json")
$config = [System.IO.Path]::Combine("$env:APPDATA", "Code", "User", "settings.json")
& sudo New-Item -Path $config -ItemType SymbolicLink -Value $dotfile -Force

& sudo scoop install Cascadia-Code 
& sudo scoop update Cascadia-Code 

Write-Host "Vscode is installed and configured" -ForegroundColor DarkCyan