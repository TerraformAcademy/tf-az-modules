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
| [azurerm_databricks_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_connector_id"></a> [access\_connector\_id](#input\_access\_connector\_id) | (Optional) Access Connector ID to use when default storage account firewall is enabled. | `string` | `null` | no |
| <a name="input_custom_parameters"></a> [custom\_parameters](#input\_custom\_parameters) | n/a 
| <pre>set(object({<br>    machine_learning_workspace_id                        = optional(string, null)<br>    nat_gateway_name                                     = optional(string, null)<br>    public_ip_name                                       = optional(string, null)<br>    no_public_ip                                         = optional(bool, false)<br>    public_subnet_name                                   = optional(string, null)<br>    public_subnet_network_security_group_association_id  = optional(string, null)<br>    private_subnet_name
             = optional(string, null)<br>    private_subnet_network_security_group_association_id = optional(string, null)<br>    storage_account_name                                 = optional(string, null)<br>    storage_account_sku_name                             = optional(string, "Standard_GRS")<br>    virtual_network_id                                   = optional(string, null)<br>    vnet_address_prefix                                  = optional(string, null)<br>  }))</pre> | n/a | yes |
| <a name="input_customer_managed_key_enabled"></a> [customer\_managed\_key\_enabled](#input\_customer\_managed\_key\_enabled) | (Optional) Is the workspace enabled for customer managed key encryption? If true this enables the Managed Identity for the managed storage account. | `bool` | 
`false` | no |
| <a name="input_default_storage_firewall_enabled"></a> [default\_storage\_firewall\_enabled](#input\_default\_storage\_firewall\_enabled) | (Optional) Disallow public access to default storage account. | `bool` | `false` | no |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | (Optional) Is the Databricks File System root file system enabled with a secondary layer of encryption with platform managed keys? Possible values are true or false. | `bool` | `false` | no |
| <a name="input_load_balancer_backend_address_pool_id"></a> [load\_balancer\_backend\_address\_pool\_id](#input\_load\_balancer\_backend\_address\_pool\_id) | (Optional) Resource ID of the Outbound Load balancer Backend Address Pool for Secure Cluster Connectivity (No Public IP) workspace with managed virtual network. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource has to be created. | `string` | n/a | yes |
| <a name="input_managed_disk_cmk_key_vault_id"></a> [managed\_disk\_cmk\_key\_vault\_id](#input\_managed\_disk\_cmk\_key\_vault\_id) | (Optional) Resource ID of the Key Vault which contains the managed\_disk\_cmk\_key\_vault\_key\_id key. | `string` | `null` | no |
| <a name="input_managed_disk_cmk_key_vault_key_id"></a> [managed\_disk\_cmk\_key\_vault\_key\_id](#input\_managed\_disk\_cmk\_key\_vault\_key\_id) | (Optional) Customer managed encryption properties for the Databricks Workspace managed disks. | `string` | `null` | no |
| <a name="input_managed_disk_cmk_rotation_to_latest_version_enabled"></a> [managed\_disk\_cmk\_rotation\_to\_latest\_version\_enabled](#input\_managed\_disk\_cmk\_rotation\_to\_latest\_version\_enabled) | (Optional) Whether customer managed keys for disk encryption will automatically be rotated to the latest version. | `string` | `null` | no |
| <a name="input_managed_resource_group_name"></a> [managed\_resource\_group\_name](#input\_managed\_resource\_group\_name) | (Optional) The name of the resource group where Azure should place the managed Databricks resources. | `string` | `null` | no |
| <a name="input_managed_services_cmk_key_vault_id"></a> [managed\_services\_cmk\_key\_vault\_id](#input\_managed\_services\_cmk\_key\_vault\_id) | (Optional) Resource ID of the Key Vault which contains the managed\_services\_cmk\_key\_vault\_key\_id key. | `string` | `null` | no |      
| <a name="input_managed_services_cmk_key_vault_key_id"></a> [managed\_services\_cmk\_key\_vault\_key\_id](#input\_managed\_services\_cmk\_key\_vault\_key\_id) | (Optional) Customer managed encryption properties for the Databricks Workspace managed resources(e.g. Notebooks and Artifacts). | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Databricks Workspace resource. | `string` | n/a | yes |
| <a name="input_network_security_group_rules_required"></a> [network\_security\_group\_rules\_required](#input\_network\_security\_group\_rules\_required) | (Optional) Does the data plane (clusters) to control plane communication happen over private link endpoint only or publicly? Possible values AllRules, NoAzureDatabricksRules or NoAzureServiceRules. | `string` | `null` | no |  
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Allow public access for accessing workspace. Set 
value to false to access workspace only via private link endpoint. Possible values include true 
or false. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which the Databricks Workspace should exist. | 
`string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. 
| `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#output\_disk\_encryption\_set\_id) | The ID of Managed Disk Encryption Set created by the Databricks Workspace. |   
| <a name="output_id"></a> [id](#output\_id) | The ID of the Databricks Workspace in the Azure management plane. |
| <a name="output_managed_disk_identity"></a> [managed\_disk\_identity](#output\_managed\_disk\_identity) | A managed\_disk\_identity block |
| <a name="output_managed_resource_group_id"></a> [managed\_resource\_group\_id](#output\_managed\_resource\_group\_id) | The ID of the Managed Resource Group created by the Databricks Workspace. |
| <a name="output_storage_account_identity"></a> [storage\_account\_identity](#output\_storage\_account\_identity) | A storage\_account\_identity block. |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The unique identifier of the databricks workspace in Databricks control plane. |
| <a name="output_workspace_url"></a> [workspace\_url](#output\_workspace\_url) | The workspace 
URL which is of the format 'adb-{workspaceId}.{random}.azuredatabricks.net' |