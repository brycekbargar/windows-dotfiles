@{
    RootModule = 'Bitwarden.psm1';
    ModuleVersion = '1.0.0.0';
    GUID = 'da9c7490-199d-415c-9f15-4171bdfc2d58';
    Description = 'Wraps bw commands with Powershell functions';
    PowerShellVersion = '5.0';

    FunctionsToExport = @(
        'Unlock-Vault',
        'Add-Key'
    );
}