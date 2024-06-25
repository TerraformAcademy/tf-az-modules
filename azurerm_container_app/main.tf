resource "azurerm_container_app" "this" {
  name                         = var.name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = var.revision_mode

  dynamic "template" {
    for_each = var.template
    content {
      dynamic "init_container" {
        for_each = template.value["init_container"]
        content {

          args    = init_container.value["args"]
          command = init_container.value["command"]
          cpu     = init_container.value["cpu"]
          dynamic "env" {
            for_each = init_container.value["env"]
            content {

              name        = env.value["name"]
              secret_name = env.value["secret_name"]
              value       = env.value["value"]
            }
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

      }

      dynamic "container" {
        for_each = template.value["container"]
        content {
          args    = container.value["args"]
          command = container.value["command"]
          cpu     = container.value["cpu"]
          dynamic "env" {
            for_each = container.value["env"]
            content {
            name        = env.value["name"]
            secret_name = env.value["secret_name"]
            value       = env.value["value"]
           }
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
