resource "azurerm_cognitive_account" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = var.kind
  sku_name            = var.sku_name

  project_management_enabled    = var.project_management_enabled
  custom_subdomain_name         = var.custom_subdomain_name
  public_network_access_enabled = var.public_network_access_enabled
  fqdns                         = var.fqdns

  dynamic "identity" {
    for_each = var.identity_type != null ? [var.identity_type] : []
    content {
      type         = var.identity_type
      identity_ids = try(var.identity_ids, [])
    }
  }

  dynamic "network_injection" {
    for_each = var.network_injection_subnet_id != null ? [var.network_injection_subnet_id] : []
    content {
      scenario  = "agent"
      subnet_id = network_injection.value
    }
  }

  tags = var.tags
}
