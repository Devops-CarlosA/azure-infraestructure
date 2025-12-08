terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  #backend "azurerm" {
  #  resource_group_name  = "rg-infra-uat"
  #  storage_account_name = "sainfrauat"
  #  container_name       = "data-infra-uat"
  #  key                  = "terraform.tfstate"
  #}
}

provider "azurerm" {
  features {}
}