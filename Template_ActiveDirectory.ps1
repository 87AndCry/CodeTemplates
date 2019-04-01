
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

####################Generate a Random Password #########################
#need to check this one.  It odes not appear to grab punctuation
Function Get-RandomPassword([int32]$Length = 8, [Switch]$Complex) { 
    $chars = @("abcdefghijkmnopqrstuvwxyz", "ABCEFGHJKLMNPQRSTUVWXYZ", "1234567890", "!@#$%^&*()-+") 
    Do { 
        $result = "" 
        for ($i = 0; $i -lt $Length; $i++) { 
            if ($Complex) { $j = Get-Random -Maximum 4 } 
            else { $j = Get-Random -Maximum 3 } 
            $result += $chars[$j][(Get-Random -Maximum $chars[$j].Length)] 
        } 
    } Until($result -cmatch “[A-Z]” -and $result -cmatch “[a-z]” -and $result -cmatch “[0-9]” -and (!$Complex -or $result -cmatch “[\!\@\#\$\%\^\&\*\(\)\-\+]”) -or ($Length -lt 4 -or (!$Complex -and $Length -lt 3))) 
    $result 
}



function New-Credential {
    #written by evetsleep, Found on Reddit
    $counter = 0
    $more = $true
    while ($more) {
        if ($counter -ge 3) {
            Write-Warning -Message ('Take a deep breath and perhaps a break.  You have entered your password {0} times incorrectly' -f $counter)
            Write-Warning -Message ('Please wait until {0} to try again to avoid risking locking yourself out.' -f $((Get-Date).AddMinutes(+15).ToShortTimeString()))
            Start-Sleep -Seconds 30
        }

        # Collect the username and password and store in credential object.
        $userName = Read-Host -Prompt 'Please enter your domain\username'
        $password = Read-Host -AsSecureString -Prompt 'Please enter your password'
		
        try {
            $credential = New-Object System.Management.Automation.PSCredential $userName, $password

            # Build the current domain
            $currentDomain = 'LDAP://{0}' -f $credential.GetNetworkCredential().Domain

            # Get the user\password. The GetNetworkCredential only works for the passwrod because the current user
            # is the one who entered it.  Shouldn't be accessible to anything\one else.
            $userName = $credential.GetNetworkCredential().UserName
            $password = $credential.GetNetworkCredential().Password

        }
        catch {
            Write-Warning -Message ('There was a problem with what you entered: {0}' -f $_.exception.message)
            continue
        }

        # Do a quick query against the domain to authenticate the user.
        $dom = New-Object System.DirectoryServices.DirectoryEntry($currentDomain, $userName, $password)
        # If we get a result back with a name property then we're good to go and we can store the credential.
        if ($dom.name) {
            Write-Output $credential
            $more = $false
            Remove-Variable password -Force
        }
        else {
            $counter++

            Write-Warning -Message ('The password you entered for {0} was incorrect.  Attempts {1}. Please try again.' -f $userName, $counter)
        }
    }
}