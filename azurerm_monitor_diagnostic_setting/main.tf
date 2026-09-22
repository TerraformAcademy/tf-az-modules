terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      #version = ">= 4.11 < 5.0"
    }
  }
  required_version = ">= 1.1.0"
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                           = var.name
  target_resource_id             = var.target_resource_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  storage_account_id             = var.storage_account_id
  log_analytics_destination_type = var.log_analytics_destination_type
  partner_solution_id            = var.partner_solution_id

  dynamic "enabled_log" {
    for_each = var.enabled_log
    content {
      category       = enabled_log.value.category
      category_group = enabled_log.value.category_group
    }
  }

  dynamic "enabled_metric" {
    for_each = var.enabled_metric
    content {
      category = enabled_metric.value.category
    }
  }
}