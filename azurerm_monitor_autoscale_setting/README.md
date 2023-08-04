## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_notification"></a> [notification](#input\_notification) | n/a | <pre>set(object({<br>    email = set(object({<br>      send_to_subscription_administrator    = optional(bool, false)<br>      send_to_subscription_co_administrator = optional(bool, false)<br>      custom_emails                         = optional(list(string))<br>    }))<br>    webhook = set(object({<br>      service_uri = string<br>      properties  = optional(map(any))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_predictive"></a> [predictive](#input\_predictive) | n/a | <pre>set(object({<br>    scale_mode      = string<br>    look_ahead_time = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | n/a | <pre>set(object({<br>    name = string<br>    capacity = set(object({<br>      default = number<br>      maximum = number<br>      minimum = number<br>    }))<br>    rule = set(object({<br>      metric_trigger = set(object({<br>        metric_name        = string<br>        metric_resource_id = string<br>        operator           = string<br>        statistic          = string<br>        time_aggregation   = string<br>        time_grain         = string<br>        time_window        = string<br>        threshold          = string<br>        metric_namespace   = optional(string)<br>        dimensions = optional(set(object({<br>          name     = string<br>          operator = string<br>          values   = list(string)<br>        })))<br>        divide_by_instance_count = optional(bool)<br>      }))<br>      scale_action = set(object({<br>        cooldown  = string<br>        direction = string<br>        type      = string<br>        value     = number<br>      }))<br>    }))<br>    fixed_date = optional(set(object({<br>      end      = string<br>      start    = string<br>      timezone = string<br>    })))<br>    recurrence = optional(set(object({<br>      timezone = string<br>      days     = list(string)<br>      hours    = number<br>      minutes  = number<br>    })))<br>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(any)` | n/a | yes |
| <a name="input_target_resource_id"></a> [target\_resource\_id](#input\_target\_resource\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |