variable "name" {
  type        = string
  description = "(Required) The name of the Application Gateway. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to the Application Gateway should exist."
}

variable "location" {
  type        = string
  description = "(Required) The Azure region where the Application Gateway should exist."
}

variable "backend_address_pool" {
  type = set(object({
    name         = string
    fqdns        = optional(list(string), [])
    ip_addresses = optional(list(string), [])
  }))

  description = "(Required) One or more backend_address_pool blocks as defined."
}

variable "backend_http_settings" {
  type = set(object({
    cookie_based_affinity               = bool
    affinity_cookie_name                = string
    name                                = string
    path                                = optional(string)
    port                                = number
    probe_name                          = optional(string)
    protocol                            = string
    request_timeout                     = optional(number, 30)
    hostname                            = optional(string)
    pick_host_name_from_backend_address = optional(string)
    authentication_certificate_backend = optional(set(object({
      name = string
    })), [])
    trusted_root_certificate_names = optional(list(string))
  }))

  description = "(Required) One or more backend_http_settings blocks as defined below."
}

variable "frontend_ip_configuration" {
  type = set(object({
    name                            = string
    subnet_id                       = optional(string)
    private_ip_address              = optional(string)
    public_ip_address_id            = optional(string)
    private_ip_address_allocation   = optional(string, "Dynamic")
    private_link_configuration_name = optional(string)
  }))

  description = "(Required) One or more frontend_ip_configuration blocks as defined below."
}

variable "frontend_port" {
  type = set(object({
    name = string
    port = number
  }))
  description = "(Required) One or more frontend_port blocks as defined below."
}

variable "gateway_ip_configuration" {
  type = set(object({
    name      = string
    subnet_id = string
  }))
  description = "(Required) One or more gateway_ip_configuration blocks as defined below."
}

variable "http_listener" {
  type = set(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    host_name                      = optional(string)
    host_names                     = optional(list(string))
    protocol                       = string
    require_sni                    = optional(bool, false)
    ssl_certificate_name           = optional(string)
    custom_error_configuration = optional(set(object({
      status_code           = string
      custom_error_page_url = string
    })), [])
    firewall_policy_id = optional(string)
    ssl_profile_name   = optional(string)
  }))

  description = "(Required) One or more http_listener blocks as defined below."
}

variable "request_routing_rule" {
  type = set(object({
    name                        = string
    rule_type                   = string
    http_listener_name          = string
    backend_address_pool_name   = optional(string)
    backend_http_settings_name  = optional(string)
    redirect_configuration_name = optional(string)
    rewrite_rule_set_name       = optional(string)
    url_path_map_name           = optional(string)
    priority                    = optional(number)
  }))
  description = "(Required) One or more request_routing_rule blocks as defined below."
}

variable "sku" {
  type = object({
    name     = string
    tier     = string
    capacity = number
  })
  description = "(Required) A sku block as defined below."
}

variable "fips_enabled" {
  type        = bool
  description = "(Optional) Is FIPS enabled on the Application Gateway?"
  default     = false
}

variable "global" {
  type = set(object({
    request_buffering_enabled  = bool #(Required) Whether Application Gateway's Request buffer is enabled.
    response_buffering_enabled = bool #(Required) Whether Application Gateway's Response buffer is enabled.
  }))

  default     = []
  description = "(Optional) A global block as defined below."
}

variable "identity" {
  type = set(object({
    type         = string #(Required) Specifies the type of Managed Service Identity that should be configured on this Application Gateway. Only possible value is UserAssigned.
    identity_ids = string #(Required) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Application Gateway.
  }))
  description = "(Optional) An identity block as defined below."
  default     = []
}

