variable "name" {
  type        = string
  description = "The name which should be used for this Data Factory"
}

variable "data_factory_id" {
  type        = string
  description = "The Data Factory ID in which to associate the Linked Service with."
}

variable "location" {
  type        = string
  description = "Azure Region."
}

variable "node_size" {
  type        = string
  description = "(Required) The size of the nodes on which the Azure-SSIS Integration Runtime runs."
}

variable "number_of_nodes" {
  type        = number
  description = "(Optional) Number of nodes for the Azure-SSIS Integration Runtime. Max is 10."
  default     = 1
}

variable "credential_name" {
  type        = string
  description = " (Optional) The name of a Data Factory Credential that the SSIS integration will use to access data sources."
  default     = null
}

variable "max_parallel_executions_per_node" {
  type        = number
  description = "(Optional) Defines the maximum parallel executions per node."
  default     = 1
}

variable "edition" {
  type        = string
  description = "(Optional) The Azure-SSIS Integration Runtime edition. Valid values are Standard and Enterprise."
  default     = "Standard"
}

variable "license_type" {
  type        = string
  description = " (Optional) The type of the license that is used. Valid values are LicenseIncluded and BasePrice."
  default     = "LicenseIncluded"
}

variable "catalog_info" {
  type = set(object({
    server_endpoint        = string
    administrator_login    = optional(string, null)
    administrator_password = optional(string, null)
    pricing_tier           = optional(string)
    elastic_pool_name      = optional(string)
    dual_standby_pair_name = optional(string)
  }))

  default = []
}

variable "custom_setup_script" {
  type = set(object({
    blob_container_uri = string
    sas_token          = string
  }))

  default = []
}

variable "express_custom_setup" {
  type = set(object({
    command_key = optional(set(object({
      target_name = string
      user_name   = string
      password    = optional(string, null)
      key_vault_password = optional(set(object({
        linked_service_name = string
        secret_name         = string
        secret_version      = optional(string)
        parameters          = optional(map(string))
      })))
    })), [])
    component = optional(set(object({
      name    = string
      license = optional(string, null)
      key_vault_license = optional(set(object({
        linked_service_name = string
        secret_name         = string
        secret_version      = optional(string)
        parameters          = optional(map(string))
      })))

    })), [])
    environment        = optional(list(string), [])
    powershell_version = optional(string, null)
  }))
}

variable "express_vnet_integration" {
  type = set(object({
    subnet_id = string
  }))

  default = []
}

variable "package_store" {
  type = set(object({
    name                = string
    linked_service_name = string
  }))

  default = []
}

variable "proxy" {
  type = set(object({
    self_hosted_integration_runtime_name = string
    staging_storage_linked_service_name  = string
    path                                 = optional(string)
  }))

  default = []
}

variable "vnet_integration" {
  type = set(object({
    vnet_id     = optional(string)
    subnet_name = optional(string)
    subnet_id   = optional(string)
    public_ips  = optional(list(string))
  }))
}

variable "description" {
  type        = string
  description = "(Optional) Integration runtime description."
  default     = null
}