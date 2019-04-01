$intSleep = 1
$SleepFor = 10

do {
    Start-Sleep -Seconds 60  #1 minutes
    $timer = $intSleep.ToString()
    Write-Host "I have been asleep for $timer Minutes" 
    $intSleep++
} until($intSleep -eq $SleepFor)  