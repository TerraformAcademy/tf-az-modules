resource "azurerm_data_factory_credential_user_assigned_managed_identity" "this" {
  name            = var.name
  data_factory_id = var.data_factory_id
  identity_id     = var.identity_id
  annotations     = var.annotations
  description     = var.description
}