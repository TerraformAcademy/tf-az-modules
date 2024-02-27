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
}

variable "ir_self_hosted" {
  
}

variable "ir_ssis" {
  
}