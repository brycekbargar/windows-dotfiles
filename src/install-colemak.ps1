Write-Host "Ensuring Colemak is installed and the only layout" -ForegroundColor DarkCyan

if((Get-WmiObject -Class Win32_Product | Where-Object Name -like "*Colemak*").Count -eq 0)
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

Set-Variable colemak -Option Constant -Value {0409:A0000409}

# assume only english is enabled
$en = (Get-WinUserLanguageList)[0];

if ($en.InputMethodTips -notcontains $colemak)
{
    Write-Verbose "Adding colemak to InputMethodTips"
    $en.InputMethodTips.Add($colemak)
}

Write-Verbose "Disabling non-colemak inputs"
$extra = $en.InputMethodTips | Where-Object { $_ -ne $colemak }
$extra | ForEach-Object { $en.InputMethodTips.Remove($_) | Out-Null }
Set-WinUserLanguageList $en -Force


Write-Host "Colemak is the only keyboard layout" -ForegroundColor DarkCyan