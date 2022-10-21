function Analyze( $RegistryPath, $Architecture) {
    Get-ItemProperty $RegistryPath | foreach {
        if (($_.DisplayName) -or ($_.version)) {
            [PSCustomObject]@{
                From = $Architecture;
                Name = $_.DisplayName;
                Version = $_.DisplayVersion;
                Install = $_.InstallDate
            }
        }
    }
}

$InstalledAppsList = @()
$InstalledAppsList += Analyze 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' 64
$InstalledAppsList += Analyze 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' 32
$InstalledAppsList | Sort-Object -Property Name | Export-CSV -Encoding UTF8 "$HOME\\installedapps.csv"

# - https://theitbros.com/how-to-get-list-of-installed-programs-in-windows-10/
#     - Use PowerShell to Get a List of Installed Programs in Windows

# To enable script execution, start PowerShell with following command e.g. from 'Win + R'
#     PowerShell -ExecutionPolicy Unrestricted
#  or
#     PowerShell -ExecutionPolicy Bypass
# - https://duckduckgo.com/?q=powershell+run+script+unauthorized+access&t=h_&ia=web
# - https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.2#-executionpolicy

# - https://stackoverflow.com/questions/21089989/how-to-convert-pipeline-to-csv-format-and-specify-utf-8-encoding/21239357#21239357
#     - change default encoding for 'Export-CSV' to UTF8 to fix diacritics
