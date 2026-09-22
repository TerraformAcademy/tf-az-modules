provider "azurerm" {
  features {
  }

  skip_provider_registration = true
}

#--------------------------------------------------------------
# Variables
#--------------------------------------------------------------

variable "resource_group_name" {
  description = "The name of the resource group to discover resources in."
  type        = string
  default     = "Allina-RG"
}

variable "storage_account_name" {
  description = "The name of the storage account to send diagnostic logs to."
  type        = string
  default     = "allina1212212"
}

variable "diagnostic_resource_types" {
  description = "Set of Azure resource types known to support diagnostic settings. Override to add/remove types for your environment."
  type        = set(string)
  default = [
    "Microsoft.KeyVault/vaults",
    "Microsoft.Network/networkSecurityGroups",
    "Microsoft.Network/publicIPAddresses",
    "Microsoft.Network/loadBalancers",
    "Microsoft.Network/applicationGateways",
    "Microsoft.Network/virtualNetworkGateways",
    "Microsoft.Network/azureFirewalls",
    "Microsoft.Network/frontDoors",
    "Microsoft.Sql/servers/databases",
    "Microsoft.Storage/storageAccounts",
    "Microsoft.Web/sites",
    "Microsoft.ContainerService/managedClusters",
    "Microsoft.EventHub/namespaces",
    "Microsoft.ServiceBus/namespaces",
    "Microsoft.Cdn/profiles",
    "Microsoft.DBforPostgreSQL/flexibleServers",
    "Microsoft.DBforMySQL/flexibleServers",
    "Microsoft.Cache/redis",
    "Microsoft.ContainerRegistry/registries",
    "Microsoft.ApiManagement/service",
    "Microsoft.SignalRService/SignalR",
    "Microsoft.CognitiveServices/accounts",
    "Microsoft.Devices/IotHubs",
    "Microsoft.OperationalInsights/workspaces",
    "Microsoft.Automation/automationAccounts",
    "Microsoft.Logic/workflows",
    "Microsoft.Batch/batchAccounts",
    "Microsoft.Search/searchServices",
    "Microsoft.DataFactory/factories",
  ]
}

#--------------------------------------------------------------
# Step 1: Discover resources by type within the resource group
#--------------------------------------------------------------

data "azurerm_resources" "by_type" {
  for_each            = var.diagnostic_resource_types
  resource_group_name = var.resource_group_name
  type                = each.value
}

#--------------------------------------------------------------
# Step 2: Flatten all discovered resources into a single map
#--------------------------------------------------------------

locals {
  all_resources = merge([
    for type_key, result in data.azurerm_resources.by_type : {
      for r in result.resources : r.id => r
    }
  ]...)
}

#--------------------------------------------------------------
# Step 3: Get diagnostic categories for each discovered resource
#--------------------------------------------------------------

data "azurerm_monitor_diagnostic_categories" "categories" {
  for_each    = local.all_resources
  resource_id = each.key
}



#--------------------------------------------------------------
# Step 4: Build enabled_log and enabled_metric sets per resource
#--------------------------------------------------------------

locals {
  diag_logs = {
    for resource_id, cat in data.azurerm_monitor_diagnostic_categories.categories :
    resource_id => [
      for log_cat in cat.log_category_types : {
        category       = log_cat
        category_group = null
      }
    ]
  }

  diag_metrics = {
    for resource_id, cat in data.azurerm_monitor_diagnostic_categories.categories :
    resource_id => [
      for metric_cat in cat.metrics : {
        category = metric_cat
      }
    ]
  }
}

#--------------------------------------------------------------
# Step 5: Storage account for diagnostic destination
#--------------------------------------------------------------

data "azurerm_storage_account" "diag" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

#--------------------------------------------------------------
# Step 6: Enable diagnostic settings for each capable resource
#--------------------------------------------------------------

module "diagnostics" {
  for_each = data.azurerm_monitor_diagnostic_categories.categories

  source = "../../azurerm_monitor_diagnostic_setting"

  name               = "diag-${lower(regex("[^/]+$", each.key))}"
  target_resource_id = each.key
  storage_account_id = data.azurerm_storage_account.diag.id

  enabled_log    = toset(local.diag_logs[each.key])
  enabled_metric = toset(local.diag_metrics[each.key])
}
