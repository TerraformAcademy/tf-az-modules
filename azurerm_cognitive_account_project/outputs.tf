output "id" {
  description = "The ID of the Cognitive Account Project."
  value       = azurerm_cognitive_account_project.this.id
}

output "default" {
  description = "Whether this Cognitive Account Project is the default project."
  value       = azurerm_cognitive_account_project.this.default
}

output "endpoints" {
  description = "The endpoints map for the Cognitive Account Project."
  value       = azurerm_cognitive_account_project.this.endpoints
}

output "identity" {
  description = "The identity information for the Cognitive Account Project."
  value = {
    type         = try(azurerm_cognitive_account_project.this.identity[0].type, null)
    principal_id = try(azurerm_cognitive_account_project.this.identity[0].principal_id, null)
    tenant_id    = try(azurerm_cognitive_account_project.this.identity[0].tenant_id, null)
  }
}