output "action_gprup_ids" {
    value = local.action_group_ids  
}

output "id" {
  value = azurerm_monitor_metric_alert.this.id
}