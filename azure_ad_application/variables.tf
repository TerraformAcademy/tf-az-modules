variable "display_name" {
  type = string
}

variable "description" {
  type    = string
  default = null
}

variable "device_only_auth_enabled" {
  type    = bool
  default = false
}

variable "fallback_public_client_enabled" {
  type    = bool
  default = false
}

variable "group_membership_claims" {
  type    = list(string)
  default = null
}

variable "identifier_uris" {
  type    = list(string)
  default = []
}

variable "marketing_url" {
  type    = string
  default = null
}

variable "oauth2_post_response_required" {
  type    = bool
  default = false
}

variable "owners" {
  type    = list(string)
  default = []
}

variable "privacy_statement_url" {
  type    = string
  default = null
}

variable "sign_in_audience" {
  type    = string
  default = null
}

variable "support_url" {
  type    = string
  default = null
}

variable "template_id" {
  type    = string
  default = null
}

variable "terms_of_service_url" {
  type    = string
  default = null
}

variable "web" {
  type = set(object({
    homepage_url = optional(string, null)
    implicit_grant = optional(set(object({
      access_token_issuance_enabled = optional(bool)
      id_token_issuance_enabled     = optional(bool)
    })), [])
    logout_url    = optional(string, null)
    redirect_uris = optional(list(string), [])
  }))
  default = []
}

variable "app_role" {
  type = set(object({
    allowed_member_types = list(string)
    description          = string
    display_name         = string
    enabled              = optional(bool, true)
    id                   = string
    value                = optional(string, null)
  }))
  default = []
}

variable "api" {
  type = set(object({
    known_client_applications      = optional(list(string), [])
    mapped_claims_enabled          = optional(bool, false)
    requested_access_token_version = optional(string, null)
    oauth2_permission_scope = optional(set(object({
      admin_consent_description  = string
      admin_consent_display_name = string
      enabled                    = optional(bool, true)
      id                         = string
      type                       = optional(string, "user")
      user_consent_description   = optional(string, null)
      user_consent_display_name  = optional(string, null)
      value                      = optional(string, null)
    })), [])
  }))
  default = []
}