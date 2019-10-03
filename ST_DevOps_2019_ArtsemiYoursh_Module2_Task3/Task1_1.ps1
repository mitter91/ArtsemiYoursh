#1.1.	Сохранить в текстовый файл на диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
[CmdletBinding()]
Param(  [parameter(Mandatory=$true, HelpMessage="Running|Stopped")]
        [string]$Status = "Running",
        [string]$Path = "D:\task1_1\file.txt",
        [parameter(Mandatory=$true, HelpMessage="Select disk C:\")]
        [string]$Disk
    )
[string]$services = ""
Get-Service | ForEach-Object{
    if($_.status -eq $Status){$services += $_.Name + ", "}
}
$services | Out-File -FilePath $Path
Get-ChildItem -Path $Disk
Get-Content $Path
