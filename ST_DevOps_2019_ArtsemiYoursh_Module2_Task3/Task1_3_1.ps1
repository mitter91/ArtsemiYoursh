#1.3.1.	Организовать запуск скрипта каждые 10 минут

$t = New-JobTrigger -Once -At 00:00 -RepetitionInterval 00:10
$cred = Get-Credential Администратор
Register-ScheduledJob -Name Script_3 -FilePath D:\devops\GitHub\ArtsemiYoursh\ST_DevOps_2019_ArtsemiYoursh_Module2_Task3\Task1_3.ps1 -Trigger $t -Credential $cred -RunAs32