#Добавление всех хостов в доверенные
#Set-Item WSMan:\localhost\Client\TrustedHosts -Value *

#1.	При помощи WMI перезагрузить все виртуальные машины.

$Computer = @("VM1","VM2","VM3")
Invoke-Command -ScriptBlock {
    Get-WmiObject Win32_OperatingSystem | Invoke-WmiMethod -Name reboot
} -ComputerName $Computer -Credential Administrator


#2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере. 

$Computer = @("VM1","VM2","VM3")
Invoke-Command -ScriptBlock {
    Get-WmiObject Win32_Service | Where-Object {$_.State -eq "Running"}
} -ComputerName $Computer -Credential Administrator | Format-Table -AutoSize


#3.	Настроить PowerShell Remoting, для управления всеми виртуальными машинами с хостовой.
#На VM:
# Enable-PSRemoting - не обязательно, если в server mager включено удаленное управление

Enter-PSSession -ComputerName VM1 -Credential Administrator


#4.	Для одной из виртуальных машин установить для прослушивания порт 42658. Проверить работоспособность PS Remoting.

$Computer = @("VM1","VM2","VM3")
Invoke-Command -ScriptBlock {
    Set-Item WSMan:\localhost\listener\listener*\port -Value 42658
} -ComputerName $Computer -Credential Administrator

#Проверка:

Enter-PSSession -ComputerName VM1 -Port 42658 -Credential Administrator 

#Как вернуть в зад:
$Computer = @("VM1","VM2","VM3")
Invoke-Command -port 42658 -ScriptBlock {
    Set-Item WSMan:\localhost\listener\listener*\port -Value 5985
} -ComputerName $Computer -Credential Administrator
#Проверка:
Enter-PSSession -ComputerName VM2 -Credential Administrator 


#5.	Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.

$Computer = @("VM1","VM2","VM3")
$credent = Get-Credential Administrator
Invoke-Command -ScriptBlock {
    New-PSSessionConfigurationFile -Path Guest.pssc –VisibleCmdlets Get-ChildItem
    Test-PSSessionConfigurationFile .\Guest.pssc
    Register-PSSessionConfiguration -Name Guest -Path .\Guest.pssc -RunAsCredential $credent
} -ComputerName $Computer -Credential $credent


Enter-PSSession -ComputerName VM1 -Credential Administrator -ConfigurationName Guest
# дает зайти только через VSCode и не видит вообще ничего, даже get-childitem, т.к. Out-Default тоже недоступен