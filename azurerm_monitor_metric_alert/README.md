## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.50.0, <4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_action_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_metric_alert.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_gorup"></a> [action\_gorup](#input\_action\_gorup) | A Map of objects ,defining action groups to create | <pre>map(object({<br>    name                = string<br>    resource_group_name = string<br>    short_name          = string<br>    enabled             = optional(bool, true)<br>    location            = optional(string, "global")<br>    email_receiver = optional(set(object({<br>      name                    = string<br>      email_address           = string<br>      use_common_alert_schema = optional(bool, false)<br>    })), [])<br>  }))</pre> | `{}` | no |
| <a name="input_action_group_ids"></a> [action\_group\_ids](#input\_action\_group\_ids) | A list of action group IDs to be attached with Alert Rule. | `list(string)` | `[]` | no |
| <a name="input_auto_mitigate"></a> [auto\_mitigate](#input\_auto\_mitigate) | (Optional) Should the alerts in this Metric Alert be auto resolved? | `bool` | `true` | no |
| <a name="input_criteria"></a> [criteria](#input\_criteria) | One or more criteria blocks to define alert conditions. | <pre>set(object({<br>    metric_namespace  = string<br>    metric_name       = string<br>    aggregation       = string<br>    operator          = string<br>    alert_sensitivity = string<br>    dimension = optional(set(object({<br>      name     = string<br>      operator = string<br>      values   = string<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of this Metric Alert | `string` | `null` | no |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | value | `string` | `"PT1M"` | no |
| <a name="input_severity"></a> [severity](#input\_severity) | (Optional) The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. | `number` | `3` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_target_resource_location"></a> [target\_resource\_location](#input\_target\_resource\_location) | (Optional) The location of the target resource. | `string` | `null` | no |
| <a name="input_target_resource_type"></a> [target\_resource\_type](#input\_target\_resource\_type) | (Optional) The resource type (e.g. Microsoft.Compute/virtualMachines) of the target resource. | `string` | `null` | no |
| <a name="input_window_size"></a> [window\_size](#input\_window\_size) | (Optional) The period of time that is used to monitor alert activity, represented in ISO 8601 duration format. This value must be greater than frequency. Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D. | `string` | `"PT5M"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_action_gprup_ids"></a> [action\_gprup\_ids](#output\_action\_gprup\_ids) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |