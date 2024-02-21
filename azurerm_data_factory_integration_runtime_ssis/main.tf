resource "azurerm_data_factory_integration_runtime_azure_ssis" "this" {
  name                             = var.name
  location                         = var.location
  data_factory_id                  = var.data_factory_id
  node_size                        = var.node_size
  number_of_nodes                  = var.number_of_nodes
  credential_name                  = var.credential_name
  max_parallel_executions_per_node = var.max_parallel_executions_per_node
  edition                          = var.edition
  license_type                     = var.license_type
  dynamic "catalog_info" {
    for_each = var.catalog_info
    content {
      server_endpoint        = catalog_info.value["server_endpoint"]
      administrator_login    = catalog_info.value["administrator_login"]
      administrator_password = catalog_info.value["administrator_password"]
      pricing_tier           = catalog_info.value["pricing_tier"]
      elastic_pool_name      = catalog_info.value["elastic_pool_name"]
      dual_standby_pair_name = catalog_info.value["dual_standby_pair_name"]
    }
  }
  dynamic "custom_setup_script" {
    for_each = var.custom_setup_script
    content {
      blob_container_uri = custom_setup_script.value["blob_container_uri"]
      sas_token          = custom_setup_script.value["sas_token"]
    }
  }

  dynamic "express_custom_setup" {
    for_each = var.express_custom_setup
    content {
      dynamic "command_key" {
        for_each = express_custom_setup.value["command_key"]
        content {
          target_name = command_key.value["target_name"]
          user_name   = command_key.value["target_name"]
          password    = command_key.value["password"]
          dynamic "key_vault_password" {
            for_each = command_key.value["key_vault_password"]
            content {
              linked_service_name = key_vault_password.value["linked_service_name"]
              secret_name         = key_vault_password.value["secret_name"]
              secret_version      = key_vault_password.value["secret_version"]
              parameters          = key_vault_password.value["parameters"]
            }
          }
        }
      }

      dynamic "component" {
        for_each = express_custom_setup.value["component"]
        content {
          name    = component.value["name"]
          license = component.value["license"]
          dynamic "key_vault_license" {
            for_each = component.value["key_vault_password"]
            content {
              linked_service_name = key_vault_password.value["linked_service_name"]
              secret_name         = key_vault_password.value["secret_name"]
              secret_version      = key_vault_password.value["secret_version"]
              parameters          = key_vault_password.value["parameters"]
            }
          }
        }
      }
    }
  }

  dynamic "express_vnet_integration" {
    for_each = var.express_vnet_integration
    content {
      subnet_id = express_vnet_integration.value["subnet_id"]
    }
  }

  dynamic "package_store" {
    for_each = var.package_store
    content {
      name                = package_store.value["name"]
      linked_service_name = package_store.value["linked_service_name"]
    }
  }

  dynamic "proxy" {
    for_each = var.proxy
    content {
      self_hosted_integration_runtime_name = proxy.vlaue["self_hosted_integration_runtime_name"]
      staging_storage_linked_service_name  = proxy.vlaue["staging_storage_linked_service_name"]
      path                                 = proxy.value["path"]
    }
  }

  dynamic "vnet_integration" {
    for_each = var.vnet_integration
    content {
      vnet_id     = vnet_integration.value["vnet_id"]
      subnet_name = vnet_integration.value["subnet_name"]
      subnet_id   = vnet_integration.value["subnet_id"]
      public_ips  = vnet_integration.value["public_ips"]
    }
  }

  description = var.description

}