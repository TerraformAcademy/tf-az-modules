variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Databricks Workspace resource."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which the Databricks Workspace should exist."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource has to be created."
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
}

variable "sku" {
  type        = string
  description = "(Required) The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial."
}

variable "load_balancer_backend_address_pool_id" {
  type        = string
  description = "(Optional) Resource ID of the Outbound Load balancer Backend Address Pool for Secure Cluster Connectivity (No Public IP) workspace with managed virtual network. Changing this forces a new resource to be created."
  default     = null
}

variable "managed_services_cmk_key_vault_id" {
  type        = string
  description = "(Optional) Resource ID of the Key Vault which contains the managed_services_cmk_key_vault_key_id key."
  default     = null
}

variable "managed_disk_cmk_key_vault_id" {
  type        = string
  description = "(Optional) Resource ID of the Key Vault which contains the managed_disk_cmk_key_vault_key_id key."
  default     = null
}

variable "managed_services_cmk_key_vault_key_id" {
  type        = string
  description = "(Optional) Customer managed encryption properties for the Databricks Workspace managed resources(e.g. Notebooks and Artifacts)."
  default     = null
}

variable "managed_disk_cmk_key_vault_key_id" {
  type        = string
  description = "(Optional) Customer managed encryption properties for the Databricks Workspace managed disks."
  default     = null
}

variable "managed_disk_cmk_rotation_to_latest_version_enabled" {
  type        = string
  description = "(Optional) Whether customer managed keys for disk encryption will automatically be rotated to the latest version."
  default     = null
}

variable "managed_resource_group_name" {
  type        = string
  description = "(Optional) The name of the resource group where Azure should place the managed Databricks resources."
  default     = null
}

variable "customer_managed_key_enabled" {
  type        = bool
  description = "(Optional) Is the workspace enabled for customer managed key encryption? If true this enables the Managed Identity for the managed storage account."
  default     = false
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  description = "(Optional) Is the Databricks File System root file system enabled with a secondary layer of encryption with platform managed keys? Possible values are true or false."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Allow public access for accessing workspace. Set value to false to access workspace only via private link endpoint. Possible values include true or false."
  default     = true
}

variable "default_storage_firewall_enabled" {
  type        = bool
  description = "(Optional) Disallow public access to default storage account."
  default     = false
}

variable "access_connector_id" {
  type        = string
  description = "(Optional) Access Connector ID to use when default storage account firewall is enabled. "
  default     = null
}

variable "network_security_group_rules_required" {
  type        = string
  description = "(Optional) Does the data plane (clusters) to control plane communication happen over private link endpoint only or publicly? Possible values AllRules, NoAzureDatabricksRules or NoAzureServiceRules."
  default     = null
}

variable "custom_parameters" {
  type = set(object({
    machine_learning_workspace_id                        = optional(string, null)
    nat_gateway_name                                     = optional(string, null)
    public_ip_name                                       = optional(string, null)
    no_public_ip                                         = optional(bool, false)
    public_subnet_name                                   = optional(string, null)
    public_subnet_network_security_group_association_id  = optional(string, null)
    private_subnet_name                                  = optional(string, null)
    private_subnet_network_security_group_association_id = optional(string, null)
    storage_account_name                                 = optional(string, null)
    storage_account_sku_name                             = optional(string, "Standard_GRS")
    virtual_network_id                                   = optional(string, null)
    vnet_address_prefix                                  = optional(string, null)
  }))
}