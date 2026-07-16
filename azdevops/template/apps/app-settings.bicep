targetScope = 'resourceGroup'

@description('Name of the existing App Service or Function App')
param appName string

@description('Resource group of the existing App Service or Function App')
param appResourceGroupName string

@description('Name of the existing App Service Plan')
param appServicePlanName string

@description('Resource ID of the App Service Plan')
param appServicePlanId string

@description('Azure region for the deployment')
param location string = resourceGroup().location

@description('Tags to apply to the resources')
param tags object = {}

resource appService 'Microsoft.Web/sites@2023-12-01' existing = {
  name: appName
}

// Disable FTP and SCM publish access for the web app
resource ftpPublishingCredentialsPolicy 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  name: 'ftp'
  parent: appService
  properties: {
    allow: false
  }
}

resource scmPublishingCredentialsPolicy 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  name: 'scm'
  parent: appService
  properties: {
    allow: false
  }
}

output ftpPolicyId string = ftpPublishingCredentialsPolicy.id
output scmPolicyId string = scmPublishingCredentialsPolicy.id
