$Host.UI.RawUI.BackgroundColor = [ConsoleColor]::Black
$Host.UI.RawUI.ForegroundColor = [ConsoleColor]::Gray

Set-PSReadlineOption -EditMode Vi

Import-Module posh-git
$GitPromptSettings.EnableWindowTitle = $null
$GitPromptSettings.EnableFileStatus = $false

function prompt {
    $lastCommandSuccess = $?

    $parts = @(
        [PSCustomObject]@{
            Text = $env:USERNAME;
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

    $git = Write-VcsStatus 6>&1
    $postCommandParts = @(
        [PSCustomObject]@{
            Text = $currentLocation;
            Color = [ConsoleColor]::Cyan
        },
        [PSCustomObject]@{
            Text = $git;
            Color = [ConsoleColor]::Yellow
        })

    $available = $Host.UI.RawUI.WindowSize.Width - ($Host.UI.RawUI.WindowSize.Width * .2) - 
        (($parts + $postCommandParts) | 
            Select-Object -Property @{ Name = "Length"; Expression = {$_.Text.Length}} |
            Measure-Object -Sum Length).Sum

    $lastCommandText = (Get-History -Count 1).CommandLine
    $lastCommandColor = [ConsoleColor]::Red
    if ($null -eq $lastCommandText -or $lastCommandText.Contains("`n") -or $lastCommandText.Length -gt $available) {
        $lastCommandText = "..."
    }
    if ($lastCommandSuccess) {
        $lastCommandColor = [ConsoleColor]::DarkMagenta 
    }
    
    $parts += 
        [PSCustomObject]@{
            Text = $lastCommandText;
            Color = $lastCommandColor
        }
    
    $parts += $postCommandParts

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