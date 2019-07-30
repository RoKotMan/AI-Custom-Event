[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation
try {
    Import-Module $PSScriptRoot\ps_modules\VstsTaskSdk
    # Import the localized strings.
    Import-VstsLocStrings "$PSScriptRoot\task.json"

    $InstrumentationKey = Get-VstsInput -Name InstrumentationKey -Require
    $EventName = Get-VstsInput -Name EventName -Require
    $SendPipelineMetadata = [System.Boolean]::Parse((Get-VstsInput -Name SendPipelineMetadata))

    . "$PSScriptRoot\main.ps1" -InstrumentationKey $InstrumentationKey -EventName $EventName -SendPipelineMetadata:$SendPipelineMetadata

}
finally {
    Trace-VstsLeavingInvocation $MyInvocation
}