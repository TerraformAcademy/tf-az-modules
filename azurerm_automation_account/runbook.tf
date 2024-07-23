resource "azurerm_automation_runbook" "this" {
  for_each                = var.runbook
  name                    = each.value.name
  resource_group_name     = azurerm_automation_account.this.resource_group_name
  location                = azurerm_automation_account.this.location
  automation_account_name = azurerm_automation_account.this.name
  runbook_type            = each.value.runbook_type
  log_progress            = each.value.log_progress
  log_verbose             = each.value.log_verbose

  dynamic "publish_content_link" {
    for_each = each.value.publish_content_link
    content {
      uri     = publish_content_link.value["uri"]
      version = publish_content_link.value["version"]
      dynamic "hash" {
        for_each = publish_content_link.value["hash"]
        content {
          algorithm = hash.value["algorithm"]
          value     = hash.value["value"]
        }
      }
    }
  }

  description              = each.value.description
  content                  = each.value.content
  tags                     = azurerm_automation_account.this.tags
  log_activity_trace_level = each.value.log_activity_trace_level

  dynamic "draft" {
    for_each = each.value.draft
    content {
      edit_mode_enabled = draft.value["edit_mode_enabled"]
      dynamic "content_link" {
        for_each = draft.value["content_link"]
        content {

          uri     = draft.value["content_link"].uri
          version = draft.value["content_link"].uri
        }
      }
      output_types = draft.value["output_types"]

      dynamic "parameters" {
        for_each = draft.value["parameters"]
        content {
          key           = parameters.value["key"]
          type          = parameters.value["key"]
          mandatory     = parameters.value["mandatory"]
          position      = parameters.value["position"]
          default_value = parameters.value["default_value"]
        }
      }

    }
  }

  dynamic "job_schedule" {
    for_each = each.value.job_schedule
    content {
      schedule_name = job_schedule.value["schedule_name"]
      parameters    = job_schedule.value["parameters"]
      run_on        = job_schedule.value["run_on"]
    }
  }

}