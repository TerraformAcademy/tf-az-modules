output "search_service_id" {
  description = "The ID of the Search Service."
  value       = azurerm_search_service.search.id
}

output "customer_managed_key_encryption_compliance_status" {
  description = "Describes whether the search service is compliant or not with respect to having non-customer encrypted resources. If a service has more than one non-customer encrypted resource and Enforcement is enabled then the service will be marked as NonCompliant. If all the resources are customer encrypted, then the service will be marked as Compliant."
  value       = azurerm_search_service.search.customer_managed_key_enforcement_enabled
}

output "endpoint" {
  description = "The endpoint of the Search Service."
  value       = azurerm_search_service.search.endpoint
}

output "primary_key" {
  description = "The primary access key for the Search Service."
  value       = azurerm_search_service.search.primary_key
}

output "query_keys" {
  description = "(Optional) Specifies the query keys for the Search Service."
  value       = azurerm_search_service.search.query_keys
}

output "secondary_key" {
  description = "The secondary access key for the Search Service."
  value       = azurerm_search_service.search.secondary_key
}

output "identity" {
  description = "The identity of the Search Service."
  value       = azurerm_search_service.search.identity
}