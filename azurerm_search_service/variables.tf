variable "name" {
  description = "The name of the Search Service."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name for the Search Service."
  type        = string
}

variable "location" {
  description = "The location for the Search Service."
  type        = string
}

variable "sku" {
  description = "The SKU name for the Search Service (e.g. basic, standard)."
  type        = string
  default     = "standard"
}

variable "allowed_ips" {
  description = "(Optional) Specifies a list of inbound IPv4 or CIDRs that are allowed to access the Search Service."
  type        = list(string)
  default     = []
}

variable "replica_count" {
  description = "Replica count for the service (optional)."
  type        = number
  default     = null
}

variable "partition_count" {
  description = "Partition count for the service (optional)."
  type        = number
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to assign to the Search Service."
  type        = map(string)
  default     = {}
}

variable "identity_type" {
  description = "Identity type: SystemAssigned, UserAssigned, or 'SystemAssigned, UserAssigned'."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "List of user-assigned identity IDs (optional)."
  type        = list(string)
  default     = []
}

variable "network_rule_set" {
  description = "Network rule set block for Search Service (optional)."
  type = object({
    ip_rules = optional(list(object({
      value = string
    })))
  })
  default = null
}

variable "authentication_failure_mode" {
  type        = string
  description = "(Optional) Specifies the response that the Search Service should return for requests that fail authentication."
  default     = null
}

variable "customer_managed_key_enforcement_enabled" {
  description = "(Optional) Specifies whether the Search Service should enforce that non-customer resources are encrypted."
  type        = bool
  default     = false
}

variable "hosting_mode" {
  type        = string
  description = "(Optional) Specifies the hosting mode for the Search Service. Possible values are 'default' and 'highDensity'."
  default     = null
}

variable "local_authentication_enabled" {
  description = "(Optional) Specifies whether the Search Service allows authenticating using API Keys?"
  type        = bool
  default     = false
}

variable "network_rule_bypass_option" {
  description = "(Optional) Specifies the network rule bypass option for the Search Service. Possible values are 'AzureServices' and 'None'."
  type        = string
  default     = "None"
}

variable "semantic_search_sku" {
  type        = string
  description = "(Optional) Specifies the Semantic Search SKU which should be used for this Search Service. Possible values include free and standard."
  default     = null
}