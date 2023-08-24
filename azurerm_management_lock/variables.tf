variable "name" {
  type        = string
  description = "Name of Management Lock."
}

variable "scope" {
  type        = string
  description = "Scope at which lock should be."
}

variable "lock_level" {
  type        = string
  description = "Level to be used for lock CanNotDelete or ReadOnly"
  default     = "CanNotDelete"
}

variable "notes" {
  type        = string
  description = "Some notes about lock."
  default     = null
}