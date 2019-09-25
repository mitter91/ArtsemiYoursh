#1. Получите справку о командлете справки 
Get-Help Get-Help 

#2. Пункт 1, но детальную справку, затем только примеры
Get-Help Get-Help -Detailed
Get-Help Get-Help -Examples
#не исключено, что для этого придется обновить справку

#3. Получите справку о новых возможностях в PowerShell 4.0 (или выше)
Get-help about_Windows_PowerShell_5.0

#4. Получите все командлеты установки значений
Get-Command -CommandType Cmdlet -Name Set* 
#Правильно бы было наверное Get-Command -CommandType Cmdlet -Verb Set , но это не работает

#5. Получить список команд работы с файлами
Get-Command -Noun Item

#6. Получить список команд работы с объектами
Get-Command -Noun Object

#7.	Получите список всех псевдонимов
Get-Alias

#8.	Создайте свой псевдоним для любого командлета
Set-Alias -Name vremya -Value Get-Date
Get-Alias -Name vremya #проверка

#9.	Просмотреть список методов и свойств объекта типа процесс
Get-Process -Name explorer | Get-Member -MemberType Properties, Method

#10.	Просмотреть список методов и свойств объекта типа строка
[string]$a = 32
$a | Get-Member
# или
"tratata" | Get-Member

#11. Получить список запущенных процессов, данные об определённом процессе
Get-Process
Get-Process -Name explorer 

#12. Получить список всех сервисов, данные об определённом сервисе
Get-Service
Get-Service -Name EventLog

#13. Получить список обновлений системы
Get-HotFix #первый вариант
Import-Module PSWindowsUpdate   #второй с добавлением дополнительного модуля
Get-WUHistory

#14. Узнайте, какой язык установлен для UI Windows
[CultureInfo]::InstalleduICulture

#15. Получите текущее время и дату
Get-Date

#16.	Сгенерируйте случайное число (любым способом)
Get-Random 

#17.	Выведите дату и время, когда был запущен процесс «explorer». Получите какой это день недели.
(Get-Process -Name explorer).StartTime
(Get-Process -Name explorer).StartTime.DayOfWeek 

#18.	Откройте любой документ в MS Word (не важно как) и закройте его с помощью PowerShell
$Word = New-Object -ComObject Word.Application
$Word.Visible = $true
$Document = $Word.Documents.Add() #новый документ
$Document.Close()
$Word.Quit()

#19.	Подсчитать значение выражения S= . N – изменяемый параметр. Каждый шаг выводить в виде строки. (Пример: На шаге 2 сумма S равна 9)
$i++ ; $S=$S+3*$i; Write-Output "На шаге $i, сумма будет равна $s"

#20.	Напишите функцию для предыдущего задания. Запустите её на выполнение.
function P9D {$i++ ; $S=$S+3*$i; Write-Output "На шаге $i, сумма будет равна $s"}
P9D

#или можно запариться в скриптик
function P9D
{
    Clear-Variable -Name * #Перед выполнением обнуляем все переменные
    $n = Read-Host "Задайте N" #ввод с руки кол-ва повторений
    Do {
        $i++; $S=$S+3*$i; Write-output "На шаге $i, сумма S равна $S"
    }
    While ($i -lt $n)  
}
P9D