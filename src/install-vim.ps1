Write-Host "Ensuring vim is installed and configured" -ForegroundColor DarkCyan

Write-Verbose "Installing latest vim"
& scoop install vim
& scoop update vim

Write-Verbose "Creating ~/.vim directory"
New-Item "~/.vim/pack/tpope/start" -ItemType Directory -Force | Out-Null

Write-Verbose "Loading vim-sensible plugin"
Push-Location "~/.vim/pack/tpope/start"
    if (-not (Test-Path "sensible")) {
        git clone https://tpope.io/vim/sensible.git
    }
    else {
        Push-Location sensible
            git fetch --prune
            git reset --hard origin/master
        Pop-Location
    }
Pop-Location

Write-Host "Vim is installed and configured" -ForegroundColor DarkCyan