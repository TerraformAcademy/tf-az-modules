resource "azurerm_data_factory_integration_runtime_self_hosted" "this" {
  name            = var.name
  data_factory_id = var.data_factory_id
  description     = var.description
  dynamic "rbac_authorization" {
    for_each = var.rbac_authorization
    content {
      resource_id = rbac_authorization.value["resource_id"]
    }
  }
}