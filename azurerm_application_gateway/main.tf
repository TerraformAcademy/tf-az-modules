terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.40, <4.00"
    }
  }
  required_version = ">= 1.0.0"
}

resource "azurerm_application_gateway" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pool
    content {
      name         = backend_address_pool.value["name"]
      fqdns        = backend_address_pool.value["fqdns"]
      ip_addresses = backend_address_pool.value["ip_addresses"]
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      cookie_based_affinity               = backend_http_settings.value["cookie_based_affinity"]
      affinity_cookie_name                = backend_http_settings.value["affinity_cookie_name"]
      name                                = backend_http_settings.value["name"]
      path                                = backend_http_settings.value["path"]
      port                                = backend_http_settings.value["port"]
      probe_name                          = backend_http_settings.value["probe_name"]
      protocol                            = backend_http_settings.value["protocol"]
      request_timeout                     = backend_http_settings.value["request_timeout"]
      host_name                           = backend_http_settings.value["host_name"]
      pick_host_name_from_backend_address = backend_http_settings.value["pick_host_name_from_backend_address"]

      dynamic "authentication_certificate" {
        for_each = backend_http_settings.value["authentication_certificate_backend"]
        content {
          name = authentication_certificate.value["name"]
        }
      }

      trusted_root_certificate_names = backend_http_settings.value["trusted_root_certificate_names"]

      dynamic "connection_draining" {
        for_each = backend_http_settings.value["connection_draining"]
        content {
          enabled           = connection_draining.value["enabled"]
          drain_timeout_sec = connection_draining.value["drain_timeout_sec"]
        }
      }
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration
    content {
      name                            = frontend_ip_configuration.value["name"]
      subnet_id                       = frontend_ip_configuration.value["subnet_id"]
      private_ip_address              = frontend_ip_configuration.value["private_ip_address"]
      public_ip_address_id            = frontend_ip_configuration.value["public_ip_address_id"]
      private_ip_address_allocation   = frontend_ip_configuration.value["private_ip_address_allocation"]
      private_link_configuration_name = frontend_ip_configuration.value["private_link_configuration_name"]
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_port
    content {
      name = frontend_port.value["name"]
      port = frontend_port.value["port"]
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = var.gateway_ip_configuration
    content {
      name      = gateway_ip_configuration.value["name"]
      subnet_id = gateway_ip_configuration.value["subnet_id"]
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listener
    content {
      name                           = http_listener.value["name"]
      frontend_ip_configuration_name = http_listener.value["frontend_ip_configuration_name"]
      frontend_port_name             = http_listener.value["frontend_port_name"]
      host_name                      = http_listener.value["host_name"]
      host_names                     = http_listener.value["host_names"]
      protocol                       = http_listener.value["protocol"]
      require_sni                    = http_listener.value["require_sni"]
      ssl_certificate_name           = http_listener.value["ssl_certificate_name"]

      dynamic "custom_error_configuration" {
        for_each = http_listener.value["custom_error_configuration"]
        content {
          status_code           = custom_error_configuration.value["status_code"]
          custom_error_page_url = custom_error_configuration.value["custom_error_page_url"]
        }
      }

      firewall_policy_id = var.create_waf ? azurerm_web_application_firewall_policy.this[0].id : null #http_listener.value["firewall_policy_id"]
      ssl_profile_name   = http_listener.value["ssl_profile_name"]
    }

  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rule
    content {
      name                        = request_routing_rule.value["name"]
      rule_type                   = request_routing_rule.value["rule_type"]
      http_listener_name          = request_routing_rule.value["http_listener_name"]
      backend_address_pool_name   = request_routing_rule.value["backend_address_pool_name"]
      backend_http_settings_name  = request_routing_rule.value["backend_http_settings_name"]
      redirect_configuration_name = request_routing_rule.value["redirect_configuration_name"]
      rewrite_rule_set_name       = request_routing_rule.value["rewrite_rule_set_name"]
      url_path_map_name           = request_routing_rule.value["url_path_map_name"]
      priority                    = request_routing_rule.value["priority"]
    }
  }

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = var.sku.capacity
  }

  fips_enabled = var.fips_enabled

  dynamic "global" {
    for_each = var.global
    content {
      request_buffering_enabled  = global.value["request_buffering_enabled"]
      response_buffering_enabled = global.value["response_buffering_enabled"]
    }
  }

  dynamic "identity" {
    for_each = var.identity
    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }

  dynamic "private_link_configuration" {
    for_each = var.private_link_configuration
    content {
      name = private_link_configuration.value["name"]
      dynamic "ip_configuration" {
        for_each = private_link_configuration.value["ip_configuration"]
        content {
          name                          = ip_configuration.value["name"]
          subnet_id                     = ip_configuration.value["subnet_id"]
          private_ip_address_allocation = ip_configuration.value["private_ip_address_allocation"]
          primary                       = ip_configuration.value["primary"]
          private_ip_address            = ip_configuration.value["private_ip_address"]
        }
      }
    }
  }

  zones = var.zones

  dynamic "trusted_client_certificate" {
    for_each = var.trusted_client_certificate
    content {
      name = trusted_client_certificate.value["name"]
      data = trusted_client_certificate.value["data"]
    }
  }

  dynamic "ssl_profile" {
    for_each = var.ssl_profile
    content {
      name                                 = ssl_profile.value["name"]
      trusted_client_certificate_names     = ssl_profile.value["trusted_client_certificate_names"]
      verify_client_cert_issuer_dn         = ssl_profile.value["verify_client_cert_issuer_dn"]
      verify_client_certificate_revocation = ssl_profile.value["verify_client_certificate_revocation"]
      dynamic "ssl_policy" {
        for_each = ssl_profile.value["ssl_policy"]
        content {
          disabled_protocols   = ssl_policy.value["disabled_protocols"]
          policy_type          = ssl_policy.value["policy_type"]
          policy_name          = ssl_policy.value["policy_name"]
          cipher_suites        = ssl_policy.value["cipher_suites"]
          min_protocol_version = ssl_policy.value["min_protocol_version"]
        }
      }
    }
  }

  dynamic "authentication_certificate" {
    for_each = var.authentication_certificate
    content {
      name = authentication_certificate.value["name"]
      data = authentication_certificate.value["data"]
    }
  }

  dynamic "trusted_root_certificate" {
    for_each = var.trusted_root_certificate
    content {
      name                = trusted_root_certificate.value["name"]
      data                = trusted_root_certificate.value["data"]
      key_vault_secret_id = trusted_root_certificate.value["key_vault_secret_id"]
    }
  }

  dynamic "ssl_policy" {
    for_each = var.ssl_policy
    content {
      disabled_protocols   = ssl_policy.value["disabled_protocols"]
      policy_type          = ssl_policy.value["policy_type"]
      policy_name          = ssl_policy.value["policy_name"]
      cipher_suites        = ssl_policy.value["cipher_suites"]
      min_protocol_version = ssl_policy.value["min_protocol_version"]
    }
  }

  enable_http2                      = var.enable_http2
  force_firewall_policy_association = var.force_firewall_policy_association

  dynamic "probe" {
    for_each = var.probe
    content {
      host                                      = probe.value["host"]
      interval                                  = probe.value["interval"]
      name                                      = probe.value["name"]
      protocol                                  = probe.value["protocol"]
      path                                      = probe.value["path"]
      timeout                                   = probe.value["timeout"]
      unhealthy_threshold                       = probe.value["unhealthy_threshold"]
      port                                      = probe.value["port"]
      pick_host_name_from_backend_http_settings = probe.value["pick_host_name_from_backend_http_settings"]
      dynamic "match" {
        for_each = probe.value["match"]
        content {
          body        = match.value["body"]
          status_code = match.value["status_code"]
        }
      }
      minimum_servers = probe.value["minimum_servers"]
    }
  }

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificate
    content {
      name                = ssl_certificate.value["name"]
      data                = ssl_certificate.value["data"]
      password            = ssl_certificate.value["password"]
      key_vault_secret_id = ssl_certificate.value["key_vault_secret_id"]
    }
  }

  tags = var.tags
  dynamic "url_path_map" {
    for_each = var.url_path_map
    content {
      name                                = url_path_map.value["name"]
      default_backend_address_pool_name   = url_path_map.value["default_backend_address_pool_name"]
      default_backend_http_settings_name  = url_path_map.value["default_backend_http_settings_name"]
      default_redirect_configuration_name = url_path_map.value["default_redirect_configuration_name"]
      default_rewrite_rule_set_name       = url_path_map.value["default_rewrite_rule_set_name"]
      dynamic "path_rule" {
        for_each = url_path_map.value["path_rule"]
        content {
          name                        = path_rule.value["name"]
          paths                       = path_rule.value["paths"]
          backend_address_pool_name   = path_rule.value["backend_address_pool_name"]
          backend_http_settings_name  = path_rule.value["backend_http_settings_name"]
          redirect_configuration_name = path_rule.value["redirect_configuration_name"]
          rewrite_rule_set_name       = path_rule.value["rewrite_rule_set_name"]
          firewall_policy_id          = var.create_waf ? azurerm_web_application_firewall_policy.this[0].id : null #path_rule.value["firewall_policy_id"]
        }
      }
    }
  }

  dynamic "waf_configuration" {
    for_each = var.waf_configuration
    content {
      enabled          = waf_configuration.value["enabled"]
      firewall_mode    = waf_configuration.value["firewall_mode"]
      rule_set_type    = waf_configuration.valid["rule_set_type"]
      rule_set_version = waf_configuration.value["rule_set_version"]
      dynamic "disabled_rule_group" {
        for_each = waf_configuration.value["disabled_rule_group"]
        content {
          rule_group_name = disabled_rule_group.value["rule_group_name"]
          rules           = disabled_rule_group.value["rules"]
        }
      }

      file_upload_limit_mb     = waf_configuration.value["file_upload_limit_mb"]
      request_body_check       = waf_configuration.value["request_body_check"]
      max_request_body_size_kb = waf_configuration.value["max_request_body_size_kb"]
      dynamic "exclusion" {
        for_each = waf_configuration.value["exclusion"]
        content {
          match_variable          = exclusion.value["match_variable"]
          selector_match_operator = exclusion.value["selector_match_operator"]
          selector                = exclusion.value["selector"]
        }
      }
    }
  }

  dynamic "custom_error_configuration" {
    for_each = var.custom_error_configuration
    content {
      status_code           = custom_error_configuration.value["status_code"]
      custom_error_page_url = custom_error_configuration.value["custom_error_page_url"]
    }
  }

  firewall_policy_id = var.create_waf ? azurerm_web_application_firewall_policy.this[0].id : null
  dynamic "redirect_configuration" {
    for_each = var.redirect_configuration
    content {
      name                 = redirect_configuration.value["name"]
      redirect_type        = redirect_configuration.value["redirect_type"]
      target_listener_name = redirect_configuration.value["target_listener_name"]
      target_url           = redirect_configuration.value["target_url"]
      include_path         = redirect_configuration.value["include_path"]
      include_query_string = redirect_configuration.value["include_query_string"]
    }
  }

  dynamic "autoscale_configuration" {
    for_each = var.autoscale_configuration
    content {
      min_capacity = autoscale_configuration.value["min_capacity"]
      max_capacity = autoscale_configuration.value["max_capacity"]
    }
  }

  dynamic "rewrite_rule_set" {
    for_each = var.rewrite_rule_set
    content {
      name = rewrite_rule_set.value["name"]
      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value["rewrite_rule"]
        content {
          name          = rewrite_rule.value["name"]
          rule_sequence = rewrite_rule.value["rule_sequence"]
          dynamic "condition" {
            for_each = rewrite_rule.value["condition"]
            content {
              variable    = condition.value["variable"]
              pattern     = condition.value["pattern"]
              ignore_case = condition.value["ignore_case"]
              negate      = condition.value["negate"]
            }
          }

          dynamic "request_header_configuration" {
            for_each = rewrite_rule.value["request_header_configuration"]
            content {
              header_name  = request_header_configuration.value["header_name"]
              header_value = request_header_configuration.value["header_value"]
            }
          }

          dynamic "response_header_configuration" {
            for_each = rewrite_rule.value["response_header_configuration"]
            content {
              header_name  = response_header_configuration.value["header_name"]
              header_value = response_header_configuration.value["header_value"]
            }
          }

          dynamic "url" {
            for_each = rewrite_rule.value["url"]
            content {
              path         = url.value["path"]
              query_string = url.value["query_string"]
              components   = url.value["components"]
              reroute      = url.value["reroute"]
            }
          }
        }
      }
    }
  }
}

