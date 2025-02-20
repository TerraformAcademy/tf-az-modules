output "id" {
  description = "Synapse ID"
  value       = azurerm_synapse_workspace.synapse.id
}

output "name" {
  description = "Synapse name"
  value       = azurerm_synapse_workspace.synapse.name
}

output "connectivity_endpoints" {
  description = "A list of connectivity endpoints for this Synapse Workspace."
  value       = azurerm_synapse_workspace.synapse.connectivity_endpoints
}
