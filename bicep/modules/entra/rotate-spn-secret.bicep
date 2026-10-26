
targetScope = 'resourceGroup'

@description('Application object ID, not the client ID.')
param applicationObjectId string

@description('Resource ID of the pre-authorized user-assigned managed identity.')
param identityResourceId string 

@description('Client ID of the user-assigned managed identity.')
param identityClientId string

@description('Name of the existing Key Vault.')
param keyVaultName string

@description('Name under which the new secret will be stored.')
param keyVaultSecretName string

@description('UTC expiry timestamp, e.g. 2027-10-22T00:00:00Z.')
param secretExpiryDateTime string

@description('Change this value to deliberately trigger another rotation.')
param rotationTrigger string

@description('Label for the new credential.')
param credentialDisplayName string = 'Automated rotation'

resource rotateSecret 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  name: 'rotateEntraSpnSecret'
  location: resourceGroup().location
  kind: 'AzureCLI'

  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identityResourceId}': {}
    }
  }

  properties: {
    azCliVersion: '2.67.0'
    timeout: 'PT15M'
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
    forceUpdateTag: rotationTrigger

    environmentVariables: [
      {
        name: 'IDENTITY_CLIENT_ID'
        value: identityClientId
      }
      {
        name: 'APPLICATION_OBJECT_ID'
        value: applicationObjectId
      }
      {
        name: 'KEY_VAULT_NAME'
        value: keyVaultName
      }
      {
        name: 'SECRET_NAME'
        value: keyVaultSecretName
      }
      {
        name: 'SECRET_EXPIRY'
        value: secretExpiryDateTime
      }
      {
        name: 'CREDENTIAL_DISPLAY_NAME'
        value: credentialDisplayName
      }
    ]

    scriptContent: '''
      set -euo pipefail
      set +x

      az login \
        --identity \
        --client-id "$IDENTITY_CLIENT_ID" \
        --allow-no-subscriptions \
        --output none

      requestBody=$(jq -n \
        --arg displayName "$CREDENTIAL_DISPLAY_NAME" \
        --arg endDateTime "$SECRET_EXPIRY" \
        '{
          passwordCredential: {
            displayName: $displayName,
            endDateTime: $endDateTime
          }
        }')

      response=$(az rest \
        --method POST \
        --url "https://graph.microsoft.com/v1.0/applications/${APPLICATION_OBJECT_ID}/addPassword" \
        --headers "Content-Type=application/json" \
        --body "$requestBody")

      secretValue=$(jq -er '.secretText' <<< "$response")
      keyId=$(jq -er '.keyId' <<< "$response")

      # Write the credential directly to Key Vault.
      # Do not echo the secret value.
      az keyvault secret set \
        --vault-name "$KEY_VAULT_NAME" \
        --name "$SECRET_NAME" \
        --value "$secretValue" \
        --output none

      unset secretValue response requestBody

      echo "Secret rotation completed successfully."
      echo "Credential key ID: $keyId"
      echo "Key Vault secret: $SECRET_NAME"
    '''
  }
}

output rotationDeploymentScriptName string = rotateSecret.name
