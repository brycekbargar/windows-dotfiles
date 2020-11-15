Write-Host "Ensuring scoop is setup and happy" -ForegroundColor DarkCyan

Write-Verbose "Installing latest scoop and related tools"
& scoop bucket add extras
& scoop bucket add nerd-fonts
& scoop update
& scoop install 7zip
& scoop update 7zip
& scoop install sudo
& scoop update sudo

Write-Verbose "Fixing scoop checkup issues"
Write-Verbose "Inno Setup Unpacker' is not installed! It's required for unpacking InnoSetup files."
& scoop install innounp

Write-Verbose "Windows Defender may slow down or disrupt installs with realtime scanning."
& sudo Add-MpPreference -ExclusionPath "$HOME\scoop"
& sudo Add-MpPreference -ExclusionPath 'C:\ProgramData\scoop'

Write-Verbose "LongPaths support is not enabled."
& sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

Write-Verbose "Cleaning up previous app version"
& scoop cleanup *

Write-Host "Scoop is setup and happy" -ForegroundColor DarkCyan