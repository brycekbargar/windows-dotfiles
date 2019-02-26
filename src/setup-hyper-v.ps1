Write-Host "Ensure hyper-v is enabled for hosts" -ForegroundColor DarkCyan

Write-Verbose "Enabling hyper-v $env:InstallType"
if ($env:InstallType -eq "host") {
    & sudo Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
    New-Item "~\hyper-v\isos" -ItemType Directory -Force
    New-Item "~\hyper-v\disks" -ItemType Directory -Force
    New-Item "~\hyper-v\machines" -ItemType Directory -Force
}

Write-Host "Hyper-v is enabled for hosts" -ForegroundColor DarkCyan