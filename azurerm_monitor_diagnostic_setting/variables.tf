variable "name" {
  description = "(Required) Specifies the name of the Diagnostic Setting."
  type        = string
}

variable "target_resource_id" {
  description = "(Required) The ID of an existing Resource on which to configure Diagnostic Settings."
  type = string
}

variable "eventhub_name" {
  description = "(Optional) Specifies the name of the Event Hub where Diagnostics Data should be sent."
  type = string
  default = null
}

variable "eventhub_authorization_rule_id" {
  description = "(Optional) Specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data."
  type = string
  default = null
}

variable "enabled_log" {
  description = "(Optional) One or more enabled_log blocks as defined below."
  type = set(object({
    category = optional(string, null)
    category_group = optional(string, null)
  }))
  default = []
}

variable "log_analytics_workspace_id" {
  description = " (Optional) Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent."
  type = string
  default = null
}

variable "enabled_metric" {
  description = "(Optional) One or more enabled_metric blocks as defined below."
  type = set(object({
    category = string
  }))
  default = []
}

variable "storage_account_id" {
  description = "(Optional) The ID of the Storage Account where logs should be sent."
  type = string
  default = null
}

variable "log_analytics_destination_type" {
  description = " (Optional) Possible values are AzureDiagnostics and Dedicated. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
  type = string
  default = "Dedicated"
}

variable "partner_solution_id" {
  description = "(Optional) The ID of the market partner solution where Diagnostics Data should be sent."
  type = string
  default = null
}