function Get-AppSettings
{
    Set-Location $PSScriptRoot
    $appSettingsFile = Get-Content -Path "..\appsettings.json" -Raw
    $settings = ConvertFrom-Json $appSettingsFile
    return $settings
}