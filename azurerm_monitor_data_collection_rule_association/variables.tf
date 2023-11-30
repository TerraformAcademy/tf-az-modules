variable "name" {
  type = string
  description = " (Optional) The name which should be used for this Data Collection Rule Association. Changing this forces a new Data Collection Rule Association to be created. Defaults to configurationAccessEndpoint."
  default = "configurationAccessEndpoint"
}

variable "target_resource_id" {
  type = string
  description = "(Required) The ID of the Azure Resource which to associate to a Data Collection Rule or a Data Collection Endpoint."
}

variable "data_collection_endpoint_id" {
  type = string
  description = "(Optional) The ID of the Data Collection Endpoint which will be associated to the target resource."
  default = null
}

variable "data_collection_rule_id" {
  type = string
  description = "(Optional) The ID of the Data Collection Rule which will be associated to the target resource."
  default = null
}

variable "description" {
  type = string
  description = "(Optional) The description of the Data Collection Rule Association."
}