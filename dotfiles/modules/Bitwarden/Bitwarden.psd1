@{
    RootModule = 'Bitwarden.psm1';
    ModuleVersion = '1.0.0.0';
    GUID = 'da9c7490-199d-415c-9f15-4171bdfc2d58';
    Description = 'Uses bitwarden to manage ssh key passwords.';
    PowerShellVersion = '7.0';

    FunctionsToExport = @(
        'Add-Key'
    );
}