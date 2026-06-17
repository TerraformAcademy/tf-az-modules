variable "name" {
  description = "The name of the Cognitive Account Project."
  type        = string
}

variable "cognitive_account_id" {
  description = "The ID of the Cognitive Account where the project should exist."
  type        = string
}

variable "location" {
  description = "The Azure region for the Cognitive Account Project."
  type        = string
}

variable "description" {
  description = "The description of the Cognitive Account Project."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the Cognitive Account Project."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to assign to the Cognitive Account Project."
  type        = map(string)
  default     = {}
}

variable "identity_type" {
  description = "The identity type for the Cognitive Account Project. Possible values are SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "List of user-assigned identity IDs for the Cognitive Account Project."
  type        = list(string)
  default     = []
}

variable "timeouts" {
  description = "Timeouts for create, read, update, and delete operations."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}
