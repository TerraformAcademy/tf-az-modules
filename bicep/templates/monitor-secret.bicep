
@description('Logic App name')
param logicAppName string = 'la-entra-secret-monitor'

param location string = resourceGroup().location

param expiryThresholdDays int = 30

param senderMailbox string

param alertRecipient string

//User Assigned Managed Identity
resource logicAppIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: 'id-entra-secret-monitor'
}

// Workflow definition from JSON
var workflowDefinition = loadJsonContent(
  'workflow.json'
)
// Deploy reusable Logic App module
module logicApp '../modules/logic-app.bicep' = {
  name: 'deploy-${logicAppName}'
  params: {
    name: logicAppName
    location: location

    definition: workflowDefinition

    workflowParameters: {
      expiryThresholdDays: {
        value: expiryThresholdDays
      }
      senderMailbox: {
        value: senderMailbox
      }
      alertRecipient: {
        value: alertRecipient
      }
      managedIdentityResourceId: {
        value: logicAppIdentity.id
      }
    }

    userAssignedIdentities: {
      '${logicAppIdentity.id}': {}
    }

    state: 'Enabled'

    tags: {
      workload: 'entra-secret-monitor'
      environment: 'production'
      managedBy: 'bicep'
    }
  }
}

output logicAppId string = logicApp.outputs.logicAppId
output managedIdentityPrincipalId string = logicAppIdentity.properties.principalId
