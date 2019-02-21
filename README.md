# Dotfiles (on windows!)

### Usage

```ps
Invoke-Expression (New-Object Net.WebClient).DownloadString('https://get.scoop.sh')
scoop install git

New-Item ~/_src -ItemType Directory
Set-Location ~/_src
git clone https://github.com/brycekbargar/windows-dotfiles.git
Set-Location ~/_src/windows-dotfiles

.\src\setup.ps1
```