variable "private_link_configuration" {
  type = set(object({
    name = string #(Required) The name of the private link configuration.
    ip_configuration = set(object({
      name                          = string                 #(Required) The name of the IP configuration.
      subnet_id                     = string                 #(Required) The ID of the subnet the private link configuration should connect to.
      private_ip_address_allocation = string                 #(Required) The allocation method used for the Private IP Address. Possible values are Dynamic and Static.
      primary                       = string                 #(Required) Is this the Primary IP Configuration?
      private_ip_address            = optional(string, null) #(Optional) The Static IP Address which should be used.
    }))

  }))
  default     = []
  description = "(Optional) One or more private_link_configuration blocks as defined below."
}

variable "zones" {
  type        = list(number)
  default     = []
  description = "(Optional) Specifies a list of Availability Zones in which this Application Gateway should be located."
}

variable "trusted_client_certificate" {
  type = set(object({
    name = string #(Required) The name of the Trusted Client Certificate that is unique within this Application Gateway.
    data = string #(Required) The base-64 encoded certificate.
  }))
  default     = []
  description = "(Optional) One or more trusted_client_certificate blocks as defined below."
}

variable "ssl_profile" {
  type = set(object({
    name                                 = string                   #(Required) The name of the SSL Profile that is unique within this Application Gateway.
    trusted_client_certificate_names     = string                   #(Optional) The name of the Trusted Client Certificate that will be used to authenticate requests from clients.
    verify_client_cert_issuer_dn         = optional(bool, false)    #(Optional) Should client certificate issuer DN be verified? Defaults to false.
    verify_client_certificate_revocation = optional(string, "OCSP") #(Optional) Specify the method to check client certificate revocation status. Possible value is OCSP.
    ssl_policy = optional(set(object({
      disabled_protocols   = optional(list(string), []) #(Optional) A list of SSL Protocols which should be disabled on this Application Gateway. Possible values are TLSv1_0, TLSv1_1, TLSv1_2 and TLSv1_3.
      policy_type          = optional(string, null)     #(Optional) The Type of the Policy. Possible values are Predefined, Custom and CustomV2.
      policy_name          = optional(string, null)     #(Optional) The Name of the Policy e.g. AppGwSslPolicy20170401S. Required if policy_type is set to Predefined. Possible values can change over time and are published here https://docs.microsoft.com/azure/application-gateway/application-gateway-ssl-policy-overview. Not compatible with disabled_protocols.
      cipher_suites        = optional(list(string), []) #(Optional) A List of accepted cipher suites.
      min_protocol_version = optional(string, null)     #(Optional) The minimal TLS version. Possible values are TLSv1_0, TLSv1_1, TLSv1_2 and TLSv1_3.
    })))
  }))
  default     = []
  description = "(Optional) One or more ssl_profile blocks as defined below."
}

variable "authentication_certificate" {
  type = set(object({
    name = string #(Required) The Name of the Authentication Certificate to use.
    data = string #(Required) The contents of the Authentication Certificate which should be used.
  }))
  default     = []
  description = "(Optional) One or more authentication_certificate blocks as defined below."
}

variable "trusted_root_certificate" {
  type = set(object({
    name                = string #(Required) The Name of the Trusted Root  Certificate to use.
    data                = string #(Required) The contents of the Trusted Root Certificate which should be used.
    key_vault_secret_id = string #(Optional) The Secret ID of (base-64 encoded unencrypted pfx) Secret or Certificate object stored in Azure KeyVault. You need to enable soft delete for the Key Vault to use this feature. Required if data is not set.
  }))
  default     = []
  description = "(Optional) One or more trusted_root_certificate blocks as defined below."
}

variable "ssl_policy" {
  type = set(object({
    disabled_protocols   = optional(list(string), []) #(Optional) A list of SSL Protocols which should be disabled on this Application Gateway. Possible values are TLSv1_0, TLSv1_1, TLSv1_2 and TLSv1_3.
    policy_type          = optional(string, null)     #(Optional) The Type of the Policy. Possible values are Predefined, Custom and CustomV2.
    policy_name          = optional(string, null)     #(Optional) The Name of the Policy e.g. AppGwSslPolicy20170401S. Required if policy_type is set to Predefined. Possible values can change over time and are published here https://docs.microsoft.com/azure/application-gateway/application-gateway-ssl-policy-overview. Not compatible with disabled_protocols.
    cipher_suites        = optional(list(string), []) #(Optional) A List of accepted cipher suites.
    min_protocol_version = optional(string, null)     #(Optional) The minimal TLS version. Possible values are TLSv1_0, TLSv1_1, TLSv1_2 and TLSv1_3.
  }))
  default     = []
  description = "(Optional) a ssl_policy block as defined below."
}

