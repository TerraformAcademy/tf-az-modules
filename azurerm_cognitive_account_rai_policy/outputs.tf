output "id" {
  description = "The ID of the RAI Policy."
  value       = azurerm_cognitive_account_rai_policy.this.id
}

output "name" {
  description = "The name of the RAI Policy."
  value       = azurerm_cognitive_account_rai_policy.this.name
}

output "description" {
  description = "The description of the RAI Policy."
  value       = try(azurerm_cognitive_account_rai_policy.this.description, null)
}
