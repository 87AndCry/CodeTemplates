
$FallBackScriptPath = "C:\Script"

try {
    $ScriptPath = Split-Path $SCRIPT:MyInvocation.MyCommand.Path -parent
}
catch {
    $ScriptPath = $FallBackScriptPath
}

$ScriptPath