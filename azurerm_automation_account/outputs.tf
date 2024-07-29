output "id`" {
  value = azurerm_automation_account.this.id
}

output "dsc_server_endpoint" {
  value = azurerm_automation_account.this.dsc_server_endpoint
}

output "dsc_primary_access_key" {
  value = azurerm_automation_account.this.dsc_primary_access_key
}

output "dsc_secondary_access_key" {
  value = azurerm_automation_account.this.dsc_secondary_access_key
}

output "hybrid_service_url" {
  value = azurerm_automation_account.this.hybrid_service_url
}