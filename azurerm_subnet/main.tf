resource "azurerm_subnet" "this" {
  name                 = var.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name

  dynamic "delegation" {
    for_each = var.delegation
    content {
      name = each.value["name"]
      dynamic "service_delegation" {
        for_each = delegation.value["service_delegation"]
        content {
          name    = service_delegation.value["name"]
          actions = service_delegation.value["actions"]
        }
      }
    }
  }

}

variable "delegation" {
  type = set(object({
    name = string
    service_delegation = set(object({
      name    = string
      actions = optional(list(string), [])
    }))
  }))
  default = [ {
    name = "managedinstancedelegation"

    service_delegation = [ {
      name    = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
    ]
  } ]

}
