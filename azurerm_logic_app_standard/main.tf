resource "azurerm_logic_app_standard" "this" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  location             = var.location
  app_service_plan_id  = var.app_service_plan_id
  app_settings         = var.app_settings
  use_extension_bundle = var.use_extension_bundle
  bundle_version       = var.bundle_version

  dynamic "connection_string" {
    for_each = var.connection_string
    content {
      name  = connection_string.value["name"]
      type  = var.connection_string.value["type"]
      value = var.connection_string.value["value"]
    }
  }

  client_affinity_enabled = var.client_affinity_enabled
  client_certificate_mode = var.client_certificate_mode
  enabled                 = var.enabled
  https_only              = var.https_only

  dynamic "identity" {
    for_each = var.identity
    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }

  site_config {
    always_on       = var.site_config.always_on
    app_scale_limit = var.site_config.app_scale_limit
    dynamic "cors" {
      for_each = var.site_config.cors
      content {
        allowed_origins     = cors.allowed_regions
        support_credentials = cors.support_credentials
      }
    }
    dotnet_framework_version = var.site_config.dotnet_framework_version
    elastic_instance_minimum = var.site_config.elastic_instance_minimum
    ftps_state               = var.site_config.ftps_state
    health_check_path        = var.site_config.health_check_path
    http2_enabled            = var.site_config.http2_enabled
    ip_restriction           = var.site_config.ip_restriction
    scm_ip_restriction       = var.site_config.scm_ip_restriction
  }

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  storage_account_share_name = var.storage_account_share_name
  version                    = var.app_version
}