variable "enable_http2" {
  type        = bool
  default     = false
  description = "(Optional) Is HTTP2 enabled on the application gateway resource?"
}

variable "force_firewall_policy_association" {
  type        = bool
  default     = false
  description = "(Optional) Is the Firewall Policy associated with the Application Gateway?"
}

variable "probe" {
  type = set(object({
    host                                      = optional(string, null) #(Optional) The Hostname used for this Probe. If the Application Gateway is configured for a single site, by default the Host name should be specified as 127.0.0.1, unless otherwise configured in custom probe. Cannot be set if pick_host_name_from_backend_http_settings is set to true.
    interval                                  = optional(number, null) #(Required) The Interval between two consecutive probes in seconds. Possible values range from 1 second to a maximum of 86,400 seconds.
    name                                      = string                 #(Required) The Name of the Probe.
    protocol                                  = string                 #(Required) The Protocol used for this Probe. Possible values are Http and Https.
    path                                      = string                 #(Required) The Path used for this Probe.
    timeout                                   = number                 #(Required) The Timeout used for this Probe, which indicates when a probe becomes unhealthy.
    unhealthy_threshold                       = number                 #(Required) The Unhealthy Threshold for this Probe, which indicates the amount of retries which should be attempted before a node is deemed unhealthy.
    port                                      = optional(number, null) #Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from HTTP settings will be used. This property is valid for Standard_v2 and WAF_v2 only.
    pick_host_name_from_backend_http_settings = optional(bool, false)  #(Optional) Whether the host header should be picked from the backend HTTP settings. 
    match = optional(set(object({
      body        = optional(string, null)     #(Optional) A snippet from the Response Body which must be present in the Response.
      status_code = optional(list(number), []) #(Required) A list of allowed status codes for this Health Probe.
    })))
    minimum_servers = optional(number, 0) #(Optional) The minimum number of servers that are always marked as healthy. 

  }))
  default     = []
  description = "(Optional) One or more probe blocks as defined below."
}

variable "ssl_certificate" {
  type = set(object({
    name                = string                 #(Required) The Name of the SSL certificate that is unique within this Application Gateway.
    data                = optional(string, null) #(Optional) The base64-encoded PFX certificate data. Required if key_vault_secret_id is not set.
    password            = optional(string, null) #(Optional) Password for the pfx file specified in data. Required if data is set.
    key_vault_secret_id = optional(string, null) #(Optional) The Secret ID of (base-64 encoded unencrypted pfx) the Secret or Certificate object stored in Azure KeyVault. You need to enable soft delete for Key Vault to use this feature. Required if data is not set.

  }))
  default     = []
  description = "(Optional) One or more ssl_certificate blocks as defined below."
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
}

