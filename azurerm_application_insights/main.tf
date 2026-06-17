resource "azurerm_application_insights" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = var.application_type

  workspace_id = var.workspace_id

  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.daily_data_cap_notifications_disabled
  retention_in_days                     = var.retention_in_days
  sampling_percentage                   = var.sampling_percentage

  disable_ip_masking                  = var.disable_ip_masking
  local_authentication_disabled       = var.local_authentication_disabled
  internet_ingestion_enabled          = var.internet_ingestion_enabled
  internet_query_enabled              = var.internet_query_enabled
  force_customer_storage_for_profiler = var.force_customer_storage_for_profiler

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = length(coalesce(identity.value.identity_ids, [])) > 0 ? identity.value.identity_ids : null
    }
  }

  tags = var.tags
}
