resource "azurerm_databricks_workspace_root_dbfs_customer_managed_key" "this" {
  workspace_id = var.workspace_id
  key_vault_key_id = var.key_vault_key_id
  key_vault_id = var.key_vault_id
}