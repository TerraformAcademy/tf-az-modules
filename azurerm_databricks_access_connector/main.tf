resource "azurerm_databricks_access_connector" "this" {
    name = var.name
    resource_group_name = var.resource_group_name
    location = var.location
    tags = var.tags

    dynamic "identity" {
    for_each = var.identity
    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }
}
