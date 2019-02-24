Write-Host "Ensuring bitwarden is installed and configured" -ForegroundColor DarkCyan

& scoop install bitwarden-cli
& scoop update bitwarden-cli
& bw login brycekbargar@gmail.com

Write-Host "Bitwarden is installed and configured" -ForegroundColor DarkCyan