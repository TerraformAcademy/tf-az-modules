variable "workspace_id" {
  type = string
  description = "(Required) The resource ID of the Databricks Workspace."
}

variable "key_vault_key_id" {
  type = string
  description = "(Required) The resource ID of the Key Vault Key to be used."
}

variable "key_vault_id" {
  type = string
  description = "(Optional) Specifies the Resource ID of the Key Vault which contains the key_vault_key_id."
  default = null
}