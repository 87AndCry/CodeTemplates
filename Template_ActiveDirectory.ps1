
$Server = Get-ADComputer computername -Properties *

#Get the DC that you logged in with
$DC = ($env:LOGONSERVER) -replace "\\"  
$DC
# (this strips off the ddomain and first ou leaving the rest)
$ADCanonicalName = $Server.CanonicalName -creplace "^[^/]*/[^/]*" 
$ADCanonicalName

###########For Each Server in an OU ############################
$Searchbase = "ou=Accountants,dc=mydomain,dc=filemaker,dc=com"
$Servers = Get-ADComputer -filter * -SearchBase $searchbase
#$servers = $servers.name  #Uncomment if you want to work with just the name and not the object
$servers = $servers | Sort-Object

$servers | ForEach-Object { }