
targetScope = 'tenant'

extension microsoftGraphV1

@description('Display name of the Entra application.')
param applicationName string

@description('Description of the application.')
param applicationDescription string = ''

@description('AzureADMyOrg for single-tenant applications.')
@allowed([
  'AzureADMyOrg'
  'AzureADMultipleOrgs'
  'AzureADandPersonalMicrosoftAccount'
  'PersonalMicrosoftAccount'
])
param signInAudience string = 'AzureADMyOrg'

resource app 'Microsoft.Graph/applications@v1.0' = {
  displayName: applicationName
  description: applicationDescription
  signInAudience: signInAudience
  uniqueName: guid(applicationName)
}

resource sp 'Microsoft.Graph/servicePrincipals@v1.0' = {
  appId: app.appId
}

output applicationObjectId string = app.id
output clientId string = app.appId
output servicePrincipalObjectId string = sp.id
