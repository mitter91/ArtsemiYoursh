(Get-Host).UI.RawUI.ForegroundColor="Red"
(Get-Host).UI.RawUI.BackgroundColor = "Black"
(Get-Host).UI.RawUI.WindowTitle = "inShell"
Set-Alias Say Write-Host
Say работает
Set-Variable –name a –value "100" –option constant
Set-Variable –name b –value "200" –option constant
Set-Location C:\
Write-Host Hello

test-path $profile
Get-Module -ListAvailable