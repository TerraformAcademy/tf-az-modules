
@description('Name of the Logic App')
param name string

@description('Azure region')
param location string = resourceGroup().location

@description('Logic App workflow definition')
param definition object = {} // defaults to null 

@description('Workflow parameter values')
param workflowParameters object = {}

@description('User assigned managed identities')
param userAssignedIdentities object

@description('Logic App state')
@allowed([
  'Enabled'
  'Disabled'
])
param state string = 'Enabled'

@description('Resource tags')
param tags object = {}

resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: name
  location: location
  tags: tags

  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: userAssignedIdentities
  }

  properties: {
    state: state
    definition: definition
    parameters: workflowParameters
  }
}

output logicAppId string = logicApp.id
output logicAppName string = logicApp.name
output identity object = logicApp.identity
