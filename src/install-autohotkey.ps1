#Requires -RunAsAdministrator

Write-Host "Ensure autohotkey is installed and runs at startup" -ForegroundColor DarkCyan

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
$principal = New-ScheduledTaskPrincipal -UserID "$(Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty UserName)" -RunLevel Highest
Register-ScheduledTask -TaskName "Autohotkey" -TaskPath "\dotfiles" -Action $action -Trigger $trigger -Principal $principal -Force

Write-Host "Autohotkey is installed and runs at startup" -ForegroundColor DarkCyan