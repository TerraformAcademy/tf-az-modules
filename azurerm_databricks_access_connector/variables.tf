variable "name" {
  type = string
  description = "(Required) Specifies the name of the Databricks Access Connector resource."
}

variable "resource_group_name" {
    type = string
    description = "(Required) The name of the Resource Group in which the Databricks Access Connector should exist."
}

variable "location" {
    type = string
    description = "(Required) Specifies the supported Azure location where the resource has to be created."
}

variable "tags" {
  type = map(any)
  description = "Optional) A mapping of tags to assign to the resource."
  default = {}
}

variable "identity" {
  type = set(object({
    type         = string #(Required) Specifies the type of Managed Service Identity that should be configured on the Databricks Access Connector. Possible values include SystemAssigned or UserAssigned.
    identity_ids = string #(Required) Specifies a list of User Assigned Managed Identity IDs to be assigned to the Databricks Access Connector.
  }))

  default = []
}
