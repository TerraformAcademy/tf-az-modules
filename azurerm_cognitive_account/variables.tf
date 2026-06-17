variable "name" {
  description = "The name of the Cognitive Account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Cognitive Account is created."
  type        = string
}

variable "location" {
  description = "The Azure location for the Cognitive Account."
  type        = string
}

variable "kind" {
  description = "The Cognitive Account kind."
  type        = string
  default     = "AIServices"
}

variable "sku_name" {
  description = "The SKU name for the Cognitive Account."
  type        = string
}

variable "project_management_enabled" {
  description = "Whether project management is enabled."
  type        = bool
  default     = true
}

variable "custom_subdomain_name" {
  description = "The custom subdomain name used for the Cognitive Account."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
  default     = false
}

variable "fqdns" {
  description = "Optional FQDNs allowed for the Cognitive Account."
  type        = list(string)
  default     = []
}

variable "identity_type" {
  description = "Managed identity type for the Cognitive Account."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "User assigned identity IDs when using UserAssigned or SystemAssigned, UserAssigned."
  type        = list(string)
  default     = []
}

variable "network_injection_subnet_id" {
  description = "Subnet ID used for agent network injection."
  type        = string
  default     = null
}

variable "storage_account_id" {
  description = "Full resource ID of the storage account associated with the Cognitive Account."
  type        = string
  default     = null
}

variable "storage_identity_client_id" {
  description = "The client ID of the managed identity associated with the storage account."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to assign to the Cognitive Account."
  type        = map(string)
  default     = {}
}
