<#
.Synopsis

Starts a vscode instance using the Remote Session extension.

.Description

Turns the absolute path into a relative path in the Remote.
Calls `code` with appropriate parameters to start in a remote session.

.Parameter Name
The full path (or relative path from the root of wsl) of the folder/file to edit in vscode.

#>
function wslcode {
    param (
        [String]$Path
    )

    $debianPath = $Path.Replace("$WSLROOT", '').Replace('\', '/')
    & code --remote wsl+Debian $debianPath
}