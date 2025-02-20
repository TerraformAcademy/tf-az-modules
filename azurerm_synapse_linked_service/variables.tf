variable "name" {
  
}

variable "synapse_workspace_id" {
  
}

variable "type" {
  
}

variable "type_properties_json" {
  
}

variable "additional_properties" {
  type = map()
  default = {}
}

variable "annotations" {
  type = list(any)
}

variable "description" {
  
}

variable "integration_runtime" {
  type = set(object({
    name = string
    parameters = optional(map(any), {})
  }))

  default = []
}

variable "parameters" {
  
}
