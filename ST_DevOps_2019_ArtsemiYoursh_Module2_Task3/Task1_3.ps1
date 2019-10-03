#1.3.	Вывести список из 10 процессов занимающих дольше всего процессор. Результат записывать в файл.

[CmdletBinding()]
Param(  [parameter(Mandatory=$true, HelpMessage="Process count")]
        [int]$Count = 10
 
        )

$Path = "D:\task1_3\file.txt"
Get-Process | Sort-Object CPU -Descending | Select-Object -First $Count | Out-File "D:\task1_3\file.txt"
Get-Content $Path