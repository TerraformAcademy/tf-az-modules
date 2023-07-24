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
| [azurerm_logic_app_standard.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_standard) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_plan_id"></a> [app\_service\_plan\_id](#input\_app\_service\_plan\_id) | (Required) The ID of the App Service Plan within which to create this Logic App. | `string` | n/a | yes |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | (Optional) A map of key-value pairs for App Settings and custom values. | `map(any)` | `{}` | no |
| <a name="input_app_version"></a> [app\_version](#input\_app\_version) | (Optional) The runtime version associated with the Logic App. | `string` | `"~3"` | no |
| <a name="input_bundle_version"></a> [bundle\_version](#input\_bundle\_version) | (Optional) If use\_extension\_bundle then controls the allowed range for bundle versions. Default [1.*, 2.0.0). | `string` | `"1.*, 2.0.0"` | no |
| <a name="input_client_affinity_enabled"></a> [client\_affinity\_enabled](#input\_client\_affinity\_enabled) | (Optional) Should the Logic App send session affinity cookies, which route client requests in the same session to the same instance? | `bool` | `false` | no |
| <a name="input_client_certificate_mode"></a> [client\_certificate\_mode](#input\_client\_certificate\_mode) | (Optional) The mode of the Logic App's client certificates requirement for incoming requests. Possible values are Required and Optional. | `string` | `null` | no |
| <a name="input_connection_string"></a> [connection\_string](#input\_connection\_string) | (Optional) An connection\_string block as defined below. | <pre>set(object({<br>    name  = string<br>    type  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | tional) Is the Logic App enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | (Optional) Can the Logic App only be accessed via HTTPS? | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block as documented above. | <pre>list(object({<br>    type         = string                 # (Required) Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).<br>    identity_ids = optional(list(string)) # (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account.<br>  }))</pre> | `[]` | no |
| <a name="input_linux_fx_version"></a> [linux\_fx\_version](#input\_linux\_fx\_version) | (Optional) Linux App Framework and version for the AppService, e.g. DOCKER\|(golang:latest). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | (Optional) The minimum supported TLS version for the Logic App. | `string` | `"1.2"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Logic App Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_pre_warmed_instance_count"></a> [pre\_warmed\_instance\_count](#input\_pre\_warmed\_instance\_count) | (Optional) The number of pre-warmed instances for this Logic App Only affects apps on the Premium plan. | `number` | `0` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the Logic App. | `string` | n/a | yes |
| <a name="input_runtime_scale_monitoring_enabled"></a> [runtime\_scale\_monitoring\_enabled](#input\_runtime\_scale\_monitoring\_enabled) | Optional) Should Runtime Scale Monitoring be enabled? | `bool` | `false` | no |
| <a name="input_scm_min_tls_version"></a> [scm\_min\_tls\_version](#input\_scm\_min\_tls\_version) | (Optional) Configures the minimum version of TLS required for SSL requests to the SCM site. Possible values are 1.0, 1.1 and 1.2. | `string` | `"1.2"` | no |
| <a name="input_scm_type"></a> [scm\_type](#input\_scm\_type) | (Optional) The type of Source Control used by the Logic App in use by the Windows Function App. | `string` | `"None"` | no |
| <a name="input_scm_use_main_ip_restriction"></a> [scm\_use\_main\_ip\_restriction](#input\_scm\_use\_main\_ip\_restriction) | (Optional) Should the Logic App ip\_restriction configuration be used for the SCM too. | `bool` | `false` | no |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | (Optional) A site\_config object. | <pre>object({<br>    always_on       = optional(bool, false)<br>    app_scale_limit = optional(number)<br>    cors = optional(set(object({<br>      allowed_regions     = list(string)<br>      support_credentials = optional(bool)<br>    })), [])<br>    dotnet_framework_version = optional(string)<br>    elastic_instance_minimum = optional(number)<br>    ftps_state               = optional(string, "FtpsOnly")<br>    health_check_path        = optional(string)<br>    http2_enabled            = optional(bool, false)<br>    ip_restriction = optional(list(object({<br>      ip_address                = optional(string)<br>      service_tag               = optional(string)<br>      virtual_network_subnet_id = optional(string)<br>      name                      = optional(string)<br>      priority                  = optional(string)<br>      action                    = optional(string, "Allow")<br>      headers = optional(list(object({<br>        x_azure_fdid      = optional(list(string))<br>        x_fd_health_probe = optional(list(string))<br>        x_forwarded_for   = optional(list(string))<br>        x_forwarded_host  = optional(list(string))<br>      })))<br>    })), [])<br>    scm_ip_restriction = optional(list(object({<br>      ip_address                = optional(string)<br>      service_tag               = optional(string)<br>      virtual_network_subnet_id = optional(string)<br>      name                      = optional(string)<br>      priority                  = optional(string)<br>      action                    = optional(string, "Allow")<br>      headers = optional(list(object({<br>        x_azure_fdid      = optional(list(string))<br>        x_fd_health_probe = optional(list(string))<br>        x_forwarded_for   = optional(list(string))<br>        x_forwarded_host  = optional(list(string))<br>      })))<br>    })), [])<br>  })</pre> | `{}` | no |
| <a name="input_storage_account_access_key"></a> [storage\_account\_access\_key](#input\_storage\_account\_access\_key) | (Required) The access key which will be used to access the backend storage account for the Logic App. | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Required) The backend storage account name which will be used by this Logic App (e.g. for Stateful workflows data). | `string` | n/a | yes |
| <a name="input_storage_account_share_name"></a> [storage\_account\_share\_name](#input\_storage\_account\_share\_name) | (Optional) The name of the share used by the logic app, if you want to use a custom name. | `string` | `null` | no |
| <a name="input_use_32_bit_worker_process"></a> [use\_32\_bit\_worker\_process](#input\_use\_32\_bit\_worker\_process) | (Optional) Should the Logic App run in 32 bit mode, rather than 64 bit mode? | `bool` | `true` | no |
| <a name="input_use_extension_bundle"></a> [use\_extension\_bundle](#input\_use\_extension\_bundle) | (Optional) Should the logic app use the bundled extension package? | `bool` | `true` | no |
| <a name="input_vnet_route_all_enabled"></a> [vnet\_route\_all\_enabled](#input\_vnet\_route\_all\_enabled) | (Optional) Should all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied. | `bool` | `false` | no |
| <a name="input_websockets_enabled"></a> [websockets\_enabled](#input\_websockets\_enabled) | (Optional) Should WebSockets be enabled? | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_domain_verification_id"></a> [custom\_domain\_verification\_id](#output\_custom\_domain\_verification\_id) | An identifier used by App Service to perform domain ownership verification via DNS TXT record. |
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | The default hostname associated with the Logic App. |
| <a name="output_id"></a> [id](#output\_id) | value |
| <a name="output_identity"></a> [identity](#output\_identity) | An identity block as defined below, which contains the Managed Service Identity information for this App Service. |
| <a name="output_kind"></a> [kind](#output\_kind) | The Logic App kind - will be functionapp,workflowapp |
| <a name="output_outbound_ip_address"></a> [outbound\_ip\_address](#output\_outbound\_ip\_address) | A comma separated list of outbound IP addresses. |
| <a name="output_possible_outbound_ip_addresses"></a> [possible\_outbound\_ip\_addresses](#output\_possible\_outbound\_ip\_addresses) | A comma separated list of outbound IP addresses - Superset of outbound\_ip\_addresses. |
| <a name="output_site_credential"></a> [site\_credential](#output\_site\_credential) | A site\_credential block as defined below, which contains the site-level credentials used to publish to this App Service. |