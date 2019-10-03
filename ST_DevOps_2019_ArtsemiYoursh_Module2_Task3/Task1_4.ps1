#1.4.	Подсчитать размер занимаемый файлами в папке (например C:\windows) за исключением файлов с заданным расширением(напрмер .tmp)

[CmdletBinding()]
Param(  [parameter(Mandatory=$true, HelpMessage="Path of summing")]
        [string]$Path,
        [parameter(Mandatory=$true, HelpMessage="FormatType .type")]
        [string]$Format
)
[int]$Sum = 0
Get-ChildItem -Recurse -Path $Path | ForEach-Object{if($_.Name -ne $Format){$Sum += $_.Length}} 
$Sum
