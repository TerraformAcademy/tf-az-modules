terraform {

}

provider "azurerm" {
  features {

  }
}

module "env" {
  source              = "../../azurerm_container_app_environment"
  name                = "test-env"
  location            = "eastus"
  resource_group_name = "RG0001"
}