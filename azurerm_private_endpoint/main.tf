resource "azurerm_private_endpoint" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  subnet_id                     = var.subnet_id
  custom_network_interface_name = var.custom_network_interface_name

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group
    content {
      name                 = private_dns_zone_group.value["name"]
      private_dns_zone_ids = private_dns_zone_group.value["private_dns_zone_ids"]
    }
  }

  dynamic "private_service_connection" {

    for_each = var.private_service_connection
    content {
      name                              = private_service_connection.value["name"]
      is_manual_connection              = private_service_connection.value["is_manual_connection"]
      private_connection_resource_alias = private_service_connection.value["private_connection_resource_alias"]
      private_connection_resource_id    = private_service_connection.value["private_connection_resource_id"]
      subresource_names                 = private_service_connection.value["subresource_names"]
      request_message                   = private_service_connection.value["request_message"]
    }
  }

  dynamic "ip_configuration" {
    for_each = var.ip_configuration
    content {
      name               = ip_configuration.value["name"]
      private_ip_address = ip_configuration.value["private_ip_address"]
      subresource_name   = ip_configuration.value["subresource_name"]
      member_name        = ip_configuration.value["member_name"]
    }
  }

  tags = var.tags

}