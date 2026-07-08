provider "azurerm" {
  features {}
}

# ---------------------------------------------------------------------------
# Data sources — reference pre-existing infrastructure
# ---------------------------------------------------------------------------

data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

# Optional: look up an existing Log Analytics Workspace to enable
# workspace-based Application Insights (recommended for new deployments).
data "azurerm_log_analytics_workspace" "example" {
  name                = var.log_analytics_workspace_name
  resource_group_name = data.azurerm_resource_group.example.name
}

# ---------------------------------------------------------------------------
# Locals — define one or more Application Insights components as a map
# ---------------------------------------------------------------------------

locals {
  application_insights = {
    # Classic (non-workspace) component — for legacy workloads
    classic = {
      name             = "${var.name_prefix}-appinsights-classic"
      application_type = "web"
      workspace_id     = null
      retention_in_days                     = 90
      sampling_percentage                   = 100
      daily_data_cap_in_gb                  = 10
      daily_data_cap_notifications_disabled = false
      disable_ip_masking                    = false
      local_authentication_disabled         = false
      internet_ingestion_enabled            = true
      internet_query_enabled                = true
      force_customer_storage_for_profiler   = false
      identity                              = null
      tags = {
        Environment = var.environment
        Owner       = var.owner
        Mode        = "classic"
        ManagedBy   = "Terraform"
      }
    }

    # Workspace-based component — recommended for new deployments
    workspace_based = {
      name             = "${var.name_prefix}-appinsights-ws"
      application_type = "web"
      workspace_id     = data.azurerm_log_analytics_workspace.example.id
      retention_in_days                     = 90
      sampling_percentage                   = 100
      daily_data_cap_in_gb                  = 10
      daily_data_cap_notifications_disabled = false
      disable_ip_masking                    = false
      local_authentication_disabled         = true
      internet_ingestion_enabled            = true
      internet_query_enabled                = true
      force_customer_storage_for_profiler   = false
      identity = {
        type         = "SystemAssigned"
        identity_ids = null
      }
      tags = {
        Environment = var.environment
        Owner       = var.owner
        Mode        = "workspace-based"
        ManagedBy   = "Terraform"
      }
    }
  }
}

# ---------------------------------------------------------------------------
# Module — azurerm_application_insights
# ---------------------------------------------------------------------------

module "application_insights" {
  source   = "../../azurerm_application_insights"
  for_each = local.application_insights

  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  application_type    = each.value.application_type

  workspace_id = each.value.workspace_id

  daily_data_cap_in_gb                  = each.value.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = each.value.daily_data_cap_notifications_disabled
  retention_in_days                     = each.value.retention_in_days
  sampling_percentage                   = each.value.sampling_percentage

  disable_ip_masking                  = each.value.disable_ip_masking
  local_authentication_disabled       = each.value.local_authentication_disabled
  internet_ingestion_enabled          = each.value.internet_ingestion_enabled
  internet_query_enabled              = each.value.internet_query_enabled
  force_customer_storage_for_profiler = each.value.force_customer_storage_for_profiler

  identity = each.value.identity

  tags = each.value.tags
}
