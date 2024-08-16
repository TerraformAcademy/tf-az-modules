variable "name" {
  type = string
  description = "(Required) Specifies the name of the Databricks Virtual Network Peering resource."
}

variable "resource_group_name" {
    type = string
    description = "Required) The name of the Resource Group in which the Databricks Virtual Network Peering should exist."
}

variable "workspace_id" {
    type = string
    description = "(Required) The ID of the Databricks Workspace that this Databricks Virtual Network Peering is bound."
}

variable "address_space_prefixes" {
  type = list(string)
  description = "Required) A list of address blocks reserved for this virtual network in CIDR notation."
}

variable "remote_address_space_prefixes" {
  type = list(string)
  description = "(Required) A list of address blocks reserved for the remote virtual network in CIDR notation. "
}

variable "remote_virtual_network_id" {
  type = string
  description = "(Required) The ID of the remote virtual network. Changing this forces a new resource to be created."
}

variable "allow_virtual_network_access" {
  type = bool
  description = "(Optional) Can the VMs in the local virtual network space access the VMs in the remote virtual network space? Defaults to true."
  default = true
}

variable "allow_forwarded_traffic" {
  type = bool
  description = "(Optional) Can the forwarded traffic from the VMs in the local virtual network be forwarded to the remote virtual network?"
  default = false
}

variable "allow_gateway_transit" {
  type = bool
  description = "Optional) Can the gateway links be used in the remote virtual network to link to the Databricks virtual network?"
  default = false
}

variable "use_remote_gateways" {
  type = bool
  description = "(Optional) Can remote gateways be used on the Databricks virtual network?"
  default = false
}

