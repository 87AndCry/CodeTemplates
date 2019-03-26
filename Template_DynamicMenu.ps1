Different version of dynamic menu list    $MaintSearchBase = "OU=AnOU,OU=Another OU,OU=YetAnotherOU,DC=Domain,DC=Com"

$MaintWindow = Get-ADGroup -filter * -SearchBase $MaintSearchBase | sort-object -Descending
$menu = @{}
[int]$int = 1  #strangely, this forces the array to start at 1 and not zero; well, zero is empty and doesn't count in count
$MaintWindow | ForEach-Object {

    #Write-Host $_
    $menu.add($int, $_.name)  
    Write-host $int , $_.name  
    $int++
}
   
[int]$ans = Read-Host 'Enter selection'
$selection = $menu.Item($ans) ; $MaintWindows