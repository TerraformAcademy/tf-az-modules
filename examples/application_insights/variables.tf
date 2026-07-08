variable "resource_group_name" {
  type        = string
  description = "The name of the existing resource group in which to create the Application Insights components."
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "The name of the existing Log Analytics Workspace used for workspace-based Application Insights."
}

variable "name_prefix" {
  type        = string
  description = "Prefix used for naming the Application Insights components."
  default     = "example"
}

variable "environment" {
  type        = string
  description = "The environment tag value (e.g. dev, staging, prod)."
  default     = "dev"
}

variable "owner" {
  type        = string
  description = "The owner tag value."
  default     = "platform-team"
}
