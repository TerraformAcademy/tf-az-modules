variable "name" {
  type        = string
  description = "(Required) A destinations block as defined below."

}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Data Collection Rule should exist."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group where the Data Collection Rule should exist."
}

variable "data_flow" {
  type = set(object({
    destinations       = list(string)
    streams            = list(string)
    built_in_transform = optional(string, null)
    output_stream      = optional(string, null)
    transform_kql      = optional(string, null)
  }))
  description = "(Required) One or more data_flow blocks."
}

variable "destinations" {
  type = set(object({
    azure_monitor_metrics = optional(set(object({
      name = string
    })), [])
    event_hub = optional(set(object({
      name         = string
      event_hub_id = string
    })), [])
    event_hub_direct = optional(set(object({
      name         = string
      event_hub_id = string
    })), [])
    log_analytics = optional(set(object({
      name                  = string
      workspace_resource_id = string
    })), [])
    monitor_account = optional(set(object({
      name               = string
      monitor_account_id = string
    })), [])
    storage_blob = optional(set(object({
      name               = string
      container_name     = string
      storage_account_id = string
    })), [])
    storage_blob_direct = optional(set(object({
      name               = string
      container_name     = string
      storage_account_id = string
    })), [])
    storage_table_direct = optional(set(object({
      name               = string
      table_name         = string
      storage_account_id = string
    })), [])
  }))
  description = "(Required) A destinations block as defined below."
}

variable "data_collection_endpoint_id" {
  type        = string
  description = "(Optional) The resource ID of the Data Collection Endpoint that this rule can be used with."
  default     = null
}

variable "description" {
  type        = string
  description = "(Optional) The description of the Data Collection Rule."
  default     = null
}

variable "data_sources" {
  type = set(object({
    data_import = optional(set(object({
      event_hub_data_source = set(object({
        name           = string
        stream         = string
        consumer_group = optional(string, null)
      }))
    })), [])
    extension = optional(set(object({
      name               = string
      extension_name     = string
      streams            = list(string)
      extension_json     = optional(string, null)
      input_data_sources = optional(list(string), [])
    })), [])
    iis_log = optional(set(object({
      name            = string
      streams         = list(string)
      log_directories = optional(list(string), [])
    })), [])
    log_file = optional(set(object({
      name          = string
      streams       = list(string)
      file_patterns = list(string)
      format        = string
      settings = optional(set(object({
        text = set(object({
          record_start_timestamp_format = string
        }))
      })), [])
    })), [])
    performance_counter = optional(set(object({
      name                          = string
      counter_specifiers            = list(string)
      sampling_frequency_in_seconds = number
      streams                       = list(string)
    })), [])
    platform_telemetry = optional(set(object({
      name    = string
      streams = list(string)
    })), [])
    syslog = optional(set(object({
      name           = string
      streams        = optional(list(string), [])
      facility_names = list(string)
      log_levels     = list(string)

    })), [])
    windows_event_log = optional(set(object({
      name           = string
      streams        = list(string)
      x_path_queries = list(string)
    })), [])
    windows_firewall_log = optional(set(object({
      name    = string
      streams = list(string)
    })), [])
  }))
  description = "(Optional) A data_sources block as defined below. This property is optional and can be omitted if the rule is meant to be used via direct calls to the provisioned endpoint."
  default     = []
}

variable "identity" {
  type = set(object({
    type = string
    identity_ids = optional(list(string), [])
  }))
  description = "An identity block to define managed identity."
  default = []
}