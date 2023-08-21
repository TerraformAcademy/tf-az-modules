resource "azurerm_subnet" "this" {
  
dynamic "delegation" {
  for_each = var.delegation
  content {
    name = each.value["name"]
    dynamic "service_delegation" {
      for_each = delegation.value["service_delegation"]
      content {
        name = service_delegation.value["name"]
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
      name = string
      actions = optional(list(string), [])
    }))
  }))
default = []

}