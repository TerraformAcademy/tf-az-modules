variable "name" {
  type = string
  description = "Name of Action Group."
 }

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the Action Group instance."
}

variable "enabled" {
  type = bool
  description = "Whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications."
  default = true
}

variable "enabled" {
  type = bool
  description = "Whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications."
  default = true
}


variable "short_name" {
  type = string
  description = "The short name of the action group. This will be used in SMS messages."
}

variable "location" {
  type = string
  description = "The Azure Region where the Action Group should exist. Changing this forces a new Action Group to be created."
  default = "global"
}

variable "email_receiver" {
  type = set(object({
      name                    = string
      email_address           = string
      use_common_alert_schema = optional(bool, false)
    })), [])
  })

default = []
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the resource."
}
