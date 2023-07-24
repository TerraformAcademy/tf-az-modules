terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.20, <4.00"
    }
  }
  required_version = ">= 1.0.0"
}