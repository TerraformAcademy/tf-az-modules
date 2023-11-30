output "id" {
  value       = azurerm_monitor_data_collection_endpoint.this.id
  description = "The ID of the Data Collection Endpoint."
}

output "configuration_access_endpoint" {
  value       = azurerm_monitor_data_collection_endpoint.this.configuration_access_endpoint
  description = "The endpoint used for accessing configuration, e.g., https://mydce-abcd.eastus-1.control.monitor.azure.com."
}

output "logs_ingestion_endpoint" {
  value       = azurerm_monitor_data_collection_endpoint.this.logs_ingestion_endpoint
  description = "The endpoint used for ingesting logs, e.g., https://mydce-abcd.eastus-1.ingest.monitor.azure.com."
}