<#Write Logs#>
$DateTime = get-date -UFormat %Y%m%d_%I%M_%S
$LogPath = $env:TEMP
$LogName = "Log_$DateTime.txt"
if ( !(Test-Path $LogPath)) { New-Item -ItemType Directory -Path $LogPath -Force}
$Log = "$LogPath\$LogName"