variable "url_path_map" {
  type = set(object({
    name                                = string                 #(Required) The Name of the URL Path Map.
    default_backend_address_pool_name   = optional(string, null) #(Optional) The Name of the Default Backend Address Pool which should be used for this URL Path Map. Cannot be set if default_redirect_configuration_name is set.
    default_backend_http_settings_name  = optional(string, null) #(Optional) The Name of the Default Backend HTTP Settings Collection which should be used for this URL Path Map. Cannot be set if default_redirect_configuration_name is set.
    default_redirect_configuration_name = optional(string, null) #(Optional) The Name of the Default Redirect Configuration which should be used for this URL Path Map. Cannot be set if either default_backend_address_pool_name or default_backend_http_settings_name is set.
    default_rewrite_rule_set_name       = optional(string, null) #(Optional) The Name of the Default Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs.
    path_rule = set(object({
      name                        = string                 #(Required) The Name of the Path Rule.
      paths                       = string                 #(Required) A list of Paths used in this Path Rule.
      backend_address_pool_name   = optional(string, null) #(Optional) The Name of the Backend Address Pool to use for this Path Rule. Cannot be set if redirect_configuration_name is set.
      backend_http_settings_name  = optional(string, null) #(Optional) The Name of the Backend HTTP Settings Collection to use for this Path Rule. Cannot be set if redirect_configuration_name is set.
      redirect_configuration_name = optional(string, null) #(Optional) The Name of a Redirect Configuration to use for this Path Rule. Cannot be set if backend_address_pool_name or backend_http_settings_name is set.
      rewrite_rule_set_name       = optional(string, null) #(Optional) The Name of the Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs.
      firewall_policy_id          = optional(string, null) #(Optional) The ID of the Web Application Firewall Policy which should be used as an HTTP Listener.
    }))
  }))
  default = []
}

variable "waf_configuration" {
  type = set(object({
    enabled          = bool                      #(Required) Is the Web Application Firewall enabled?
    firewall_mode    = string                    #(Required) The Web Application Firewall Mode. Possible values are Detection and Prevention.
    rule_set_type    = optional(string, "OWASP") #(Optional) The Type of the Rule Set used for this Web Application Firewall. Possible values are OWASP, Microsoft_BotManagerRuleSet and Microsoft_DefaultRuleSet. 
    rule_set_version = string                    #(Required) The Version of the Rule Set used for this Web Application Firewall. Possible values are 0.1, 1.0, 2.1, 2.2.9, 3.0, 3.1 and 3.2.
    disabled_rule_group = optional(set(object({
      rule_group_name = string                     #(Required) The rule group where specific rules should be disabled.
      rules           = optional(list(string), []) #(Optional) A list of rules which should be disabled in that group. Disables all rules in the specified group if rules is not specified.
    })), [])
    file_upload_limit_mb     = optional(number, null) #(Optional) The File Upload Limit in MB. Accepted values are in the range 1MB to 750MB for the WAF_v2 SKU, and 1MB to 500MB for all other SKUs. Defaults to 100MB.
    request_body_check       = optional(bool, true)   #(Optional) Is Request Body Inspection enabled?
    max_request_body_size_kb = optional(number, 128)  #(Optional) The Maximum Request Body Size in KB. Accepted values are in the range 1KB to 128KB. Defaults to 128KB.
    exclusion = optional(set(object({
      match_variable          = string                 #(Required) Match variable of the exclusion rule to exclude header, cookie or GET arguments. 
      selector_match_operator = optional(string, null) #(Optional) Operator which will be used to search in the variable content.
      selector                = optional(string, null) #(Optional) String value which will be used for the filter operation.
    })), [])
  }))
  default = []
}

variable "custom_error_configuration" {
  type = set(object({
    status_code           = string #(Required) Status code of the application gateway customer error. Possible values are HttpStatus403 and HttpStatus502
    custom_error_page_url = string #(Required) Error page URL of the application gateway customer error.
  }))
  default = []
}

variable "firewall_policy_id" {
  type        = string
  description = "(Optional) The ID of the Web Application Firewall Policy."
  default     = null
}

variable "redirect_configuration" {
  type = set(object({
    name                 = string                 #(Required) Unique name of the redirect configuration block.
    redirect_type        = string                 #(Required) The type of redirect. Possible values are Permanent, Temporary, Found and SeeOther.
    target_listener_name = string                 #(Optional) The name of the listener to redirect to. Cannot be set if target_url is set.
    target_url           = optional(string, null) #(Optional) The URL to redirect the request to. Cannot be set if target_listener_name is set.
    include_path         = optional(string, null) #(Optional) Whether to include the path in the redirected URL. 
    include_query_string = optional(bool, false)  #(Optional) Whether to include the query string in the redirected URL.
  }))
  default     = []
  description = "(Optional) One or more redirect_configuration blocks as defined below."
}

