variable "name" {
  type        = string
  description = "(Required) The name which should be used for this Service Plan."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group where the AppService should exist."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Service Plan should exist."
}

variable "os_type" {
  type        = string
  description = "(Required) The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer."
}

variable "sku_name" {
  type        = string
  description = "Required) The SKU for the plan."
}

variable "app_service_environment_id" {
  type        = string
  description = "(Optional) The ID of the App Service Environment to create this Service Plan in."
  default     = null
}

variable "maximum_elastic_worker_count" {
  type        = number
  description = "(Optional) The maximum number of workers to use in an Elastic SKU Plan."
  default     = null
}

variable "worker_count" {
  type        = number
  description = "(Optional) The number of Workers (instances) to be allocated."
  default     = 1
}

variable "per_site_scaling_enabled" {
  type        = bool
  description = "(Optional) Should Per Site Scaling be enabled."
  default     = false
}

variable "zone_balancing_enabled" {
  type        = bool
  description = "(Optional) Should the Service Plan balance across Availability Zones in the region. Changing this forces a new resource to be created."
  default     = false
}

variable "tags" {
  type        = map(any)
  description = "(Required)  A mapping of tags which should be assigned to the AppService."
}