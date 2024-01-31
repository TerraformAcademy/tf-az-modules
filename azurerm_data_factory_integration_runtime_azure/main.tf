resource "azurerm_data_factory_integration_runtime_azure" "this" {
  name                    = var.name
  data_factory_id         = var.data_factory_id
  location                = var.location
  description             = var.description
  cleanup_enabled         = var.cleanup_enabled
  compute_type            = var.compute_type
  core_count              = var.core_count
  time_to_live_min        = var.time_to_live_min
  virtual_network_enabled = var.virtual_network_enabled
}