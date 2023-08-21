resource "azurerm_mssql_managed_instance" "this" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  sku_name                     = var.sku_name
  storage_size_in_gb           = var.storage_size_in_gb
  subnet_id                    = var.subnet_id
  vcores                       = var.vcores
  public_data_endpoint_enabled = var.public_data_endpoint_enabled
  license_type                 = var.license_type
  collation                    = var.collation
  dns_zone_partner_id          = var.dns_zone_partner_id
  minimum_tls_version          = var.minimum_tls_version

  dynamic "identity" {
    for_each = var.identity
    content {
      type         = identity.value["type"] 
      identity_ids = identity.value["identity_ids"]
    }
  }

  maintenance_configuration_name = var.maintenance_configuration_name
  proxy_override                 = var.proxy_override
  storage_account_type           = var.storage_account_type
  tags                           = var.tags
  timezone_id                    = var.timezone_id
}

module "name" {
  source = "./"
}