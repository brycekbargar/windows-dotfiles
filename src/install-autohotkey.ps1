#Requires -RunAsAdministrator

Write-Host "Ensuring autohotkey is installed and runs at startup" -ForegroundColor DarkCyan

Write-Verbose "Installing autohotkey"
& scoop install autohotkey
& scoop update autohotkey

$ahk = Resolve-Path (where.exe autohotkey)
$default = Resolve-Path ([System.IO.Path]::Combine($PSScriptRoot, "..", "dotfiles", "autohotkey", "default.ahk"))

Write-Debug $ahk
Write-Debug $default

Write-Verbose "Registering startup scheduled task"
$action = New-ScheduledTaskAction -Execute $ahk -Argument $default
$trigger = New-ScheduledTaskTrigger -AtLogon
$principal = New-ScheduledTaskPrincipal -UserID "$(Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty PrimaryOwnerName)" -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopOnIdleEnd -DontStopIfGoingOnBatteries
Register-ScheduledTask -TaskName "Autohotkey" -TaskPath "\dotfiles" -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force

Write-Host "Autohotkey is installed and runs at startup" -ForegroundColor DarkCyan