variable "autoscale_configuration" {
  type = set(object({
    min_capacity = number                 #(Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
    max_capacity = optional(number, null) #(Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
  }))
  default     = []
  description = "(Optional) An autoscale_configuration block as defined below."
}

variable "rewrite_rule_set" {
  type = set(object({
    name = string #(Required) Unique name of the rewrite rule set block.
    rewrite_rule = optional(set(object({
      name          = string #(Required) Unique name of the rewrite rule block.
      rule_sequence = string #(Required) Rule sequence of the rewrite rule that determines the order of execution in a set.
      condition = optional(set(object({
        variable    = string                #(Required) The variable of the condition.
        pattern     = string                #(Required) The pattern, either fixed string or regular expression, that evaluates the truthfulness of the condition.
        ignore_case = optional(bool, false) #(Optional) Perform a case in-sensitive comparison. 
        negate      = optional(bool, false) #(Optional) Negate the result of the condition evaluation.
      })), [])

      request_header_configuration = optional(set(object({
        header_name  = string #(Required) Header name of the header configuration.
        header_value = string #(Required) Header value of the header configuration. To delete a request header set this property to an empty string.
      })), [])

      response_header_configuration = optional(set(object({
        header_name  = string #(Required) Header name of the header configuration.
        header_value = string #(Required) Header value of the header configuration. To delete a request header set this property to an empty string.
      })), [])

      url = optional(set(object({
        path         = optional(string, null) #(Optional) The URL path to rewrite.
        query_string = optional(string, null) #(Optional) The query string to rewrite.
        components   = optional(string, null) #(Optional) The components used to rewrite the URL. Possible values are path_only and query_string_only to limit the rewrite to the URL Path or URL Query String only.
        reroute      = optional(bool, false)  #(Optional) Whether the URL path map should be reevaluated after this rewrite has been applied.
      })), [])

    })), [])
  }))
  default     = []
  description = "(Optional) One or more rewrite_rule_set blocks as defined below. Only valid for v2 SKUs."
}

# WAF Variables 

variable "custom_rules" {
  type = set(object({
    enabled   = optional(bool, true)   # (Optional) Describes if the policy is in enabled state or disabled state.
    name      = optional(string, null) # Optional) Gets name of the resource that is unique within a policy. This name can be used to access the resource.
    priority  = number                 # (Required) Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.
    rule_type = string                 # (Required) Describes the type of rule. Possible values are MatchRule, RateLimitRule and Invalid.
    match_conditions = set(object({
      match_variables = set(object({
        variable_name = string           # (Required) The name of the Match Variable. Possible values are RemoteAddr, RequestMethod, QueryString, PostArgs, RequestUri, RequestHeaders, RequestBody and RequestCookies.
        selector      = optional(string) # (Optional) Describes field of the matchVariable collection
      }))
      match_values       = optional(list(string))     # (Optional) A list of match values. This is Required when the operator is not Any.
      operator           = string                     # (Required) Describes operator to be matched. Possible values are Any, IPMatch, GeoMatch, Equal, Contains, LessThan, GreaterThan, LessThanOrEqual, GreaterThanOrEqual, BeginsWith, EndsWith and Regex.
      negation_condition = optional(bool, false)      # (Optional) Describes if this is negate condition or not
      transforms         = optional(list(string), []) # A list of transformations to do before the match is attempted. Possible values are HtmlEntityDecode, Lowercase, RemoveNulls, Trim, UrlDecode and UrlEncode.
    }))                                               # Required) One or more match_conditions blocks as defined below.

    action               = string                 # (Required) Type of action. Possible values are Allow, Block and Log.
    rate_limit_duration  = optional(string, null) # (Optional) Specifies the duration at which the rate limit policy will be applied. Should be used with RateLimitRule rule type. Possible values are FiveMins and OneMin.
    rate_limit_threshold = optional(number, 1)    # Optional) Specifies the threshold value for the rate limit policy. Must be greater than or equal to 1 if provided.
    group_rate_limit_by  = optional(string, null) # (Optional) Specifies what grouping the rate limit will count requests by. Possible values are GeoLocation, ClientAddr and None.

  }))

  default     = []
  description = "One or more custom_rules blocks."
}


