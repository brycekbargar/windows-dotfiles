Write-Host "Ensuring gitconfig is linked" -ForegroundColor DarkCyan

Write-Verbose "Linking gitconfig"
$dotfile = [System.IO.Path]::Combine($PSScriptRoot, "..", "dotfiles", "git", ".gitconfig")
$config = [System.IO.Path]::Combine($HOME, ".gitconfig")
& sudo New-Item -Path $config -ItemType SymbolicLink -Value $dotfile -Force

$currentPath = [Environment]::GetEnvironmentVariable('PATH', 'USER')
Write-Debug $currentPath

if (-not $currentPath.Contains("dotfiles\git")) {
    Write-Verbose "Setting path"
    $git = Resolve-Path([System.IO.Path]::Combine($PSScriptRoot, "..", "dotfiles", "git", "bin"))
    [Environment]::SetEnvironmentVariable('PATH', "$currentPath;$git" ,'USER')
}

Write-Host "Gitconfig is linked" -ForegroundColor DarkCyan
