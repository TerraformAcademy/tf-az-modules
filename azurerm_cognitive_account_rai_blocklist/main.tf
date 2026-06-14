resource "azurerm_cognitive_account_rai_blocklist" "this" {
  name                 = var.name
  cognitive_account_id = var.cognitive_account_id

  description = var.description
  tags        = var.tags

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
