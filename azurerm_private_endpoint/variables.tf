variable "name"{
    type = string
    description = "Specifies the Name of the Private Endpoint."
}

variable "resource_group_name"{
    type = string
    description = "Specifies the Name of the Resource Group within which the Private Endpoint should exist."
}

variable "location" {
    type = string
    description = "The supported Azure location where the resource exists."  
}

variable "subnet_id"{
    type = string
    description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint."
}

variable "custom_network_interface_name"{
    type = string
    description = "The custom name of the network interface attached to the private endpoint."
    default = null
}

variable "private_dns_zone_group" {
    type = set(object({
      name = string
      private_dns_zone_ids = list(string)
    }))
    default = []
}

variable "private_service_connection" {
    type = set(object({
      name = string
      is_manual_connection = bool
      private_connection_resource_id = optional(string, null)
      private_connection_resource_alias = optional(string, null)
      subresource_names = optional(list(string), [])
      request_message = optional(string, null)

    }))
    default = []
}

variable "ip_configuration" {
    name = string
    private_ip_address = string
    subresource_name = optional(string, null)
    member_name = optional(string, null)  
}

variable "tags" {
    default = {}
  
}