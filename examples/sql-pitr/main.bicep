targetScope = 'resourceGroup'

@description('Name of the existing SQL server')
param serverName string = 'my-sql-server'

@description('Name of the existing SQL database')
param databaseName string = 'my-database'

@description('The backup retention period in days. Valid range: 1-35.')
param retentionDays int = 15

@description('The differential backup interval in hours. Allowed values: 12 or 24.')
@allowed([
  12
  24
])
param diffBackupIntervalInHours int = 12

module pitrPolicy '../../misc/sql/pitr.bicep' = {
  name: 'pitrPolicy'
  params: {
    serverName: serverName
    databaseName: databaseName
    retentionDays: retentionDays
    diffBackupIntervalInHours: diffBackupIntervalInHours
  }
}

output policyId string = pitrPolicy.outputs.id
output policyName string = pitrPolicy.outputs.name
output configuredRetentionDays int = pitrPolicy.outputs.retentionDays
output configuredDiffBackupIntervalInHours int? = pitrPolicy.outputs.diffBackupIntervalInHours!
