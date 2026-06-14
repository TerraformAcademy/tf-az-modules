variable "name" {
  description = "The name of the Cognitive Deployment."
  type        = string
}

variable "cognitive_account_id" {
  description = "The ID of the Cognitive Services Account."
  type        = string
}

variable "model_format" {
  description = "The format of the deployment model (e.g. OpenAI)."
  type        = string
}

variable "model_name" {
  description = "The name of the model to deploy."
  type        = string
}

variable "model_version" {
  description = "Model version (optional)."
  type        = string
  default     = null
}

variable "sku_name" {
  description = "The SKU name (e.g. Standard)."
  type        = string
}

variable "sku_tier" {
  description = "The SKU tier (optional)."
  type        = string
  default     = null
}

variable "sku_size" {
  description = "The SKU size (optional)."
  type        = string
  default     = null
}

variable "sku_family" {
  description = "The SKU family (optional)."
  type        = string
  default     = null
}

variable "sku_capacity" {
  description = "The SKU capacity (optional)."
  type        = number
  default     = null
}

variable "dynamic_throttling_enabled" {
  description = "Whether dynamic throttling is enabled."
  type        = bool
  default     = false
}

variable "rai_policy_name" {
  description = "Optional RAI policy name to attach to the deployment."
  type        = string
  default     = null
}

variable "version_upgrade_option" {
  description = "Version upgrade option for the deployment."
  type        = string
  default     = null
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
