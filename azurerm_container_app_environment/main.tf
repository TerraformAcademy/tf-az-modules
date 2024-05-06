resource "azurerm_container_app_environment" "this" {
  name                                        = var.name
  resource_group_name                         = var.resource_group_name
  location                                    = var.location
  dapr_application_insights_connection_string = var.dapr_application_insights_connection_string
  infrastructure_resource_group_name          = var.infrastructure_resource_group_name
  infrastructure_subnet_id                    = var.infrastructure_subnet_id
  internal_load_balancer_enabled              = var.internal_load_balancer_enabled
  zone_redundancy_enabled                     = var.zone_redundancy_enabled
  log_analytics_workspace_id                  = var.log_analytics_workspace_id
  dynamic "workload_profile" {
    for_each = var.workload_profile
    content {
      name                  = each.value["name"]
      workload_profile_type = each.value["workload_profile_type"]
      maximum_count         = each.value["maximum_count"]
      minimum_count         = each.value["minimum_count"]
    }
  }

  tags = var.tags
}