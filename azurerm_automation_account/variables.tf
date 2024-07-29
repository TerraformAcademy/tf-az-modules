variable "name" {

}

variable "resource_group_name" {

}

variable "location" {

}

variable "sku_name" {

}

variable "runbook" {
  type = map(object({
    name         = string
    runbook_type = string
    log_progress = string
    log_verbose  = string
    publish_content_link = optional(set(object({
      uri     = string
      version = optional(string, null)
      hash = optional(set(object({
        algorithm = string
        value     = string
      })), [])
    })), [])

    description              = optional(string, null)
    content                  = optional(string)
    log_activity_trace_level = optional(number, 0)

    draft = optional(set(object({
      edit_mode_enabled = optional(bool, true)

      content_link = optional(set(object({
        uri     = string
        version = optional(string, null)

        hash = optional(set(object({
          algorithm = string
          value     = string
        })), [])
      })), [])

      output_types = optional(string, null)
      parameters = optional(list(object({
        key           = string
        type          = string
        mandatory     = optional(bool)
        position      = optional(string)
        default_value = optional(string)
      })), [])

    })), [])

    job_schedule = optional(set(object({
      schedule_name = string
      parameters    = optional(map(string), {})
      run_on        = optional(string, null)
    })))
  }))

  default = {}
}

variable "schedule" {
  type = map(object({
    name        = string
    frequency   = string
    description = optional(string, null)
    interval    = optional(number, 1)
    start_time  = optional(string, null)
    expiry_time = optional(string, null)
    timezone    = optional(string, null)
    week_days   = optional(list(string), [])
    month_days  = optional(list(string), [])

    monthly_occurrence = optional(set(object({
      day        = string
      occurrence = number
    })), [])
  }))

  default = {}
}

variable "identity" {
  type = set(object({
    type         = string #(Required) Specifies the type of Managed Service Identity that should be configured on this Automation Account. Only possible value is UserAssigned.
    identity_ids = string #(Required) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Automation Account.
  }))

  default = []
}

variable "local_authentication_enabled" {
  type = bool
  default = true
}

variable "public_network_access_enabled" {
  type = bool
  default = true
}

variable "encryption" {
  type = set(object({
    key_vault_key_id = string
    user_assigned_identity_id = optional(string)
  }))

  default = []
}

variable "tags" {
  type = map(string)
  default = {}
}