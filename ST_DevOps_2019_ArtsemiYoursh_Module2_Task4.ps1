#1.	Вывести список всех классов WMI на локальном компьютере. 
Get-WmiObject -list 

#2.	Получить список всех пространств имён классов WMI. 
Get-WmiObject -namespace root -list 

#3.	Получить список классов работы с принтером.
Get-WmiObject -list *print*  

#4.	Вывести информацию об операционной системе, не менее 10 полей.
Get-WmiObject -Class win32_operatingSystem | ForEach-Object{ Write-host $_.SystemDirectory; $_.BuildNumber; $_.SerialNumber; $_.Version; $_.SystemDrive; $_.Status; $_.LocalDateTime; $_.WindowsDirectory; $_.TotalVirtualMemorySize; $_.TotalVisibleMemorySize} 

#5.	Получить информацию о BIOS.
Get-WmiObject -Class Win32_BIOS 

#6.	Вывести свободное место на локальных дисках. На каждом и сумму.
$TotalFreeSpace = $null
Get-WmiObject -Class Win32_LogicalDisk | ForEach-Object {
    Write-host $_.DeviceID ([math]::Round($_.FreeSpace / 1Gb , 2)) "Gb";
    $TotalFreeSpace += [math]::Round($_.FreeSpace / 1Gb , 2)
    }
Write-Host "Total Free Space:" $TotalFreeSpace "Gb"

#7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
[CmdletBinding()]
Param(  [parameter(Mandatory=$false, HelpMessage="задайте Ip хоста")]
        [string]$pinghost = "192.168.0.1"
     )
[int]$t = $null
(Test-Connection $pinghost).ResponseTime | ForEach-Object {
    $t += $_
}
Write-Host "Ping time: $t ms"

#или

[CmdletBinding()]
Param(  [parameter(Mandatory=$False, HelpMessage="задайте Ip хоста")]
        [string]$pinghost = "192.168.0.1"
     )
[int]$t = $null
(Get-WmiObject Win32_PingStatus -Filter "Address = '$pinghost'").ResponseTime | ForEach-Object {
    $t += $_
}
Write-Host "Ping time: $t ms"
# Win32_PingStatus пингует только один раз

#8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.
Get-WmiObject -Class Win32_Product | Format-Table Name, Version 

#9.	Выводить сообщение при каждом запуске приложения MS Word.
register-wmiEvent -query "select * from __instancecreationevent within 5 where targetinstance isa 'Win32_Process' and targetinstance.name='winword.exe'" -sourceIdentifier "IllidanWordRage" -Action { 
    $LWindow = New-Object -ComObject Wscript.Shell
    $LWindow.Popup("Вы готовы?", 0, "Иллидан Ярость Слова спрашивает:", 4 )
}