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
| [azurerm_monitor_data_collection_rule_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_collection_endpoint_id"></a> [data\_collection\_endpoint\_id](#input\_data\_collection\_endpoint\_id) | (Optional) The ID of the Data Collection Endpoint which will be associated to the target resource. | `string` | `null` | no |
| <a name="input_data_collection_rule_id"></a> [data\_collection\_rule\_id](#input\_data\_collection\_rule\_id) | (Optional) The ID of the Data Collection Rule which will be associated to the target resource. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the Data Collection Rule Association. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name which should be used for this Data Collection Rule Association. Changing this forces a new Data Collection Rule Association to be created. Defaults to configurationAccessEndpoint. | `string` | `"configurationAccessEndpoint"` | no |
| <a name="input_target_resource_id"></a> [target\_resource\_id](#input\_target\_resource\_id) | (Required) The ID of the Azure Resource which to associate to a Data Collection Rule or a Data Collection Endpoint. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Data Collection Rule Association. |