resource "azuread_application" "this" {
  display_name                   = var.display_name
  description                    = var.description
  device_only_auth_enabled       = var.device_only_auth_enabled
  fallback_public_client_enabled = var.fallback_public_client_enabled
  group_membership_claims        = var.group_membership_claims
  identifier_uris                = var.identifier_uris
  marketing_url                  = var.marketing_url
  oauth2_post_response_required  = var.oauth2_post_response_required
  owners                         = var.owners
  privacy_statement_url          = var.privacy_statement_url
  sign_in_audience               = var.sign_in_audience
  support_url                    = var.support_url
  template_id                    = var.template_id
  terms_of_service_url           = var.terms_of_service_url

  dynamic "web" {
    for_each = var.web
    content {
      homepage_url  = web.value["homepage_url"]
      logout_url    = web.value["logout_url"]
      redirect_uris = web.value["redirect_uris"]
      dynamic "implicit_grant" {
        for_each = web.value["implicit_grant"]
        content {
          access_token_issuance_enabled = implicit_grant.value["access_token_issuance_enabled"]
          id_token_issuance_enabled     = implicit_grant.value["id_token_issuance_enabled"]
        }
      }
    }
  }

  dynamic "app_role" {
    for_each = var.app_role
    content {
      allowed_member_types = app_role.value["allowed_member_types"]
      description          = app_role.value["description"]
      display_name         = app_role.value["display_name"]
      enabled              = app_role.value["enabled"]
      id                   = app_role.value["id"]
      value                = app_role.value["value"]
    }
  }

  dynamic "api" {
    for_each = var.api
    content {
      known_client_applications      = api.value["known_client_applications"]
      mapped_claims_enabled          = api.value["mapped_claims_enabled"]
      requested_access_token_version = api.value["requested_access_token_version"]
      dynamic "oauth2_permission_scope" {
        for_each = api.value["oauth2_permission_scope"]
        content {
          admin_consent_description  = oauth2_permission_scope.value["admin_consent_description"]
          admin_consent_display_name = oauth2_permission_scope.value["admin_consent_display_name"]
          enabled                    = oauth2_permission_scope.value["enabled"]
          id                         = oauth2_permission_scope.value["id"]
          type                       = oauth2_permission_scope.value["type"]
          user_consent_description   = oauth2_permission_scope.value["user_consent_description"]
          user_consent_display_name  = oauth2_permission_scope.value["user_consent_display_name"]
          value                      = oauth2_permission_scope.value["value"]
        }
      }
    }
  }
}