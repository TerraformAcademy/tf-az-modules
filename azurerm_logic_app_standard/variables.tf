variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Logic App Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Logic App."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists."
}

variable "app_service_plan_id" {
  type        = string
  description = "(Required) The ID of the App Service Plan within which to create this Logic App."
}

variable "app_settings" {
  type        = map(any)
  description = "(Optional) A map of key-value pairs for App Settings and custom values."
  default     = {}
}

variable "use_extension_bundle" {
  type        = bool
  description = "(Optional) Should the logic app use the bundled extension package?"
  default     = true
}

variable "bundle_version" {
  type        = string
  description = "(Optional) If use_extension_bundle then controls the allowed range for bundle versions. Default [1.*, 2.0.0)."
  default     = "1.*, 2.0.0"
}

variable "connection_string" {
  type = set(object({
    name  = string
    type  = string
    value = string
  }))
  description = "(Optional) An connection_string block as defined below."
  default = []
}

variable "client_affinity_enabled" {
  type        = bool
  description = "(Optional) Should the Logic App send session affinity cookies, which route client requests in the same session to the same instance?"
  default     = false
}

variable "client_certificate_mode" {
  type        = string
  description = "(Optional) The mode of the Logic App's client certificates requirement for incoming requests. Possible values are Required and Optional."
  default     = null
}

variable "enabled" {
  type        = bool
  description = "tional) Is the Logic App enabled? Defaults to true."
  default     = true
}

variable "https_only" {
  type        = bool
  description = "(Optional) Can the Logic App only be accessed via HTTPS?"
  default     = true
}

variable "identity" {
  type = list(object({
    type         = string                 # (Required) Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
    identity_ids = optional(list(string)) # (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account.
  }))
  description = "(Optional) An identity block as documented above."

  default = []
}
variable "site_config" {
  type = object({
    always_on       = optional(bool, false)
    app_scale_limit = optional(number)
    cors = optional(set(object({
      allowed_regions     = list(string)
      support_credentials = optional(bool)
    })), [])
    dotnet_framework_version = optional(string)
    elastic_instance_minimum = optional(number)
    ftps_state               = optional(string, "FtpsOnly")
    health_check_path        = optional(string)
    http2_enabled            = optional(bool, false)
    ip_restriction = optional(list(object({
      ip_address                = optional(string)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      name                      = optional(string)
      priority                  = optional(string)
      action                    = optional(string, "Allow")
      headers = optional(list(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(list(string))
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      })))
    })), [])
    scm_ip_restriction = optional(list(object({
      ip_address                = optional(string)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      name                      = optional(string)
      priority                  = optional(string)
      action                    = optional(string, "Allow")
      headers = optional(list(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(list(string))
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      })))
    })), [])
  })

  description = " (Optional) A site_config object."
  default     = {}
}

variable "scm_use_main_ip_restriction" {
  type        = bool
  description = " (Optional) Should the Logic App ip_restriction configuration be used for the SCM too."
  default     = false
}

variable "scm_min_tls_version" {
  type        = string
  description = " (Optional) Configures the minimum version of TLS required for SSL requests to the SCM site. Possible values are 1.0, 1.1 and 1.2."
  default     = "1.2"
}

variable "scm_type" {
  type        = string
  description = " (Optional) The type of Source Control used by the Logic App in use by the Windows Function App."
  default     = "None"
}

variable "linux_fx_version" {
  type        = string
  description = "(Optional) Linux App Framework and version for the AppService, e.g. DOCKER|(golang:latest)."
  default     = null
}

variable "min_tls_version" {
  type        = string
  description = "(Optional) The minimum supported TLS version for the Logic App."
  default     = "1.2"
}

variable "pre_warmed_instance_count" {
  type        = number
  description = "(Optional) The number of pre-warmed instances for this Logic App Only affects apps on the Premium plan."
  default     = 0
}

variable "runtime_scale_monitoring_enabled" {
  type        = bool
  description = "Optional) Should Runtime Scale Monitoring be enabled?"
  default     = false
}

variable "use_32_bit_worker_process" {
  type        = bool
  description = "(Optional) Should the Logic App run in 32 bit mode, rather than 64 bit mode?"
  default     = true
}

variable "vnet_route_all_enabled" {
  type        = bool
  description = " (Optional) Should all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied."
  default     = false
}

variable "websockets_enabled" {
  type        = bool
  description = "(Optional) Should WebSockets be enabled?"
  default     = false
}

variable "storage_account_name" {
  type        = string
  description = "(Required) The backend storage account name which will be used by this Logic App (e.g. for Stateful workflows data)."
}

variable "storage_account_access_key" {
  type        = string
  description = "(Required) The access key which will be used to access the backend storage account for the Logic App."
}

variable "storage_account_share_name" {
  type        = string
  description = "(Optional) The name of the share used by the logic app, if you want to use a custom name."
  default     = null
}

variable "app_version" {
  type        = string
  description = "(Optional) The runtime version associated with the Logic App."
  default     = "~3"
}