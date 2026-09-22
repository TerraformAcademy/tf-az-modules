// example of calling module

module kvrolerbac '../modules/rbac/deploy.bicep' = {
name: 'rssdatarole-${utc)'
params: {
roleAssignments: [
{
  principalld: rssappservice.outputs.appService.identity.principalId
  principalType: 'ServicePrincipal'
  roleDefinitionId: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
  resourceId: '/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.KeyVault/vaults/${keyvault.outputs.keyVault.name}'
}
{
  principalld: rssappservice.outputs.appService2.identity.principalId
  principalType: 'ServicePrincipal'
  roleDefinitionId: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
  resourceId: '/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Storage/storageAccounts/${storageAccount.outputs.storageAccount.name}'
}
]
} 
}
