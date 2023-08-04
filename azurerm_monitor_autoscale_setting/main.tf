resource "azurerm_monitor_autoscale_setting" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = var.target_resource_id
  enabled             = var.enabled

  dynamic "profile" {
    for_each = var.profile
    content {
      name = profile.value["name"]
      dynamic "capacity" {
        for_each = profile.value["capacity"]
        content {
          default = capacity.value["default"]
          maximum = capacity.value["maximum"]
          minimum = capacity.value["minimum"]
        }
      }
      dynamic "rule" {
        for_each = profile.value["rule"]
        content {
          dynamic "metric_trigger" {
            for_each = rule.value["metric_trigger"]
            content {
              metric_name        = metric_trigger.value["metric_name"]
              metric_namespace   = metric_trigger.value["metric_namespace"]
              operator           = metric_trigger.value["operator"]
              statistic          = metric_trigger.value["statistic"]
              time_aggregation   = metric_trigger.value["time_aggregation"]
              time_grain         = metric_trigger.value["time_grain"]
              time_window        = metric_trigger.value["time_window"]
              threshold          = metric_trigger.value["threshold"]
              metric_resource_id = metric_trigger.value["metric_resource_id"]

              dynamic "dimensions" {
                for_each = metric_trigger.value["dimensions"]
                content {
                  name     = dimensions.value["name"]
                  operator = dimensions.value["operator"]
                  values   = dimensions.value["values"]
                }
              }

              divide_by_instance_count = metric_trigger.value["divide_by_instance_count"]
            }
          }
          dynamic "scale_action" {
            for_each = rule.value["scale_action"]
            content {
              cooldown  = scale_action.value["cooldown"]
              direction = scale_action.value["direction"]
              type      = scale_action.value["type"]
              value     = scale_action.value["value"]
            }
          }
        }
      }

      dynamic "fixed_date" {
        for_each = profile.value["fixed_date"]
        content {
          end      = fixed_date.value["end"]
          start    = fixed_date.value["start"]
          timezone = fixed_date.value["timezone"]
        }
      }

      dynamic "recurrence" {
        for_each = profile.value["recurrence"]
        content {
          timezone = recurrence.value["timezone"]
          days     = recurrence.value["days"]
          hours    = recurrence.value["hours"]
          minutes  = recurrence.value["minutes"]
        }
      }
    }
  }

  dynamic "notification" {
    for_each = var.notification
    content {
      dynamic "email" {
        for_each = notification.value["email"]
        content {
          send_to_subscription_administrator    = email.value["send_to_subscription_administrator"]
          send_to_subscription_co_administrator = email.value["send_to_subscription_co_administrator"]
          custom_emails                         = email.value["custom_emails"]
        }
      }

      dynamic "webhook" {
        for_each = notification.value["webhook"]
        content {
          service_uri = webhook.value["service_uri"]
          properties  = webhook.value["properties"]
        }
      }
    }
  }
  tags = var.tags
}