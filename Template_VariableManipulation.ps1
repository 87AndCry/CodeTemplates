

#########Split a var##########################


Get-Content file.txt | ForEach-Object {
    $var = $_.Split('=')
    New-Variable -Name $var[0] -Value $var[1]
}
##################################
