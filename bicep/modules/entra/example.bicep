param applicationName string
param applicationDescription string = ''
param signInAudience string = 'AzureADMyOrg'

module spnModule './modules/create-spn.bicep' = {
  name: 'createEntraSpn'
  params: {
    applicationName: applicationName
    applicationDescription: applicationDescription
    signInAudience: signInAudience
  }
}

output applicationObjectId string = spnModule.outputs.applicationObjectId
output clientId string = spnModule.outputs.clientId
output servicePrincipalObjectId string = spnModule.outputs.servicePrincipalObjectId
