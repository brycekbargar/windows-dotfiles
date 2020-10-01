& scoop bucket add extras
& scoop install sudo
& scoop update sudo

# Scoop Checkup fixes
    # 'Inno Setup Unpacker' is not installed! It's required for unpacking InnoSetup files.
    & scoop install innounp

    # Windows Defender may slow down or disrupt installs with realtime scanning.
    & sudo Add-MpPreference -ExclusionPath "$HOME\scoop"
    & sudo Add-MpPreference -ExclusionPath 'C:\ProgramData\scoop'

    # LongPaths support is not enabled.
    & sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1