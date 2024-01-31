variable "name" {
  type        = string
  description = "The name which should be used for this Data Factory"
}

variable "data_factory_id" {
  type        = string
  description = "The Data Factory ID in which to associate the Linked Service with."
}

variable "description" {
  type        = string
  description = "Integration runtime description."
  default     = null
}

variable "rbac_authorization" {
  type = set(object({
    resource_id = string
  }))
}