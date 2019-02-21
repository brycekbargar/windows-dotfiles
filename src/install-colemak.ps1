Write-Host "Ensuring Colemak is installed and the only layout" -ForegroundColor DarkCyan

if((Get-WmiObject -Class Win32_Product | Where-Object Name -like "*Colemak*").Count -eq 0)
{
    Write-Debug "Installing Colemak"
    Write-Verbose "Installing git-lfs and restoring zips"
    & scoop install git-lfs
    & scoop update git-lfs
    & git lfs install
    & git lfs checkout

    Write-Verbose "Creating unzip directory"
    $lib = [System.IO.Path]::Combine($PSScriptRoot, "..", "lib")
    $unzip = [System.IO.Path]::Combine($lib, "temp", [System.IO.Path]::GetRandomFileName())

    Write-Verbose "Unzipping using System.IO"
    Expand-Archive -Path ([System.IO.Path]::Combine($lib, "Colemak-1.1-Caps-Lock-Unchanged.zip")) -DestinationPath $unzip

    Write-Verbose "Running installer"
    $msi = Resolve-Path ([System.IO.Path]::Combine($unzip, "Colemak2_amd64.msi"))
    Start-Process msiexec.exe -ArgumentList "/package $msi /qn" -Wait -PassThru -Verb RunAs
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

Write-Host "Colemak is installed the only keyboard layout" -ForegroundColor DarkCyan