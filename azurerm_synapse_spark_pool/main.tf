resource "azurerm_synapse_spark_pool" "this" {
  name                 = var.name
  synapse_workspace_id = var.synapse_workspace_id
  node_size_family     = var.node_size_family
  node_size            = var.node_size
  cache_size           = var.cache_size
  compute_isolation_enabled = var.compute_isolation_enabled

  dynamic "auto_scale" {
    for_each = var.auto_scale
    content {
        max_node_count = auto_scale.value["max_node_count"]
        min_node_count = auto_scale.value["min_node_count"]
    }
  }

  dynamic "auto_pause" {
    for_each = var.auto_pause
    content {
        delay_in_minutes = 15
    }
  }

dynamic_executor_allocation_enabled = var.dynamic_executor_allocation_enabled
min_executors = var.min_executors
max_executors = var.max_executors

session_level_packages_enabled = var.session_level_packages_enabled


  dynamic "library_requirement" {
    for_each = var.library_requirement
    content {
      # content - (required) is a type of string
      content = library_requirement.value["content"]
      # filename - (required) is a type of string
      filename = library_requirement.value["filename"]
    }
  }

  dynamic "spark_config" {
    for_each = var.spark_config
    content {
      # content - (required) is a type of string
      content = spark_config.value["content"]
      # filename - (required) is a type of string
      filename = spark_config.value["filename"]
    }
  }

spark_log_folder = var.spark_log_folder
spark_events_folder = var.spark_events_folder
spark_version = var.spark_version
  tags = var.tags


}
