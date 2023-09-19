terraform {

}

provider "azurerm" {
  features {

  }
}

locals {
  workload_groups = {
    "group1" = {
      name        = "workload_group_01"
      sql_pool_id = data.azurerm_synamps_pool.id
      classifiers = {
        "wgclasifier1" = {
          member_name = "memberGroup1"
        }
      }
    }
  }
  workload_classifier = {
    "classifier1" = {
      member_name       = "membergroup1"
      workload_group_id = azurerm_synapse_sql_pool_workload_group.example["group1"].id
      context           = "example_context"
      end_time          = "14:00"
      importance        = "normal"
      label             = "example"
      member_name       = "groupMember1"
      start_time        = "06:00"
    }
  }
}

resource "azurerm_synapse_sql_pool_workload_group" "example" {
  for_each                           = local.workload_groups
  name                               = each.value.name
  sql_pool_id                        = each.value.sql_pool_id
  max_resource_percent               = 100
  min_resource_percent               = 0
  max_resource_percent_per_request   = 3
  min_resource_percent_per_request   = 3
  query_execution_timeout_in_seconds = 0
}

resource "azurerm_synapse_sql_pool_workload_classifier" "example" {
  for_each          = local.workload_groups
  name              = each.value.classifiers
  workload_group_id = each.value.workload_group_id
  context           = each.value.context
  end_time          = each.value.end_time
  importance        = each.value.importance
  label             = each.value.label
  member_name       = each.value.member_name
  start_time        = each.value.start_time
}
