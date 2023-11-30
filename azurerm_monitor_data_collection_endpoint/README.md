## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_data_collection_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | (Optional) Specifies a description for the Data Collection Endpoint. | `string` | `null` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | (Optional) The kind of the Data Collection Endpoint. Possible values are Linux and Windows. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Data Collection Endpoint should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name which should be used for this Data Collection Endpoint. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether network access from public internet to the Data Collection Endpoint are allowed. Possible values are true and false. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Data Collection Endpoint should exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Data Collection Endpoint. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configuration_access_endpoint"></a> [configuration\_access\_endpoint](#output\_configuration\_access\_endpoint) | The endpoint used for accessing configuration, e.g., https://mydce-abcd.eastus-1.control.monitor.azure.com. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Data Collection Endpoint. |
| <a name="output_logs_ingestion_endpoint"></a> [logs\_ingestion\_endpoint](#output\_logs\_ingestion\_endpoint) | The endpoint used for ingesting logs, e.g., https://mydce-abcd.eastus-1.ingest.monitor.azure.com. |