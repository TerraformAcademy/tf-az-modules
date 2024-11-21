resource "azurerm_synapse_workspace" "synapse" {
  name                                 = var.name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = var.storage_data_lake_gen2_filesystem_id
  sql_administrator_login              = var.sql_administrator_login
  sql_administrator_login_password     = var.sql_administrator_password
  public_network_access_enabled        = var.saas_connection
  managed_virtual_network_enabled      = true
  linking_allowed_for_aad_tenant_ids   = var.linking_allowed_for_aad_tenant_ids
  compute_subnet_id                    = var.compute_subnet_id
  data_exfiltration_protection_enabled = var.data_exfiltration_protection_enabled
  purview_id                           = var.purview_id
  sql_identity_control_enabled         = var.sql_identity_control_enabled
  managed_resource_group_name          = var.managed_resource_group_name

  aad_admin = [var.aad_admin]
  dynamic "azure_devops_repo" {
    for_each = toset(var.azure_devops_configuration == null ? [] : [var.azure_devops_configuration])
    content {
      account_name    = azure_devops_repo.value.account_name
      branch_name     = azure_devops_repo.value.branch_name
      last_commit_id  = try(azure_devops_repo.value.last_commit_id, null)
      project_name    = azure_devops_repo.value.project_name
      repository_name = azure_devops_repo.value.repository_name
      root_folder     = azure_devops_repo.value.root_folder
      tenant_id       = azure_devops_repo.value.tenant_id
    }
  }

  identity {
    type = "SystemAssigned"
  }

  dynamic "customer_managed_key" {
    for_each = toset(var.customer_managed_key == null ? [] : [var.customer_managed_key])
    content {
      key_versionless_id = customer_managed_key.value.key_versionless_id
      key_name           = try(customer_managed_key.value.key_name, null)
    }
  }

  tags = var.tags
}
