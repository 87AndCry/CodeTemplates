

#get features from one server and apply to new one.
Get-WindowsFeature -cn OLDSERVERNAME | ForEach-Object { $_.Installed -eq $true } | Add-WindowsFeature 