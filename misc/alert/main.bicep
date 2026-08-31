param alerts array

module metricAlerts './modules/metric-alert.bicep' = [
  for alert in alerts: {
    name: alert.name
    params: {
      alert: alert
    }
  }
]
