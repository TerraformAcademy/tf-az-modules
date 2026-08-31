using 'main.bicep'

param environment = 'dev'

param tags = {
  Environment: 'dev'
  ManagedBy: 'Bicep'
  Application: 'batr'
}

param alerts = [
  {
    name: 'db-storage-utilization'
    type: 'metric'

    description: 'Alert when database storage utilization exceeds threshold'
    severity: 2
    enabled: true

    scopes: [
      '/subscriptions/xxxxxxxx/resourceGroups/batr-dev-rg/providers/Microsoft.Sql/servers/batr-dev-sql/databases/batr-dev-db'
    ]

    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'

    criteria: {
      name: 'DbStorageUtilization'
      metricName: 'dbStorageUtilization'
      metricNamespace: 'Microsoft.Sql/servers/databases'
      operator: 'GreaterThan'
      threshold: 80
      timeAggregation: 'Average'
    }

    autoMitigate: true

    actions: [
      {
        actionGroupId: '/subscriptions/xxxxxxxx/resourceGroups/batr-dev-monitoring-rg/providers/Microsoft.Insights/actionGroups/batr-dev-alerts'
      }
    ]
  }

  {
    name: 'keyvault-object-created'
    type: 'log'

    displayName: 'Key Vault Object Created'
    description: 'Detect creation of objects in Key Vault'
    severity: 2
    enabled: true

    location: 'centralindia'

    scopes: [
      '/subscriptions/xxxxxxxx/resourceGroups/batr-dev-rg/providers/Microsoft.OperationalInsights/workspaces/batr-dev-law'
    ]

    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'

    query: '''
      AzureActivity
      | where ResourceProviderValue == "MICROSOFT.KEYVAULT"
      | where OperationNameValue contains "create"
    '''

    timeAggregation: 'Count'
    operator: 'GreaterThan'
    threshold: 0

    failingPeriods: {
      numberOfEvaluationPeriods: 1
      minFailingPeriodsToAlert: 1
    }

    autoMitigate: true

    actionGroups: [
      '/subscriptions/xxxxxxxx/resourceGroups/batr-dev-monitoring-rg/providers/Microsoft.Insights/actionGroups/batr-dev-alerts'
    ]

    customProperties: {}
  }
]
