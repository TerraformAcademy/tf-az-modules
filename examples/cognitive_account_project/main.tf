provider "azurerm" {
  features {}
}

# ---------------------------------------------------------------------------
# Data sources — reference pre-existing infrastructure
# ---------------------------------------------------------------------------

data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

# Look up the parent Cognitive Account (AI Foundry hub) that was created
# separately, e.g. via the azurerm_cognitive_account module.
data "azurerm_cognitive_account" "parent" {
  name                = var.cognitive_account_name
  resource_group_name = data.azurerm_resource_group.example.name
}

# ---------------------------------------------------------------------------
# Locals — define one or more projects as a map for for_each
# ---------------------------------------------------------------------------

locals {
  projects = {
    default_project = {
      name         = "${var.name_prefix}-project"
      display_name = "${var.name_prefix} Project"
      description  = "Default AI Foundry project for ${var.environment} environment."
      identity_type = "SystemAssigned"
      identity_ids  = []
      tags = {
        Environment = var.environment
        Owner       = var.owner
        ManagedBy   = "Terraform"
      }
    }
  }
}

# ---------------------------------------------------------------------------
# Module — azurerm_cognitive_account_project
# ---------------------------------------------------------------------------

module "cognitive_account_project" {
  source   = "../../azurerm_cognitive_account_project"
  for_each = local.projects

  name                 = each.value.name
  cognitive_account_id = data.azurerm_cognitive_account.parent.id
  location             = data.azurerm_resource_group.example.location

  display_name = each.value.display_name
  description  = each.value.description

  identity_type = each.value.identity_type
  identity_ids  = each.value.identity_ids

  tags = each.value.tags
}
