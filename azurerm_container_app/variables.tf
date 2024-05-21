variable "name" {
  type        = string
  description = "The name for this Container App. Changing this forces a new resource to be created."
}

variable "container_app_environment_id" {
  type        = string
  description = "The ID of the Container App Environment within which this Container App should exist."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Container App Environment is to be created."
}

variable "revision_mode" {
  type        = string
  default     = "Single"
  description = " The revisions operational mode for the Container App. Possible values include Single and Multiple."
}

variable "template" {
  type = set(object({
    init_contianer = optional(set(object({
      args    = optional(list(string), [])
      command = optional(string, null)
      cpu     = optional(string, null)
      env = optional(set(object({
        name        = string
        secret_name = optional(string, null)
        value       = optional(string, null)
      })))
      ephemeral_storage = optional(string, null)
      image             = string
      memory            = optional(string, null)
      name              = string
      volume_mounts = optional(object({
        name = string
        path = string
      }))
    })), [])
    container = set(object({
      args    = optional(list(string), [])
      command = optional(string, null)
      cpu     = optional(string, null)
      env = optional(set(object({
        name        = string
        secret_name = optional(string, null)
        value       = optional(string, null)
      })), null)
      ephemeral_storage = optional(string, null)
      image             = string
      liveness_probe = optional(object({

      }), {})
      memory = optional(string, null)
      name   = string
      volume_mounts = optional(object({
        name = string
        path = string
      }))
    }))
  }))
}

variable "tags" {
  type = map(any)
  default = {

  }

  description = "A mapping of tags to assign to the Container App."
}
