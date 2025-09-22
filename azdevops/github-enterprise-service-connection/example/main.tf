module "github-service-connection"{
  source = "../../"
  project_id = var.project_id
  service_endpoint_name = var.service_endpoint_name
  url = var.url
  description  = "Managed By Terraform"
  personal_access_token = var.personal_access_token

}
