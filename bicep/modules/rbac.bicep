// now the deployment object can be created. It will contain a resource for each individual RBAC

resource DeployRBAC 'Microsoft.Resources/deployments@2022-09-01' = if (length(expandedInput) > 0) {

name: 'DeployRBAC'

properties: {
mode: 'Incremental'
template: {
'$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
contentVersion: '1.0.0.0'
resources: union(
map (resourceScopedInput, item => {
type: 'Microsoft.Authorization/roleAssignments'
apiVersion: ' 2022-04-01'
scope: item.resourceId
name: guid(resourceGroup().id, item.resourceId, item.principalId, item.roleDefinitionId)
properties: {
roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', item.roleDefinitionId)
principalld: item.principalId
principalType: item.principalType
}
}),
map(resourceGroupScopedInput, item => {
type: 'Microsoft.Authorization/roleAssignments'
apiVersion: '2022-04-01'
name: guid(resourceGroup().id, item.principalId, item.roleDefinitionId)
properties: {
roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', item.roleDefinitionId)
principalId: item.principalId
principalType: item.principalType
}
})
)
}
}
