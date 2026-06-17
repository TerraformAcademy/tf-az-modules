provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

data "azurerm_subnet" "agent" {
  name                 = var.agent_subnet_name
  resource_group_name  = var.subnet_resource_group_name
  virtual_network_name = var.virtual_network_name
}

data "azurerm_dns_zone" "example" {
  name                = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group_name
}

locals {
  cognitive_accounts = {
    aifoundry_example = {
      name                        = "${var.name_prefix}-aifoundry"
      resource_group_name         = data.azurerm_resource_group.example.name
      location                    = data.azurerm_resource_group.example.location
      sku_name                    = "S0"
      custom_subdomain_name       = "${var.name_prefix}-ai"
      project_management_enabled  = true
      identity_type               = "SystemAssigned"
      network_injection_subnet_id = data.azurerm_subnet.agent.id
      fqdns                       = [data.azurerm_dns_zone.example.name]
      tags = {
        Environment = var.environment
        Owner       = var.owner
      }
    }
  }
}

module "cognitive_account" {
  source   = "../azurerm_cognitive_account"
  for_each = local.cognitive_accounts

  name                        = each.value.name
  resource_group_name         = each.value.resource_group_name
  location                    = each.value.location
  kind                        = "AIServices"
  sku_name                    = each.value.sku_name
  custom_subdomain_name       = each.value.custom_subdomain_name
  project_management_enabled  = each.value.project_management_enabled
  identity_type               = each.value.identity_type
  network_injection_subnet_id = each.value.network_injection_subnet_id
  fqdns                       = each.value.fqdns
  tags                        = each.value.tags
}
