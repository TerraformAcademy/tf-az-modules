output "id" {
  value       = azurerm_application_gateway.this.id
  description = "value"
}

output "authentication_certificate " {
  value = azurerm_application_gateway.this.authentication_certificate 
  description = "A list of authentication_certificate blocks."
}

output "backend_http_settings" {
  value = azurerm_application_gateway.this.backend_http_settings
  description = "A list of backend_http_settings blocks."
}

output "frontend_ip_configuration" {
  value = azurerm_application_gateway.this.frontend_ip_configuration
  description = "A list of frontend_ip_configuration blocks."
}

output "frontend_port" {
  value = azurerm_application_gateway.this.frontend_port
  description = " A list of frontend_port blocks"
}

output "gateway_ip_configuration" {
  value = azurerm_application_gateway.this.gateway_ip_configuration
  description = "A list of gateway_ip_configuration blocks."
}

output "http_listener" {
  value = azurerm_application_gateway.this.http_listener
  description = "A list of http_listener blocks."
}

output "private_endpoint_connection" {
  value = azurerm_application_gateway.this.private_endpoint_connection
  description = "A list of private_endpoint_connection blocks."
}

output "private_link_configuration" {
  value = azurerm_application_gateway.this.private_link_configuration
  description = " A list of private_link_configuration blocks."
}

output "probe" {
  value = azurerm_application_gateway.this.probe
  description = "A probe block."
}

output "request_routing_rule" {
  value = azurerm_application_gateway.this.request_routing_rule
  description = "A list of request_routing_rule blocks."
}

output "ssl_certificate" {
  value = azurerm_application_gateway.this.ssl_certificate
  description = "A list of ssl_certificate blocks."
}

output "url_path_map" {
  value = azurerm_application_gateway.this.url_path_map
  description = " A list of url_path_map blocks."
}

output "custom_error_configuration" {
  value = azurerm_application_gateway.this.custom_error_configuration
  description = "A list of custom_error_configuration blocks."
}

output "redirect_configuration" {
  value = azurerm_application_gateway.this.redirect_configuration
  description = "A list of redirect_configuration blocks."
}