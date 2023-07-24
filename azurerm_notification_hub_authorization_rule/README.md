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
| [azurerm_notification_hub_authorization_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_listen"></a> [listen](#input\_listen) | (Optional) Does this Authorization Rule have Listen access to the Notification Hub? | `bool` | `false` | no |
| <a name="input_manage"></a> [manage](#input\_manage) | (Optional) Does this Authorization Rule have Manage access to the Notification Hub? | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name to use for this Authorization Rule. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name) | (Required) The name of the Notification Hub Namespace in which the Notification Hub exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_notification_hub_name"></a> [notification\_hub\_name](#input\_notification\_hub\_name) | (Required) The name of the Notification Hub for which the Authorization Rule should be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which the Notification Hub Namespace exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_send"></a> [send](#input\_send) | (Optional) Does this Authorization Rule have Send access to the Notification Hub? | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Authorization Rule. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The Primary Access Key associated with this Authorization Rule. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The Secondary Access Key associated with this Authorization Rule. |