resource "azurerm_web_application_firewall_policy" "this" {
  count               = var.create_waf ? [1] : []
  name                = var.waf_name
  resource_group_name = var.resource_group_name
  location            = var.location

  dynamic "custom_rules" {
    for_each = var.custom_rules
    content {
      enabled   = custom_rules.value["enabled"]
      name      = custom_rules.value["name"]
      priority  = custom_rules.value["priority"]
      rule_type = custom_rules.value["rule-type"]

      dynamic "match_conditions" {
        for_each = custom_rules.value["match_condition"]
        content {
          dynamic "match_variables" {
            for_each = match_conditions.value["match_variables"]
            content {
              variable_name = match_variables.value["variable_name"]
              selector      = match_variables.value["selector"]
            }
          }
          match_values       = match_conditions.value["match_values"]
          operator           = match_conditions.value["operator"]
          negation_condition = match_conditions.value["negation_condition"]
          transforms         = match_conditions.value["transforms"]
        }
      }

      action               = custom_rules.value["action"]
      rate_limit_duration  = custom_rules.value["rate_limit_duration"]
      rate_limit_threshold = custom_rules.value["rate_limit_threshold"]
      group_rate_limit_by  = custom_rules.value["group_rate_limit_by"]
    }
  }

  dynamic "policy_settings" {
    for_each = var.policy_settings
    content {
      enabled                     = policy_settings.value["enabled"]
      mode                        = policy_settings.value["mode"]
      file_upload_limit_in_mb     = policy_settings.value["file_upload_limit_in_mb"]
      request_body_check          = policy_settings.value["request_body_check"]
      max_request_body_size_in_kb = policy_settings.value["max_request_body_size_in_kb"]
      dynamic "log_scrubbing" {
        for_each = policy_settings.value["log_scrubbing"]
        content {
          enabled = log_scrubbing.value["enabled"]
          dynamic "rule" {
            for_each = log_scrubbing.value["rule"]
            content {
              enabled                 = rule.value["enabled"]
              match_variable          = rule.value["match_variable"]
              selector_match_operator = rule.value["selector_match_operator"]
              selector                = rule.value["selector"]
            }
          }
        }
      }
      request_body_inspect_limit_in_kb = policy_settings.value["request_body_inspect_limit_in_kb"]
    }
  }

  dynamic "managed_rules" {
    for_each = var.managed_rules
    content {
      dynamic "exclusion" {
        for_each = managed_rules.value["exclusion"]
        content {
          match_variable          = exclusion.value["match_variable"]
          selector                = exclusion.value["selector"]
          selector_match_operator = exclusion.value["selector_match_operator"]
          dynamic "excluded_rule_set" {
            for_each = exclusion.value["excluded_rule_set"]
            content {
              type    = excluded_rule_set.value["type"]
              version = excluded_rule_set.value["version"]
              dynamic "rule_group" {
                for_each = excluded_rule_set.value["rule_group"]
                content {
                  rule_group_name = rule_group.value["rule_group_name"]
                  excluded_rules  = rule_group.value["excluded_rules"]
                }
              }
            }
          }
        }
      }

      dynamic "managed_rule_set" {
        for_each = managed_rules.value["managed_rule_set"]
        content {
          type    = managed_rule_set.value["type"]
          version = managed_rule_set.value["version"]
          dynamic "rule_group_override" {
            for_each = managed_rule_set.value["rule_group_override"]
            content {
              rule_group_name = rule_group_override.value["rule_group_name"]
              dynamic "rule" {
                for_each = rule_group_override.value["rule"]
                content {
                  id      = rule.value["id"]
                  enabled = rule.value["enabled"]
                  action  = rule.value["action"]
                }
              }
            }
          }
        }
      }
    }
  }
  tags = var.tags
}
