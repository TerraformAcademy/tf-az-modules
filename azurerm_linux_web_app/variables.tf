variable "name" {
    type = string
    description = "(Required) The name which should be used for this Linux Web App."
}

variable "location" {
  type = string
  description = "(Required) The Azure Region where the Linux Web App should exist."
}

variable "resource_group_name" {
    type = string
    description = "(Required) The name of the Resource Group where the Linux Web App should exist."
}

variable "service_plan_id" {
    type = string
    description = "(Required) The ID of the Service Plan that this Linux App Service will be created in."
}

variable "site_config" {
  type = set(object({
     always_on = optional(bool, false)
     api_definition_url = optional(string, null)
     api_management_api_id = optional(string, null)
     app_command_line = optional(string, null)
     application_stack = optional(set(object({
        docker_image_name = optional(string, null)
        docker_registry_url = optional(string, null)
        docker_registry_username = optional(string, null)
        docker_registry_password = optional(string, null)
        dotnet_version = optional(string, null)
        go_version = optional(string, null)

     })), [])
     auto_heal_enabled = optional(bool, false)
     auto_heal_setting = optional(set(object({

     })), [])
     container_registry_managed_identity_client_id = optional(string, null) 
     container_registry_use_managed_identity = optional(bool, false)
     cors = optional(set(object({

     })), [])
     default_documents = optional(list(string), [])
     ftps_state = optional(string, "Disabled")
     health_check_path = optional(string, null)
     health_check_eviction_time_in_min = optional(number, null)
     http2_enabled = optional(bool, false)
     ip_restriction = optional(set(object({

     })), [])
     load_balancing_mode = optional(string, "LeastRequests")
     local_mysql_enabled = optional(bool, false)
     managed_pipeline_mode = optional(string, null)
     minimum_tls_version = optional(string, "1.2")
     remote_debugging_version = optional(string, null)
     scm_ip_restriction = optional(set(object({

     })), [])
     scm_minimum_tls_version = optional(string, "1.2")
     scm_use_main_ip_restriction = optional(bool, true)
     use_32_bit_worker = optional(bool, true)
     vnet_route_all_enabled = optional(bool, false)
     websockets_enabled = optional(bool, false)
     worker_count = optional(number, null)
  }))
  description = "(Required) A site_config block as defined below."
}