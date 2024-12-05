variable "name" {
  
}

variable "synapse_workspace_id" {
  
}

variable "node_size_family" {
  
}

variable "node_size" {
  
}

variable "node_count" {

}

variable "auto_scale" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      max_node_count = number
      min_node_count = number
    }
  ))
  default = []
}

variable "auto_pause" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      delay_in_minutes = number
    }
  ))
  default = []
}

variable "cache_size" {

}

variable "compute_isolation_enabled" {
  type = bool
  default = false
}

variable "dynamic_executor_allocation_enabled" {
  type = bool
  default = false
}

variable "spark_version" {
  
}

variable "min_executors" {
  
}

variable "max_executors" {
  
}

variable "library_requirement" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      content  = string
      filename = string
    }
  ))
  default = []
}

variable "spark_config" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      content  = string
      filename = string
    }
  ))
  default = []
}

variable "session_level_packages_enabled" {
  type = bool
  default = false
}

variable "spark_log_folder" {
  type = string
  default = null
}

variable "spark_events_folder" {
  type = string
  default = null
}

variable "tags" {
  
}
