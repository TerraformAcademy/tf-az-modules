variable "subscription_id" {
  description = "Azure Subscription ID"
  default     = "2d38b96b-0573-4e07-946e-283161509b9d"
}

variable "resource_group_name" {
  description = "Resource Group Name"
  default     = "M6CSQLMIRGP01-D"
}

variable "location" {
  description = "Azure Region"
  default     = "Central US"
}

variable "admin_username" {
  description = "Managed Instance Admin Username"
  default     = "azsqladmin"
}

variable "admin_password" {
  description = "Managed Instance Admin Password"
  default     = "Azure@123"
}

variable "subnet_id" {
  description = "Virtual Network Subnet ID"
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "Private Endpoint Subnet ID"
  type        = string
}

variable "name" {
  description = "Name of the Azure SQL Managed Instance"
  default     = "sqlmi-es-d-cus-001" # we can variable appliaction/project name short cut
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  default     = 7
}

# variable "vcores" {
#   description = "Number of vCores for the managed instance"
#   default     = 4
# }

# variable "storage_size_gb" {
#   description = "Storage size in GB"
#   default     = 512
# }

variable "license_type" {
  default     = "LicenseIncluded"
  type        = string
  description = "What type of license the Managed Instance will use. Possible values are LicenseIncluded and BasePrice"
}

variable "sku_name" {
  type        = string
  description = "value"
}

variable "storage_size_in_gb" {
  type = number

}

variable "vcores" {
  type = number

}
variable "collation" {
  default = "SQL_Latin1_General_CP1_CI_AS"
  type    = string

}

variable "dns_zone_partner_id" {
  default = null

}
variable "identity" {
  type = set(object({
    type         = string
    identity_ids = optional(list(string), [])
  }))
  default = []

}

variable "maintenance_configuration_name" {
  default = "SQL_Default"

}

variable "minimum_tls_version" {
  default = "1.2"
  type    = string

}

variable "proxy_override" {
  type    = string
  default = "Default"

}
variable "public_data_endpoint_enabled" {
  type    = bool
  default = false
}
variable "storage_account_type" {
  default = "GRS"
  type    = string

}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "timezone_id" {
  type    = string
  default = "EST"
}

