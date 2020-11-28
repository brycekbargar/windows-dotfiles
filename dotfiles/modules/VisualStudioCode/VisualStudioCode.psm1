<#
.Synopsis

Starts a vscode instance using the Remote Session extension.

.Description

Turns the absolute path into a relative path in the Remote.
Calls `code` with appropriate parameters to start in a remote session.

Note: This assumes the windows and wsl user are the same name.

.Parameter Path
The path (from the _src folder) of the folder/file to edit in vscode.
Alternatively, the full path if it starts with '/'

#>
function wslcode {
    param (
        [String]$Path
    )

    $Path = $Path.Replace("\", "/")

    if (-Not $Path.StartsWith("/")) {
        $Path = "/home/$env:USERNAME/_src/$Path"
    }

    & code --remote wsl+Debian "$Path"
}