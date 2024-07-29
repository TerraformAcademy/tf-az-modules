resource "azurerm_automation_account" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name

  dynamic "identity" {
    for_each = var.identity
    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }

  local_authentication_enabled = var.local_authentication_enabled
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "encryption" {
    for_each = var.encryption 
    content {
        key_vault_key_id = encryption.value["key_vault_key_id"]
        user_assigned_identity_id = encryption.value["user_assigned_identity_id"]
    }
  }

  tags = var.tags
}