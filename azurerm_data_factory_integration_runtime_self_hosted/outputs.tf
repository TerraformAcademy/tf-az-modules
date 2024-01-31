output "id" {
  value       = azurerm_data_factory_integration_runtime_self_hosted.this.id
  description = "The ID of the Data Factory."
}

output "primary_authorization_key" {
  value       = azurerm_data_factory_integration_runtime_self_hosted.this.primary_authorization_key
  description = "The primary integration runtime authentication key."
}

output "secondary_authorization_key" {
  value       = azurerm_data_factory_integration_runtime_self_hosted.this.secondary_authorization_key
  description = "The secondary integration runtime authentication key."
}