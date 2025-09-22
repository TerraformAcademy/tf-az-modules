resource "azuredevops_serviceendpoint_github_enterprise" "this" {
  project_id            = var.project_id
  service_endpoint_name = var.service_endpoint_name
  url                   = var.url
  description           = var.description

  auth_personal {
    # Also can be set with AZDO_GITHUB_ENTERPRISE_SERVICE_CONNECTION_PAT environment variable
    personal_access_token = var.personal_access_token
  }
}
