Write-Host "Ensuring vscode is installed and configured" -ForegroundColor DarkCyan

Write-Verbose "Installing vscode"
& scoop install vscode
& scoop update vscode

Write-Verbose "Creating context menu entry"
& "$HOME\scoop\apps\vscode\current\vscode-install-context.reg"

Write-Verbose "Installing Cascadia-Code"
& sudo scoop install Cascadia-Code 
& sudo scoop update Cascadia-Code 

Write-Host "Vscode is installed and configured" -ForegroundColor DarkCyan