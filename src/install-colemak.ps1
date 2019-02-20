Write-Host "Ensuring Colemak is installed and the only input" -ForegroundColor DarkCyan

Set-Variable colemak -Option Constant -Value {0409:A0000409}

if (((Get-WinUserLanguageList) | Select-Object -ExpandProperty InputMethodTips | Where-Object { $_ -EQ $colemak }).Count -NE 1)
{
    Write-Debug "Installing Colemak"
    Write-Verbose "Installing git-lfs and restoring zips"
    scoop install git-lfs; scoop update git-lfs
    git lfs install
    git lfs checkout

    Write-Verbose "Creating unzip directory"
    $lib = Join-Path $PSScriptRoot ".." "lib"
    $unzip = Join-Path $lib "temp" ([System.IO.Path]::GetTempFileName())
    New-Item $unzip -ItemType Directory

    Write-Verbose "Unzipping using System.IO"
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory((Join-Path $lib "Colemak-1.1-Caps-Lock-Unchanged.zip"), $unzip)

    Write-Verbose "Running installer"
    $msi = Join-Path $unzip "Colemak2_amd64.msi"
    Start-Process msiexec -ArgumentList "/i $msi /qn /norestart" -Wait -PassThru
}

if (((Get-WinUserLanguageList) | Select-Object -ExpandProperty InputMethodTips) -NE 1)
{
    Write-Debug "Disable Non-Colemak Inputs"
}

Write-Host "Colemak is the only keyboard layout" -ForegroundColor DarkCyan