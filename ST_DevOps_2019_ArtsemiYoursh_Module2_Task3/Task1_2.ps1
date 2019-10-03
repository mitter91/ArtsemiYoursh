#1.2.	Просуммировать все числовые значения переменных среды Windows. (Параметры не нужны)

<# Почему-то не работает
$S = 0
Get-ChildItem Env: | ForEach-Object { 
    if 
    ($_.Value -is [int]) 
    {$S += $_.Value}
}
Write-Host $S
#>

$S = 0
Get-Variable | ForEach-Object { 
    if 
    ($_.Value -is [int]) 
    {$S += $_.Value}
}
Write-Host $S