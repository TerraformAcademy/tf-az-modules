variable "ir_azure" {
  type = map(object({
    name                    = string
    data_factory_id         = string
    location                = string
    description             = optional(string, null)
    cleanup_enabled         = optional(bool, true)
    compute_type            = optional(string, "General")
    core_count              = optional(number, 8)
    time_to_live_min        = optional(number, 0)
    virtual_network_enabled = optional(bool, false)
  }))

  default = {}
}

variable "ir_self_hosted" {
  type = map(object({
    name            = string
    data_factory_id = string
    description     = optional(string, null)
    rbac_authorization = optional(set(object({
      resource_id = string
    })), [])
  }))

  default = {}
}

variable "ir_ssis" {
  type = map(object({
    name                             = string
    data_factory_id                  = string
    location                         = string
    node_size                        = string
    number_of_nodes                  = optional(number, 1)
    credential_name                  = optional(string, null)
    max_parallel_executions_per_node = optional(number, 1)
    edition                          = optional(string, "Standard")
    license_type                     = optional(string, "LicenseIncluded")
    catalog_info = optional(set(object({
      server_endpoint        = string
      administrator_login    = optional(string, null)
      administrator_password = optional(string, null)
      pricing_tier           = optional(string)
      elastic_pool_name      = optional(string)
      dual_standby_pair_name = optional(string)
    })), [])
    custom_setup_script = optional(set(object({
      blob_container_uri = string
      sas_token          = string
    })), [])
    express_custom_setup = optional(set(object({
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
    })), [])
    express_vnet_integration = optional(set(object({
      subnet_id = string
    })), [])
    package_store = optional(set(object({
      name                = string
      linked_service_name = string
    })), [])
    proxy = optional(set(object({
      self_hosted_integration_runtime_name = string
      staging_storage_linked_service_name  = string
      path                                 = optional(string)
    })), [])
    vnet_integration = optional(set(object({
      vnet_id     = optional(string)
      subnet_name = optional(string)
      subnet_id   = optional(string)
      public_ips  = optional(list(string))
    })), [])
    description = optional(string, null)
  }))
}