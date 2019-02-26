# Dotfiles (on windows!)

### Usage

```ps
# In admin powershell
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine

# In regular powershell
Invoke-Expression (New-Object Net.WebClient).DownloadString('https://get.scoop.sh')
scoop install git

New-Item ~\_src -ItemType Directory
Set-Location ~\_src
git clone https://github.com/brycekbargar/windows-dotfiles.git
Set-Location windows-dotfiles

.\src\setup.ps1
```