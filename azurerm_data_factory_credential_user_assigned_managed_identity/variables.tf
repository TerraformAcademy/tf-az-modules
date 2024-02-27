variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Credential."
}

variable "data_factory_id" {
  type        = string
  description = "(Required) The Data Factory ID in which to associate the Credential with. "
}

variable "identity_id" {
  type        = string
  description = "(Required) The Resouce ID of an existing User Assigned Managed Identity."
}

variable "annotations" {
  type        = list(string)
  description = "(Optional) List of tags that can be used for describing the Data Factory Credential."
  default     = []
}

variable "description" {
  type        = string
  description = "(Optional) The description for the Data Factory Credential."
  default     = null
}