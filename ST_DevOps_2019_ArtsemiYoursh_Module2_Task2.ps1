#1.	Просмотреть содержимое ветви реeстра HKCU (поменял комент)
Get-ChildItem -Path HKCU:\ -Recurse -Force

#2.	Создать, переименовать, удалить каталог на локальном диске
New-Item -ItemType Directory -Path C:\tratata
Rename-Item -Path C:\tratata -NewName atatart
Remove-Item -Path C:\atatart

#3.	Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.
New-Item -ItemType Directory -Path C:\M2T2_YOURSH
New-PSDrive -Name P -Root C:\M2T2_YOURSH -PSProvider FileSystem
Get-PSDrive #смотрим, что диск создался

#4.	Сохранить в текстовый файл на созданном диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
Get-Service | Where-Object {$_.Status -eq "Running"} | Out-File -FilePath P:\Services.txt
Get-ChildItem -Path P:\
Get-Content -Path P:\Services.txt

#5.	Просуммировать все числовые значения переменных текущего сеанса.
$S = 0
Get-Variable | ForEach-Object { 
    if 
    ($_.Value -is [int]) 
    {$S += $_.Value}
}
Write-Host $S

#6.	Вывести список из 6 процессов занимающих дольше всего процессор.
Get-Process | Sort-Object CPU -Descending | Select-Object -First 6

<#7.	Вывести список названий и занятую виртуальную память (в Mb) каждого процесса, 
разделённые знаком тире, при этом если процесс занимает более 100Mb – выводить информацию красным цветом,
иначе зелёным.#>

Get-Process | ForEach-Object {
    if ($_.VirtualMemorySize / (1024*1024) -ge 100)
        { 
    Write-Host $_.Name, '-', ([int]($_.VirtualMemorySize / (1024*1024))), 'Mb' -ForegroundColor Red
    }
    else {
        Write-Host $_.Name, '-', ([int]($_.VirtualMemorySize / (1024*1024))), 'Mb' -ForegroundColor Green
    }
}

#8.	Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp
$b=0
Get-ChildItem -Path C:\Windows -Recurse -Force | ForEach-Object {
if ($_.Name -NotLike ".tmp") {$b += $_.Length / (1024*1024)}
}
Write-Host $b 'Mb'

#9.	Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft -Recurse -Force | Export-Csv -Path P:\HKLM.csv

#10.	Сохранить в XML -файле историческую информацию о командах выполнявшихся в текущем сеансе работы PS.\
Get-History | Export-Clixml -Path d:\history.xml

#11.	Загрузить данные из полученного в п.10 xml-файла и вывести в виде списка информацию о каждой записи, в виде 5 любых (выбранных Вами) свойств.
Import-Clixml -Path d:\history.xml  | ForEach-Object {Write-Host $_.Start, $_.ID, $_.EndExecutionTime, $_.ExecutionStatus, $_.CommandLine} 

#12.	Удалить созданный диск и папку С:\M2T2_ФАМИЛИЯ
Remove-PSDrive -Name P
Remove-Item -Path c:\M2T2_YOURSH -Recurse
