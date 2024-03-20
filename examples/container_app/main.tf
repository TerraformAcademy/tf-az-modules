terraform {

}

provider "azurerm" {
  features {

  }
}

module "contaoner-app" {
  source                       = "../../azurerm_container_app"
  name                         = "app1"
  resource_group_name          = "RG0001"
  container_app_environment_id = "/spdpjka/sdad/asda/adsa/asd//adada/"
  template = [{
    container = [{
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }]
  }]

}