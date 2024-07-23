resource "azurerm_automation_schedule" "this" {
  for_each = var.schedule

  name                    = each.value.name
  resource_group_name     = azurerm_automation_account.this.resource_group_name
  automation_account_name = azurerm_automation_account.this.name
  frequency               = each.value.frequency
  description             = each.value.description
  interval                = each.value.interval
  start_time              = each.value.start_time
  expiry_time             = each.value.expiry_time
  timezone                = each.value.timezone
  week_days               = each.value.week_days
  month_days              = each.value.month_days

  dynamic "monthly_occurrence" {
    for_each = each.value.monthly_occurrence
    content {
      day        = monthly_occurrence.value["day"]
      occurrence = monthly_occurrence.value["occurrence"]
    }
  }
}