Different version of dynamic menu list    $SearchBase = "OU=AnOU,OU=Another OU,OU=YetAnotherOU,DC=Domain,DC=Com"

$ADGroup = Get-ADGroup -filter * -SearchBase $SearchBase | Sort-Object -Descending
$menu = @{ }
[int]$int = 1  #strangely, this forces the array to start at 1 and not zero; well, zero is empty and doesn't count in count
$ADGroup | ForEach-Object {

    #Write-Host $_
    $menu.add($int, $_.name)  
    Write-Host $int , $_.name  
    $int++
}
   
[int]$ans = Read-Host 'Enter selection'
$Selection = $menu.Item($ans) ; $ADGroup


#Teling VSCode to be quiet.
$Selection



