resource "azurerm_cognitive_deployment" "this" {
  name                 = var.name
  cognitive_account_id = var.cognitive_account_id

  model {
    format  = var.model_format
    name    = var.model_name
    version = try(var.model_version, null)
  }

  sku {
    name     = var.sku_name
    tier     = try(var.sku_tier, null)
    size     = try(var.sku_size, null)
    family   = try(var.sku_family, null)
    capacity = try(var.sku_capacity, null)
  }

  dynamic_throttling_enabled = var.dynamic_throttling_enabled
  rai_policy_name            = var.rai_policy_name
  version_upgrade_option     = var.version_upgrade_option

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = try(timeouts.value.create, null)
      read   = try(timeouts.value.read, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}
