variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "enabled" {
  type    = bool
  default = true
}

variable "target_resource_id" {
  type = string
}

variable "profile" {
  type = set(object({
    name = string
    capacity = set(object({
      default = number
      maximum = number
      minimum = number
    }))
    rule = set(object({
      metric_trigger = set(object({
        metric_name        = string
        metric_resource_id = string
        operator           = string
        statistic          = string
        time_aggregation   = string
        time_grain         = string
        time_window        = string
        threshold          = string
        metric_namespace   = optional(string)
        dimensions = optional(set(object({
          name     = string
          operator = string
          values   = list(string)
        })))
        divide_by_instance_count = optional(bool)
      }))
      scale_action = set(object({
        cooldown  = string
        direction = string
        type      = string
        value     = number
      }))
    }))
    fixed_date = optional(set(object({
      end      = string
      start    = string
      timezone = string
    })))
    recurrence = optional(set(object({
      timezone = string
      days     = list(string)
      hours    = number
      minutes  = number
    })))
  }))
}

variable "notification" {
  type = set(object({
    email = set(object({
      send_to_subscription_administrator    = optional(bool, false)
      send_to_subscription_co_administrator = optional(bool, false)
      custom_emails                         = optional(list(string))
    }))
    webhook = set(object({
      service_uri = string
      properties  = optional(map(any))
    }))
  }))
  default = []
}

variable "predictive" {
  type = set(object({
    scale_mode      = string
    look_ahead_time = optional(string)
  }))
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
}