Import-Module PSReadLine
Set-PSReadlineOption -EditMode Vi
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        Write-Host -NoNewLine "`e[1 q"
    } else {
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

Import-Module posh-git
$GitPromptSettings.WindowTitle = $null

function prompt {
    $lastCommandSuccess = $?
    $promptColor = [ConsoleColor]::Green
    if(-Not $lastCommandSuccess) {
        $promptColor = [ConsoleColor]::Magenta
    }

    $parts = @(
        [PSCustomObject]@{
            Text = "⚧ ";
            Color = $promptColor
        })
    
    $gitStatus = Get-GitStatus
    if(-Not ($gitStatus -Eq $null)) {
        $promptColor = [ConsoleColor]::Green
        if( $gitStatus.HasWorking -or 
            $gitStatus.HasUntracked -or 
            $gitStatus.HasIndex) {

            $promptColor = [ConsoleColor]::Magenta
        }

        $parts += 
            [PSCustomObject]@{
                Text = $gitStatus.Branch + " ";
                Color = $promptColor
            }
    }

    $currentLocation = ($ExecutionContext.SessionState.Path.CurrentLocation).Path.Replace($HOME, '~')
    if($currentLocation -eq "~") {
        $currentLocation = "~\"
    }

    $parts +=
        [PSCustomObject]@{
            Text = "$currentLocation\";
            Color = [ConsoleColor]::DarkGray
        }

    $promptChar = '🦖'
    $user = [Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())
    if ($user.IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
        $promptChar = '#'
        $promptColor = [ConsoleColor]::Red
    }
    
    $parts += 
        [PSCustomObject]@{
            Text = "`r`n$promptChar ";
            Color = $promptColor
        }
    
    $parts | Foreach-Object {
        $Host.UI.RawUI.ForegroundColor = $_.Color
        $Host.UI.Write("$($_.Text)")
    }

    $host.UI.RawUI.ForegroundColor = [ConsoleColor]::Gray
    return " "
}