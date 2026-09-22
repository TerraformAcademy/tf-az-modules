<!-- BEGIN_TF_DOCS -->
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
| [azurerm_fabric_capacity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/fabric_capacity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administration_members"></a> [administration\_members](#input\_administration\_members) | (Optional) An array of administrator user identities. The member must be an Entra user or a service principal. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The supported Azure location where the Fabric Capacity exists. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name which should be used for the Fabric Capacity. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which to create the Fabric Capacity. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) A sku block as defined above. | <pre>object({<br/>    name = string # (Required) The name of the SKU to use for the Fabric Capacity. Possible values are F2, F4, F8, F16, F32, F64, F128, F256, F512, F1024, F2048.<br/>    tier = string # (Required) The tier of the SKU to use for the Fabric Capacity. The only possible value is Fabric.<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Fabric Capacity. |
<!-- END_TF_DOCS -->