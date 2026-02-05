variable "name" {
  type = string
  description = "(Required) Specifies the name of the Data Factory. Changing this forces a new resource to be created. Must be globally unique."
}

variable "resource_group_name" {
  type = string
  description = "(Required) The name of the resource group in which to create the Data Factory."
}

variable "location" {
  type = string
  description = "(Required) Specifies the supported Azure location where the resource exists."
}

variable "github_configuration" {
  type = list(object({
    account_name = string
    branch_name = string
    git_url = optional(string, null)
    repository_name = string
    root_folder = optional(string, null)
    publishing_enabled = optional(bool, true)
  }))
}

variable "global_parameter" {
  type = list(object({
    account_name = string
    type = string
    value = string
  }))
}

variable "identity" {
  type = list(object({
    type         = string                 # (Required) Specifies the type of Managed Service Identity that should be configured on this Data Factory. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
    identity_ids = optional(list(string)) # (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Data Factory.
  }))
  description = "(Optional) An identity block as documented above."

  default = []
}

variable "vsts_configuration" {
  type = list(object({
    account_name = string
    branch_name = string
    project_name = string 
    repository_name = string
    root_folder = string
    tenant_id = string
    publishing_enabled = optional(bool, true)
  }))
}

variable "managed_virtual_network_enabled" {
  type = bool
  description = "(Optional) Is Managed Virtual Network enabled?"
  default = false
}

variable "public_network_enabled" {
  type = bool
  description = "(Optional) Is the Data Factory visible to the public network?"
  default = false
}

variable "customer_managed_key_id" {
  type = string
    description = "(Optional) Specifies the Azure Key Vault Key ID to be used as the Customer Managed Key (CMK) for double encryption. Required with user assigned identity."
    default = null
}

variable "customer_managed_key_identity_id" {
  type = string
  description = "(Optional) Specifies the ID of the user assigned identity associated with the Customer Managed Key."
  default = null
}

variable "purview_id" {
  type = string
  description = "(Optional) Specifies the ID of the purview account resource associated with the Data Factory."
  default = null
}

variable "tags" {
  type = map(any)
  description = "(Required) A mapping of tags to assign to the resource."
}