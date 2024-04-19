resource "azurerm_api_management" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email

  dynamic "hostname_configuration" {
    for_each = var.hostname_configuration
    content {
      dynamic "management" {
        for_each = hostname_configuration.value["management"]
        content {
          host_name                       = management.value["hostname"]
          key_vault_id                    = management.value["key_vault_id"]
          certificate                     = management.value["certificate"]
          certificate_password            = management.value["certificate_password"]
          negotiate_client_certificate    = management.value["negotiate_client_certificate"]
          ssl_keyvault_identity_client_id = management.value["ssl_keyvault_identity_client_id"]
        }
      }

      dynamic "portal" {
        for_each = hostname_configuration.value["portal"]
        content {
          host_name                       = portal.value["hostname"]
          key_vault_id                    = portal.value["key_vault_id"]
          certificate                     = portal.value["certificate"]
          certificate_password            = portal.value["certificate_password"]
          negotiate_client_certificate    = portal.value["negotiate_client_certificate"]
          ssl_keyvault_identity_client_id = portal.value["ssl_keyvault_identity_client_id"]
        }
      }

      dynamic "developer_portal" {
        for_each = hostname_configuration.value["developer_portal"]
        content {
          host_name                       = developer_portal.value["hostname"]
          key_vault_id                    = developer_portal.value["key_vault_id"]
          certificate                     = developer_portal.value["certificate"]
          certificate_password            = developer_portal.value["certificate_password"]
          negotiate_client_certificate    = developer_portal.value["negotiate_client_certificate"]
          ssl_keyvault_identity_client_id = developer_portal.value["ssl_keyvault_identity_client_id"]
        }
      }

      dynamic "scm" {
        for_each = hostname_configuration.value["scm"]
        content {
          host_name                       = scm.value["hostname"]
          key_vault_id                    = scm.value["key_vault_id"]
          certificate                     = scm.value["certificate"]
          certificate_password            = scm.value["certificate_password"]
          negotiate_client_certificate    = scm.value["negotiate_client_certificate"]
          ssl_keyvault_identity_client_id = scm.value["ssl_keyvault_identity_client_id"]
        }
      }

      dynamic "proxy" {
        for_each = hostname_configuration.value["proxy"]
        content {
          default_ssl_binding             = proxy.value["default_ssl_binding"]
          host_name                       = proxy.value["hostname"]
          key_vault_id                    = proxy.value["key_vault_id"]
          certificate                     = proxy.value["certificate"]
          certificate_password            = proxy.value["certificate_password"]
          negotiate_client_certificate    = proxy.value["negotiate_client_certificate"]
          ssl_keyvault_identity_client_id = proxy.value["ssl_keyvault_identity_client_id"]
        }
      }
    }
  }
}