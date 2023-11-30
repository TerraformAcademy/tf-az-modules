## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.75.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_data_collection_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_collection_endpoint_id"></a> [data\_collection\_endpoint\_id](#input\_data\_collection\_endpoint\_id) | (Optional) The resource ID of the Data Collection Endpoint that this rule can be used with. | `string` | `null` | no |
| <a name="input_data_flow"></a> [data\_flow](#input\_data\_flow) | (Required) One or more data\_flow blocks. | <pre>set(object({<br>    destinations       = list(string)<br>    streams            = list(string)<br>    built_in_transform = optional(string, null)<br>    output_stream      = optional(string, null)<br>    transform_kql      = optional(string, null)<br>  }))</pre> | n/a | yes |
| <a name="input_data_sources"></a> [data\_sources](#input\_data\_sources) | (Optional) A data\_sources block as defined below. This property is optional and can be omitted if the rule is meant to be used via direct calls to the provisioned endpoint. | <pre>set(object({<br>    data_import = optional(set(object({<br>      event_hub_data_source = set(object({<br>        name           = string<br>        stream         = string<br>        consumer_group = optional(string, null)<br>      }))<br>    })), [])<br>    extension = optional(set(object({<br>      name               = string<br>      extension_name     = string<br>      streams            = list(string)<br>      extension_json     = optional(string, null)<br>      input_data_sources = optional(list(string), [])<br>    })), [])<br>    iis_log = optional(set(object({<br>      name            = string<br>      streams         = list(string)<br>      log_directories = optional(list(string), [])<br>    })), [])<br>    log_file = optional(set(object({<br>      name          = string<br>      streams       = list(string)<br>      file_patterns = list(string)<br>      format        = string<br>      settings = optional(set(object({<br>        text = set(object({<br>          record_start_timestamp_format = string<br>        }))<br>      })), [])<br>    })), [])<br>    performance_counter = optional(set(object({<br>      name                          = string<br>      counter_specifiers            = list(string)<br>      sampling_frequency_in_seconds = number<br>      streams                       = list(string)<br>    })), [])<br>    platform_telemetry = optional(set(object({<br>      name    = string<br>      streams = list(string)<br>    })), [])<br>    syslog = optional(set(object({<br>      name           = string<br>      streams        = optional(list(string), [])<br>      facility_names = list(string)<br>      log_levels     = list(string)<br><br>    })), [])<br>    windows_event_log = optional(set(object({<br>      name           = string<br>      streams        = list(string)<br>      x_path_queries = list(string)<br>    })), [])<br>    windows_firewall_log = optional(set(object({<br>      name    = string<br>      streams = list(string)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the Data Collection Rule. | `string` | `null` | no |
| <a name="input_destinations"></a> [destinations](#input\_destinations) | (Required) A destinations block as defined below. | <pre>set(object({<br>    azure_monitor_metrics = optional(set(object({<br>      name = string<br>    })), [])<br>    event_hub = optional(set(object({<br>      name         = string<br>      event_hub_id = string<br>    })), [])<br>    event_hub_direct = optional(set(object({<br>      name         = string<br>      event_hub_id = string<br>    })), [])<br>    log_analytics = optional(set(object({<br>      name                  = string<br>      workspace_resource_id = string<br>    })), [])<br>    monitor_account = optional(set(object({<br>      name               = string<br>      monitor_account_id = string<br>    })), [])<br>    storage_blob = optional(set(object({<br>      name               = string<br>      container_name     = string<br>      storage_account_id = string<br>    })), [])<br>    storage_blob_direct = optional(set(object({<br>      name               = string<br>      container_name     = string<br>      storage_account_id = string<br>    })), [])<br>    storage_table_direct = optional(set(object({<br>      name               = string<br>      table_name         = string<br>      storage_account_id = string<br>    })), [])<br>  }))</pre> | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | An identity block to define managed identity. | <pre>set(object({<br>    type = string<br>    identity_ids = optional(list(string), [])<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Data Collection Rule should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) A destinations block as defined below. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Data Collection Rule should exist. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Data Collection Rule. |
| <a name="output_identity"></a> [identity](#output\_identity) | The Principal ID associated with this Managed Service Identity. |
| <a name="output_immutable_id"></a> [immutable\_id](#output\_immutable\_id) | The immutable ID of the Data Collection Rule. |