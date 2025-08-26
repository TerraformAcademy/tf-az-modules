    dynamic "new_cluster_config"{
        for_each = var.new_cluster_config
        content {
            cluster_version = new_cluster_config.value["cluster_version"]
            node_type = new_cluster_config.value["node_type"]
            custom_tags = new_cluster_config.value["custom_tags"]
            driver_node_type = new_cluster_config.value["driver_node_type"]
            init_scripts = new_cluster_config.value["init_scripts"]
            log_destination = new_cluster_config.value["log_destination"]
            max_number_of_workers = new_cluster_config.value["max_number_of_workers"]
            min_number_of_workers = new_cluster_config.value["min_number_of_workers"]
            spark_config = new_cluster_config.value["spark_config"]
            spark_environment_variables = new_cluster_config.value["spark_environment_variables"]
        }
    }


variable "new_cluster_config"{
    type = set(object({
        cluster_version = string
        node_type = string
        custom_tags = optional(map(string), {})
        driver_node_type = optional(string, null)
        init_scripts = optional(list(string), [])
        log_destination = optional(string, null)
        max_number_of_workers = optional(string, null)
        min_number_of_workers = optional(string, null)
        spark_config = optional(map(string), {})
        spark_environment_variables = optional(map(string), {})
    }))
}
