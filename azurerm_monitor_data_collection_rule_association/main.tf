resource "azurerm_monitor_data_collection_rule_association" "this" {
  target_resource_id = var.target_resource_id
  name = var.name
  description = var.description
  data_collection_endpoint_id = var.data_collection_endpoint_id
  data_collection_rule_id = var.data_collection_rule_id
}