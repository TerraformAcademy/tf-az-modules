output "project_ids" {
  description = "Map of Cognitive Account Project IDs created by the example."
  value       = { for key, mod in module.cognitive_account_project : key => mod.id }
}

output "project_endpoints" {
  description = "Map of Cognitive Account Project endpoints created by the example."
  value       = { for key, mod in module.cognitive_account_project : key => mod.endpoints }
}

output "project_identities" {
  description = "Map of managed identity details for each Cognitive Account Project."
  value       = { for key, mod in module.cognitive_account_project : key => mod.identity }
}
