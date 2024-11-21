resource "azurerm_synapse_integration_runtime_azure" "this" {
  name                 = var.name
  synapse_workspace_id = var.synapse_workspace_id
  location             = var.location
  compute_type         = var.compute_type
  core_count           = var.core_count
  description          = var.description
  time_to_live_min     = var.time_to_live_min
}
 
