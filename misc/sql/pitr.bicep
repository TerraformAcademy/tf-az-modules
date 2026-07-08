targetScope = 'resourceGroup'

// ---------------------------------------------------------------------------
// Parent resource references
// ---------------------------------------------------------------------------

@description('Name of the existing SQL Server')
param serverName string

@description('Name of the existing SQL Database on the server')
param databaseName string

// ---------------------------------------------------------------------------
// Policy properties
// ---------------------------------------------------------------------------

@description('''
The backup retention period in days.
Controls how many days Point-in-Time Restore (PITR) is supported.
Valid range: 1–35 days.
''')
@minValue(1)
@maxValue(35)
param retentionDays int = 7

@description('''
The differential backup interval in hours.
Controls how frequently differential backups are taken.
Only applicable to live databases (not dropped databases).
Allowed values: 12 or 24 hours.
''')
@allowed([
  12
  24
])
param diffBackupIntervalInHours int = 12

// ---------------------------------------------------------------------------
// Parent resource lookups (existing)
// ---------------------------------------------------------------------------

resource sqlServer 'Microsoft.Sql/servers@2025-01-01' existing = {
  name: serverName
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2025-01-01' existing = {
  name: databaseName
  parent: sqlServer
}

// ---------------------------------------------------------------------------
// Backup Short-Term Retention Policy
// ---------------------------------------------------------------------------

resource backupShortTermRetentionPolicy 'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies@2025-01-01' = {
  // The name must always be 'default' – this is the only policy name supported by the API.
  name: 'default'
  parent: sqlDatabase
  properties: {
    retentionDays: retentionDays
    diffBackupIntervalInHours: diffBackupIntervalInHours
  }
}

// ---------------------------------------------------------------------------
// Outputs
// ---------------------------------------------------------------------------

@description('Resource ID of the backup short-term retention policy')
output id string = backupShortTermRetentionPolicy.id

@description('Name of the backup short-term retention policy (always "default")')
output name string = backupShortTermRetentionPolicy.name

@description('Configured retention period in days')
output retentionDays int = backupShortTermRetentionPolicy.properties.retentionDays

@description('Configured differential backup interval in hours')
output diffBackupIntervalInHours int = backupShortTermRetentionPolicy.properties.diffBackupIntervalInHours
