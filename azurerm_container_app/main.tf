resource "azurerm_container_app" "this" {
  name                         = var.name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = var.revision_mode

  dynamic "template" {
    for_each = var.template
    content {
      init_container {
        args    = template.value["init_container"].args
        command = template.value["init_container"].command
        cpu     = template.value["init_container"].cpu
        env {
          name        = template.value["env"].name
          secret_name = template.value["env"].secret_name
          value       = template.value["env"].value
        }
        ephemeral_storage = template.value["init_container"].ephemeral_storage
        image             = template.value["init_container"].image
        memory            = template.value["init_container"].memory
        name              = template.value["init_container"].name
        volume_mounts {
          name = template.value["volume_mounts"].name
          path = template.value["volume_mounts"].path
        }
      }

      dynamic "container" {
        for_each = template.value["container"]
        content {
          args    = container.value["args"]
          command = container.value["command"]
          cpu     = container.value["cpu"]
          env {
            name        = container.value["env"].name
            secret_name = container.value["env"].secret_name
            value       = container.value["env"].value
          }
          ephemeral_storage = container.value["ephemeral_storage"]
          image             = container.value["image"]
          memory            = container.value["memory"]
          name              = container.value["name"]

        }
      }
    }
  }

  tags = var.tags
}