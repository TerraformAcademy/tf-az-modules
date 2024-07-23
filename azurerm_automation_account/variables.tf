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
}
