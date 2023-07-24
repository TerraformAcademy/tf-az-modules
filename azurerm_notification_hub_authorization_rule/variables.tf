variable "name" {
  type        = string
  description = "(Required) The name to use for this Authorization Rule. Changing this forces a new resource to be created."
}

variable "notification_hub_name" {
  type        = string
  description = " (Required) The name of the Notification Hub for which the Authorization Rule should be created. Changing this forces a new resource to be created."
}

variable "namespace_name" {
  type        = string
  description = " (Required) The name of the Notification Hub Namespace in which the Notification Hub exists. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which the Notification Hub Namespace exists. Changing this forces a new resource to be created."
}

variable "manage" {
  type        = bool
  description = "(Optional) Does this Authorization Rule have Manage access to the Notification Hub?"
  default     = false
}

variable "send" {
  type        = bool
  description = "(Optional) Does this Authorization Rule have Send access to the Notification Hub?"
  default     = false
}

variable "listen" {
  type        = bool
  description = "(Optional) Does this Authorization Rule have Listen access to the Notification Hub?"
  default     = false
}