variable "policy_settings" {
  type = set(object({
    enabled                     = optional(bool, true)           # (Optional) Describes if the policy is in enabled state or disabled state.
    mode                        = optional(string, "Prevention") # (Optional) Describes if it is in detection mode or prevention mode at the policy level. Valid values are Detection and Prevention. Defaults to Prevention.
    file_upload_limit_in_mb     = optional(number, 100)          # (Optional) The File Upload Limit in MB. Accepted values are in the range 1 to 4000.
    request_body_check          = optional(bool, true)           # Optional) Is Request Body Inspection enabled?
    max_request_body_size_in_kb = optional(number, 128)          # (Optional) The Maximum Request Body Size in KB. Accepted values are in the range 8 to 2000.
    log_scrubbing = optional(set(object({
      enabled = optional(bool, true) # (Optional) Whether this rule is enabled. Defaults to true.
      rule = optional(set(object({
        enabled                 = optional(bool, true)   # (Optional) Describes if the policy is in enabled state or disabled state. 
        match_variable          = string                 # (Required) Specifies the variable to be scrubbed from the logs. Possible values are RequestHeaderNames, RequestCookieNames, RequestArgNames, RequestPostArgNames, RequestJSONArgNames and RequestIPAddress.
        selector_match_operator = optional(string, null) #(Optional) Specifies the operating on the selector. Possible values are Equals and EqualsAny. Defaults to Equals.
        selector                = optional(string, null) # (Optional) Specifies which elements in the collection this rule applies to.
      })), [])
    })), [])
  }))
  description = "(Optional) A policy_settings block as defined below."
  default     = []
}

variable "managed_rules" {
  type = set(object({
    exclusion = optional(set(object({
      match_variable          = string # (Required) The name of the Match Variable. Possible values: RequestArgKeys, RequestArgNames, RequestArgValues, RequestCookieKeys, RequestCookieNames, RequestCookieValues, RequestHeaderKeys, RequestHeaderNames, RequestHeaderValues.
      selector                = string # (Required) Describes field of the matchVariable collection.
      selector_match_operator = string # (Required) Describes operator to be matched. Possible values: Contains, EndsWith, Equals, EqualsAny, StartsWith.
      excluded_rule_set = optional(set(object({
        type    = optional(string, "OWASP") # (Optional) The rule set type. The only possible value include Microsoft_DefaultRuleSet and OWASP. Defaults to OWASP.
        version = optional(string, "3.2")   # (Optional) The rule set version. The only possible value include 2.1 (for rule set type Microsoft_DefaultRuleSet) and 3.2 (for rule set type OWASP). 
        rule_group = optional(set(object({
          rule_group_name = string                     # (Required) The name of rule group for exclusion.
          excluded_rules  = optional(list(string), []) # (Optional) One or more Rule IDs for exclusion.
        })), [])
      })), [])
    })), [])

    managed_rule_set = set(object({
      type    = optional(string, "OWASP") # (Optional) The rule set type. The only possible value include Microsoft_BotManagerRuleSet, Microsoft_DefaultRuleSet and OWASP. Defaults to OWASP.
      version = string
      rule_group_override = optional(set(object({
        rule_group_name = string # (Required) The name of the Rule Group.
        rule = optional(set(object({
          id      = string                      # (Required) Identifier for the managed rule.
          enabled = optional(string, "enabled") #(Optional) Describes if the managed rule is in enabled state or disabled state.
          action  = optional(string, "Allow")   # (Optional) Describes the override action to be applied when rule matches. Possible values are Allow, AnomalyScoring, Block, JSChallenge and Log. JSChallenge is only valid for rulesets of type Microsoft_BotManagerRuleSet.
        })), [])
      })), [])
    }))
  }))

  description = "(Required) A managed_rules blocks as defined below."
}