[CmdletBinding()]
param(
    [string]$InstrumentationKey,
    [string]$EventName,
    [switch]$SendPipelineMetadata
)

if ( $PSVersionTable.PSEdition -eq "Core" ) {
    Add-Type -Path "$PSScriptRoot\netstandard2.0\Microsoft.ApplicationInsights.AspNetCore.dll"
}
else {
    Add-Type -Path "$PSScriptRoot\net46\Microsoft.ApplicationInsights.dll"
}

$TelemetryClient = $null
$TelemetryClient = New-Object -TypeName Microsoft.ApplicationInsights.TelemetryClient
$CustomProperties = New-Object 'System.Collections.Generic.Dictionary[string,string]'
if ( $SendPipelineMetadata ) {
    if (![String]::IsNullOrEmpty($env:BUILD_BUILDNUMBER)) { $CustomProperties.Add('BuildNumber', $env:BUILD_BUILDNUMBER) }
    if (![String]::IsNullOrEmpty($env:BUILD_BUILDID)) { $CustomProperties.Add('BuildId', $env:BUILD_BUILDID) }
    if (![String]::IsNullOrEmpty($env:BUILD_DEFINITIONNAME)) { $CustomProperties.Add('BuildDefinitionName', $env:BUILD_DEFINITIONNAME) }
    if (![String]::IsNullOrEmpty($env:BUILD_SOURCEBRANCH)) { $CustomProperties.Add('BuildSourceBranch', $env:BUILD_SOURCEBRANCH) }
    if (![String]::IsNullOrEmpty($env:BUILD_REPOSITORY_NAME)) { $CustomProperties.Add('BuildRepositoryName', $env:BUILD_REPOSITORY_NAME) }
    if (![String]::IsNullOrEmpty($env:RELEASE_RELEASENAME)) { $CustomProperties.Add('ReleaseName', $env:RELEASE_RELEASENAME) }
    if (![String]::IsNullOrEmpty($env:RELEASE_RELEASEID)) { $CustomProperties.Add('ReleaseId', $env:RELEASE_RELEASEID) }
    if (![String]::IsNullOrEmpty($env:RELEASE_RELEASEDESCRIPTION)) { $CustomProperties.Add('ReleaseDescription', $env:RELEASE_RELEASEDESCRIPTION) }
    if (![String]::IsNullOrEmpty($env:RELEASE_DEFINITIONNAME)) { $CustomProperties.Add('ReleaseDefinitionName', $env:RELEASE_DEFINITIONNAME) }
    if (![String]::IsNullOrEmpty($env:RELEASE_ENVIRONMENTNAME)) { $CustomProperties.Add('ReleaseEnvironmentName', $env:RELEASE_ENVIRONMENTNAME) }
}
try {	
    $TelemetryClient.InstrumentationKey = $InstrumentationKey
    $TelemetryClient.TrackEvent($EventName, $CustomProperties)
    Write-Host "Sending custom event to Application Insights..."
    $TelemetryClient.Flush()
    Write-Host "Event send."
}
catch {
    Write-Error "Exception while logging into Application Insights: $($_.Exception.Message)"
}  
