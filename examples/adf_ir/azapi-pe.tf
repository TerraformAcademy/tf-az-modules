data "azapi_resource" "storage_account_private_endpoint_connection" {
  type                   = "Microsoft.Storage/storageAccounts@2022-09-01"
  resource_id            = var.target_id
  response_export_values = ["properties.privateEndpointConnections."]

  depends_on = [
    azurerm_data_factory_managed_private_endpoint.this,
  ]
}

locals {

  ## Extract private endpoint connection names
  ### This is done by looking at data.azapi_resource.batch_storage_account_private_endpoint_connection and picking the connection name.
  ### The name of the managed private endpoint is at the end of the description field. This can be used to pick the correct private endpoint connection.
  ### After the approval is done, the description fields changes to whatever we configure in azapi_update_resource.approve_batch_storage_account_*_private_endpoint_connection.
  ### It is important that the logic in the for loop below and the content of the description fields matches to make the Terraform configuration work.

  ## Blob
  storage_account_blob_private_endpoint_connection_name = one([
    for connection in jsondecode(data.azapi_resource.storage_account_private_endpoint_connection.output).properties.privateEndpointConnections
    : connection.name
    if
    endswith(connection.properties.privateLinkServiceConnectionState.description, azurerm_data_factory_managed_private_endpoint.this.name)
  ])

}

## Do the actual approval for each of the connections
### Blob
resource "azapi_update_resource" "approve_batch_storage_account_blob_private_endpoint_connection" {
  type      = "Microsoft.Storage/storageAccounts/privateEndpointConnections@2022-09-01"
  name      = local.storage_account_blob_private_endpoint_connection_name
  parent_id = var.target_id

  body = jsonencode({
    properties = {
      privateLinkServiceConnectionState = {
        description = "Approved via Terraform - ${azurerm_data_factory_managed_private_endpoint.this.name}" # To identify which managed private endpoint this connection belongs to we add the managed private endpoint name to the description
        status      = "Approved"
      }
    }
  })

  lifecycle {
    ignore_changes = all # We don't want to touch this after creation
  }
}