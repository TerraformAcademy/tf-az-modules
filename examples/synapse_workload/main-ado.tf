terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=1.1.0"
    }
  }

  backend "azurerm" {
    
  }
}

provider "azuredevops" {
  
  org_service_url       = var.AZDO_ORG_SERVICE_URL
  personal_access_token = var.AZDO_PERSONAL_ACCESS_TOKEN


}


data "azuredevops_projects" "ado_project" {

}

data "azuredevops_git_repositories" "ado_git_repo" {
  for_each = data.azuredevops_projects.ado_project.projects
  project_id = each.value.project_id
}



module "auto_reviewers" {
  for_each = data.azuredevops_git_repositories.ado_git_repo.repositories
  source     = "../../modules/branch_policy/auto_reviewers"
  project_id = each.value.project_id
  settings = {
    auto_reviewer_ids = ["8681a16c-556e-6ed5-8cce-b6b895321aa2","b1fa71d4-b6cb-69e4-a164-bb8918bb2337"]
    scope = [{
      repository_id  = each.value.id
      repository_ref = each.value.default_branch
    }]
  }

}

module "min_reviewer" {
  for_each = data.azuredevops_git_repositories.ado_git_repo.repositories
  source     = "../../modules/branch_policy/min_reviewer"
  project_id = each.value.project_id
  settings = {
    reviewer_count = 2
    scope = [
      {
        repository_id  = each.value.id
        repository_ref = each.value.default_branch
      }
    ]
  }
}

module "comment_resolution" {
  for_each = data.azuredevops_git_repositories.ado_git_repo.repositories
  source     = "../../modules/branch_policy/comment_resolution"
  project_id = each.value.project_id
  scope = [{
    repository_id  = each.value.id
    repository_ref = each.value.default_branch
  }]
}

module "email_pattern" {
  for_each = data.azuredevops_projects.ado_project.projects
  source = "../../modules/branch_policy/email_pattern"
  project_id = each.value.project_id
  author_email_patterns = ["*@egonzehnder.com"]
}
