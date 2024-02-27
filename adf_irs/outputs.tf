output "ir_azure" {
  value = azurerm_data_factory_integration_runtime_azure.this
}

output "ir_self_hosted" {
  value = azurerm_data_factory_integration_runtime_self_hosted.this
}

output "ir_ssis" {
  value = azurerm_data_factory_integration_runtime_azure_ssis.this
}