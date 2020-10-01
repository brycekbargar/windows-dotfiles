Write-Host "Ensuring windows subsystem for linux is installed and ready to be configured" -ForegroundColor DarkCyan

Write-Verbose "Installing terminal and vcredist2019"
& scoop install windows-terminal
& scoop update windows-terminal
& scoop install extras/vcredist2019
& scoop update extras/vcredist2019

Write-Verbose "Enabling WSL"
& sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
& sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
Write-Warning "WSL is enabled, a restart may be required"

$wsl_update_x64 = "$HOME\Downloads\wsl_update_x64.msi"
if (-not (Test-Path $wsl_update_x64)) {
    Write-Verbose "Downloading kernel update to be run later"
    Invoke-WebRequest -uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile $wsl_update_x64
}

Write-Host "Windows subsystem for linux is installed and ready to be configured" -ForegroundColor DarkCyan
