resource "azurerm_monitor_data_collection_rule" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "data_flow" {
    for_each = var.data_flow
    content {
      destinations       = data_flow.value["destinations"]
      streams            = data_flow.value["streams"]
      built_in_transform = data_flow.value["built_in_transform"]
      output_stream      = data_flow.value["output_stream"]
      transform_kql      = data_flow.value["transform_kql"]
    }
  }

  dynamic "destinations" {
    for_each = var.destinations
    content {
      dynamic "azure_monitor_metrics" {
        for_each = destinations.value["azure_monitor_metrics"]
        content {
          name = azure_monitor_metrics.value["name"]
        }
      }
      dynamic "event_hub" {
        for_each = destinations.value["event_hub"]
        content {
          name         = event_hub.value["name"]
          event_hub_id = event_hub.value["event_hub_id"]
        }
      }
      dynamic "event_hub_direct" {
        for_each = destinations.value["event_hub_direct"]
        content {
          name         = event_hub_direct.value["name"]
          event_hub_id = event_hub_direct.value["event_hub_id"]
        }
      }
      dynamic "log_analytics" {
        for_each = destinations.value["log_analytics"]
        content {
          name                  = log_analytics.value["name"]
          workspace_resource_id = log_analytics.value["workspace_resource_id"]
        }
      }
      dynamic "monitor_account" {
        for_each = destinations.value["monitor_account"]
        content {
          name               = monitor_account.value["name"]
          monitor_account_id = monitor_account.value["monitor_account_id"]
        }
      }
      dynamic "storage_blob" {
        for_each = destinations.value["storage_blob"]
        content {
          name               = storage_blob.value["name"]
          container_name     = storage_blob.value["container_name"]
          storage_account_id = storage_blob.value["storage_account_id"]
        }
      }
      dynamic "storage_blob_direct" {
        for_each = destinations.value["storage_blob_direct"]
        content {
          name               = storage_blob_direct.value["name"]
          container_name     = storage_blob_direct.value["container_name"]
          storage_account_id = storage_blob_direct.value["storage_account_id"]
        }
      }
      dynamic "storage_table_direct" {
        for_each = destinations.value["storage_table_direct"]
        content {
          name               = storage_table_direct.value["name"]
          table_name         = storage_table_direct.value["table_name"]
          storage_account_id = storage_table_direct.value["storage_account_id"]
        }
      }
    }

  }

  data_collection_endpoint_id = var.data_collection_endpoint_id

  dynamic "data_sources" {
    for_each = var.data_sources
    content {
      dynamic "data_import" {
        for_each = data_sources.value["data_import"]
        content {
          dynamic "event_hub_data_source" {
            for_each = data_import.value["event_hub_data_source"]
            content {
              name           = event_hub_data_source.value["name"]
              stream         = event_hub_data_source.value["stream"]
              consumer_group = event_hub_data_source.value["consumer_group"]
            }
          }
        }

      }

      dynamic "extension" {
        for_each = data_sources.value["extension"]
        content {
          name               = extension.value["name"]
          extension_name     = extension.value["extension_name"]
          streams            = extension.value["streams"]
          extension_json     = extension.value["extension_json"]
          input_data_sources = extension.value["input_data_sources"]
        }
      }

      dynamic "iis_log" {
        for_each = data_sources.value["iis_log"]
        content {
          name            = iis_log.value["name"]
          streams         = iis_log.value["streams"]
          log_directories = iis_log.value["log_directories"]
        }
      }

      dynamic "log_file" {
        for_each = data_sources.value["log_file"]
        content {
          name          = log_file.value["name"]
          streams       = log_file.value["streams"]
          file_patterns = log_file.value["file_patterns"]
          format        = log_file.value["format"]
          dynamic "settings" {
            for_each = log_file.value["settings"]
            content {
              dynamic "text" {
                for_each = settings.value["text"]
                content {
                  record_start_timestamp_format = text.value["record_start_timestamp_format"]
                }
              }

            }
          }
        }
      }

      dynamic "performance_counter" {
        for_each = data_sources.value["performance_counter"]
        content {
          name                          = performance_counter.value["name"]
          counter_specifiers            = performance_counter.value["counter_specifiers"]
          sampling_frequency_in_seconds = performance_counter.value["sampling_frequency_in_seconds"]
          streams                       = performance_counter.value["streams"]
        }
      }

      dynamic "platform_telemetry" {
        for_each = data_sources.value["platform_telemetry"]
        content {
          name    = platform_telemetry.value["name"]
          streams = platform_telemetry.value["streams"]
        }
      }

      dynamic "syslog" {
        for_each = data_sources.value["syslog"]
        content {
          name           = syslog.value["name"]
          streams        = syslog.value["streams"]
          log_levels     = syslog.value["log_levels"]
          facility_names = syslog.value["facility_names"]
        }
      }

      dynamic "windows_event_log" {
        for_each = data_sources.value["windows_event_log"]
        content {
          name           = windows_event_log.value["name"]
          streams        = windows_event_log.value["streams"]
          x_path_queries = windows_event_log.value["x_path_queries"]
        }
      }

      dynamic "windows_firewall_log" {
        for_each = data_sources.value["windows_firewall_log"]
        content {
          name    = windows_firewall_log.value["name"]
          streams = windows_firewall_log.value["streams"]
        }
      }

    }

  }

  dynamic "identity" {
    for_each = var.identity
    content {
      type = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }

}