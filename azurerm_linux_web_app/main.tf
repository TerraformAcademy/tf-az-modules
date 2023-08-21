resource "azurerm_linux_web_app" "this" {
  name                = var.name
  location = var.location
  resource_group_name = var.resource_group_name
  service_plan_id = var.service_plan_id
  dynamic "site_config" {
    for_each = var.site_config
    content {
      always_on = site_config.value["always_on"]
      api_definition_url = site_config.value["api_definition_url"]

      dynamic "application_stack" {
        for_each = site_config.value["application_stack"]
        content {
          docker_image_name = application_stack.value["docker_image_name"]
        }
      }

      auto_heal_enabled = site_config.value["auto_heal_enabled"]
    }

  }
}