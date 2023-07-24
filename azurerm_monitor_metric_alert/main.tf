terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      required_version = ">= 3.50.0, < 4.0.0"
    }
  }
}

resource "azurerm_monitor_action_group" "this" {
  for_each            = var.action_gorup
  name                = each.value.name
  resource_group_name = var.resource_group_name
  short_name          = each.value.short_name
  enabled             = each.value.enabled
  location            = each.value.location

  dynamic "email_receiver" {
    for_each = each.value.email_receiver
    content {
      name                    = email_receiver.value["name"]
      email_address           = email_receiver.value["email_address"]
      use_common_alert_schema = email_receiver.value["use_common_alert_schema"]
    }
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = toset(var.scopes)

  dynamic "action" {
    for_each = toset(local.action_group_ids)
    content {
      action_group_id = action.key
    }
  }

  dynamic "criteria" {
    for_each = var.criteria
    content {
      metric_namespace  = criteria.value["metric_namespace"]
      metric_name       = criteria.value["metric_name"]
      aggregation       = criteria.value["aggregation"]
      operator          = criteria.value["operator"]
      alert_sensitivity = criteria.value["alert_sensitivity"]

      dynamic "dimension" {
        for_each = criteria.value["dimension"]
        content {
          name     = dimension.value["name"]
          operator = dimension.value["operator"]
          values   = dimension.value["operator"]
        }
      }
    }
  }

  auto_mitigate            = var.auto_mitigate
  description              = var.description
  frequency                = var.frequency
  severity                 = var.severity
  target_resource_type     = var.target_resource_type
  target_resource_location = var.target_resource_location
  window_size              = var.window_size
  tags                     = var.tags
}