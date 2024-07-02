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

  dynamic "dapr" {
    for_each = var.dapr
    content {
      app_id = dapr.value["app_id"]
      app_port = dapr.value["app_port"]
      app_protocol = dapr.value["app_protocol"]
    }
  }

  dynamic "identity" {
    for_each = var.identity
    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }

  dynamic "ingress" {
    for_each = var.ingress
    content {
      allow_insecure_connections = ingress.value["allow_insecure_connections"]
      dynamic "custom_domain" {
        for_each = ingress.value["custom_domain"]
        content {
          certificate_binding_type = custom_domain.value["certificate_binding_type"]
          certificate_id = custom_domain.value["certificate_id"]
          name = custom_domain.value["name"]
        }
      }
      fqdn = ingress.value["fqdn"]
      external_enabled = ingress.value["external_enabled"]
      target_port = ingress.value["target_port"]
      exposed_port = ingress.value["exposed_port"]
      dynamic "traffic_weight" {
        for_each = ingress.value["traffic_weight"]
        content {
          label = traffic_weight.value["label"]
          latest_revision = traffic_weight.value["latest_revision"]
          revision_suffix = traffic_weight.value["revision_suffix"]
          percentage = traffic_weight.value["percentage"]
        }
      }
      transport = ingress.value["transport"]
    }
  }

  dynamic "secret" {
    for_each = var.secret
    content {
      name = secret.value["name"]
     # identity = secret.value["identity"]
     # key_vault_secret_id = secret.value["key_vault_secret_id"]
      value = secret.value["value"]
    }
  }

  workload_profile_name = var.workload_profile_name
}
