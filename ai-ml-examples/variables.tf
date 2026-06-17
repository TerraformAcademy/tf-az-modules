variable "resource_group_name" {
  description = "The name of the existing resource group used by the cognitive account example."
  type        = string
}

variable "subnet_resource_group_name" {
  description = "The resource group that contains the agent subnet."
  type        = string
}

variable "virtual_network_name" {
  description = "The virtual network name containing the agent subnet."
  type        = string
}

variable "agent_subnet_name" {
  description = "The subnet used for agent network injection."
  type        = string
}

variable "dns_zone_name" {
  description = "The DNS zone name used for allowed FQDN configuration."
  type        = string
}

variable "dns_zone_resource_group_name" {
  description = "The resource group containing the DNS zone."
  type        = string
}

variable "name_prefix" {
  description = "Prefix used for naming the cognitive account resources."
  type        = string
  default     = "example"
}

variable "environment" {
  description = "The environment tag value."
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "The owner tag value."
  type        = string
  default     = "ai-team"
}
