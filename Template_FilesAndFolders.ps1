

#########Directory Info#############
$list = Get-ChildItem \\sfeaglfile01\EAGLEH | ForEach-Object { $_.PSIsContainer } | Select-Object FullName
$list.FullName | ForEach-Object { Get-Acl $_ | Format-List }

##########Get directory folder size###########################
$size = "{0:N2} GB" -f ((Get-ChildItem $path -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1GB)
$size
##########NEW Share ###########
New-SmbShare -Name $ShareName -Path -$SharePath  -CachingMode None -FullAccess everyone -CimSession $ServerName

##########Get Share list####################
$list = Get-SmbShare -CimSession sfhqsefile01 | Select-Object Name, Path, Description 
$list


#######File/Folder Permissions and Ownership################################
$UserFolder = "$HomeShare\$UserName"
try {
    New-Item -Path $UserFolder -ItemType Directory -ErrorVariable ErrorUserDirectory
}
catch {
    Add-Content -Path $Logit -value "I can't create $UserFolder"
    Add-Content -Path $Logit -value "$ErrorUserDirectory"
}
$auth = "$domain\$UserName"
$FileSystemAccessRights = [System.Security.AccessControl.FileSystemRights]"Modify"
$AccessControlType = [System.Security.AccessControl.AccessControlType]::Allow
$InheritanceFlags = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit"
$PropagationFlags = [System.Security.AccessControl.PropagationFlags]::None

$NewAccessrule = New-Object System.Security.AccessControl.FileSystemAccessRule($auth, $FileSystemAccessRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)  
$NewOwnerRule = New-Object -TypeName System.Security.Principal.NTAccount -ArgumentList $auth  #Set owner
$currentACL = Get-Acl -path $userfolder 
$currentACL.addAccessRule($NewAccessrule) 
$currentACL.SetOwner($NewOwnerRule)

try {
    Set-Acl -path $userfolder -AclObject $currentACL -ErrorVariable ErrorSetACL

}
catch {
    Add-Content -Path $Logit -value "I had trouble setting ACL on $UserFolder"
    Add-Content -Path $Logit -value "$ErrorSetACL"
}

######################################