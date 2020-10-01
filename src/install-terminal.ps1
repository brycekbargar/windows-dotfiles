Write-Host "Ensuring windows terminal is installed and configured" -ForegroundColor DarkCyan

& scoop install windows-terminal
& scoop update windows-terminal
& scoop install extras/vcredist2019
& scoop update extras/vcredist2019

Write-Host "Windows terminal is installed and configured" -ForegroundColor DarkCyan
