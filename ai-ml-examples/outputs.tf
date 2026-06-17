output "cognitive_account_ids" {
  description = "Map of managed Cognitive Account IDs created by the example."
  value       = { for key, module in module.cognitive_account : key => module.id }
}

output "cognitive_account_endpoints" {
  description = "Map of Cognitive Account endpoints created by the example."
  value       = { for key, module in module.cognitive_account : key => module.endpoint }
}
