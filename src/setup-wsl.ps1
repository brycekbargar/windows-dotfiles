Write-Host "Ensuring windows subsystem for linux is installed and ready to be configured" -ForegroundColor DarkCyan

if(-not (& where.exe wsl)) {
    Write-Verbose "Enabling WSL"
    & sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    & sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    Write-Warning "WSL is enabled, a restart may be required"
}

$wsl_update_x64 = "$HOME\Downloads\wsl_update_x64.msi"
if (-not (Test-Path $wsl_update_x64)) {
    Write-Verbose "Downloading kernel update to be run later"
    Invoke-WebRequest -uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile $wsl_update_x64
}
$wsl_update_x64 = "$HOME\Downloads\wsl_update_x64.msi"

Do {
Write-Verbose "Checking for the latest version of Debian"
$response = Invoke-WebRequest 'https://aka.ms/wsl-debian-gnulinux' `
    -MaximumRedirection 0 `
    -SkipHttpErrorCheck `
    -ErrorAction Ignore
If ($response.StatusCode -eq 301)
{
    $actualDebianUrl = $response.Headers.Location[0]
    if(([System.Uri]$actualDebianUrl).AbsolutePath -match '/(.*_x64)__' -and $Matches.Count -eq 2)
    {
        $DebianGNULinux_Version_x64 = "$HOME\Downloads\$($Matches.1).zip"
        if (-not (Test-Path $DebianGNULinux_Version_x64)) {
            Write-Verbose "Downloading latest version of Debian"
            Invoke-WebRequest -uri $actualDebianUrl -OutFile $DebianGNULinux_Version_x64

            $wsl_install_location = "$HOMEDRIVE\wsl\$($Matches.1)"
            if (-not (Test-Path $wsl_install_location)) {
                Write-Verbose "Extracting latest version of Debian"
                New-Item $wsl_install_location -Type Directory
                Expand-Archive -Path $DebianGNULinux_Version_x64 -DestinationPath $wsl_install_location


                & sudo New-Item -Path "$HOMEDRIVE\wsl\Debian"  -ItemType SymbolicLink -Value $wsl_install_location -Force
                break
            }
        }
    }

    Write-Warning "Didn't download/extract the latest of Debian, either the remote is changed or it is already dowloaded/extracted"
}
} While ($false)

Write-Host "Windows subsystem for linux is installed and ready to be configured" -ForegroundColor DarkCyan
