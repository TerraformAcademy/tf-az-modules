resource "azurerm_data_factory_integration_runtime_azure_ssis" "this" {
  name = var.name
  location = var.location
  data_factory_id = var.data_factory_id
  node_size = var.node_size
  number_of_nodes = var.number_of_nodes
  credential_name = var.credential_name
  max_parallel_executions_per_node = var.max_parallel_executions_per_node
  edition = var.edition
  license_type = var.license_type
  dynamic "catalog_info" {
    for_each = var.catalog_info
    content {
      server_endpoint = catalog_info.value["server_endpoint"]
      administrator_login = catalog_info.value["administrator_login"]
      administrator_password = catalog_info.value["administrator_password"]
      pricing_tier = catalog_info.value["pricing_tier"]
      elastic_pool_name = catalog_info.value["elastic_pool_name"]
      dual_standby_pair_name = catalog_info.value["dual_standby_pair_name"]
    }
  }
}