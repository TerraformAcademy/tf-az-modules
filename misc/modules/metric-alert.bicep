@description('Alert configuration object')
param alert object

@description('Common tags to apply to the alert')
param tags object = {}

resource alertRule 'Microsoft.Insights/metricAlerts@2018-03-01' = if (alert.type == 'metric') {
  name: alert.name
  location: 'global'
  tags: tags
  properties: {
    description: alert.description
    severity: alert.severity
    enabled: alert.enabled
    scopes: alert.scopes
    evaluationFrequency: alert.evaluationFrequency
    windowSize: alert.windowSize
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          criterionType: 'StaticThresholdCriterion'
          name: alert.criteria.name
          metricName: alert.criteria.metricName
          metricNamespace: alert.criteria.metricNamespace
          operator: alert.criteria.operator
          threshold: alert.criteria.threshold
          timeAggregation: alert.criteria.timeAggregation
        }
      ]
    }
    autoMitigate: alert.autoMitigate
    actions: alert.actions
  }
}

resource scheduledQueryRule 'Microsoft.Insights/scheduledQueryRules@2023-12-01' = if (alert.type == 'log') {
  name: alert.name
  location: alert.location
  tags: tags
  properties: {
    displayName: alert.displayName
    description: alert.description
    severity: alert.severity
    enabled: alert.enabled
    evaluationFrequency: alert.evaluationFrequency
    windowSize: alert.windowSize

    scopes: alert.scopes

    criteria: {
      allOf: [
        {
          query: alert.query
          timeAggregation: alert.timeAggregation
          operator: alert.operator
          threshold: alert.threshold
          failingPeriods: {
            numberOfEvaluationPeriods: alert.failingPeriods.numberOfEvaluationPeriods
            minFailingPeriodsToAlert: alert.failingPeriods.minFailingPeriodsToAlert
          }
        }
      ]
    }

    autoMitigate: alert.autoMitigate

    actions: {
      actionGroups: alert.actionGroups
      customProperties: alert.customProperties
    }
  }
}
