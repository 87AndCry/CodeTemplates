<#Work with windows versions#>
$version = (Get-WmiObject -class Win32_OperatingSystem).version
$MajorV = ([version]$version).Major
#write-host "$MajorV $env:COMPUTERNAME"
if ($MajorV -lt 10) {write-host "$env:COMPUTERNAME $version"}