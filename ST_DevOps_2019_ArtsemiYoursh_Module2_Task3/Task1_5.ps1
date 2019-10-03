<#1.5.	Создать один скрипт, объединив 3 задачи:
1.5.1.	Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.
1.5.2.	Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
1.5.3.	Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла и вывести в виде списка  разным разными цветами
#>
[CmdletBinding()]
Param(  [parameter(Mandatory=$false, HelpMessage="Registry path")]
        [string]$RegistryPath = "HKLM:\SOFTWARE\Microsoft",
        [parameter(Mandatory=$true, HelpMessage="Enter Directory Path")]
        [string]$Directory = "D:\task1_5\",
        [parameter(Mandatory=$false, HelpMessage="Enter XML filename")]
        [string]$XMLFile = "File.xml",
        [parameter(Mandatory=$false, HelpMessage="Enter CSV filename")]
        [string]$CSVFile = "File.csv"
     )

New-Item -ItemType Directory -Path $Directory
$XMLPath = $Directory + $XMLFile
$CSVPath = $Directory + $CSVFile
Get-ChildItem $RegistryPath | Export-Clixml -Path $XMLPath -Force
Import-Clixml -Path $XMLPath | ForEach-Object {Write-Host $_ -f DarkRed}
Get-HotFix | Export-Csv -Path $CSVPath
Import-Csv -Path $CSVPath | ForEach-Object {Write-Host $_ -b DarkRed}
