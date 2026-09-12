@description('Application Insights resource ID')
param appInsightsResourceId string

@description('Resource group location where the availability test is created')
param location string

@description('Name of the availability test')
param webTestName string

@description('HTTPS URL to monitor')
param requestUrl string

@description('Number of days before SSL certificate expiry at which the test starts failing')
param sslExpiryDays int = 90

// ------------------------------------------------------------
// Application Insights Standard Availability Test
// ------------------------------------------------------------

resource availabilityTest 'Microsoft.Insights/webtests@2022-06-15' = {
  name: webTestName
  location: location
  kind: 'standard'

  tags: {
    // Associates the WebTest with Application Insights
    'hidden-link:${appInsightsResourceId}': 'Resource'
  }

  properties: {
    SyntheticMonitorId: webTestName
    Name: webTestName
    Description: 'Standard Application Insights availability test with SSL certificate expiry monitoring'

    Enabled: true

    // Run every 5 minutes
    Frequency: 300

    // Test timeout in seconds
    Timeout: 120

    Kind: 'standard'

    // Retry failed tests
    RetryEnabled: true

    // Locations from which the endpoint will be tested
    Locations: [
      {
        Id: 'emea-nl-ams-azr'
      }
      {
        Id: 'emea-uk-lon-azr'
      }
    ]

    Request: {
      RequestUrl: requestUrl
      HttpVerb: 'GET'

      // Follow redirects to the final HTTPS endpoint
      FollowRedirects: true

      // Don't parse dependent requests
      ParseDependentRequests: false
    }

    ValidationRules: {
      // Application must return HTTP 200
      ExpectedHttpStatusCode: 200

      // Validate TLS/SSL certificate
      SSLCheck: true

      // Start failing the availability test when certificate
      // has 90 days or less remaining
      SSLCertRemainingLifetimeCheck: sslExpiryDays
    }
  }
}


// ------------------------------------------------------------
// Availability / SSL Expiry Alert
// ------------------------------------------------------------

resource availabilityAlert 'Microsoft.Insights/metricAlerts@2026-01-01' = {
  name: '${webTestName}-alert'
  location: 'global'

  tags: {
    'hidden-link:${appInsightsResourceId}': 'Resource'
    'hidden-link:${availabilityTest.id}': 'Resource'
  }

  properties: {
    description: 'Alerts when the Application Insights availability test fails, including SSL certificate expiry within 90 days.'

    severity: 2
    enabled: true

    // Both resources are required for the WebTest availability criterion
    scopes: [
      availabilityTest.id
      appInsightsResourceId
    ]

    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'

    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria'

      webTestId: availabilityTest.id
      componentId: appInsightsResourceId

      // Alert when 1 or more test locations fail
      failedLocationCount: 1
    }

    actions: [
      {
        actionGroupId: actionGroupResourceId
      }
    ]
  }

  dependsOn: [
    availabilityTest
  ]
}
