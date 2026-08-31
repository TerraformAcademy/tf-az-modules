// targetScope = 'subscription'

@description('Environment being deployed')
param environment string

@description('Array containing alert configurations')
param alerts array

@description('Common tags applied to all alert resources')
param tags object = {}

module monitorAlerts '../modules/metric-alert.bicep' = [
  for alert in alerts: {
    name: '${environment}-${alert.name}'
    params: {
      alert: alert
      tags: tags
    }
  }
]
