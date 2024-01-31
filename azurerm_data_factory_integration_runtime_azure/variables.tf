variable "name" {
  type        = string
  description = "The name which should be used for this Data Factory"
}

variable "data_factory_id" {
  type        = string
  description = "The Data Factory ID in which to associate the Linked Service with."
}

variable "location" {
  type        = string
  description = "Azure Region."
  default     = "AutoResolve"
}

variable "description" {
  type        = string
  description = "Integration runtime description."
  default     = null
}

variable "cleanup_enabled" {
  type        = bool
  description = "Cluster will not be recycled and it will be used in next data flow activity run until TTL (time to live) is reached if this is set as false."
  default     = true
}

variable "compute_type" {
  type        = string
  description = "Compute type of the cluster which will execute data flow job. Valid values are General, ComputeOptimized and MemoryOptimized."
  default     = "General"
}

variable "core_count" {
  type        = number
  description = "Core count of the cluster which will execute data flow job. Valid values are 8, 16, 32, 48, 80, 144 and 272."
  default     = 8
}

variable "time_to_live_min" {
  type        = number
  description = "Time to live (in minutes) setting of the cluster which will execute data flow job. "
  default     = 0
}

variable "virtual_network_enabled" {
  type        = bool
  description = "Is Integration Runtime compute provisioned within Managed Virtual Network?"
  default     = false
}