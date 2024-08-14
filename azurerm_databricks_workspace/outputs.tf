output "id" {
  value       = azurerm_databricks_workspace.this.id
  description = "The ID of the Databricks Workspace in the Azure management plane."
}

output "disk_encryption_set_id" {
  value       = azurerm_databricks_workspace.this.disk_encryption_set_id
  description = "The ID of Managed Disk Encryption Set created by the Databricks Workspace."
}

output "managed_disk_identity" {
  value       = azurerm_databricks_workspace.this.managed_disk_identity
  description = "A managed_disk_identity block"
}

output "managed_resource_group_id" {
  value       = azurerm_databricks_workspace.this.managed_resource_group_id
  description = "The ID of the Managed Resource Group created by the Databricks Workspace."
}

output "workspace_url" {
  value       = azurerm_databricks_workspace.this.workspace_url
  description = "The workspace URL which is of the format 'adb-{workspaceId}.{random}.azuredatabricks.net'"
}

output "workspace_id" {
  value       = azurerm_databricks_workspace.this.workspace_id
  description = "The unique identifier of the databricks workspace in Databricks control plane."
}

output "storage_account_identity" {
  value       = azurerm_databricks_workspace.this.storage_account_identity
  description = "A storage_account_identity block."
}