resource "azurerm_private_endpoint" "this" {
  name = var.name
  resource_group_name = var.resource_group_name
  location = var.location
  subnet_id = var.subnet_id
  custom_network_interface_name = var.custom_network_interface_name

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group
    content{
        name = private_dns_zone_group.value["name"]
        private_dns_zone_ids = private_dns_zone_group.value["private_dns_zone_ids"]
        private_connection_resource_alias = private_dns_zone_group.value["private_connection_resource_alias"]
        private_connection_resource_id = private_dns_zone_group.value["private_connection_resource_id"]
        subresource_names = private_dns_zone_group.value["subresource_names"]
    }
  }

  dynamic "ip_configuration" {
    
  }

}