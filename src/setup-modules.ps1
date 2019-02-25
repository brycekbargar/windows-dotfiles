Write-Host "Ensuring dotfiles\modules are on the ps path" -ForegroundColor DarkCyan

$currentPath = [Environment]::GetEnvironmentVariable('PSModulePath', 'USER')
Write-Debug $currentPath

if (-not $currentPath.Contains("dotfiles\modules")) {
    Write-Verbose "Setting path"
    $modules = Resolve-Path([System.IO.Path]::Combine($PSScriptRoot, "..", "dotfiles", "modules"))
    [Environment]::SetEnvironmentVariable('PSModulePath', "$currentPath;$modules" ,'USER')
}

Write-Host "Dotfiles/modules are on the ps path" -ForegroundColor DarkCyan