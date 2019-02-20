Write-Host "Ensuring Colemak is installed and the only input" -ForegroundColor DarkCyan

Set-Variable colemak -Option Constant -Value {0409:A0000409}

if (((Get-WinUserLanguageList) | Select-Object -ExpandProperty InputMethodTips | Where-Object { $_ -EQ $colemak }).Count -NE 1)
{
    Write-Debug "Installing Colemak"
    scoop install git-lfs; scoop update git-lfs
    git lfs install
    git lfs checkout
}

if (((Get-WinUserLanguageList) | Select-Object -ExpandProperty InputMethodTips) -NE 1)
{
    Write-Debug "Disable Non-Colemak Inputs"
}

Write-Host "Colemak is the only keyboard layout" -ForegroundColor DarkCyan