## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.20, <4.00 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.20, <4.00 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_environment_id"></a> [app\_service\_environment\_id](#input\_app\_service\_environment\_id) | (Optional) The ID of the App Service Environment to create this Service Plan in. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Service Plan should exist. | `string` | n/a | yes |
| <a name="input_maximum_elastic_worker_count"></a> [maximum\_elastic\_worker\_count](#input\_maximum\_elastic\_worker\_count) | (Optional) The maximum number of workers to use in an Elastic SKU Plan. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name which should be used for this Service Plan. | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer. | `string` | n/a | yes |
| <a name="input_per_site_scaling_enabled"></a> [per\_site\_scaling\_enabled](#input\_per\_site\_scaling\_enabled) | (Optional) Should Per Site Scaling be enabled. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the AppService should exist. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Required) The SKU for the plan. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required)  A mapping of tags which should be assigned to the AppService. | `map(any)` | n/a | yes |
| <a name="input_worker_count"></a> [worker\_count](#input\_worker\_count) | (Optional) The number of Workers (instances) to be allocated. | `number` | `1` | no |
| <a name="input_zone_balancing_enabled"></a> [zone\_balancing\_enabled](#input\_zone\_balancing\_enabled) | (Optional) Should the Service Plan balance across Availability Zones in the region. Changing this forces a new resource to be created. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Service Plan. |
| <a name="output_kind"></a> [kind](#output\_kind) | A string representing the Kind of Service Plan. |
| <a name="output_reserved"></a> [reserved](#output\_reserved) | Whether this is a reserved Service Plan Type. true if os\_type is Linux, otherwise false. |