resource "azurerm_search_service" "search" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  allowed_ips                   = try(var.allowed_ips, null)
  replica_count                 = try(var.replica_count, null)
  partition_count               = try(var.partition_count, null)
  public_network_access_enabled = try(var.public_network_access_enabled, null)
  tags                          = try(var.tags, null)

  authentication_failure_mode              = try(var.authentication_failure_mode, null)
  customer_managed_key_enforcement_enabled = try(var.customer_managed_key_enforcement_enabled, null)
  hosting_mode                             = try(var.hosting_mode, null)

  dynamic "identity" {
    for_each = var.identity_type == "SystemAssigned" ? [var.identity_type] : []
    content {
      type = var.identity_type
    }
  }

  dynamic "identity" {
    for_each = var.identity_type == "SystemAssigned, UserAssigned" ? [var.identity_type] : []
    content {
      type         = var.identity_type
      identity_ids = try(var.identity_ids, [])
    }
  }

  dynamic "identity" {
    for_each = var.identity_type == "UserAssigned" ? [var.identity_type] : []
    content {
      type         = var.identity_type
      identity_ids = length(try(var.identity_ids, [])) > 0 ? var.identity_ids : []
    }
  }
  network_rule_bypass_option = var.network_rule_bypass_option
  semantic_search_sku        = var.semantic_search_sku
}
