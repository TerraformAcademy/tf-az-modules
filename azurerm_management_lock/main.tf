resource "azurerm_management_lock" "this" {
  name       = var.name
  scope      = var.scope
  lock_level = var.lock_level
  notes      = var.notes

}