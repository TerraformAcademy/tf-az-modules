output "id" {
  value       = azurerm_service_plan.this.id
  description = "The ID of the Service Plan."
}

output "kind" {
  value       = azurerm_service_plan.this.kind
  description = "A string representing the Kind of Service Plan."
}

output "reserved" {
  value       = azurerm_service_plan.this.reserved
  description = "Whether this is a reserved Service Plan Type. true if os_type is Linux, otherwise false."
}