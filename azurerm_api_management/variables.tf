variable "name" {

}

variable "resource_group_name" {

}

variable "location" {

}

variable "sku_name" {

}

variable "publisher_email" {

}

variable "publisher_name" {

}

variable "hostname_configuration" {
  type = set(object({
    management = optional(set(object({
      hostname                        = string
      key_vault_id                    = optional(string, null)
      certificate                     = optional(string, null)
      certificate_password            = optional(string, null)
      negotiate_client_certificate    = optional(bool, false)
      ssl_keyvault_identity_client_id = optional(string, null)
    })), [])

    portal = optional(set(object({
      hostname                        = string
      key_vault_id                    = optional(string, null)
      certificate                     = optional(string, null)
      certificate_password            = optional(string, null)
      negotiate_client_certificate    = optional(bool, false)
      ssl_keyvault_identity_client_id = optional(string, null)
    })), [])

    developer_portal = optional(set(object({
      hostname                        = string
      key_vault_id                    = optional(string, null)
      certificate                     = optional(string, null)
      certificate_password            = optional(string, null)
      negotiate_client_certificate    = optional(bool, false)
      ssl_keyvault_identity_client_id = optional(string, null)
    })), [])

    scm = optional(set(object({
      hostname                        = string
      key_vault_id                    = optional(string, null)
      certificate                     = optional(string, null)
      certificate_password            = optional(string, null)
      negotiate_client_certificate    = optional(bool, false)
      ssl_keyvault_identity_client_id = optional(string, null)
    })), [])

    proxy = optional(set(object({
      default_ssl_binding             = optional(bool, false)
      hostname                        = string
      key_vault_id                    = optional(string, null)
      certificate                     = optional(string, null)
      certificate_password            = optional(string, null)
      negotiate_client_certificate    = optional(bool, false)
      ssl_keyvault_identity_client_id = optional(string, null)
    })), [])

  }))
}