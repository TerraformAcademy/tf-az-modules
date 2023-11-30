variable "name" {
  type        = string
  description = "(Required) The name which should be used for this Data Collection Endpoint."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Data Collection Endpoint should exist."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group where the Data Collection Endpoint should exist."
}

variable "description" {
  type        = string
  description = "(Optional) Specifies a description for the Data Collection Endpoint."
  default     = null
}

variable "kind" {
  type        = string
  description = "(Optional) The kind of the Data Collection Endpoint. Possible values are Linux and Windows."
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether network access from public internet to the Data Collection Endpoint are allowed. Possible values are true and false."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags which should be assigned to the Data Collection Endpoint."
}

