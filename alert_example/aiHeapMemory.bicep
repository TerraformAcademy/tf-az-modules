resource heapMemoryAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'heap-memory-usage-alert'
  location: 'global'
  properties: {
    description: 'Alert when Heap Memory Usage exceeds threshold'
    severity: 3
    enabled: true
    scopes: [
      appInsightsResourceId
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    targetResourceType: 'microsoft.insights/components'   // must match scope's resource type exactly
    targetResourceRegion: appInsightsLocation              // actual region of the App Insights resource, NOT 'global'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          criterionType: 'StaticThresholdCriterion'
          name: 'HeapMemoryUsage'
          metricName: 'Heap Memory Usage (MB)'
          metricNamespace: 'Azure.ApplicationInsights'
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Average'
          skipMetricValidation: true
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroupResourceId
      }
    ]
  }
}
