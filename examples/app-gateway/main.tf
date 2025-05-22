locals {
  # Tagging module and general variables
  location         = "centralus"
  # Resource Group
  resource_group_name = "rg-001"

  # Virtual Network
  subnet_id            = "/subscriptions/xxxxxx/resourceGroups/rg-x-001/providers/Microsoft.Network/virtualNetworks/vnet-xappgw-001/subnets/snet-appgw"


  # Application Gateway
  app_gw = {
    name = "agw-001"
    backend_address_pool = [{
      name         = "bp-agw-cdp"
      ip_addresses = ["10.10.00.21"]
    }]
    frontend_ip_configuration = [{
      name                          = "fe-agw-public"
      public_ip_address_id          = module.pip.id
    },
    {
      name                          = "fe-agw-private"
      subnet_id                     = local.subnet_id
      private_ip_address            = "10.10.0000.51" 
      private_ip_address_allocation = "Static"
    }]
    frontend_port = [{
      name = "http"
      port = 80
    }]
    backend_http_settings = [{
      cookie_based_affinity = "Disabled"
      name                  = "behttp-agw-01"
      port                  = 80
      protocol              = "Http"
    }]
    gateway_ip_configuration = [{
      name      = "ipconfig-agw-cdp"
      subnet_id = local.subnet_id
    }]
    
    http_listener = [{
      name                           = "list-http-agwgw"
      frontend_ip_configuration_name = "fe-agw-public"
      frontend_port_name             = "http"
      protocol                       = "Http"
    }]
    request_routing_rule = [{
      name                       = "rule1"
      rule_type                  = "Basic"
      http_listener_name         = "list-http-agwgw"
      backend_http_settings_name = "behttp-agw-001"
      backend_address_pool_name  = "bp-agw-01"
      priority                   = 100
    }]
    sku = {
      name     = "WAF_v2"
      tier     = "WAF_v2"
      capacity = 2
    }
    managed_rules = [{
      managed_rule_set = [{
        type    = "OWASP"
        version = "3.2"
        rule_group_override = [{
          rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
          rule = [{
            id      = "920300"
            enabled = true
            action  = "Log"
            },
            {
              id      = "920440"
              enabled = true
              action  = "Block"
            }
          ]
        }]
      }]
    }]
  }

}

module "pip" {
  source = "./tf-azurerm-modules/networking/azurerm-public_ip"

  allocation_method   = "Static"
  location            = local.location
  name                = "pip-001"
  resource_group_name = module.resource-group.resource_group_name
  sku                 = "Standard"
  tags                = module.tags.tags
}

module "agw" {
  source = "./azurerm-application_gateway"

  name                      = local.app_gw.name
  location                  = local.location
  resource_group_name       = module.resource-group.resource_group_name
  backend_address_pool      = local.app_gw.backend_address_pool
  frontend_ip_configuration = local.app_gw.frontend_ip_configuration
  frontend_port             = local.app_gw.frontend_port
  backend_http_settings     = local.app_gw.backend_http_settings
  gateway_ip_configuration  = local.app_gw.gateway_ip_configuration
  http_listener             = local.app_gw.http_listener
  request_routing_rule      = local.app_gw.request_routing_rule
  sku                       = local.app_gw.sku
  tags          = module.tags.tags
}
