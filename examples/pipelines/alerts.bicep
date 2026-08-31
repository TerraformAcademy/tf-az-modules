BART-alerts-config.bicep

@description('Required, app service plan for')
param appServicePlan string
param appservice string

@allowed([
  'a'
  'p'
])
@description('Required. target environment for the deployment')
param env string

@description('Alert config details')
var alertConfigs = {
a: {
BATR_01_LIB_001: {
AlertName: 'BATR-01-LIB-001 error in SYNC_SEND_ERROR'
Severity: 2
Evaulation Frequecy: 'PT15M'
WindowSize: 'PT15M'
Desc: 'C10023490'
autoMitigate: true
alertCriteria: [
{
operator: 'GreaterThan'
query: 'AppTraces | where Message has "BATR-01-LIB-001"
threshold: 0
timeAggregation: 'Count'
}
]
}

Example for metric alert
SqlFailedConnectionerror: {
AlertName: 'Failed SQL Connections'
Severity: 2
Evaulation Frequecy: 'PT15M'
WindowSize: 'PT15M'
Desc: 'CI0023490'
autoMitigate: true
alertCriteria: [
{
name: 'Criteria 1'
metricName: 'connection_Failed'
operator: 'GreaterThan'
threshold: 0
timeAggregation: 'count'
dimensions: []
}
]
}
