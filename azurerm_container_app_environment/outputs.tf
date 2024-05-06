output "id" {
  value = azurerm_container_app_environment.this.id
  description = "The ID of the Container App Environment"
}

output "default_domain" {
  value = azurerm_container_app_environment.this.default_domain
  description = "The default, publicly resolvable, name of this Container App Environment."
}

output "docker_bridge_cidr" {
  value = azurerm_container_app_environment.this.docker_bridge_cidr
  description = "The network addressing in which the Container Apps in this Container App Environment will reside in CIDR notation."
}

output "platform_reserved_cidr" {
  value = azurerm_container_app_environment.this.platform_reserved_cidr
  description = "The IP range, in CIDR notation, that is reserved for environment infrastructure IP addresses."
}

output "platform_reserved_dns_ip_address" {
  value = azurerm_container_app_environment.this.platform_reserved_dns_ip_address
  description = "The IP address from the IP range defined by platform_reserved_cidr that is reserved for the internal DNS server."
}

output "static_ip_address" {
  value = azurerm_container_app_environment.this.static_ip_address
  description = "The Static IP address of the Environment."
}
