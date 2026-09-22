variable "name" {
  type        = string
  description = "(Required) The name which should be used for the Fabric Capacity."
}

variable "location" {
  type        = string
  description = "(Required) The supported Azure location where the Fabric Capacity exists."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Fabric Capacity."
}

variable "sku" {
  type = object({
    name = string # (Required) The name of the SKU to use for the Fabric Capacity. Possible values are F2, F4, F8, F16, F32, F64, F128, F256, F512, F1024, F2048.
    tier = string # (Required) The tier of the SKU to use for the Fabric Capacity. The only possible value is Fabric.
  })

  description = "(Required) A sku block as defined above."
}

variable "administration_members" {
  type        = list(string)
  description = "(Optional) An array of administrator user identities. The member must be an Entra user or a service principal."
  default     = []
}