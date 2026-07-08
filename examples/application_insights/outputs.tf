output "application_insights_ids" {
  description = "Map of Application Insights component IDs created by the example."
  value       = { for key, mod in module.application_insights : key => mod.id }
}

output "application_insights_app_ids" {
  description = "Map of Application Insights App IDs created by the example."
  value       = { for key, mod in module.application_insights : key => mod.app_id }
}

output "application_insights_instrumentation_keys" {
  description = "Map of Application Insights instrumentation keys created by the example."
  value       = { for key, mod in module.application_insights : key => mod.instrumentation_key }
  sensitive   = true
}

output "application_insights_connection_strings" {
  description = "Map of Application Insights connection strings created by the example."
  value       = { for key, mod in module.application_insights : key => mod.connection_string }
  sensitive   = true
}
