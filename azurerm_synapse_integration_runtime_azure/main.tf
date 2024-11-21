resource "azurerm_synapse_integration_runtime_azure" "example" {
  name                 = var.name
  synapse_workspace_id = var.synapse_workspace_id
  location             = var.location
}
