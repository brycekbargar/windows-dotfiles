Set-PSReadlineOption -EditMode Vi
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        Write-Host -NoNewLine "`e[1 q"
    } else {
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

Set-Variable 'WSLHOME' "C:\wsl\Debian\rootfs\home\bryce\"

Import-Module posh-git
$GitPromptSettings.EnableWindowTitle = $null

function prompt {
    $lastCommandSuccess = $?

    $parts = @(
        [PSCustomObject]@{
            Text = "$env:USERDomain\$env:USERNAME";
            Color = [ConsoleColor]::Green
        },
        [PSCustomObject]@{
            Text = "@";
            Color = [ConsoleColor]::Magenta
        },
        [PSCustomObject]@{
            Text = $env:COMPUTERNAME
            Color = [ConsoleColor]::Green
        })

    $currentLocation = ($ExecutionContext.SessionState.Path.CurrentLocation).Path.Replace($HOME, '~')
    if($currentLocation -eq "~") {
        $currentLocation = "~\"
    }

    $git = (Write-VcsStatus 6>&1) -join ''
    $parts += @(
        [PSCustomObject]@{
            Text = "$currentLocation\";
            Color = [ConsoleColor]::Cyan
        },
        [PSCustomObject]@{
            Text = $git;
            Color = [ConsoleColor]::Yellow
        })

    $promptChar = '$'
    $promptColor = [ConsoleColor]::DarkGray
    $user = [Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())
    if ($user.IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
        $promptChar = '#'
        $promptColor = [ConsoleColor]::Red
    }
    
    $parts += 
        [PSCustomObject]@{
            Text = "`r`n$promptChar>";
            Color = $promptColor
        }
    
    $parts | Foreach-Object {
        $Host.UI.RawUI.ForegroundColor = $_.Color
        $Host.UI.Write("$($_.Text) ")
    }

    $host.UI.RawUI.ForegroundColor = [ConsoleColor]::Gray
    return " "
}