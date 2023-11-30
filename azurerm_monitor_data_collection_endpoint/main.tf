resource "azurerm_monitor_data_collection_endpoint" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  description                   = var.description
  kind                          = var.kind
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
}