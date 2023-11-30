output "id" {
  value = azurerm_monitor_data_collection_rule.this.id
  description = "The ID of the Data Collection Rule."
}

output "immutable_id" {
  value = azurerm_monitor_data_collection_rule.this.immutable_id
  description = "The immutable ID of the Data Collection Rule."
}

output "identity" {
    value = azurerm_monitor_data_collection_rule.this.identity
    description = "The Principal ID associated with this Managed Service Identity."
}