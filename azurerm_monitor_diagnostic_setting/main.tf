terraform {
  required_providers {
    azurerm={
        source = "hashicorp/azurerm"
        version = ">= 4.11 < 5.0"
    }
  }
    required_version = ">= 1.1.0"
}