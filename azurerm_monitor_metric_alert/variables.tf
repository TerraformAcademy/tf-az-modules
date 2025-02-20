variable "name" {
  type = string
 }

variable "resource_group_name" {
  type = string
}

variable "action_gorup" {
  type = map(object({
    name                = string
    resource_group_name = string
    short_name          = string
    enabled             = optional(bool, true)
    location            = optional(string, "global")
    email_receiver = optional(set(object({
      name                    = string
      email_address           = string
      use_common_alert_schema = optional(bool, false)
    })), [])
  }))

  description = "A Map of objects ,defining action groups to create"
  default     = {}
}

variable "action_group_ids" {
  type        = list(string)
  description = "A list of action group IDs to be attached with Alert Rule."
  default     = []
}

variable "criteria" {
  type = set(object({
    metric_namespace  = string
    metric_name       = string
    aggregation       = string
    operator          = string
    threshold         = number
    dimension = optional(set(object({
      name     = string
      operator = string
      values   = string
    })), [])
  }))
  description = "One or more criteria blocks to define alert conditions."
  default     = []
}

variable "auto_mitigate" {
  type        = bool
  description = "(Optional) Should the alerts in this Metric Alert be auto resolved?"
  default     = true
}

variable "description" {
  type        = string
  description = "(Optional) The description of this Metric Alert"
  default     = null
}

variable "frequency" {
  type        = string
  description = "value"
  default     = "PT1M"
}

variable "severity" {
  type        = number
  description = "(Optional) The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4."
  default     = 3
}

variable "target_resource_type" {
  type        = string
  default     = null
  description = "(Optional) The resource type (e.g. Microsoft.Compute/virtualMachines) of the target resource."
}

variable "target_resource_location" {
  type        = string
  default     = null
  description = "(Optional) The location of the target resource."
}

variable "window_size" {
  type        = string
  description = "(Optional) The period of time that is used to monitor alert activity, represented in ISO 8601 duration format. This value must be greater than frequency. Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D."
  default     = "PT5M"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the resource."
}
