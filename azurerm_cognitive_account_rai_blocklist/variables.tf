variable "name" {
  description = "The name of the RAI Blocklist."
  type        = string
}

variable "cognitive_account_id" {
  description = "The ID of the Cognitive Services Account."
  type        = string
}

variable "description" {
  description = "A short description for the RAI Blocklist."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to assign to the RAI Blocklist."
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "Timeouts for create/read/update/delete."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}
