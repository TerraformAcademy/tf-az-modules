variable "name" {
  type        = string
  description = "The name of the Container Apps Managed Environment. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Container App Environment is to be created."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the Container App Environment is to exist."
}

variable "dapr_application_insights_connection_string" {
  type        = string
  description = "Application Insights connection string used by Dapr to export Service to Service communication telemetry."
  default     = null
}

variable "infrastructure_resource_group_name" {
  type        = string
  description = " Name of the platform-managed resource group created for the Managed Environment to host infrastructure resources."
  default     = null
}

variable "infrastructure_subnet_id" {
  type        = string
  description = "The existing Subnet to use for the Container Apps Control Plane. "
  default     = null
}

variable "internal_load_balancer_enabled" {
  type        = bool
  description = "Should the Container Environment operate in Internal Load Balancing Mode?"
  default     = false
}

variable "zone_redundancy_enabled" {
  type        = bool
  description = "Should the Container App Environment be created with Zone Redundancy enabled? "
  default     = false
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The ID for the Log Analytics Workspace to link this Container Apps Managed Environment to."
  default     = null
}

variable "workload_profile" {
  type = set(object({
    name                  = string
    workload_profile_type = string
    maximum_count         = number
    minimum_count         = number
  }))
  description = "The profile of the workload to scope the container app execution."
  default     = []
}

variable "tags" {
  type        = map(any)
  description = " A mapping of tags to assign to the resource."
  default     = {}
}