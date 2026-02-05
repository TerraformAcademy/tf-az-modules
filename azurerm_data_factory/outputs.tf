output "id" {
  value = azurerm_data_factory.this.id
  description = "The ID of the Data Factory."
}

output "identity" {
  value = azurerm_data_factory.this.identity
  description = "The Managed Identity of the Data Factory."
}