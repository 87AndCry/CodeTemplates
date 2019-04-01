#Mainmenu function. Contains the screen output for the menu and waits for and handles user input.  

#AreYouSure function. Alows user to select y or n when asked to exit. Y exits and N returns to main menu.  
function Enter-AreYouSure {
    $AreYouSure = Read-Host "Are you sure you want to exit? (y/n)"  
    if ($AreYouSure -eq "y") { exit }  
    if ($AreYouSure -eq "n") { Enter-Mainmenu }  
    else {
        Write-Host -foregroundcolor red "Invalid Selection"   
        Enter-AreYouSure  
    }  
}  
function Enter-Mainmenu {  
    Clear-Host  
    Write-Output "---------------------------------------------------------"  
    Write-Output ""  
    Write-Output ""  
    Write-Output "    1. Open Notepad"  
    Write-Output "    2. Open Calculator"  
    Write-Output "    3. Exit"  
    Write-Output ""  
    Write-Output ""  
    Write-Output "---------------------------------------------------------"  
    $answer = Read-Host "Please Make a Selection"  
    switch ($answer) {
        1 { Write-Host Notepad }
        2 { Write-Host Calc }
        3 { Enter-AreYouSure }
        default {
            Write-Host -ForegroundColor red "Invalid Selection" 
            Start-Sleep -Seconds 1 
            Enter-Mainmenu 
        } #
    } 
}  
  
Enter-Mainmenu