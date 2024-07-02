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


variable "dapr" {
  type = set(object({
    app_id = string
    app_port = optional(number, null)
    app_protocol = optional(string, null)
  }))

  default = []
}

variable "registry" {
  type = set(object({
    server = string
    identity = optional(string, null)
    password_secret_nae = otpional(string, null)
    username = otpional(string, null)
  }))

  default = []
}

variable "identity" {
  type = list(object({
    type         = string                 # (Required) Specifies the type of Managed Service Identity that should be configured on this Container App. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
    identity_ids = optional(list(string)) # (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Container App.
  }))
  description = "(Optional) An identity block as documented above."

  default = []
}

variable "ingress" {
  type = set(object({
    allow_insecure_connections = optional(bool, false)
    custom_domain = optional(set(object({
        certificate_binding_type = optional(string, "Disabled")
        certificate_id = string
        name = string
    })), [])

    fqdn = optional(string, null)
    external_enabled = optional(bool, false)
    target_port = number
    exposed_port = optional(number, null)
    traffic_weight = set(object({
      label = optional(string, null)
      latest_revision = optional(bool, false)
      revision_suffix = optional(string, null)
      percentage = number
    }))
    transport = optional(string, "auto")
  }))
}

variable "secret" {
  type = set(object({
    name =  string
    # identity = optional(string, null)
    # key_vault_secret_id = optional(string, null)
    value = optional(string, null)
  }))

  default = []
}


variable "workload_profile_name" {
  type = string
  default = null
}