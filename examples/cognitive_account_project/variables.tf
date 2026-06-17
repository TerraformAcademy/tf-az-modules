variable "resource_group_name" {
  description = "Name of the existing resource group containing the Cognitive Account."
  type        = string
}

variable "cognitive_account_name" {
  description = "Name of the existing Cognitive Account (AI Foundry hub) to attach the project to."
  type        = string
}

variable "name_prefix" {
  description = "Prefix used to name the Cognitive Account Project."
  type        = string
  default     = "example"
}

variable "environment" {
  description = "Environment tag value (e.g. dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner tag value."
  type        = string
  default     = "ai-team"
}
