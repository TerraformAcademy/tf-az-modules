locals {
  action_gorup     = azurerm_monitor_action_group.this
  action_group_id  = [for id in local.action_gorup : id.id]
  action_group_ids = concat(local.action_group_id, var.action_group_ids)
}
