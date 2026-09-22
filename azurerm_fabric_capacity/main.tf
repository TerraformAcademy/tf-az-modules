resource "azurerm_fabric_capacity" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name = var.sku.name
    tier = var.sku.tier
  }

  administration_members = var.administration_members

}