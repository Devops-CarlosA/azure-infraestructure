terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  #backend "azurerm" {
  #  resource_group_name  = "rg-infra-staging"
  #  storage_account_name = "tfsainfrastaging"
  #  container_name       = "tf-infra-staging"
  #  key                  = "terraform.tfstate"
  #}
}

provider "azurerm" {
  features {}
}