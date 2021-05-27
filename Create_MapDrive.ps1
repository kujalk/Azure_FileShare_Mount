<#
Developer - K.Janarthanan
Date - 27/5/2021
Purpose - To map network drive to Azure File
#>

try
{
    Write-Host "Creating credential object" -foregroundcolor "Green"
    [securestring]$Encrypt = ConvertTo-SecureString "${storage_key}" -AsPlainText -Force
    [pscredential]$cred = New-Object System.Management.Automation.PSCredential ("AZURE\${storage_account}", $Encrypt)
    Write-Host "Successfully created credential object" -ForegroundColor "Green"

    Write-Host "Creating Network Drive" -ForegroundColor "Green"
    New-PSDrive -Name "${drive_name}" -PSProvider "FileSystem" -Root "\\${storage_account}.file.core.windows.net\${fileshare}" -Credential $cred -Persist
    Write-Host "Created the network drive sucessfully" -ForegroundColor "Green"

}
catch
{
    Write-Host "Error occured while mapping the drive - $_" -ForegroundColor "Red"
}