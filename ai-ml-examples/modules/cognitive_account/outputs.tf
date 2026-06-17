output "id" {
  description = "The ID of the Cognitive Account."
  value       = azurerm_cognitive_account.this.id
}

output "endpoint" {
  description = "The endpoint of the Cognitive Account."
  value       = azurerm_cognitive_account.this.endpoint
}
