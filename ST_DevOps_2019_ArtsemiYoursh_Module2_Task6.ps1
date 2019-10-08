#1.	Для каждого пункта написать и выполнить соответсвующий скрипт автоматизации администрирования:
#1.1.	Вывести все IP адреса вашего компьютера (всех сетевых интерфейсов)
Get-NetIPConfiguration -Detailed | Select-Object -Property IPv4Address, InterfaceDescription


#1.2.	Получить mac-адреса всех сетевых устройств вашего компьютера и удалённо.

Write-Host `t  'Description' `t `t `t 'IPAddress' `t `t 'MACAddress'
    Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE | ForEach-Object{ 
    
    Write-Host $_.Description `t  $_.IPAddress[0] `t `t $_.MACAddress | Format-Table
    }

$Comp = @("VM1","VM2","VM3")
    
Invoke-Command -ScriptBlock {
    Write-Host 'Name' `t  'Description' `t `t `t `t 'IPAddress' `t 'MACAddress'
    $PCName = $env:COMPUTERNAME

        Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE | ForEach-Object {
        Write-Host $PCName `t $_.Description `t $_.IPAddress[0] `t $_.MACAddress
        }
} -ComputerName $Comp -Credential Administrator


#1.3.	На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP.

$Comp = @("VM1","VM2","VM3")
Invoke-Command -ScriptBlock {
$NICs = Get-WMIObject Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled -eq “TRUE”}
ForEach-Object ($NIC in $NICs) {
     $NIC.EnableDHCP()    
     $NIC.SetDNSServerSearchOrder()    
    }
IPConfig /all
} -ComputerName $Comp -Credential Administrator


#1.4.	Расшарить папку на компьютере

Invoke-Command -ScriptBlock {
    New-Item -ItemType Directory -Path "C:\tratata"

    $Acl = Get-Acl "C:\tratata"
    $Ar = New-Object  system.security.accesscontrol.filesystemaccessrule("Everyone","FullControl","Allow")
    $Acl.SetAccessRule($Ar)
    Set-Acl "C:\tratata" $Acl
    
    New-SMBShare –Name "ratata" -Path "C:\tratata" -FullAccess "Everyone"
    
} -ComputerName VM2 -Credential Administrator


#1.5.	Удалить шару из п.1.4

Invoke-Command -ScriptBlock {

    Remove-SmbShare -Name "ratata" -Force
    Remove-Item -Path "C:\tratata" -Force
    
} -ComputerName VM2 -Credential Administrator


#1.6.	Скрипт входными параметрами которого являются Маска подсети и два ip-адреса. Результат  – сообщение (ответ) в одной ли подсети эти адреса.




#2.	Работа с Hyper-V

Enable-WindowsOptionalFeature -Online -FeatureName  Microsoft-Hyper-V-Management-PowerShell

Enable-WindowsOptionalFeature -Online -FeatureName  Microsoft-Hyper-V-Tools-All

Enable-WindowsOptionalFeature -Online -FeatureName  Microsoft-Hyper-V-All


#2.1.	Получить список коммандлетов работы с Hyper-V (Module Hyper-V)

Get-Command -CommandType Cmdlet -Source Hyper-V 
#Get-Command *-VM cmdlet


#2.2.	Получить список виртуальных машин

Get-VM


#2.3.	Получить состояние имеющихся виртуальных машин

Get-VM
#or mb
Enable-VMResourceMetering -VMName 'YOURSH_VM1'
Measure-VM -VMName 'YOURSH_VM1'


#2.4.	Выключить виртуальную машину

Stop-VM -Name VM2 -TurnOff -Force

#2.5.	Создать новую виртуальную машину

New-VM -Name VM4


#2.6.	Создать динамический жесткий диск

#Get-Command *VHD* cmdlet

New-VHD -Path D:\VMS\test\dddisc.vhdx -Dynamic -SizeBytes 20Mb


#2.7.	Удалить созданную виртуальную машину

Remove-VM -Name VM4
