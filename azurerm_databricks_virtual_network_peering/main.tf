resource "azurerm_databricks_virtual_network_peering" "this" {
    name = var.name
    resource_group_name = var.resource_group_name
    workspace_id = var.workspace_id
    address_space_prefixes = var.address_space_prefixes
    remote_address_space_prefixes = var.remote_address_space_prefixes
    remote_virtual_network_id = var.remote_virtual_network_id
    allow_virtual_network_access = var.allow_virtual_network_access
    allow_forwarded_traffic = var.allow_forwarded_traffic
    allow_gateway_transit = var.allow_gateway_transit
    use_remote_gateways = var.use_remote_gateways
}
