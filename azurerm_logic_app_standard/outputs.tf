output "id" {
  description = "value"
  value       = azurerm_logic_app_standard.this.id
}

output "custom_domain_verification_id" {
  description = "An identifier used by App Service to perform domain ownership verification via DNS TXT record."
  value       = azurerm_logic_app_standard.this.custom_domain_verification_id
}

output "default_hostname" {
  description = "The default hostname associated with the Logic App."
  value       = azurerm_logic_app_standard.this.default_hostname
}

output "outbound_ip_address" {
  description = "A comma separated list of outbound IP addresses."
  value       = azurerm_logic_app_standard.this.outbound_ip_addresses
}

output "possible_outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses - Superset of outbound_ip_addresses."
  value       = azurerm_logic_app_standard.this.possible_outbound_ip_addresses
}

output "identity" {
  description = "An identity block as defined below, which contains the Managed Service Identity information for this App Service."
  value       = azurerm_logic_app_standard.this.identity
}

output "site_credential" {
  description = "A site_credential block as defined below, which contains the site-level credentials used to publish to this App Service."
  value       = azurerm_logic_app_standard.this.site_credential
}

output "kind" {
  description = "The Logic App kind - will be functionapp,workflowapp"
  value       = azurerm_logic_app_standard.this.kind
}