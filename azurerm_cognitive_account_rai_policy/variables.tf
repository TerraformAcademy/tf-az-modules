variable "name" {
  description = "The name of the RAI Policy."
  type        = string
}

variable "cognitive_account_id" {
  description = "The ID of the Cognitive Services Account."
  type        = string
}

variable "tags" {
  description = "Tags to assign to the RAI Policy."
  type        = map(string)
  default     = {}
}

variable "base_policy_name" {
  description = "The name of the base policy to use for this RAI Policy."
  type        = string
}

variable "mode" {
  description = "The mode of the RAI Policy. Possible values: Default, Deferred, Blocking, Asynchronous_filter."
  type        = string
  default     = null
}

variable "content_filter" {
  description = "One or more content_filter blocks. Each item must include name, filter_enabled, block_enabled, severity_threshold, source."
  type = list(object({
    name               = string
    filter_enabled     = bool
    block_enabled      = bool
    severity_threshold = string
    source             = string
  }))
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
