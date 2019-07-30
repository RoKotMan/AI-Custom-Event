## AI Custom Event

The Application Insights Custom Event extension uses [Microsoft.ApplicationInsights](https://www.nuget.org/packages/Microsoft.ApplicationInsights/) and [Microsoft.ApplicationInsights.AspNetCore](https://www.nuget.org/packages/Microsoft.ApplicationInsights.AspNetCore/) to send a custom event to Azure Application Insight.

If you need to track releases in Application Insights see this extension: [Release Annotations for Azure Application Insights](https://marketplace.visualstudio.com/items?itemName=ms-appinsights.appinsightsreleaseannotations)

### Parameters

* InstrumentationKey - The instrumentation key links your telemetry to the resource. [See more.](https://docs.microsoft.com/en-us/azure/azure-monitor/app/create-new-resource)
* Event Name - Event name property
* Send pipeline metadata - Will be send build/release predefined variables as Custom Properties:
  * BUILD_BUILDNUMBER
  * BUILD_BUILDID
  * BUILD_DEFINITIONNAME
  * BUILD_SOURCEBRANCH
  * BUILD_REPOSITORY_NAME
  * RELEASE_RELEASENAME
  * RELEASE_RELEASEID
  * RELEASE_RELEASEDESCRIPTION
  * RELEASE_DEFINITIONNAME
  * RELEASE_ENVIRONMENTNAME

![Parameters](/screenshots/screen1.jpg)

### Explore events
* [Exploring Metrics in Application Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/app/metrics-explorer)

![Explore events](/screenshots/screen2.jpg)

#### Quick steps to get started
1. Add the 'AI Custom Event' custom task to the build or release definition.
2. Enter the required information.
3. Save the definition.
4. Queue a new build or create a new release.

### Learn More

The [source](https://github.com/RoKotMan/AI-Custom-Event) of this extension is available.
