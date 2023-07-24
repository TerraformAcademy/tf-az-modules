output "id" {
  description = "The ID of the Authorization Rule."
  value       = azurerm_notification_hub_authorization_rule.this.id

}

output "primary_access_key" {
  description = "The Primary Access Key associated with this Authorization Rule."
  value       = azurerm_notification_hub_authorization_rule.this.primary_access_key
  sensitive   = true

}

output "secondary_access_key" {
  description = "The Secondary Access Key associated with this Authorization Rule."
  value       = azurerm_notification_hub_authorization_rule.this.secondary_access_key
  sensitive   = true
}