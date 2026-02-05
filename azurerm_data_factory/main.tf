terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.0"
        }
    }
}

resource "azurerm_data_factory" "this" {
    name                = var.name
    location            = var.location
    resource_group_name = var.resource_group_name

    dynamic "identity" {
        for_each = var.identity 
        content {
            type         = identity.value["type"]
            identity_ids = identity.value["identity_ids"]
        }
    }

    dynamic "github_configuration" {
        for_each = var.github_configuration
        content {
            account_name    = github_configuration.value["account_name"]
            branch_name     = github_configuration.value["branch_name"]
            git_url         = github_configuration.value["git_url"]
            repository_name = github_configuration.value["repository_name"]
            root_folder     = github_configuration.value["root_folder"]
            publishing_enabled = github_configuration.value["publishing_enabled"]
        }
    }

    dynamic "global_parameter" {
      for_each = var.global_parameter
      content {
        name = global_parameter.value["name"]
        type = global_parameter.value["type"]
        value = global_parameter.value["value"]
      }

    }

    dynamic "vsts_configuration" {
        for_each = var.vsts_configuration
        content {
            account_name    = vsts_configuration.value["account_name"]
            branch_name     = vsts_configuration.value["branch_name"]
            project_name    = vsts_configuration.value["project_name"]
            repository_name = vsts_configuration.value["repository_name"]
            root_folder     = vsts_configuration.value["root_folder"]
            tenant_id      = vsts_configuration.value["tenent_id"]
            publishing_enabled = vsts_configuration.value["publishing_enabled"]
        }
      
    }

    tags = var.tags
}