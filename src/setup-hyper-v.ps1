Write-Host "Ensure hyper-v is enabled for hosts" -ForegroundColor DarkCyan

Write-Verbose "Enabling hyper-v $env:InstallType"
if ($env:InstallType -eq "host") {
    & sudo Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
}

Write-Host "Hyper-v is enabled for hosts" -ForegroundColor DarkCyan