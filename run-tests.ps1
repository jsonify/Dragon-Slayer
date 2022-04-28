$dsPath = 'D:\Projects\Powershell\DragonSlayer'

Set-Location $dsPath

Import-Module Pester

Invoke-Pester "$dsPath\DragonSlayer.Tests.ps1"

