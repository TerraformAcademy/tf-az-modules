variable "name" {
  type = string
}

variable "synapse_workspace_id" {
  type = string
}

variable "location" {
  type = string
}

variable "compute_type" {
  type = string
  default = null
}

variable "core_count" {
  type = number
  default = null
}

variable "description" {

  type = string
  default = null
}

variable "time_to_live_min"{
  type = number
  default = 0
}
